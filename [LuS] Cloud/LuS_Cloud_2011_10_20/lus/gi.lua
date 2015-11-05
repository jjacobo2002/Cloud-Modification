module('gi', package.seeall)

vipcount = 0
modcount = 0
pinfo = {}

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

function ResetPlayerInfo()
	pinfo = nil; pinfo = {}
	for pID, value in pairs(user) do
		AddPlayer(pID)
	end
end

function AddPlayer(pID)
	name = user[pID]:GetName()
	if pinfo[name] == nil then
		pinfo[name] = {}
		pinfo[name].jointime = os.time()
		pinfo[name].moneyspend = 0
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
end
