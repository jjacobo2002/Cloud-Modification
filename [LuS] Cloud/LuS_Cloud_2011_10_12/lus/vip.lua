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
					Attach_Script_Once(veh, "JFW_Health_Regen", "1,1,10")
					Attach_Script_Once(veh, "JFW_Armour_Regen", "1,1,10")
					InputConsole("cmsg 250,250,0 %s has bought a vehregen!", user[pID]:GetName())
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	return false
end
