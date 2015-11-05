module('uc', package.seeall)

Player = {}
Player.__index = Player

function Player:Init(pID, Nick)
	local self = {}
	setmetatable(self, Player)
	
	self.pID = pID
	self.nickname = Nick
	self.login = false
	self.password = nil
	self.dbid = 0
	self.bankcredits = 0
	self.recs = 0
	self.dp = 0
	self.loti = 0
	self.interest = sc.interest
	self.allow_interest = false
	self.vip = 0
	self.last_vip_update = 0
	self.vip_subscribe = 0
	self.vip_months = 0
	self.access = 0
	self.currentip = Get_IP_Address(pID)
	self.accountip = 0
	self.currentserial = 0
	self.accountserial = 0
	self.jointime = 0
	self.last_present = 0
	self.onlinetime = 0
	self.onlinecounter = os.time()
	self.mute = false
	self.sound = 0
	self.protection = 0
	self.autologin = 0
	self.banned = false
	self.freeze = false
	self.blockdmg = false
	self.disabled = false
	self.kills = 0
	self.last_killed = 0
	self.start_killspree = os.time()
	self.lastkey = os.time()
	self.modpower = false
	self.bonuscreds = false
	self.scripts = false
	
	return self
end

function Player:Login(pw)
	if pw ~= nil then
		self.password = pw
	end
	
	if self:IsDisabled() == false then
		if self:IsValidNick() == false then
			InputConsole("msg [LuS] %s has an invalid nickname and has been disabled.", self:GetName())
			self:Disable()
		elseif self:IsValidSerial() == false then
			InputConsole("msg [LuS] %s has an invalid serialhash and has been disabled.", self:GetName())
			self:Disable()
		elseif self:IsBanned() then
			InputConsole("msg [LuS] %s is in the banlist and has been disabled.", self:GetName())
			self:Disable()
		else
			sql = string.format("SELECT COUNT(*) as count FROM users WHERE nickname LIKE '%s'", self:GetName())
			result = db.Query(sql)
			data = result[1]
			
			if tonumber(data.count) < 1 then
				InputConsole("msg [LuS] Attention everyone! Please give a warm welcome to the newbie: %s!", user[pID]:GetName())
				
				sql = string.format("INSERT INTO users (nickname, jointime) VALUES('%s', %d)", user[pID]:GetName(), os.time())
				db.Query(sql)
			end
				
			sql = string.format("SELECT * FROM users WHERE nickname LIKE '%s' LIMIT 1", user[pID]:GetName())
			result = db.Query(sql)
			data = result[1]
			
			-- Making sure some values are numbers.	--
			data.id = tonumber(data.id)
			data.access = tonumber(data.access)
			data.credits = tonumber(data.credits)
			data.recs = tonumber(data.recs)
			data.dp = tonumber(data.dp)
			data.loti = tonumber(data.loti)
			data.jointime = tonumber(data.jointime)
			data.onlinetime = tonumber(data.onlinetime)
			data.last_present = tonumber(data.last_present)
			data.vip_last_update = tonumber(data.vip_last_update)
			data.vip = tonumber(data.vip)
			data.vip_months = tonumber(data.vip_months)
			data.vip_subscription = tonumber(data.vip_subscription)
			data.protection = tonumber(data.protection)
			data.autologin = tonumber(data.autologin)
			data.sound = tonumber(data.sound)
			
			-- If the player already has an Account IP and Account Serial, check for nickspoofers or autologin 	--
			if data.ip ~= nil and data.serialhash ~= nil then
				-- Pre-loading certain values	--
				self.autologin = data.autologin
				self.protection = data.protection
				self.accountserial = data.serialhash
				self.accountip = data.ip
				
				ipmatch = mf.CompareIP(self.accountip, self.currentip)
				serialmatch = self.accountserial == self.currentserial
				
				-- Warnings	--
				if self.protection == 0 then
					if ipmatch == false and serialmatch == false then
						InputConsole("msg [LuS] Warning, %s might be a nickspoofer! (Serialhash & IP don't match)", self:GetName())
						msg = irc.ToColor(string.format("[Protect] Info: %s's Account IP: %s | Account Serial: %s", self:GetName(), self.accountip, self.accountserial), "04")
						irc.SendMsg(msg)
					elseif serialmatch == false then
						InputConsole("msg [LuS] Warning, %s might be a nickspoofer! (Serialhash doesn't match)", self:GetName())
						msg = irc.ToColor(string.format("[Protect] Info: %s's Account Serial: %s", self:GetName(), self.accountserial), "04")
						irc.SendMsg(msg)
					elseif ipmatch == false then
						InputConsole("msg [LuS] Warning, %s might be a nickspoofer! (IP doesn't match)", self:GetName())
						msg = irc.ToColor(string.format("[Protect] Info: %s's Account IP: %s", self:GetName(), self.accountip), "04")
						irc.SendMsg(msg)
					end
				end
				
				-- Autologin	--
				if self.autologin > 0 then
					if self.autologin == 1 or self.autologin == 3 then
						if ipmatch == true then
							self.login = true
						end
					end
					if self.autologin == 2 or self.autologin == 3 then
						if serialmatch == true then
							self.login = true
						end
					end
				end
			end
			
			-- Password Login	--
			if self.login == false then
				if data.password == nil or data.password == self.password then
					self.login = true
				elseif self.password ~= nil then
					InputConsole("ppage %d If you tried !login <password>, please check if the password is correct or contact a mod.", self.pID)
				else
					InputConsole("msg [LuS] Welcome, %s. Please login using !login <password>", self:GetName())
				end
			end
				
			-- Serial/IP Protection	--
			valid = true
			if self.protection > 0 then
				if self.protection == 1 or self.protection == 3 then
					if ipmatch == false then
						valid = false
					end
				end
				if self.protection == 2 or self.protection == 3 then
					if serialmatch == false then
						valid = false
					end
				end
				
				if valid == false then
					self:Logout(false)
					self:Disable()
					InputConsole("msg [LuS] %s is a nickspoofer and has been disabled.", self:GetName())
					
					msg = irc.ToColor(string.format("[Protection] Info: Account Protection triggered on %s. Protection Level: %d | Account IP: %s | Account Serial: %s", self:GetName(), self.protection, self.accountip, self.accountserial), "04")
					irc.SendMsg(msg)
				end
			end

			-- Load data if user may login	--
			if self.login == true then
				self.dbid = data.id
				self.access = data.access
				self.bankcredits = data.credits
				self.recs = data.recs
				self.dp = data.dp
				self.loti = data.loti
				self.jointime = data.jointime
				self.onlinetime = data.onlinetime
				self.last_present = data.last_present
				self.last_vip_update = data.vip_last_update
				self.vip = data.vip
				self.vip_months = data.vip_months
				self.vip_subscribe = data.vip_subscription
				self.password = data.password
				self.sound = data.sound
				
				-- Mod Count	--
				if self.access > 1 then
					gi.CountMods(1)
				end
				
				-- VIP interest/Count	--		
				if self:IsVIP() then
					gi.CountVips(1)
					self.interest = sc.vipinterest
				end
			
				-- Adding jointime if needed	--
				if self.jointime == 0 then
					self.jointime = os.time()
					query = string.format("UPDATE users SET jointime=%d WHERE id=%d", os.time(), self.dbid)
					db.Query(query)
				end
				
				-- Adding account_ip if needed	--
				if self.accountip == nil then
					self:SetAccountIP()
				end
				
				-- Adding account_serial if needed	--
				if self.accountserial == nil then
					self:SetAccountSerial()
				end
				
				-- Checking if user has a password	--
				if self:IsProtected() == false then
					InputConsole("pamsg %d You don't have a password set. For help with setting a password, use the command: !accounthelp", self.pID)
				end
				
				-- Check BDay and gives present if needed	--
				-- Also gives a message how many days it has	--
				-- been since this player started playing	--
				self:BDay()
				
				-- Checking/Setting VIP Status	--
				self:UpdateVIP()
				
				-- Welcome PM	--
				InputConsole("ppage %d Welcome, %s. You currently have %d credits and %d recs.", self.pID, self:GetName(), self.bankcredits, self.recs)
				InputConsole("ppage %d Type !accounthelp for help with your account. For all commands, use !commands.", self.pID)
			end
		end
	end
