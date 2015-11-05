module('rm', package.seeall)

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

			bots.MultiSpawn(Get_GameObj(pID), botlist, 11, 4, 0.1, true)
			
			InputConsole("cmsg 61,89,171 %s has recieved friends from the Random Message Gods.", user[pID]:GetName())
			
			reward[6] = false
		end
		return 1
	end
	
	return false
end

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Cloud Gaming started in August of 2009, and it has been growing ever since!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Be the first to type !omg and recieve 1000 credits!", rm)
	reward[1] = true
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Organ donors save lives. Become one today!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: DarkOrbit is actually an online game, but DarkOrbit no longer plays it.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: While obelisk guns are fun, they piss most people off. If you want popularity, don't get one, instead snipe n00bs to death.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know Someone10 was the first cloud player?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Look around, the enemy may be near.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Players with scripts have more advantages... Download scripts 4+.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Welcome to cloud-zone, the coolest server of all times.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that this server is 90%% one-man made?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: I like donuts!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Something wrong? Blame it on Darkorbit!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Think about the irony involved when trying to put a character into a wall. Weird, eh?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that the character, !orphan, is faster than your internet connection?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole('msg RM #%d: Did you know that all commands begin with a "!"?', rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that you get banned for cheating?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that someone is behind you right now?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Nod Tiberium Refinery not under attack!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that tiberium can't hurt you with a !tibsuit.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that there are too many 'did you know' questions?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that reseti is also the anoying mole in Animal Crossing?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Look around, the enemy may be near.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: If you go under you will be owned by a moderator.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Look around, the enemy may be near.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: If you have alot of cash, stop thinking of yourself and donate some of your teammates", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: The Legend says: You are what you eat.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Be happy or prepare to die.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: People who use bad language in the Cloud Server get LYNCHED a few days later in real life.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Here rulez KAMUIXMOD.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: If you attack, then don't do it alone! Get a helping hand.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know the French government hates YOU? (jk)", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Restart approved (requested by DarkOrbit). Restarting in 5 seconds. (jk)", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know a ramjet headshot does 1,000 damage?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know a good tactic to kill strong characters is to drop vehicles on them?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: What is the most important thing in your life? Your Life?! Wrong! It is Cloud.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: God is great and strong but you have the chance to get stronger with !up1k. Use it, drink it!!!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: You should be jealous because Harry Potter can fly and you cannot.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: You're weak. What you need is Dr.Pepper. Drink it and you'll be like Kane.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: If Darkorbit joins everybody gets a blackscreen.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Want to create more fairness ingame? Try your chance to join our Mod Community and create happiness for everybody who plays Cloud.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: WARNING: CABAL inc, RUN!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that I am behind you, already typing !buggy?", rm)
end)

table.insert(rmsg, function(rm)
	if max_pID > 0 then
		pID = math.random(1, max_pID)
		while user[pID] == nil do
			pID = math.random(1, max_pID)
		end
		
		weaponlist = { "POW_Railgun_Player", "POW_PersonalIonCannon_Player", "POW_VoltAutoRifle_Player", "POW_RamjetRifle_Player" }
		
		Grant_Powerup(Get_GameObj(pID), weaponlist[math.random(1, table.maxn(weaponlist))])
		InputConsole("msg RM #%d: Congratulations, %s! You've won the hourly prize of the PWN-GUN!", rm, user[pID]:GetName())
	end
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that it costs 240k (240 !ups) to get a 2k orphan from scratch?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Put your pants back on!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Deal or no deal. This is the question.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Not everybody is something special but you can create your own future with your hands and credits.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: ~Darkorbit is Da Master, Rezpect Him At All Coztz~", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Go to the forums to add a message to these random messages!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Need help with Math? Ask Brcaspa. LOL.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Sonic has entered the game. Assume the position.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Pizza pizza pizza pie, it's so good you can't deny", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Cloud is actually an acronym for 'Cool Leet Ownage Uber Death'. Lol, wait, no it isn't.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Type 'www.cloud-zone.com' for a health upgrade!", rm)
	reward[2] = true
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Type 'Dark is cool! for 2,000 credits!", rm)
	reward[3] = true
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Type 'i love random messages!' for proxys!", rm)
	reward[4] = true
end)

