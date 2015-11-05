module('vip', package.seeall)

function Command(pID, Message)
	if Message[1] == "!bonuscreds" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				if user[pID]:HasBonusCreds() then
					user[pID]:SetBonusCreds(false)
					InputConsole("ppage %d You deactivated your bonuscreds. No +5 creds/sec for your team.", pID)
				else
					user[pID]:SetBonusCreds(true)
					InputConsole("ppage %d Your team now gains +5 creds/sec!", pID)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!vipvehregen" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 5000
				if Get_Money(pID) < price then
					if Get_Team(pID) == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					end				
					InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
				else
					veh = Get_Vehicle(Get_GameObj(pID))
					if veh == 0 then
						InputConsole("ppage %d You need to be in a vehicle to buy the vipvehregen", pID)
					else
						if Is_Script_Attached(veh, "JFW_Health_Regen") then
							InputConsole("ppage %d This vehicle already has a regen", pID)
						else
							Attach_Script_Once(veh, "JFW_Health_Regen", "1,1,10")
							Attach_Script_Once(veh, "JFW_Armour_Regen", "1,1,10")
							InputConsole("cmsg 250,250,0 %s has bought a vehregen!", user[pID]:GetName())
							Set_Money(pID, Get_Money(pID)-price)
							gi.AddMoneySpend(user[pID]:GetName(), price)
						end
					end
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!vipgamble" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 2000
				tgwait = 60
				
				gamble_allow = user[pID]:GetLastVipGamble() + tgwait
				
				if os.time() >= gamble_allow then
					if Get_Money(pID) < price then
						InputConsole("ppage %d You need %d credits before you can use vipgamble.", pID, price)
					else
						credits = math.random(-2550,5000)
						if credits < 0 then
							Set_Money(pID, Get_Money(pID)-500)
							InputConsole("ppage %d You lost, bonus loss of -500 :)", pID)
						end
						Set_Money(pID, Get_Money(pID)+credits) 
						InputConsole("ppage %d You got %d credits", pID, credits)
						user[pID]:SetLastVipGamble(os.time())
					end
				else
					left = gamble_allow - os.time()
					InputConsole("ppage %d You need to wait %d more seconds till you can use vipgamble.", pID, left)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!upx10" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 5500
				if Get_Money(pID) < price then
					if Get_Team(pID) == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					end				
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					pObj = Get_GameObj(pID)
					if Get_Preset_Name(Get_GameObj(pID)) == "GDI_Prisoner_v0a" and Get_Health(Get_GameObj(pID)) >= 800 then
						InputConsole("ppage %d You cannot use !upx10 on prisoner anymore. Try !up.", pID)
					else
						for i=1, 10 do
							Grant_Powerup(pObj, "POW_Tiberium_Shield") 
							Grant_Powerup(pObj, "POW_Tiberium_Shield") 
							Grant_Powerup(pObj, "POW_Health_025")  
							Grant_Powerup(pObj, "POW_Armor_025") 
						end
					
						InputConsole("cmsg 0,250,0 %s has bought a health and armor upgrade X 10!!! PREMIUM ONLY", user[pID]:GetName())
						Set_Money(pID, Get_Money(pID)-price)
						gi.AddMoneySpend(user[pID]:GetName(), price)
					end
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!hummerbot" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 2800
				team = Get_Team(pID)
				if team == 1 then
					if Get_Money(pID) < price then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)		
						InputConsole("ppage %d You need %d credits", pID, price)
					else
						pObj = Get_GameObj(pID)
						Facing = Get_Facing(pObj)
						pos = Get_Position(pObj)
						
						tankbot = Create_Object("CnC_Nod_Buggy", mf.CalcPos(pos, Facing, 7, {Z=3}))
							Set_Model(tankbot, "v_gdi_humvee")
							
						LuS_Attach_Scripts(tankbot, { lus_damaged="", lus_killed="", z_Set_Team=team, JFW_Base_Defence="5,999,20", M01_Hunt_The_Player_JDG="", M00_Disable_Transition="" })
						
						InputConsole("cmsg 0,250,0 %s has bought a health and armor upgrade X 10!!! PREMIUM ONLY", user[pID]:GetName())
						Set_Money(pID, Get_Money(pID)-price)
						gi.AddMoneySpend(user[pID]:GetName(), price)
					end
				else
					InputConsole("ppage %d You need to be on GDI.", pID)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!buggybot" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 2800
				team = Get_Team(pID)
				if team == 0 then
					if Get_Money(pID) < price then
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)		
						InputConsole("ppage %d You need %d credits", pID, price)
					else
						pObj = Get_GameObj(pID)
						Facing = Get_Facing(pObj)
						pos = Get_Position(pObj)
						
						tankbot = Create_Object("CnC_Nod_Buggy", mf.CalcPos(pos, Facing, 7, {Z=3}))
							
						LuS_Attach_Scripts(tankbot, { lus_damaged="", lus_killed="", z_Set_Team=team, JFW_Base_Defence="5,999,20", M01_Hunt_The_Player_JDG="", M00_Disable_Transition="" })
						
						InputConsole("cmsg 0,250,0 %s has bought a health and armor upgrade X 10!!! PREMIUM ONLY", user[pID]:GetName())
						Set_Money(pID, Get_Money(pID)-price)
						gi.AddMoneySpend(user[pID]:GetName(), price)
					end
				else
					InputConsole("ppage %d You need to be on Nod.", pID)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!elitesquad" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 25000
				team = Get_Team(pID)
				if Get_Money(pID) < price then
					if team == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					end				
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					Bots = { "Mutant_3Boss_Raveshaw", "Mutant_3Boss_Raveshaw", "civ_lab_tech_01", "civ_lab_tech_01", "Mutant_3Boss_Petrova", "Mutant_3Boss_Petrova" }
							
					bots.MultiSpawn(Get_GameObj(pID), Bots, table.maxn(Bots), 3, 0.5, false, { z_Set_Team=team, lus_damaged="", lus_poked="", lus_killed="" })
					
					InputConsole("cmsg 0,250,250 %s has bought an elite squad!!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!shockerbot" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 4500
				if Get_Money(pID) < price then
					if Get_Team(pID) == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					end				
					InputConsole("ppage %d You need %d credits", pID, price)
				else							
					MultiSpawn(Get_GameObj(pID), "civ_lab_tech_01", 2, 2, 0.5, false, { z_Set_Team=team, lus_damaged="", lus_poked="", lus_killed="", changemodel="dino" })
					
					InputConsole("cmsg 0,250,0 %s has bought a shocker bot!!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!anti-everything-tower" or Message[1] == "!ae" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 35000
				team = Get_Team(pID)
				if Get_Money(pID) < price then
					if team == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					end				
					InputConsole("ppage %d You need %d credits", pID, price)
				else							
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					base = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 0, {Z=-5}))
						Set_Model(base, "dsp_tower2")
						Set_Max_Health(base, 850)
					
					laser1 = Create_Object("M11_Nod_Ceiling_Gun", mf.CalcPos(pos, Facing, 0, {Z=3, Y=2}))
						Set_Skin(laser1, "blamo")
						
					laser2 = Create_Object("M11_Nod_Ceiling_Gun", mf.CalcPos(pos, Facing, 0, {Z=3, Y=-2}))
						Set_Skin(laser2, "blamo")
						
					laser3 = Create_Object("M11_Nod_Ceiling_Gun", mf.CalcPos(pos, Facing, 0, {Z=3, X=2}))
						Set_Skin(laser3, "blamo")
						
					laser4 = Create_Object("M11_Nod_Ceiling_Gun", mf.CalcPos(pos, Facing, 0, {Z=3, X=-2}))
						Set_Skin(laser4, "blamo")
						
					
					-- Attaching the scripts	--
					LuS_Attach_Scripts(base, { lus_damaged="", z_Set_Team=team, JFW_Death_Destroy_Object={laser1, laser2, laser3, laser4}, M00_Disable_Transition="5,100,1" })
					LuS_Attach_Scripts(laser1, { z_Set_Team=team, JFW_Base_Defence="5,800,20" })
					LuS_Attach_Scripts(laser2, { z_Set_Team=team, JFW_Base_Defence="5,800,20" })
					LuS_Attach_Scripts(laser3, { z_Set_Team=team, JFW_Base_Defence="5,800,20" })
					LuS_Attach_Scripts(laser4, { z_Set_Team=team, JFW_Base_Defence="5,800,20" })
					
					-- Other	--
					Disable_Physical_Collisions(base)
					
					InputConsole("msg %s has bought an anti-everything tower! ", user[pID]:GetName())
					InputConsole("msg Ceiling guns will own you!")
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!g3" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				if Get_Team(pID) == 1 then
					price = 4500
					if Get_Money(pID) < price then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
						InputConsole("ppage %d You need %d credits", pID, price)
					else
						pObj = Get_GameObj(pID)
						pos = Get_Position(pObj)
						Facing = Get_Facing(pObj)
					
						-- Creating the objects	--
						g = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=6}))
							Set_Max_Health(g, 500)
						
						weapon1 = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=6.1, X=1.5}))
							Set_Model(weapon1, "w_gdi_tlgn")
							Set_Skin(weapon1, "blamo")
							
						weapon2 = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=6.1, X=-1.5}))
							Set_Model(weapon2, "w_gdi_tlgn")
							Set_Skin(weapon2, "blamo")
							
						weapon3 = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=4.1, X=-2.5}))
							Set_Model(weapon3, "w_gdi_tlgn")
							Set_Skin(weapon3, "blamo")
							
						weapon4 = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=4.1, X=3}))
							Set_Model(weapon4, "w_gdi_tlgn")
							Set_Skin(weapon4, "blamo")
							
						weapon5 = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=4.1, Y=3}))
							Set_Model(weapon5, "w_gdi_tlgn")
							Set_Skin(weapon5, "blamo")
							
						weapon6 = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=4.1, Y=-2.5}))
							Set_Model(weapon6, "w_gdi_tlgn")
							Set_Skin(weapon6, "blamo")
						
						-- Attaching the scripts	--
						LuS_Attach_Scripts(g, { lus_damaged="", JFW_Death_Destroy_Object={weapon1, weapon2, weapon3, weapon4, weapon5, weapon6} })
						
						-- Other	--
						Disable_Physical_Collisions(g)
						
						InputConsole("msg %s has bought a guard tower version 3.0!!", user[pID]:GetName())
						Set_Money(pID, Get_Money(pID)-price)
						gi.AddMoneySpend(user[pID]:GetName(), price)
					end
				else
					InputConsole("ppage %d You need to be on GDI", pID)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!t3" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				if Get_Team(pID) == 0 then
					price = 4500
					if Get_Money(pID) < price then
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
						InputConsole("ppage %d You need %d credits", pID, price)
					else					
						pObj = Get_GameObj(pID)
						pos = Get_Position(pObj)
						Facing = Get_Facing(pObj)
					
						-- Creating the objects	--
						turret = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=0.5}))
							Set_Max_Health(turret, 500)
						weapon1 = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=3}))
							Set_Model(weapon1, "w_gdi_tlgn")
							Set_Skin(weapon1, "blamo")
						weapon2 = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=3.5}))
							Set_Model(weapon2, "w_gdi_tlgn")
							Set_Skin(weapon2, "blamo")
						weapon3 = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=0.5, X=2}))
							Set_Model(weapon3, "w_gdi_tlgn")
							Set_Skin(weapon3, "blamo")
						weapon4 = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=0.5, X=-2}))
							Set_Model(weapon4, "w_gdi_tlgn")
							Set_Skin(weapon4, "blamo")
						weapon5 = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=0.5, Y=2}))
							Set_Model(weapon5, "w_gdi_tlgn")
							Set_Skin(weapon5, "blamo")
						weapon6 = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=0.5, Y=-2}))
							Set_Model(weapon6, "w_gdi_tlgn")
							Set_Skin(weapon6, "blamo")
							
						-- Attaching the scripts	--
						LuS_Attach_Scripts(turret, { lus_damaged="", JFW_Death_Destroy_Object={weapon1, weapon2, weapon3, weapon4, weapon5, weapon6} })
						
						-- Other	--
						Disable_Physical_Collisions(turret)
						
						InputConsole("msg %s has bought a turret version 3.0!!", user[pID]:GetName())
						Set_Money(pID, Get_Money(pID)-price)
						gi.AddMoneySpend(user[pID]:GetName(), price)
					end
				else
					InputConsole("ppage %d You need to be on Nod.", pID)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!ambush" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 6000
				team = Get_Team(pID)
				if Get_Money(pID) < price then
					if team == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					end				
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					if Message[2] == nil then
						InputConsole("ppage %d You can't ambush no-one! Fill in a nickname (!ambush <player>)", pID)
					else
						tID = mf.FindPlayer("ID", Message[2])
						if tID == "Many" then
							InputConsole("ppage %d This playername is not unique.", pID)
						elseif tID == "None" then
							InputConsole("ppage %d This player does not exist or is not ingame.", pID)
						elseif Get_Team(tID) == team then
							InputConsole("ppage %d You can't ambush a team-mate!", pID)
						else
							tObj = Get_GameObj(tID)
							veh = Get_Vehicle(tObj)
							if veh == 0 then
								Obj = tObj
								Distance = 2
							else
								Obj = veh
								Distance = 4
							end
							
							bots.MultiSpawn(Obj, "CnC_Nod_FlameThrower_2SF", 4, Distance, 0.1, false, { z_Set_Team=team, lus_damaged="", lus_poked="", lus_killed="", M05_Nod_Gun_Emplacement="", M01_Hunt_The_Player_JDG="" })
						
							InputConsole("msg %s has bought an ambush on %s!!!", user[pID]:GetName(), user[tID]:GetName())
						
							Set_Money(pID, Get_Money(pID)-price)
							gi.AddMoneySpend(user[pID]:GetName(), price)
						end
					end
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!zombiesuit" or Message[1] == "!zs" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 1500
				if Get_Money(pID) < price then
					if Get_Team(pID) == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					end				
					InputConsole("ppage %d You need %d credits", pID, price)
				elseif user[pID]:HasZombiesuit() then
					InputConsole("ppage %d You already have a zombiesuit!", pID)
				else
					user[pID]:SetZombiesuit(true)
					InputConsole("msg %s has bought a zombie suit! Will spawn a bot on death!", user[pID]:GetName())
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!advancedguardobby" or Message[1] == "!ago" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				price = 45000
				team = Get_Team(pID)
				if Get_Money(pID) < price then
					if team == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					end				
					InputConsole("ppage %d You need %d credits", pID, price)
				else							
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					control = Create_Object("GDI Gunboat", mf.CalcPos(pos, Facing, 0, {Z=3, X=4.5}))
						Set_Model(control, "dsp_lockers")
						Set_Max_Health(control, 150)
						Set_Max_Shield_Strength(control, 200)
						Set_Skin(control, "CNCStructureLight")
						Set_Shield_Type(control, "CNCStructureLight")
					
					c1 = Create_Object("M09_Rnd_Door", mf.CalcPos(pos, Facing, 0, {Z=5}))
						Set_Model(c1, "dsp_container")
						Set_Skin(c1, "blamo")
						
					c2 = Create_Object("M09_Rnd_Door", mf.CalcPos(pos, Facing, 0, {Z=5, X=3}))
						Set_Model(c2, "dsp_container")
						Set_Skin(c2, "blamo")
						
					c3 = Create_Object("M09_Rnd_Door", mf.CalcPos(pos, Facing, 0, {Z=5, X=6}))
						Set_Model(c3, "dsp_container")
						Set_Skin(c3, "blamo")
						
					c4 = Create_Object("M09_Rnd_Door", mf.CalcPos(pos, Facing, 0, {Z=5, X=9}))
						Set_Model(c4, "dsp_container")
						Set_Skin(c4, "blamo")
						
					w1 = Create_Object("GDI_Ceiling_Gun_AGT", mf.CalcPos(pos, Facing, 0, {Z=4}))
						Set_Skin(w1, "blamo")
						
					w2 = Create_Object("GDI_Ceiling_Gun_AGT", mf.CalcPos(pos, Facing, 0, {Z=4, X=9}))
						Set_Skin(w2, "blamo")
						
					w3 = Create_Object("GDI_Ceiling_Gun_AGT", mf.CalcPos(pos, Facing, 0, {Z=4, X=4.5, Y=4}))
						Set_Skin(w3, "blamo")
					
					w4 = Create_Object("GDI_Ceiling_Gun_AGT", mf.CalcPos(pos, Facing, 0, {Z=4, X=4.5, Y=-4}))
						Set_Skin(w4, "blamo")
						
					obby = Create_Object("M09_Rnd_Door", mf.CalcPos(pos, Facing, 0, {Z=9, X=4.5}))
						Set_Model(obby, "dsp_ltrod")
						Set_Skin(obby, "blamo")
						
					obbywep = Create_Object("Nod_Obelisk", mf.CalcPos(pos, Facing, 0, {Z=12.5, X=4.5}))
						Set_Skin(obby, "blamo")
					
					-- Attaching the scripts	--
					LuS_Attach_Scripts(control, { z_Set_Team=team, lus_damaged="", JFW_Death_Destroy_Object={c1, c2, c3, c4, w1, w2, w3, w4, obby, obbywep} })
					LuS_Attach_Scripts(w1, { z_Set_Team=team, JFW_Base_Defence="5,999,20" })
					LuS_Attach_Scripts(w2, { z_Set_Team=team, JFW_Base_Defence="5,999,20" })
					LuS_Attach_Scripts(w3, { z_Set_Team=team, JFW_Base_Defence="5,999,20" })
					LuS_Attach_Scripts(w4, { z_Set_Team=team, JFW_Base_Defence="5,999,20" })
					LuS_Attach_Scripts(obbywep, { z_Set_Team=team, JFW_Base_Defence="5,999,20", M01_Hunt_The_Player="" })
					
					-- Other	--
					
					InputConsole("msg %s has bought an advanced guard obelisk! Kill the control center!", user[pID]:GetName())
					InputConsole("snda c&c cloaking.wav")
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need premium access to use this command. Use !premiumhelp for more info!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	return false
end

