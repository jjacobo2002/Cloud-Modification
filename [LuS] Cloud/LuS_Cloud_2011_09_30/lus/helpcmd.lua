module('helpcmd', package.seeall)

function Command(pID, Message)
	--[[ Help/Commands tree.
		!commands/!help
			!accounthelp
				!myaccount
				!protecthelp
				!loginhelp
			!bankhelp
			!lottohelp
			!buyhelp
				!bots
				!build
				!chars
				!veh
				!upgrades
					!weapons
				!gambles
					!freezerhelp
			!mischelp
			!modhelp
	]]

	if Message[1] == "!commands" or Message[1] == "!help" then
		InputConsole("pamsg %d Commands: !accounthelp, !bankhelp, !lottohelp, !buyhelp, !mischelp", pID)
		if user[pID]:HasAccess(2) then
			InputConsole("pamsg %d Commands: !modhelp", pID)
		end
		
		if user[pID]:IsLogged() == false then
			InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
		end
		return 1
	end
	
	if Message[1] == "!lottohelp" then
		InputConsole("pamsg %d To check when the lotto starts, you can use !lotto. To check the price of a loti, type !lotiprice. To buy a loti, type !loti", pID)
	
		if user[pID]:IsLogged() == false then
			InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
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
	
	if Message[1] == "!accounthelp" then
		InputConsole("pamsg %d To reset your account-serial, use !serialreset", pID)
		InputConsole("pamsg %d You can increase the range of your account-IP using !iprangeup. To reset your account-IP, use !ipreset", pID)
		InputConsole("pamsg %d Commands: !myaccount, !protecthelp, !loginhelp, !dp, !soundon, !soundoff, !playtime (player), !onlinetime (player)", pID)
	
		if user[pID]:IsLogged() == false then
			InputConsole("pamsg %d Note: Most commands require you to be logged in!", pID)
		end
		return 1
	end
	
	if Message[1] == "!mischelp" then
		InputConsole("pamsg %d Commands: !scripts <player>, !tdonate <credits>", pID)
		if user[pID]:IsVIP() then
			InputConsole("pamsg %d Premium Commands: !bonuscreds", pID)
		end
		
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
			InputConsole("pamsg %d Commands: !bots, !build, !chars, !veh, !upgrades, !gambles", pID)
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
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
			InputConsole("pamsg %d Commands: !gapc (2000), !napc (2000), !flame (2000), !light (2200), !hovercraft (2500), !stank (2800), !mammy (3800), !demossm (5500).", pID)
			InputConsole("pamsg %d Commands: !buggy (700), !humvee (850), !recon (1000), !mrls (1200), !arty (1500), !gditrans (1500), !nodtrans (1500), !med (1500).", pID)
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!upgrades" then
		if user[pID]:HasAccess(1) then
			InputConsole("pamsg %d Commands: !weapons.", pID)
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
