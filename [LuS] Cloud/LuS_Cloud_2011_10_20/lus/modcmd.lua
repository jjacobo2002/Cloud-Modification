module('modcmd', package.seeall)

function Key(pID, Key)
	if Key == "t10m" and user[pID]:GetModPower() then
		pObj = Get_GameObj(pID)
	
		pos = Get_Position(pObj)
		Facing = Get_Facing(pObj)
		Distance = 10
		pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
		pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
		
		Set_Position(pObj, pos)
	end
end

function Command(pID, Message)
	if Message[1] == "!rm" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil or Message[2] == "all" then
				InputConsole("msg [LuS] %s", load_modules(true))
			else
				InputConsole("msg [LuS] %s", load_modules(Message[2]))
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!islogged" then
		if user[pID]:HasAccess(2) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					if user[tID]:IsLogged() then
						InputConsole("ppage %d Player %s is logged in.", pID, user[tID]:GetName())
					else
						InputConsole("ppage %d Player %s is NOT logged in.", pID, user[tID]:GetName())
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!removepass" then
		if user[pID]:HasAccess(3) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					if user[tID]:GetAccess() > user[pID]:GetAccess() then
						InputConsole("ppage %d You can not remove the password of someone with a higher access level than you.", pID)
					else
						user[tID]:SetPassword(nil)
						InputConsole("ppage %d You removed the password of %s", pID, user[tID]:GetName())
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!passwordset" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					if user[tID]:GetAccess() > user[pID]:GetAccess() then
						InputConsole("ppage %d You can not set the password of someone with a higher access level than you.", pID)
					else
						if Message[3] == nil then
							InputConsole("ppage %d You need to fill in a password.", pID)
						elseif string.match(Message[3], "^%w+$") == nil then
							InputConsole("ppage %d The new password can only contain alphanumeric characters (A-Z,0-9).", pID)
						else
							user[tID]:SetPassword(Message[3])
							InputConsole("ppage %d %s their password has been set to: %s", pID, user[tID]:GetName(), user[tID]:GetPassword())
						end
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 0
	end
	
	if Message[1] == "!isprotected" then
		if user[pID]:HasAccess(2) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					if user[tID]:IsLogged() == false then
						sql = string.format("SELECT password FROM users WHERE nickname LIKE '%s'", user[tID]:GetName())
						result = db.Query(sql)
						data = result[1]
						
						if data.password ~= nil then
							InputConsole("ppage %d This player does have a password set and should be protected!", pID)
						else
							InputConsole("ppage %d This player does NOT have a password set and is NOT protected!", pID)
						end
					elseif user[tID]:IsProtected() then
						InputConsole("ppage %d This player does have a password set and should be protected!", pID)
					else
						InputConsole("ppage %d This player does NOT have a password set and is NOT protected!", pID)
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!tabletest" then
		if user[pID]:HasAccess(2) then
			tabletest = nil; tabletest = {}
			tabletest['logged_in'] = 0
			tabletest['logged_out'] = 0
			tabletest['wtf'] = 0
			
			for tID, value in pairs(user) do
				if user[tID] ~= nil then
					if user[tID]:GetDbID() ~= 0 and user[tID]:IsLogged() then
						tabletest['logged_in'] = tabletest['logged_in'] + 1
					elseif user[tID]:GetDbID() == 0 and user[tID]:IsLogged() == false then
						tabletest['logged_out'] = tabletest['logged_out'] + 1
					else
						tabletest['wtf'] = tabletest['wtf'] + 1
					end
				end
			end
			total_players = Get_Player_Count()
			tabletest['unknown'] = total_players - (tabletest['logged_in'] + tabletest['logged_out'] + tabletest['wtf'])
			InputConsole("msg [LuS] Test Results: Logged_In(%d), Logged_Out(%d), Transformed_Data(%d), Unknown_Data(%d)", tabletest['logged_in'], tabletest['logged_out'], tabletest['wtf'], tabletest['unknown'])
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!setaccess" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					if Message[3] == nil or tonumber(Message[3]) == nil then
						InputConsole("ppage %d You need to fill in a number representing the access level.", pID)
					else
						AccessLevel = tonumber(Message[3])
						if pID == tID then
							InputConsole("ppage %d You can't change your own access level.", pID)
						elseif AccessLevel > user[pID]:GetAccess() then
							InputConsole("ppage %d You can't give someone a higher access level than your own.", pID)
						elseif AccessLevel < 0 then
							InputConsole("ppage %d You can't give someone an access level lower then 0.", pID)
						else
							if user[tID]:SetAccess(AccessLevel) then
								InputConsole("ppage %d %s their access level has been set to level %d.", pID, user[tID]:GetName(), AccessLevel)
								InputConsole("ppage %d Your access level has been set to level %d.", tID, AccessLevel)
							else
								InputConsole("ppage %d [Error] User %s is not logged in.", pID, user[tID]:GetName())
							end
						end
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!getaccess" then
		if user[pID]:HasAccess(2) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					InputConsole("ppage %d %s his/her access level is: %d.", pID, user[tID]:GetName(), user[tID]:GetAccess())
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!getvip" then
		if user[pID]:HasAccess(2) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					vipdata = user[tID]:GetVIP()
					if user[tID]:IsVIP() then
						InputConsole("ppage %d This user IS a VIP/Premium player!", pID)
						if vipdata['subscription'] then
							InputConsole("ppage %d This user has a VIP-Subscription and will be a VIP till they stop their subscription.", pID)
						else
							passed = mf.TimePassed(vipdata['vip_left'], 5)
							InputConsole("ppage %d This user has %d months, %d weeks, %d days, %d hours, %d minutes and %d seconds of VIP/Premium access left.", pID, vipdata['months'], passed['weeks'], passed['days'], passed['hours'], passed['minutes'], passed['seconds'])
						end
					else
						InputConsole("ppage %d This user is NOT a VIP/Premium player.", pID)
						if vipdata['last_vip_update'] > 0 then
							Date = os.date('%c', vipdata['last_vip_update'])
							InputConsole("ppage %d Last VIP Update for this user was on: %s", pID, Date)
						else
							InputConsole("ppage %d This user never had VIP/Premium access before", pID)
						end
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!addvip" then
		if user[pID]:HasAccess(5) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					if Message[3] == nil or tonumber(Message[3]) == nil then
						InputConsole("ppage %d You need to fill in a number representing the amount of months.", pID)
					else
						Months = tonumber(Message[3])
						vipdata = user[tID]:GetVIP()
						if user[tID]:IsLogged() then
							if vipdata['subscription'] then
								InputConsole("ppage %d This player already has a subscription. There is no use in adding months.", pID)
							else
								InputConsole("ppage %d You added %d months of premium to %s.", pID, Months, user[tID]:GetName())
								InputConsole("ppage %d You have received %d months of premium access.", tID, Months)
								user[tID]:AddVIP(Months)
							end
						else
							InputConsole("ppage %d [Error] User %s is not logged in.", pID, user[tID]:GetName())
						end
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!removevip" then
		if user[pID]:HasAccess(5) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					if Message[3] == nil or tonumber(Message[3]) == nil then
						InputConsole("ppage %d You need to fill in a number representing the amount of months.", pID)
					else
						Months = tonumber(Message[3])
						vipdata = user[tID]:GetVIP()
						if user[tID]:IsLogged() then
							if vipdata['subscription'] then
								InputConsole("ppage %d This player already has a subscription. There is no use in removing months.", pID)
							else
								InputConsole("ppage %d You removed %d months of premium from %s.", pID, Months, user[tID]:GetName())
								InputConsole("ppage %d %d months of premium have been removed.", tID, Months)
								user[tID]:RemoveVIP(Months)
							end
						else
							InputConsole("ppage %d [Error] User %s is not logged in.", pID, user[tID]:GetName())
						end
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!setvip" then
		if user[pID]:HasAccess(5) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					if Message[3] == nil or tonumber(Message[3]) == nil then
						InputConsole("ppage %d You need to fill in a number representing the amount of months.", pID)
					else
						Months = tonumber(Message[3])
						vipdata = user[tID]:GetVIP()
						if user[tID]:IsLogged() then
							if vipdata['subscription'] then
								InputConsole("ppage %d This player already has a subscription. There is no use in changing months.", pID)
							else
								InputConsole("ppage %d You have set the premium of %s to %d months.", pID, user[tID]:GetName(), Months)
								InputConsole("ppage %d Your premium have been set to %d months.", tID, Months)
								user[tID]:SetVIP(Months)
							end
						else
							InputConsole("ppage %d [Error] User %s is not logged in.", pID, user[tID]:GetName())
						end
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!addvipsub" then
		if user[pID]:HasAccess(5) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					vipdata = user[tID]:GetVIP()
					if user[tID]:IsLogged() then
						if vipdata['subscription'] then
							InputConsole("ppage %d This player already has a VIP-subscription.", pID)
						else
							InputConsole("ppage %d %s has been added to the VIP-subscribers.", pID, user[tID]:GetName())
							InputConsole("ppage %d you have been added to the VIP-subscribers.", tID)
							user[tID]:AddVIPSub()
						end
					else
						InputConsole("ppage %d [Error] User %s is not logged in.", pID, user[tID]:GetName())
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!removevipsub" then
		if user[pID]:HasAccess(5) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					vipdata = user[tID]:GetVIP()
					if user[tID]:IsLogged() then
						if vipdata['subscription'] == false then
							InputConsole("ppage %d This player does not have a VIP-subscription.", pID)
						else
							InputConsole("ppage %d %s has been removed from the VIP-subscribers.", pID, user[tID]:GetName())
							InputConsole("ppage %d You have been removed from the VIP-subscribers.", tID)
							user[tID]:RemoveVIPSub()
						end
					else
						InputConsole("ppage %d [Error] User %s is not logged in.", pID, user[tID]:GetName())
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!flotto" then
		if user[pID]:HasAccess(4) then
			lotto.Execute()
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!resetip" then
		if user[pID]:HasAccess(3) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:SetAccountIP()
					InputConsole("ppage %d Your Account IP has been set to: %s", tID, user[tID]:GetAccountIP())
					InputConsole("ppage %d %s their Account IP has been set to: %s", pID, user[tID]:GetName(), user[tID]:GetAccountIP())
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!resetserial" then
		if user[pID]:HasAccess(3) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:SetAccountSerial()
					InputConsole("ppage %d Your Account Serial has been set to: %s", tID, user[tID]:GetAccountSerial())
					InputConsole("ppage %d %s his/her Account Serial has been set to: %s", pID, user[tID]:GetName(), user[tID]:GetAccountSerial())
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!bring" then
		if user[pID]:HasAccess(2) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:TeleportTo(pID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!goto" then
		if user[pID]:HasAccess(2) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[pID]:TeleportTo(tID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!send" then
		if user[pID]:HasAccess(2) then
			if Message[2] == nil or Message[3] == nil then
				InputConsole("ppage %d Please fill in both player names.", pID)
			else
				fID = mf.FindPlayer("ID", Message[2])
				tID = mf.FindPlayer("ID", Message[3])
				if fID == "Many" or tID == "Many" then
					InputConsole("ppage %d One or both of these playernames are not unique.", pID)
				elseif fID == "None" or tID == "None" then
					InputConsole("ppage %d One or both of these players do not exist or are not ingame.", pID)
				else
					user[fID]:TeleportTo(tID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!addcredits" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				if Message[3] == nil or tonumber(Message[3]) == nil then
					InputConsole("ppage %d Please specify the amount of credits by using numbers.", pID)
				else
					tID = mf.FindPlayer("ID", Message[2])
					if tID == "Many" then
						InputConsole("ppage %d This playername is not unique.", pID)
					elseif tID == "None" then
						InputConsole("ppage %d This player does not exist or is not ingame.", pID)
					else
						credits = tonumber(Message[3])
						user[tID]:AddBankCredits(credits)
						InputConsole("ppage %d You have added %d credits to %s their bank.", pID, credits, user[tID]:GetName())
						InputConsole("ppage %d %d credits have been added to your bank.", tID, credits)
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!removecredits" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				if Message[3] == nil or tonumber(Message[3]) == nil then
					InputConsole("ppage %d Please specify the amount of credits by using numbers.", pID)
				else
					tID = mf.FindPlayer("ID", Message[2])
					if tID == "Many" then
						InputConsole("ppage %d This playername is not unique.", pID)
					elseif tID == "None" then
						InputConsole("ppage %d This player does not exist or is not ingame.", pID)
					else
						credits = tonumber(Message[3])
						user[tID]:RemoveBankCredits(credits)
						InputConsole("ppage %d You have removed %d credits from %s their bank.", pID, credits, user[tID]:GetName())
						InputConsole("ppage %d %d credits have been removed from your bank.", tID, credits)
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!setcredits" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				if Message[3] == nil or tonumber(Message[3]) == nil then
					InputConsole("ppage %d Please specify the amount of credits by using numbers.", pID)
				else
					tID = mf.FindPlayer("ID", Message[2])
					if tID == "Many" then
						InputConsole("ppage %d This playername is not unique.", pID)
					elseif tID == "None" then
						InputConsole("ppage %d This player does not exist or is not ingame.", pID)
					else
						credits = tonumber(Message[3])
						user[tID]:SetBankCredits(credits)
						InputConsole("ppage %d You have set %s their bank to %d credits.", pID, user[tID]:GetName(), credits)
						InputConsole("ppage %d Your bank has been set to %d credits.", tID, credits)
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!addrecs" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				if Message[3] == nil or tonumber(Message[3]) == nil then
					InputConsole("ppage %d Please specify the amount of recs by using numbers.", pID)
				else
					tID = mf.FindPlayer("ID", Message[2])
					if tID == "Many" then
						InputConsole("ppage %d This playername is not unique.", pID)
					elseif tID == "None" then
						InputConsole("ppage %d This player does not exist or is not ingame.", pID)
					else
						recs = tonumber(Message[3])
						user[tID]:AddRecs(recs)
						InputConsole("ppage %d You have added %d recs to %s their account.", pID, recs, user[tID]:GetName())
						InputConsole("ppage %d %d recs have been added to your account.", tID, recs)
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!removerecs" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				if Message[3] == nil or tonumber(Message[3]) == nil then
					InputConsole("ppage %d Please specify the amount of recs by using numbers.", pID)
				else
					tID = mf.FindPlayer("ID", Message[2])
					if tID == "Many" then
						InputConsole("ppage %d This playername is not unique.", pID)
					elseif tID == "None" then
						InputConsole("ppage %d This player does not exist or is not ingame.", pID)
					else
						recs = tonumber(Message[3])
						user[tID]:RemoveRecs(recs)
						InputConsole("ppage %d You have removed %d recs from %s their account.", pID, recs, user[tID]:GetName())
						InputConsole("ppage %d %d recs have been removed from your account.", tID, recs)
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!setrecs" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				if Message[3] == nil or tonumber(Message[3]) == nil then
					InputConsole("ppage %d Please specify the amount of recs by using numbers.", pID)
				else
					tID = mf.FindPlayer("ID", Message[2])
					if tID == "Many" then
						InputConsole("ppage %d This playername is not unique.", pID)
					elseif tID == "None" then
						InputConsole("ppage %d This player does not exist or is not ingame.", pID)
					else
						recs = tonumber(Message[3])
						user[tID]:SetRecs(recs)
						InputConsole("ppage %d You have set %s their recs to %d.", pID, user[tID]:GetName(), recs)
						InputConsole("ppage %d Your recs have been set to %d.", tID, recs)
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!saveall" then
		if user[pID]:HasAccess(4) then
			for tID, value in pairs(user) do
				user[tID]:Save(false)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!fsave" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:Save(false)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!flogout" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:Logout(false)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!fundowi" then
		if user[pID]:HasAccess(3) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:UndoLastWi()
					InputConsole("ppage %d You have undone the last wi of %s", pID, user[tID]:GetName())
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!freeze" then
		if user[pID]:HasAccess(3) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:SetFreeze(true)
					InputConsole("ppage %d You have frozen %s", pID, user[tID]:GetName())
					InputConsole("ppage %d You have been frozen.", tID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!unfreeze" then
		if user[pID]:HasAccess(3) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:SetFreeze(false)
					InputConsole("ppage %d You have unfrozen %s", pID, user[tID]:GetName())
					InputConsole("ppage %d You have been unfrozen.", tID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!mute" then
		if user[pID]:HasAccess(3) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:SetMute(true)
					InputConsole("ppage %d You have muted %s", pID, user[tID]:GetName())
					InputConsole("ppage %d You have been muted.", tID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!unmute" then
		if user[pID]:HasAccess(3) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:SetMute(false)
					InputConsole("ppage %d You have unmuted %s", pID, user[tID]:GetName())
					InputConsole("ppage %d You have been unmuted.", tID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!blockdmg" then
		if user[pID]:HasAccess(3) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:SetBlockDmg(true)
					InputConsole("ppage %d You have blocked %s their damage", pID, user[tID]:GetName())
					InputConsole("ppage %d Your damage has been blocked.", tID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!allowdmg" then
		if user[pID]:HasAccess(3) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:SetBlockDmg(false)
					InputConsole("ppage %d You have allowed %s their damage", pID, user[tID]:GetName())
					InputConsole("ppage %d Your damage has been allowed.", tID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!disable" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:Disable()
					InputConsole("ppage %d You have disabled %s", pID, user[tID]:GetName())
					InputConsole("ppage %d You have been disabled.", tID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!enable" then
		if user[pID]:HasAccess(4) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					user[tID]:Enable()
					InputConsole("ppage %d You have enabled %s", pID, user[tID]:GetName())
					InputConsole("ppage %d You have been enabled.", tID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!eject" then
		if user[pID]:HasAccess(2) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name.", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					InputConsole("eject %d", tID)
					InputConsole("ppage %d You have ejected %s", pID, user[tID]:GetName())
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!modpower" then
		if user[pID]:HasAccess(2) then
			if user[pID]:GetModPower() then
				user[pID]:SetModPower(false, false)
				InputConsole("ppage %d You de-activated modpower!", pID)
			else
				user[pID]:SetModPower(true, false)
				InputConsole("ppage %d You activated modpower!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 0
	end
	
	if Message[1] == "!eteam" then
		if user[pID]:HasAccess(2) then
			if tc.Are_Teams_Even() == true then
				InputConsole("ppage %d The teams are even.", pID)
			else
				tc.StartBalance()
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!reloadconfig" then
		if user[pID]:HasAccess(4) then
			sc.Load()
			InputConsole("ppage %d Reloaded the server config", pID)
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!lua" then
		if user[pID]:HasAccess(5) then
			if Message[-2] == nil then
				InputConsole("ppage %d !lua <chunk>", pID)
   			else
				proc, err = loadstring(Message[-2])
				if proc == nil then
					OnError(err)
				else
					status, err = pcall(proc)
					if err then
						OnError(err)
					end 
				end
   			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	return false
end
