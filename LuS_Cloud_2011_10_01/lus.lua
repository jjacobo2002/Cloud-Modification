function InputConsole(...)
	Console_Input(string.format(unpack(arg)))
end

--------------
-- Hooks	--
--------------

function Radio_Hook(Team, pID, a, RadioId, b)
	if user[pID]:IsMuted() then
		return 0
	end
	return 1
end

function Damage_Hook(pID, Damager, Target, Damage, Warhead)
	if user[pID]:IsDmgBlocked() then
		return 0
	end
	return 1
end

function OnError(Error)
	print(Error)
	if irc ~= nil and irc.IRC_Client ~= -1 then
		msg = irc.ToColor(string.format("Error: %s", Error), "04")
		irc.SendMsg(msg)
	end
end

function OnPlayerJoin(pID, Nick)
	-- Preparing the base-table for users (Logged Out/New)	--
	user[pID] = uc.Player:Init(pID, Nick)
	RequestSerial(pID)
	InputConsole("version %d", pID)
	
	-- Adds the player to the list of players for the auto-balance.
	if tc.autobalance then
		tc.AddPlayer(pID)
	end
	
	-- Adds the player to the game-info list
	gi.AddPlayer(pID)
	
	-- (re)calculating the max pID	--
	if pID > max_pID then
		max_pID = pID
	end
	
	-- Start Auto-Balance if no mods are in-game	--
	if gi.GetModCount() == 0 then
		tc.StartBalance()
	end
end

function OnPlayerLeave(pID)
	-- !noob + leave check	--
	username = user[pID]:GetName()
	if caninoob[username] ~= nil then
		timepassed = os.time() - caninoob[username]['time']
		if timepassed <= 10 then
			tID = caninoob[username]['tID']
			if user[tID] ~= nil and user[tID]:GetName() == caninoob[username]['tName'] then
				user[tID]:AddRecs(1)
				InputConsole("msg [LuS] gave a free rec to %s! Don't tell %s!.", user[tID]:GetName(), username)
			end
		end
	end

	-- Logging out the user	--
	if user[pID] == nil then
		InputConsole("msg [LuS] Error: %s has left the game without having a usertable! Please contact an Admin!", user[pID]:GetName())
	elseif user[pID]:GetDbID() ~= 0 then
		user[pID]:Logout(true)
		user[pID] = nil
	elseif user[pID] ~= nil then
		InputConsole("msg [LuS] Bye %s! (User was logged out)", user[pID]:GetName())
		user[pID] = nil
	else
		InputConsole("msg [LuS] Error: %s has left the game with malformed data! Please contact an Admin!", user[pID]:GetName())
		user[pID] = nil
	end
	
	-- (re)calculating the max pID	--
	if pID == max_pID then
		max_pID = max_pID - 1
		while user[max_pID] == nil and max_pID > 0 do
			max_pID = max_pID - 1
		end
	end
	
	-- Start Auto-Balance if no mods are in-game	--
	if gi.GetModCount() == 0 then
		tc.StartBalance()
	end
end

function OnLevelLoaded()
	-- Setting the randomseed for this game	--
	mf.SetRandomSeed()

	-- Loads/Save Server Configuration	--
	sc.Save()
	
	-- Increasing the lottopot	--
	lotto.IncreasePot(2500)
	
	-- Allowing Interest	--
	for pID, v in pairs(user) do
		user[pID]:AllowInterest()
	end
	
	-- Setting starttime of this game.	--
	gametime_start = os.time()

	-- Resetting !noob, !rec and !freezer	--
	caninoob = nil; caninoob = {}	
	canirec = nil; canirec = {}
	gamble.ResetFreezer()
	
	-- Attaching Scripts to all the buildings	--
	for x, Building in pairs(Get_All_Buildings()) do
		LuS_Attach_Scripts(Building, { lus_killed="", lus_damaged="" })
	end
	
	-- Starting MVP Reward	--
	invispos = { X = 10, Y = 10, Z = 10 }
	invisobj = Create_Object("invisible_object", invispos)
	if invisobj ~= nil then
		Attach_Script_Once(invisobj, "wingame", "")
	end
	
	-- Reset Player Info from gi.lua	--
	gi.ResetPlayerInfo()
	
	-- VIP Balance	--
	if gi.GetVipCount() > 3 then
		tc.BalanceVIP()
	end