end

function Player:Logout(Leaving)
	if self:IsLogged() then
		self:Save(Leaving)
		
		if self.access > 1 then
			gi.CountMods(-1)
		end
		if self:IsVIP() then
			gi.CountVips(-1)
		end
		
		if Leaving == true then
			InputConsole("msg [LuS] Thank you for playing, %s.", self:GetName())
		else
			self.login = false
			self.password = nil
			self.dbid = 0
			self.bankcredits = 0
			self.recs = 0
			self.dp = 0
			self.loti = 0
			self.interest = sc.interest
			self.allow_interest = false
			self.vip = 0
			self.last_vip_update = 0
			self.vip_subscribe = 0
			self.vip_months = 0
			self.access = 0
			self.accountip = 0
			self.accountserial = 0
			self.jointime = 0
			self.last_present = 0
			self.onlinetime = 0
			self.onlinecounter = os.time()
			self.killstreak = 0
			self.sound = 0
			self.protection = 0
			self.autologin = 0
			
			InputConsole("msg [LuS] %s logged out.", self:GetName())
		end
	end
end

function Player:Save(Leaving)
	if self.dbid ~= 0 then
		sql = string.format("UPDATE users SET credits=%d, loti=%d, last_present=%d, recs=%d, dp=%d, onlinetime=%d WHERE id=%d", self.bankcredits, self.loti, self.last_present, self.recs, self.dp, self:GetOnlineTime(), self.dbid)
		
		db.Query(sql)
		
		if Leaving == false then
			InputConsole("ppage %d Your data has been saved!", self.pID)
		end
	end
