module('vip', package.seeall)

function Command(pID, Message)
	if Message[1] == "!bonuscreds" then
		if user[pID]:HasAccess(1) and user[pID]:IsVIP() then
			if user[pID]:HasBonusCreds() then
				user[pID]:SetBonusCreds(false)
				InputConsole("ppage %d You deactivated your bonuscreds. No +5 creds/sec for your team.", pID)
			else
				user[pID]:SetBonusCreds(true)
				InputConsole("ppage %d Your team now gains +5 creds/sec!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!vipvehregen" then
		if user[pID]:HasAccess(1) and user[pID]:IsVIP() then
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
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!vipgamble" then
		if user[pID]:HasAccess(1) and user[pID]:IsVIP() then
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
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
	end
	
	return false
end
