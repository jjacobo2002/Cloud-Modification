
-- Vertigo Bomber(non smokey version yay unused model) v_gdi_hcraft
-- Fire Hawk (yay for noisey as hell commanche model?) v_ag_commanchea
-- Vindicator (yay for another unused hovercraft model) V_AG_VHCraft
-- These next 2 do not reload and cost 10k each. Cannot use !upv.
-- Harbringer (agt gun and death cannons on the side)
-- Kirov (submarine attached to a hovercraft)

HelipadSystem = {}
-- Bomber Tables
HelipadSystem["CarpetBomber"] = {}
HelipadSystem["NukeBomber"] = {}
HelipadSystem["IonBomber"] = {}
HelipadSystem["FireHawk"] = {}
HelipadSystem["Vertigo"] = {}
HelipadSystem["Vindicator"] = {}
-- Helipad Tables
HelipadSystem["Helipad"] = {}
HelipadSystem["Helipad"]["GDI"] = {}
HelipadSystem["Helipad"]["Nod"] = {}
-- This is to get the ID that's dropped by the heavy bombers and the ID of the person that used. I intend to use this later to be able to control the damage of the bomb alot better
-- and actually give you the kill, but for now it's just mainly spamming explosions lol..
HelipadSystem["Bomb"] = {}
-- This prevents 2.9 script users and below from using any of keys or commands (not like they could use the keys anyway lol)
HelipadSystem["Scripts"] = {}

dofile( "LuaPlugins\\customs.lua" )

function printf(...)
	io.write(string.format(unpack(arg)))
end

function InputConsole(...)
	Console_Input(string.format(unpack(arg)))
end

--Debuging only

function OnError(Error)
	if Error then
		InputConsole("msg "..Error)
	end
end

-- For getting the distance between the person and the bomber when they use the enter key

function Get_Distance(object1, object2)
   local pos = Get_Position(object1)
   local pos2 = Get_Position(object2)
   local Distance1 = pos.X - pos2.X
   if (Distance1 < 0) then
      Distance1 = Distance1 * -1
   end
   local Distance2 = pos.Y - pos2.Y
   if (Distance2 < 0) then
      Distance2 = Distance2 * -1
   end
   local Distance3 = pos.Z - pos2.Z
   if (Distance3 < 0) then
      Distance3 = Distance3 * -1
   end
   local Distance4 = Distance1 + Distance2
   local Distance5 = Distance3 + Distance4
   local Distance = Distance5 / 3
   return Distance
end