end

function Player:GetName()
	return self.nickname
end

function Player:IsLogged()
	return self.login
end

function Player:GetDbID()
	return self.dbid
end

function Player:GetInterest()
	return self.interest
end

function Player:InterestAllowed()
	return self.allow_interest
end

function Player:GetJoinTime()
	return self.jointime
end

function Player:GetOnlineTime()
	tp = os.time() - self.onlinecounter
	ot = self.onlinetime + tp
	return ot
end

function Player:GetPlayTime()
	playtime = os.time() - self.jointime
	return playtime
end

function Player:AllowInterest()
	self.allow_interest = true
end

function Player:DisallowInterest()
	self.allow_interest = false
end

function Player:BDay()
	-- Preparing vars	--
	minute = 60; hour = minute*60; day = hour*24; week = day*7; month = day*30

	playtime = self:GetPlayTime()

	-- Checking for birthday presents	--
	if self.last_present == 0 and playtime > day then
		self:AddBankCredits(5000)
		InputConsole("msg [LuS] %s has received 5k for playing this server for over one day!", self:GetName())
		self.last_present = self.jointime + day
	elseif (self.last_present - self.jointime) == day and playtime > week then
		self:AddBankCredits(20000)
		InputConsole("msg [LuS] %s has received 20k for playing this server for over one week!", self:GetName())
		self.last_present = self.jointime + week
	elseif (self.last_present - self.jointime) == week and playtime > month then
		self:AddBankCredits(50000)
		InputConsole("msg [LuS] %s has received 50k for playing this server for over one month!", self:GetName())
		self.last_present = self.jointime + month
	elseif (playtime - self.last_present) > month then
		self:AddLoti(1)
		InputConsole("msg [LuS] %s has received one loti for playing this server for another month!", self:GetName())
		self.last_present = self.last_present + month
	else
		passed = mf.TimePassed(playtime, 5)
		InputConsole("msg [LuS] %s has been playing this server for %d weeks, %d days, %d hours, %d minutes and %d seconds!", self:GetName(), passed['weeks'], passed['days'], passed['hours'], passed['minutes'], passed['seconds'])
	end
end

