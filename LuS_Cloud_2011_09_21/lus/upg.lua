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

	return nil
end
