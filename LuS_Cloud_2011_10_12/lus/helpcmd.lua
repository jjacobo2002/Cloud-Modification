module('helpcmd', package.seeall)

rules =	{
			'"Cheating/Hacking" - Do not use cheats or hacks while in Cloud, there is NO exception! If we catch you, you WILL be banned.',
			'"Basebuild" - Do not build walls, defenses or any other building in the enemy base.',
			'"Roofbeacons" - Do not nuke or ion on the roof of a building on non-flying maps.',
			'"Outside the map" - Do not fly/jump outside (under/over) the map.',
			'"Base to Base (B2B)" - Do not attack the enemy base from within your own base.',
			'"Tunnel Beacons" - Do not place beacons in the tunnels. Ledges connected to a tunnel will also be counted as a tunnel.',
			'"Emote-Abuse" - Do not use emotes to negate damage from falling down.',
			'"Glitches/Bugs" - Do not abuse glitches or bugs.',
			'"Teamhamper(TH)" - Do not hamper your team.',
			'"Scripts" - We would appriciate it if you would install the latest update (Scripts 4). *WE DO NOT FORCE SCRIPTS ON EVERYONE*',
			'"Multi-Accounting" - It is not allowed to play multiple accounts by yourself.',
			'"Behaviour" - Please behave yourself. Don\'t use excessive swearing, and try not to Troll or Flame fellow players.',
			'"Hotkeys/Macro\'s" - Hotkeys and/or Macro\'s are not allowed with the exception of Copy/Paste.',
			{
				'"Whoring" - It is not allowed to whore points, recs or kills.',
				'The most obvious act of whoring is working together with the enemy. This enemy can be yourself, a family member, a friend or even a stranger you just met.',
				'Walking around in a defenseless enemy base, against a team having lost all hope, killing people in dead or alive buildings without even trying to scratch a living building to win the game.',
				'Disabling your enemy multiple times, only to retreat till they are trying to counter you so you can kill them.'
			}
		}

