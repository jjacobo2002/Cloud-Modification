module('privcmd', package.seeall)

forumgamble = {}
forumgamble['kamuixmod'] = 0

function Command(pID, Message)
	pName = user[pID]:GetName()
	

	if Message[1] == "!privatehelp" then
		if pName == "Darkorbit" or pName == "Cotsuma" then				                       
			
			InputConsole("ppage %d !godregen rainbow healthme !test !renegade !epic !ulti", pID)
			return 0
		end
	end	
	if Message[1] == "!godregen" then
		if pName == "Darkorbit" or pName == "Cotsuma" then				                       
			Attach_Script(Get_GameObj(pID), "JFW_Health_Regen", "1,1,500")
			Attach_Script(Get_GameObj(pID), "JFW_Armour_Regen", "1,1,500")
			
			InputConsole("ppage %d You used !godregen.", pID)
			return 0
		end
	end
	
	if Message[1] == "rainbow" then
		if pName == "Darkorbit" then				                       
			Set_Money(pID, Get_Money(pID) + 180000)
			
			InputConsole("ppage %d You used rainbow.", pID)
			return 0
		end
	end
	if Message[1] == "healthme" then
		if pName == "Darkorbit" then				                       
			Grant_Powerup(Get_GameObj(pID), "POW_Medal_Health")
			Grant_Powerup(Get_GameObj(pID), "POW_Medal_Armor") 
			
			InputConsole("ppage %d You used healthme.", pID)
			return 0
		end
	end
	if Message[1] == "!ulti" then
		if pName == "Darkorbit" then				                       
			Grant_Powerup(Get_GameObj(pID), "POW_Anti-Sound_Emitter")
			
			InputConsole("ppage %d You used !ulti.", pID)
			return 0
		end
	end
	if Message[1] == "!test" then
		if pName == "Darkorbit" then 
			InputConsole("msg %s has bought a ??!", pName) 
			Grant_Powerup(Get_GameObj(pID), "POW_Nuclear_Missle_Beacon")
			Grant_Powerup(Get_GameObj(pID), "POW_IonCannonBeacon_Player")
			
			InputConsole("ppage %d You used !test.", pID)
			return 0
		end
	end
	
	if Message[1] == "!renegade" then
		if pName == "Darkorbit" then
			Attach_Script_Once(Get_GameObj(pID), "z_Set_Team", 2)
			
			InputConsole("ppage %d You used !renegade.", pID)
			return 0
		end
	end
	
	if Message[1] == "!epic" then
		if pName == "Darkorbit" then				                       
			Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "1,1,200")
			Attach_Script_Once(Get_GameObj(pID), "JFW_Armour_Regen", "1,1,200")
			Set_Money(pID, Get_Money(pID) + 180000)
			Grant_Powerup(Get_GameObj(pID), "POW_Medal_Health")
			Grant_Powerup(Get_GameObj(pID), "POW_Medal_Armor")
			Grant_Powerup(Get_GameObj(pID), "POW_Double_Damage")
			Grant_Powerup(Get_GameObj(pID), "POW_RamjetRifle_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_Pistol_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_AutoRifle_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_Flamethrower_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_GrenadeLauncher_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_Chaingun_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_RocketLauncher_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_ChemSprayer_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_SniperRifle_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_PersonalIonCannon_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_LaserChaingun_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_LaserRifle_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_TiberiumFlechetteGun_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_TiberiumAutoRifle_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_PersonalIonCannon_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_Railgun_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_RamjetRifle_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_Pistol_AI")
			Grant_Powerup(Get_GameObj(pID), "POW_VoltAutoRifle_Player")
			Grant_Powerup(Get_GameObj(pID), "CnC_MineProximity_05")
			Attach_Script_Once(Get_GameObj(pID), "JFW_Pilot_Repair", ".1,3,100")
			
			InputConsole("ppage %d You used !epic.", pID)
			return 0
		end
	end
	
	if Message[1] == "!forumgamble" then
		if pName == "kamuixmod" then
			price = 2000
			tgwait = 60
			
			gamble_allow = forumgable[pName] + tgwait
			
			if os.time() > gamble_allow then
				if Get_Money(pID) < price then
					InputConsole("ppage %d You need %d credits before you can use forumgamble.", pID, price)
				else
					-- you can put your chance & prize stuff below here
					random = math.random(-2550,5000)
					if random < 0 then
						Set_Money(pID, Get_Money(pID)-500)
						InputConsole("ppage %d You lost, bonus loss of -500 :)", pID)
					end
					Set_Money(pID, Get_Money(pID)+random) 
					InputConsole("ppage %d You got %d credits", pID,random)
					-- and above here
					forumgable[pName] = os.time()
				end
			else
				left = gamble_allow - os.time()
				InputConsole("ppage %d You need to wait %d more seconds till you can use forumgamble.", pID, left)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	return false
end
