module('mf', package.seeall)

function SplitMessage(Message)
	if Message ~= nil and Message ~= "" then
		msg = {}
		msg2 = {}
		i = 0
		for v in string.gmatch(Message, "[^%s]+") do
			i = i + 1
			msg[i] = v
		end
		while i > 0 do
			msg2[-i] = table.concat(msg, ' ', i)
			msg2[i] = msg[i]
			i = i - 1
		end
		return msg2
	else
		msg[-1] = "None"
		msg[1] = "None"
		return msg
	end
end

function FindPlayer(Result, Name)
	--Original function by PsuFan
	--Rewritten/Edited by SxDarkOne
	--Will now continue searching for an exact match, even if a partial match ("Many") is found.
	--Will not loop trough 127 id's if no match ("None") is found. Only a max of MaxID times.
	
	--Result can be either "Name" or "ID"
	--Name is the full/partial nickname.
	--MaxID is the max amount of players that can join. Or you can calculate the highest pID in-game yourself.
	--Returns "Many" if the name is not an exact match and the name is not unique.
	--Returns "None" if no result was found.

	MaxID = max_pID
	CurID = 0
	PartialMatch = nil
	
	while CurID <= MaxID do
		CurID = CurID + 1
		if user[CurID] ~= nil then
			CurName = user[CurID]:GetName()
			if string.lower(CurName) == string.lower(Name) then
				if Result == "Name" then
					return CurName
				elseif Result == "ID" then
					return CurID
				end
			elseif string.find(string.lower(CurName), string.lower(Name)) ~= nil then
				if PartialMatch ~= nil then
					return "Many"
				else
					if Result == "Name" then
						PartialMatch = CurName
					elseif Result == "ID" then
						PartialMatch = CurID
					end
				end
			end
		end
	end
	
	if PartialMatch == nil then
		return "None"
	else
		return PartialMatch
	end
end

function TimePassed(Seconds, MaxTime)
	-- Converts seconds passed to a more read-able format
	-- Maxtime:
	-- 5 (or higher) = weeks, days, hours, minutes, seconds.
	-- 4 = days, hours, minutes, seconds.
	-- 3 = hours, minutes, seconds.
	-- 2 = minutes, seconds.
	-- 1 (or lower) = seconds.
	
	minute = 60; hour = minute*60; day = hour*24; week = day*7
	
	Seconds = tonumber(Seconds)
	MaxTime = tonumber(MaxTime)
	
	if Seconds == nil or MaxTime == nil then
		return "Error"
	end
	
	local tpassed = {}
	tpassed['weeks'] = 0
	tpassed['days'] = 0
	tpassed['hours'] = 0
	tpassed['minutes'] = 0
	
	if MaxTime >= 5 then
		tpassed['weeks'] = math.floor(Seconds / week)
		Seconds = Seconds - (week * tpassed['weeks'])
	end
	
	if MaxTime >= 4 then
		tpassed['days'] = math.floor(Seconds / day)
		Seconds = Seconds - (day * tpassed['days'])
	end
	
	if MaxTime >= 3 then
		tpassed['hours'] = math.floor(Seconds / hour)
		Seconds = Seconds - (hour * tpassed['hours'])
	end
	
	if MaxTime >= 2 then
		tpassed['minutes'] = math.floor(Seconds / minute)
		Seconds = Seconds - (minute * tpassed['minutes'])
	end
	
	tpassed['seconds'] = Seconds
	
	return tpassed
end

function CompareIP(IP1, IP2)
	match = true
	
	IP1 = mf.SplitIP(IP1)
	IP2 = mf.SplitIP(IP2)
	
	for i=1, 4 do
		if (IP1[i] ~= '*' and IP2[i] ~= '*') and IP1[i] ~= IP2[i] then
			match = false
		end
	end
	
	return match
end

function SplitIP(IP)
	IPn = {}
	i = 0
	
	for v in string.gmatch(IP, "[^%.]+") do
		i = i + 1
		IPn[i] = v
	end
	
	return IPn
end

function QKick(pID, By, Reason)
	nickname = user[pID]:GetName()
	query = string.format("INSERT INTO kick_log(time, player, ip, by, reason) VALUES(%d, '%s', '%s', '%s', '%s')", os.time(), nickname, user[pID]:GetCurrentIP(), By, Reason)
	db.Query(query)
	InputConsole("kick %d", pID)
	InputConsole("allow %s", nickname)
	InputConsole("[LuS] %s has been QKicked by %s for: %s", nickname, By, Reason)
end

