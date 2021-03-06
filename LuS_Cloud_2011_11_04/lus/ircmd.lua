module('ircmd', package.seeall)

function Reply(Msg, User, IsPM)
	if IsPM then
		irc.SendPM(Msg, User)
	else
		irc.SendNotice(Msg, User)
	end
end

function Command(User, Message, IsPM)
	if Message[1] == ".help" then
		commands = {}
		
		if ircuser[User]:HasAccess(1) then
			commands[1] = ".help | .auth | .myaccess"
		end
		
		if ircuser[User]:HasAccess(2) then
			commands[2] = ".islogged <player>"
		end
		
		if ircuser[User]:HasAccess(3) then
			commands[3] = ".removepass <player>"
		end
		
		if ircuser[User]:HasAccess(4) then
			commands[4] = ".rm"
		end
		
		if ircuser[User]:HasAccess(5) then
			commands[5] = ""
		end
		
		if commands[1] ~= nil then
			for k, msg in pairs(commands) do
				Reply(string.format("Level %d commands: %s", k, msg), User, IsPM)
			end
		end
		
		return 1
	end
	
	if Message[1] == ".rm" and IsPM == false then
		if ircuser[User]:HasAccess(4) then
			irc.SendNotice("[c=04][b][Warning][/b] Reloading irc-related modules might not result in a confirmation message.[/c]", User)
			if Message[2] == nil or Message[2] == "all" then
				msg = load_modules(true)
			else
				msg = load_modules(Message[2])
			end
			irc.SendMsg(string.format("[c=07][b]%s[/b][/c]", msg))
		else
			irc.SendNotice("You do not have access to this command.", User)
		end
		
		return 1
	end
	
	if Message[1] == ".auth" and IsPM then
		if ircuser[User]:IsAuthed() then
			irc.SendPM("You are already authed!", User)
		else
			if Message[2] == nil or Message[3] == nil then
				irc.SendPM("Usage: .auth <nickname> <password> (From your in-game account!)", User)
			else
				ircuser[User]:Auth(Message[2], Message[3])
			end
		end
		
		return 1
	end
	
	if Message[1] == ".myaccess" then
		Reply(string.format("Your access level is: %d", ircuser[User]:GetAccess()), User, IsPM)
		
		return 1
	end
	
	if Message[1] == ".islogged" then
		if ircuser[User]:HasAccess(2) then
			if Message[2] == nil then
				Reply("Usage: .islogged <playername>", User, IsPM)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					Reply("This playername is not unique.", User, IsPM)
				elseif tID == "None" then
					Reply("This player does not exist or is not ingame.", User, IsPM)
				else
					if user[tID]:IsLogged() then
						Reply(string.format("Player %s is logged in.", user[tID]:GetName()), User, IsPM)
					else
						Reply(string.format("Player %s is NOT logged in.", user[tID]:GetName()), User, IsPM)
					end
				end
			end
		else
			Reply("You do not have access to this command.", User, IsPM)
		end
		
		return 1
	end
	
	if Message[1] == ".removepass" then
		if ircuser[User]:HasAccess(3) then
			if Message[2] == nil then
				Reply("Usage: .removepass <playername>", User, IsPM)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					Reply("This playername is not unique.", User, IsPM)
				elseif tID == "None" then
					Reply("This player is not in-game. Searching database...", User, IsPM)
					
					-- Nickname check
					if string.find(Message[2], "^[%w%$%(%)%.%[%]%-_|]+$") == nil then
						Reply("Invalid characters detected, query not executed. Please use different search terms.", User, IsPM)
						return 1
					end
						
					query = string.format("SELECT COUNT(nickname) as count, nickname, access FROM users WHERE nickname LIKE '%s'", Message[2])
					result = db.Query(query)
					data = result[1]
					
					data.count = tonumber(data.count)
					data.access = tonumber(data.access)
					
					if data.count < 1 then
						Reply(string.format("A player with the name [b]%s[/b] does not exist.", Message[2]), User, IsPM)
					elseif data.count > 1 then
						Reply(string.format("A player with the name [b]%s[/b] is not unique, please use a (near) exact name, or use .finduser to find the name you need.", Message[2]), User, IsPM)
					else
						if data.access > ircuser[User]:GetAccess() then
							Reply("You can not remove the password of someone with a higher access level than you.", User, IsPM)
						else
							db.Query("UPDATE users SET password=NULL WHERE nickname = %s", data.nickname)
							Reply(string.format("You removed the password of %s", data.nickname), User, IsPM)
						end
					end
				else
					if user[tID]:GetAccess() > ircuser[User]:GetAccess() then
						Reply("You can not remove the password of someone with a higher access level than you.", User, IsPM)
					else
						user[tID]:SetPassword(nil)
						Reply(string.format("You removed the password of %s", user[tID]:GetName()), User, IsPM)
					end
				end
			end
		else
			Reply("You do not have access to this command.", User, IsPM)
		end
		
		return 1
	end
	
	return 1
end
