module('gi', package.seeall)

vipcount = 0
modcount = 0
pinfo = {}
cps = {}
pp = {}
ref = {}

-- All	--
function Reset_All()
	pinfo = nil; pinfo = {}
	for pID, value in pairs(user) do
		AddPlayer(pID)
		if user[pID]:GetAccess() > 1 then
			CountMods(1)
		end
		if user[pID]:IsVIP() then
			CountVips(1)
		end
	end
	
	ResetCPS()
end

-- Vip/Mod Count	--
function CountVips(x)
	vipcount = vipcount + x
	if vipcount < 0 then
		vipcount = 0
	end
end

function GetVipCount()
	return vipcount
end

function CountMods(x)
	modcount = modcount + x
	if modcount < 0 then
		modcount = 0
	end
end

function GetModCount()
	return modcount
end

-- General Player Stuff
function ResetPlayerInfo()
	pinfo = nil; pinfo = {}
	for pID, value in pairs(user) do
		AddPlayer(pID)
		user[pID].BlackJack = "No"
		user[pID].bjdealeractualcount = 0
		user[pID].bjplayeractualcount = 0
		user[pID].bjdealeracecount = 0
		user[pID].bjplayeracecount = 0
		user[pID].bjplayerbet = 0

		user[pID].bjplayercard1 = 0
		user[pID].bjplayercard2 = 0
		user[pID].bjdealercard1 = 0
		user[pID].bjdealercard2 = 0
	end
end

function AddPlayer(pID)
	name = user[pID]:GetName()
	if pinfo[name] == nil then
		pinfo[name] = {}
		pinfo[name].jointime = os.time()
		pinfo[name].moneyspend = 0
		pinfo[name].bk = 0
	end
end

function GetJoinTime(Player)
	return pinfo[Player].jointime
end

function GetAllJoinTimes()
	ret = {}
	
	for pName in pairs(pinfo) do
		table.insert(ret, {jointime = pinfo[pName].jointime, name = pName})
	end
	
	table.sort(ret, function(v1,v2)	return v1.jointime > v2.jointime end)
	
	return ret
end

function AddMoneySpend(Player, Money)
	pinfo[Player].moneyspend = pinfo[Player].moneyspend + Money
end

function RemoveMoneySpend(Player, Money)
	pinfo[Player].moneyspend = pinfo[Player].moneyspend - Money
end

function GetMoneySpend(Player)
	return pinfo[Player].moneyspend
end

function GetAllMoneySpenders()
	ret = {}
	
	for pName in pairs(pinfo) do
		table.insert(ret, {moneyspend = pinfo[pName].moneyspend, name = pName})
	end
	
	table.sort(ret, function(v1,v2)	return v1.moneyspend < v2.moneyspend end)
	
	return ret
end

function AddBuildingKill(Player)
	pinfo[Player].bk = pinfo[Player].bk + 1
end

function GetBuildingKill(Player)
	return pinfo[Player].bk
end

-- CPS Management	--
function GetCPS(team)
	toadd = 0
	
	if ref[team] then
		if pp[team] then
			toadd = toadd + 10
		else
			toadd = toadd + 5
		end
	end
	
	for pID, v in pairs(user) do
		if team == Get_Team(pID) then
			if user[pID]:HasBonusCreds() then
				toadd = toadd + 5
			end
			if user[pID]:IsMrMoney() then
				toadd = toadd + 5
			end
		end
	end
	
	return (cps[team]+toadd)
end

function ResetCPS()
	cps[0] = 0
	cps[1] = 0
	
	pp[0] = true
	pp[1] = true
	
	ref[0] = true
	ref[1] = true
end

function AddCPS(team, persec)
	cps[team] = cps[team] + persec
end

function RemoveCPS(team, persec)
	cps[team] = cps[team] - persec
end