function ValidateNick(Nickname)
	if string.find(Nickname, "%w+") == nil or string.find(Nickname, "^[%w%$%(%)%.%[%]%-_|]+$") == nil or string.len(Nickname) < 3 then
		return false
	else
		return true
	end
end

function ValidateSerial(Serial)
	if string.find(Serial, "^%w+$") == nil or string.len(Serial) ~= 32 then
		return false
	else
		return true
	end
end

function SaveAll()
	for k, v in pairs(user) do
		user[k]:Save(false)
	end
end

function SetRandomSeed()
	players = Get_Player_Count()
	if players > 1 then
		seed = os.time() / players
	else
		seed = os.time()
	end
	math.randomseed(seed)
end

function TeamDonate(pID, credits)
	side = Get_Team(pID)
	teamsize = Tally_Team_Size(side)-1
	if teamsize > 0 then
		credits = credits / teamsize
		for tID, value in pairs(user) do
			if side == Get_Team(tID) and tID ~= pID then
				Set_Money(pID, Get_Money(pID)-credits)
				Set_Money(tID, Get_Money(tID)+credits)
				InputConsole("ppage %d %s donated %d credits to you!", tID, user[pID]:GetName(), credits)
			end
		end
	end
end

function ReadINI(File, Section, Key)
	SectionPattern = "^%[".. Section .. "%].*"
	FoundFile = false
	FoundSection = false
	FoundKey = false

	if File ~= nil and File ~= "" and Section ~= nil and Section ~= "" and Key ~= nil and Key ~= "" then
		ini = io.open(File, "r")

		if ini ~= nil then
			FoundFile = true
			for line in ini:lines() do
				if line ~= "" and string.sub(line, 0, 1) ~= ";" then
					if FoundSection == false then
						if string.find(line, SectionPattern) ~= nil then
							FoundSection = true
						end
					elseif string.sub(line, 0, 1) == "[" then
						break
					else
						strequal = string.find(line, "=")
						if strequal ~= nil then
							IniKey = string.sub(line, 0, strequal-1)
							IniKey = string.match(IniKey, "[^%s]+")
							if IniKey == Key then
								Value = string.sub(line, strequal+1)
								Value = string.match(Value, "[^%s]+.*[^%s]*")
								FoundKey = true
							end
						end
					end
				end
			end
		end
	end

	ini:close()

	if FoundFile == false then
		return "Error: File doesn't exist."
	elseif FoundSection == false then
		return "Error: Section doesn't exist."
	elseif FoundKey == false then
		return "Error: Key doesn't exist."
	else
		return Value
	end
end

function WriteINI(File, Section, Key, Value)
	SectionPattern = "^%[".. Section .. "%].*"
	FoundFile = false
	FoundSection = false
	FoundKey = false
	NewINI = ""

	if File ~= nil and File ~= "" and Section ~= nil and Section ~= "" and Key ~= nil and Key ~= "" and Value ~= nil then
		ini = io.open(File, "r")

		if ini ~= nil then
			FoundFile = true
			for line in ini:lines() do
				saveline = true
				if line ~= "" and string.sub(line, 0, 1) ~= ";" then
					if FoundSection == false then
						if string.find(line, SectionPattern) ~= nil then
							FoundSection = true
						end
					elseif string.sub(line, 0, 1) == "[" and FoundKey == false then
						break
					else
						strequal = string.find(line, "=")
						if strequal ~= nil then
							IniKey = string.sub(line, 0, strequal-1)
							IniKey = string.match(IniKey, "[^%s]+")
							if IniKey == Key then
								FoundKey = true
								saveline = false
								NewINI = NewINI .. Key .. " = " .. Value .. "\n"
							end
						end
					end
				end
				if saveline == true then
					NewINI = NewINI .. line .. "\n"
				end
			end
			ini:close()
		end
	else
		return "Error: Missing Arguments"
	end

	if FoundKey == true then
		ini = io.open(File, "w")
		ini:write(NewINI)
		ini:close()
		return true
	else
		if FoundFile == false then
			return "Error: File doesn't exist."
		elseif FoundSection == false then
			return "Error: Section doesn't exist."
		elseif FoundKey == false then
			return "Error: Key doesn't exist."
		end
	end
end

function Get_Distance(Obj1, Obj2)
	pos = Get_Position(Obj1)
	pos2 = Get_Position(Obj2)
	
	Distance = math.sqrt((pos.X - pos2.X)^2+(pos.Y - pos2.Y)^2+(pos.Z - pos2.Z)^2)
	
	return Distance
end
