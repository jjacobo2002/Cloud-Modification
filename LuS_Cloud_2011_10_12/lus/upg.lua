module('upg', package.seeall)

function Command(pID, Message)
	-- Weapons	--
	if Message[1] == "!rail" then
		if user[pID]:HasAccess(1) then
			price = 600
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a rockin rail!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_Railgun_Player")  
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
				end				
				InputConsole("ppage %d You need %d credits for a Railgun", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!commandopack" then
		if user[pID]:HasAccess(1) then
			price = 7500
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a commando pack!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_Double_Damage")
				Grant_Powerup(Get_GameObj(pID), "POW_SniperRifle_Player")
				Grant_Powerup(Get_GameObj(pID), "POW_Railgun_Player")
				Grant_Powerup(Get_GameObj(pID), "CnC_POW_MineRemote_02")
				Grant_Powerup(Get_GameObj(pID), "POW_RepairGun_Player")
				InputConsole("snda 00-n106e.wav")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a commando pack!", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!technopack" then
		if user[pID]:HasAccess(1) then
			price = 4000
			if Get_Money(pID) >= price then
				InputConsole("msg %s has bought a TechnoPack! Max Ammo! ", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				Grant_Powerup(Get_GameObj(pID), "POW_RocketLauncher_Player") -- Rocket
				Grant_Powerup(Get_GameObj(pID), "POW_RamjetRifle_Player") -- Ramjet
				Grant_Powerup(Get_GameObj(pID), "POW_LaserRifle_Player") -- Lasergun
				Grant_Powerup(Get_GameObj(pID), "CnC_POW_VoltAutoRifle_Player_Nod") -- Volt (Problem, fix if possible)
				Grant_Powerup(Get_GameObj(pID), "CnC_POW_RepairGun_Player") -- Repair gun
				Grant_Powerup(Get_GameObj(pID), "CnC_MineProximity_05") -- Proxy (I think this is correct, if not please correct)
				Grant_Powerup(Get_GameObj(pID), "CnC_POW_MineRemote_02") -- Having issues with this, remote c4 please fix.
				Grant_Powerup(Get_GameObj(pID), "CnC_POW_Ammo_ClipMax") -- Sets ammo to max.
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy !technopack.", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!volt" then
		if user[pID]:HasAccess(1) then
			price = 600
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a volt!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_VoltAutoRifle_Player") 

				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a volt", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!remote" then
		if user[pID]:HasAccess(1) then
			price = 2000
			if Get_Money(pID) > price then 
				InputConsole("msg %s has bought remotes!! Check your buildings!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "CnC_POW_MineRemote_02")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for remotes", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!proxy" then
		if user[pID]:HasAccess(1) then
			price = 350
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought proxys!!!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "CnC_MineProximity_05")

				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for proxy", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!shotgun" then
		if user[pID]:HasAccess(1) then
			price = 50
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a scary shotgun!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_Shotgun_Player")

				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a shotgun", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!sniper" then
		if user[pID]:HasAccess(1) then
			price = 400
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a sniper!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_SniperRifle_Player")
				InputConsole("snda mx0_trooper2_32.wav")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a sniper", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!ramjet" then
		if user[pID]:HasAccess(1) then
			price = 700
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a ramjet!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_RamjetRifle_Player")

				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a ramjet", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!flamethrower" then
		if user[pID]:HasAccess(1) then
			price = 50
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a flamethrower!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				Grant_Powerup(Get_GameObj(pID), "POW_Flamethrower_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a FlameThrower", pID, price) 
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!laser" then
		if user[pID]:HasAccess(1) then
			price = 450
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a laser gun!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_LaserRifle_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a LaserRifle", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!lcg" then
		if user[pID]:HasAccess(1) then
			price = 750
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a laser chain gun!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_LaserChaingun_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a LaserRifle", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!grenade" then
		if user[pID]:HasAccess(1) then
			price = 100
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a grenade!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_GrenadeLauncher_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a grenade", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!repair" then
		if user[pID]:HasAccess(1) then
			price = 200
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a repair!!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_RepairGun_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a repair gun.", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!megarepair" then
		if user[pID]:HasAccess(1) then
			price = 1500
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a super repair!!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "CnC_POW_RepairGun_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a super repair gun.", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!chem" then
		if user[pID]:HasAccess(1) then
			price = 100
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a chemsprayer!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_ChemSprayer_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a chemsprayer", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!tibgun" then
		if user[pID]:HasAccess(1) then
			price = 500
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a Flechettegun!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_TiberiumFlechetteGun_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a flechette", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!rocket" then
		if user[pID]:HasAccess(1) then
			price = 300
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a rocket launcher!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "CnC_POW_RocketLauncher_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a rocket", pID, price) 
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!rifle" then
		if user[pID]:HasAccess(1) then
			price = 50
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a rifle!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_AutoRifle_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a rifle", pID, price) 
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!tibrifle" then
		if user[pID]:HasAccess(1) then
			price = 200
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a tibrifle!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_TiberiumAutoRifle_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for a tibrifle", pID, price) 
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!pic" then
		if user[pID]:HasAccess(1) then
			price = 600
			if Get_Money(pID) >= price then 
				InputConsole("msg %s has bought a personal ioncannon!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price) 
				Grant_Powerup(Get_GameObj(pID), "POW_PersonalIonCannon_Player")
				
				gi.AddMoneySpend(user[pID]:GetName(), price)
			else 
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits for an personal ioncannon", pID, price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end

	-- Regens	--
	if Message[1] == "!fastregen" then
		if user[pID]:HasAccess(1) then
			price = 1000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "0.5,0.05,1")
				InputConsole("cmsg 250,250,0 %s has bought a regen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!fastvehregen" then
		if user[pID]:HasAccess(1) then
			price = 2500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Pilot_Repair", ".5,3,2")
				InputConsole("cmsg 250,250,0 %s has bought a vehregen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!fastvehregen2" then
		if user[pID]:HasAccess(1) then
			price = 4500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Pilot_Repair", ".5,3,5")
				InputConsole("cmsg 250,250,0 %s has bought a vehregen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!bothregen" then
		if user[pID]:HasAccess(1) then
			price = 1000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "2,5,2")
				Attach_Script_Once(Get_GameObj(pID), "JFW_Armour_Regen", "2,5,2")
				InputConsole("cmsg 250,250,0 %s has bought a regen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!bothregen2" then
		if user[pID]:HasAccess(1) then
			price = 2500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "1.5,2,6")
				Attach_Script_Once(Get_GameObj(pID), "JFW_Armour_Regen", "1.5,2,6")
				InputConsole("cmsg 250,250,0 %s has bought a regen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!fastregen2" then
		if user[pID]:HasAccess(1) then
			price = 2000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "0.5,0.05,1")
				Attach_Script_Once(Get_GameObj(pID), "JFW_Armour_Regen", "0.5,0.05,1")
				InputConsole("cmsg 250,250,0 %s has bought a regen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!fastregen3" then
		if user[pID]:HasAccess(1) then
			price = 3000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "0.4,0.04,2")
				Attach_Script_Once(Get_GameObj(pID), "JFW_Armour_Regen", "0.4,0.04,2")
				InputConsole("cmsg 250,250,0 %s has bought a regen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!lowvehregen" then
		if user[pID]:HasAccess(1) then
			price = 1500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Pilot_Repair", "5,2,5")
				InputConsole("cmsg 250,250,0 %s has bought a vehregen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!medvehregen" then
		if user[pID]:HasAccess(1) then
			price = 2500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Pilot_Repair", "2,1,10")
				InputConsole("cmsg 250,250,0 %s has bought a vehregen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!highvehregen" then
		if user[pID]:HasAccess(1) then
			price = 5500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Pilot_Repair", "1,3,20")
				InputConsole("cmsg 250,250,0 %s has bought a vehregen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!lowregen" then
		if user[pID]:HasAccess(1) then
			price = 500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "2,5,2")
				InputConsole("cmsg 250,250,0 %s has bought a regen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!medregen" then
		if user[pID]:HasAccess(1) then
			price = 1500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "2,2,5")
				Attach_Script_Once(Get_GameObj(pID), "JFW_Armour_Regen", "2,2,5")
				InputConsole("cmsg 250,250,0 %s has bought a regen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!highregen" then
		if user[pID]:HasAccess(1) then
			price = 3800
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits to buy a regen", pID, price)
			else
				Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "1,3,20")
				Attach_Script_Once(Get_GameObj(pID), "JFW_Armour_Regen", "1,3,20")
				InputConsole("cmsg 250,250,0 %s has bought a regen!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	-- Suits	--
	if Message[1] == "!nukesuit" or Message[1] == "!ns" then
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
				Attach_Script_Once(Get_GameObj(pID), "JFW_Blow_Up_On_Death", "Explosion_NukeBeacon")
				InputConsole("msg %s has bought a nuke suit! %s will blow up when they die!", user[pID]:GetName(), user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!killsuit" or Message[1] == "!ks" then
		if user[pID]:HasAccess(1) then
			price = 2500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits", pID, price)
			elseif user[pID]:HasKillsuit() then
				InputConsole("ppage %d You already have a killsuit!", pID)
			else
				user[pID]:SetKillsuit(true)
				InputConsole("msg %s has bought a kill suit! If you kill him, you will be damaged!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!tibsuit" or Message[1] == "!ts" then
		if user[pID]:HasAccess(1) then
			price = 2500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				Set_Skin(Get_GameObj(pID), "SkinMutant")
				InputConsole("msg %s has bought a mutant skin! Tib will heal health!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!ss" then
		if user[pID]:HasAccess(1) then
			scripts = tonumber(user[pID]:GetScripts())
			if scripts == nil or scripts == false or scripts < 2.9 then
				InputConsole("pamsg %d You can download the latest scripts from www.tiberiantechnologies.org/downloads", pID)
				InputConsole("pamsg %d You do not have scripts 2.9 or higher. You cannot buy !ss. Please update your scripts.", pID)
			else
				price = 3000
				if Get_Money(pID) < price then
					if Get_Team(pID) == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					end				
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					InputConsole("msg %s has bought a stealth suit, SCRIPTS REQUIRED!", user[pID]:GetName())
					InputConsole("msg Anyone without latest scripts CAN see %s even though they bought ss", user[pID]:GetName())
					Enable_Stealth(Get_GameObj(pID), 1)
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!absorbsuit" or Message[1] == "!as" then
		if user[pID]:HasAccess(1) then
			price = 3500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits", pID, price)
			elseif user[pID]:HasAbsorbsuit() then
				InputConsole("ppage %d You already have an absorbsuit!", pID)
			else
				user[pID]:SetAbsorbsuit(true)
				InputConsole("msg %s has bought an absorb suit! Can steal health+armor!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
			else
				InputConsole("ppage %d You do not have access to this command.", pID)
			end
		return 1
	end
	
	return false
end

function Killsuit(VictimObj, KillerObj)
	vID = Get_Player_ID(VictimObj)
	kID = Get_Player_ID(KillerObj)
	
	fullhp = Get_Health(KillerObj)
	fullap = Get_Shield_Strength(KillerObj)
	
	Apply_Damage(KillerObj, fullhp/2, "sharpnel", 0)
	InputConsole("ppage %d You have gained 100 credits!", kID)
	
	actualdmg = (fullhp - Get_Health(KillerObj)) + (fullap - Get_Shield_Strength(KillerObj))
	
	if Is_A_Star(KillerObj) then
		InputConsole("ppage %d You have lost %d health because you killed someone with a killsuit!!", kID, actualdmg)
		InputConsole("ppage %d You inflicted %d damage on %s because they killed you when you had a killsuit!", vID, actualdmg, user[kID]:GetName())
	else
		InputConsole("ppage %d You inflicted %d damage on a %s because it killed you when you had a killsuit!", vID, actualdmg, Get_Preset_Name(KillerObj))
	end
end

function Absorbsuit(vID, VictimObj, kID, KillerObj)
	sthp = Get_Health(KillerObj)
	stap = Get_Shield_Strength(KillerObj)
	
	dehp = Get_Max_Health(VictimObj) * .05
	deap = Get_Max_Shield_Strength(VictimObj) * .05
	
	Set_Max_Health(KillerObj, Get_Max_Health(KillerObj)+dehp)
	Set_Max_Shield_Strength(KillerObj, Get_Max_Shield_Strength(KillerObj)+deap)
	
	Set_Health(KillerObj, sthp+20)
	Set_Shield_Strength(KillerObj, stap+20)
	
	InputConsole("ppage %d Gained %d hp and %d ap from %s", kID , dehp, deap, user[vID]:GetName())
end
