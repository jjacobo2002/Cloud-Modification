function OnChat(pID, Type, Message, Target)
--	if Message == "!cmsghelp" then
--		InputConsole("pamsg %d Colors: cyan, green, yellow, purple, orange, blue, red, random. !cmsg <color> <message> ", pID)
--		InputConsole("pamsg %d For locking your color: Colors: cyan, green, yellow, purple, orange, blue, red, random. !cmsglock <color>. Type !cmsgunlock to go back to normal. ", pID)	
--	end
--extra extras powerups upgrades commands other gamble
	
	------------------------------
	-- VIP Extra's ---------------
	------------------------------
--[[
	if Message == "!caspa" then
		if user[pID]['access'] >= 1 then
			if user[pID]['vip'] == 1 then
				if Get_Money(pID) > 5800 then
					InputConsole("msg %s has bought a caspa! :D",sName)
					Set_Money(pID, Get_Money(pID)-5800)
					Change_Character(Get_GameObj(pID), "CnC_Nod_FlameThrower_3Boss")
					Attach_Script(Get_GameObj(pID), "spawnarmy", "")
					Grant_Powerup(Get_GameObj(pID), "POW_SniperRifle_Player")
					Grant_Powerup(Get_GameObj(pID), "POW_PersonalIonCannon_Player")
					Grant_Powerup(Get_GameObj(pID), "POW_LaserChaingun_Player")
					Grant_Powerup(Get_GameObj(pID), "POW_LaserRifle_Player")
					Grant_Powerup(Get_GameObj(pID), "POW_TiberiumFlechetteGun_Player")
				else
					if Get_Team(pID) == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
					end	
					InputConsole("ppage %d You need 5800 credits to buy a caspa!", pID)
				end
			else 
				InputConsole("ppage %d Sign up for the premium package to use this command! !packagehelp", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command, because your not logged in.", pID)
		end
	end
]]

	------------------------------
	-- Mod Stuff -----------------
	------------------------------

--- Scripts	---

spawnarmy = {}
function spawnarmy:Killed(ID, obj, killer)
	if Get_Object_Type(obj) == 0 then
		local pos = Get_Position(obj)
		local Facing = Get_Facing(obj)
		local Distance = 0 --the distance, of how far to create the object from the player.
		pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
		pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
		pos.Z = pos.Z + 1
		pos.Y = pos.Y - 3
		turret = Create_Object("Nod_Minigunner_0", pos)
		pos.Z = pos.Z + 1
		pos.Y = pos.Y + 1
		turret = Create_Object("Nod_Minigunner_1Off", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X - 2	
		pos.Y = pos.Y + 1
		turret = Create_Object("Nod_Minigunner_0", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X - 1
		pos.Y = pos.Y + 1
		turret = Create_Object("Nod_Minigunner_0", pos)
		pos.X = pos.X - 2
		pos.Y = pos.Y - 1
		turret = Create_Object("Nod_Minigunner_0", pos)
		pos.Y = pos.Y - 2
		turret = Create_Object("Nod_Minigunner_0", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X + 3
		pos.Y = pos.Y - 2
		turret = Create_Object("Nod_RocketSoldier_0", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X - 3
		pos.Y = pos.Y + 2
		turret = Create_Object("Nod_RocketSoldier_0", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X + 2
		pos.Y = pos.Y + 3
		turret = Create_Object("Nod_Minigunner_0", pos)
		pos.X = pos.X - 3
		pos.Y = pos.Y + 4
		turret = Create_Object("Nod_Minigunner_0", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X - 4
		pos.Y = pos.Y - 2
		turret = Create_Object("Nod_Minigunner_0", pos)
	elseif Get_Object_Type(obj) == 1 then
		local pos = Get_Position(obj)
		local Facing = Get_Facing(obj)
		local Distance = 0 --the distance, of how far to create the object from the player.
		pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
		pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
		pos.Z = pos.Z + 1
		pos.Y = pos.Y - 3
		turret = Create_Object("GDI_Minigunner_0", pos)
		pos.Z = pos.Z + 1
		pos.Y = pos.Y + 1
		turret = Create_Object("GDI_Minigunner_1Off", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X - 2
		pos.Y = pos.Y + 1
		turret = Create_Object("GDI_Minigunner_0", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X - 1
		pos.Y = pos.Y + 1
		turret = Create_Object("GDI_Minigunner_0", pos)
		pos.X = pos.X - 2
		pos.Y = pos.Y - 1
		turret = Create_Object("GDI_RocketSoldier_0", pos)
		pos.Y = pos.Y - 2
		turret = Create_Object("GDI_Minigunner_0", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X + 3
		pos.Y = pos.Y - 2
		turret = Create_Object("GDI_RocketSoldier_0", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X - 3
		pos.Y = pos.Y + 2
		turret = Create_Object("GDI_Minigunner_0", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X + 2
		pos.Y = pos.Y + 3
		turret = Create_Object("GDI_Minigunner_0", pos)
		pos.X = pos.X - 3
		pos.Y = pos.Y + 4
		turret = Create_Object("GDI_Minigunner_0", pos)
		pos.Z = pos.Z + 1
		pos.X = pos.X - 4
		pos.Y = pos.Y - 2
		turret = Create_Object("GDI_Minigunner_0", pos)
	end	
end
Register_Script("spawnarmy", "", spawnarmy)

mindcontrol = {}
function mindcontrol:Killed(ID, obj, killer)
	if Get_Preset_Name(killer) == "CNC_GDI_Gun_Emplacement" then
		if Get_Model(killer) == "w_gdi_tlgn" or Get_Model(killer) == "W_GDI_TLGN" then
			if Get_Max_Health(killer) == 1999 then
				local pos = Get_Position(obj)
				local preset = Get_Preset_Name(obj)
				pos.Z = pos.Z + 1
				pos.Y = pos.Y + 1   
				local turret = Create_Object(preset, pos)
				Attach_Script(turret, "M05_Nod_Gun_Emplacement", "")
				Attach_Script(turret, "z_Set_Team", 1)
				Attach_Script(turret, "M01_Hunt_The_Player_JDG", "")
				--Attach_Script(turret, "JFW_Hunt_Attack", 30)
			else
				local pos = Get_Position(obj)
				local preset = Get_Preset_Name(obj)
				pos.Z = pos.Z + 1
				pos.Y = pos.Y + 1
				local turret = Create_Object(preset, pos)
				Attach_Script(turret, "M05_Nod_Gun_Emplacement", "")
				Attach_Script(turret, "z_Set_Team", 0)
				Attach_Script(turret, "M01_Hunt_The_Player_JDG", "")
				--Attach_Script(turret, "JFW_Hunt_Attack", 30)
			end
		end
	end
end
Register_Script("mindcontrol", "", mindcontrol)

--m00evan_dsgn0060i1evan_snd is cloud sound