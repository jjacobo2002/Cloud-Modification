module('db', package.seeall)

--require('LuaPlugins\\lus\\lib\\lsqlite3')
--sqldb = sqlite3.open('LuaPlugins\\lus\\data\\lus.sqlite')

sqldb = sqlite('LuaPlugins\\lus\\data\\lus.sqlite')

function Close()
	--sqldb:close()
end

function Query(sql)
	result = nil; result = {}

	--sqldb:exec(sql, callback)
	sqldb:Query("", "callback", sql)

	return result
end

function callback(notused, argc, data, cname)
	row = nil; row = {}
	for k, v in pairs(data) do
		row[cname[k]] = v
	end
	

	table.insert(result, row)
	return 0
end
