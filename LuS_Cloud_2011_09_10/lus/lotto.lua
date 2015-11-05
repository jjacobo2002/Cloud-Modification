module('lotto', package.seeall)

function IncreasePot(Credits)
	if sc.lotto_total_credits < sc.lotto_limit then
		sc.lotto_total_credits = sc.lotto_total_credits + Credits
	end
end

function DecreasePot(Credits)
	sc.lotto_total_credits = sc.lotto_total_credits - Credits
end

function Execute()
	-- PreVars	--
	disabled = false
	loti = nil; loti = {}
	prize = nil; prize = {}
	leftover_perc = 100
	
	-- Saving so people have their loti's in the game	--
	mf.SaveAll()
	
	-- Start message	--
	InputConsole("msg [LuS] The lotto has started! There is a total of %d credits in the pot!", sc.lotto_total_credits)
	
	-- Counting Loti's	--
	db:Query("", "query_CountLoti", "SELECT SUM(loti), COUNT(id) FROM users WHERE loti > 0")
end

function CountLoti(data)
	-- preparing data	--
	data[1] = tonumber(data[1])
	data[2] = tonumber(data[2])
	
	if data[1] == nil then
		data[1] = 0
	end
	
	if data[2] == nil then
		data[2] = 0
	end
	
	-- Disabling the Lotto if there's less then 20 loti's or less then 5 different players who bought a loti.	--
	if data[1] < 20 or data[2] < 5 then
		disabled = true
	end
	
	total_loti = data[1]
	total_buyers = data[2]
	
	InputConsole("msg [LuS] There are a total of %d loti's bought by %d users.", total_loti, total_buyers)
	
	-- Executing Lotto if it isn't disabled	--
	if disabled == false then
		-- Assigning a unique loti number per player.	--
		buyc = 0
		db:Query("", "query_AssignLoti", "SELECT nickname, loti FROM users WHERE loti > 0")
	else
		InputConsole("msg [LuS] Lotto canceled! Not enough participants.")
		sc.last_lotto = os.time()
		sc.Save()
	end
end

function AssignLoti(data)
	-- Preparing data	--
	data[2] = tonumber(data[2])
	
	-- assigning loti numbers to player names. It generates another random number if the loti number already exists.	--
	for i=1, data[2] do
		loti_number = math.random(total_loti)
		while loti[loti_number] ~= nil do
			loti_number = math.random(total_loti)
		end
		loti[loti_number] = {}
		loti[loti_number]['player'] = data[1]
		loti[loti_number]['prize'] = false
		
		--Message to show which number is assigned to which player. In comment because its SPAMMY in-game	--
		--InputConsole("msg [LuS] Loti number %d has been assigned to: %s", loti_number, loti[loti_number]['player'])
	end
	
	buyc = buyc + 1
	if buyc == total_buyers then
		lotto.CalculateWinners()
	end
end

function CalculateWinners()
	InputConsole("msg [LuS] Calculating prizes and winners...")
		
	-- Calculating Prizes	--
	for i=1, sc.lotto_prizes do
		percent = math.random(1, sc.lotto_max_prize)
		
		if percent > leftover_perc or i == sc.lotto_prizes then
			percent = leftover_perc
		end
		
		if percent > 0 then
			leftover_perc = leftover_perc - percent
			percent = percent / 100
			prize[i] = sc.lotto_total_credits * percent
		end
	end
	
	--Assigning the prizes.
	for index, prizecash in pairs(prize) do
		number = math.random(total_loti)
		
		while loti[number]['prize'] == true do
			number = math.random(total_loti)
		end
		
		pID = mf.FindPlayer("ID", loti[number]['player'])
		if pID == "None" then
			query = string.format("UPDATE users SET credits=credits+%d WHERE nickname='%s'", prizecash, loti[number]['player'])
			db:Query("", "", query)
		else
			user[pID]:AddBankCredits(prizecash)
		end
		lotto.DecreasePot(prizecash)
		query = string.format("INSERT INTO lotto_log (player, time, prize) VALUES ('%s', %d, %d)", loti[number]['player'], os.time(), prizecash)
		db:Query("", "", query)
		InputConsole("msg [LuS] Lotto: %s has won %d credits!", loti[number]['player'], prizecash)
		loti[number]['prize'] = true
	end
	
	sc.last_lotto = os.time()
	sc.Save()
	for pID, value in pairs(user) do
		if user[pID]:GetDbID() ~= 0 then
			user[pID]:SetLoti(0)
			user[pID]:Save(false)
		end
	end
	lotto.ResetAllLoti()
end

function ResetAllLoti()
	db:Query("", "", "UPDATE users SET loti=0")
end

function Command(pID, Message)
	if Message[1] == "!lotto" then
		if user[pID]:HasAccess(1) then
			next_lotto = sc.last_lotto + sc.lotto_wait
			wait_time = next_lotto - os.time()
			
			if wait_time < 1 then
				lotto.Execute()
			else
				passed = {}
				passed = mf.TimePassed(wait_time, 4)

				InputConsole("msg [LuS] The lottopot currently holds %d credits! The next lotto will be executed in %d days, %d hours, %d minutes and %d seconds!", sc.lotto_total_credits, passed['days'], passed['hours'], passed['minutes'], passed['seconds'])
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!lotiprice" then
		if user[pID]:HasAccess(1) then
			InputConsole("ppage %d A loti costs %d credits for you.", pID, user[pID]:GetLotiPrice())
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!loti" then
		if user[pID]:HasAccess(1) then
			price = user[pID]:GetLotiPrice()
			if Get_Money(pID) < price then
				InputConsole("ppage %d You need %d credits to buy a loti.", pID, price)
			else
				Set_Money(pID, Get_Money(pID) - price)
				lotto.IncreasePot(price*sc.to_lotto)
				user[pID]:AddLoti(1)
				InputConsole("ppage %d You have bought a loti, you now have %d loti's.", pID, user[pID]:GetLoti())
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	return nil
end