function Command(pID, Message)
	--[[ Help/Commands tree.
		!commands/!help
			!callmod (important command)
			!rules
			!accounthelp
				!myaccount
				!protecthelp
				!loginhelp
			!bankhelp
			!lottohelp
			!premiumhelp
			!mischelp
				!sounds
			!modhelp
			!buyhelp
				!updates
				!bots
				!tankbots
				!build
				!chars
				!veh
				!upgrades
					!weapons
					!regens
				!gambles
					!freezerhelp			
	]]

	if Message[1] == "!commands" or Message[1] == "!help" then
		InputConsole("pamsg %d Commands: !rules, !callmod, !accounthelp, !bankhelp, !lottohelp, !buyhelp, !mischelp, !premiumhelp.", pID)
		if user[pID]:HasAccess(2) then
			InputConsole("pamsg %d Commands: !modhelp", pID)
		end
		
		if user[pID]:IsLogged() == false then
			InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
		end
		return 1
	end
	
		if Message[1] == "!rules" or Message[1] == "!rule" then
			if Message[2] == nil then
				InputConsole("ppage %d There are currently %d rules. To view a rule type !rule <#number>. To view all rules, type !rules all", pID, table.maxn(rules))
			elseif Message[2] == "all" then
				for i=table.maxn(rules), 1, -1 do
					ShowRule(i, pID)
				end
			else
				rulenr = tonumber(Message[2])
				if rulenr == nil or rules[rulenr] == nil then
					InputConsole("ppage %d Unknown rule.", pID)
				else
					ShowRule(rulenr, pID)
				end
			end
			
			return 1
		end
	
		if Message[1] == "!accounthelp" then
			InputConsole("pamsg %d To reset your account-serial, use !serialreset", pID)
			InputConsole("pamsg %d You can increase the range of your account-IP using !iprangeup. To reset your account-IP, use !ipreset", pID)
			InputConsole("pamsg %d Commands: !myaccount, !protecthelp, !loginhelp, !dp, !soundon, !soundoff, !playtime (player), !onlinetime (player)", pID)
		
			if user[pID]:IsLogged() == false then
				InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
			end
			return 1
		end
		
			if Message[1] == "!myaccount" then
				InputConsole("pamsg %d Commands: !myvip, !mypassword, !myaccess, !myip, !myserial, !myloti, !mysound, !mylogin, !myprotect, !myrec", pID)
			
				if user[pID]:IsLogged() == false then
					InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
				end
				return 1
			end
			
			if Message[1] == "!protecthelp" then
				InputConsole("pamsg %d Warning: This means you can shut yourself out of your account! Be carefull!.", pID)
				InputConsole("pamsg %d Example: If you set the protection-level to 3, and either the Serial or IP doesn't match, the user will be disabled.", pID)
				InputConsole("pamsg %d <level> can be 0, 1, 2 or 3. 0=Nothing, 1=IP, 2=Serial, 3=Serial&IP", pID)
				InputConsole("pamsg %d After you set a password, you can set the protection level of your account using !setprotect <level>", pID)
				InputConsole("pamsg %d You can set a password using !setpassword <password> (where <password> is your password)", pID)
				InputConsole("pamsg %d The most important thing is setting a password! After that you can protect your account on IP and Serial.", pID)
			
				if user[pID]:IsLogged() == false then
					InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
				end
				return 1
			end
			
			if Message[1] == "!loginhelp" then
				InputConsole("pamsg %d Example: If you set the autologin-level to 3, you will be automaticly logged in if your IP or Serial matches.", pID)
				InputConsole("pamsg %d <level> can be 0, 1, 2 or 3. 0=Password, 1=IP&Password, 2=Serial&Password, 3=IP&Serial&Password", pID)
				InputConsole("pamsg %d If that fails, you should contact a mod. If you want to login automaticly, you need to use !setautologin <level>", pID)
				InputConsole("pamsg %d If you are logged out, and have a password on your account, you need to use !login <password> (where <password> is your password)", pID)
			
				if user[pID]:IsLogged() == false then
					InputConsole("pamsg %d Note: Some commands require you to be logged in!", pID)
				end
				return 1
			end
		
		if Message[1] == "!bankhelp" then
			InputConsole("pamsg %d To check another player their recs, use !tp <player>", pID)
			InputConsole("pamsg %d To rec someone, type !rec <player>. To noob someone, type !noob <player> or !n00b <player>", pID)
			InputConsole("pamsg %d If you have accidently !wi over 45k, you can use !undowi within 30 seconds to get your money back", pID)
			InputConsole("pamsg %d To withdraw credits, use !wi <credits>. To exchange recs for credits in your bank, use !ex <recs>", pID)
			InputConsole("pamsg %d To check another player their balance, use !bal <player> or !balance <player>", pID)
			InputConsole("pamsg %d To check your balance, you can use !bal or !balance", pID)
		
			if user[pID]:IsLogged() == false then
				InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
			end
			return 1
		end
	
		if Message[1] == "!lottohelp" then
			InputConsole("pamsg %d The lotto will be executed every three days. There's between 4 and 8 prizes (random).", pID)
			InputConsole("pamsg %d To check when the lotto starts, you can use !lotto. To check the price of a loti, type !lotiprice. To buy a loti, type !loti", pID)
		
			if user[pID]:IsLogged() == false then
				InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
			end
			return 1
		end
	
		if Message[1] == "!premiumhelp" then
			if user[pID]:HasAccess(1) then
				InputConsole("pamsg %d Premium Commands: !bonuscreds, !tankbots.", pID)	
				
				if user[pID]:IsVIP() == false then
					InputConsole("For more info, visit our forums @ www.cloud-zone.com")
					InputConsole("Well that's possible! Help the server out by donating! For each $5 donated you will receive one month of premium access!")
					InputConsole("Do you want access to more commands? Do you want increased interest rate? Do you want an extra 500k/month in your bank? Do you want an extra +5cps?")
				end
			else
				InputConsole("ppage %d You do not have access to this command.", pID)
			end
			return 1
		end
	
		if Message[1] == "!mischelp" then
			InputConsole("pamsg %d Commands: !scripts <player>, !tdonate <credits>, !sounds", pID)
			if user[pID]:IsVIP() then
				InputConsole("pamsg %d Premium Commands: !bonuscreds", pID)
			end
			
			if user[pID]:IsLogged() == false then
				InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
			end
			return 1
		end
	
			if Message[1] == "!sounds" then
				if user[pID]:HasAccess(1) then
					if sounds.soundhelplist[1] == nil then
						InputConsole("ppage %d Sorry, there are currently no extra sounds available!", pID)
					elseif Message[2] == nil or tonumber(Message[2]) == nil then
						InputConsole("ppage %d There are %d sound lists, please use !sounds <listnr> to view those sounds.", pID, sounds.si)
					else
						listnr = tonumber(Message[2])
						if sounds.soundhelplist[listnr] then
							InputConsole("ppage %d %s.", pID, sounds.soundhelplist[listnr])
							if user[pID]:GetSound() == 0 then
								InputConsole("ppage %d Please use !soundon if you want to hear sounds.", pID)
							end
						else
							InputConsole("ppage %d This sound list does not exist, please choose a list number between 1 and %d.", pID, sounds.si)
						end
					end
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
	
		if Message[1] == "!modhelp" then
			if user[pID]:HasAccess(2) then
				InputConsole("pamsg %d Commands: !bring <player>, !goto <player>, !send <player1> <player2>, !eject <player>, !modpower, !eteam", pID)
				InputConsole("pamsg %d Commands: !islogged <player>, !isprotected <player>, !tabletest, !getaccess <player>, !getvip <player>", pID)
				
				if user[pID]:HasAccess(3) then
					InputConsole("pamsg %d Commands: !freeze <player>, !unfreeze <player>, !mute <player>, !unmute <player>, !blockdmg <player>, !allowdmg <player>", pID)
					InputConsole("pamsg %d Commands: !removepass <player>, !resetip <player>, !resetserial <player>, !fundowi <player>", pID)
				end
				
				if user[pID]:HasAccess(4) then
					InputConsole("pamsg %d Commands: !disable <player>, !enable <player>, !reloadconfig", pID)
					InputConsole("pamsg %d Commands: !addrecs <player> <recs>, !removerecs <player> <recs>, !setrecs <player> <recs>", pID)
					InputConsole("pamsg %d Commands: !addcredits <player> <credits>, !removecredits <player> <credits>, !setcredits <player> <credits>", pID)
					InputConsole("pamsg %d Commands: !saveall, !fsave <player>, !flogout <player>, !rm (module), !flotto, !passwordset <player> <password>, !setaccess <player> <level>", pID)
				end
				
				if user[pID]:HasAccess(5) then
					InputConsole("pamsg %d Commands: !addvip <player> <months>, !setvip <player> <months>, !removevip <player> <months>, !addvipsub <player>, !removevipsub <player>", pID)
				end
			else
				InputConsole("ppage %d You do not have access to this command.", pID)
			end
			return 1
		end
	
		if Message[1] == "!buyhelp" then
			if user[pID]:HasAccess(1) then
				InputConsole("pamsg %d To see the latest added commands, you can use !updates.", pID)
				InputConsole("pamsg %d Commands: !bots, !build, !chars, !veh, !upgrades, !gambles", pID)
				if user[pID]:IsVIP() then
					InputConsole("pamsg %d Premium Commands: !tankbots", pID)
				end
			else
				InputConsole("ppage %d You do not have access to this command.", pID)
			end
			return 1
		end
	
			if Message[1] == "!updates" then
				InputConsole("snda l08b_05_pet02.wav")
				InputConsole("pamsg %d Nothing new for now...", pID)		
				
				if user[pID]:IsLogged() == false then
					InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
				end
				return 1
			end
			
			if Message[1] == "!bots" then
				if user[pID]:HasAccess(1) then
					InputConsole("pamsg %d Nothing yet.", pID)
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
	
			if Message[1] == "!tankbots" then
				if user[pID]:HasAccess(1) then
					InputConsole("pamsg %d Premium Commands: Nothing yet.", pID)
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
	
			if Message[1] == "!build" then
				if user[pID]:HasAccess(1) then
					InputConsole("pamsg %d Nothing yet.", pID)
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
	
			if Message[1] == "!chars" then
				if user[pID]:HasAccess(1) then
					InputConsole("pamsg %d Nothing yet.", pID)
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
	
			if Message[1] == "!veh" then
				if user[pID]:HasAccess(1) then
					InputConsole("pamsg %d Vehicle Commands: !gapc (2000), !napc (2000), !light (2200), !hovercraft (2500), !stank (2800), !mammy (3800), !demossm (5500), !trooptrans (12000).", pID)
					InputConsole("pamsg %d Vehicle Commands: !buggy (700), !humvee (850), !recon (1000), !mrls (1200), !arty (1500), !gditrans (1500), !nodtrans (1500), !med (1500), !flame (2000)", pID)
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
	
			if Message[1] == "!upgrades" then
				if user[pID]:HasAccess(1) then
					InputConsole("pamsg %d Commands: !weapons, !regens, !suits.", pID)
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
				
				if Message[1] == "!weapons" then
					if user[pID]:HasAccess(1) then
						InputConsole("pamsg %d Commands: !megarepair (1500), !remote (2000), !technopack (4000), !commandopack (7500).", pID)
						InputConsole("pamsg %d Commands: !proxy (350), !sniper (400), !laser (450), !tibgun (500), !volt (600), !pic (600), !rail (600), !ramjet (700), !lcg (750).", pID)
						InputConsole("pamsg %d Commands: !shotgun (50), !flamethrower (50), !rifle (50), !grenade (100), !chem (100), !repair (200), !tibrifle (200), !rocket (300).", pID)
					else
						InputConsole("ppage %d You do not have access to this command.", pID)
					end
					return 1
				end
	
				if Message[1] == "!regens" then
					if user[pID]:HasAccess(1) then
						InputConsole("pamsg %d Commands: !lowvehregen (1500), !medvehregen (2500), !fastvehregen (2500), !fastvehregen2 (4500), !highvehregen (5500).", pID)
						InputConsole("pamsg %d Commands: !lowregen (500), !fastregen (1000), !bothregen (1000), !medregen (1500), !fastregen2 (2000), !bothregen2 (2500), !fastregen3 (3000), !highregen (3800).", pID)
					else
						InputConsole("ppage %d You do not have access to this command.", pID)
					end
					return 1
				end
				
				if Message[1] == "!suits" then
					if user[pID]:HasAccess(1) then
						InputConsole("pamsg %d Commands: !tibsuit/!ts (2500), !killsuit/!ks (2500), !ss (3000), !absorbsuit/!as (3500), !nukesuit/!ns (8000).", pID)
					else
						InputConsole("ppage %d You do not have access to this command.", pID)
					end
					return 1
				end
				
			if Message[1] == "!gambles" then
				if user[pID]:HasAccess(1) then
					InputConsole("pamsg %d Commands: !freezerhelp.", pID)
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
	
				if Message[1] == "!freezerhelp" then
					if user[pID]:HasAccess(1) then
						InputConsole("pamsg %d The more ice you move, the higher the reward (or the fine if you melt the ice!).", pID)
						InputConsole("pamsg %d Use !openfreezer to help DarkOrbit !moveice, be sure to !closefreezer before the ice melts.", pID)
					else
						InputConsole("ppage %d You do not have access to this command.", pID)
					end
					return 1
				end
	
	return false
end

function ShowRule(rulenr, pID)
	rule = rules[rulenr]
	if type(rule) == "string" then
		InputConsole("pamsg %d #%d: %s", pID, rulenr, rule)
	elseif type(rule) == "table" then
		for i=table.maxn(rules[rulenr]), 1, -1 do
			if i > 1 then
				InputConsole("pamsg %d #%d.%d: %s", pID, rulenr, i-1, rules[rulenr][i])
			else
				InputConsole("pamsg %d #%d: %s", pID, rulenr, rules[rulenr][i])
			end
		end
	end
end