function Player:UpdateVIP()
	-- Preparing vars	--
	minute = 60; hour = minute*60; day = hour*24; month = day*30
	
	vip_before = self:IsVIP()
	
	viptime = os.time() - self.last_vip_update
	if viptime > month then
		if self.vip_subscribe == 1 then
			self:AddBankCredits(500000)
			self.interest = sc.vipinterest
			if self.last_vip_update < self.jointime or self.vip == 0 then
				self.last_vip_update = os.time()
			else
				self.last_vip_update = self.last_vip_update + month
			end
			self.vip = 1
			InputConsole("ppage %d Your VIP-access is updated and you received 500k!", self.pID)
			self:Save(false)
			self:UpdateVIP()
		else
			if self.vip_months > 0 then
				self:AddBankCredits(500000)
				self.interest = sc.vipinterest
				self.last_vip_update = os.time()
				self:RemoveVIP(1)
				self.vip = 1
				InputConsole("ppage %d Your VIP-access is updated and you received 500k!", self.pID)
				self:Save(false)
			elseif self.vip == 1 then
				self.vip = 0
				self.interest = sc.interest
				gi.CountVips(-1)
				InputConsole("ppage %d Your VIP (premium) access has now ended.", self.pID)
			end
		end
	end
	
	if vip_before == false and self:IsVIP() then
		gi.CountVips(1)
	end
	
	sql = string.format("UPDATE users SET vip_last_update=%d, vip=%d, vip_months=%d, vip_subscription=%d WHERE id=%d", self.last_vip_update, self.vip, self.vip_months, self.vip_subscribe, self.dbid)
	db.Query(sql)
end

function Player:HasAccess(Level)
	if self.access >= Level then
		return true
	else
		return false
	end
end

function Player:SetCurrentSerial(Serial)
	self.currentserial = Serial
end

function Player:GetCurrentSerial()
	return self.currentserial
end

function Player:SetAccountSerial()
	self.accountserial = self.currentserial
	if self:IsLogged() then
		sql = string.format("UPDATE users SET serialhash='%s' WHERE id=%d", self.accountserial, self.dbid)
	else
		sql = string.format("UPDATE users SET serialhash='%s' WHERE nickname LIKE '%s'", self.accountserial, self:GetName())
	end
	db.Query(sql)
end

function Player:GetAccountSerial()
	return self.accountserial
end

function Player:GetCurrentIP()
	return self.currentip
end

function Player:SetAccountIP()
	self.accountip = self.currentip
	if self:IsLogged() then
		sql = string.format("UPDATE users SET ip='%s' WHERE id=%d", self.accountip, self.dbid)
	else
		sql = string.format("UPDATE users SET ip='%s' WHERE nickname LIKE '%s'", self.accountip, self:GetName())
	end
	db.Query(sql)
end

function Player:GetAccountIP()
	return self.accountip
end

function Player:IPRangeUp()
	IP = mf.SplitIP(self.accountip)
	
	for i=4, 2, -1 do
		if IP[i] ~= '*' then
			IP[i] = '*'
			IP = string.format("%s.%s.%s.%s", IP[1], IP[2], IP[3], IP[4])
			self.accountip = IP
			
			sql = string.format("UPDATE users SET ip='%s' WHERE id=%d", self.accountip, self.dbid)
			db.Query(sql)
			return true
		end
	end
	
	return false
end

function Player:SetProtectLevel(Level)
	self.protection = Level
	
	sql = string.format("UPDATE users SET protection=%d WHERE id=%d", self.protection, self.dbid)
	db.Query(sql)
end

function Player:GetProtectLevel()
	return self.protection
end

function Player:SetLoginLevel(Level)
	self.autologin = Level
	
	sql = string.format("UPDATE users SET autologin=%d WHERE id=%d", self.autologin, self.dbid)
	db.Query(sql)
end

function Player:GetLoginLevel()
	return self.autologin
end

function Player:SetBan(State)
	if State == true then
		self.banned = true
	else
		self.banned = false
	end
end

function Player:IsBanned()
	return self.banned
end