end

function OnObjectCreate(Object)
	if Is_Vehicle(Object) then
		LuS_Attach_Scripts(Object, { lus_vehaction="", lus_damaged="", lus_poked="" })
	end
	
	if Is_Soldier(Object) and Is_A_Star(Object) == false then
		--LuS_Attach_Scripts(Object, { lus_damaged="", lus_poked="" }) -- Causes crashes with alot of bots
	end
	
	if Is_A_Star(Object) then
		pID = Get_Player_ID(Object)
		
		LuS_Attach_Scripts(Object, { lus_killed="", lus_damaged="", lus_poked="" })
		
		if user[pID]:InterestAllowed() then
			Attach_Script_Once(Object, "interest_save", "")
		end
		
		if user[pID]:IsFrozen() then
			Attach_Script_Once(Object, "freeze", "")
		end
		
		if user[pID]:IsDisabled() then
			Toggle_Fly_Mode(Object)
		end
		
		if user[pID]:HasBonusCreds() then
			Attach_Script_Once(Object, "JFW_Credit_Trickle", "5,1")
		end
		
		if user[pID]:GetModPower() then
			user[pID]:SetModPower(false, true)
		end
	end
end

function Serial_Hook(pID, Serial)
	if user[pID] ~= nil then
		user[pID]:SetCurrentSerial(Serial)
		
		-- Join Log	--
		query = string.format("SELECT COUNT(*) as count, id FROM join_log WHERE nickname = '%s' AND ip = '%s' AND serialhash = '%s'", user[pID]:GetName(), user[pID]:GetCurrentIP(), user[pID]:GetCurrentSerial())
		result = db.Query(query)
		
		data = result[1]
		
		if tonumber(data.count) == 0 then
			query = string.format("INSERT INTO join_log (first_time, last_time, nickname, ip, serialhash) VALUES(%d, %d, '%s', '%s', '%s')", os.time(), os.time(), user[pID]:GetName(), user[pID]:GetCurrentIP(), user[pID]:GetCurrentSerial())
			db.Query(query)
		else
			query = string.format("UPDATE join_log SET last_time=%d, total_times=total_times+1 WHERE id=%d", os.time(), data.id)
			db.Query(query)
		end
		
		-- IRC Join message	--
		msg = irc.ToColor(string.format("[Join] %s@%s (Serialhash: %s)", user[pID]:GetName(), user[pID]:GetCurrentIP(), user[pID]:GetCurrentSerial()), "03")
		irc.SendMsg(msg)
		
		-- Check if banned	--
		SIP = mf.SplitIP(user[pID]:GetCurrentIP())
		query = string.format([[SELECT COUNT(*) as count
								FROM banlist
								WHERE ((type='nickname' AND value='%s')
									OR (type='ip' AND value='%s')
									OR (type='serial' AND value='%s')
									OR (type='iprange' AND (value='%s.*.*.*' OR value='%s.%s.*.*' OR value='%s.%s.%s.*')))
								AND (expiration = 0 OR expiration > %d)
								ORDER BY expiration ASC LIMIT 1]], user[pID]:GetName(), user[pID]:GetCurrentIP(), user[pID]:GetCurrentSerial(), SIP[1], SIP[1], SIP[2], SIP[1], SIP[2], SIP[3], os.time())
		result = db.Query(query)
		data = result[1]
	
		if tonumber(data.count) > 0 then
			user[pID]:SetBan(true)
			user[pID]:Logout(false)
		end
		
		-- Trying to log the user in	--
		user[pID]:Login()
	end
end

function Suicide_Hook(pID)
	InputConsole("ppage %d Please use the !killme command instead.", pID)
	return 0
end

function OnPlayerVersion(pID, Version)
	if user[pID] ~= nil then
		user[pID]:SetScripts(Version)
	end
end

function Unload()
	if db ~= nil and type(db['Close']) == "function" then
		db.Close()
	end
end

