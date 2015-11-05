module('ircuc', package.seeall)

IRC_User = {}
IRC_User.__index = IRC_User

function IRC_User:Init(User)
	local self = {}
	setmetatable(self, IRC_User)
	
	self.user = User
	self.auth = false
	self.access = 1
	
	msg = string.format("Welcome, %s! To auth yourself for moderator powers, PM me with the following command: .auth <ingamenickname> <ingamepassword>", User)
	irc.SendPM(msg, self.user)

	return self
end

function IRC_User:Auth(User, Password)
	sql = string.format("SELECT COUNT(access) as match, access FROM users WHERE nickname LIKE '%s' AND password = '%s'", User, Password)
	
	result = db.Query(sql)
	data = result[1]
	
	match = tonumber(data.match)
	access = tonumber(data.access)
		
	if match == 0 then
		irc.SendPM("Please check if both the in-game nickname and password are correct.", User)
	elseif match == 1 then
		self.access = access
		self.auth = true
		irc.SendPM(string.format("You are now authed. Your access level is: [n]%d[/n]", self.access), User)
	else
		OnError(string.format("IRC AUTH FAILURE (%s)", User))
	end
end

function IRC_User:HasAccess(Level)
	if self.access >= Level then
		return true
	else
		return false
	end
end

function IRC_User:GetAccess()
	return self.access
end

function IRC_User:IsAuthed()
	return self.auth
end