function Player:SetSound(State)
	if State == 1 then
		self.sound = 1
		sql = string.format("UPDATE users SET sound=1 WHERE id=%d", self.dbid)
	else
		self.sound = 0
		sql = string.format("UPDATE users SET sound=0 WHERE id=%d", self.dbid)
	end
	db.Query(sql)
end

function Player:GetSound()
	return self.sound
end

function Player:Withdraw(Credits)
	Set_Money(self.pID, Get_Money(self.pID)+Credits)
	self:RemoveBankCredits(Credits)


	self.lastwi = nil; self.lastwi = {}
	self.lastwi['credits'] = Credits
	self.lastwi['time'] = os.time()
end

function Player:UndoLastWi()
	if self.lastwi ~= nil then
		Credits = self.lastwi['credits']
		
		self:AddBankCredits(Credits)
		Set_Money(self.pID, Get_Money(self.pID)-Credits)
		self.lastwi = nil
		InputConsole("ppage %d Your last !wi has been undone (%d Credits).", self.pID, Credits)
	end
end

function Player:GetLastWi()
	if self.lastwi ~= nil then
		return self.lastwi
	else
		return false
	end
end

function Player:RemoveBankCredits(Credits)
	self.bankcredits = self.bankcredits - Credits
end

function Player:AddBankCredits(Credits)
	self.bankcredits = self.bankcredits + Credits
end

function Player:SetBankCredits(Credits)
	self.bankcredits = Credits
end

function Player:GetBankCredits()
	return self.bankcredits
end

function Player:ExchangeRecs(recs)
	credits = recs * 2000
	tax = credits * sc.depotax
	lotto.IncreasePot(tax)
	credits = credits - tax
	
	self:RemoveRecs(recs)
	self:AddBankCredits(credits)
	
	return credits
end

function Player:RemoveRecs(recs)
	self.recs = self.recs - recs
end

function Player:AddRecs(recs)
	self.recs = self.recs + recs
end

function Player:SetRecs(recs)
	self.recs = recs
end

function Player:GetRecs()
	return self.recs
end

function Player:GetTotalCredits(IGCash)
	total = self.bankcredits + (self.recs * 2000)
	if IGCash == true then
		total = total + Get_Money(self.pID)
	end
	return total
end

function Player:OnBankLimit()
	if self:GetTotalCredits(false) > sc.banklimit then
		return true
	else
		return false
	end
end

function Player:RemoveDP(Damage)
	self.dp = self.dp - Damage
end

function Player:AddDP(Damage)
	self.dp = self.dp + Damage
end

function Player:SetDP(Damage)
	self.dp = Damage
end

function Player:GetDP()
	return self.dp
end

function Player:SetPassword(password)
	if password == nil then
		query = string.format("UPDATE users SET password=NULL WHERE nickname='%s'", self:GetName())
	else
		query = string.format("UPDATE users SET password='%s' WHERE nickname='%s'", password, self:GetName())
	end
	db.Query(query)
	
	self.password = password
end

function Player:GetPassword()
	return self.password
end

function Player:IsProtected()
	if self.password ~= nil then
		return true
	else
		return false
	end
end

function Player:SetAccess(Level)
	if self.login == true then
		oldaccess = self.access
		self.access = Level
		query = string.format("UPDATE users SET access=%d WHERE id=%d", self.access, self.dbid)
		db.Query(query)
		
		if oldaccess == 1 and self.access > 1 then
			gi.CountMods(1)
		elseif oldaccess > 1 and self.access == 1 then
			gi.CountMods(-1)
		end
		
		return true
	else
		return false
	end
end

function Player:GetAccess()
	return self.access
end

function Player:IsVIP()
	if self.vip == 1 then
		return true
	else
		return false
	end
end

function Player:GetVIP()
	data = {}
	
	if self.vip_subscribe == 1 then
		data['subscription'] = true
	else
		data['subscription'] = false
	end
	
	data['months'] = self.vip_months
	
	minute = 60; hour = minute*60; day = hour*24; week = day*7; month = day*30
	
	data['last_vip_update'] = self.last_vip_update
	
	viptime_spend = os.time() - self.last_vip_update
	data['vip_left'] = month - viptime_spend
				
	if data['vip_left'] < 0 then
		data['vip_left'] = 0
	end
	
	return data
