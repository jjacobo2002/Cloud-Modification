module('char', package.seeall)

function Command(pID, Message)
	
	return false
end

function Robber(kID, kObj, vID)
	if string.lower(Get_Model(kObj)) == "c_ag_nod_kane" then
		if user[kID] ~= nil and user[vID] ~= nil then
			if user[vID]:GetBankCredits() <= 0 then
				InputConsole("ppage %d the person who you killed had nothing in the bank! Sorry!", kID)
			else
				veh = Get_Vehicle(kObj)
				if veh == 0 then
					if user[kID]:OnBankLimit() then
						InputConsole("ppage %d Because your have over %s credits in the bank + recs combined, the credits from your kill went into the lotto pot!", kID, sc.banklimit)
						giveint = user[vID]:GetBankCredits() * 0.008
						InputConsole("ppage %d Congrats! You just stole %d credits from %s. Auto-added to the lotto pot!", kID, giveint, user[vID]:GetName())
						InputConsole("ppage %d Shit! %s just stole %d credits from you! Auto-deducted from bank! Your credits were added to the lotto!", vID, user[kID]:GetName(), giveint)	
						user[vID]:RemoveBankCredits(giveint)
						lotto.IncreasePot(giveint)
					else
						giveint = user[vID]:GetBankCredits() * 0.02
						InputConsole("ppage %d Congrats! You just stole %d credits from %s. Auto-added to bank!", kID, giveint, user[vID]:GetName())
						InputConsole("ppage %d Shit! %s just stole %d credits from you! Auto-deducted from bank!", vID, user[kID]:GetName(), giveint)		
						user[vID]:RemoveBankCredits(giveint)	
						user[kID]:AddBankCredits(giveint)
					end
				else
					InputConsole("ppage %d You cannot steal money while in a vehicle.", kID)	
				end
			end
		end
	end
end
