module('sounds', package.seeall)

soundlist = {}
soundhelplist = {}
si = 1

function Play(sound)
	if soundlist[sound] ~= nil then
		for tID, v in pairs(user) do
			if user[tID]:GetSound() == 1 then
				InputConsole("sndp %d %s", tID, soundlist[sound])
			end
		end
	end
end

function LoadSounds()
	soundfile = io.open("LuaPlugins\\lus\\data\\sounds.txt", "r")
	if soundfile ~= nil then
		for line in soundfile:lines() do
			strequal = string.find(line, "=")
			if strequal ~= nil then
				soundmsg = string.sub(line, 0, strequal-1)
				sound = string.match(line, ".+%.[^%s]+", strequal+1)
				soundlist[soundmsg] = sound
				
				if sound ~= nil and soundmsg ~= nil then
					if soundhelplist[si] == nil then
						soundhelplist[si] = soundmsg
					else
						if string.len(soundhelplist[si]..', '..soundmsg) > 128 then
							si = si + 1
							soundhelplist[si] = soundmsg
						else
							soundhelplist[si] = soundhelplist[si]..', '..soundmsg
						end
					end
				end
			end
		end
	end
	soundfile:close()
end

--[[ Old Sound Help List
if Message == "!sounds" then
		InputConsole("msg %d !sounds2-6, !rsp, !ra2sp", pID)
		InputConsole("msg %d die affirmative bye cya aha traffic terrorist shutup stfu destroy no whoops ns fun unstable guys where meee target2 attack bla junior candy boink", pID)
		InputConsole("msg %d stupid mechman bell inc cow creak sak monster run2 what clear hurry kill_him jerks gameover gg helidown hmm hey heh go fight cover negative sorry", pID)
		InputConsole("msg %d chicky skill hehe hh tt tuff yes_sir yeah fall got_it grunt good dead oops creature roar target incinerate fire smell ^^ toast pain present burn", pID)
	end
	if Message == "!sounds2" then
		InputConsole("msg %d situation_under_control time_for_action support gotcha gotya coffee ask hunt ceiling_turret pray amateur eye lucky finally mobius boo", pID)
		InputConsole("msg %d system_backup dubi shatter hit bravo bear rooster battle dogs petrova pet job_hazard out_of_the_way who_is_there call_a_doctor man_down", pID)
		InputConsole("msg %d boink2 door rain destruction yes rav father tv help dont_shoot_me hello hi hi2 haha muhaha hihi move medic elephants ow aw not_now", pID)
	end
	if Message == "!sounds3" then
		InputConsole("msg %d dance headache munchies dont+shoot quiet heads_up watch_out help2 run yell np wow stay_down got_one cool bigheads wasted kane phew superman", pID)
		InputConsole("msg %d hero oo o.o comeon cmon gun ambulance flies woops whoa yeah2 ha hey2 yes_sir2 yes_sir3 ow2 pin7 rape ty 1 2 3 4 smart yo bird time_to_die elena gogogo", pID)
		InputConsole("msg %d orva_volley whip all_right", pID)
	end
	if Message == "!sounds4" then
		InputConsole("msg %d Sounds: fat chaos wait cool grr dietime unreal enemy stfu body notstupid imhit trydie n00b funny lucky gg urdead boom oops", pID)
		InputConsole("msg %d cya bye squirrel ask die daddy pu pc pf sc su", pID)
		InputConsole("msg %d sf boink hawk1 hawk2 bu bf bc guns snipe sit shoot jerks smile hehe stupid call kids run chicky hehe skill urside", pID)
		InputConsole("msg %d mlaunch war2 moo notwelcome lag sexy school wnn weee nooo notv blabla pain dance never nice", pID)
	end
	if Message == "!sounds5" then
		InputConsole("msg %d Sounds: mullet huh die exterminate work weird monster search bombdrop gull :( mutation deathscream whatami ooops join opinion polish newtarget", pID)
		InputConsole("msg %d Sounds: cry alarm alarm2 ion heart justice hurt devastation fast patience sayitright noob elec rocknroll secure doloo ", pID)
		InputConsole("msg %d Sounds: delta coming sleep tibdeath animals property field hello2 dololo dowowo", pID)
	end
	if Message == "!sounds6" then
		InputConsole("msg %d Sounds: trouble 'oh no' 'o rly?' witty present2 hold np", pID)
		InputConsole("msg %d Sounds: who? hobby 'well done' neverthought room specialty getit trespassers how? yourdead", pID)
	end
	if Message == "!ra2sp" or Message == "!ra2soundpack" or Message == "!ra2sounds" then

		InputConsole("msg Sonic's RA2 Sound Pack Sounds: blueprints, bomb, c4, captain, closing_on_target, destination, easy, firezone, flak, helium, highroad, job ", pID)

		InputConsole("msg , kirov, knowledge, mind, mind_is_clear, request, rocket, romanov, russia, smuggler, tanya, truck, vehicle, wish", pID)

	end
	if Message == "!rsp" or Message == "!soundpack" or Message == "!newsounds" then

		InputConsole("msg Sonic's Renegade Sound Pack Sounds: 911, ahhh, boing, bubble, cock, dundundundun, explode, falcon, punch, falling, end, hell, here_we_go, hey!, ", pID)

		InputConsole("msg , lazor, jump, kaboom, leeroy, listen, health, gun, mario, mario_ow, quack, ring, speed, sega, sparta, sword, tingle, television, 9000, water, wtf, look, hello!, watchout", pID)

	end
	if Message == "!rsp2" then		
		InputConsole("pamsg %d , doublerainbow, friday, ohcrap, whichseat, turtles, grandpa", pID)
		
		InputConsole("pamsg %d , beep, camera, charizard, cheer, coin, comeon, continue, dance, decaf, doh, dynamite, eyo, kick, explode, gosonic", pID)
		
		InputConsole("pamsg %d , haahaa, hammer, incredible, ivysaur, jackpot, jigglypuff, name, notevenclose, pawnch, squirtle, surprize, throw, time", pID)
		
		InputConsole("pamsg %d , tourny, triplefinish, wah, wars, weather, pbj, pikafall, pikmin, thunder, pkfire, flash, starstorm, show, slow, banana", pID)
		
		InputConsole("pamsg %d , sunnyd, nation, uuu, motivation, rude, tonight, faraway, notafraid, grenade, allaboard, pokemon, shutup, you, awesome", pID)
		
		InputConsole("pamsg %d octogonopus, pika, pikaaa, pikapika, star, clap, chocolate, hax, gas, mic, pity, base, airplanes, and, aura, awww", pID)
	
	end--]]