end

function Player:AddVIP(Months)
	self.vip_months = self.vip_months + Months
	if self.vip_months < 0 then
		self.vip_months = 0
	end
	self:UpdateVIP()
end

function Player:RemoveVIP(Months)
	self.vip_months = self.vip_months - Months
	if self.vip_months < 0 then
		self.vip_months = 0
	end
	self:UpdateVIP()
end

function Player:SetVIP(Months)
	self.vip_months = Months
	if self.vip_months < 0 then
		self.vip_months = 0
	end
	self:UpdateVIP()
end

function Player:AddVIPSub()
	self.vip_subscribe = 1
	self:UpdateVIP()
end

function Player:RemoveVIPSub()
	self.vip_subscribe = 0
	self:UpdateVIP()
end

function Player:RemoveLoti(Loti)
	self.loti = self.loti - Loti
end

function Player:AddLoti(Loti)
	self.loti = self.loti + Loti
end

function Player:SetLoti(Loti)
	self.loti = Loti
end

function Player:GetLoti()
	return self.loti
end

function Player:GetLotiPrice()
	p1 = sc.loti_price_credit
	p2 = self:GetTotalCredits(true) * sc.loti_price_perc
	if p1 > p2 then
		price = p1
	else
		price = p2
	end
	
	return price
end

function Player:SetFreeze(State)
	pObj = Get_GameObj(self.pID)
	if State == true then
		self.freeze = true
		self.frozenpos = Get_Position(pObj)
		Attach_Script_Once(pObj, "freeze", "")
	else
		self.freeze = false
		self.frozenpos = nil
		Remove_Script(pObj, "freeze")
	end
end

function Player:SetFrozenPos()
	if self.frozenpos ~= nil then
		pObj = Get_GameObj(self.pID)
		
		veh = Get_Vehicle(pObj)
		if veh == 0 then
			Set_Position(pObj, self.frozenpos)
		else
			Set_Position(veh, self.frozenpos)
		end
	end
end

function Player:IsFrozen()
	return self.freeze
end

function Player:SetMute(State)
	if State == true then
		self.mute = true
	else
		self.mute = false
	end
end

function Player:IsMuted()
	return self.mute
end

function Player:SetBlockDmg(State)
	if State == true then
		self.blockdmg = true
	else
		self.blockdmg = false
	end
end

function Player:IsDmgBlocked()
	return self.blockdmg
end

function Player:Disable()
	if self.disabled == false then
		pObj = Get_GameObj(self.pID)
		
		veh = Get_Vehicle(pObj)
		if veh ~= 0 then
			Force_Occupants_Exit(veh)
		end
		
		Toggle_Fly_Mode(pObj)
		
		pos = Get_Position(pObj)
		pos.Z = pos.Z + 200
		Set_Position(pObj, pos)
		
		self:SetFreeze(true)
		self:SetMute(true)
		self:SetBlockDmg(true)
		
		self.disabled = true
	end
end

function Player:Enable()
	if self.disabled == true then
		pObj = Get_GameObj(self.pID)
		Toggle_Fly_Mode(pObj)
		
		self:SetFreeze(false)
		self:SetMute(false)
		self:SetBlockDmg(false)
		
		self.disabled = false
	end
end

function Player:IsDisabled()
	return self.disabled
end

function Player:TeleportTo(tID)
	fObj = Get_GameObj(self.pID)
	tObj = Get_GameObj(tID)
	
	veh = Get_Vehicle(tObj)
	if veh ~= 0 then
		Distance = 10
	else
		Distance = 1
	end
	
	pos = Get_Position(tObj)
	Facing = Get_Facing(tObj)
	
	pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
	pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
	
	Set_Position(fObj, pos)
end

function Player:IsValidNick()
	if mf.ValidateNick(self:GetName()) == true then
		return true
	else
		return false
	end
end

function Player:IsValidSerial()
	if mf.ValidateSerial(self.currentserial) == true then
		return true
	else
		return false
	end
