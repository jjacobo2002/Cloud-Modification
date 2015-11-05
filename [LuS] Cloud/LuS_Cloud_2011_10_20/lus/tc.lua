module('tc', package.seeall)

autobalance = false

function Are_Teams_Even()
	nod_pl = Tally_Team_Size(0)
	gdi_pl = Tally_Team_Size(1)
	if nod_pl > gdi_pl then
		if nod_pl - gdi_pl > 1 then
			return 0
		end
	elseif gdi_pl > nod_pl then
		if gdi_pl - nod_pl > 1 then
			return 1
		end
	end
	
	return true
end

function ResetNP()
	np = nil; np = {};
	for pID, value in pairs(user) do
		AddPlayer(pID)
	end
end

function AddPlayer(pID)
	name = user[pID]:GetName()
	if np[name] == nil then
		np[name] = {}
		np[name].np = 0
		np[name].nominate = false
		np[name].volunteer = false
	end
end

function Nominate(pID, tID)
	pName = user[pID]:GetName()
	tName = user[tID]:GetName()
	
	if np[pName].nominate == false then
		np[pName].nominate = true
		np[tName].np = np[tName].np + 1
		return true
	else
		return false
	end
end

function Volunteer(pID)
	pName = user[pID]:GetName()
	if np[pName].volunteer == false then
		np[pName].np = np[pName].np + 100
		np[name].volunteer = true
		return true
	else
		return false
	end
end

function StartBalance()
	team = Are_Teams_Even()
	if team ~= true then
		if autobalance == false then
			InputConsole("msg [LuS] Teams unbalanced. Starting auto-balance...")
			autobalance = true
			ResetNP()
			
			start_time = os.time()
			
			if team == 0 then
				teamname = "Nod"
			elseif team == 1 then
				teamname = "GDI"
			else
				teamname = "?"
			end
			InputConsole("msg [LuS] Players of team %s, please !volunteer for a teamchange or !nominate a player.", teamname)
		end
	elseif autobalance == true then
		autobalance = false
		InputConsole("msg [LuS] Teams are balanced. Auto-balance stopped.")
	end
end

function BalanceNow()
	if os.time() - start_time > 60 then
		autobalance = false
		if Are_Teams_Even() == true then
			InputConsole("msg [LuS] Teams are balanced. Auto-balance stopped.")
		else
			InputConsole("msg [LuS] Time up. Executing team balance...")
			
			-- Less NP to VIP's and Scripts > 3
			for pID, value in pairs(user) do
				if team == Get_Team(pID) then
					name = user[pID]:GetName()
						
					if user[pID]:IsVIP() then
						np[name].np = np[name].np - 1
						irc.SendMsg(string.format("[b][Debug][/b] %s - Is a VIP - Removed 1 NP - Total: %f", name, np[name].np))
					end
						
					scripts = tonumber(user[pID]:GetScripts())
					if scripts ~= nil and scripts >= 3 then
						np[name].np = np[name].np - 1
						irc.SendMsg(string.format("[b][Debug][/b] %s - Has scripts %s - Removed 1 NP - Total: %f", name, scripts, np[name].np))
					end
				end
			end
				
			-- NP based on Money Spend
			moneyspenders = gi.GetAllMoneySpenders()
			lastspend = nil
			npadd = 0
			
			x = table.maxn(moneyspenders)
			while x ~= 0 do
				name = moneyspenders[x].name
				if np[name] ~= nil then
					if lastspend ~= nil and lastspend ~= moneyspenders[x].moneyspend then
						npadd = npadd + 0.5
					end
						
					np[name].np = np[name].np + npadd
					lastspend = moneyspenders[x].moneyspend
					
					irc.SendMsg(string.format("[b][Debug][/b] %s - Spend %d credits - Added %f NP - Total: %f", name, lastspend, npadd, np[name].np))
				end
				moneyspenders[x] = nil
				x = table.maxn(moneyspenders)
			end
			
			-- NP based on Join Time
			jointimes = gi.GetAllJoinTimes()
			lastjoin = nil
			npadd = 0
			
			x = table.maxn(jointimes)
			while x ~= 0 do
				name = jointimes[x].name
				if np[name] ~= nil then
					if lastjoin ~= nil and lastjoin ~= jointimes[x].jointime then
						npadd = npadd + 0.5
					end
						
					np[name].np = np[name].np + npadd
					lastjoin = jointimes[x].jointime
					
					irc.SendMsg(string.format("[b][Debug][/b] %s - Jointime: %d - Added %f NP - Total: %f", name, lastjoin, npadd, np[name].np))
				end
				jointimes[x] = nil
				x = table.maxn(jointimes)
			end
			
			
			-- Ordering the np's from high to low.
			nporder = {}
			for pName in pairs(np) do
				table.insert(nporder, {np = np[pName].np, name = pName})
			end

			table.sort(nporder, function(v1,v2)	return v1.np < v2.np end)
			
			target_team_id = 0
			target_team_name = "Nod"
			if team == 0 then
				target_team_id = 1
				target_team_name = "GDI"
			end
			
			while Are_Teams_Even() ~= true do
				x = table.maxn(nporder)
				tID = mf.FindPlayer("ID", nporder[x].name)
				if user[tID] ~= nil then
					InputConsole("team2 %d %d", tID, target_team_id)
					InputConsole("msg [LuS] %s has been changed to team %s.", user[tID]:GetName(), target_team_name)
					irc.SendMsg(string.format("[b][Debug][/b] %s - NP Points: %f - Changed", user[tID]:GetName(), nporder[x].np))
				end
				nporder[x] = nil
			end
		end
	end
end

function BalanceVIP()
	InputConsole("msg [LuS] Balancing Premium Players...")
	
	npl = nil; npl = {}
	npl[0] = {}; npl[1] = {}
	
	vippl = nil; vippl = {}
	vippl[0] = {}; vippl[1] = {}
	
	vipcount = nil; vipcount = {}
	vipcount[0] = 0; vipcount[1] = 0;
	
	for tID, value in pairs(user) do
		side = Get_Team(tID)
		if user[tID]:IsVIP() then
			vipcount[side] = vipcount[side] + 1
			table.insert(vippl[side], tID)
		else
			table.insert(npl[side], tID)
		end
	end
	
	if vipcount[0] > vipcount[1] then
		difference = vipcount[0] - vipcount[1]
		vipto_id = 1; vipfrom_id = 0;
	elseif vipcount[1] > vipcount[0] then
		difference = vipcount[1] - vipcount[0]
		vipto_id = 0; vipfrom_id = 1;
	else
		difference = 0
	end
	
	i = 1
	x = 1
	while difference > 1 do
		pID = vippl[vipfrom_id][i]
		InputConsole("team2 %d %d", pID, vipto_id)
		--InputConsole("msg [LuS-Debug] Changed %s to team %d", user[pID]:GetName(), vipto_id)
		i = i + 1
		
		if Are_Teams_Even() ~= true then
			pID = npl[vipto_id][x]
			InputConsole("team2 %d %d", pID, vipfrom_id)
			--InputConsole("msg [LuS-Debug] Changed %s to team %d", user[pID]:GetName(), vipfrom_id)
			x = x + 1
		end
		
		difference = difference - 1
	end
	InputConsole("msg [LuS] Premium Players balanced.")
end
