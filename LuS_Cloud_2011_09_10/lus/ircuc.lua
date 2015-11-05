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
	sql = string.format("SELECT COUNT(access), access FROM users WHERE nickname LIKE '%s' AND password = '%s'", User, Password)
	db:Query(self.user, "query_AuthIRC", sql)
end

function IRC_User:LoadAccess(Level)
	self.access = Level
	self.auth = true
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
