module('revival', package.seeall)

--[[ Cloud Revival Award Plugin for August 26 2011

To Install/Activate:
1. Make sure this file is in the following folder: Server\LuaPlugins\modules\ and is called 'revival.lua'
2. Make sure the table "reward" exists in the database, if it doesn't, execute the following query (Execute SQL tab in FF SQLite Manager):
	CREATE TABLE "reward" ("nickname" VARCHAR NOT NULL  UNIQUE , "reward" INTEGER NOT NULL  DEFAULT 0)
3. Paste the following line somewhere at the beginning of the file (like near db = sqlite(file)):
	require 'LuaPlugins\\modules\\revival'
4. In OnPlayerJoin, paste the following line at the top:
	revival.PlayerJoin(Nick, pID)
5. In OnPlayerLeave, paste the following line at the top:
	revival.PlayerLeave(user[pID]['name'])
6. Paste the following function somewhere in the file:
	function query_rewards(Nick, argc, data, name)
		revival.LoadData(Nick, data)
	end

	
To Remove/Deactivate, remove every line you placed while following the "Install/Activate" guide. These are probably:
	require 'LuaPlugins\\modules\\revival'
	revival.PlayerJoin(Nick, pID)
	revival.PlayerLeave(user[pID]['name'])
	function query_rewards(Nick, argc, data, name)
		revival.LoadData(Nick, data)
	end
]]

rewards = {}
totalplayers = 0
award_from = 15 -- Change this to 0 or 1 if you want to test it :P

function PlayerJoin(Nick, pID)
	Nick = string.lower(Nick)
	rewards[Nick] = {}
	rewards[Nick].pID = pID
	rewards[Nick].recv = false
	sql = string.format("SELECT COUNT(*), reward FROM reward WHERE nickname='%s'", Nick)
	db:Query(Nick, "query_rewards", sql)
end

function PlayerLeave(Nick)
	Nick = string.lower(Nick)
	
	rewards[Nick] = nil
	totalplayers = totalplayers - 1
end

function LoadData(Nick, data)
	Nick = string.lower(Nick)
	result = tonumber(data[1])
	reward = tonumber(data[2])
	if rewards[Nick] ~= nil and rewards[Nick].recv == false then
		if result == 0 then
			sql = string.format("INSERT INTO reward (nickname) VALUES ('%s')", Nick)
			db:Query("", "", sql)
			rewards[Nick].recv = 0
		else
			rewards[Nick].recv = reward
		end
		totalplayers = totalplayers + 1
		AwardCredits()
	end
end

function AwardCredits()
	if totalplayers >= award_from then
		InputConsole("msg Yay! %d players in-game! *hands out rewards*", totalplayers)
		for Nick, v in pairs(rewards) do
			pID = rewards[Nick].pID
			credits = 0
			if rewards[Nick].recv < award_from then
				rewards[Nick].recv = award_from
				credits = credits + 100000
			end
			
			if totalplayers > rewards[Nick].recv then
				dif = totalplayers - rewards[Nick].recv
				credits = credits + (dif * 10000)
				rewards[Nick].recv = totalplayers
			end
			
			if user[pID] ~= nil and user[pID]['dbID'] ~= 0 then
				user[pID]['bank_credits'] = user[pID]['bank_credits'] + credits
				save_data(pID, "lotto")
			else
				sql = string.format("UPDATE users SET credits=credits+%d WHERE nickname LIKE '%s'", credits, Nick)
				db:Query("", "", sql)
			end
			
			sql = string.format("UPDATE reward SET reward=%d WHERE nickname='%s'", rewards[Nick].recv, Nick)
			db:Query("", "", sql)
			
			InputConsole("ppage %d You have been awared %d credits! Yay!!", pID, credits)
		end
	end
end