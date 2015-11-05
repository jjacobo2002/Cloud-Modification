module('rm', package.seeall)

--[[if Message == "I have no friends :(" then
		if rprize6 == 1 then
			if Get_Team(pID) == 1 then
				InputConsole("cmsg 61,89,171 %s has recieved friends from the Random Message Gods.", sName)
				local pos = Get_Position(Get_GameObj(pID))
				local Facing = Get_Facing(Get_GameObj(pID))
				local Distance = 0 --the distance, of how far to create the object from the player.
				pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
				pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
				pos.Z = pos.Z + 1
				pos.Y = pos.Y - 3
				turret = Create_Object("", pos)
				pos.Z = pos.Z + 1
				pos.Y = pos.Y + 1
				turret = Create_Object("", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y + 1
				turret = Create_Object("GDI_Minigunner_0", pos)
				pos.X = pos.X - 1
				pos.Y = pos.Y + 1
				turret = Create_Object("GDI_Minigunner_0", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y - 1
				turret = Create_Object("", pos)
				pos.X = pos.X - 1
				pos.Y = pos.Y + 1
				turret = Create_Object("GDI_Minigunner_0", pos)
				pos.Z = pos.Z + 1
				pos.X = pos.X + 2
				pos.Y = pos.Y + 3
				turret = Create_Object("GDI_RocketSoldier_0", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y - 1
				turret = Create_Object("GDI_Minigunner_0", pos)
				pos.Z = pos.Z + 1
				pos.X = pos.X + 3
				pos.Y = pos.Y - 2
				turret = Create_Object("GDI_Minigunner_0", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y - 1
				turret = Create_Object("GDI_Minigunner_0", pos)
				pos.Y = pos.Y + 1
				turret = Create_Object("GDI_Minigunner_0", pos)
			elseif Get_Team(pID) == 0 then
				InputConsole("cmsg 61,89,171 %s has recieved friends from the Random Message Gods.", sName)
				local pos = Get_Position(Get_GameObj(pID))
				local Facing = Get_Facing(Get_GameObj(pID))
				local Distance = 0 --the distance, of how far to create the object from the player.
				pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
				pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
				pos.Y = pos.Y + 1
				pos.Z = pos.Z + 1
				turret = Create_Object("", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y - 1
				turret = Create_Object("", pos)
				pos.X = pos.X + 1
				turret = Create_Object("Nod_Minigunner_0", pos)
				pos.X = pos.X + 1
				pos.Y = pos.Y + 2
				turret = Create_Object("Nod_Minigunner_0", pos)
				pos.Z = pos.Z + 1
				pos.X = pos.X + 3
				pos.Y = pos.Y - 2
				turret = Create_Object("Nod_Minigunner_0", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y - 1
				turret = Create_Object("Nod_Minigunner_0", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y - 1
				turret = Create_Object("", pos)
				pos.Z = pos.Z + 1
				pos.X = pos.X + 2
				pos.Y = pos.Y + 3
				turret = Create_Object("Nod_RocketSoldier_0", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y - 1
				turret = Create_Object("Nod_Minigunner_0", pos)
				pos.Z = pos.Z + 1
				pos.X = pos.X + 2
				pos.Y = pos.Y + 3
				turret = Create_Object("Nod_Minigunner_0", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y - 1
				turret = Create_Object("Nod_Minigunner_0", pos)
			end
			rprize6 = 0
		end
	end--]]

reward = {}
rmsg = {}

reward[1] = false -- !omg
reward[2] = false -- www.cloud-zone.com
reward[3] = false -- Dark is cool!
reward[4] = false -- i love random messages!
reward[5] = false -- MY TEAM OWNS!
reward[6] = false -- i have no friends :(

function Command(pID, Message)
	if Message[-1] == "!omg" then
		if user[pID]:HasAccess(1) and reward[1] then
			Set_Money(pID, Get_Money(pID)+1000)
			InputConsole("cmsg 61,89,171 %s has recieved 1,000 credits from the Random Message Gods.", user[pID]:GetName())
			
			reward[1] = false
		end
		return 1
	end
	
	if Message[-1] == "www.cloud-zone.com" then
		if user[pID]:HasAccess(1) and reward[2] then
			pObj = Get_GameObj(pID)

			Set_Max_Health(pObj ,Get_Max_Health(pObj)+35)
			Set_Max_Shield_Strength(pObj ,Get_Max_Shield_Strength(pObj)+35)
			
			Set_Health(pObj, Get_Health(pObj)+50)
			Set_Shield_Strength(pObj, Get_Shield_Strength(pObj)+50)
			
			InputConsole("cmsg 61,89,171 %s has recieved a health upgrade from the Random Message Gods.", user[pID]:GetName())
			
			reward[2] = false
		end
		return 1
	end
	
	if Message[-1] == "Dark is cool!" then
		if user[pID]:HasAccess(1) and reward[3] then
			Set_Money(pID, Get_Money(pID)+2000)
			InputConsole("cmsg 61,89,171 %s has recieved 2,000 credits from the Random Message Gods.", user[pID]:GetName())
			
			reward[3] = false
		end
		return 1
	end
	
	if Message[-1] == "i love random messages!" then
		if user[pID]:HasAccess(1) and reward[4] then
			Grant_Powerup(Get_GameObj(pID), "CnC_MineProximity_05")
			InputConsole("cmsg 61,89,171 %s has recieved proxys from the Random Message Gods.", user[pID]:GetName())
			
			reward[4] = false
		end
		return 1
	end
	
	if Message[-1] == "MY TEAM OWNS!" then
		if user[pID]:HasAccess(1) and reward[5] then
			team = Get_Team(pID)
			for tID, v in pairs(user) do
				if Get_Team(tID) == team then
					Set_Money(tID, Get_Money(tID)+500)
				end
			end
			
			teamname = "Nod"
			if team == 1 then teamname = "GDI" end
			
			InputConsole("cmsg 61,89,171 Each %s player has received 500 credits from the Random Message Gods!", teamname)
			
			reward[5] = false
		end
		return 1
	end
	
	if Message[-1] == "I have no friends :(" then
		if user[pID]:HasAccess(1) and reward[6] then
			team = Get_Team(pID)
			if team == 0 then
				botlist = { "Nod_Minigunner_0", "Nod_Minigunner_1Off", "Nod_RocketSoldier_0" }	
			elseif team == 1 then
				botlist = { "GDI_Minigunner_0", "GDI_Minigunner_1Off", "GDI_RocketSoldier_0" }
			end
			
			Units = 11
			Distance = 4
			Facing = Get_Facing(Get_GameObj(pID))
			FaceInc = 360/Units

			pos = Get_Position(Get_GameObj(pID))
			pos.Z = pos.Z + 0.1

			for i=1, Units do
				rb = math.random(1, table.maxn(botlist))
				objname = botlist[rb]
				Xnew = pos.X + (Distance * math.cos(Facing*(math.pi/180)))
				Ynew = pos.Y + (Distance * math.sin(Facing*(math.pi/180)))

				newpos = { X=Xnew, Y=Ynew, Z=pos.Z }
				obj = Create_Object(objname, newpos)

				Facing = Facing + FaceInc
				if Facing > 360 then
					Facing = -180+(Facing-360)
				end
			end
			
			InputConsole("cmsg 61,89,171 %s has recieved friends from the Random Message Gods.", user[pID]:GetName())
			
			reward[6] = false
		end
		return 1
	end
	
	return false
end

rmsg[1] = function()
	InputConsole("msg RM #1: Cloud Gaming started in August of 2009, and it has been growing ever since!")
end

rmsg[2] = function()
	InputConsole("msg RM #2: Be the first to type !omg and recieve 1000 credits!")
	reward[1] = true
end

rmsg[3] = function()
	InputConsole("msg RM #3: Organ donors save lives. Become one today!")
end

rmsg[4] = function()
	InputConsole("msg RM #4: DarkOrbit is actually an online game, but DarkOrbit no longer plays it.")
end

rmsg[5] = function()
	InputConsole("msg RM #5: While obelisk guns are fun, they piss most people off. If you want popularity, don't get one, instead snipe n00bs to death.")
end

rmsg[6] = function()
	InputConsole("msg RM #6: Did you know Someone10 was the first cloud player?")
end

rmsg[7] = function()
	InputConsole("msg RM #7: Look around, the enemy may be near.")
end

rmsg[8] = function()
	InputConsole("msg RM #8: Players with scripts have more advantages... Download scripts 4+.")
end

rmsg[9] = function()
	InputConsole("msg RM #9: Welcome to cloud-zone, the coolest server of all times.")
end

rmsg[10] = function()
	InputConsole("msg RM #10: Did you know that canisnip is a common donator and that he payed for the whole player of the month competition!?")
end

rmsg[11] = function()
	InputConsole("msg RM #11: Player of the month February 2010: juninho15")
end

rmsg[12] = function()
	InputConsole("msg RM #12: Did you know that this server is 90%% one-man made?")
end

rmsg[13] = function()
	InputConsole("msg RM #13: I like donuts!")
end

rmsg[14] = function()
	InputConsole("msg RM #14: Something wrong? Blame it on Darkorbit!")
end

rmsg[15] = function()
	InputConsole("msg RM #15: Think about the irony involved while trying to put a character into a wall. Weird, eh?")
end

rmsg[16] = function()
	InputConsole("msg RM #16: Did you know that the character, !orphan, is faster than your internet connection?")
end

rmsg[17] = function()
	InputConsole('msg RM #17: Did you know that all commands begin with a "!"?')
end

rmsg[18] = function()
	InputConsole("msg RM #18: Did you know that you get banned for cheating?")
end

rmsg[19] = function()
	InputConsole("msg RM #19: Did you know that someone is behind you right now?")
end

rmsg[20] = function()
	InputConsole("msg RM #20: Did you know flying is only for people who are afraid of running?")
end

rmsg[21] = function()
	InputConsole("msg RM #21: Did you know that tiberium can hurt you without a tib suit?")
end

rmsg[22] = function()
	InputConsole("msg RM #22: Did you know that there are too many 'did you know' questions?")
end

rmsg[23] = function()
	InputConsole("msg RM #23: Did you know that reseti is also the anoying mole in Animal Crossing?")
end

rmsg[24] = function()
	InputConsole("msg RM #24: Look around, the enemy may be near.")
end

rmsg[25] = function()
	InputConsole("msg RM #25: If you go under you will be owned by a moderator.")
end

rmsg[26] = function()
	InputConsole("msg RM #26: Look around, the enemy may be near.")
end

rmsg[27] = function()
	InputConsole("msg RM #27: If you have alot of cash, stop thinking of yourself and donate some of your teammates")
end

rmsg[28] = function()
	InputConsole("msg RM #28: The Legend says: You are what you eat.")
end

rmsg[29] = function()
	InputConsole("msg RM #29: Be happy or prepare to die.")
end

rmsg[30] = function()
	InputConsole("msg RM #30: People who use bad language in Cloud Server get LYNCHED a few days later in real life.")
end

rmsg[31] = function()
	InputConsole("msg RM #31: Here rulez KAMUIXMOD")
end

rmsg[32] = function()
	InputConsole("msg RM #32: If you attack, then dont do it alone! Get a helping hand.")
end

rmsg[33] = function()
	InputConsole("msg RM #33: Did you know the French government hates YOU? (jk)")
end

rmsg[34] = function()
	InputConsole("msg RM #34: Restart approved (requested by DarkOrbit). Restarting in 5 seconds. (jk)")
end

rmsg[35] = function()
	InputConsole("msg RM #35: Did you know a ramjet headshot does 1,000 damage?")
end

rmsg[36] = function()
	InputConsole("msg RM #36: Did you know a good tactic to kill strong characters is to drop vehicles on them?")
end

rmsg[37] = function()
	InputConsole("msg RM #37: What is the most important thing in your life? Your Life?! Wrong! It is Cloud.")
end

rmsg[38] = function()
	InputConsole("msg RM #38: God's great and strong but you have the chance to get stronger with !up1k. Use it, drink it!!!")
end

rmsg[39] = function()
	InputConsole("msg RM #39: You should be jealous because Harry Potter can fly and you cannot.")
end

rmsg[40] = function()
	InputConsole("msg RM #40: You're weak. What you need is Dr.Pepper. Drink it and you'll be like Kane.")
end

rmsg[41] = function()
	InputConsole("msg RM #41: If Darkorbit joins everybody gets a blackscreen.")
end

rmsg[42] = function()
	InputConsole("msg RM #42: Wanna create more fairness ingame? Try your chance to join our Mod Community and create Happiness for everybody who plays Cloud.")
end

rmsg[43] = function()
	InputConsole("msg RM #43: WARNING: CABAL inc, RUN!")
end

rmsg[44] = function()
	InputConsole("msg RM #44: Did you know that I am behind you, already typing !buggy?")
end

rmsg[45] = function()
	pID = math.random(1, max_pID)
	while user[pID] == nil do
		pID = math.random(1, max_pID)
	end
	
	weaponlist = { "POW_Railgun_Player", "POW_PersonalIonCannon_Player", "POW_VoltAutoRifle_Player", "POW_RamjetRifle_Player" }
	
	Grant_Powerup(Get_GameObj(pID), weaponlist[math.random(1, table.maxn(weaponlist))])
	InputConsole("msg RM #45: Congratulations, %s! You've won the hourly prize of the PWN-GUN!", user[pID]:GetName())
end

rmsg[46] = function()
	InputConsole("msg RM #46: Did you know that it costs 240k (240 !ups) to get a 2k orphan from scratch?")
end

rmsg[47] = function()
	InputConsole("msg RM #47: Put your pants on! (Lol cani?)")
end

rmsg[48] = function()
	InputConsole("msg RM #48: Deal or no deal. This is the question.")
end

rmsg[49] = function()
	InputConsole("msg RM #49: Not everybody is something special but you can create your own future with your hands and credits.")
end

rmsg[50] = function()
	InputConsole("msg RM #50: ~Darkorbit is Da Master, Rezpect Him At All Coztz~")
end

rmsg[51] = function()
	InputConsole("msg RM #51: Go to the forums to add a message to these random messages!")
end

rmsg[52] = function()
	InputConsole("msg RM #52: Need help with Math? Ask Brcaspa. LOL.")
end

rmsg[53] = function()
	InputConsole("msg RM #53: Sonic has entered the game. Assume the position.")
end

rmsg[54] = function()
	InputConsole("msg RM #54: Pizza pizza pizza pie, it's so good you can't deny")
end

rmsg[55] = function()
	InputConsole("msg RM #55: Cloud is actually an acronym for 'Cool Leet Ownage Uber Death'. Lol, wait, no it isn't.")
end

rmsg[56] = function()
	InputConsole("msg RM #56: Type 'www.cloud-zone.com' for a health upgrade!")
	reward[2] = true
end

rmsg[57] = function()
	InputConsole("msg RM #57: Type 'Dark is cool! for 2,000 credits!")
	reward[3] = true
end

rmsg[58] = function()
	InputConsole("msg RM #58: Type 'i love random messages!' for proxys!")
	reward[4] = true
end

--[[ Disabled, no reward. (Might crash the server)
rmsg[59] = function()
	InputConsole("msg RM #59: Type 'iwannabeachicken' to turn into a chicken!")
	reward[59] = true
end--]]

rmsg[60] = function()
	InputConsole("msg RM #60: maciozo likes everyone =D")
end

rmsg[61] = function()
	InputConsole("msg RM #61: Bow down before me, for I am Host!")
end

rmsg[62] = function()
	InputConsole("msg RM #62: I Like short-shorts!")
end

rmsg[63] = function()
	InputConsole("msg RM #63: YYYYYAAAAAYYYYY! Your letting me be myself!")
end

rmsg[64] = function()
	InputConsole("msg RM #64: May The Cloud Be With You!")
end

rmsg[65] = function()
	InputConsole("msg RM #65: Go Team GDI!")
end

rmsg[66] = function()
	InputConsole("msg RM #66: Go Team Nod!")
end

rmsg[67] = function()
	InputConsole("msg RM #67: Everything is just one big.... cloud?")
end

rmsg[68] = function()
	InputConsole("msg RM #68: Those are my two buggaboos!")
end

rmsg[69] = function()
	InputConsole("msg RM #69: I like my donuts sprinkled with pink frosting")
end

rmsg[70] = function()
	InputConsole("msg RM #70: While dropping a buggy on characters with a lot of hp is an easy way to kill them, it's also an easy way to make somebody hate you!")
end

rmsg[71] = function()
	InputConsole("msg RM #71: Using !gethp on whitneyH is a guarantee that you'll get noobed!")
end

rmsg[72] = function()
	InputConsole("msg RM #72: Fizzy1234 doesnt know much but what he does know, you better not challenge him!")
end

rmsg[73] = function()
	InputConsole("msg RM #73: Now you see me, now your dead ")
end

rmsg[74] = function()
	InputConsole("msg RM #74: Get over it, slave gnome! The server won't power itself!")
end

rmsg[75] = function()
	InputConsole("msg RM #75: I love the way you lie")
end

rmsg[76] = function()
	InputConsole("msg RM #76: Live your life to the fullest. Then, when you die, respawn at Lumbridge.")
end

rmsg[77] = function()
	InputConsole("msg RM #77: Where's my pants? *looks at cani..*")
end

rmsg[78] = function()
	InputConsole("msg RM #78: To-do list.. 1. chores..  2. shopping.. 999. cloud.. 'hmm.. i can always do the chores later... >.>'")
end

rmsg[79] = function()
	InputConsole("msg RM #79: Did you know canisnip never wears underwear yet he has millions of them!")
end

rmsg[80] = function()
	InputConsole("msg RM #80: SxDarkOne is officially an anime addict!")
end

rmsg[81] = function()
	InputConsole("msg RM #81: Kamuixmod likes Jadedrgn")
end

rmsg[82] = function()
	InputConsole("msg RM #82: B0b is to sexy for my shirt")
end

rmsg[83] = function()
	InputConsole("msg RM #83: This is a random message")
end

rmsg[84] = function()
	InputConsole("msg RM #84: Why are you wasting your time reading this message when you could be playing a game?")
end

rmsg[85] = function()
	InputConsole("msg RM #85: You must construct additional pylons!!!!")
end

rmsg[86] = function()
	InputConsole("msg RM #86: KARMA CHARGER INCOMING!!! RUN!!!")
end

rmsg[87] = function()
	InputConsole("msg RM #87: MutateMe is so awesome that you just can't denie!! (luv u muta) :p")
end

rmsg[88] = function()
	InputConsole("msg RM #88: Did you know you could refund a mr.money, robber, darkorbit and aqollo simply by typing !refund me ?!?")
end

rmsg[89] = function()
	InputConsole("msg RM #89: Guns don't kill people, Robbers do!")
end

rmsg[90] = function()
	InputConsole("msg RM #90: ERROR: ~Ran out of messages~")
end

rmsg[91] = function()
	InputConsole("msg RM #91: I'm here to kick ass and chew bubble gum, and i'm all out of kick ass.")
end

rmsg[92] = function()
	InputConsole("msg RM #92: When stealing cash with a robber remember one thing, be careful of who you steal from, Darkorbit Will take revenge!")
end

rmsg[93] = function()
	InputConsole("msg RM #93: Do you know what's faster than a orphan?! SONIC! He runs faster than light and time and sound all put together! and he plays here in cloud!")
end

rmsg[94] = function()
	InputConsole("msg RM #94: Soon, all will become clear.")
end

rmsg[95] = function()
	InputConsole("msg RM #95: The first person to type 'MY TEAM OWNS!' will grant 500 credits to each person on their team!")
	reward[5] = true
end

rmsg[96] = function()
	InputConsole("msg RM #96: This doesn't look good. Call a !doctor")
end

rmsg[97] = function()
	InputConsole("msg RM #97: Yeah, Yeah, Yeah. Wouldyamind girl, if i told you, last night really blew my mind?")
end

rmsg[98] = function()
	InputConsole("msg RM #98: No disrespect.")
end

rmsg[99] = function()
	InputConsole("msg RM #99: Your so amazing, remember the time, just thinking about you, gives me butterflies.")
end

rmsg[100] = function()
	InputConsole("msg RM #100: HUURAY!!! RANDOM MESSAGE 100!!! EVERYONE GAINS 1,000 CREDITS!")
	for tID, v in pairs(user) do
		Set_Money(tID, Get_Money(tID)+1000)
	end
	InputConsole("cmsg 61,89,171 EVERYONE has recieved 1,000 from the Random Message Gods!!!!")
end

rmsg[101] = function()
	InputConsole("msg RM #101: Reach your hand in the sky, to see when you will die.")
end

rmsg[102] = function()
	InputConsole("msg RM #102: Ever tried catching a sludge and put some salt on it? *hehe*")
end

rmsg[103] = function()
	InputConsole("msg RM #103: Sorry man, I madez you a cookie, but I ate it =(")
end

rmsg[104] = function()
	InputConsole("msg RM #104: Ever tried putting names together? SoniCabal, DarkorbiToeinfection, Oh sorry, my bad.")
end

rmsg[105] = function()
	InputConsole("msg RM #105: !vote yes..Oh, what's the poll?")
end

rmsg[106] = function()
	InputConsole("msg RM #106: Visceroid mutation! Help! no! Kill him. grunt grunt grunt grunt ^^ grunt huffhuff grunt grunt.")
end

rmsg[107] = function()
	InputConsole("msg RM #107: GDI Tiberium Refinery not under attack!")
end

rmsg[108] = function()
	InputConsole("msg RM #108: Ninjas can't catch you if you go stealth!")
end

rmsg[109] = function()
	InputConsole("msg RM #109: To get the new maps on this server, go to cloud-zone.com and view the thread called new maps under announcements. Then follow the link under the post.")
end

rmsg[110] = function()
	InputConsole("msg RM #110: Ah man we ran out of random messages..")
end

rmsg[111] = function()
	InputConsole("msg RM #111: The ice cream man sells ice cream")
end

rmsg[112] = function()
	InputConsole("msg RM #112: Be careful with the Obby Gun, as you can kill yourself with it if you fire it too close to yourself.")
end

rmsg[113] = function()
	InputConsole("msg RM #113: Did you know that the bird is the word?")
end

rmsg[114] = function()
	InputConsole("msg RM #114: Did you know that I'm mad cuz 90% of all random messages start with DID YOU KNOW!!!!!")
end

rmsg[115] = function()
	InputConsole("msg RM #115: Caspa is a mixture of fun and madness.")
end

rmsg[116] = function()
	InputConsole("msg RM #116: Lelouch Vi Britannia commands you donate all of your cash to Darkorbit!")
end

rmsg[117] = function()
	InputConsole("msg RM #117: Imagination is the creation of fear.")
end

rmsg[118] = function()
	InputConsole("msg RM #118: This is one messed up looking cloud.")
end

rmsg[119] = function()
	InputConsole("msg RM #119: Mods are like teletubbies, we watch you on our screen!")
end

rmsg[120] = function()
	InputConsole("msg RM #120: Let this message be dedicated to WhitneyH. We will not forget you. R.I.P.")
end

rmsg[121] = function()
	InputConsole("msg RM #121: You can run, but not forever!")
end

rmsg[122] = function()
	InputConsole("msg RM #122: By the time you have finished reading this, you will have realized you just wasted 10 seconds of your life.")
end

rmsg[123] = function()
	InputConsole("msg RM #123: Did you know Random_Fire_Guy likes doing random stupid things for no apparent reason?")
end

rmsg[124] = function()
	InputConsole("msg RM #124: For cake, please assume the party-escort submission position, or yell 'I WANT MY CAKE!'")
end

rmsg[125] = function()
	InputConsole("msg RM #125: Foxy is a care bear.")
end

rmsg[126] = function()
	InputConsole("msg RM #126: If a kid refuses to sleep during nap time, are they guilty of resisting a rest?")
end

rmsg[127] = function()
	InputConsole("msg RM #127: A bus station is where a bus stops. A train station is where a train stops. On my desk, I have a work station.")
end

rmsg[128] = function()
	InputConsole("msg RM #128: I was standing in the park wondering why frisbees got bigger as they get closer. Then it hit me.")
end

rmsg[129] = function()
	InputConsole("msg RM #129: The last thing I want to do is hurt you. But it's still on the list.")
end

rmsg[130] = function()
	InputConsole("msg RM #130: Light travels faster than sound. This is why some people appear bright until you hear them speak.")
end

rmsg[131] = function()
	InputConsole("msg RM #131: Mutiny!!!!!")
end

rmsg[132] = function()
	InputConsole("msg RM #132: The last guy who tried to buy an !ss with scripts got DENIED!!")
end

rmsg[133] = function()
	InputConsole("msg RM #133: Hey, don't forget about some of the older commands. Look around !commands and other menus.")
end

rmsg[134] = function()
	InputConsole("msg RM #134: Remember, try and be friendly in this server. Even if someone isn't friendly to you.")
end

rmsg[135] = function()
	InputConsole("msg RM #135: Here at Cloud C&C, we take pride in being a tight community! We encourage you to join it!")
end

rmsg[136] = function()
	InputConsole("msg RM #136: Stop texting and play!!!")
end

rmsg[137] = function()
	InputConsole("msg RM #137: BRB, gotta run to the bathroom.")
end

rmsg[138] = function()
	InputConsole("msg RM #138: Why is 'Z' the last letter of the alphabet? Because it overslept!")
end

rmsg[139] = function()
	InputConsole("msg RM #139: The names....RANGO!")
end

rmsg[140] = function()
	InputConsole("msg RM #140: RANDOM MESSAGE MANIA! ALL RANDOM MESSAGE COMMANDS/PRIZES CAN BE USED!!!!")
	for k, v in pairs(reward) do
		reward[k] = true
	end
end

rmsg[141] = function()
	InputConsole("msg RM #141: Do you ever feel lonely? Not anymore! Just type 'I have no friends :(' and see what happens!")
	reward[6] = true
end