function OnChat(pID, Type, Message, Target)
	if user[pID] == nil then
		return 1
	end

	-- If user is muted, return 0	--
	if user[pID]:IsMuted() then
		return 0
	end
	
	-- Key Hook	--
	key = string.match(Message, "k\n([^\r\n]+)\n")
	if key ~= nil then
		Key_Hook(pID, key)
		return 1
	end
	
	-- Doesn't check for commands if the message Accessing a PT or game hasn't started that long yet	--
	if Target < -1 or (os.time()-gametime_start) < 3 then
		return 1
	end
	
	-- PM Log	--
	if Type == 2 and user[Target] ~= nil then
		msg = irc.ToColor(string.format("PM (%s -> %s): %s", user[pID]:GetName(), user[Target]:GetName(), Message), "12")
		irc.SendMsg(msg)
		return 1
	end
	
	-- Sounds	--
	sounds.Play(Message)
	
	-- Splitting the Message	--
	Message = mf.SplitMessage(Message)
	
	-- Chat Commands in modules	--
	for k, v in pairs(module_list) do
		moduname = v[1]
		if v[5] then
			cmd = _G[moduname].Command(pID, Message)
			if cmd then
				return cmd
			end
		end
	end
	
	return 1
end

----------------------
-- LuS Custom Hooks	--
----------------------

function Key_Hook(pID, Key)
	if user[pID]:HasAccess(1) then
		if user[pID]:PressKey() then
			usercmd.Key(pID, Key)
		end
	end
	if user[pID]:HasAccess(2) then
		modcmd.Key(pID, Key)
	end
end

function LuS_Killed(VictimObj, KillerObj)
	if Is_A_Star(KillerObj) and Is_A_Star(VictimObj) then
		vID = Get_Player_ID(VictimObj)
		kID = Get_Player_ID(KillerObj)
	
		-- Multikill	--
		if user[kID] ~= nil and user[vID] ~= nil and kID ~= vID then
			user[kID]:MultiKill(vID)
		end
		
		-- Robber	--
		char.Robber(kID, KillerObj, vID)
	end
	
	if Is_Building(VictimObj) then
		if Is_A_Star(KillerObj) then
			pID = Get_Player_ID(KillerObj)
			if user[pID]:OnBankLimit() then
				InputConsole("msg [LuS] %s has destroyed the %s!", user[pID]:GetName(), Get_Preset_Name(VictimObj))
				InputConsole("ppage %d You have over %d credits in bank+recs combined, you cannot recieve the rec.", pID, sc.banklimit)
			else
				user[pID]:AddRecs(1)
				InputConsole("snda m00bnaf_kill0022i1nemg_snd.wav")
				InputConsole("msg [LuS] %s has been recommended for destroying the %s! They now have %d recs!", user[pID]:GetName(), Get_Preset_Name(VictimObj), user[pID]:GetRecs())
			end
		else
			InputConsole("msg [LuS] %s has destroyed the %s!", Get_Preset_Name(KillerObj), Get_Preset_Name(VictimObj))
		end
	end
end

function LuS_Damaged(DamagedObj, ShooterObj, Damage)
	if Is_A_Star(ShooterObj) then
		sID = Get_Player_ID(ShooterObj)
		
		if user[sID] ~= nil and user[sID]:IsLogged() and DamagedObj ~= ShooterObj then
			user[sID]:Damage(Damage)
		end
	end
end

function LuS_Veh_Enter(VehicleObj, PlayerObj)
	
end

function LuS_Veh_Exit(VehicleObj, PlayerObj)
	
end

function LuS_Poked(PokedObj, PokerObj)
	
end

------------------
-- Timer Stuff	--
------------------

function OnThink()
	if tClock() - TimerCount > 200 then
		TimerCount = tClock()
		Timers()
	end
end

function Timers()
	irc.Think()
	
	if tClock() - Clock_2sec > 2000 then
		Clock_2sec = tClock()
		if tc.autobalance then
			tc.BalanceNow()
		end
		if RM_Timer < os.time() and max_pID > 0 then
			random_rm = math.random(1, table.maxn(rm.rmsg))
			if rm.rmsg[random_rm] then
				rm.rmsg[random_rm]()
			end
			RM_Timer = os.time() + math.random(5, 120)
		end
	end
end

----------------------
-- Custom Scripts	--
----------------------
function LuS_Attach_Scripts(Obj, Scripts)
	if Obj ~= nil and type(Scripts) == "table" then		
		for script, arg in pairs(Scripts) do
			Attach_Script_Once(Obj, script, arg)
		end
	end
