module('gamble', package.seeall)

function Command(pID, Message)
	if Message[1] == "!openfreezer" then
		if user[pID]:HasAccess(1) then
			gametime_elapsed = os.time() - gametime_start
			if gametime_elapsed < sc.bank_wait then
				gametime_bankwait = sc.bank_wait - gametime_elapsed
				InputConsole("ppage %d You need to wait %d seconds before you can use the freezer.", pID, gametime_bankwait)
			else
				if Freezer[pID] == nil then
					Freezer[pID] = {}
					Freezer[pID]['state'] = 1
					Freezer[pID]['ice'] = 0
		
					pObj = Get_GameObj(pID)
					Attach_Script_Once(pObj, "openfreezer", "")
					InputConsole("msg %s has opened the freezer!", user[pID]:GetName())
					InputConsole("ppage %d You have opened the freezer, quickly !moveice and make sure to !closefreezer afterwards!", pID)
				elseif Freezer[pID]['state'] == 1 then
					InputConsole("ppage %d You already opened the freezer! Go !moveice before it melts!", pID)
				elseif Freezer[pID]['state'] == 2 then
					InputConsole("ppage %d You have helped DarkOrbit enough this game.", pID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!moveice" then
		if user[pID]:HasAccess(1) then
			if Freezer[pID] == nil then
				InputConsole("ppage %d You need to !openfreezer before you can help DarkOrbit !moveice.", pID)
			elseif Freezer[pID]['state'] == 1 then
				Freezer[pID]['ice'] = Freezer[pID]['ice'] + 1
				InputConsole("ppage %d You have moved %d ice!", pID, Freezer[pID]['ice'])
			elseif Freezer[pID]['state'] == 2 then
				InputConsole("ppage %d You have helped DarkOrbit enough this game.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 0
	end
	
	if Message[1] == "!closefreezer" then
		if user[pID]:HasAccess(1) then
			if Freezer[pID] == nil then
				InputConsole("ppage %d You need to !openfreezer before you can help DarkOrbit !moveice.", pID)
			elseif Freezer[pID]['state'] == 1 then
				Freezer[pID]['state'] = 2
				payup = Freezer[pID]['ice'] * 150
				Set_Money(pID, Get_Money(pID)+payup)
				InputConsole("msg %s has helped DarkOrbit move %d ice and received %d credits.", user[pID]:GetName(), Freezer[pID]['ice'], payup)
			elseif Freezer[pID]['state'] == 2 then
				InputConsole("ppage %d The freezer is already closed!.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end

	return nil
end

function ResetFreezer()
	Freezer = nil; Freezer = {}
end

function AutoClose(pID)
	if Freezer[pID] ~= nil and Freezer[pID]['state'] == 1 then
		Freezer[pID]['state'] = 2
		payup = Freezer[pID]['ice'] * 300
		Set_Money(pID, Get_Money(pID)-payup)
		InputConsole("msg %s melted %d ice and needed to pay DarkOrbit %d credits.", user[pID]:GetName(), Freezer[pID]['ice'], payup)	
	end
end
