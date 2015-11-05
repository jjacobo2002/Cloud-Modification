module('char', package.seeall)

function Command(pID, Message)
	if Message[1] == "!petrova" then
		if user[pID]:HasAccess(1) then
			price = 9000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "Mutant_3Boss_Petrova")
					pObj = Get_GameObj(pID)
					Set_Skin(pObj, "SkinFlesh")
				
				-- Other	--
				InputConsole("snda m00ccsm_kibv0012i1gbrs_snd.wav", pID)
				
				InputConsole("cmsg 0,250,0 %s has bought a petrova!! Shocker alert!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!assassin" then
		if user[pID]:HasAccess(1) then
			price = 15500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "CnC_Nod_FlameThrower_2SF")
					pObj = Get_GameObj(pID)
					Attach_Script(pObj, "changemodel", "trike") 
					Set_Max_Health(pObj, 200)
					Set_Max_Shield_Strength(pObj, 100)
				
				InputConsole("msg %s has bought an assassin! Watch your back, they can insta kill you!", user[pID]:GetName())
				InputConsole("ppage %d To kill someone, get close to them and push 'e', or whatever button you use to access the purchase terminal!", pID)
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!reddwire" then
		if user[pID]:HasAccess(1) then
			price = 12750
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "CnC_Nod_MiniGunner_0_Skirmish")
					pObj = Get_GameObj(pID)
					Grant_Powerup(pObj, "POW_LaserRifle_Player")
					Grant_Powerup(pObj, "POW_LaserChaingun_Player")
					Grant_Powerup(pObj, "POW_Railgun_Player")
					Set_Max_Health(pObj, 600)
					Set_Max_Shield_Strength(pObj, 450)
				
				Random = math.random(1,2)
				if Random == 1 then
					InputConsole("snda m00gnod_gcon0015a2nsrs_snd.wav")
				elseif Random == 2 then
					InputConsole("snda m00ggdi_gcon0002r2gers_snd.wav")
				end
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!fsfox" then
		if user[pID]:HasAccess(1) then
			price = 20000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "CnC_GDI_MiniGunner_2SF")
					pObj = Get_GameObj(pID)
					Set_Max_Shield_Strength(pObj, 0)
					Set_Max_Health(pObj, 1000)
					Grant_Powerup(pObj, "POW_VoltAutoRifle_Player")
					Grant_Powerup(pObj, "POW_Shotgun_Player")  	
					Grant_Powerup(pObj, "POW_Double_Damage")
				
				InputConsole("snda 00-n106e.wav")
				
				InputConsole("cmsg 0,250,0 %s has bought a FsFox! Watch out for obby gun!", user[pID]:GetName())
				InputConsole("msg %s has bought a FsFox! Good luck!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!engie" then
		if user[pID]:HasAccess(1) then
			price = 20000
			if Get_Preset_Name(Get_GameObj(pID)) == "CnC_GDI_Engineer_0" or Get_Preset_Name(Get_GameObj(pID)) == "CnC_Nod_Engineer_0" then
				InputConsole("ppage %d You cannot buy engie", pID)
			else
				pObj = Get_GameObj(pID)
				close = false
				for _,Building in pairs(Get_All_Buildings()) do
					distance = mf.Get_Distance(pObj, Building)
					if distance < 10 then
						if Get_Money(pID) < 0 then
							team = Get_Team(pID)
							if team == Get_Object_Type(Building) then
								if team == 1 then
									Change_Character(pObj,"CnC_GDI_Engineer_0") 
								else
									Change_Character(pObj,"CnC_Nod_Engineer_0")
								end
								InputConsole("ppage %d you have been changed into an engie because you have negative credits and you are close to a building.", pID)
							else
								InputConsole("ppage %d You can't buy this at an enemy building!",pID)
							end
						else
							InputConsole("ppage %d you do not have negative credits.", pID)
						end	
						close = true
						b = Building
						d = distance
					end
				end
				
				if close then
					InputConsole("msg %s is close to a building", user[pID]:GetName()) 
					InputConsole("msg %s is %d away from the %s", user[pID]:GetName(), d, Get_Preset_Name(b))
				else
					InputConsole("ppage %d You're not close to a building", pID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!c4tech" then
		if user[pID]:HasAccess(1) then
			price = 3800
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "civ_lab_tech_03")
					pObj = Get_GameObj(pID)
					Grant_Powerup(pObj, "POW_MineRemote_Player")
					Grant_Powerup(pObj, "POW_MineTimed_Player")
					Grant_Powerup(pObj, "POW_Head_Band")
				
				InputConsole("cmsg 0,250,0 %s has bought an explosive specialist!!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!prisoner" then
		if user[pID]:HasAccess(1) then
			price = 4500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "GDI_Prisoner_v0a")
					pObj = Get_GameObj(pID)
				
				bots.MultiSpawn(pObj, { "Nod_Minigunner_0", "GDI_Minigunner_0" }, 2, 2, 0.1, false, { z_Set_Team=Get_Team(pID) })
				
				InputConsole("cmsg 0,250,0 %s Watch out! If you kill prisoner you get negative points!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!aqollo" then
		if user[pID]:HasAccess(1) then
			price = 15000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "Civ_Male_v5a")
					pObj = Get_GameObj(pID)
					Set_Max_Health(pObj, 500)
					Grant_Powerup(pObj, "POW_TiberiumFlechetteGun_Player")
					Grant_Powerup(pObj, "POW_PersonalIonCannon_Player")
					Grant_Powerup(pObj, "CnC_POW_RepairGun_Player")
					Grant_Powerup(pObj, "CnC_POW_RocketLauncher_Player")
					Grant_Powerup(pObj, "CnC_POW_MineTimed_Player_01")
					Grant_Powerup(pObj, "CnC_POW_MineRemote_02")
					Attach_Script(pObj, "changemodel", "clown") 
					
					
				InputConsole("snda 00-n106e.wav")
				InputConsole("cmsg 0,250,0 %s has bought Aqollo!!! Obby gun!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!ralph" then
		if user[pID]:HasAccess(1) then
			price = 3000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "Farmer")
					pObj = Get_GameObj(pID)
					Grant_Powerup(Get_GameObj(pID), "CnC_POW_IonCannonBeacon_Player")
					
				InputConsole("cmsg 0,250,0 %s has bought a ralph!! Ion beacon alert!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!jumpy" then
		if user[pID]:HasAccess(1) then
			price = 2000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			elseif Get_Preset_Name(Get_GameObj(pID)) == "CnC_Nod_FlameThrower_2SF" then
				InputConsole("ppage %d You cannot buy jumpy with this char.", pID)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "Civ_Resist_Female_v0d")
					pObj = Get_GameObj(pID)
					Grant_Powerup(pObj, "POW_RepairGun_Player")
					Grant_Powerup(pObj, "CnC_MineProximity_05")
					Grant_Powerup(pObj, "POW_Shotgun_Player")
					Attach_Script(pObj, "M00_No_Falling_Damage_DME", "")
					
				InputConsole("cmsg 0,250,0 %s has bought jumpy!! you can jump high!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!spy123321" or Message[1] == "!spy" then
		if user[pID]:HasAccess(1) then
			price = 25000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				pObj = Get_GameObj(pID)
				veh = Get_Vehicle(pObj)
				if veh ~= 0 then
					InputConsole("ppage %d You can't buy a !spy whilst in a vehicle", pID)
				else
					-- Creating the character	--
					Change_Character(pObj, "CnC_Nod_FlameThrower_2SF")
						pObj = Get_GameObj(pID)
						Attach_Script_Once(pObj, "RA_Infantry_Spy", "")
						Set_Max_Shield_Strength(pObj, 75)
						Set_Max_Health(pObj, 200)
						Grant_Powerup(pObj, "POW_PersonalIonCannon_Player")
						Grant_Powerup(pObj, "POW_RepairGun_Player")
						Grant_Powerup(pObj, "CnC_POW_MineRemote_02")
						
					InputConsole("msg %s has bought a spy!!! BASE DEFENSES WILL IGNORE %s .", user[pID]:GetName(), user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!mrmoney" then
		if user[pID]:HasAccess(1) then
			price = 5000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "CnC_Nod_FlameThrower_2SF")
					pObj = Get_GameObj(pID)
					Set_Max_Shield_Strength(pObj, 150)
					Set_Max_Health(pObj, 250)
					Grant_Powerup(pObj, "POW_TiberiumFlechetteGun_Player")
					Grant_Powerup(pObj, "POW_PersonalIonCannon_Player")
					Grant_Powerup(pObj, "POW_Railgun_Player")
					Grant_Powerup(pObj, "POW_RamjetRifle_Player")
					Grant_Powerup(pObj, "POW_VoltAutoRifle_Player")
					Grant_Powerup(pObj, "POW_RepairGun_Player")
					Grant_Powerup(pObj, "POW_ChemSprayer_Player")
					LuS_Attach_Scripts(pObj, { changemodel="mrtickles", JFW_Credit_Trickle="150,30" })
					
				InputConsole("cmsg 0,250,0 %s has bought a mr money!", user[pID]:GetName())
				InputConsole("msg %s will give the team 150 credits for every 30 seconds he is alive!", user[pID]:GetName())
				
				user[vID]:SetMrMoney(true)
				gi.AddCPS(Get_Team(pID), 5)
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!darkorbit" then
		if user[pID]:HasAccess(1) then
			price = 8000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "civ_lab_tech_01")
					pObj = Get_GameObj(pID)
					Grant_Powerup(pObj, "POW_LaserRifle_Player")
					Grant_Powerup(pObj, "POW_SniperRifle_Player")
					Attach_Script(pObj, "changemodel", "dino")
					
				InputConsole("cmsg 0,250,0 %s has bought darkorbit! Watch out for obbygun!", user[pID]:GetName())
				InputConsole("snda 00-n106e.wav")
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!orphan" then
		if user[pID]:HasAccess(1) then
			price = 3000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "Nun")
					pObj = Get_GameObj(pID)
					Grant_Powerup(pObj, "POW_Railgun_Player")
				
				InputConsole("snda m00ccsm_kick0024i1gcc3_snd.wav", pID)
				InputConsole("cmsg 0,250,0 %s has bought Anorphan! How fast can you get!?!?", user[pID]:GetName())
				InputConsole("msg %s has bought Anorphan! How fast can you get!?!?", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!rav" then
		if user[pID]:HasAccess(1) then
			price = 6500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "Mutant_3Boss_Raveshaw")
				
				InputConsole("SNDA m00gsrs_kitb0001i1mein_snd.wav")
				InputConsole("snda 00-n106e.wav")
				InputConsole("cmsg 0,250,0 %s has bought a rav!! obbygun alert!!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!mrmutant" then
		if user[pID]:HasAccess(1) then
			price = 3000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "Mutant_0_GDI")
					pObj = Get_GameObj(pID)
					Set_Max_Health(pObj, 750)
					Grant_Powerup(pObj, "POW_Chaingun_Player_Nod")
					Grant_Powerup(pObj, "POW_GrenadeLauncher_Player")
					Grant_Powerup(pObj, "POW_RepairGun_Player")
					Grant_Powerup(pObj, "POW_ChemSprayer_Player")
				
				InputConsole("snda m00ccsm_kibv0012i1gbrs_snd.wav", pID)
				InputConsole("cmsg 0,250,0 %s has bought a mr. mutant!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!hotwire" then
		if user[pID]:HasAccess(1) then
			price = 1500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			elseif Get_Preset_Name(Get_GameObj(pID)) == "CnC_GDI_Engineer_2SF" then
				InputConsole("ppage %d You can't buy hotwire, you already are!", pID)
			elseif Get_Preset_Name(Get_GameObj(pID)) == "CnC_Nod_Technician_0" then
				InputConsole("ppage %d You can't buy hotwire, you are a tech!", pID)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "CnC_GDI_Engineer_2SF")
				
				InputConsole("cmsg 0,250,0 %s has bought a hotwire!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!tech" then
		if user[pID]:HasAccess(1) then
			price = 1500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			elseif Get_Preset_Name(Get_GameObj(pID)) == "CnC_GDI_Engineer_2SF" then
				InputConsole("ppage %d You can't buy a tech, you are a hotwire!", pID)
			elseif Get_Preset_Name(Get_GameObj(pID)) == "CnC_Nod_Technician_0" then
				InputConsole("ppage %d You can't buy a tech, you already are!", pID)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "CnC_Nod_Technician_0")
				
				InputConsole("cmsg 0,250,0 %s has bought a tech!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!yuri" then
		if user[pID]:HasAccess(1) then
			price = 5000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "CnC_GDI_RocketSoldier_2SF_Secret")
					pObj = Get_GameObj(pID)
				
				InputConsole("cmsg 0,250,0 %s has bought Yuri!!", user[pID]:GetName())
				InputConsole("cmsg 28,145,103 %s can control your mind....", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!sbh" then
		if user[pID]:HasAccess(1) then
			price = 1000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				-- Creating the character	--
				Change_Character(Get_GameObj(pID), "CnC_Nod_FlameThrower_2SF")
				
				InputConsole("snda m00evag_dsgn0008i1evag_snd.wav")
				InputConsole("cmsg 0,250,0 %s has bought a sbh.", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!refundme" then
		if user[pID]:HasAccess(1) then
			local PlayerObj = Get_GameObj(pID)
			local pos1 = Get_Position(PlayerObj)
			for _,Building in pairs(Get_All_Buildings()) do
				local distance = mf.Get_Distance(Get_GameObj(pID), Building)
				if distance < 10 then -- less then 40 meters
					veh = Get_Vehicle(Get_GameObj(pID))
					if veh == 0 then
						if Get_Model(Get_GameObj(pID)) == "c_ag_nod_sniper" then
							if Get_Money(pID) > 10 then
								InputConsole("ppage %d I dont think you really need a refund, do you?", pID)
							else
								InputConsole("cmsg 0,250,0 %s has refunded themselves 10", user[pID]:GetName())
								Set_Money(pID, Get_Money(pID)+10)
								Apply_Damage(Get_GameObj(pID), 9999, "blamokiller", 0)	
							end	
						elseif Get_Preset_Name(Get_GameObj(pID)) == "Civ_Male_v5a" then
							if Get_Money(pID) > 15000 then
								InputConsole("ppage %d I dont think you really need a refund, do you?", pID)
							else	
								InputConsole("cmsg 0,250,0 %s has refunded themselves 15000", user[pID]:GetName())
								Set_Money(pID, Get_Money(pID)+15000)
								Apply_Damage(Get_GameObj(pID), 9999, "blamokiller", 0)
							end
						elseif Get_Preset_Name(Get_GameObj(pID)) == "civ_lab_tech_01" then
							if Get_Money(pID) > 8000 then
								InputConsole("ppage %d I dont think you really need a refund, do you?", pID)
							else
								InputConsole("cmsg 0,250,0 %s has refunded themselves 8000", user[pID]:GetName())
								Set_Money(pID, Get_Money(pID)+8000)
								Apply_Damage(Get_GameObj(pID), 9999, "blamokiller", 0)
							end
						elseif Get_Model(Get_GameObj(pID)) == "mrtickles" or Get_Model(Get_GameObj(pID)) == "MRTICKLES" then
							if Get_Money(pID) > 5000 then
								InputConsole("ppage %d I dont think you really need a refund, do you?", pID)
							else
								InputConsole("cmsg 0,250,0 %s has refunded themselves 5000", user[pID]:GetName())
								Set_Money(pID, Get_Money(pID)+5000)
								Apply_Damage(Get_GameObj(pID), 9999, "blamokiller", 0)	
							end
						elseif Get_Preset_Name(Get_GameObj(pID)) == "Nod_Kane" then
							if Get_Money(pID) > 15000 then
								InputConsole("ppage %d I dont think you really need a refund, do you?", pID)
							else
								InputConsole("cmsg 0,250,0 %s has refunded themselves 15000", user[pID]:GetName())
								Set_Money(pID, Get_Money(pID)+15000)
								Apply_Damage(Get_GameObj(pID), 9999, "blamokiller", 0)
							end
						else
							InputConsole("ppage %d Your character cannot be refunded.", pID)
						end
					else
						InputConsole("ppage %d You can't use this in a veh!", pID)
					end
					
					InputConsole("msg %s is close to a building", user[pID]:GetName()) 
					Console_Input(string.format("msg %s is %d away from the %s", user[pID]:GetName(), distance, Get_Preset_Name(Building)))
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	return false
end

function Robber(kID, kObj, vID)
	if string.lower(Get_Model(kObj)) == "c_ag_nod_kane" then
		--nothing
	end
end

function Assassin(PokerObj, PokedObj)
	pID = Get_Player_ID(PokerObj)
	if string.lower(Get_Preset_Name(PokerObj)) == "cnc_nod_flamethrower_2sf" then
		if string.lower(Get_Model(PokerObj)) == "trike" then
			if Get_Health(PokedObj) ~= 0 then
				if Get_Object_Type(PokerObj) == Get_Object_Type(PokedObj) then
					InputConsole("ppage %d You cannot kill your own team mates!", pID)	
				else
					Apply_Damage(PokedObj, 9999, "shrapnel", PokerObj)
					if Is_A_Star(PokedObj) then
						tID = Get_Player_ID(PokedObj)
						InputConsole("ppage %d You successfully assassinated %s", pID, user[tID]:GetName())
						InputConsole("ppage %d You were assassinated by %s", tID,  user[pID]:GetName())
						
						if Get_Team(tID) == 0 then
							InputConsole("cmsg 250,250,0 %s assassinated %s", user[pID]:GetName(), user[tID]:GetName())
						else
							InputConsole("cmsg 250,0,0 %s assassinated %s", user[pID]:GetName(), user[tID]:GetName())					
						end
						Set_Score(pID, Get_Score(pID)+250)
						Set_Money(pID, Get_Money(pID)+250)
					else
						objname = Get_Preset_Name(PokedObj)
						Set_Score(pID, Get_Score(pID)+50)
						Set_Money(pID, Get_Money(pID)+50)
						InputConsole("ppage %d You successfully assassinated a %s", pID, objname)
					end
					--Set_cPlayer(pID, {Kills = Get_Kills(pID)+1})
				end
			end
		end
	end
end

function Yuri(VictimObj, KillerObj)
	veh = Get_Vehicle(KillerObj)
	pID = Get_Player_ID(KillerObj)
	
	if veh == 0 then
		pos = Get_Position(VictimObj)
		preset = Get_Preset_Name(VictimObj)
		Facing = Get_Facing(VictimObj)
		model = Get_Model(VictimObj)
		maxhealth = Get_Max_Health(VictimObj)
		maxarmor = Get_Max_Shield_Strength(VictimObj)
		team = Get_Team(pID)
		
		bot = Create_Object(preset, mf.CalcPos(pos, Facing, 0, {Z=0.2}))
			Set_Facing(bot, Facing)
			Set_Max_Health(bot, maxhealth)
			Set_Max_Shield_Strength(bot, maxarmor)
		
		LuS_Attach_Scripts(bot, { lus_damaged="", lus_poked="", changemodel=model, z_Set_Team=team, M05_Nod_Gun_Emplacement="", M01_Hunt_The_Player_JDG=""})
	else
		InputConsole("ppage %d You cannot mindcontrol in a vehicle.", pID)
	end
end