function ZombieSuit(pID, pObj)
	--if Get_Model(obj) == "DSP_BEAKER" or Get_Model(obj) == "DSP_DESK" or Get_Model(obj) == "DSP_BOOKSHELF" or Get_Model(obj) ==  "DSP_BUNKBEDS" or Get_Model(obj) ==  "DSP_COUCH" or Get_Model(obj) ==  "DSP_COUCH3" or Get_Model(obj) ==  "DSP_COUCH4" or Get_Model(obj) ==  "DSP_CRYOBIG" or Get_Model(obj) ==  "DSP_FIRESIGN" or Get_Model(obj) ==  "DSP_GASCAN" or Get_Model(obj) ==  "DSP_SEABUOY" or Get_Model(obj) ==  "DSP_TIBTREE2" or Get_Model(obj) ==  "DSP_TOILET" or Get_Model(obj) ==  "DSP_TVMONITOR" or Get_Model(obj) ==  "DSP_URINAL" or Get_Model(obj) ==  "DSP_VENDING" then
	
	pos = Get_Position(pObj)
	preset = Get_Preset_Name(pObj)
	Facing = Get_Facing(pObj)
	model = Get_Model(pObj)
	team = Get_Team(pID)
		
	bot = Create_Object(preset, mf.CalcPos(pos, Facing, 0, {Z=0.2}))
		Set_Facing(bot, Facing)
		
	LuS_Attach_Scripts(bot, { lus_damaged="", lus_poked="", changemodel=model, z_Set_Team=team, M05_Nod_Gun_Emplacement="", M01_Hunt_The_Player_JDG=""})
end
