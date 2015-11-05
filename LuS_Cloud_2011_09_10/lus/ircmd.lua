module('ircmd', package.seeall)

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
		
		if commands[1] == nil then
			if IsPM then
				irc.SendPM("You do not have access to any commands.", User)
			else
				irc.SendNotice("You do not have access to any commands.", User)
			end
		else
			if IsPM then
				for k, msg in pairs(commands) do
					irc.SendPM(string.format("Level %d commands: %s", k, msg), User)
				end
			else
				for k, msg in pairs(commands) do
					irc.SendNotice(string.format("Level %d commands: %s", k, msg), User)
				end
			end
		end
	end
	
	if Message[1] == ".rm" and IsPM == false then
		if ircuser[User]:HasAccess(4) then
			irc.SendNotice(irc.ToColor("[Warning] Reloading irc-related modules might not result in a confirmation message.", "04"), User)
			if Message[2] == nil or Message[2] == "all" then
				msg = load_modules(true)
				
			else
				msg = load_modules(Message[2])
			end
			msg = irc.ToColor(msg, "07")
			msg = irc.ToBold(msg)
			irc.SendMsg(msg)
		else
			irc.SendNotice("You do not have access to this command.", User)
		end
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
	end
	
	if Message[1] == ".myaccess" then
		access = ircuser[User]:GetAccess()
		if IsPM then
			irc.SendPM(string.format("Your access level is: %d", access), User)
		else
			irc.SendNotice(string.format("Your access level is: %d", access), User)
		end
	end
	
	if Message[1] == ".islogged" then
		if ircuser[User]:HasAccess(2) then
			if Message[2] == nil then
				msg = "Usage: .islogged <playername>"
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					msg = "This playername is not unique."
				elseif tID == "None" then
					msg = "This player does not exist or is not ingame."
				else
					if user[tID]:IsLogged() then
						msg = string.format("Player %s is logged in.", user[tID]:GetName())
					else
						msg = string.format("Player %s is NOT logged in.", user[tID]:GetName())
					end
				end
			end
		else
			msg = "You do not have access to this command."
		end
		
		if IsPM then
			irc.SendPM(msg, User)
		else
			irc.SendNotice(msg, User)
		end
	end
	
	if Message[1] == ".removepass" then
		if ircuser[User]:HasAccess(3) then
			if Message[2] == nil then
				msg = "Usage: .removepass <playername>"
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					msg = "This playername is not unique."
				elseif tID == "None" then
					msg = "This player is not in-game. Searching database..."
					
					-- Nickname check
					query = string.format("SELECT COUNT(nickname), nickname, access FROM users WHERE nickname LIKE '%s'", Message[2])
					db:Query({User, Message[1]}, "IRCmd_Callback", query)
				else
					if user[tID]:GetAccess() > ircuser[User]:GetAccess() then
						msg = "You can not remove the password of someone with a higher access level than you."
					else
						user[tID]:SetPassword(nil)
						msg = string.format("You removed the password of %s", user[tID]:GetName())
					end
				end
			end
		else
			msg = "You do not have access to this command."
		end
		
		if IsPM then
			irc.SendPM(msg, User)
		else
			irc.SendNotice(msg, User)
		end
	end
end
