module('irc', package.seeall)

Packet_Construct = ""
IRC_Client = -1

function UserInit(User)
	_G['ircuser'][User] = ircuc.IRC_User:Init(User)
end

function GetWords(str)
	local ret = {}
	i = 1
	for v in string.gmatch(str, "[^%s]+") do
		table.insert(ret, v)
	end
	return ret
end

function Think()
	if IRC_Client > -1 then
		if DataAvaliable(IRC_Client) == 0 then
			if Packet_Construct == nil then
				Packet_Construct = string.char()
			end
			Packet_Construct = Packet_Construct .. Recv(IRC_Client)
		end
	end

	if Packet_Construct ~= nil then
		if string.find(Packet_Construct, "\n") ~= nil then
			Callback(string.match(Packet_Construct, "[^\n]+"))
			Packet_Construct = string.match(Packet_Construct, "\n(.+)")
		end
	end
end

function Connect()
	Default_Channel = mf.ReadINI(Config_File, "IRC", "channel")
	Nickname = mf.ReadINI(Config_File, "IRC", "nickname")
	Password = mf.ReadINI(Config_File, "IRC", "password")
	Address = mf.ReadINI(Config_File, "IRC", "host")
	Port = tonumber(mf.ReadINI(Config_File, "IRC", "port"))
	Ignore = mf.ReadINI(Config_File, "IRC", "ignore")

	IRC_Client = Client(Address, Port)

	if IRC_Client == -1 then
		print("[IRC] Can't connect.")
	else
		to_send = string.format("NICK %s\nUSER %s 0 * :[LuS]Bot\n", Nickname, Nickname)
		Send(IRC_Client, to_send)
		Join_Default_Channel()
		Auth(Password)
	end
end

function Receive(Channel, User, Message)
	Message = mf.SplitMessage(Message)
	if string.find(Channel, "#.+") ~= nil and Channel ~= Default_Channel then
		Part(Channel)
		print(string.format("IRC Left channel: %s", Channel))
	elseif Channel == Nickname then
		print(string.format("IRC PM From %s: %s", User, Message[-1]))
		if User == "StatServ" then
			Join_Default_Channel()
			Auth(Password)
		end
		OnPM(User, Message)
	else
		OnChannel(User, Message)
	end
end

function Callback(Packet)
	--print(Packet)
	local tok = GetWords(Packet)
	if tok[1] == "PING" then
		Send(IRC_Client, string.format("PONG %s\n", tok[2]))
		return
	end

	if tok[2] == "PRIVMSG" or tok[2] == "PART" or tok[2] == "JOIN"  or tok[2] == "NICK" then
		channel = tok[3];
		message = string.match(Packet, "[^%s]+%s*[^%s]+%s*[^%s]+%s*:(.+)")
		user = string.match(tok[1], ":([^:!]+)!")
		
		if tok[2] == "PRIVMSG" and user ~= Ignore then
			Receive(channel, user, message)
		elseif tok[2] == "PART" and user ~= Nickname and user ~= Ignore and channel == Default_Channel then
			UserLeave(user)
		elseif tok[2] == "JOIN" and user ~= Nickname and user ~= Ignore and (channel == Default_Channel or channel == ":"..Default_Channel) then
			UserJoin(user)
		elseif tok[2] == "NICK" and user ~= Nickname and user ~= Ignore then
			newnick = string.match(channel, ".+", 2)
			NickChange(user, newnick)
		end
	end
end

function Part(Channel)
	to_send = string.format("PART %s\n", Channel)
	Send(IRC_Client, to_send)
end

function Join_Default_Channel()
	to_send = string.format("JOIN %s\n", Default_Channel)
	Send(IRC_Client, to_send)
end

function Auth(pw)
	to_send = string.format("IDENTIFY %s", pw)
	SendPM(to_send, "NickServ")
end

function Quit(msg)
	to_send = string.format("QUIT %s\n", msg)
	Send(IRC_Client, to_send)
end

function ToColor(msg, colorid)
	return string.format("%s%s%s%s", string.char(3), colorid, msg, string.char(3))
end

function ToBold(msg)
	return string.format("%s%s%s", string.char(2), msg, string.char(2))
end

function ToUnderline(msg)
	return string.format("%s%s%s", string.char(0x1F), msg, string.char(0x1F))
end

function ToItalic(msg)
	return string.format("%s%s%s", string.char(0x16), msg, string.char(0x16))
end

function SendNotice(Msg, User)
	to_send = string.format("NOTICE %s :%s\n", User, Msg)
	Send(IRC_Client, to_send)
end

function SendMsg(Msg)
	to_send = string.format("PRIVMSG %s :%s\n", Default_Channel, Msg)
	Send(IRC_Client, to_send)
end

function SendPM(Msg, User)
	to_send = string.format("PRIVMSG %s :%s\n", User, Msg)
	Send(IRC_Client, to_send)
end

function UserJoin(User)
	print(string.format("%s Joined %s", User, Default_Channel))
	
	UserInit(User)
end

function UserLeave(User)
	print(string.format("%s Left %s", User, Default_Channel))
	
	_G['ircuser'][User] = nil
end

function NickChange(oldnick, newnick)
	if ircuser[oldnick]:IsAuthed() then
		UserInit(newnick)
		
		access = ircuser[oldnick]:GetAccess()
		ircuser[newnick]:LoadAccess(access)
	end
end

function OnChannel(User, Message)
	if ircuser[User] == nil then
		UserInit(User)
	end
	
	ircmd.Command(User, Message, false)
end

function OnPM(User, Message)
	if ircuser[User] ~= nil then
		ircmd.Command(User, Message, true)
	end
end