end

-- LuS Callbacks	--
lus_killed = {}
function lus_killed:Killed(ID, obj, killer)
	LuS_Killed(obj, killer)
end
Register_Script("lus_killed", "", lus_killed)

lus_damaged = {}
function lus_damaged:Damaged(ID, obj, shooter, damage)
	if damage >= 1 then
		LuS_Damaged(obj, shooter, damage)
	end
end
Register_Script("lus_damaged", "", lus_damaged)

lus_vehaction = {}
function lus_vehaction:Custom(ID, obj, message, param, sender)
	if message == CUSTOM_EVENT_VEHICLE_ENTER then
		LuS_Veh_Enter(obj, sender)
	elseif message == CUSTOM_EVENT_VEHICLE_EXIT then
		LuS_Veh_Exit(obj, sender)
	end
end
Register_Script("lus_vehaction", "", lus_vehaction)

lus_poked = {}
function lus_poked:Poked(ID, obj, poker)
	if Is_A_Star(poker) then
		LuS_Poked(obj, poker)
	end
end
Register_Script("lus_poked", "", lus_poked)

-- Other	--
interest_save = {}
function interest_save:Created(ID, obj)
	Start_Timer(ID, obj, 5, 0)
end
function interest_save:Timer_Expired(ID, obj, num)
	pID = Get_Player_ID(obj)
	if user[pID] == nil then
		InputConsole("msg [LuS] Error: Player id %d doesn't have a usertable, please contact an admin!", pID)
	elseif user[pID]:InterestAllowed() then		
		if user[pID]:OnBankLimit() then
			InputConsole("ppage %d Your bank is full, please spend some credits.", pID)
		else
			user_interest = user[pID]:GetBankCredits() * user[pID]:GetInterest()
			user[pID]:AddBankCredits(user_interest)
			InputConsole("ppage %d You received %d credits interest.", pID, user_interest)
		end
	
		-- Updating VIP state	--
		user[pID]:UpdateVIP()
		
		-- Saving data	--
		user[pID]:Save(false)
		user[pID]:DisallowInterest()
	end
end
Register_Script("interest_save", "", interest_save)

wingame = {}
function wingame:Created(ID, obj)   
	Start_Timer(ID, obj, 5, 0)
end
function wingame:Timer_Expired(ID, obj, num)
	tc.BalanceVIP()

	current_game = {}
	current_game = The_Game()
	if current_game['MVPName'] == nil then
		InputConsole("msg [LuS] Error: Could not get the MVP Name.")
	else
		if current_game['MVPName'] == "" then
			InputConsole("msg [LuS] There was no MVP last game!")
		else
			InputConsole("msg [LuS] %s was the MVP last game!", current_game['MVPName'])
			mobj = Get_GameObj_By_Player_Name(current_game['MVPName'])
			mID = Get_Player_ID(mobj)
			if mID ~= nil then
				if user[mID] ~= nil then
					if user[mID]:OnBankLimit() then
						InputConsole("msg [LuS] %s has over %d in the bank + recs combined, and cannot recieve the MVP rec.", user[mID]:GetName(), sc.banklimit)
					else
						user[mID]:AddRecs(1)
						InputConsole("msg [LuS] %s gains one rec for being MVP!! They now have %d recs!", user[mID]:GetName(), user[mID]:GetRecs())
					end
				end
			else
				InputConsole("msg [LuS] Error: Could not get the Player ID from the MVP")
			end
		end
	end
	
	Destroy_Object(obj)
end
Register_Script("wingame", "", wingame)

freeze = {}
function freeze:Created(ID, obj)
	Start_Timer(ID, obj, 1, 0)
end
function freeze:Timer_Expired(ID, obj, num)
	pID = Get_Player_ID(obj)
	user[pID]:SetFrozenPos()
	
	Start_Timer(ID, obj, 1, 0)
end
Register_Script("freeze", "", freeze)

openfreezer = {}
function openfreezer:Created(ID, obj)
	seconds = math.random(8, 30)
	Start_Timer(ID, obj, seconds, 0)
end
function openfreezer:Timer_Expired(ID, obj, num)
	pID = Get_Player_ID(obj)
	gamble.AutoClose(pID)