function OnChat(pID, Type, Message, Target, int)
	key = string.match(Message, "k\n([^\r\n]+)\n")
	str = Explode(Message, " ")
	GlobalName = Get_Player_Name_By_ID(pID)
	-- Nod and GDI Helipad
	if str[1] == "!bomberlist" then
		if HelipadSystem["Scripts"][pID].Version >= 2.9 then
			if Get_Team(pID) == 0 then
				InputConsole("pamsg "..pID.." !bomber(5000), !heavybomber(15000), !vertigo(3000), !vindicator(1500)")
			elseif Get_Team(pID) == 1 then
				InputConsole("pamsg "..pID.." !bomber(5000), !heavybomber(15000), !firehawk(3000), !vindicator(1500)")
			end
		else
			InputConsole("pamsg "..pID.." Download Scripts 3.4 at: http://www.cloud-zone.com or http://www.game-maps.net")
			InputConsole("pamsg "..pID.." You do not haver scripts 2.9 or higher. You cannot buy any bombers. Please update your scripts.")
		end
	end
	if str[1] == "!vehicles" then
		if Get_Team(pID) == 0 then
			InputConsole("pamsg "..pID.." !apache(900), !trans(700)")
		elseif Get_Team(pID) == 1 then
			InputConsole("pamsg "..pID.." !orca(900), !trans(700)")
		end
	end
	if str[1] == "!helipad" then
		if HelipadSystem["Scripts"][pID].Version >= 2.9 then
			if Get_Team(pID) == 1 then
				if HelipadSystem["Helipad"]["GDI"].Built ~= 1 then
					if Get_Money(pID) >= 10000 then
						HelipadSystem["Helipad"]["GDI"].Built = 1
						local pos = Get_Position(Get_GameObj(pID))
						pos.Z = pos.Z - .2
						GHeli = Create_Object("GDI Gunboat", pos)
						pos.Z = pos.Z + 1
						Set_Position(Get_GameObj(pID), pos)
						Set_Model(GHeli, "enc_nhel")
						Attach_Script(GHeli, "z_Set_Team", Get_Team(pID))
						local Location = {X = pos.X, Y = pos.Y, Z = pos.Z+1}
						local Size = {X = 10, Y = 10, Z = 15}
						GHeliZone = Create_Script_Zone("Script_Zone_All", Location, Size)
						Attach_Script(GHeliZone, "GHelipadScriptZone", "")
						Attach_Script(GHeli, "JFW_Death_Destroy_Object", GHeliZone)
						Set_Max_Health(GHeli, 100)
						Set_Max_Shield_Strength(GHeli, 500)
						Set_Skin(GHeli, "CNCStructureLight")
						Set_Shield_Type(GHeli, "CNCStructureLight")
						Set_Money(pID, Get_Money(pID)-10000)
						InputConsole("sndt 1 m00bgwf_dsgn0004i1evag_snd.wav")
						Attach_Script(GHeli, "GHeli_Construction_Complete", "")
						Attach_Script(GHeli, "G_Helipad_Control", "")
						HelipadSystem["Helipad"]["GDI"].PadID = GHeli
						HelipadSystem["Helipad"]["GDI"].Building = "no"
						HelipadSystem["Helipad"]["GDI"].Attacked = "no"
					else
						InputConsole("sndp "..pID.." m00evag_dsgn0028i1evag_snd.wav")
					end
				else
					InputConsole("cmsgp "..pID.." 255,0,0 Your team already has a Helipad.")
				end
			elseif Get_Team(pID) == 0 then
				if HelipadSystem["Helipad"]["Nod"].Built ~= 1 then
					if Get_Money(pID) >= 10000 then
						HelipadSystem["Helipad"]["Nod"].Built = 1
						local pos = Get_Position(Get_GameObj(pID))
						pos.Z = pos.Z - .2
						NHeli = Create_Object("GDI Gunboat", pos)
						pos.Z = pos.Z + 1
						Set_Position(Get_GameObj(pID), pos)
						Set_Model(NHeli, "enc_nhel")
						Attach_Script(NHeli, "z_Set_Team", Get_Team(pID))
						local Location = {X = pos.X, Y = pos.Y, Z = pos.Z+1}
						local Size = {X = 15, Y = 15, Z = 15}
						NHeliZone = Create_Script_Zone("Script_Zone_All", Location, Size)
						Attach_Script(NHeliZone, "NHelipadScriptZone", "")
						Attach_Script(NHeli, "JFW_Death_Destroy_Object", NHeliZone)
						Set_Max_Health(NHeli, 100)
						Set_Max_Shield_Strength(NHeli, 500)
						Set_Skin(NHeli, "CNCStructureLight")
						Set_Shield_Type(NHeli, "CNCStructureLight")
						Set_Money(pID, Get_Money(pID)-10000)
						InputConsole("sndt 0 m00bgwf_dsgn0004i1evag_snd.wav")
						Attach_Script(NHeli, "NHeli_Construction_Complete", "")
						Attach_Script(NHeli, "N_Helipad_Control", "")
						HelipadSystem["Helipad"]["Nod"].PadID = NHeli
						HelipadSystem["Helipad"]["Nod"].Building = "no"
						HelipadSystem["Helipad"]["Nod"].Attacked = "no"
					else
						InputConsole("sndp "..pID.." m00evan_dsgn0024i1evan_snd.wav")
					end
				else
					InputConsole("cmsgp "..pID.." 255,0,0 Your team already has a Helipad.")
				end
			end
		else
			InputConsole("ppage "..pID.." You do not have high enough scripts to use this command")
		end
	end
	-- Fire Hawk
	if str[1] == "!firehawk" then
		if HelipadSystem["Scripts"][pID].Version >= 2.9 then
			if Get_Team(pID) == 1 then
				if HelipadSystem["Helipad"]["GDI"].Built == 1 then
					if HelipadSystem["Helipad"]["GDI"].Building == "no" then
						if Get_Money(pID) >= 3000 then
							local pos = Get_Position(HelipadSystem["Helipad"]["GDI"].PadID)
							pos.Z = pos.Z + 1
							GHeliPath = Create_Object("Invisible_Object", pos)
							Attach_Script_Once(GHeliPath, "Test_Cinematic", "FireHawk.txt")
							HelipadSystem["Helipad"]["GDI"].Owner = pID
							InputConsole("sndt 1 m00evag_dsgn0004i1evag_snd.wav")
							Attach_Script(HelipadSystem["Helipad"]["GDI"].PadID, "GHeli_Building_Progress", "")
							HelipadSystem["Helipad"]["GDI"].Building = "yes"
							Set_Money(pID, Get_Money(pID)-3000)
						else
							InputConsole("sndp "..pID.." m00evag_dsgn0028i1evag_snd.wav")
						end
					elseif HelipadSystem["Helipad"]["GDI"].Building == "yes" then
						InputConsole("sndp "..pID.." m00evag_dsgn0012i1evag_snd.wav")
					end
				else
					InputConsole("cmsgp "..pID.." 255,0,0 Your team does not have a Helipad.")
				end
			else
				InputConsole("cmsgp "..pID.." 255,0,0 This is only for GDI.")
			end
		else
			InputConsole("ppage "..pID.." You do not have high enough scripts to use this command")
		end
	end
	-- Vertigo
	if str[1] == "!vertigo" then
		if HelipadSystem["Scripts"][pID].Version >= 2.9 then
			if Get_Team(pID) == 0 then
				if HelipadSystem["Helipad"]["Nod"].Built == 1 then
					if HelipadSystem["Helipad"]["Nod"].Building == "no" then
						if Get_Money(pID) >= 3000 then
							local pos = Get_Position(HelipadSystem["Helipad"]["Nod"].PadID)
							pos.Z = pos.Z + 1
							GHeliPath = Create_Object("Invisible_Object", pos)
							Attach_Script_Once(GHeliPath, "Test_Cinematic", "Vertigo.txt")
							HelipadSystem["Helipad"]["Nod"].Owner = pID
							InputConsole("sndt 0 m00evan_dsgn0002i1evan_snd.wav")
							Attach_Script(HelipadSystem["Helipad"]["Nod"].PadID, "NHeli_Building_Progress", "")
							HelipadSystem["Helipad"]["Nod"].Building = "yes"
							Set_Money(pID, Get_Money(pID)-3000)
						else
							InputConsole("sndp "..pID.." m00evan_dsgn0024i1evan_snd.wav")
						end
					elseif HelipadSystem["Helipad"]["Nod"].Building == "yes" then
						InputConsole("sndp "..pID.." m00evan_dsgn0009i1evan_snd.wav")
					end
				else
					InputConsole("cmsgp "..pID.." 255,0,0 Your team does not have a Helipad.")
				end
			else
				InputConsole("cmsgp "..pID.." 255,0,0 This is only for Nod.")
			end
		else
			InputConsole("ppage "..pID.." You do not have high enough scripts to use this command")
		end
	end
	-- Vindicator
	if str[1] == "!vindicator" then
		if HelipadSystem["Scripts"][pID].Version >= 2.9 then
			if Get_Team(pID) == 0 then
				if HelipadSystem["Helipad"]["Nod"].Built == 1 then
					if HelipadSystem["Helipad"]["Nod"].Building == "no" then
						if Get_Money(pID) >= 1500 then
							local pos = Get_Position(HelipadSystem["Helipad"]["Nod"].PadID)
							pos.Z = pos.Z + .5
							GHeliPath = Create_Object("Invisible_Object", pos)
							Attach_Script_Once(GHeliPath, "Test_Cinematic", "Nod_Vindicator.txt")
							HelipadSystem["Helipad"]["Nod"].Owner = pID
							InputConsole("sndt 0 m00evan_dsgn0002i1evan_snd.wav")
							Attach_Script(HelipadSystem["Helipad"]["Nod"].PadID, "NHeli_Building_Progress", "")
							HelipadSystem["Helipad"]["Nod"].Building = "yes"
							Set_Money(pID, Get_Money(pID)-1500)
						else
							InputConsole("sndp "..pID.." m00evan_dsgn0024i1evan_snd.wav")
						end
					elseif HelipadSystem["Helipad"]["Nod"].Building == "yes" then
						InputConsole("sndp "..pID.." m00evan_dsgn0009i1evan_snd.wav")
					end
				else
					InputConsole("cmsgp "..pID.." 255,0,0 Your team does not have a Helipad.")
				end
			elseif Get_Team(pID) == 1 then
				if HelipadSystem["Helipad"]["GDI"].Built == 1 then
					if HelipadSystem["Helipad"]["GDI"].Building == "no" then
						if Get_Money(pID) >= 1500 then
							local pos = Get_Position(HelipadSystem["Helipad"]["GDI"].PadID)
							pos.Z = pos.Z + .5
							GHeliPath = Create_Object("Invisible_Object", pos)
							Attach_Script_Once(GHeliPath, "Test_Cinematic", "GDI_Vindicator.txt")
							HelipadSystem["Helipad"]["GDI"].Owner = pID
							InputConsole("sndt 1 m00evag_dsgn0004i1evag_snd.wav")
							Attach_Script(HelipadSystem["Helipad"]["GDI"].PadID, "GHeli_Building_Progress", "")
							HelipadSystem["Helipad"]["GDI"].Building = "yes"
							Set_Money(pID, Get_Money(pID)-1500)
						else
							InputConsole("sndp "..pID.." m00evan_dsgn0024i1evan_snd.wav")
						end
					elseif HelipadSystem["Helipad"]["GDI"].Building == "yes" then
						InputConsole("sndp "..pID.." m00evan_dsgn0009i1evan_snd.wav")
					end
				else
					InputConsole("cmsgp "..pID.." 255,0,0 Your team does not have a Helipad.")
				end
			end
		else
			InputConsole("ppage "..pID.." You do not have high enough scripts to use this command")
		end
	end
	-- The Carpet Bomber
	if str[1] == "!bomber" then
		if HelipadSystem["Scripts"][pID].Version >= 2.9 then
			if Get_Team(pID) == 1 then
				if HelipadSystem["Helipad"]["GDI"].Built == 1 then
					if HelipadSystem["CarpetBomber"][pID].ID == nil then
						if HelipadSystem["Helipad"]["GDI"].Building == "no" then
							if Get_Money(pID) >= 5000 then
								local pos = Get_Position(HelipadSystem["Helipad"]["GDI"].PadID)
								pos.Z = pos.Z + 1
								GHeliPath = Create_Object("Invisible_Object", pos)
								Attach_Script_Once(GHeliPath, "Test_Cinematic", "GDI_Bomber.txt")
								HelipadSystem["Helipad"]["GDI"].Owner = pID
								InputConsole("sndt 1 m00evag_dsgn0004i1evag_snd.wav")
								Attach_Script(HelipadSystem["Helipad"]["GDI"].PadID, "GHeli_Building_Progress", "")
								HelipadSystem["Helipad"]["GDI"].Building = "yes"
								Set_Money(pID, Get_Money(pID)-5000)
							else
								InputConsole("sndp "..pID.." m00evag_dsgn0028i1evag_snd.wav")
							end
						elseif HelipadSystem["Helipad"]["GDI"].Building == "yes" then
							InputConsole("sndp "..pID.." m00evag_dsgn0012i1evag_snd.wav")
						end
					else
						InputConsole("cmsgp "..pID.." 255,0,0 You already have a Carpet Bomber")
					end
				else
					InputConsole("cmsgp "..pID.." 255,0,0 Your team does not have a Helipad.")
				end
			elseif Get_Team(pID) == 0 then
				if HelipadSystem["Helipad"]["Nod"].Built == 1 then
					if HelipadSystem["CarpetBomber"][pID].ID == nil then
						if HelipadSystem["Helipad"]["Nod"].Building == "no" then
							if Get_Money(pID) >= 5000 then
								local pos = Get_Position(HelipadSystem["Helipad"]["Nod"].PadID)
								pos.Z = pos.Z + 2
								NHeliPath = Create_Object("Invisible_Object", pos)
								Attach_Script_Once(NHeliPath, "Test_Cinematic", "Nod_Bomber.txt")
								HelipadSystem["Helipad"]["Nod"].Owner = pID
								InputConsole("sndt 0 m00evan_dsgn0002i1evan_snd.wav")
								Attach_Script(HelipadSystem["Helipad"]["Nod"].PadID, "NHeli_Building_Progress", "")
								HelipadSystem["Helipad"]["Nod"].Building = "yes"
								Set_Money(pID, Get_Money(pID)-5000)
							else
								InputConsole("sndp "..pID.." m00evan_dsgn0024i1evan_snd.wav")
							end
						elseif HelipadSystem["Helipad"]["Nod"].Building == "yes" then
							InputConsole("sndp "..pID.." m00evan_dsgn0009i1evan_snd.wav")
						end
					else
						InputConsole("cmsgp "..pID.." 255,0,0 You already have a Carpet Bomber")
					end
				else
					InputConsole("cmsgp "..pID.." 255,0,0 Your team does not have a Helipad.")
				end
			end
		else
			InputConsole("ppage "..pID.." You do not have high enough scripts to use this command")
		end
	end
	-- The Nuke/Ion bomber
	if str[1] == "!heavybomber" then
		if HelipadSystem["Scripts"][pID].Version >= 2.9 then
			if Get_Team(pID) == 1 then
				if HelipadSystem["Helipad"]["GDI"].Built == 1 then
					if HelipadSystem["IonBomber"][pID].ID == nil then
						if HelipadSystem["Helipad"]["GDI"].Building == "no" then
							if Get_Money(pID) >= 15000 then
								local pos = Get_Position(HelipadSystem["Helipad"]["GDI"].PadID)
								pos.Z = pos.Z + 1
								GHeliPath = Create_Object("Invisible_Object", pos)
								Attach_Script_Once(GHeliPath, "Test_Cinematic", "GDI_Heavy_Bomber.txt")
								HelipadSystem["Helipad"]["GDI"].Owner = pID
								InputConsole("sndt 1 m00evag_dsgn0004i1evag_snd.wav")
								Attach_Script(HelipadSystem["Helipad"]["GDI"].PadID, "GHeli_Building_Progress", "")
								HelipadSystem["Helipad"]["GDI"].Building = "yes"
								Set_Money(pID, Get_Money(pID)-15000)
							else
								InputConsole("sndp "..pID.." m00evag_dsgn0028i1evag_snd.wav")
							end
						elseif HelipadSystem["Helipad"]["GDI"].Building == "yes" then
							InputConsole("sndp "..pID.." m00evag_dsgn0012i1evag_snd.wav")
						end
					else
						InputConsole("cmsgp "..pID.." 255,0,0 You already have a Carpet Bomber")
					end
				else
					InputConsole("cmsgp "..pID.." 255,0,0 Your team does not have a Helipad.")
				end
			elseif Get_Team(pID) == 0 then
				if HelipadSystem["Helipad"]["Nod"].Built == 1 then
					if HelipadSystem["NukeBomber"][pID].ID == nil then
						if HelipadSystem["Helipad"]["Nod"].Building == "no" then
							if Get_Money(pID) >= 15000 then
								local pos = Get_Position(HelipadSystem["Helipad"]["Nod"].PadID)
								pos.Z = pos.Z + 2
								NHeliPath = Create_Object("Invisible_Object", pos)
								Attach_Script_Once(NHeliPath, "Test_Cinematic", "Nod_Heavy_Bomber.txt")
								HelipadSystem["Helipad"]["Nod"].Owner = pID
								InputConsole("sndt 0 m00evan_dsgn0002i1evan_snd.wav")
								Attach_Script(HelipadSystem["Helipad"]["Nod"].PadID, "NHeli_Building_Progress", "")
								HelipadSystem["Helipad"]["Nod"].Building = "yes"
								Set_Money(pID, Get_Money(pID)-15000)
							else
								InputConsole("sndp "..pID.." m00evan_dsgn0024i1evan_snd.wav")
							end
						elseif HelipadSystem["Helipad"]["Nod"].Building == "yes" then
							InputConsole("sndp "..pID.." m00evan_dsgn0009i1evan_snd.wav")
						end
					else
						InputConsole("cmsgp "..pID.." 255,0,0 You already have a Carpet Bomber")
					end
				else
					InputConsole("cmsgp "..pID.." 255,0,0 Your team does not have a Helipad.")
				end
			end
		else
			InputConsole("ppage "..pID.." You do not have high enough scripts to use this command")
		end
	end
	-- Regular Bomber Firing Keys
	if key == "Taunt1" or key == "Taunt3" or key == "PrimaryFire" or key == "SecondaryFire" then
		-- Carpet Bomber Ammo
		if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["CarpetBomber"][pID].ID then
			BomberID = HelipadSystem["CarpetBomber"][pID].ID
			if HelipadSystem["CarpetBomber"][BomberID].Enabled == "yes" then
				if HelipadSystem["CarpetBomber"][BomberID].Ammo <= 10 and HelipadSystem["CarpetBomber"][BomberID].Ammo ~= 0 then
					local pos = Get_Position(Get_GameObj(pID))
					pos.Z = pos.Z - 5
					Bomb = Create_Object("SignalFlare_Gold_Phys3", pos)
					HelipadSystem["Bomb"][Bomb] = {}
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Set_Model(Bomb, "w_a-10bomb")
					InputConsole("snda a10whistle1.wav")
					Attach_Script(Bomb, "BombKillScript", "")
					Set_Facing(Bomb, Get_Facing(Get_GameObj(pID)))
					HelipadSystem["CarpetBomber"][BomberID].Enabled = "no"
					Attach_Script(HelipadSystem["CarpetBomber"][pID].ID, "Bomber_Firing_Rate", .5)
					HelipadSystem["CarpetBomber"][BomberID].Ammo = HelipadSystem["CarpetBomber"][BomberID].Ammo - 1
					if HelipadSystem["CarpetBomber"][BomberID].Ammo == 0 then
						if Get_Team(pID) == 1 then
							InputConsole("sndp "..pID.." m00evag_dsgn0020i1evag_snd.wav")
						elseif Get_Team(pID) == 0 then
							InputConsole("sndp "..pID.." m00evan_dsgn0017i1evan_snd.wav")
						end
					end
				elseif HelipadSystem["CarpetBomber"][BomberID].Ammo == 0 then
					InputConsole("cmsgp " .. pID .. " 255,0,0 You have no more bombs left! Use the Helipad to reload.")
				end
			end
		end
		-- Nuke Bomber Ammo
		if Get_Team(pID) == 0 then
			if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["NukeBomber"][pID].ID then
				BomberID = HelipadSystem["NukeBomber"][pID].ID
				if HelipadSystem["NukeBomber"][BomberID].Enabled == "yes" then
					if HelipadSystem["NukeBomber"][BomberID].Ammo <= 10 and HelipadSystem["NukeBomber"][BomberID].Ammo ~= 0 then
						local pos = Get_Position(Get_GameObj(pID))
						pos.Z = pos.Z - 5
						Bomb = Create_Object("SignalFlare_Gold_Phys3", pos)
						Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_NukeBeacon")
						HelipadSystem["Bomb"][pID].NukeBombID = Bomb
						HelipadSystem["Bomb"][Bomb] = {}
						HelipadSystem["Bomb"][Bomb].pID = pID
						Set_Model(Bomb, "w_a-10bomb")
						InputConsole("snda a10whistle1.wav")
						Attach_Script(Bomb, "BombKillScript", "")
						Set_Facing(Bomb, Get_Facing(Get_GameObj(pID)))
						HelipadSystem["NukeBomber"][BomberID].Enabled = "no"
						Attach_Script(HelipadSystem["NukeBomber"][pID].ID, "Bomber_Firing_Rate", .5)
						HelipadSystem["NukeBomber"][BomberID].Ammo = HelipadSystem["NukeBomber"][BomberID].Ammo - 1
						if HelipadSystem["NukeBomber"][BomberID].Ammo == 0 then
							if Get_Team(pID) == 1 then
								InputConsole("sndp "..pID.." m00evag_dsgn0020i1evag_snd.wav")
							elseif Get_Team(pID) == 0 then
								InputConsole("sndp "..pID.." m00evan_dsgn0017i1evan_snd.wav")
							end
						end
					elseif HelipadSystem["NukeBomber"][BomberID].Ammo == 0 then
						InputConsole("cmsgp " .. pID .. " 255,0,0 You have no more bombs left! Use the Helipad to reload.")
					end
				end
			end
		end
		-- Ion Bomber Ammo
		if Get_Team(pID) == 1 then
			if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["IonBomber"][pID].ID then
				BomberID = HelipadSystem["IonBomber"][pID].ID
				if HelipadSystem["IonBomber"][BomberID].Enabled == "yes" then
					if HelipadSystem["IonBomber"][BomberID].Ammo <= 10 and HelipadSystem["IonBomber"][BomberID].Ammo ~= 0 then
						local pos = Get_Position(Get_GameObj(pID))
						pos.Z = pos.Z - 5
						Bomb = Create_Object("SignalFlare_Gold_Phys3", pos)
						Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_IonCannonBeacon")
						Set_Model(Bomb, "w_a-10bomb")
						HelipadSystem["Bomb"][pID].IonBombID = Bomb
						HelipadSystem["Bomb"][Bomb] = {}
						HelipadSystem["Bomb"][Bomb].pID = pID
						InputConsole("snda a10whistle1.wav")
						Attach_Script(Bomb, "BombKillScript", "")
						Set_Facing(Bomb, Get_Facing(Get_GameObj(pID)))
						HelipadSystem["IonBomber"][BomberID].Enabled = "no"
						Attach_Script(HelipadSystem["IonBomber"][pID].ID, "Bomber_Firing_Rate", .5)
						HelipadSystem["IonBomber"][BomberID].Ammo = HelipadSystem["IonBomber"][BomberID].Ammo - 1
						if HelipadSystem["IonBomber"][BomberID].Ammo == 0 then
							if Get_Team(pID) == 1 then
								InputConsole("sndp "..pID.." m00evag_dsgn0020i1evag_snd.wav")
							elseif Get_Team(pID) == 0 then
								InputConsole("sndp "..pID.." m00evan_dsgn0017i1evan_snd.wav")
							end
						end
					elseif HelipadSystem["IonBomber"][BomberID].Ammo == 0 then
						InputConsole("cmsgp " .. pID .. " 255,0,0 You have no more bombs left! Use the Helipad to reload.")
					end
				end
			end
		end
		-- Vindicator Ammo
		if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["Vindicator"][pID].ID then
			if HelipadSystem["Vindicator"][pID].Enabled == "yes" then
				VindID = HelipadSystem["Vindicator"][pID].ID
				if HelipadSystem["Vindicator"][VindID].Ammo <= 2 and HelipadSystem["Vindicator"][VindID].Ammo ~= 0 then
					local pos = Get_Position(Get_GameObj(pID))
					pos.Z = pos.Z - 5
					Bomb = Create_Object("SignalFlare_Gold_Phys3", pos)
					HelipadSystem["Bomb"][pID].VinBombID = Bomb
					HelipadSystem["Bomb"][Bomb] = {}
					HelipadSystem["Bomb"][Bomb].pID = pID
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Set_Model(Bomb, "w_a-10bomb")
					InputConsole("snda a10whistle1.wav")
					Attach_Script(Bomb, "BombKillScript", "")
					Set_Facing(Bomb, Get_Facing(Get_GameObj(pID)))
					HelipadSystem["Vindicator"][pID].Enabled = "no"
					Attach_Script(HelipadSystem["Vindicator"][pID].ID, "Bomber_Firing_Rate", .5)
					HelipadSystem["Vindicator"][VindID].Ammo = HelipadSystem["Vindicator"][VindID].Ammo - 1
					if HelipadSystem["Vindicator"][VindID].Ammo == 0 then
						if Get_Team(pID) == 1 then
							InputConsole("sndp "..pID.." m00evag_dsgn0020i1evag_snd.wav")
						elseif Get_Team(pID) == 0 then
							InputConsole("sndp "..pID.." m00evan_dsgn0017i1evan_snd.wav")
						end
					end
				elseif HelipadSystem["Vindicator"][VindID].Ammo == 0 then
					InputConsole("cmsgp " .. pID .. " 255,0,0 You have no more bombs left! Use the Helipad to reload.")
				end
			end
		end
	end
	-- Fire Hawk and Vertigo Firing Keys
	if key == "Taunt2" or key == "ThirdFire" then
		-- Fire Hawk Ammo
		if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["FireHawk"][pID].ID then
			if HelipadSystem["FireHawk"][pID].Enabled == "yes" then
				HawkID = HelipadSystem["FireHawk"][pID].ID
				if HelipadSystem["FireHawk"][HawkID].Ammo <= 4 and HelipadSystem["FireHawk"][HawkID].Ammo ~= 0 then
					local pos = Get_Position(Get_GameObj(pID))
					pos.Z = pos.Z - 5
					Bomb = Create_Object("SignalFlare_Gold_Phys3", pos)
					HelipadSystem["Bomb"][pID].FHBombID = Bomb
					HelipadSystem["Bomb"][Bomb] = {}
					HelipadSystem["Bomb"][Bomb].pID = pID
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Set_Model(Bomb, "w_a-10bomb")
					InputConsole("snda a10whistle1.wav")
					Attach_Script(Bomb, "BombKillScript", "")
					Set_Facing(Bomb, Get_Facing(Get_GameObj(pID)))
					HelipadSystem["FireHawk"][pID].Enabled = "no"
					Attach_Script(HelipadSystem["FireHawk"][pID].ID, "Bomber_Firing_Rate", .5)
					HelipadSystem["FireHawk"][HawkID].Ammo = HelipadSystem["FireHawk"][HawkID].Ammo - 1
					if HelipadSystem["FireHawk"][HawkID].Ammo == 0 then
						if Get_Team(pID) == 1 then
							InputConsole("sndp "..pID.." m00evag_dsgn0020i1evag_snd.wav")
						elseif Get_Team(pID) == 0 then
							InputConsole("sndp "..pID.." m00evan_dsgn0017i1evan_snd.wav")
						end
					end
				end
			end
		end
		-- Vertigo Ammo
		if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["Vertigo"][pID].ID then
			VertID = HelipadSystem["Vertigo"][pID].ID
			if HelipadSystem["Vertigo"][pID].Enabled == "yes" then
				VertID = HelipadSystem["Vertigo"][pID].ID
				if HelipadSystem["Vertigo"][VertID].Ammo <= 2 and HelipadSystem["Vertigo"][VertID].Ammo ~= 0 then
					local pos = Get_Position(Get_GameObj(pID))
					pos.Z = pos.Z - 5
					Bomb = Create_Object("SignalFlare_Gold_Phys3", pos)
					HelipadSystem["Bomb"][pID].VertBombID = Bomb
					HelipadSystem["Bomb"][Bomb] = {}
					HelipadSystem["Bomb"][Bomb].pID = pID
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Attach_Script(Bomb, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
					Enable_Stealth(HelipadSystem["Vertigo"][pID].ID, 0)
					Set_Model(Bomb, "w_a-10bomb")
					InputConsole("snda a10whistle1.wav")
					Attach_Script(Bomb, "BombKillScript", "")
					Set_Facing(Bomb, Get_Facing(Get_GameObj(pID)))
					HelipadSystem["Vertigo"][pID].Enabled = "no"
					Attach_Script(HelipadSystem["Vertigo"][pID].ID, "Bomber_Firing_Rate", .5)
					Attach_Script(HelipadSystem["Vertigo"][pID].ID, "Stealth_Timer", "")
					HelipadSystem["Vertigo"][VertID].Ammo = HelipadSystem["Vertigo"][VertID].Ammo - 1
					if HelipadSystem["Vertigo"][VertID].Ammo == 0 then
						if Get_Team(pID) == 1 then
							InputConsole("sndp "..pID.." m00evag_dsgn0020i1evag_snd.wav")
						elseif Get_Team(pID) == 0 then
							InputConsole("sndp "..pID.." m00evan_dsgn0017i1evan_snd.wav")
						end
					end
				end
			end
		end
	end
	-- Carpet Bomber Entry Key
	if key == "Soundtrack_Toggle" then
		if HelipadSystem["CarpetBomber"][pID].ID ~= nil then
			BomberID = HelipadSystem["CarpetBomber"][pID].ID
			if Get_Team(pID) == 1 then
				if HelipadSystem["CarpetBomber"][BomberID].Building == "no" then
					if Get_Distance(HelipadSystem["CarpetBomber"][pID].ID, Get_GameObj(pID)) <= 8 then
						local pos = Get_Position(HelipadSystem["CarpetBomber"][pID].ID)
						pos.Z = pos.Z + 5
						Set_Position(Get_GameObj(pID), pos)
					else
						InputConsole("cmsgp " .. pID .. " 255,0,0 You are too far away from your Bomber.")
					end
				elseif HelipadSystem["CarpetBomber"][BomberID].Building == "yes" then
					InputConsole("cmsgp " .. pID .. " 255,0,0 Your Bomber is not yet ready.")
				end
			elseif Get_Team(pID) == 0 then
				if HelipadSystem["CarpetBomber"][BomberID].Building == "no" then
					if Get_Distance(HelipadSystem["CarpetBomber"][pID].ID, Get_GameObj(pID)) <= 8 then
						local pos = Get_Position(HelipadSystem["CarpetBomber"][pID].ID)
						pos.Z = pos.Z + 5
						Set_Position(Get_GameObj(pID), pos)
					else
						InputConsole("cmsgp " .. pID .. " 255,0,0 You are too far away from your Bomber.")
					end
				elseif HelipadSystem["CarpetBomber"][BomberID].Building == "yes" then
					InputConsole("cmsgp " .. pID .. " 255,0,0 Your Bomber is not yet ready.")
				end
			end
		else
			InputConsole("cmsgp " .. pID .. " 255,0,0 You do not have a Bomber")
		end
	end
	-- Heavy Bomber Entry Key
	if key == "Soundtrack_Forward" then
		if Get_Team(pID) == 1 then
			if HelipadSystem["IonBomber"][pID].ID ~= nil then
				BomberID = HelipadSystem["IonBomber"][pID].ID
				if HelipadSystem["IonBomber"][BomberID].Building == "no" then
					if Get_Distance(HelipadSystem["IonBomber"][pID].ID, Get_GameObj(pID)) <= 8 then
						local pos = Get_Position(HelipadSystem["IonBomber"][pID].ID)
						pos.Z = pos.Z + 5
						Set_Position(Get_GameObj(pID), pos)
					else
						InputConsole("cmsgp " .. pID .. " 255,0,0 You are too far away from your Heavy Bomber.")
					end
				elseif HelipadSystem["IonBomber"][BomberID].Building == "yes" then
					InputConsole("cmsgp " .. pID .. " 255,0,0 Your Heavy Bomber is not yet ready.")
				end
			else
				InputConsole("cmsgp " .. pID .. " 255,0,0 You do not have a Heavy Bomber")
			end
		elseif Get_Team(pID) == 0 then
			if HelipadSystem["NukeBomber"][pID].ID ~= nil then
				BomberID = HelipadSystem["NukeBomber"][pID].ID
				if HelipadSystem["NukeBomber"][BomberID].Building == "no" then
					if Get_Distance(HelipadSystem["NukeBomber"][pID].ID, Get_GameObj(pID)) <= 8 then
						local pos = Get_Position(HelipadSystem["NukeBomber"][pID].ID)
						pos.Z = pos.Z + 5
						Set_Position(Get_GameObj(pID), pos)
					else
						InputConsole("cmsgp " .. pID .. " 255,0,0 You are too far away from your Heavy Bomber.")
					end
				elseif HelipadSystem["NukeBomber"][BomberID].Building == "yes" then
					InputConsole("cmsgp " .. pID .. " 255,0,0 Your Heavy Bomber is not yet ready.")
				end
			else
				InputConsole("cmsgp " .. pID .. " 255,0,0 You do not have a heavy Bomber")
			end
		end
	end
	--
	if key == "PoolInfo" then
		if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["CarpetBomber"][pID].ID then
			BomberID = HelipadSystem["CarpetBomber"][pID].ID
			if HelipadSystem["CarpetBomber"][BomberID].Enabled == "yes" then
				InputConsole("cmsgp "..pID.." 0,0,255 Bomb Count: "..HelipadSystem["CarpetBomber"][BomberID].Ammo)
			end
		end
		if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["IonBomber"][pID].ID then
			BomberID = HelipadSystem["IonBomber"][pID].ID
			if HelipadSystem["IonBomber"][BomberID].Enabled == "yes" then
				InputConsole("cmsgp "..pID.." 0,0,255 Bomb Count: "..HelipadSystem["IonBomber"][BomberID].Ammo)
			end
		end
		if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["NukeBomber"][pID].ID then
			BomberID = HelipadSystem["NukeBomber"][pID].ID
			if HelipadSystem["NukeBomber"][BomberID].Enabled == "yes" then
				InputConsole("cmsgp "..pID.." 0,0,255 Bomb Count: "..HelipadSystem["NukeBomber"][BomberID].Ammo)
			end
		end
		if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["FireHawk"][pID].ID then
			HawkID = HelipadSystem["FireHawk"][pID].ID
			if HelipadSystem["FireHawk"][pID].Enabled == "yes" then
				InputConsole("cmsgp "..pID.." 0,0,255 Bomb Count: "..HelipadSystem["FireHawk"][HawkID].Ammo)
			end
		end
		if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["Vertigo"][pID].ID then
			VertID = HelipadSystem["Vertigo"][pID].ID
			if HelipadSystem["Vertigo"][pID].Enabled == "yes" then
				InputConsole("cmsgp "..pID.." 0,0,255 Bomb Count: "..HelipadSystem["Vertigo"][VertID].Ammo)
			end
		end
		if Get_Vehicle(Get_GameObj(pID)) == HelipadSystem["Vindicator"][pID].ID then
			VindID = HelipadSystem["Vindicator"][pID].ID
			if HelipadSystem["Vindicator"][pID].Enabled == "yes" then
				InputConsole("cmsgp "..pID.." 0,0,255 Bomb Count: "..HelipadSystem["Vindicator"][VindID].Ammo)
			end
		end
	end
	-- None Script users can use these commands if there is a helipad built.
	if str[1] == "!orca" then
		if Get_Team(pID) == 1 then
			if HelipadSystem["Helipad"]["GDI"].Built == 1 then
				if HelipadSystem["Helipad"]["GDI"].Building == "no" then
					if Get_Money(pID) >= 900 then
						local pos = Get_Position(HelipadSystem["Helipad"]["GDI"].PadID)
						pos.Z = pos.Z + 1
						GHeliPath = Create_Object("Invisible_Object", pos)
						Attach_Script_Once(GHeliPath, "Test_Cinematic", "GDI_Orca.txt")
						InputConsole("sndt 1 m00evag_dsgn0004i1evag_snd.wav")
						Attach_Script(HelipadSystem["Helipad"]["GDI"].PadID, "GHeli_Building_Progress", "")
						HelipadSystem["Helipad"]["GDI"].Building = "yes"
						Set_Money(pID, Get_Money(pID)-900)
					else
						InputConsole("sndp "..pID.." m00evag_dsgn0028i1evag_snd.wav")
					end
				elseif HelipadSystem["Helipad"]["GDI"].Building == "yes" then
					InputConsole("sndp "..pID.." m00evag_dsgn0012i1evag_snd.wav")
				end
			else
				InputConsole("ppage "..pID.." Your team does not have a Helipad.")
			end
		else
			InputConsole("ppage "..pID.." You must be on GDI to purchase this")
		end
	end
	if str[1] == "!apache" then
		if Get_Team(pID) == 0 then
			if HelipadSystem["Helipad"]["Nod"].Built == 1 then
				if HelipadSystem["Helipad"]["Nod"].Building == "no" then
					if Get_Money(pID) >= 900 then
						local pos = Get_Position(HelipadSystem["Helipad"]["Nod"].PadID)
						pos.Z = pos.Z + 1
						GHeliPath = Create_Object("Invisible_Object", pos)
						Attach_Script_Once(GHeliPath, "Test_Cinematic", "Nod_Apache.txt")
						InputConsole("sndt 1 m00evag_dsgn0004i1evag_snd.wav")
						Attach_Script(HelipadSystem["Helipad"]["Nod"].PadID, "NHeli_Building_Progress", "")
						HelipadSystem["Helipad"]["Nod"].Building = "yes"
						Set_Money(pID, Get_Money(pID)-900)
					else
						InputConsole("sndp "..pID.." m00evan_dsgn0024i1evan_snd.wav")
					end
				elseif HelipadSystem["Helipad"]["Nod"].Building == "yes" then
					InputConsole("sndp "..pID.." m00evag_dsgn0012i1evag_snd.wav")
				end
			else
				InputConsole("ppage "..pID.." Your team does not have a Helipad.")
			end
		else
			InputConsole("ppage "..pID.." You must be on Nod to purchase this")
		end
	end
	if str[1] == "!transport" then
		if Get_Team(pID) == 1 then
			if HelipadSystem["Helipad"]["GDI"].Built == 1 then
				if HelipadSystem["Helipad"]["GDI"].Building == "no" then
					if Get_Money(pID) >= 700 then
						local pos = Get_Position(HelipadSystem["Helipad"]["GDI"].PadID)
						pos.Z = pos.Z + .3
						GHeliPath = Create_Object("Invisible_Object", pos)
						Attach_Script_Once(GHeliPath, "Test_Cinematic", "GDI_Transport.txt")
						InputConsole("sndt 1 m00evag_dsgn0004i1evag_snd.wav")
						Attach_Script(HelipadSystem["Helipad"]["GDI"].PadID, "GHeli_Building_Progress", "")
						HelipadSystem["Helipad"]["GDI"].Building = "yes"
						Set_Money(pID, Get_Money(pID)-700)
					else
						InputConsole("sndp "..pID.." m00evag_dsgn0028i1evag_snd.wav")
					end
				elseif HelipadSystem["Helipad"]["GDI"].Building == "yes" then
					InputConsole("sndp "..pID.." m00evag_dsgn0012i1evag_snd.wav")
				end
			else
				InputConsole("ppage "..pID.." Your team does not have a Helipad.")
			end
		elseif Get_Team(pID) == 0 then
			if HelipadSystem["Helipad"]["Nod"].Built == 1 then
				if HelipadSystem["Helipad"]["Nod"].Building == "no" then
					if Get_Money(pID) >= 700 then
						local pos = Get_Position(HelipadSystem["Helipad"]["Nod"].PadID)
						pos.Z = pos.Z + .3
						GHeliPath = Create_Object("Invisible_Object", pos)
						Attach_Script_Once(GHeliPath, "Test_Cinematic", "Nod_Trasnport.txt")
						InputConsole("sndt 1 m00evag_dsgn0004i1evag_snd.wav")
						Attach_Script(HelipadSystem["Helipad"]["Nod"].PadID, "NHeli_Building_Progress", "")
						HelipadSystem["Helipad"]["Nod"].Building = "yes"
						Set_Money(pID, Get_Money(pID)-700)
					else
						InputConsole("sndp "..pID.." m00evan_dsgn0024i1evan_snd.wav")
					end
				elseif HelipadSystem["Helipad"]["Nod"].Building == "yes" then
					InputConsole("sndp "..pID.." m00evag_dsgn0012i1evag_snd.wav")
				end
			else
				InputConsole("ppage "..pID.." Your team does not have a Helipad.")
			end
		end
	end
	return 1
end

function Explode(str, delim)
	local t = {}
	while true do
		local i,y = string.find(str, delim)
		if i == nil then
			table.insert(t, str)
			break
		end
		table.insert(t, string.sub(str, 0, i-1))
		str = str:sub(i+delim:len())
	end
	return t
end

function Get_ID_By_Player_Name(Name)
	for i = 1,127 do
		cName = Get_Player_Name_By_ID(i)
		if cName ~= nil then
			if Name == cName then
				return i
			end
		end
	end
end
	
function OnPlayerJoin(pID, Nick)
	HelipadSystem["CarpetBomber"][pID] = {}
	HelipadSystem["NukeBomber"][pID] = {}
	HelipadSystem["IonBomber"][pID] = {}
	HelipadSystem["FireHawk"][pID] = {}
	HelipadSystem["Vertigo"][pID] = {}
	HelipadSystem["Vindicator"][pID] = {}
	HelipadSystem["Bomb"][pID] = {}
end
function OnPlayerLeave(pID)
	if HelipadSystem["CarpetBomber"][pID].ID ~= nil then
		Destroy_Object(HelipadSystem["CarpetBomber"][pID].ID)
	end
	if HelipadSystem["NukeBomber"][pID].ID ~= nil then
		Destroy_Object(HelipadSystem["NukeBomber"][pID].ID)
	end
	if HelipadSystem["IonBomber"][pID].ID ~= nil then
		Destroy_Object(HelipadSystem["IonBomber"][pID].ID)
	end
end
function OnGameOver()
	HelipadSystem["Helipad"]["GDI"] = {}
	HelipadSystem["Helipad"]["Nod"] = {}
	for _,pID in pairs(Get_All_Players()) do
		HelipadSystem["CarpetBomber"][pID] = {}
		HelipadSystem["NukeBomber"][pID] = {}
		HelipadSystem["IonBomber"][pID] = {}
		HelipadSystem["FireHawk"][pID] = {}
		HelipadSystem["Vertigo"][pID] = {}
		HelipadSystem["Vindicator"][pID] = {}
		HelipadSystem["Bomb"][pID] = {}
	end
end
function OnPlayerVersion(pID, Version)
	HelipadSystem["Scripts"][pID] = {}
	HelipadSystem["Scripts"][pID].Version = Version
end

-- FireHawk Controller Script

FireHawkScript = {}
function FireHawkScript:Created(ID, obj)
	Set_Model(obj, "vdx_gdi_orca")
	pID = HelipadSystem["Helipad"]["GDI"].Owner
	HelipadSystem["FireHawk"][pID].ID = obj
	HelipadSystem["FireHawk"][obj] = {}
	HelipadSystem["FireHawk"][obj].pID = pID
	HelipadSystem["FireHawk"][obj].Ammo = 4
	HelipadSystem["FireHawk"][pID].Enabled = "no"
	HelipadSystem["Helipad"]["GDI"].Owner = nil
	Start_Timer(ID, obj, 16, 1)
end
function FireHawkScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		pID = HelipadSystem["FireHawk"][obj].pID
		Start_Timer(ID, obj, 1.5, 2)
	end
	if num == 2 then
		pID = HelipadSystem["FireHawk"][obj].pID
		RandomCreate = math.random(1,2)
		if RandomCreate == 1 then
			InputConsole("sndp "..pID.." FireHawkCreateA.wav")
		elseif RandomCreate == 2 then
			InputConsole("sndp "..pID.." FireHawkCreateB.wav")
		end
	end
end
function FireHawkScript:Custom(ID, obj, msg, driver, owner)
	if msg == 1000000028 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		if pID ~= HelipadSystem["FireHawk"][obj].pID then
			HelipadSystem["FireHawk"][obj].pID = pID
			HelipadSystem["FireHawk"][pID] = {}
			HelipadSystem["FireHawk"][pID].ID = obj
		end
		HelipadSystem["FireHawk"][pID].Enabled = "yes"
		RandomSelect = math.random(1,6)
		if RandomSelect == 1 then
			InputConsole("sndp "..pID.." FireHawkSelectA.wav")
		elseif RandomSelect == 2 then
			InputConsole("sndp "..pID.." FireHawkSelectB.wav")
		elseif RandomSelect == 3 then
			InputConsole("sndp "..pID.." FireHawkSelectC.wav")
		elseif RandomSelect == 4 then
			InputConsole("sndp "..pID.." FireHawkSelectD.wav")
		elseif RandomSelect == 5 then
			InputConsole("sndp "..pID.." FireHawkSelectE.wav")
		elseif RandomSelect == 6 then
			InputConsole("sndp "..pID.." FireHawkSelectF.wav")
		end
	end
	if msg == 1000000029 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		HelipadSystem["FireHawk"][pID].Enabled = "no"
	end
end
function FireHawkScript:Destroyed(ID, obj)
	pID = HelipadSystem["FireHawk"][obj].pID
	HelipadSystem["FireHawk"][obj].Ammo = 0
	HelipadSystem["FireHawk"][obj].Reload = "no"
	HelipadSystem["FireHawk"][pID].ID = nil
	HelipadSystem["FireHawk"][pID].Enabled = "no"
	RandomDie = math.random(1,3)
	if RandomDie == 1 then
		InputConsole("sndp "..pID.." FireHawkDieA.wav")
	elseif RandomDie == 2 then
		InputConsole("sndp "..pID.." FireHawkDieB.wav")
	elseif RandomDie == 3 then
		InputConsole("sndp "..pID.." FireHawkDieC.wav")
	end
end
function FireHawkScript:Killed(ID, obj, killer)
	pID = HelipadSystem["FireHawk"][obj].pID
	HelipadSystem["FireHawk"][obj].Ammo = 0
	HelipadSystem["FireHawk"][obj].Reload = "no"
	HelipadSystem["FireHawk"][pID].ID = nil
	HelipadSystem["FireHawk"][pID].Enabled = "no"
	RandomDie = math.random(1,3)
	if RandomDie == 1 then
		InputConsole("sndp "..pID.." FireHawkDieA.wav")
	elseif RandomDie == 2 then
		InputConsole("sndp "..pID.." FireHawkDieB.wav")
	elseif RandomDie == 3 then
		InputConsole("sndp "..pID.." FireHawkDieC.wav")
	end
end
Register_Script("FireHawkScript", "", FireHawkScript)

-- Vertigo Bomber Control Script

VertigoScript = {}
function VertigoScript:Created(ID, obj)
	Set_Model(obj, "v_gdi_hcraft")
	pID = HelipadSystem["Helipad"]["Nod"].Owner
	HelipadSystem["Vertigo"][pID].ID = obj
	HelipadSystem["Vertigo"][obj] = {}
	HelipadSystem["Vertigo"][obj].pID = pID
	HelipadSystem["Vertigo"][obj].Ammo = 2
	HelipadSystem["Vertigo"][pID].Enabled = "no"
	HelipadSystem["Helipad"]["Nod"].Owner = nil
	Start_Timer(ID, obj, 16, 1)
end
function VertigoScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		pID = HelipadSystem["Vertigo"][obj].pID
		Start_Timer(ID, obj, 1.5, 2)
	end
	if num == 2 then
		pID = HelipadSystem["Vertigo"][obj].pID
		RandomCreate = math.random(1,2)
		if RandomCreate == 1 then
			InputConsole("sndp "..pID.." VertigoCreateA.wav")
		elseif RandomCreate == 2 then
			InputConsole("sndp "..pID.." VertigoCreateB.wav")
		end
		Enable_Stealth(obj, 1)
	end
end
function VertigoScript:Custom(ID, obj, msg, driver, owner)
	if msg == 1000000028 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		if pID ~= HelipadSystem["Vertigo"][obj].pID then
			HelipadSystem["Vertigo"][obj].pID = pID
			HelipadSystem["Vertigo"][pID] = {}
			HelipadSystem["Vertigo"][pID].ID = obj
		end
		HelipadSystem["Vertigo"][pID].Enabled = "yes"
		RandomSelect = math.random(1,6)
		if RandomSelect == 1 then
			InputConsole("sndp "..pID.." VertigoSelectA.wav")
		elseif RandomSelect == 2 then
			InputConsole("sndp "..pID.." VertigoSelectB.wav")
		elseif RandomSelect == 3 then
			InputConsole("sndp "..pID.." VertigoSelectC.wav")
		elseif RandomSelect == 4 then
			InputConsole("sndp "..pID.." VertigoSelectD.wav")
		elseif RandomSelect == 5 then
			InputConsole("sndp "..pID.." VertigoSelectE.wav")
		elseif RandomSelect == 6 then
			InputConsole("sndp "..pID.." VertigoSelectF.wav")
		end
	end
	if msg == 1000000029 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		HelipadSystem["Vertigo"][pID].Enabled = "no"
	end
end
function VertigoScript:Destroyed(ID, obj)
	pID = HelipadSystem["Vertigo"][obj].pID
	HelipadSystem["Vertigo"][obj].Ammo = 0
	HelipadSystem["Vertigo"][obj].Reload = "no"
	HelipadSystem["Vertigo"][pID].ID = nil
	HelipadSystem["Vertigo"][pID].Enabled = "no"
	RandomDie = math.random(1,3)
	if RandomDie == 1 then
		InputConsole("sndp "..pID.." VertigoDieA.wav")
	elseif RandomDie == 2 then
		InputConsole("sndp "..pID.." VertigoDieB.wav")
	elseif RandomDie == 3 then
		InputConsole("sndp "..pID.." VertigoDieC.wav")
	end
end
function VertigoScript:Killed(ID, obj, killer)
	pID = HelipadSystem["Vertigo"][obj].pID
	HelipadSystem["Vertigo"][obj].Ammo = 0
	HelipadSystem["Vertigo"][obj].Reload = "no"
	HelipadSystem["Vertigo"][pID].ID = nil
	HelipadSystem["Vertigo"][pID].Enabled = "no"
	RandomDie = math.random(1,3)
	if RandomDie == 1 then
		InputConsole("sndp "..pID.." VertigoDieA.wav")
	elseif RandomDie == 2 then
		InputConsole("sndp "..pID.." VertigoDieB.wav")
	elseif RandomDie == 3 then
		InputConsole("sndp "..pID.." VertigoDieC.wav")
	end
end
Register_Script("VertigoScript", "", VertigoScript)

-- Vindicator Bomber Nod Control Script

NodVindicatorScript = {}
function NodVindicatorScript:Created(ID, obj)
	Set_Model(obj, "v_chameleon")
	pID = HelipadSystem["Helipad"]["Nod"].Owner
	HelipadSystem["Vindicator"][pID].ID = obj
	HelipadSystem["Vindicator"][obj] = {}
	HelipadSystem["Vindicator"][obj].pID = pID
	HelipadSystem["Vindicator"][obj].Ammo = 2
	HelipadSystem["Vindicator"][pID].Enabled = "no"
	HelipadSystem["Helipad"]["Nod"].Owner = nil
	Start_Timer(ID, obj, 16, 1)
end
function NodVindicatorScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		pID = HelipadSystem["Vindicator"][obj].pID
		Start_Timer(ID, obj, 1.5, 2)
	end
	if num == 2 then
		pID = HelipadSystem["Vindicator"][obj].pID
		RandomCreate = math.random(1,3)
		if RandomCreate == 1 then
			InputConsole("sndp "..pID.." VindicatorCreateA.wav")
		elseif RandomCreate == 2 then
			InputConsole("sndp "..pID.." VindicatorCreateB.wav")
		elseif RandomCreate == 3 then
			InputConsole("sndp "..pID.." VindicatorCreateC.wav")
		end
	end
end
function NodVindicatorScript:Custom(ID, obj, msg, driver, owner)
	if msg == 1000000028 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		if pID ~= HelipadSystem["Vindicator"][obj].pID then
			HelipadSystem["Vindicator"][obj].pID = pID
			HelipadSystem["Vindicator"][pID] = {}
			HelipadSystem["Vindicator"][pID].ID = obj
		end
		HelipadSystem["Vindicator"][pID].Enabled = "yes"
		RandomSelect = math.random(1,9)
		if RandomSelect == 1 then
			InputConsole("sndp "..pID.." VindicatorSelectA.wav")
		elseif RandomSelect == 2 then
			InputConsole("sndp "..pID.." VindicatorSelectB.wav")
		elseif RandomSelect == 3 then
			InputConsole("sndp "..pID.." VindicatorSelectC.wav")
		elseif RandomSelect == 4 then
			InputConsole("sndp "..pID.." VindicatorSelectD.wav")
		elseif RandomSelect == 5 then
			InputConsole("sndp "..pID.." VindicatorSelectE.wav")
		elseif RandomSelect == 6 then
			InputConsole("sndp "..pID.." VindicatorSelectF.wav")
		elseif RandomSelect == 7 then
			InputConsole("sndp "..pID.." VindicatorSelectG.wav")
		elseif RandomSelect == 8 then
			InputConsole("sndp "..pID.." VindicatorSelectH.wav")
		elseif RandomSelect == 9 then
			InputConsole("sndp "..pID.." VindicatorSelectI.wav")
		end
	end
	if msg == 1000000029 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		HelipadSystem["Vindicator"][pID].Enabled = "no"
	end
end
function NodVindicatorScript:Destroyed(ID, obj)
	pID = HelipadSystem["Vindicator"][obj].pID
	HelipadSystem["Vindicator"][obj].Ammo = 0
	HelipadSystem["Vindicator"][obj].Reload = "no"
	HelipadSystem["Vindicator"][pID].ID = nil
	HelipadSystem["Vindicator"][pID].Enabled = "no"
	RandomDie = math.random(1,4)
	if RandomDie == 1 then
		InputConsole("sndp "..pID.." VindicatorDieA.wav")
	elseif RandomDie == 2 then
		InputConsole("sndp "..pID.." VindicatorDieB.wav")
	elseif RandomDie == 3 then
		InputConsole("sndp "..pID.." VindicatorDieC.wav")
	elseif RandomDie == 4 then
		InputConsole("sndp "..pID.." VindicatorDieC.wav")
	end
end
function NodVindicatorScript:Killed(ID, obj, killer)
	pID = HelipadSystem["Vindicator"][obj].pID
	HelipadSystem["Vindicator"][obj].Ammo = 0
	HelipadSystem["Vindicator"][obj].Reload = "no"
	HelipadSystem["Vindicator"][pID].ID = nil
	HelipadSystem["Vindicator"][pID].Enabled = "no"
	RandomDie = math.random(1,4)
	if RandomDie == 1 then
		InputConsole("sndp "..pID.." VindicatorDieA.wav")
	elseif RandomDie == 2 then
		InputConsole("sndp "..pID.." VindicatorDieB.wav")
	elseif RandomDie == 3 then
		InputConsole("sndp "..pID.." VindicatorDieC.wav")
	elseif RandomDie == 4 then
		InputConsole("sndp "..pID.." VindicatorDieC.wav")
	end
end
Register_Script("NodVindicatorScript", "", NodVindicatorScript)

-- Vindicator Bomber Nod Control Script

GDIVindicatorScript = {}
function GDIVindicatorScript:Created(ID, obj)
	Set_Model(obj, "v_chameleon")
	pID = HelipadSystem["Helipad"]["GDI"].Owner
	HelipadSystem["Vindicator"][pID].ID = obj
	HelipadSystem["Vindicator"][obj] = {}
	HelipadSystem["Vindicator"][obj].pID = pID
	HelipadSystem["Vindicator"][obj].Ammo = 2
	HelipadSystem["Vindicator"][pID].Enabled = "no"
	HelipadSystem["Helipad"]["GDI"].Owner = nil
	Start_Timer(ID, obj, 16, 1)
end
function GDIVindicatorScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		pID = HelipadSystem["Vindicator"][obj].pID
		Start_Timer(ID, obj, 1.5, 2)
	end
	if num == 2 then
		pID = HelipadSystem["Vindicator"][obj].pID
		RandomCreate = math.random(1,3)
		if RandomCreate == 1 then
			InputConsole("sndp "..pID.." VindicatorCreateA.wav")
		elseif RandomCreate == 2 then
			InputConsole("sndp "..pID.." VindicatorCreateB.wav")
		elseif RandomCreate == 3 then
			InputConsole("sndp "..pID.." VindicatorCreateC.wav")
		end
	end
end
function GDIVindicatorScript:Custom(ID, obj, msg, driver, owner)
	if msg == 1000000028 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		if pID ~= HelipadSystem["Vindicator"][obj].pID then
			HelipadSystem["Vindicator"][obj].pID = pID
			HelipadSystem["Vindicator"][pID] = {}
			HelipadSystem["Vindicator"][pID].ID = obj
		end
		HelipadSystem["Vindicator"][pID].Enabled = "yes"
		RandomSelect = math.random(1,9)
		if RandomSelect == 1 then
			InputConsole("sndp "..pID.." VindicatorSelectA.wav")
		elseif RandomSelect == 2 then
			InputConsole("sndp "..pID.." VindicatorSelectB.wav")
		elseif RandomSelect == 3 then
			InputConsole("sndp "..pID.." VindicatorSelectC.wav")
		elseif RandomSelect == 4 then
			InputConsole("sndp "..pID.." VindicatorSelectD.wav")
		elseif RandomSelect == 5 then
			InputConsole("sndp "..pID.." VindicatorSelectE.wav")
		elseif RandomSelect == 6 then
			InputConsole("sndp "..pID.." VindicatorSelectF.wav")
		elseif RandomSelect == 7 then
			InputConsole("sndp "..pID.." VindicatorSelectG.wav")
		elseif RandomSelect == 8 then
			InputConsole("sndp "..pID.." VindicatorSelectH.wav")
		elseif RandomSelect == 9 then
			InputConsole("sndp "..pID.." VindicatorSelectI.wav")
		end
	end
	if msg == 1000000029 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		HelipadSystem["Vindicator"][pID].Enabled = "no"
	end
end
function GDIVindicatorScript:Destroyed(ID, obj)
	pID = HelipadSystem["Vindicator"][obj].pID
	HelipadSystem["Vindicator"][obj].Ammo = 0
	HelipadSystem["Vindicator"][obj].Reload = "no"
	HelipadSystem["Vindicator"][pID].ID = nil
	HelipadSystem["Vindicator"][pID].Enabled = "no"
	RandomDie = math.random(1,4)
	if RandomDie == 1 then
		InputConsole("sndp "..pID.." VindicatorDieA.wav")
	elseif RandomDie == 2 then
		InputConsole("sndp "..pID.." VindicatorDieB.wav")
	elseif RandomDie == 3 then
		InputConsole("sndp "..pID.." VindicatorDieC.wav")
	elseif RandomDie == 4 then
		InputConsole("sndp "..pID.." VindicatorDieC.wav")
	end
end
function GDIVindicatorScript:Killed(ID, obj, killer)
	pID = HelipadSystem["Vindicator"][obj].pID
	HelipadSystem["Vindicator"][obj].Ammo = 0
	HelipadSystem["Vindicator"][obj].Reload = "no"
	HelipadSystem["Vindicator"][pID].ID = nil
	HelipadSystem["Vindicator"][pID].Enabled = "no"
	RandomDie = math.random(1,4)
	if RandomDie == 1 then
		InputConsole("sndp "..pID.." VindicatorDieA.wav")
	elseif RandomDie == 2 then
		InputConsole("sndp "..pID.." VindicatorDieB.wav")
	elseif RandomDie == 3 then
		InputConsole("sndp "..pID.." VindicatorDieC.wav")
	elseif RandomDie == 4 then
		InputConsole("sndp "..pID.." VindicatorDieC.wav")
	end
end
Register_Script("GDIVindicatorScript", "", GDIVindicatorScript)

-- GDI Ion Bomber Controler

GDIIonBomberScript = {}
function GDIIonBomberScript:Created(ID, obj)
	Set_Model(obj, "v_gdi_a10")
	pID = HelipadSystem["Helipad"]["GDI"].Owner
	HelipadSystem["IonBomber"][pID].ID = obj
	HelipadSystem["IonBomber"][obj] = {}
	HelipadSystem["IonBomber"][obj].pID = pID
	HelipadSystem["IonBomber"][obj].Ammo = 1
	HelipadSystem["IonBomber"][pID].Enabled = "no"
	HelipadSystem["Helipad"]["GDI"].Owner = nil
	HelipadSystem["IonBomber"][obj].Building = "yes"
	Start_Timer(ID, obj, 16, 1)
	Set_Max_Health(obj, 500)
	Set_Max_Shield_Strength(obj, 500)
end
function GDIIonBomberScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		pID = HelipadSystem["IonBomber"][obj].pID
		HelipadSystem["IonBomber"][obj].Building = "no"
	end
end
function GDIIonBomberScript:Custom(ID, obj, msg, driver, owner)
	if msg == 1000000028 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		if pID ~= HelipadSystem["IonBomber"][obj].pID then
			Force_Occupant_Exit(pID)
		end
		BomberID = HelipadSystem["IonBomber"][pID].ID
		HelipadSystem["IonBomber"][BomberID].Enabled = "yes"
	end
	if msg == 1000000029 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		BomberID = HelipadSystem["IonBomber"][pID].ID
		HelipadSystem["IonBomber"][BomberID].Enabled = "no"
	end
end
function GDIIonBomberScript:Destroyed(ID, obj)
	if HelipadSystem["IonBomber"][obj].Ammo == 1 then
		Attach_Script(obj, "JFW_Blow_Up_On_Death", "Explosion_IonCannonBeacon")
	end	
	pID = HelipadSystem["IonBomber"][obj].pID
	HelipadSystem["IonBomber"][obj].Ammo = 0
	HelipadSystem["IonBomber"][obj].Reload = "no"
	HelipadSystem["IonBomber"][pID].ID = nil
	HelipadSystem["IonBomber"][pID].Enabled = "no"
end
function GDIIonBomberScript:Killed(ID, obj, killer)
	if HelipadSystem["IonBomber"][obj].Ammo == 1 then
		Attach_Script(obj, "JFW_Blow_Up_On_Death", "Explosion_IonCannonBeacon")
	end	
	pID = HelipadSystem["IonBomber"][obj].pID
	HelipadSystem["IonBomber"][obj].Ammo = 0
	HelipadSystem["IonBomber"][obj].Reload = "no"
	HelipadSystem["IonBomber"][pID].ID = nil
	HelipadSystem["IonBomber"][pID].Enabled = "no"
end
Register_Script("GDIIonBomberScript", "", GDIIonBomberScript)

--Nod's Nuke Bomber Controler

NodNukeBomberScript = {}
function NodNukeBomberScript:Created(ID, obj)
	Set_Model(obj, "v_jet")
	pID = HelipadSystem["Helipad"]["Nod"].Owner
	HelipadSystem["NukeBomber"][pID].ID = obj
	HelipadSystem["NukeBomber"][obj] = {}
	HelipadSystem["NukeBomber"][obj].pID = pID
	HelipadSystem["NukeBomber"][obj].Ammo = 1
	HelipadSystem["NukeBomber"][pID].Enabled = "no"
	HelipadSystem["Helipad"]["Nod"].Owner = nil
	HelipadSystem["NukeBomber"][obj].Building = "yes"
	Start_Timer(ID, obj, 16, 1)
	Set_Max_Health(obj, 500)
	Set_Max_Shield_Strength(obj, 500)
end
function NodNukeBomberScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		pID = HelipadSystem["NukeBomber"][obj].pID
		HelipadSystem["NukeBomber"][obj].Building = "no"
	end
end
function NodNukeBomberScript:Custom(ID, obj, msg, driver, owner)
	if msg == 1000000028 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		if pID ~= HelipadSystem["NukeBomber"][obj].pID then
			Force_Occupant_Exit(pID)
		end
		BomberID = HelipadSystem["NukeBomber"][pID].ID
		HelipadSystem["NukeBomber"][BomberID].Enabled = "yes"
	end
	if msg == 1000000029 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		BomberID = HelipadSystem["NukeBomber"][pID].ID
		HelipadSystem["NukeBomber"][BomberID].Enabled = "no"
	end
end
function NodNukeBomberScript:Destroyed(ID, obj)
	if HelipadSystem["NukeBomber"][obj].Ammo == 1 then
		Attach_Script(obj, "JFW_Blow_Up_On_Death", "Explosion_NukeBeacon")
	end
	pID = HelipadSystem["NukeBomber"][obj].pID
	HelipadSystem["NukeBomber"][obj].Ammo = 0
	HelipadSystem["NukeBomber"][obj].Reload = "no"
	HelipadSystem["NukeBomber"][pID].ID = nil
	HelipadSystem["NukeBomber"][pID].Enabled = "no"
end
function NodNukeBomberScript:Killed(ID, obj, killer)
	if HelipadSystem["NukeBomber"][obj].Ammo == 1 then
		Attach_Script(obj, "JFW_Blow_Up_On_Death", "Explosion_NukeBeacon")
	end
	pID = HelipadSystem["NukeBomber"][obj].pID
	HelipadSystem["NukeBomber"][obj].Ammo = 0
	HelipadSystem["NukeBomber"][obj].Reload = "no"
	HelipadSystem["NukeBomber"][pID].ID = nil
	HelipadSystem["NukeBomber"][pID].Enabled = "no"
end
Register_Script("NodNukeBomberScript", "", NodNukeBomberScript)

-- GDI Bomber Controler

GDIBomberScript = {}
function GDIBomberScript:Created(ID, obj)
	Set_Model(obj, "v_gdi_a10")
	pID = HelipadSystem["Helipad"]["GDI"].Owner
	HelipadSystem["CarpetBomber"][pID].ID = obj
	HelipadSystem["CarpetBomber"][obj] = {}
	HelipadSystem["CarpetBomber"][obj].pID = pID
	HelipadSystem["CarpetBomber"][obj].Ammo = 10
	HelipadSystem["CarpetBomber"][pID].Enabled = "no"
	HelipadSystem["Helipad"]["GDI"].Owner = nil
	HelipadSystem["CarpetBomber"][obj].Building = "yes"
	Start_Timer(ID, obj, 16, 1)
end
function GDIBomberScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		pID = HelipadSystem["CarpetBomber"][obj].pID
		HelipadSystem["CarpetBomber"][obj].Building = "no"
	end
end
function GDIBomberScript:Custom(ID, obj, msg, driver, owner)
	if msg == 1000000028 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		if pID ~= HelipadSystem["CarpetBomber"][obj].pID then
			Force_Occupant_Exit(pID)
		end
		BomberID = HelipadSystem["CarpetBomber"][pID].ID
		HelipadSystem["CarpetBomber"][BomberID].Enabled = "yes"
	end
	if msg == 1000000029 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		BomberID = HelipadSystem["CarpetBomber"][pID].ID
		HelipadSystem["CarpetBomber"][BomberID].Enabled = "no"
	end
end
function GDIBomberScript:Destroyed(ID, obj)
	pID = HelipadSystem["CarpetBomber"][obj].pID
	HelipadSystem["CarpetBomber"][obj].Ammo = 0
	HelipadSystem["CarpetBomber"][obj].Reload = "no"
	HelipadSystem["CarpetBomber"][pID].ID = nil
	HelipadSystem["CarpetBomber"][pID].Enabled = "no"
end
function GDIBomberScript:Killed(ID, obj, killer)
	pID = HelipadSystem["CarpetBomber"][obj].pID
	HelipadSystem["CarpetBomber"][obj].Ammo = 0
	HelipadSystem["CarpetBomber"][obj].Reload = "no"
	HelipadSystem["CarpetBomber"][pID].ID = nil
	HelipadSystem["CarpetBomber"][pID].Enabled = "no"
end
Register_Script("GDIBomberScript", "", GDIBomberScript)

--Nod's Bomber Controler

NodBomberScript = {}
function NodBomberScript:Created(ID, obj)
	Set_Model(obj, "v_jet")
	pID = HelipadSystem["Helipad"]["Nod"].Owner
	HelipadSystem["CarpetBomber"][pID].ID = obj
	HelipadSystem["CarpetBomber"][obj] = {}
	HelipadSystem["CarpetBomber"][obj].pID = pID
	HelipadSystem["CarpetBomber"][obj].Ammo = 10
	HelipadSystem["CarpetBomber"][pID].Enabled = "no"
	HelipadSystem["Helipad"]["Nod"].Owner = nil
	HelipadSystem["CarpetBomber"][obj].Building = "yes"
	Start_Timer(ID, obj, 16, 1)
end
function NodBomberScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		pID = HelipadSystem["CarpetBomber"][obj].pID
		HelipadSystem["CarpetBomber"][obj].Building = "no"
	end
end
function NodBomberScript:Custom(ID, obj, msg, driver, owner)
	if msg == 1000000028 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		if pID ~= HelipadSystem["CarpetBomber"][obj].pID then
			Force_Occupant_Exit(pID)
		end
		BomberID = HelipadSystem["CarpetBomber"][pID].ID
		HelipadSystem["CarpetBomber"][BomberID].Enabled = "yes"
	end
	if msg == 1000000029 then
		pID = Get_ID_By_Player_Name(Get_Player_Name(owner))
		BomberID = HelipadSystem["CarpetBomber"][pID].ID
		HelipadSystem["CarpetBomber"][BomberID].Enabled = "no"
	end
end
function NodBomberScript:Destroyed(ID, obj)
	pID = HelipadSystem["CarpetBomber"][obj].pID
	HelipadSystem["CarpetBomber"][obj].Ammo = 0
	HelipadSystem["CarpetBomber"][obj].Reload = "no"
	HelipadSystem["CarpetBomber"][pID].ID = nil
	HelipadSystem["CarpetBomber"][pID].Enabled = "no"
end
function NodBomberScript:Killed(ID, obj, killer)
	pID = HelipadSystem["CarpetBomber"][obj].pID
	HelipadSystem["CarpetBomber"][obj].Ammo = 0
	HelipadSystem["CarpetBomber"][obj].Reload = "no"
	HelipadSystem["CarpetBomber"][pID].ID = nil
	HelipadSystem["CarpetBomber"][pID].Enabled = "no"
end
Register_Script("NodBomberScript", "", NodBomberScript)

--Kills the bomb instead of destroying it

BombKillScript = {}
function BombKillScript:Created(ID, obj)
	Start_Timer(ID, obj, 0.1, 1)
	Start_Timer(ID, obj, 0.15, 2)
	Start_Timer(ID, obj, 0.2, 3)
end
function BombKillScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		HelipadSystem["Bomb"][obj].pos = Get_Position(obj)
		Start_Timer(ID, obj, 0.1, 1)
	end
	if num == 2 then
		HelipadSystem["Bomb"][obj].pos2 = Get_Position(obj)
		Start_Timer(ID, obj, 0.1, 2)
	end
	if num == 3 then
		if HelipadSystem["Bomb"][obj].pos.Z == HelipadSystem["Bomb"][obj].pos2.Z then
			pID = HelipadSystem["Bomb"][obj].pID
			if HelipadSystem["Bomb"][pID] ~= nil then
				if obj == HelipadSystem["Bomb"][pID].IonBombID then
					BombRadiation = Create_Object("Invisible_Object", pos)
					Attach_Script(BombRadiation, "IonRadiationScript", "")
					HelipadSystem["Bomb"][BombRadiation] = {}
					HelipadSystem["Bomb"][BombRadiation].pID = pID
					for _,Building in pairs(Get_All_Buildings()) do
						local distance = Get_Distance(obj, Building)
						if distance < 10 then -- less then 40 meters
							health = Get_Health(Building)
							onetwenty = health*.4
							Apply_Damage(Building, onetwenty, "sharpnel", 0) 
        						pos = Get_Position(Building)
       							object = Create_Object("M09_Rnd_Door", pos)
        						Attach_Script_Once(object, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
        						Apply_Damage(object, 9999, "blamokiller", 0)
							Console_Input(string.format("msg %s was damaged by a bomber!",Get_Preset_Name(Building)))
						end
					end
				end
			end
			if HelipadSystem["Bomb"][pID] ~= nil then
				if obj == HelipadSystem["Bomb"][pID].NukeBombID then
					BombRadiation = Create_Object("Invisible_Object", pos)
					Attach_Script(BombRadiation, "NukeRadiationScript", "")
					HelipadSystem["Bomb"][BombRadiation] = {}
					HelipadSystem["Bomb"][BombRadiation].pID = pID
					for _,Building in pairs(Get_All_Buildings()) do
						local distance = Get_Distance(obj, Building)
						if distance < 10 then -- less then 40 meters
							health = Get_Health(Building)
							onetwenty = health*.4
							Apply_Damage(Building, onetwenty, "sharpnel", 0) 
        						pos = Get_Position(Building)
       							object = Create_Object("M09_Rnd_Door", pos)
        						Attach_Script_Once(object, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
        						Apply_Damage(object, 9999, "blamokiller", 0)
							Console_Input(string.format("msg %s was damaged by a bomber!",Get_Preset_Name(Building)))
						end
					end
				end
			end
			for _,Building in pairs(Get_All_Buildings()) do
				local distance = Get_Distance(obj, Building)
				if distance < 10 then -- less then 40 meters
					health = Get_Health(Building)
					onetwenty = health*.1
					Apply_Damage(Building, onetwenty, "sharpnel", 0) 
        				pos = Get_Position(Building)
       					object = Create_Object("M09_Rnd_Door", pos)
        				Attach_Script_Once(object, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
        				Apply_Damage(object, 9999, "blamokiller", 0)
					Console_Input(string.format("msg %s was damaged by a bomber!",Get_Preset_Name(Building)))
				end
			end
			Apply_Damage(obj, 9999, "blamokiller", 99999)
		end
		Start_Timer(ID, obj, 0.1, 3)
	end
end
Register_Script("BombKillScript", "", BombKillScript)

--The Helipad Reload zone

GHelipadScriptZone = {}
function GHelipadScriptZone:Entered(ID, obj, enter)
	if Is_VTOLVehicle(enter) then
		pID = Get_ID_By_Player_Name(Get_Player_Name(Get_Vehicle_Driver(enter)))
		Vehicle = enter
		if Get_Vehicle_Occupant_Count(enter) >= 1 then
			if Get_Team(pID) == 1 then
				if enter == HelipadSystem["FireHawk"][pID].ID then
					HawkID = HelipadSystem["FireHawk"][pID].ID
					if HelipadSystem["FireHawk"][HawkID].Ammo <= 3 or HelipadSystem["FireHawk"][HawkID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Reloading...")
						Start_Timer(ID, obj, 3, 1)
						HelipadSystem["FireHawk"][HawkID].Reload = "yes"
					end
				end
				if enter == HelipadSystem["Vertigo"][pID].ID then
					VertID = HelipadSystem["Vertigo"][pID].ID
					if HelipadSystem["Vertigo"][VertID].Ammo <= 1 or HelipadSystem["Vertigo"][VertID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Reloading...")
						Start_Timer(ID, obj, 3, 1)
						HelipadSystem["Vertigo"][VertID].Reload = "yes"
					end
				end
				if enter == HelipadSystem["Vindicator"][pID].ID then
					VindID = HelipadSystem["Vindicator"][pID].ID
					if HelipadSystem["Vindicator"][VindID].Ammo <= 1 or HelipadSystem["Vindicator"][VindID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Reloading...")
						Start_Timer(ID, obj, 3, 1)
						HelipadSystem["Vindicator"][VindID].Reload = "yes"
					end
				end
				if enter == HelipadSystem["CarpetBomber"][pID].ID then
					BomberID = HelipadSystem["CarpetBomber"][pID].ID
					if HelipadSystem["CarpetBomber"][BomberID].Ammo <= 9 or HelipadSystem["CarpetBomber"][BomberID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Reloading...")
						Start_Timer(ID, obj, 3, 1)
						HelipadSystem["CarpetBomber"][BomberID].Reload = "yes"
					end
				end
				if enter == HelipadSystem["IonBomber"][pID].ID then
					BomberID = HelipadSystem["IonBomber"][pID].ID
					if HelipadSystem["IonBomber"][BomberID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Ion Bomber will be reloaded in 30 seconds. Please do not leave the helipad")
						Start_Timer(ID, obj, 30, 1)
						HelipadSystem["IonBomber"][BomberID].Reload = "yes"
					end
				end
				if enter == HelipadSystem["NukeBomber"][pID].ID then
					BomberID = HelipadSystem["NukeBomber"][pID].ID
					if HelipadSystem["NukeBomber"][BomberID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Nuke Bomber will be reloaded in 30 seconds. Please do not leave the helipad.")
						Start_Timer(ID, obj, 30, 1)
						HelipadSystem["NukeBomber"][BomberID].Reload = "yes"
					end
				end
			end
		end
	end
end
function GHelipadScriptZone:Timer_Expired(ID, obj, num)
	if Vehicle == HelipadSystem["CarpetBomber"][pID].ID then
		BomberID = HelipadSystem["CarpetBomber"][pID].ID
		if HelipadSystem["CarpetBomber"][BomberID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["CarpetBomber"][BomberID].Ammo <= 9 or HelipadSystem["CarpetBomber"][BomberID].Ammo == 0 then
					HelipadSystem["CarpetBomber"][BomberID].Ammo = HelipadSystem["CarpetBomber"][BomberID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["CarpetBomber"][BomberID].Ammo == 10 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Carpet Bomber has been reloaded.")
					else
						Start_Timer(ID, obj, 3, 1)
					end
				end
			end
		end
	end
	if Vehicle == HelipadSystem["NukeBomber"][pID].ID then
		BomberID = HelipadSystem["NukeBomber"][pID].ID
		if HelipadSystem["NukeBomber"][BomberID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["NukeBomber"][BomberID].Ammo == 0 then
					HelipadSystem["NukeBomber"][BomberID].Ammo = HelipadSystem["NukeBomber"][BomberID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["NukeBomber"][BomberID].Ammo == 1 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Nuke Bomber has been reloaded.")
					else
						Start_Timer(ID, obj, 30, 1)
					end
				end
			end
		end
	end
	if Vehicle == HelipadSystem["IonBomber"][pID].ID then
		BomberID = HelipadSystem["IonBomber"][pID].ID
		if HelipadSystem["IonBomber"][BomberID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["IonBomber"][BomberID].Ammo == 0 then
					HelipadSystem["IonBomber"][BomberID].Ammo = HelipadSystem["IonBomber"][BomberID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["IonBomber"][BomberID].Ammo == 1 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Ion Bomber has been reloaded.")
					else
						Start_Timer(ID, obj, 30, 1)
					end
				end
			end
		end
	end
	if Vehicle == HelipadSystem["FireHawk"][pID].ID then
		HawkID = HelipadSystem["FireHawk"][pID].ID
		if HelipadSystem["FireHawk"][HawkID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["FireHawk"][HawkID].Ammo <= 3 or HelipadSystem["FireHawk"][HawkID].Ammo == 0 then
					HelipadSystem["FireHawk"][HawkID].Ammo = HelipadSystem["FireHawk"][HawkID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["FireHawk"][HawkID].Ammo == 4 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Fire Hawk has been reloaded.")
					else
						Start_Timer(ID, obj, 3, 1)
					end
				end
			end
		end
	end
	if Vehicle == HelipadSystem["Vertigo"][pID].ID then
		VertID = HelipadSystem["Vertigo"][pID].ID
		if HelipadSystem["Vertigo"][VertID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["Vertigo"][VertID].Ammo <= 1 or HelipadSystem["Vertigo"][VertID].Ammo == 0 then
					HelipadSystem["Vertigo"][VertID].Ammo = HelipadSystem["Vertigo"][VertID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["Vertigo"][VertID].Ammo == 2 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Vertigo has been reloaded.")
					else
						Start_Timer(ID, obj, 3, 1)
					end
				end
			end
		end
	end
	if Vehicle == HelipadSystem["Vindicator"][pID].ID then
		VindID = HelipadSystem["Vindicator"][pID].ID
		if HelipadSystem["Vindicator"][VindID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["Vindicator"][VindID].Ammo <= 1 or HelipadSystem["Vindicator"][VindID].Ammo == 0 then
					HelipadSystem["Vindicator"][VindID].Ammo = HelipadSystem["Vindicator"][VindID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["Vindicator"][VindID].Ammo == 2 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Vindicator has been reloaded.")
					else
						Start_Timer(ID, obj, 3, 1)
					end
				end
			end
		end
	end
end
function GHelipadScriptZone:Exited(ID, obj, exiter)
	bombaID = Get_Player_ID(exiter)
	if Is_VTOLVehicle(exiter) then
		if Get_Vehicle_Occupant_Count(exiter) >= 1 then
			if Get_Team(bombaID) == 1 then
				if exiter == HelipadSystem["FireHawk"][pID].ID then
					HawkID = HelipadSystem["FireHawk"][pID].ID
					HelipadSystem["FireHawk"][HawkID].Reload = "no"
				end
				if exiter == HelipadSystem["Vertigo"][pID].ID then
					VertID = HelipadSystem["Vertigo"][pID].ID
					HelipadSystem["Vertigo"][VertID].Reload = "no"
				end
				if exiter == HelipadSystem["Vindicator"][pID].ID then
					VindID = HelipadSystem["Vindicator"][pID].ID
					HelipadSystem["Vindicator"][VindID].Reload = "no"
				end
				if exiter == HelipadSystem["CarpetBomber"][pID].ID then
					BomberID = HelipadSystem["CarpetBomber"][pID].ID
					HelipadSystem["CarpetBomber"][BomberID].Reload = "no"
				end
				if exiter == HelipadSystem["IonBomber"][pID].ID then
					BomberID = HelipadSystem["IonBomber"][pID].ID
					HelipadSystem["IonBomber"][BomberID].Reload = "no"
				end
				if exiter == HelipadSystem["NukeBomber"][pID].ID then
					BomberID = HelipadSystem["NukeBomber"][pID].ID
					HelipadSystem["NukeBomber"][BomberID].Reload = "no"
				end
			end
		end
	end
end
Register_Script("GHelipadScriptZone", "", GHelipadScriptZone)

-- Nods Helipad Reload Zone

NHelipadScriptZone = {}
function NHelipadScriptZone:Entered(ID, obj, enter)
	if Is_VTOLVehicle(enter) then
		pID = Get_ID_By_Player_Name(Get_Player_Name(Get_Vehicle_Driver(enter)))
		Vehicle = enter
		if Get_Vehicle_Occupant_Count(enter) >= 1 then
			if Get_Team(pID) == 0 then
				if enter == HelipadSystem["FireHawk"][pID].ID then
					HawkID = HelipadSystem["FireHawk"][pID].ID
					if HelipadSystem["FireHawk"][HawkID].Ammo <= 3 or HelipadSystem["FireHawk"][HawkID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Reloading...")
						Start_Timer(ID, obj, 3, 1)
						HelipadSystem["FireHawk"][HawkID].Reload = "yes"
					end
				end
				if enter == HelipadSystem["Vertigo"][pID].ID then
					VertID = HelipadSystem["Vertigo"][pID].ID
					if HelipadSystem["Vertigo"][VertID].Ammo <= 1 or HelipadSystem["Vertigo"][VertID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Reloading...")
						Start_Timer(ID, obj, 3, 1)
						HelipadSystem["Vertigo"][VertID].Reload = "yes"
					end
				end
				if enter == HelipadSystem["Vindicator"][pID].ID then
					VindID = HelipadSystem["Vindicator"][pID].ID
					if HelipadSystem["Vindicator"][VindID].Ammo <= 1 or HelipadSystem["Vindicator"][VindID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Reloading...")
						Start_Timer(ID, obj, 3, 1)
						HelipadSystem["Vindicator"][VindID].Reload = "yes"
					end
				end
				if enter == HelipadSystem["CarpetBomber"][pID].ID then
					BomberID = HelipadSystem["CarpetBomber"][pID].ID
					if HelipadSystem["CarpetBomber"][BomberID].Ammo <= 9 or HelipadSystem["CarpetBomber"][BomberID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Reloading...")
						Start_Timer(ID, obj, 3, 1)
						HelipadSystem["CarpetBomber"][BomberID].Reload = "yes"
					end
				end
				if enter == HelipadSystem["IonBomber"][pID].ID then
					BomberID = HelipadSystem["IonBomber"][pID].ID
					if HelipadSystem["IonBomber"][BomberID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Ion Bomber will be reloaded in 30 seconds. Please do not leave the helipad.")
						Start_Timer(ID, obj, 30, 1)
						HelipadSystem["IonBomber"][BomberID].Reload = "yes"
					end
				end
				if enter == HelipadSystem["NukeBomber"][pID].ID then
					BomberID = HelipadSystem["NukeBomber"][pID].ID
					if HelipadSystem["NukeBomber"][BomberID].Ammo == 0 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Nuke Bomber will be reloaded in 30 seconds. Please do not leave the helipad.")
						Start_Timer(ID, obj, 30, 1)
						HelipadSystem["NukeBomber"][BomberID].Reload = "yes"
					end
				end
			end
		end
	end
end
function NHelipadScriptZone:Timer_Expired(ID, obj, num)
	if Vehicle == HelipadSystem["FireHawk"][pID].ID then
		HawkID = HelipadSystem["FireHawk"][pID].ID
		if HelipadSystem["FireHawk"][HawkID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["FireHawk"][HawkID].Ammo <= 3 or HelipadSystem["FireHawk"][HawkID].Ammo == 0 then
					HelipadSystem["FireHawk"][HawkID].Ammo = HelipadSystem["FireHawk"][HawkID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["FireHawk"][HawkID].Ammo == 4 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Fire Hawk has been reloaded.")
					else
						Start_Timer(ID, obj, 3, 1)
					end
				end
			end
		end
	end
	if Vehicle == HelipadSystem["Vertigo"][pID].ID then
		VertID = HelipadSystem["Vertigo"][pID].ID
		if HelipadSystem["Vertigo"][VertID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["Vertigo"][VertID].Ammo <= 1 or HelipadSystem["Vertigo"][VertID].Ammo == 0 then
					HelipadSystem["Vertigo"][VertID].Ammo = HelipadSystem["Vertigo"][VertID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["Vertigo"][VertID].Ammo == 2 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Vertigo has been reloaded.")
					else
						Start_Timer(ID, obj, 3, 1)
					end
				end
			end
		end
	end
	if Vehicle == HelipadSystem["CarpetBomber"][pID].ID then
		BomberID = HelipadSystem["CarpetBomber"][pID].ID
		if HelipadSystem["CarpetBomber"][BomberID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["CarpetBomber"][BomberID].Ammo <= 9 or HelipadSystem["CarpetBomber"][BomberID].Ammo == 0 then
					HelipadSystem["CarpetBomber"][BomberID].Ammo = HelipadSystem["CarpetBomber"][BomberID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["CarpetBomber"][BomberID].Ammo == 10 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Carpet Bomber has been reloaded.")
					else
						Start_Timer(ID, obj, 3, 1)
					end
				end
			end
		end
	end
	if Vehicle == HelipadSystem["NukeBomber"][pID].ID then
		BomberID = HelipadSystem["NukeBomber"][pID].ID
		if HelipadSystem["NukeBomber"][BomberID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["NukeBomber"][BomberID].Ammo == 0 then
					HelipadSystem["NukeBomber"][BomberID].Ammo = HelipadSystem["NukeBomber"][BomberID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["NukeBomber"][BomberID].Ammo == 1 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Nuke Bomber has been reloaded.")
					else
						Start_Timer(ID, obj, 30, 1)
					end
				end
			end
		end
	end
	if Vehicle == HelipadSystem["IonBomber"][pID].ID then
		BomberID = HelipadSystem["IonBomber"][pID].ID
		if HelipadSystem["IonBomber"][BomberID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["IonBomber"][BomberID].Ammo == 0 then
					HelipadSystem["IonBomber"][BomberID].Ammo = HelipadSystem["IonBomber"][BomberID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["IonBomber"][BomberID].Ammo == 1 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Ion Bomber has been reloaded.")
					else
						Start_Timer(ID, obj, 30, 1)
					end
				end
			end
		end
	end
	if Vehicle == HelipadSystem["Vindicator"][pID].ID then
		VindID = HelipadSystem["Vindicator"][pID].ID
		if HelipadSystem["Vindicator"][VindID].Reload == "yes" then
			if num == 1 then
				if HelipadSystem["Vindicator"][VindID].Ammo <= 1 or HelipadSystem["Vindicator"][VindID].Ammo == 0 then
					HelipadSystem["Vindicator"][VindID].Ammo = HelipadSystem["Vindicator"][VindID].Ammo + 1
					InputConsole("sndp "..pID.." clicking_looped.wav")
					if HelipadSystem["Vindicator"][VindID].Ammo == 2 then
						InputConsole("cmsgp "..pID.." 0,0,255 Your Vertigo has been reloaded.")
					else
						Start_Timer(ID, obj, 3, 1)
					end
				end
			end
		end
	end
end
function NHelipadScriptZone:Exited(ID, obj, exiter)
	if Is_VTOLVehicle(exiter) then
		if Get_Vehicle_Occupant_Count(exiter) >= 1 then
			pID = Get_ID_By_Player_Name(Get_Player_Name(Get_Vehicle_Driver(exiter)))
			if Get_Team(pID) == 0 then
				if exiter == HelipadSystem["FireHawk"][pID].ID then
					HawkID = HelipadSystem["FireHawk"][pID].ID
					HelipadSystem["FireHawk"][HawkID].Reload = "no"
				end
				if exiter == HelipadSystem["Vertigo"][pID].ID then
					VertID = HelipadSystem["Vertigo"][pID].ID
					HelipadSystem["Vertigo"][VertID].Reload = "no"
				end
				if exiter == HelipadSystem["Vindicator"][pID].ID then
					VindID = HelipadSystem["Vindicator"][pID].ID
					HelipadSystem["Vindicator"][VindID].Reload = "no"
				end
				if exiter == HelipadSystem["CarpetBomber"][pID].ID then
					BomberID = HelipadSystem["CarpetBomber"][pID].ID
					HelipadSystem["CarpetBomber"][BomberID].Reload = "no"
				end
				if exiter == HelipadSystem["IonBomber"][pID].ID then
					BomberID = HelipadSystem["IonBomber"][pID].ID
					HelipadSystem["IonBomber"][BomberID].Reload = "no"
				end
				if exiter == HelipadSystem["NukeBomber"][pID].ID then
					BomberID = HelipadSystem["NukeBomber"][pID].ID
					HelipadSystem["NukeBomber"][BomberID].Reload = "no"
				end
			end
		end
	end
end
Register_Script("NHelipadScriptZone", "", NHelipadScriptZone)

--Firing Rate for the bombers

Bomber_Firing_Rate = {}
function Bomber_Firing_Rate:ScriptParams()
	return "myparameter:int"
end
function Bomber_Firing_Rate:Created(ID, obj)
	Time = Get_String_Parameter(ID, obj, "myparameter")
	Start_Timer(ID, obj, Time, 1)
end
function Bomber_Firing_Rate:Timer_Expired(ID, obj, num)
	pID = Get_ID_By_Player_Name(Get_Player_Name(Get_Vehicle_Driver(obj)))
	if num == 1 then
		if Get_Vehicle_Occupant_Count(obj) >= 1 then
			if obj == HelipadSystem["FireHawk"][pID].ID then
				HawkID = HelipadSystem["FireHawk"][pID].ID
				HelipadSystem["FireHawk"][pID].Enabled = "yes"
			end
			if obj == HelipadSystem["Vertigo"][pID].ID then
				VertID = HelipadSystem["Vertigo"][pID].ID
				HelipadSystem["Vertigo"][pID].Enabled = "yes"
			end
			if obj == HelipadSystem["Vindicator"][pID].ID then
				VindID = HelipadSystem["Vindicator"][pID].ID
				HelipadSystem["Vindicator"][pID].Enabled = "yes"
			end
			if obj == HelipadSystem["CarpetBomber"][pID].ID then
				BomberID = HelipadSystem["CarpetBomber"][pID].ID
				HelipadSystem["CarpetBomber"][BomberID].Enabled = "yes"
			end
			if obj == HelipadSystem["NukeBomber"][pID].ID then
				BomberID = HelipadSystem["NukeBomber"][pID].ID
				HelipadSystem["NukeBomber"][BomberID].Enabled = "yes"
			end
			if obj == HelipadSystem["IonBomber"][pID].ID then
				BomberID = HelipadSystem["IonBomber"][pID].ID
				HelipadSystem["IonBomber"][BomberID].Enabled = "yes"
			end
			Remove_Script(obj, "Bomber_Firing_Rate")
		end
	end
end
Register_Script("Bomber_Firing_Rate", "myparameter:int", Bomber_Firing_Rate)

-- Timer for the Vertigo's Stealth

Stealth_Timer = {}
function Stealth_Timer:Created(ID, obj)
	Start_Timer(ID, obj, 5, 1)
end
function Stealth_Timer:Timer_Expired(ID, obj, num)
	pID = Get_ID_By_Player_Name(Get_Player_Name(Get_Vehicle_Driver(obj)))
	if num == 1 then
		if Get_Vehicle_Occupant_Count(obj) >= 1 then
			if obj == HelipadSystem["Vertigo"][pID].ID then
				Enable_Stealth(HelipadSystem["Vertigo"][pID].ID, 1)
			end
			Remove_Script(obj, "Stealth_Timer")
		end
	end
end
Register_Script("Stealth_Timer", "", Stealth_Timer)

-- Build Progress for the GDI units

GHeli_Building_Progress = {}
function GHeli_Building_Progress:Created(ID, obj)
	Start_Timer(ID, obj, 16, 1)
end
function GHeli_Building_Progress:Timer_Expired(ID, obj, num)
	if num == 1 then
		HelipadSystem["Helipad"]["GDI"].Building = "no"
		InputConsole("sndt 1 m00evag_dsgn0006i1evag_snd.wav")
		InputConsole("cmsgt 1 255,255,255 Unit ready.")
		Remove_Script(obj, "GHeli_Building_Progress")
	end
end
Register_Script("GHeli_Building_Progress", "", GHeli_Building_Progress)

-- Build Progress for the Nod units

NHeli_Building_Progress = {}
function NHeli_Building_Progress:Created(ID, obj)
	Start_Timer(ID, obj, 16, 1)
end
function NHeli_Building_Progress:Timer_Expired(ID, obj, num)
	if num == 1 then
		HelipadSystem["Helipad"]["Nod"].Building = "no"
		InputConsole("sndt 0 m00evan_dsgn0003i1evan_snd.wav")
		InputConsole("cmsgt 0 255,255,255 Unit ready.")
		Remove_Script(obj, "NHeli_Building_Progress")
	end
end
Register_Script("NHeli_Building_Progress", "", NHeli_Building_Progress)

-- Construction Complete Sound for GDI

GHeli_Construction_Complete = {}
function GHeli_Construction_Complete:Created(ID, obj)
	Start_Timer(ID, obj, 1.8, 1)
end
function GHeli_Construction_Complete:Timer_Expired(ID, obj, num)
	if num == 1 then
		InputConsole("sndt 1 m00evag_dsgn0010i1evag_snd.wav")
		Remove_Script(obj, "GHeli_Construction_Complete")
	end
end
Register_Script("GHeli_Construction_Complete", "", GHeli_Construction_Complete)

-- Construction Complete Sound for Nod

NHeli_Construction_Complete = {}
function NHeli_Construction_Complete:Created(ID, obj)
	Start_Timer(ID, obj, 1.8, 1)
end
function NHeli_Construction_Complete:Timer_Expired(ID, obj, num)
	if num == 1 then
		InputConsole("sndt 0 m00evan_dsgn0005i1evan_snd.wav")
		Remove_Script(obj, "NHeli_Construction_Complete")
	end
end
Register_Script("NHeli_Construction_Complete", "", NHeli_Construction_Complete)

-- GDI Helipad Control Scripts
-- Sounds
-- GDI GDI Helicopter pad under attack m00bghp_tdfe0001i1evag_snd
-- Nod GDI Helicopter pad under attack m00bghp_tdfe0002i1evan_snd
-- Nod GDI Helicopter pad destroyed m00bghp_kill0002i1evan_snd
-- GDI GDI Helicopter pad destroyed m00bghp_kill0001i1evag_snd
-- SBH "Structure destroyed brothers!" m00bggt_kill0027i1nsss_snd
-- Havod "That was a bad idea brothers." m00bgwf_kill0003i1gbmg_snd

G_Helipad_Control = {}
function G_Helipad_Control:Damaged(ID, obj, shooter, damage)
	if damage > 0 then
		if HelipadSystem["Helipad"]["GDI"].Attacked == "no" then
			HelipadSystem["Helipad"]["GDI"].Attacked = "yes"
			InputConsole("sndt 1 m00bghp_tdfe0001i1evag_snd.wav")
			InputConsole("sndt 0 m00bghp_tdfe0002i1evan_snd.wav")
			InputConsole("cmsgt 1 255,255,255 Warning - GDI Helicopter Pad under attack.")
			InputConsole("cmsgt 0 255,255,255 GDI Helicopter Pad under attack.")
			Start_Timer(ID, obj, 60, 1)
		end
	end
end
function G_Helipad_Control:Timer_Expired(ID, obj, num)
	if num == 1 then
		HelipadSystem["Helipad"]["GDI"].Attacked = "no"
	end
end
function G_Helipad_Control:Killed(ID, obj, killer)
	InputConsole("sndt 1 m00bghp_kill0001i1evag_snd.wav")
	InputConsole("sndt 0 m00bghp_kill0002i1evan_snd.wav")
	InputConsole("cmsg 255,255,255 GDI Helicopter Pad destroyed.")
	pos = Get_Position(obj)
	GSound = Create_Object("Invisible_Object", pos)
	Attach_Script(GSound, "G_Helipad_Destroyed", "")
	HelipadSystem["Helipad"]["GDI"].Built = HelipadSystem["Helipad"]["GDI"].Built - 1
end
Register_Script("G_Helipad_Control", "", G_Helipad_Control)

G_Helipad_Destroyed = {}
function G_Helipad_Destroyed:Created(ID, obj)
	Start_Timer(ID, obj, 3, 1)
end
function G_Helipad_Destroyed:Timer_Expired(ID, obj, num)
	if num == 1 then
		InputConsole("snda m00bggt_kill0027i1nsss_snd.wav")
		Start_Timer(ID, obj, 3, 2)
	end
	if num == 2 then
		InputConsole("snda m00bgwf_kill0003i1gbmg_snd.wav")
		Destroy_Object(obj)
	end
end
Register_Script("G_Helipad_Destroyed", "", G_Helipad_Destroyed)

-- Nod Helipad Control Scripts
-- Sounds
-- Nod "Nod Helicopter pad under attack" m00bnhp_tdfe0001i1evan_snd
-- GDI "Nod Helicopter pad under attack" m00bnhp_tdfe0002i1evag_snd
-- Nod "Nod Helicopter pad destroyed" m00bnhp_kill0001i1evan_snd
-- GDI "Nod helicopter pad destroyed" m00bnhp_kill0002i1evag_snd
-- Havoc "So much for the chopper tours" m00bnhp_kill0053i1gbmg_snd
-- Havoc "Try landing on that!" m00bnhp_kill0054i1gbmg_snd
-- Havoc "This is my LZ now, Beat it!" m00bnhp_kill0003i1gbmg_snd

N_Helipad_Control = {}
function N_Helipad_Control:Damaged(ID, obj, shooter, damage)
	if damage > 0 then
		if HelipadSystem["Helipad"]["Nod"].Attacked == "no" then
			HelipadSystem["Helipad"]["Nod"].Attacked = "yes"
			InputConsole("sndt 1 m00bnhp_tdfe0002i1evag_snd.wav")
			InputConsole("sndt 0 m00bnhp_tdfe0001i1evan_snd.wav")
			InputConsole("cmsgt 0 255,255,255 Warning - Nod Helicopter Pad under attack.")
			InputConsole("cmsgt 1 255,255,255 Nod Helicopter Pad under attack.")
			Start_Timer(ID, obj, 60, 1)
		end
	end
end
function N_Helipad_Control:Timer_Expired(ID, obj, num)
	if num == 1 then
		HelipadSystem["Helipad"]["Nod"].Attacked = "no"
	end
end
function N_Helipad_Control:Killed(ID, obj, killer)
	InputConsole("sndt 1 m00bnhp_kill0002i1evag_snd.wav")
	InputConsole("sndt 0 m00bnhp_kill0001i1evan_snd.wav")
	InputConsole("cmsg 255,255,255 Nod Helicopter Pad destroyed.")
	pos = Get_Position(obj)
	NSound = Create_Object("Invisible_Object", pos)
	Attach_Script(NSound, "N_Helipad_Destroyed", "")
	HelipadSystem["Helipad"]["Nod"].Built = HelipadSystem["Helipad"]["Nod"].Built - 1
end
Register_Script("N_Helipad_Control", "", N_Helipad_Control)

N_Helipad_Destroyed = {}
function N_Helipad_Destroyed:Created(ID, obj)
	Start_Timer(ID, obj, 3, 1)
end
function N_Helipad_Destroyed:Timer_Expired(ID, obj, num)
	if num == 1 then
		RandomSound = math.random(1,3)
		if RandomSound == 1 then
			InputConsole("snda m00bnhp_kill0053i1gbmg_snd.wav")
		elseif RandomSound == 2 then
			InputConsole("snda m00bnhp_kill0054i1gbmg_snd.wav")
		elseif RandomSound == 3 then
			InputConsole("snda m00bnhp_kill0003i1gbmg_snd.wav")
		end
		Destroy_Object(obj)
	end
end
Register_Script("N_Helipad_Destroyed", "", N_Helipad_Destroyed)

-- Radiation Scripts
-- Ion

IonRadiationScript = {}
function IonRadiationScript:Created(ID, obj)   
	Start_Timer(ID,obj,0.5, 1)
	Start_Timer(ID,obj,15, 2)
end
function IonRadiationScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		for _,Players in pairs(Get_All_Players()) do
			local distance = Get_Distance(obj, Get_GameObj(Players))
			if distance < 20 then
				Damager = HelipadSystem["Bomb"][obj].pID
				Apply_Damage(Get_GameObj(Players), 3, "IonCannon", Damager)
			end
		end
		for _,Vehicles in pairs(Get_All_Vehicles()) do
			local distance = Get_Distance(obj, Vehicles)
			if distance < 20 then
				Damager = HelipadSystem["Bomb"][obj].pID
				Apply_Damage(Get_GameObj(Vehicles), 3, "IonCannon", Damager)
			end
		end
		Start_Timer(ID,obj,0.5, 1)
	end
	if num == 2 then
		Destroy_Object(obj)
	end
end
Register_Script("IonRadiationScript", "", IonRadiationScript)

-- Nuke

NukeRadiationScript = {}
function NukeRadiationScript:Created(ID, obj)   
	Start_Timer(ID,obj,0.5, 1)
	Start_Timer(ID,obj,15, 2)
end
function NukeRadiationScript:Timer_Expired(ID, obj, num)
	if num == 1 then
		for _,Players in pairs(Get_All_Players()) do
			local distance = Get_Distance(obj, Get_GameObj(Players))
			if distance < 20 then
				Damager = HelipadSystem["Bomb"][obj].pID
				Apply_Damage(Get_GameObj(Players), 3, "Nuke", Damager)
			end
		end
		for _,Vehicles in pairs(Get_All_Vehicles()) do
			local distance = Get_Distance(obj, Vehicles)
			if distance < 20 then
				Damager = HelipadSystem["Bomb"][obj].pID
				Apply_Damage(Get_GameObj(Vehicles), 3, "Nuke", Damager)
			end
		end
		Start_Timer(ID,obj,0.5, 1)
	end
	if num == 2 then
		Destroy_Object(obj)
	end
end
Register_Script("NukeRadiationScript", "", NukeRadiationScript)