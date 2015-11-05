module('gamble', package.seeall)

function Command(pID, Message)
	if Message[1] == "!openfreezer" then
		if user[pID]:HasAccess(1) then
			price = 500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end		
				InputConsole("ppage %d You need %d credits", pID, price)
			else
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
						InputConsole("msg %s just opened the freezer. Too cool. Type !moveice to move the ice cream!", user[pID]:GetName())
						InputConsole("ppage %d You have opened the freezer, quickly !moveice and make sure to !closefreezer afterwards!", pID)
						gi.AddMoneySpend(user[pID]:GetName(), price)
					elseif Freezer[pID]['state'] == 1 then
						InputConsole("ppage %d You already opened the freezer! Go !moveice before it melts!", pID)
					elseif Freezer[pID]['state'] == 2 then
						InputConsole("ppage %d You have helped DarkOrbit enough this game.", pID)
					end
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
				InputConsole("msg %s closed the freezer and collects %d credits for moving %d ice.", user[pID]:GetName(), payup, Freezer[pID]['ice'])
			elseif Freezer[pID]['state'] == 2 then
				InputConsole("ppage %d The freezer is already closed!.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end

	if Message[1] == "!lowgamble" then
		if user[pID]:HasAccess(1) then
			price = 500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end		
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				credits = math.random(-600, 500)
				Set_Money(pID, Get_Money(pID)+credits) 
				InputConsole("ppage %d You got %d credits", pID, credits)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!medgamble" then
		if user[pID]:HasAccess(1) then
			price = 3500
			if Get_Money(pID) < 3500 then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				credits = math.random(-4000,3500)
				Set_Money(pID, Get_Money(pID)+credits) 
				InputConsole("ppage %d You got %d credits", pID, credits)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end	
	
	if Message[1] == "!highgamble" then
		if user[pID]:HasAccess(1) then
			price = 10000
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				credits = math.random(-11200,10000)
				Set_Money(pID, Get_Money(pID)+credits) 
				InputConsole("ppage %d You got %d credits", pID, credits)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!chancegamble" then
		if user[pID]:HasAccess(1) then
			price = 1500
			if Get_Money(pID) < price then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				InputConsole("ppage %d You MAY go into negative credits with this gamble.", pID)
				credits = math.random(-5500,5000)
				Set_Money(pID, Get_Money(pID)+credits) 
				InputConsole("ppage %d You got %d credits", pID, credits)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	return false
end

function ResetFreezer()
	Freezer = nil; Freezer = {}
end

function AutoClose(pID)
	if Freezer[pID] ~= nil and Freezer[pID]['state'] == 1 then
		Freezer[pID]['state'] = 2
		payup = Freezer[pID]['ice'] * 250
		Set_Money(pID, Get_Money(pID)-payup)
		InputConsole("msg %s you fool! You've melted all of the ice cream! Pay up %d credits for the %d wasted ice cream!", user[pID]:GetName(), payup, Freezer[pID]['ice'])	
	end
end
