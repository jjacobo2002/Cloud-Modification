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
	
	return false
end