end

function Player:MultiKill(vID)
	if os.time() - self.start_killspree > 8 then
		self.kills = 0
		self.last_killed = 0
		self.start_killspree = os.time()
	end
	
	if self.last_killed ~= vID then
		self.kills = self.kills + 1
		if self.kills == 2 then
			InputConsole("msg [LuS] DOUBLE KILL!! %s is on fire!!", self:GetName())
			InputConsole("SNDA m00gsrs_kick0006i1neen_snd.wav")
			
			if self:OnBankLimit() then
				InputConsole("ppage %d You cannot receive the rec because your bank credits + recs have reached the limit", self.pID)
			else
				self:AddRecs(1)
				InputConsole("msg [LuS] %s gains one rec for the double kill!! They now have %d recs!", self:GetName(), self:GetRecs())
			end
		elseif self.kills == 3 then
			InputConsole("msg [LuS] TRIPLE KILL!!! %s is unbelieveable!!!", self:GetName())
			InputConsole("snda m00avis_kifi0003i1moac_snd.wav") 
			
			if self:OnBankLimit() then
				InputConsole("ppage %d You cannot receive the rec because your bank credits + recs have reached the limit", self.pID)
			else
				self:AddRecs(2)
				InputConsole("msg [LuS] %s gains TWO recs for the TRIPLE kill!! They now have %d recs!", self:GetName(), self:GetRecs())
			end
		elseif self.kills == 4 then
			InputConsole("msg [LuS] QUADRUPLE KILL!!!! %s is unstoppable!!!!", self:GetName())
			InputConsole("snda m00ggdi_hesx0019r3gers_snd.wav")
			InputConsole("snda m00ggdi_hesx0019r3gers_snd.wav")
			
			if self:OnBankLimit() then
				InputConsole("ppage %d You cannot receive the rec because your bank credits + recs have reached the limit", self.pID)
			else
				self:AddRecs(3)
				InputConsole("msg [LuS] %s gains THREE recs for the QUADRUPLE kill!! They now have %d recs!", self:GetName(), self:GetRecs())
			end
		end
	end
	self.last_killed = vID
end

function Player:Damage(Damage)
	if self.dp > 10000 then
		if self:OnBankLimit() then
			self:RemoveDP(10000)
			InputConsole("ppage %d Your bank and recs combined are greater then %d, so you cannot recieve the rec.", sID, sc.banklimit)
		else
			self:AddRecs(1)
			self:RemoveDP(10000)
			InputConsole("msg [LuS] %s has been reccomended by [DamageTracker] for obtaining 10,000 damage points! They now have %d recs!", self:GetName(), self.recs)
		end
	else
		Damage = tonumber(Damage)
		if Damage < 0 then
			Damage = Damage*-1
		end				
		self:AddDP(Damage)
	end
end

function Player:PressKey()
	passed = os.time() - self.lastkey
	if passed > 1 then
		self.lastkey = os.time()
		return true
	else
		return false
	end
end

function Player:SetModPower(State, Died)
	if State == true and self.modpower == false then		
		InputConsole("spectate %d", self.pID)
		
		if self:HasAccess(4) then
			pObj = Get_GameObj(self.pID)
			Grant_Powerup(pObj, "POW_Anti-Sound_Emitter")
		end

		self.modpower = true
	elseif self.modpower == true then
		self.modpower = false
		if Died == false then
			InputConsole("spectate %d", self.pID)
		end
	end
end

function Player:GetModPower()
	return self.modpower
end

function Player:SetBonusCreds(State)
	pObj = Get_GameObj(self.pID)
	if State == true then
		self.bonuscreds = true
		Attach_Script_Once(pObj, "JFW_Credit_Trickle", "5,1")
	else
		self.bonuscreds = false
		Remove_Script(pObj, "JFW_Credit_Trickle")
	end
end

function Player:HasBonusCreds()
	return self.bonuscreds
end

function Player:GetScripts()
	return self.scripts
end

function Player:SetScripts(version)
	self.scripts = version
end