end
function openfreezer:Killed(ID, vObj, kObj)
	pID = Get_Player_ID(vObj)
	gamble.AutoClose(pID)
end
Register_Script("openfreezer", "", openfreezer)

-- Temp Query Callback
function callback(notused, argc, data, cname)
	db.callback(notused, argc, data, cname)
end

-------------
-- Modules --
-------------
function load_modules(modu)
	loaded = ""

	for k, v in pairs(module_list) do
		name = v[1]; reload = v[2]; load_action = v[3]; unload_action = v[4]; canload = false; found = false;

		if type(modu) == "string" then
			if modu == name then
				if reload == true then
					canload = true
				end
				found = true
			end
		elseif type(modu) == "boolean" then
			if modu == false or reload == true then
				canload = true
			end
		end

		if canload == true then
			packname = string.format('LuaPlugins\\lus\\%s', name)
			if unload_action ~= false and package.loaded[packname] ~= nil then
				assert(loadstring(unload_action))()
			end
			
			package.loaded[packname] = nil
			require(packname)

			if load_action ~= false then
				assert(loadstring(load_action))()
			end

			if loaded ~= "" then
				loaded = loaded .. ", "
			end
			loaded = loaded .. name
		end

		if found then
			break
		end
	end

	if found == true and loaded == "" then
		msg = string.format("Can't reload module '%s'. Please restart the server to reload this module.", name)
	elseif loaded == "" then
		msg = string.format("Module '%s' does not exist.", modu)
	elseif modu == true or type(modu) == "string" then
		msg = string.format("Reloaded module(s): %s", loaded)
	else
		msg = string.format("Loaded module(s): %s", loaded)
	end
	
	print(msg)
	return msg
end

--[[ Module List
		Values:
			1. String: The module file name (without the extension)
			2. Boolean:	Can it reload after it's loaded
			3. String/Boolean: Function to call when the module is (re)loaded. False if there isn't one
			4. String/Boolean: Function to call when the module is unloaded when reloading. False if there isn't one
			5. Boolean: true if it has a function called "Command(pID, Message)" to handle chat commands. False if not.
]]
module_list = 	{
					{'db', true, false, 'db.Close()', false},
					{'mf', true, false, false, false},
					{'modcmd', true, false, false, true},
					{'helpcmd', true, false, false, true},
					{'sc', true, 'sc.Load()', false, false},
					{'uc', false, false, false, false},
					{'usercmd', true, false, false, true},
					{'lotto', true, false, false, true},
					{'char', true, false, false, true},
					{'build', true, false, false, true},
					{'bots', true, false, false, true},
					{'upg', true, false, false, true},
					{'gamble', true, false, false, true},
					{'vip', true, false, false, true},
					{'gi', true, 'gi.Reset_All()', false, false},
					{'tc', true, false, false, false},
					{'irc', true, 'irc.Connect()', 'irc.Quit("Reloading module")', false},
					{'ircuc', false, false, false, false},
					{'ircmd', true, false, false, false},
					{'veh', true, false, false, true},
					{'rm', true, false, false, true},
					{'sounds', true, 'sounds.LoadSounds()', false, false}
				}

----------
-- Init --
----------
Clock_2sec = 0
TimerCount = 0
RM_Timer = os.time() + math.random(30, 90)

CUSTOM_EVENT_VEHICLE_ENTER = 1000000028
CUSTOM_EVENT_VEHICLE_EXIT = 1000000029

Config_File = "LuaPlugins\\lus\\data\\lus.ini"

user = {}
ircuser = {}
max_pID = 0

load_modules(false)

------------------------------
--Unused Functions/Hooks	--
------------------------------
function Loading_Hook(pID, Loading)
end

function Load()
end

function OnHostMessage(pID, Type, Message)
end

function OnGameOver()
end

function OnConsoleOutput(Message)
end

function OnCharacterPurchase(Purchaser, Cost, Preset, PurchaserRet)
end

function OnVehiclePurchase(Purchaser, Cost, Preset, PurchaserRet)
end

function OnPowerupPurchase(Purchaser, Cost, Preset, PurchaserRet)
end

function OnDDE(Message)
end

function Ping_Hook(pID, Ping)
end