--[[ Disabled, no reward. (Might crash the server)
table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Type 'iwannabeachicken' to turn into a chicken!", rm)
	reward[59] = true
end)--]]

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: maciozo likes everyone =D", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Bow down before me, for I am Host!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: I Like short-shorts!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: YYYYYAAAAAYYYYY! You're letting me be myself!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: May The Cloud be with you!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Go Team GDI!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Go Team Nod!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Everything is just one big.... cloud?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Those are my two buggaboos!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: I like my donuts sprinkled with pink frosting.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: While dropping a buggy on characters with a lot of hp is an easy way to kill them, it's also an easy way to make somebody hate you!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Fizzy1234 doesn't know much but what he does know, you better not challenge him!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Now you see me, now you're dead.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Get over it, slave gnome! The server won't power itself!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: I love the way you lie.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Live your life to the fullest. Then, when you die, respawn at Lumbridge.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Where's my pants? *looks at cani..*", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: To-do list.. 1. chores..  2. shopping.. 999. cloud.. 'hmm.. I can always do the chores later... >.>'", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know canisnip never wears underwear yet he has millions of them!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: SxDarkOne is officially an anime addict!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Kamuixmod likes Jadedrgn.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: B0b is too sexy for my shirt.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: This is a random message.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Why are you wasting your time reading this message when you could be playing a game?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: You must construct additional pylons!!!!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: KARMA CHARGER INCOMING!!! RUN!!!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: MutateMe is so awesome that you just can't deny!! (luv u muta) :p", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know you can refund a Mr.Money, Robber, Darkorbit and Aqollo simply by typing !refund me ?!?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Guns don't kill people, Robbers do!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: ERROR: ~Ran out of messages~", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: I'm here to kick ass and chew bubble gum, and I'm all out of kick ass.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: When stealing cash with a robber remember one thing, be careful of who you steal from, Darkorbit Will take revenge!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Do you know what's faster than an orphan?! SONIC! He runs faster than light, time and sound all put together! And he plays here in cloud!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Soon, all will become clear.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: The first person to type 'MY TEAM OWNS!' will grant 500 credits to each person on their team!", rm)
	reward[5] = true
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: This doesn't look good. Call a !doctor.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Yeah, Yeah, Yeah. Wouldyamind girl, if I told you, last night really blew my mind?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: No disrespect.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: You're so amazing, remember the time, just thinking about you, gives me butterflies.", rm)
end)

table.insert(rmsg, 100, function(rm)
	InputConsole("msg RM #%d: HUURAY!!! RANDOM MESSAGE 100!!! EVERYONE GAINS 1,000 CREDITS!", rm)
	for tID, v in pairs(user) do
		Set_Money(tID, Get_Money(tID)+1000)
	end
	InputConsole("cmsg 61,89,171 EVERYONE has recieved 1,000 from the Random Message Gods!!!!")
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Reach your hand in the sky, to see when you will die.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Ever tried catching a sludge and put some salt on it? (Don't do it :P)", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Sorry man, I madez you a cookie, but I eated it =(", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Ever tried putting names together? SoniCabal, DarkorbiToeinfection, Oh sorry, my bad.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: !vote yes..Oh, what's the poll?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Visceroid mutation! Help! no! Kill him. Grunt grunt grunt grunt ^^ grunt huffhuff grunt grunt.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: GDI Tiberium Refinery not under attack!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Ninjas can't catch you if you go stealth!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: To get the new maps on this server, go to cloud-zone.com and view the thread called new maps under announcements. Then follow the link under the post.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Ah man we ran out of random messages..", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: The ice cream man sells ice cream", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Be careful with the Obby Gun, as you can kill yourself with it if you fire it too close to yourself.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that the bird is the word?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know that I'm mad 'cause 90%% of all random messages start with DID YOU KNOW!!!!!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Caspa is a mixture of fun and madness.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Lelouch Vi Britannia commands you to donate all of your cash to Darkorbit!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Imagination is the creation of fear.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: This is one messed up looking cloud.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Mods are like Teletubbies, we watch you on our screen!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Let this message be dedicated to WhitneyH. We will not forget you. R.I.P.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: You can run, but not forever!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: By the time you have finished reading this, you will have realized you just wasted 10 seconds of your life.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Did you know Random_Fire_Guy likes doing random stupid things for no apparent reason?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: For cake, please assume the party-escort submission position, or yell 'I WANT MY CAKE!'", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Foxy is a care bear.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: If a kid refuses to sleep during nap time, are they guilty of resisting a rest?", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: A bus station is where a bus stops. A train station is where a train stops. On my desk, I have a work station.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: I was standing in the park wondering why frisbees got bigger as they get closer. Then it hit me.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: The last thing I want to do is hurt you. But it's still on the list.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Light travels faster than sound. This is why some people appear bright until you hear them speak.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Mutiny!!!!!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: The last guy who tried to buy an !ss with scripts got DENIED!!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Hey, don't forget about some of the older commands. Look around !commands and other menus.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Remember, try and be friendly in this server. Even if someone isn't friendly to you.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Here at Cloud C&C, we take pride in being a tight community! We encourage you to join it!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Stop texting and play!!!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: BRB, gotta run to the bathroom.", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Why is 'Z' the last letter of the alphabet? Because it overslept!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: The names....RANGO!", rm)
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: RANDOM MESSAGE MANIA! ALL RANDOM MESSAGE COMMANDS/PRIZES CAN BE USED!!!!", rm)
	for k, v in pairs(reward) do
		reward[k] = true
	end
end)

table.insert(rmsg, function(rm)
	InputConsole("msg RM #%d: Do you ever feel lonely? Not anymore! Just type 'I have no friends :(' and see what happens!", rm)
	reward[6] = true
end)
