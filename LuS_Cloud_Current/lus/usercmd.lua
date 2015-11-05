module('usercmd', package.seeall)

-- Init vars	--
lastmodcall = 0

function Key(pID, Key)
	if Key == "bal" then
		InputConsole("ppage %d Your current balance is %d credits.", pID, user[pID]:GetBankCredits())
	end
	
	if Key == "recs" then
		InputConsole("ppage %d You currently have %d recommendations!", pID, user[pID]:GetRecs())
	end
	
	if Key == "loti" then
		InputConsole("ppage %d You currently have %d loti's.", pID, user[pID]:GetLoti())
	end
	
	if Key == "dp" then
		dammore = 10000 - user[pID]:GetDP()
		InputConsole("ppage %d You have %d damage points! You need %d more for a rec. ", pID, user[pID]:GetDP(), dammore)
	end
end

function Command(pID, Message)
	if Message[1] == "!myvip" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsVIP() then
				vipdata = user[pID]:GetVIP()
				passed = mf.TimePassed(vipdata['vip_left'], 5)
				
				if vipdata['subscription'] then
					InputConsole("ppage %d You currently have access to VIP commands every month till you stop your subscription.", pID)
				else
					InputConsole("ppage %d You currently have access to VIP commands for the next %d months, %d weeks, %d days, %d minutes and %d seconds.", pID, vipdata['months'], passed['weeks'], passed['days'], passed['hours'], passed['minutes'], passed['seconds'])
				end
				
				if vipdata['subscription'] or vipdata['months'] > 0 then
					InputConsole("ppage %d VIP Renewal in: %d weeks, %d days, %d hours, %d minutes and %d seconds.", pID, passed['weeks'], passed['days'], passed['hours'], passed['minutes'], passed['seconds'])
				end
			else
				InputConsole("ppage %d You currently don't have access to VIP commands. If you want to be a Premium Member, go to www.cloud-zone.com", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!mypassword" then
		if user[pID]:HasAccess(1) then
			if user[pID]:GetPassword() == nil then
				InputConsole("ppage %d You do not have a password set! Please check !accounthelp for help with setting a password!", pID)
			else
				InputConsole("ppage %d Your current password is: %s", pID, user[pID]:GetPassword())
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!myaccess" then
		if user[pID]:HasAccess(1) then
			InputConsole("ppage %d Your current access-level is: %d", pID, user[pID]:GetAccess())
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!myip" then
		if user[pID]:HasAccess(1) then
			InputConsole("ppage %d Your current IP is: %s", pID, user[pID]:GetCurrentIP())
			InputConsole("ppage %d Your account IP is: %s", pID, user[pID]:GetAccountIP())
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!myserial" then
		if user[pID]:HasAccess(1) then
			InputConsole("ppage %d Your current serialhash is: %s", pID, user[pID]:GetCurrentSerial())
			InputConsole("ppage %d Your account serialhash is: %s", pID, user[pID]:GetAccountSerial())
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!myloti" then
		if user[pID]:HasAccess(1) then
			InputConsole("ppage %d You currently have %d loti's.", pID, user[pID]:GetLoti())
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!mysound" then
		if user[pID]:HasAccess(1) then
			if user[pID]:GetSound() == 1 then
				InputConsole("ppage %d You currently have extra-sounds on!", pID)
			else
				InputConsole("ppage %d You currently have extra-sounds off!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!mylogin" then
		if user[pID]:HasAccess(1) then
			InputConsole("ppage %d Your current auto-login level is: %d", pID, user[pID]:GetLoginLevel())
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!myprotect" then
		if user[pID]:HasAccess(1) then
			InputConsole("ppage %d Your current protection level is: %d", pID, user[pID]:GetProtectLevel())
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!playtime" then
		if user[pID]:HasAccess(1) then
			if Message[2] == nil then
				passed = mf.TimePassed(user[pID]:GetOnlineTime(), 3)
				InputConsole("ppage %d %s has spent %d hours, %d minutes and %d seconds on this server since %s", pID, user[pID]:GetName(), passed['hours'], passed['minutes'], passed['seconds'], mf.FormatDate(user[pID]:GetJoinTime()))
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					passed = mf.TimePassed(user[tID]:GetOnlineTime(), 3)
					InputConsole("ppage %d %s has spent %d hours, %d minutes and %d seconds on this server since %s", pID, user[tID]:GetName(), passed['hours'], passed['minutes'], passed['seconds'], mf.FormatDate(user[tID]:GetJoinTime()))
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!setpassword" then
		if user[pID]:IsLogged() then
			if user[pID]:HasAccess(1) then
				if Message[2] == user[pID]:GetPassword() then
					InputConsole("ppage %d If you want to change your password, please use a different one then your current one.", pID)
				elseif string.len(Message[2]) < 3 then
					InputConsole("ppage %d Your (new) password has to be atleast three (3) signs long.", pID)
				elseif string.match(Message[2], "^%w+$") == nil then
					InputConsole("ppage %d Your (new) password can only contain alphanumeric characters (A-Z,0-9).", pID)
				else
					user[pID]:SetPassword(Message[2])
					InputConsole("ppage %d Your password has been changed to: %s", pID, user[pID]:GetPassword())
				end
			else
				InputConsole("ppage %d You do not have access to this command.", pID)
			end
		end
		return 0
	end
	
	if Message[1] == "!login" then
		if user[pID]:IsLogged() == false then
			user[pID]:Login(Message[2])
		else
			InputConsole("ppage %d You are already logged in.", pID)
		end
		return 0
	end
	
	if Message[1] == "!balance" or Message[1] == "!bal" then
		if user[pID]:HasAccess(1) then
			if Message[2] == nil then
				InputConsole("msg [LuS] %s his/her current balance is %d credits.", user[pID]:GetName(), user[pID]:GetBankCredits())
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					InputConsole("msg [LuS] %s his/her current balance is %d credits.", user[tID]:GetName(), user[tID]:GetBankCredits())
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!wi" then
		if user[pID]:HasAccess(1) then
			gametime_elapsed = os.time() - gametime_start
			if gametime_elapsed < sc.bank_wait then
				gametime_bankwait = sc.bank_wait - gametime_elapsed
				InputConsole("ppage %d You need to wait %d seconds for the bank to open.", pID, gametime_bankwait)
			else
				if Message[2] == nil or tonumber(Message[2]) == nil then
					InputConsole("ppage %d Please specify the amount of credits by using numbers.", pID)
				else
					credits = tonumber(Message[2])
					if credits < 0 then
						InputConsole("ppage %d You cannot withdraw a negative amount of credits.", pID)
					elseif credits > user[pID]:GetBankCredits() then
						InputConsole("ppage %d You do not have that much credits.", pID)
					else
						user[pID]:Withdraw(credits)
						InputConsole("ppage %d You have withdrawn %d credits. You currently have %d credits left in your bank.", pID, credits, user[pID]:GetBankCredits())
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!undowi" then
		if user[pID]:HasAccess(1) then
			lastwi = user[pID]:GetLastWi()
			if lastwi == false or lastwi['credits'] < 45000 then
				InputConsole("ppage %d You cannot undo your last !wi because: You haven't !wi yet or have !wi less then 45k.", pID)
			else
				witime = os.time() - lastwi['time']
				if witime > 30 then
					InputConsole("ppage %d You cannot undo your last !wi because: More than 30 seconds have passed since your last !wi.", pID)
				else
					totalcredits = user[pID]:GetTotalCredits(false) + lastwi['credits']
					if totalcredits > sc.banklimit then
						InputConsole("ppage %d You cannot undo your last !wi because: The total amount will exceed the bank limit.", pID)
					elseif Get_Money(pID) < lastwi['credits'] then
						InputConsole("ppage %d You cannot undo your last !wi because: You don't have the amount of credits you !wi.", pID)
					else
						user[pID]:UndoLastWi()
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!ex" or Message[1] == "!exchangerec" then
		if user[pID]:HasAccess(1) then
			gametime_elapsed = os.time() - gametime_start
			if gametime_elapsed < sc.bank_wait then
				gametime_bankwait = sc.bank_wait - gametime_elapsed
				InputConsole("ppage %d You need to wait %d seconds for the bank to open.", pID, gametime_bankwait)
			else
				if Message[2] == nil or tonumber(Message[2]) == nil then
					InputConsole("ppage %d Please specify the amount of recs by using numbers.", pID)
				else
					recs = tonumber(Message[2])
					if recs <= 0 then
						InputConsole("ppage %d You cannot exchange less than 1 rec.", pID)
					elseif recs > user[pID]:GetRecs() then
						InputConsole("ppage %d You do not have that much recs.", pID)
					else
						if user[pID]:GetBankCredits() > sc.banklimit then
							InputConsole("ppage %d Your bank is full, you cannot exchange your recs.", pID)
						else
							credits = user[pID]:ExchangeRecs(recs)
							taxperc = sc.depotax*100
							InputConsole("ppage %d A fee of %d%% has been deducted from your exchange. You have deposited %d credits into your bank account. Total: %d", pID, taxperc, credits, user[pID]:GetBankCredits())
							InputConsole("ppage %d You used %d recs. You now have %d recs remaining.", pID, recs, user[pID]:GetRecs())
						end
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!n00b" or Message[1] == "!noob" then
		if user[pID]:HasAccess(1) then
			username = user[pID]:GetName()
			if _G['caninoob'][username] == nil then
				if Message[2] == nil then
					InputConsole("ppage %d You have to fill in a player name to noob.", pID)
				else
					tID = mf.FindPlayer("ID", Message[2])
					if tID == "Many" then
						InputConsole("ppage %d This playername is not unique.", pID)
					elseif tID == "None" then
						InputConsole("ppage %d This player does not exist or is not ingame.", pID)
					elseif tID == pID then
						InputConsole("ppage %d you cannot n00b yourself :)", pID)
					else
						if Message[-3] == nil then
							Reason = "No Reason"
						else
							Reason = Message[-3]
						end
						user[tID]:RemoveRecs(1)
						_G['caninoob'][username] = {}
						_G['caninoob'][username]['time'] = os.time()
						_G['caninoob'][username]['tName'] = user[tID]:GetName()
						_G['caninoob'][username]['tID'] = tID
						InputConsole("msg [LuS] %s has n00bed %s for: %s", username, user[tID]:GetName(), Reason)
					end
				end
			else
				InputConsole("ppage %d You have already noobed someone this game!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!rec" then
		if user[pID]:HasAccess(1) then
			username = user[pID]:GetName()
			if _G['canirec'][username] == nil then
				if Message[2] == nil then
					InputConsole("ppage %d You have to fill in a player name to rec.", pID)
				else
					tID = mf.FindPlayer("ID", Message[2])
					if tID == "Many" then
						InputConsole("ppage %d This playername is not unique.", pID)
					elseif tID == "None" then
						InputConsole("ppage %d This player does not exist or is not ingame.", pID)
					elseif tID == pID then
						InputConsole("ppage %d you cannot rec yourself :)", pID)
					else
						if user[tID]:OnBankLimit() then
							InputConsole("ppage %d %s has over %d in the bank + recs combined, you cannot rec him.", pID, user[tID]:GetName(), sc.banklimit)
						else
							if Message[-3] == nil then
								Reason = "No Reason"
							else
								Reason = Message[-3]
							end
							user[tID]:AddRecs(1)
							_G['canirec'][username] = false
							InputConsole("msg [LuS] %s has recced %s for: %s", username, user[tID]:GetName(), Reason)
						end
					end
				end
			else
				InputConsole("ppage %d You have already recced somebody this game!", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!tp" or Message[-1] == "!myrec" then
		if user[pID]:HasAccess(1) then
			if Message[2] == nil then
				InputConsole("msg [LuS] %s has %d recommendations!", user[pID]:GetName(), user[pID]:GetRecs())
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					InputConsole("msg [LuS] %s has %d recommendations!", user[tID]:GetName(), user[tID]:GetRecs())
				end
			end	
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!iprangeup" then
		if user[pID]:HasAccess(1) then
			result = user[pID]:IPRangeUp()
			if result == true then
				InputConsole("ppage %d Your current Account IP has been set to: %s", pID, user[pID]:GetAccountIP())
			else
				InputConsole("ppage %d You can not further widen your IP Range.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!ipreset" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsProtected() then
				user[pID]:SetAccountIP()
				InputConsole("ppage %d Your Account IP has been set to: %s", pID, user[pID]:GetAccountIP())
			else
				InputConsole("ppage %d You need to have a password set before you can reset your account IP", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!serialreset" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsProtected() then
				user[pID]:SetAccountSerial()
				InputConsole("ppage %d Your Account Serial has been set to: %s", pID, user[pID]:GetAccountSerial())
			else
				InputConsole("ppage %d You need to have a password set before you can reset your account Serial", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!setprotect" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsProtected() then
				if Message[2] == nil or tonumber(Message[2]) == nil then
					InputConsole("ppage %d Please fill in a number representing the protection-level.", pID)
				else
					level = tonumber(Message[2])
					if level < 0 or level > 3 then
						InputConsole("ppage %d The protection-level has to be 0, 1, 2 or 3.", pID)
					else
						user[pID]:SetProtectLevel(level)
						InputConsole("ppage %d Your protection-level has been set to: %d", pID, user[pID]:GetProtectLevel())
					end
				end
			else
				InputConsole("ppage %d You need to have a password set before you can set your protection-level.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!setautologin" then
		if user[pID]:HasAccess(1) then
			if user[pID]:IsProtected() then
				if Message[2] == nil or tonumber(Message[2]) == nil then
					InputConsole("ppage %d Please fill in a number representing the autologin-level.", pID)
				else
					level = tonumber(Message[2])
					if level < 0 or level > 3 then
						InputConsole("ppage %d The autologin-level has to be 0, 1, 2 or 3.", pID)
					else
						user[pID]:SetLoginLevel(level)
						InputConsole("ppage %d Your autologin-level has been set to: %d", pID, user[pID]:GetLoginLevel())
					end
				end
			else
				InputConsole("ppage %d You need to have a password set before you can set your protection-level.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!soundon" then
		if user[pID]:HasAccess(1) then
			scripts = user[pID]:GetScripts()
			if scripts == false or scripts < 3.4 then
				InputConsole("ppage %d You need scripts 3.4 or higher to hear custom sounds.", pID)
			else
				user[pID]:SetSound(1)
				InputConsole("ppage %d You can now hear extra sounds! (Scripts 3.4 required)", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!soundoff" then
		if user[pID]:HasAccess(1) then
			user[pID]:SetSound(0)
			InputConsole("ppage %d You turned off the extra sounds.", pID)
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!dp" then
		if user[pID]:HasAccess(1) then
			dammore = 10000 - user[pID]:GetDP()
			InputConsole("ppage %d You have %d damage points! You need %d more for a rec. ", pID, user[pID]:GetDP(), dammore)
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!tdonate" then
		if user[pID]:HasAccess(1) then
			if Message[2] == nil or tonumber(Message[2]) == nil then
				InputConsole("ppage %d Please specify the amount of credits by using numbers.", pID)
			else
				credits = tonumber(Message[2])
				if credits < 0 then
					InputConsole("ppage %d You cannot donate a negative amount of credits.", pID)
				elseif Get_Money(pID) < credits then
					InputConsole("ppage %d You don't have that much credits.", pID)
				else
					mf.TeamDonate(pID, credits)
					InputConsole("ppage %d You have donated %d credits to your team!", pID, credits)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!scripts" then
		if user[pID]:HasAccess(1) then
			if Message[2] == nil then
				if user[pID]:GetScripts() == false then
					InputConsole("msg [LuS] %s does not have any scripts.", user[pID]:GetName())
				else
					InputConsole("msg [LuS] %s has scripts version %s", user[pID]:GetName(), user[pID]:GetScripts())
				end
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					if user[tID]:GetScripts() == false then
						InputConsole("msg [LuS] %s does not have any scripts.", user[tID]:GetName())
					else
						InputConsole("msg [LuS] %s has scripts version %s", user[tID]:GetName(), user[tID]:GetScripts())
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!volunteer" then
		if user[pID]:HasAccess(1) then
			if tc.autobalance then
				if tc.team_to_change == Get_Team(pID) then
					temp = tc.Volunteer(pID)
					if temp then
						InputConsole("ppage %d Thank you for volunteering! If needed you will be changed within 60 seconds!", pID)
					else
						InputConsole("ppage %d You already volunteered yourself.", pID)
					end
				else
					InputConsole("ppage %d You're on the wrong team silly!", pID)
				end
			else
				InputConsole("ppage %d Teambalance is not active.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!nominate" then
		if user[pID]:HasAccess(1) then
			if Message[2] == nil then
				InputConsole("ppage %d You need to fill in a player name!", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					if tc.autobalance then
						if tc.team_to_change == Get_Team(pID) then
							if tc.team_to_change == Get_Team(tID) then
								if tID == pID then
									InputConsole("ppage %d You can't nominate yourself.", pID)
								else
									temp = tc.Nominate(pID, tID)
									if temp then
										InputConsole("ppage %d You nominated %s for a teamchange!", pID, user[tID]:GetName())
									else
										InputConsole("ppage %d You already nominated someone.", pID)
									end
								end
							else
								InputConsole("ppage %d You need to nominate someone on your team.", pID)
							end
						else
							InputConsole("ppage %d You're on the wrong team silly!", pID)
						end
					else
						InputConsole("ppage %d Teambalance is not active.", pID)
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 0
	end
	
	if Message[1] == "!callmod" then
		if user[pID]:HasAccess(1) then
			if gi.GetModCount() > 0 then
				InputConsole("ppage %d There are already mods in-game!", pID)
			else
				if (os.time() - lastmodcall) > 30 then
					modcalled = 0
					for User, v in pairs(ircuser) do
						if ircuser[User]:HasAccess(2) then
							irc.SendPM(string.format("Player [u]%s[/u] has requested for a mod.", user[pID]:GetName()), User)
							modcalled = modcalled + 1
						end
					end
					
					if modcalled > 0 then
						InputConsole("ppage %d %d mods have been called.", pID, modcalled)
					else
						InputConsole("ppage %d Sorry, there are currently no active mods on IRC :(", pID)
					end
					lastmodcall = os.time()
				else
					InputConsole("ppage %d This command has already been used in the last thirty seconds, please be patient!", pID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!killme" then
		if user[pID]:HasAccess(1) then
			pObj = Get_GameObj(pID)
			veh = Get_Vehicle(pObj)						
			if veh == 0 then
				Apply_Damage(pObj, 9999, "laser", pObj)
			else
				if pObj ~= Get_Vehicle_Driver(veh) then
					InputConsole("ppage %d You can't kill someone else their vehicle", pID)
				else
					Apply_Damage(veh, 9999, "blamokiller", 0)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!gethp" then
		if user[pID]:HasAccess(1) then
			if Message[2] == nil then
				InputConsole("ppage %d Please fill in a player name", pID)
			else
				tID = mf.FindPlayer("ID", Message[2])
				if tID == "Many" then
					InputConsole("ppage %d This playername is not unique.", pID)
				elseif tID == "None" then
					InputConsole("ppage %d This player does not exist or is not ingame.", pID)
				else
					tObj = Get_GameObj(tID)
					veh = Get_Vehicle(tObj)
					
					vhp = Get_Health(veh)
					vap = Get_Shield_Strength(veh)
					
					php = Get_Health(tObj)
					pap = Get_Shield_Strength(tObj)
					
					InputConsole("msg %s is at %d health and %d armor. ", user[tID]:GetName(), php, pap)
					if veh ~= 0 then
						InputConsole("msg %s is in a vehicle that has %d health and %d armor. ", user[tID]:GetName(), vhp, vap)
					end
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!buy1k" then
		if user[pID]:HasAccess(1) then
			recprice = 2   
			if user[pID]:GetRecs() < recprice then
				InputConsole("ppage %d You do not have enough recs.", pID)
			else
				user[pID]:RemoveRecs(recprice)
				InputConsole("msg %s has exchanged 2 recs for 1000 credits!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)+1000)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!credspersec" or Message[1] == "!cps" then
		if user[pID]:HasAccess(1) then
			InputConsole("msg The approximate credits/second value for GDI is: %d creds/sec", gi.GetCPS(1))
			InputConsole("msg The approximate credits/second value for Nod is: %d creds/sec", gi.GetCPS(0))
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
	end
	
	if Message[1] == "!uu" then
		if user[pID]:HasAccess(1) then
			if user[pID]:CanUnstuck() then
				pObj = Get_GameObj(pID)
				Facing = Get_Facing(pObj)
				pos = Get_Position(pObj)
				
				Set_Position(pObj, mf.CalcPos(pos, Facing, 0, {Z=3}))
			else
				InputConsole("ppage %d Ask a mod to activate this command for you if you're stuck.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!uf" then
		if user[pID]:HasAccess(1) then
			if user[pID]:CanUnstuck() then
				pObj = Get_GameObj(pID)
				Facing = Get_Facing(pObj)
				pos = Get_Position(pObj)
				
				Set_Position(pObj, mf.CalcPos(pos, Facing, 3))
			else
				InputConsole("ppage %d Ask a mod to activate this command for you if you're stuck.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	--[[ XMas Commands
	if Message[1] == "!present" then
		if user[pID]:HasAccess(1) then
			if user[pID].last_present == nil then
				user[pID].last_present = os.time()-10
			end
			
			local wait = os.time() - user[pID].last_present
			if wait < 10 then
				InputConsole("ppage %d You must wait %d seconds before you can receive another present.", pID, (10-wait))
			else
				user[pID].last_present = os.time()
				local present = math.random(0,7)
				if present == 0 then
					InputConsole("ppage %d You just gained 50 max health thanks to a present from santa!", pID)
					InputConsole("cmsg 255,0,0 Happy Holidays! Enjoy your +50 health!")
					InputConsole("cmsg 0,100,0 Happy Holidays! Enjoy your +50 health!")
					local pObj = Get_GameObj(pID)
					local huhp = Get_Max_Health(pObj)				
					Set_Max_Health(pObj, huhp+50)
					Set_Health(pObj, huhp+50)
				elseif present == 1 then
					bots.MultiSpawn(Get_GameObj(pID), "civ_lab_tech_01", 1, 1, 0.1, false, { z_Set_Team=Get_Team(pID), lus_damaged="", lus_poked="", lus_killed="", changemodel="dino" })
					InputConsole("ppage %d You got a shockerbot in your present!", pID)
					InputConsole("cmsg 255,0,0 Happy Holidays! Enjoy your shockerbot!")
					InputConsole("cmsg 0,100,0 Happy Holidays! Enjoy your shockerbot!")
				elseif present == 2 or present == 3 then
					local moneyrandom = math.random(2,10000)
					Set_Money(pID, Get_Money(pID)+moneyrandom) 
					InputConsole("ppage %d You open your present and you see %d credits! Hurray!", pID, moneyrandom)
					InputConsole("cmsg 135,206,250 Happy Holidays! Enjoy your %d credits!", moneyrandom)
					InputConsole("cmsg 30,144,255 Happy Holidays! Enjoy your %d credits!", moneyrandom)
				elseif present == 4 then
					local pObj = Get_GameObj(pID)
					local pos = Get_Position(pObj)
					local Facing = Get_Facing(pObj)
					local Distance = 7
					
					pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
					pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
					pos.Z = pos.Z + 3
						
					local vehobj = Create_Object("CnC_Nod_Stealth_Tank", pos)
					Attach_Script_Once(vehobj, "z_Set_Team", Get_Team(pID))
					
					InputConsole("ppage %d You got a stealth tank in your present!", pID)
					InputConsole("cmsg 255,0,0 Happy Holidays! Enjoy your stealth tank!")
					InputConsole("cmsg 0,100,0 Happy Holidays! Enjoy your stealth tank!")
				elseif present == 5 then
					Grant_Powerup(Get_GameObj(pID), "POW_Railgun_Player")  
					InputConsole("ppage %d You open your present and you see a shiny new railgun!", pID)
					InputConsole("cmsg 135,206,250 Happy Holidays! Enjoy your railgun!")
					InputConsole("cmsg 30,144,255 Happy Holidays! Enjoy your railgun!") 
				elseif present == 6 then
					Grant_Powerup(Get_GameObj(pID), "POW_Head_Band")
					InputConsole("ppage %d You open your present and you see an unlimited supply of proxy mines!", pID)
					InputConsole("cmsg 135,206,250 Happy Holidays! Enjoy your proxys!!")
					InputConsole("cmsg 30,144,255 Happy Holidays! Enjoy your proxys!!") 
				elseif present == 7 then
					local pos = Get_Position(Get_GameObj(pID))
					InputConsole("ppage %d You open your present and you find out you've been a naughty child! Burrrrrrn!!!!!!", pID)
					InputConsole("cmsg 255,255,0 Happy Holidays! BURN FOR BEING NAUGHTY")
					InputConsole("cmsg 255,140,0 Happy Holidays! BURN FOR BEING NAUGHTY")
					local turret = Create_Object("CnC_Nod_Stealth_Tank", pos)
					Attach_Script_Once(turret, "JFW_Blow_Up_On_Death", "Explosion_NukeBeacon")
					Apply_Damage(turret, 9999, "blamokiller", 0)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!santa" then
		if user[pID]:HasAccess(1) then
			if user[pID].last_santa == nil then
				user[pID].last_santa = os.time()-10
			end
				
			local wait = os.time() - user[pID].last_santa
			if wait < 10 then
				InputConsole("ppage %d You must wait %d seconds before you can get another santa.", pID, (10-wait))
			else
				user[pID].last_santa = os.time()
				bots.MultiSpawn(Get_GameObj(pID), "M04 Ship First Mate", 2, 2, 0.2, false, { z_Set_Team=Get_Team(pID), lus_damaged="", lus_poked="", lus_killed="" })
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!elf" then
		if user[pID]:HasAccess(1) then
			if Get_Preset_Name(Get_GameObj(pID)) == "CnC_GDI_Mutant_2SF_Templar" then
				InputConsole("msg Lol, %s tried to buy elf when they already had it.", user[pID]:GetName())
			else
				Change_Character(Get_GameObj(pID), "CnC_GDI_Mutant_2SF_Templar") 
				InputConsole("cmsg 255,255,0 Happy Holidays! Try shooting people with the AI pistol!")
				InputConsole("cmsg 255,140,0 Happy Holidays! Try shooting people with the AI pistol!")
				Grant_Powerup(Get_GameObj(pID), "POW_Pistol_AI")
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	-- End XMas Commands--]]
	
	return false
end
