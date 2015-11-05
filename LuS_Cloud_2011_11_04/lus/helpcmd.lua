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
			!newb
			!rules
			!callmod (important command)
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
					!suits
				!gambles
					!freezerhelp			
	]]

	if Message[1] == "!commands" or Message[1] == "!help" then
		InputConsole("pamsg %d Commands: !newb, !rules, !callmod, !accounthelp, !bankhelp, !lottohelp, !buyhelp, !mischelp, !premiumhelp.", pID)
		if user[pID]:HasAccess(2) then
			InputConsole("pamsg %d Commands: !modhelp", pID)
		end
		
		if user[pID]:IsLogged() == false then
			InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
		end
		return 1
	end
	
		if Message[1] == "!newb" then
			ShowNewb(pID)

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
			InputConsole("pamsg %d The bank opens after 5 minutes. You can !buy1k to exchange 2 recs for 1k in-game credits without having to wait for the bank to open.", pID)
			InputConsole("pamsg %d To rec someone, type !rec <player>. To noob someone, type !noob <player> or !n00b <player>. To check another player their recs, use !tp <player>", pID)
			InputConsole("pamsg %d To withdraw credits, use !wi <credits>. To exchange recs for credits in your bank, use !ex <recs>. If you have accidently !wi over 45k, you can use !undowi within 30 seconds to get your money back", pID)
			InputConsole("pamsg %d To check your balance, you can use !bal or !balance, to check another player their balance, use !bal <player> or !balance <player>.", pID)
		
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
				InputConsole("pamsg %d Premium Commands: !vipgamble, !bonuscreds, !vipvehregen, !upx10, !hummerbot, !buggybot, !elitequad, !shockerbot, !ae, !g3, !t3, !ambush <player>, !zs, !ago.", pID)	
				
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
			InputConsole("pamsg %d Commands: !gethp <player>, !scripts <player>, !tdonate <credits>, !sounds, !killme, !cps", pID)
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
				InputConsole("pamsg %d Commands: !bring <player>, !goto <player>, !send <player1> <player2>, !eject <player>, !modpower, !eteam, !gdi <player>, !nod <player>", pID)
				InputConsole("pamsg %d Commands: !islogged <player>, !isprotected <player>, !tabletest, !getaccess <player>, !getvip <player>, !yesuu <player>, !nouu <player>", pID)
				
				if user[pID]:HasAccess(3) then
					InputConsole("pamsg %d Commands: !freeze <player>, !unfreeze <player>, !mute <player>, !unmute <player>, !blockdmg <player>, !allowdmg <player>", pID)
					InputConsole("pamsg %d Commands: !removepass <player>, !resetip <player>, !resetserial <player>, !fundowi <player>", pID)
				end
				
				if user[pID]:HasAccess(4) then
					InputConsole("pamsg %d Commands: !disable <player>, !enable <player>, !reloadconfig, !0wn <player>, !memory, !clearmem, !jail <player>, !dejail", pID)
					InputConsole("pamsg %d Commands: !addrecs <player> <recs>, !removerecs <player> <recs>, !setrecs <player> <recs>, !refund <player> <credits>", pID)
					InputConsole("pamsg %d Commands: !addcredits <player> <credits>, !removecredits <player> <credits>, !setcredits <player> <credits>", pID)
					InputConsole("pamsg %d Commands: !saveall, !fsave <player>, !flogout <player>, !rm (module), !flotto, !passwordset <player> <password>, !setaccess <player> <level>", pID)
				end
				
				if user[pID]:HasAccess(5) then
					InputConsole("pamsg %d Commands: !spawn <preset> <team>, !last, !model <model>, !getm <player>, !youm <model> <player>, !setm <player>, !getp <player>, !toilet, !fly.", pID)
					InputConsole("pamsg %d Commands: !addvip <player> <months>, !setvip <player> <months>, !removevip <player> <months>, !addvipsub <player>, !removevipsub <player>, !lua <chunk>.", pID)
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
					if Get_Team(pID) == 1 then
						InputConsole("pamsg %d GDI Commands: !gbot (1000), !grbot (1800), !mobot (2500), !rgbot (2800), !hotbot (3500), !gdicommander (4000), !gdiarmy (4000), !sbot (5000).", pID)
					elseif Get_Team(pID) == 0 then
						InputConsole("pamsg %d Nod Commands: !nbot (1000), !nrbot (1800), !mebot (2500), !rnbot (2800), !techbot (3500), !nodcommander (4000), !nodarmy (4000), !rbot (5000).", pID)
					end
					InputConsole("pamsg %d Commands: !rambot (3000), !buyshockerbot (10 Recs).", pID)
					if user[pID]:IsVIP() then
						InputConsole("pamsg %d Premium Commands: !elitesquad (25 0000), !ambush <player> (6000)", pID)
					end
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
	
			if Message[1] == "!tankbots" then
				if user[pID]:HasAccess(1) then
					if Get_Team(pID) == 1 then
						InputConsole("pamsg %d Premium Commands: !hummerbot (2800).", pID)
					else
						InputConsole("pamsg %d Premium Commands: !buggybot (2800).", pID)
					end
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
	
			if Message[1] == "!build" then
				if user[pID]:HasAccess(1) then
					InputConsole("pamsg %d Commands: !buytibsilo (25 Recs).", pID)
					if Get_Team(pID) == 1 then
						InputConsole("pamsg %d GDI Commands: !gun (500), !g (600), !g2 (2500), !tg (3000), !gneg silo (12000), !agt (35000).", pID)
					elseif Get_Team(pID) == 0 then
						InputConsole("pamsg %d Nod Commands: !tail (400), !t (500), !it (2000), !t2 (2500), !nneg silo (12000), !obby/!obelisk (35000).", pID)
					end
					InputConsole("pamsg %d Commands: !cg (250), !wall (300), !sam (800), !cannon (1000), !cgring (2500), !deathcannon (3000), !rt (4500), !artytower/!at (6500), !teslatower/!tesla (7500), !tib silo (10 000).", pID)
					if user[pID]:IsVIP() then
						if Get_Team(pID) == 1 then
							InputConsole("pamsg %d Premium Commands: !g3 (4500), !ae (35 000), !ago (45 000).", pID)
						else
							InputConsole("pamsg %d Premium Commands: !t3 (4500), !ae (35 000), !ago (45 000).", pID)
						end
					end
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
	
			if Message[1] == "!chars" or Message[1] == "!char" then
				if user[pID]:HasAccess(1) then
					InputConsole("pamsg %d Commands: !yuri (5000), !rav (6500), !darkorbit (8000), !petrova (9000), !reddwire (12 750), !aqollo (15 000), !assassin (15 500), !fsfox (20 000), !spy123321/!spy (25 000).", pID)
					InputConsole("pamsg %d Commands: !refundhelp, !engie (<0), !sbh (1000), !hotwire (1500), !tech (1500), !jumpy (2000), !ralph (3000), !orphan (3000), !mrmutant (3000), !c4tech (3800), !prisoner (4500), !mrmoney (5000).", pID)
				else
					InputConsole("ppage %d You do not have access to this command.", pID)
				end
				return 1
			end
			
			if Message[1] == "!refundhelp" then
				if user[pID]:HasAccess(1) then
					InputConsole("ppage %d Refund you char with !refundme. Refundable chars: !aqollo, !mrmoney, !darkorbit, !robber")
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
					InputConsole("pamsg %d Commands: !up (1000), !upv (2000), !mutantharvy, !weapons, !regens, !suits.", pID)
					if user[pID]:IsVIP() then
						InputConsole("pamsg %d Premium Commands: !upx10 (5500)", pID)
					end
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
	
				if Message[1] == "!regens" or Message[1] == "!regen" then
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
						InputConsole("pamsg %d Commands: !tibsuit/!ts (2500), !killsuit/!ks (2500), !ss (3000), !absorbsuit/!as (3500), !cobrasuit/!cs (4000 !reddwire only), !nukesuit/!ns (8000).", pID)
						if user[pID]:IsVIP() then
							InputConsole("pamsg %d Premium Commands: !zombiesuit/!zs (1500)", pID)
						end
					else
						InputConsole("ppage %d You do not have access to this command.", pID)
					end
					return 1
				end
				
			if Message[1] == "!gambles" then
				if user[pID]:HasAccess(1) then
					InputConsole("pamsg %d Commands: !lowgamble (500), !chancegamble (1500), !medgamble (3500), !highgamble (10000), !freezerhelp.", pID)
					if user[pID]:IsVIP() then
						InputConsole("pamsg %d Premium Commands: !vipgamble", pID)
					end
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

function ShowNewb(pID)
	InputConsole("pamsg %d Server updates comes around once every week, use !updates to see the latest updates. Cloud C&C is a very unique server, and we, Cloud-Zone Gaming, hope that you can enjoy your time here!", pID)
	InputConsole("pamsg %d This server also has a very strong weapon called the 'Obelisk gun' (Obbygun), which shoots an Obelisk Laser. You can get it using the !commandopack or by buying a !char that has one.", pID)
	InputConsole("pamsg %d Don't be intimidated if you can't seem to damage another player, it is likely he/she upgraded their health. You can use the command !gethp <player> to see their current health.", pID)
	InputConsole("pamsg %d For more info, you can use the command !accounthelp. There are two commands named in !accounthelp: !protecthelp and !loginhelp. Please check them out to protect your account against nickspoofers.", pID)
	InputConsole("pamsg %d To get a full list of commands, please type !commands. Every player has an account on our server. This is for our banksystem (!bankhelp), lottosystem (!lottohelp) and more.", pID)
	InputConsole("pamsg %d Welcome to Cloud C&C Mode! You may or may not have noticed that this is a modified server. Our website is located at www.cloud-zone.com. Please read our !rules!", pID) 
end
