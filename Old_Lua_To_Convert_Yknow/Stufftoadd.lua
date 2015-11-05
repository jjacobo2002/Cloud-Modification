--turret + guard tower commands Written by RoShambo
--Remove credits and you will die!
--Enjoy The Wonderful World Of Lua (from darkorbit)
--These codes are current as of August 2nd, 2010 and were made by DarkOrbit 
--trying to convert to sq.lite system
--I give credit to mvrtech,Dean,Dozer,Jadedrgn,TechnoBulldog,SxDarkOne and Cotsuma for helping me with many things, also jnz i love you


-- regen regens commands
--PREIST
	if Message == "!doctor" then
		if Get_Money(pID) > 4000 then 
			InputConsole("cmsg 0,250,0 %s has bought a doctor.", sName)
			Set_Money(pID, Get_Money(pID)-4000) 
			Change_Character(Get_GameObj(pID),"GDI_Female_Lieutenant") 
                        Set_Max_Health(Get_GameObj(pID), 400)
			Attach_Script(Get_GameObj(pID), "healscript", "")
                        Grant_Powerup(Get_GameObj(pID), "POW_LaserRifle_Player")
                        Grant_Powerup(Get_GameObj(pID), "POW_LaserChaingun_Player")
			InputConsole("snda m00ffire_003in_gcf1_snd.wav")
		else 
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end
			InputConsole("ppage %d You need 4000 credits for a doctor", pID)
		end
	end
	if Message == "!priest" then
		if user[pID]['access'] >= 1 then
			if user[pID]['vip'] == 1 then
				if Get_Money(pID) > 9500 then 
					InputConsole("cmsg 0,250,0 %s has bought a Priest! New Powerup every minute!", sName)
					Set_Money(pID, Get_Money(pID)-9500) 
					Change_Character(Get_GameObj(pID),"Priest")
					Attach_Script(Get_GameObj(pID), "healscript", "")
					Attach_Script_Once(Get_GameObj(pID), "grantwep", "") 
					InputConsole("snda m00gcim_stoa0001i1gcim_snd.wav")
				else 
					if Get_Team(pID) == 1 then
						InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
					else
						InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
					end
					InputConsole("ppage %d You need 9500 credits for a priest", pID)
				end
			else
				InputConsole("ppage %d Sign up for the premium package to use this command! !packagehelp", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command, because your not logged in.", pID)
		end
	end
grantwep = {}
function grantwep:Created(ID, obj)   
	Start_Timer(ID,obj,60, 0)
end

function grantwep:Timer_Expired(ID, obj, num)
	coor = Get_Position(obj)
	turret = Create_Object("tw_POW01_LaserChaingun", coor)
	InputConsole("ppage %d You have been granted a random powerup!",Get_Player_ID(obj))
	Attach_Script(obj, "grantwep", "")
end
Register_Script("grantwep", "", grantwep)
  
healscript = {}
function healscript:Created(ID, obj)   
	Start_Timer(ID,obj,5, 0)
end

function healscript:Timer_Expired(ID, obj, num)


	for _,Players in pairs(Get_All_Players()) do
		local distance = Get_Distance(obj, Get_GameObj(Players))
		if distance < 12 then -- less then 40 meters
			if Get_Team(Players) == Get_Team(Get_Player_ID(obj)) then
				Set_Health(Get_GameObj(Players), Get_Health(Get_GameObj(Players))+10)
				Set_Shield_Strength(Get_GameObj(Players), Get_Shield_Strength(Get_GameObj(Players))+10)
			end
		end
	end	
--	coor = Get_Position(obj)
--	turret = Create_Object("tw_POW01_LaserChaingun", coor)
--	InputConsole("ppage %d You have been granted a random powerup!",Get_Player_ID(obj))
	Attach_Script(obj, "healscript", "")
end
Register_Script("healscript", "", healscript)


Object = 0
function Load()

end

function Unload()

end

function OnError(Error)
	InputConsole("msg Darkorbit apoligizes for these spam error messages, we hope they will give us info on crashes. Thank you.")
	InputConsole("msg Error: %s", Error)
end
virus1 = {}

function virus1:Killed(ID, obj, killer)
	Attach_Script(killer, "virus2", "")
	InputConsole("ppage %d You have infected %s with a virus! They will constantly lose health and armor for the next five minutes, or until they die!",Get_Player_ID(obj),Get_Player_Name(killer))
	InputConsole("ppage %d You have been infected by a virus! You will constantly lose health and armor for the next five minutes, or until you die!",Get_Player_ID(killer))
end

Register_Script("virus1", "", virus1)

virus2 = {}

function virus2:Created(ID, obj)
	local fivemin = 60*5   
	Start_Timer(ID, obj, fivemin, 0)
	Attach_Script(obj, "JFW_Health_Regen", "1,1,-5")
	Attach_Script(obj, "JFW_Armor_Regen", "1,1,-5")
	Attach_Script(obj, "virus3", "")
end

function virus2:Timer_Expired(ID, obj, num)
	Remove_Script(obj, "JFW_Health_Regen")
	Remove_Script(obj, "JFW_Armor_Regen")
	InputConsole("ppage %d Your virus has been removed from your system, you will no longer lose health or armor.",Get_Player_ID(obj))
end

Register_Script("virus2", "", virus2)

virus3 = {}

function virus3:Created(ID, obj)
	local five = 5   
	Start_Timer(ID, obj, five, 0)
	if Get_Health(obj) == 0 then
		Apply_Damage(obj, 9999, "blamokiller", 0)
	end	
end

function virus3:Timer_Expired(ID, obj, num)
	Attach_Script(obj, "virus3", "")
end

Register_Script("virus3", "", virus3)

	if Message == "!virussuit" or Message == "!vs" then
		if Get_Money(pID) > 4500 then
			InputConsole("msg %s has bought a virus suit! Kill him, and be sick for 5 minutes, or until you die!" ,sName)
			Set_Money(pID, Get_Money(pID)-4500)
			Attach_Script(Get_GameObj(pID), "virus1", "")
			InputConsole("ppage %d Your max Health/Armor has been halved, but whoever kills you will lose health and armor for the next 5 minutes!",pID)
			Set_Max_Health(Get_GameObj(pID), Get_Max_Health(Get_GameObj(pID))/2)
			Set_Max_Shield_Strength(Get_GameObj(pID), Get_Max_Shield_Strength(Get_GameObj(pID))/2)
		else
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end	
			InputConsole("ppage %d You need 4500 credits to buy a virus suit!", pID)
		end
	end
-- SCRIPTS

youdie2 = {}
function youdie2:Created(ID, obj)   
	Start_Timer(ID, obj,5, 0)
end
function youdie2:Destroyed(ID, obj)

end

function youdie2:Killed(ID, obj, killer)

end

function youdie2:Damaged(ID, obj, shooter, damage)

end

function youdie2:Custom(ID, obj, message, param, sender)

end

function youdie2:Enemy_Seen(ID, obj, seen)

end

function youdie2:Action_Complete(ID, obj, action)

end

function youdie2:Animation_Complete(ID, obj, anim)

end

function youdie2:Poked(ID, obj, poker)

end

function youdie2:Entered(ID, obj, enter)

end

function youdie2:Exited(ID, obj, exiter)

end
function youdie2:Timer_Expired(ID, obj, num)
	if Get_Health(obj) == 0 then
		Apply_Damage(obj, 10, "blamokiller", 0)
	end
	Attach_Script(obj,"youdie", "")
end

Register_Script("youdie2", "", youdie2)
youdie = {}
function youdie:Created(ID, obj)   
	Start_Timer(ID, obj,5, 0)
end
function youdie:Destroyed(ID, obj)

end

function youdie:Killed(ID, obj, killer)

end

function youdie:Damaged(ID, obj, shooter, damage)

end

function youdie:Custom(ID, obj, message, param, sender)

end

function youdie:Enemy_Seen(ID, obj, seen)

end

function youdie:Action_Complete(ID, obj, action)

end

function youdie:Animation_Complete(ID, obj, anim)

end

function youdie:Poked(ID, obj, poker)

end

function youdie:Entered(ID, obj, enter)

end

function youdie:Exited(ID, obj, exiter)

end
function youdie:Timer_Expired(ID, obj, num)
	Attach_Script(obj,"youdie2", "")
end

Register_Script("youdie", "", youdie)
nodcurse = {}
function nodcurse:Created(ID, obj)   
	Start_Timer(ID, obj,600, 0)
end
function nodcurse:Destroyed(ID, obj)

end

function nodcurse:Killed(ID, obj, killer)

end

function nodcurse:Damaged(ID, obj, shooter, damage)

end

function nodcurse:Custom(ID, obj, message, param, sender)

end

function nodcurse:Enemy_Seen(ID, obj, seen)

end

function nodcurse:Action_Complete(ID, obj, action)

end

function nodcurse:Animation_Complete(ID, obj, anim)

end

function nodcurse:Poked(ID, obj, poker)

end

function nodcurse:Entered(ID, obj, enter)

end

function nodcurse:Exited(ID, obj, exiter)

end
function nodcurse:Timer_Expired(ID, obj, num)
	nodcurseh = 1
	InputConsole("msg Nod's curse has worn off!")
end

Register_Script("nodcurse", "", nodcurse)

gdicurse = {}
function gdicurse:Created(ID, obj)   
	Start_Timer(ID, obj,600, 0)
end
function gdicurse:Destroyed(ID, obj)

end

function gdicurse:Killed(ID, obj, killer)

end

function gdicurse:Damaged(ID, obj, shooter, damage)

end

function gdicurse:Custom(ID, obj, message, param, sender)

end

function gdicurse:Enemy_Seen(ID, obj, seen)

end

function gdicurse:Action_Complete(ID, obj, action)

end

function gdicurse:Animation_Complete(ID, obj, anim)

end

function gdicurse:Poked(ID, obj, poker)

end

function gdicurse:Entered(ID, obj, enter)

end

function gdicurse:Exited(ID, obj, exiter)

end
function gdicurse:Timer_Expired(ID, obj, num)
	gdicurseh = 1
	InputConsole("msg GDI's curse has worn off!")
end

Register_Script("gdicurse", "", gdicurse)

nodbless = {}
function nodbless:Created(ID, obj)   
	Start_Timer(ID, obj,600, 0)
end
function nodbless:Destroyed(ID, obj)

end

function nodbless:Killed(ID, obj, killer)

end

function nodbless:Damaged(ID, obj, shooter, damage)

end

function nodbless:Custom(ID, obj, message, param, sender)

end

function nodbless:Enemy_Seen(ID, obj, seen)

end

function nodbless:Action_Complete(ID, obj, action)

end

function nodbless:Animation_Complete(ID, obj, anim)

end

function nodbless:Poked(ID, obj, poker)

end

function nodbless:Entered(ID, obj, enter)

end

function nodbless:Exited(ID, obj, exiter)

end
function nodbless:Timer_Expired(ID, obj, num)
	nodblessh = 1
	InputConsole("msg Nod's bless of a regen has worn off!")
end

Register_Script("nodbless", "", nodbless)
gdibless = {}
function gdibless:Created(ID, obj)   
	Start_Timer(ID, obj,600, 0)
end
function gdibless:Destroyed(ID, obj)

end

function gdibless:Killed(ID, obj, killer)

end

function gdibless:Damaged(ID, obj, shooter, damage)

end

function gdibless:Custom(ID, obj, message, param, sender)

end

function gdibless:Enemy_Seen(ID, obj, seen)

end

function gdibless:Action_Complete(ID, obj, action)

end

function gdibless:Animation_Complete(ID, obj, anim)

end

function gdibless:Poked(ID, obj, poker)

end

function gdibless:Entered(ID, obj, enter)

end

function gdibless:Exited(ID, obj, exiter)

end
function gdibless:Timer_Expired(ID, obj, num)
	gdiblessh = 1
	InputConsole("msg GDI's bless of a regen has worn off!")
end

Register_Script("gdibless", "", gdibless)

--HALLOWEEN

removehp = {}
function removehp:Created(ID, obj)   

end
function removehp:Destroyed(ID, obj)

end

function removehp:Killed(ID, obj, killer)
	WriteINI("absorb.ini", "HP", Get_Player_Name(obj),2)		
end

function removehp:Damaged(ID, obj, shooter, damage)

end

function removehp:Custom(ID, obj, message, param, sender)

end

function removehp:Enemy_Seen(ID, obj, seen)

end

function removehp:Action_Complete(ID, obj, action)

end

function removehp:Animation_Complete(ID, obj, anim)

end

function removehp:Poked(ID, obj, poker)

end

function removehp:Entered(ID, obj, enter)

end

function removehp:Exited(ID, obj, exiter)

end
function removehp:Timer_Expired(ID, obj, num)

end

Register_Script("removehp", "", removehp)
healthsteal = {}
function healthsteal:Created(ID, obj)   

end
function healthsteal:Destroyed(ID, obj)

end

function healthsteal:Killed(ID, obj, killer)


	local absre = ReadINI("absorb.ini", "HP", Get_Player_Name(killer))
	local absorb = absre or "0"
	local caniabs = tonumber(absorb)
	if caniabs == 1 then 
		if Get_Player_Name(killer) == Get_Player_Name(obj) then
			InputConsole("ppage %d You cannot get health from yourself",Get_Player_ID(killer))
		else
			local sthp = Get_Health(killer)
			local stap = Get_Shield_Strength(killer)
			local dehp = Get_Max_Health(obj) * .05
			local deap = Get_Max_Shield_Strength(obj) * .05
			Set_Max_Health(killer,Get_Max_Health(killer)+dehp)
			Set_Max_Shield_Strength(killer,Get_Max_Shield_Strength(killer)+deap)
			Set_Health(killer, sthp+20)
			Set_Shield_Strength(killer, stap+20)
			InputConsole("ppage %d Gained %d hp and %d ap from %s",Get_Player_ID(killer),dehp,deap,Get_Player_Name(obj))
		end
	end
 		
end

function healthsteal:Damaged(ID, obj, shooter, damage)

end

function healthsteal:Custom(ID, obj, message, param, sender)

end

function healthsteal:Enemy_Seen(ID, obj, seen)

end

function healthsteal:Action_Complete(ID, obj, action)

end

function healthsteal:Animation_Complete(ID, obj, anim)

end

function healthsteal:Poked(ID, obj, poker)

end

function healthsteal:Entered(ID, obj, enter)

end

function healthsteal:Exited(ID, obj, exiter)

end
function healthsteal:Timer_Expired(ID, obj, num)

end

Register_Script("healthsteal", "", healthsteal)




bankuse = {}
function bankuse:Created(ID, obj)   
	Start_Timer(ID, obj,300, 0)
end
function bankuse:Destroyed(ID, obj)

end

function bankuse:Killed(ID, obj, killer)

end

function bankuse:Damaged(ID, obj, shooter, damage)

end

function bankuse:Custom(ID, obj, message, param, sender)

end

function bankuse:Enemy_Seen(ID, obj, seen)

end

function bankuse:Action_Complete(ID, obj, action)

end

function bankuse:Animation_Complete(ID, obj, anim)

end

function bankuse:Poked(ID, obj, poker)

end

function bankuse:Entered(ID, obj, enter)

end

function bankuse:Exited(ID, obj, exiter)

end
function bankuse:Timer_Expired(ID, obj, num)
	canibank = 2
	InputConsole("msg The bank has opened! You may now use your bank!")
end

Register_Script("bankuse", "", bankuse)


multiscript = {}
function multiscript:Created(ID, obj)   

end
function multiscript:Destroyed(ID, obj)

end

function multiscript:Killed(ID, obj, killer)
	if multi == 2 then
		local pos = Get_Position(obj)
		pos.Z = pos.Z + 1
		pos.Y = pos.Y + 1
		local turret = Create_Object("Nod_Minigunner_0", pos)
		Attach_Script_Once(turret, "multiscript", "") 
		pos.Y = pos.Y + 2
		local turret = Create_Object("Nod_Minigunner_0", pos)
		Attach_Script_Once(turret, "multiscript", "") 
	end
end

function multiscript:Damaged(ID, obj, shooter, damage)

end

function multiscript:Custom(ID, obj, message, param, sender)

end

function multiscript:Enemy_Seen(ID, obj, seen)

end

function multiscript:Action_Complete(ID, obj, action)

end

function multiscript:Animation_Complete(ID, obj, anim)

end

function multiscript:Poked(ID, obj, poker)

end

function multiscript:Entered(ID, obj, enter)

end

function multiscript:Exited(ID, obj, exiter)

end
function multiscript:Timer_Expired(ID, obj, num)

end

Register_Script("multiscript", "", multiscript)


gmultiscript = {}
function gmultiscript:Created(ID, obj)   

end
function gmultiscript:Destroyed(ID, obj)

end

function gmultiscript:Killed(ID, obj, killer)
	if multi == 2 then
		local pos = Get_Position(obj)
		pos.Z = pos.Z + 1
		pos.Y = pos.Y + 1
		local turret = Create_Object("GDI_Minigunner_0", pos)
		Attach_Script_Once(turret, "gmultiscript", "") 
		pos.Y = pos.Y + 2
		local turret = Create_Object("GDI_Minigunner_0", pos)
		Attach_Script_Once(turret, "gmultiscript", "") 
	end
end

function gmultiscript:Damaged(ID, obj, shooter, damage)

end

function gmultiscript:Custom(ID, obj, message, param, sender)

end

function gmultiscript:Enemy_Seen(ID, obj, seen)

end

function gmultiscript:Action_Complete(ID, obj, action)

end

function gmultiscript:Animation_Complete(ID, obj, anim)

end

function gmultiscript:Poked(ID, obj, poker)

end

function gmultiscript:Entered(ID, obj, enter)

end

function gmultiscript:Exited(ID, obj, exiter)

end
function gmultiscript:Timer_Expired(ID, obj, num)

end

Register_Script("gmultiscript", "", gmultiscript)


-- LUA SCRIPTS zzz 











--hlist = Get_Player_Name_By_ID(pID) == "Jrod" or Get_Player_Name_By_ID(pID) == "FML" or Get_Player_Name_By_ID(pID) == "Sonic" or Get_Player_Name_By_ID(pID) == "Someone10" or Get_Player_Name_By_ID(pID) == "evilelmo" or Get_Player_Name_By_ID(pID) == "Cotsuma" or Get_Player_Name_By_ID(pID) == "Darkorbit" or Get_Player_Name_By_ID(pID) == "theretardedwhiteboy-DnS-" or Get_Player_Name_By_ID(pID) == "OSTKb0Bm3h" or Get_Player_Name_By_ID(pID) == "Pwn3r" or Get_Player_Name_By_ID(pID) == "Banddroid|s2" or Get_Player_Name_By_ID(pID) == "Say4Extibo" or Get_Player_Name_By_ID(pID) == "MagnumKof" or Get_Player_Name_By_ID(pID) == "FTwilldy" or Get_Player_Name_By_ID(pID) == "B0bslayer" or Get_Player_Name_By_ID(pID) == "canisnip"
--	if Message == "!halloween" then
--		InputConsole("cmsg 250,140,0 Happy Halloween! ")
--		InputConsole("cmsg 0,0,0 Happy Halloween! ")
--		InputConsole("msg Hey, %s, if you posted on cloud-zone.com in the halloween topic, you can access the following commands!",sName)
--		InputConsole("msg !halloween Perhaps you want to go trick or treating, or have a chat with a ghost. Enjoy!")
--		InputConsole("msg Would you like to be 'zombified?'")
--	end
--	if Message == "!costumes" then
--		InputConsole("ppage %d All costumes must be typed by !costume <name> The following are available skins: bookshelf,desk", pID)
--		InputConsole("ppage %d Costume: desk,gascan,buoy,tibtree,toilet,urinal,vending,bunkbeds,couch,couch2,couch3", pID)
--	end
--	if Message == "zombified" or Message == "zombie" then
--		if hlist or donator then
--			if Get_Model(Get_GameObj(pID)) == "DSP_BEAKER" or Get_Model(Get_GameObj(pID)) == "DSP_DESK" or Get_Model(Get_GameObj(pID)) == "DSP_BOOKSHELF" or Get_Model(Get_GameObj(pID)) ==  "DSP_BUNKBEDS" or Get_Model(Get_GameObj(pID)) ==  "DSP_COUCH" or Get_Model(Get_GameObj(pID)) ==  "DSP_COUCH3" or Get_Model(Get_GameObj(pID)) ==  "DSP_COUCH4" or Get_Model(Get_GameObj(pID)) ==  "DSP_CRYOBIG" or Get_Model(Get_GameObj(pID)) ==  "DSP_FIRESIGN" or Get_Model(Get_GameObj(pID)) ==  "DSP_GASCAN" or Get_Model(Get_GameObj(pID)) ==  "DSP_SEABUOY" or Get_Model(Get_GameObj(pID)) ==  "DSP_TIBTREE2" or Get_Model(Get_GameObj(pID)) ==  "DSP_TOILET" or Get_Model(Get_GameObj(pID)) ==  "DSP_TVMONITOR" or Get_Model(Get_GameObj(pID)) ==  "DSP_URINAL" or Get_Model(Get_GameObj(pID)) ==  "DSP_VENDING" then
--
--				donothing = dodonothing
--			else
--				InputConsole("cmsg 250,140,0 Happy Halloween!")
--				InputConsole("cmsg 0,0,0 Happy Halloween! ")
--				InputConsole("msg You are a zombie!")
--				Attach_Script_Once(Get_GameObj(pID), "zombie", "")
--			end
--		end
--	end		
--	if FirstW == "!costume" then
--		if hlist or donator then
--			if Get_Max_Health(Get_GameObj(pID)) < 500 then
--				InputConsole("cmsg 250,140,0 %s has a costume! Happy Halloween! ", sName)
--				InputConsole("cmsg 0,0,0 %s has a costume! Happy Halloween! ", sName)
--				if SecondW == "beaker" then
--					Set_Model(Get_GameObj(pID), "dsp_beaker")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "bookshelf" then
--					Set_Model(Get_GameObj(pID), "dsp_bookshelf")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "bunkbeds" then
--					Set_Model(Get_GameObj(pID), "dsp_bunkbeds")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "couch" then
--					Set_Model(Get_GameObj(pID), "dsp_couch")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "couch2" then
--					Set_Model(Get_GameObj(pID), "dsp_couch3")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "couch3" then
--					Set_Model(Get_GameObj(pID), "dsp_couch4")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "desk" then
--					Set_Model(Get_GameObj(pID), "dsp_desk")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "firesign" then
--					Set_Model(Get_GameObj(pID), "dsp_firesign")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "gascan" then
--					Set_Model(Get_GameObj(pID), "dsp_gascan")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "buoy" then
--					Set_Model(Get_GameObj(pID), "dsp_seabuoy")
---					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "tibtree" then
--					Set_Model(Get_GameObj(pID), "dsp_tibtree2")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "toilet" then
--					Set_Model(Get_GameObj(pID), "dsp_toilet")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "urinal" then
--					Set_Model(Get_GameObj(pID), "dsp_urinal")
--					InputConsole("ppage %d You changed your model.", pID)
--				elseif  SecondW == "vending" then
--					Set_Model(Get_GameObj(pID), "dsp_vending")
--					InputConsole("ppage %d You changed your model.", pID)
--				else
--					InputConsole("ppage %d Skin not found.", pID)
--				end
--			else
--				InputConsole("ppage %d Your character must have less then 500 health to use this command.", pID)
--			end
--		else
--			InputConsole("ppage %d You can't do this, you didn't post on the halloween topic on the forums!", pID)
--		end
--	end	
--	if Message == "ghost" then
--		if hlist or donator then
--			InputConsole("cmsg 250,140,0 %s has a ghostregen! Happy Halloween! ", sName)
--			InputConsole("cmsg 0,0,0 %s has a ghostregen! Happy Halloween! ", sName)
--			InputConsole("msg Wwoooooooooooooooooo!!!! You have recieved a regen to help keep you immortal!!")
--			Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "2,2,5")
--			Attach_Script_Once(Get_GameObj(pID), "JFW_Armour_Regen", "2,2,5")
--		else
--			InputConsole("ppage %d You can't do this, you didn't post on the halloween topic on the forums!", pID)
--		end
--	end	
--	if Message == "trick or treat" or Message == "tot" then
--		hrandom = math.random(1,2)
--		if hrandom == 1 then
--			huahp = Get_Health(Get_GameObj(pID))
--			InputConsole("cmsg 250,140,0 Happy Halloween! ")
--			InputConsole("cmsg 0,0,0 Happy Halloween! ")
--			InputConsole("msg %s has recieved a treat! +5 Max hp!",sName)
--			huhp = Get_Max_Health(Get_GameObj(pID))				
--			Set_Max_Health(Get_GameObj(pID), huhp+5)
--			Set_Health(Get_GameObj(pID), huahp+5)			
--		else
--			huahp = Get_Health(Get_GameObj(pID))
--			InputConsole("cmsg 250,140,0 Happy Halloween! ")
--			InputConsole("cmsg 0,0,0 Happy Halloween! ")
--			InputConsole("msg %s has recieved a trick! -5 Max hp!",sName)
--			huhp = Get_Max_Health(Get_GameObj(pID))				
--			Set_Max_Health(Get_GameObj(pID), huhp-5)
--			Set_Health(Get_GameObj(pID), huahp-5)
--		end
--	end
--	
-- HALLOWEEN ^^^^^^^^^^^^^^^^^^^^^^^^^
-- HALLOWEEN ^^^^^^^^^^^^^^^^^^^^^^^^^			

	if Message == "!psychictower" or Message == "!pt" then
		if Get_Team(pID) == 1 then
			if Get_Money(pID) < 3500 then
				InputConsole("ppage %d You need 3500 credits", pID)
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				local pos = Get_Position(Get_GameObj(pID))
				local Facing = Get_Facing(Get_GameObj(pID))
				local Distance = 0 --the distance, of how far to create the object from the player.
				pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
				pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
				turret = Create_Object("GDI_Guard_Tower", pos)
				Attach_Script(turret, "z_Set_Team", Get_Team(pID))
				Set_Model(turret, "dsp_cryobig")
				Set_Max_Health(turret, 500)				
				pos.X = pos.X + 1
				pos.Z = pos.Z + 3.5
				weapon1 = Create_Object("CNC_GDI_Gun_Emplacement", pos)
				Set_Model(weapon1, "w_gdi_tlgn")
				Attach_Script(weapon1, "z_Set_Team", Get_Team(pID))
				Attach_Script(turret, "JFW_Death_Destroy_Object", weapon1)
				Attach_Script_Once(weapon1, "JFW_Health_Regen", "0.0005,0.0005,2000")
				Attach_Script_Once(weapon1, "JFW_Armour_Regen", "0.0005,0.0005,2000")
				Set_Max_Health(weapon1, 1999)
				Set_Max_Shield_Strength(weapon1, 2000)
				pos.X = pos.X - 2
				weapon2 = Create_Object("CNC_GDI_Gun_Emplacement", pos)
				Set_Model(weapon2, "w_gdi_tlgn")
				Attach_Script(weapon2, "z_Set_Team", Get_Team(pID))
				Attach_Script(turret, "JFW_Death_Destroy_Object", weapon2)
				Attach_Script_Once(weapon2, "JFW_Health_Regen", "0.0005,0.0005,2000")
				Attach_Script_Once(weapon2, "JFW_Armour_Regen", "0.0005,0.0005,2000")
				Set_Max_Health(weapon2, 1999)
				Set_Max_Shield_Strength(weapon2, 2000)
				pos.X = pos.X + 1
				vshack = Create_Object("Simple_Sydney_SandM_Machine", pos)
				Attach_Script(turret, "JFW_Death_Destroy_Object", vshack)
				Set_Model(vshack, "dsp_cryobig")
				if turret == nil then
					InputConsole("ppage %d Error creating turret", pID)
				else
					InputConsole("msg %s has bought a psychic tower!", sName)
					InputConsole("cmsg 28,145,103 The Tower is your master...")
					Disable_Physical_Collisions(turret)
					Set_Money(pID, Get_Money(pID)-3500)
				end
			end
		elseif Get_Team(pID) == 0 then
			if Get_Money(pID) < 3500 then
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
				InputConsole("ppage %d You need 3500 credits", pID)
			else
				local pos = Get_Position(Get_GameObj(pID))
				local Facing = Get_Facing(Get_GameObj(pID))
				local Distance = 0 --the distance, of how far to create the object from the player.
				pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
				pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
				turret = Create_Object("GDI_Guard_Tower", pos)
				Attach_Script(turret, "z_Set_Team", Get_Team(pID))
				Set_Model(turret, "dsp_cryobig")
				Set_Max_Health(turret, 500)				
				pos.X = pos.X + 1
				pos.Z = pos.Z + 3.5
				weapon1 = Create_Object("CNC_GDI_Gun_Emplacement", pos)
				Set_Model(weapon1, "w_gdi_tlgn")
				Attach_Script(weapon1, "z_Set_Team", Get_Team(pID))
				Attach_Script(turret, "JFW_Death_Destroy_Object", weapon1)
				Attach_Script_Once(weapon1, "JFW_Health_Regen", "0.0005,0.0005,2000")
				Attach_Script_Once(weapon1, "JFW_Armour_Regen", "0.0005,0.0005,2000")
				Set_Max_Health(weapon1, 2000)
				Set_Max_Shield_Strength(weapon1, 2000)
				pos.X = pos.X - 2
				weapon2 = Create_Object("CNC_GDI_Gun_Emplacement", pos)
				Set_Model(weapon2, "w_gdi_tlgn")
				Attach_Script(weapon2, "z_Set_Team", Get_Team(pID))
				Attach_Script(turret, "JFW_Death_Destroy_Object", weapon2)
				Attach_Script_Once(weapon2, "JFW_Health_Regen", "0.0005,0.0005,2000")
				Attach_Script_Once(weapon2, "JFW_Armour_Regen", "0.0005,0.0005,2000")
				Set_Max_Health(weapon2, 2000)
				Set_Max_Shield_Strength(weapon2, 2000)
				pos.X = pos.X + 1
				vshack = Create_Object("Simple_Sydney_SandM_Machine", pos)
				Attach_Script(turret, "JFW_Death_Destroy_Object", vshack)
				Set_Model(vshack, "dsp_cryobig")
				if turret == nil then
					InputConsole("ppage %d Error creating turret", pID)
				else
					InputConsole("msg %s has bought a psychic tower!", sName)
					InputConsole("cmsg 28,145,103 The Tower is your master...")
					Disable_Physical_Collisions(turret)
					Set_Money(pID, Get_Money(pID)-3500)
				end
			end
		end
	end
	if Message == "!clonemachine" then
		if Get_Money(pID) < 25000 then	
			InputConsole("ppage %d You need 25000 credits", pID)
		else	
			if Get_Team(pID) == 0 then
				if ncaniclone == 0 then
					local pos = Get_Position(Get_GameObj(pID))
					local Facing = Get_Facing(Get_GameObj(pID))
					local Distance = 0 --the distance, of how far to create the object from the player.
					pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
					pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
					pos.Z = pos.Z + 0.5
					base = Create_Object("M01_GDI_Gunboat", pos)
					Disable_Physical_Collisions(base)
					Set_Model(base, "dsp_lockers")
					Attach_Script_Once(base, "clonemachine", "")
					Attach_Script(base, "z_Set_Team", Get_Team(pID))
					Set_Money(pID, Get_Money(pID)-25000)
					InputConsole("cmsg 0,250,0 %s has bought a clonemachine", sName)
					InputConsole("cmsg 150,30,0 Nod will spawn clones 15 seconds after they purchase a character!", sName)
					ncaniclone = 1
				else
					InputConsole("ppage %d Your team already has a clone machine", pID)
				end
			elseif Get_Team(pID) == 1 then
				if gcaniclone == 0 then
					local pos = Get_Position(Get_GameObj(pID))
					local Facing = Get_Facing(Get_GameObj(pID))
					local Distance = 0 --the distance, of how far to create the object from the player.
					pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
					pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
					pos.Z = pos.Z + 0.5
					base = Create_Object("M01_GDI_Gunboat", pos)
					Disable_Physical_Collisions(base)
					Attach_Script(base, "z_Set_Team", Get_Team(pID))
					Attach_Script_Once(base, "gdiclone", "")
					Set_Model(base, "dsp_lockers")
					Set_Money(pID, Get_Money(pID)-25000)
					InputConsole("cmsg 0,250,0 %s has bought a clonemachine", sName)
					InputConsole("cmsg 150,30,0 GDI will spawn clones 15 seconds after they purchase a character!", sName)
					gcaniclone = 1
				else
					InputConsole("ppage %d Your team already has a clone machine", pID)
				end
			end
		end
	end
-- PREMIUM
-- PREMIUM
	if Message == "!bless" then        
		if Get_Money(pID) > 40000 then
			if Get_Team(pID) == 1 then
				if gdiblessh == 2 then
					InputConsole("ppage %d Your team already has been blessed with a regen.", pID)
				else               
					gdiblessh = 2
					Set_Money(pID, Get_Money(pID)-40000)
					InputConsole("snda healer1.wav", pID)
					InputConsole("cmsg 0,250,0 %s has blessed GDI with a regen for ten minutes!", sName)
					local invispos = { X = 10 , Y = 10, Z = 10}
					invisobj = Create_Object("invisible_object", invispos)
					if invisobj ~= nil then
						Attach_Script_Once(invisobj, "gdibless", "")
					end
				end	
			elseif Get_Team(pID) == 0 then
				if nodblessh == 2 then
					InputConsole("ppage %d Your team already has been blessed with a regen.", pID)
				else  
					nodblessh = 2
					Set_Money(pID, Get_Money(pID)-40000)
					InputConsole("snda healer1.wav", pID)
					InputConsole("cmsg 0,250,0 %s has blessed Nod with a regen for ten minutes!", sName)
					local invispos = { X = 10 , Y = 10, Z = 10}
					invisobj = Create_Object("invisible_object", invispos)
					if invisobj ~= nil then
						Attach_Script_Once(invisobj, "nodbless", "")
					end
				end
			end  
		else
			InputConsole("ppage %d You need 40000 credits.", pID)
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end
		end
	end    
	if Message == "!curse" then        
		if Get_Money(pID) > 50000 then
			if Get_Team(pID) == 1 then
				if gdicurseh == 2 then
					InputConsole("ppage %d The other team has already been cursed once.", pID)
				else               
					gdicurseh = 2
					Set_Money(pID, Get_Money(pID)-50000)
					InputConsole("snda m00avis_kiov0002i1moac_snd.wav", pID)
					InputConsole("cmsg 0,250,0 %s has cursed Nod for ten minutes!", sName)
					local invispos = { X = 10 , Y = 10, Z = 10}
					invisobj = Create_Object("invisible_object", invispos)
					if invisobj ~= nil then
						Attach_Script_Once(invisobj, "gdicurse", "")
					end
				end	
			elseif Get_Team(pID) == 0 then
				if nodcurseh == 2 then
					InputConsole("ppage %d The other team has already been cursed once.", pID)
				else  
					nodcurseh = 2
					Set_Money(pID, Get_Money(pID)-50000)
					InputConsole("snda m00avis_kiov0002i1moac_snd.wav", pID)
					InputConsole("cmsg 0,250,0 %s has cursed GDI for ten minutes!", sName)
					local invispos = { X = 10 , Y = 10, Z = 10}
					invisobj = Create_Object("invisible_object", invispos)
					if invisobj ~= nil then
						Attach_Script_Once(invisobj, "nodcurse", "")
					end
				end
			end  
		else
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end
			InputConsole("ppage %d You need 50000 credits.", pID)
		end
	end          

	if Message == "!kickumom" then
		if Get_Money(pID) > 10000 then 
			InputConsole("cmsg 0,250,0 %s has bought a kickumom! Watch out for explosions!", sName)
			Set_Money(pID, Get_Money(pID)-10000) 
			Change_Character(Get_GameObj(pID),"Cook") 
			Set_Max_Health(Get_GameObj(pID), 550)
			Attach_Script_Once(Get_GameObj(pID), "JFW_Blow_Up_On_Death", "Explosion_IonCannonBeacon")	
		else 
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end		
			InputConsole("ppage %d You need 10000 credits for a kickumom", pID)
		end
	end  


--CINEMATICS
--CINEMATICS
--CINEMATICS
--CINEMATICS
--CINEMATICS
	if Message == "!backup" then
		if Get_Money(pID) > 4000 then
			if Get_Team(pID) == 0 then
				InputConsole("msg %s has bought 4 backup soldiers!", sName)
				obj = Create_Object("invisible_object", Get_Position(Get_GameObj(pID)))
				Set_Money(pID, Get_Money(pID)-4000)
				if obj ~= nil then
   					Attach_Script_Once(obj, "Test_Cinematic", "NOD8trooperparadrop.txt")
					InputConsole("snda m00tfea_010in_nctk_snd.wav")
				end	
			elseif Get_Team(pID) == 1 then
				InputConsole("msg %s has bought 4 backup soldiers!", sName)
				obj = Create_Object("invisible_object", Get_Position(Get_GameObj(pID)))
				Set_Money(pID, Get_Money(pID)-4000)
				if obj ~= nil then
   					Attach_Script_Once(obj, "Test_Cinematic", "GDI8trooperparadrop.txt")
					InputConsole("snda m00tfea_010in_nctk_snd.wav")
			else
				InputConsole("ppage %d Your not on a team!", pID)
				end	
			end
		else
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end				
			InputConsole("ppage %d You need 4000 credits for a soldier backup", pID)
		end
	end
	if Message == "!voltbackup" then
		if Get_Money(pID) > 6000 then
			if Get_Team(pID) == 0 then
				InputConsole("msg %s has bought 4 backup soldiers!", sName)
				obj = Create_Object("invisible_object", Get_Position(Get_GameObj(pID)))
				Set_Money(pID, Get_Money(pID)-6000)
				if obj ~= nil then
   					Attach_Script_Once(obj, "Test_Cinematic", "backupmendoza8.txt")
					InputConsole("snda m00tfea_010in_nctk_snd.wav")
				end	
			elseif Get_Team(pID) == 1 then
				InputConsole("msg %s has bought 4 backup soldiers!", sName)
				obj = Create_Object("invisible_object", Get_Position(Get_GameObj(pID)))
				Set_Money(pID, Get_Money(pID)-6000)
				if obj ~= nil then
   					Attach_Script_Once(obj, "Test_Cinematic", "backupmobius8.txt")
					InputConsole("snda m00tfea_010in_nctk_snd.wav")
			else
				InputConsole("ppage %d Your not on a team!", pID)
				end	
			end
		else
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end				
			InputConsole("ppage %d You need 6000 credits for a soldier backup", pID)
		end
	end
--if Message == "!superrecon" then
--if Get_Money(pID) > 600 then
--InputConsole("msg %s has bought a super recon! Use 1,2,3,4,5,6,7,8,9 to switch weapons!", sName)
--InputConsole("ppage %d If your recon dies, try buying it in a location with no defences.", pID)
--obj = Create_Object("invisible_object", Get_Position(Get_GameObj(pID)))
--Set_Money(pID, Get_Money(pID)-600)
--if obj ~= nil then
-- Attach_Script_Once(obj, "Test_Cinematic", "reconNod_Paradropwithrecon.txt")
--end		
--else
--InputConsole("ppage %d You need 600 credits for a recon", pID)
--end
--end
--if Message == "!laserapache" then
--if Get_Money(pID) > 2000 then
--if Get_Team(pID) == 0 then
--InputConsole("msg %s has bought a laser apache!", sName)
--InputConsole("ppage %d Push '7' to change to laserchaingun", pID)
--obj = Create_Object("invisible_object", Get_Position(Get_GameObj(pID)))
--Set_Money(pID, Get_Money(pID)-2000)
--if obj ~= nil then
--Attach_Script_Once(obj, "Test_Cinematic", "laserapache.txt")
--end		
--else
--InputConsole("ppage %d You need to be on NOD", pID)
--end
--else
--InputConsole("ppage %d You need 2000 credits for a laserapache", pID)
--end
--end
--if Message == "!laserorca" then
--if Get_Money(pID) > 2000 then
--if Get_Team(pID) == 1 then
--InputConsole("msg %s has bought a laser orca!", sName)
--InputConsole("ppage %d Push '7' to change to laserchaingun", pID)
--obj = Create_Object("invisible_object", Get_Position(Get_GameObj(pID)))
--Set_Money(pID, Get_Money(pID)-2000)
--if obj ~= nil then
-- Attach_Script_Once(obj, "Test_Cinematic", "laserorca.txt")
--end
--else
--InputConsole("ppage %d You need to be on GDI", pID)
--end	
--else
--InputConsole("ppage %d You need 2000 credits for a laserorca", pID)
--end
--end
--CINEMATICS
--CINEMATICS
--CINEMATICS
--CINEMATICS
--CINEMATICS

	if Message == "!darkisgod" then
		if sName == "Darkorbit" then
			Set_The_Game({MVPName="Darkorbit", MVPCount=10000})
		end
	end
	if Message == "!uni" or Message == "!unib0ngr" then
		if Get_Money(pID) > 6000 then 
			InputConsole("cmsg 0,250,0 %s has bought unib0ngr!", sName)
			Set_Money(pID, Get_Money(pID)-6000) 
			Change_Character(Get_GameObj(pID),"civ_lab_tech_02") 
			Set_Max_Health(Get_GameObj(pID), 700) 
			Grant_Powerup(Get_GameObj(pID), "CnC_MineProximity_05")
			Grant_Powerup(Get_GameObj(pID), "POW_VoltAutoRifle_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_AutoRifle_Player") 
			Grant_Powerup(Get_GameObj(pID), "POW_RamjetRifle_Player")
			Grant_Powerup(Get_GameObj(pID), "POW_TiberiumFlechetteGun_Player") 
		else 
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end				
			InputConsole("ppage %d You need 6000 credits for unib0ngr", pID)
		end
	end
	if Message == "!headhunter" then
		InputConsole("ppage %d Fixing up head hunter, character is unavailable right now",pID)
	end		

	if Message == "!demotrap" or Message == "!dt" then				
		InputConsole("ppage %d Sorry, testing. Before this was added server lasted 3+ hours b4 a crash.", pID)
	end
	if Message == "!miragetank" then
		InputConsole("ppage %d Command Removed.", pID)
	end

	if Message == "!bab" then
		price = 2500
		if Get_Money(pID) < price then
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end				
			InputConsole("ppage %d Babushka Costs %d Credits.", pID, price)
		else
			Change_Character(Get_GameObj(pID),"Civ_Resist_Babushka")
			Grant_Powerup(Get_GameObj(pID), "POW_LaserChaingun_Player")
			Grant_Powerup(Get_GameObj(pID), "CnC_POW_MineRemote_02")
			Grant_Powerup(Get_GameObj(pID), "POW_RepairGun_Player")
			Set_Max_Health(Get_GameObj(pID), 300)
			Set_Max_Shield_Strength(Get_GameObj(pID), 200)
			Set_Money(pID, Get_Money(pID)-price)
			Grant_Powerup(Get_GameObj(pID), "CnC_POW_Ammo_ClipMax")
			InputConsole("msg %s has bought a Babushka", sName)
			InputConsole("sndp %d correction_3.wav", pID)
		end
	end
	if Message == "!bombbeacon" or Message == "!bb" then
		if Get_Money(pID) < 6000 then
			InputConsole("ppage %d You need 6000 credits", pID)
			InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
		else

			local pos = Get_Position(Get_GameObj(pID))
			local Facing = Get_Facing(Get_GameObj(pID))
			local Distance = 0 --the distance, of how far to create the object from the player.
			pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
			pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
			turret = Create_Object("Marker Flag", pos)
			Attach_Script_Once(turret, "artybeacon", "")
			Set_Skin(turret, "blamo")
			if turret == nil then
				InputConsole("ppage %d Error creating tower", pID)
			else
				InputConsole("cmsg 0,250,0 %s has bought a bombardment!! Can damage buildings!", sName)
				Disable_Physical_Collisions(turret)
				Set_Money(pID, Get_Money(pID)-6000)
			end
		end
	end
	if Message == "!ravbot" then 
		if Get_Money(pID) < 3000 then
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end				
			InputConsole("ppage %d You need 3000 credits", pID)
		else
			local pos = Get_Position(Get_GameObj(pID))
			local Facing = Get_Facing(Get_GameObj(pID))
			local Distance = 0 --the distance, of how far to create the object from the player.
			pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
			pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
			pos.Z = pos.Z + 1
			pos.Y = pos.Y + 1
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))	
			if turret == nil then
				InputConsole("ppage %d Error creating bot", pID)
			else
				InputConsole("cmsg 0,250,250 %s has bought obby gun bots! OMG NO!", sName)
				Set_Money(pID, Get_Money(pID)-3000)					
			end
		end		
	end
	if Message == "!up1k" then
		if Get_Preset_Name(Get_GameObj(pID)) == "Nod_Kane" or Get_Preset_Name(Get_GameObj(pID)) == "CnC_GDI_RocketSoldier_2SF_Secret" or Get_Preset_Name(Get_GameObj(pID)) == "CnC_GDI_MiniGunner_2SF" or Get_Preset_Name(Get_GameObj(pID)) == "Nun" or Get_Preset_Name(Get_GameObj(pID)) == "GDI_Prisoner_v0a" or Get_Preset_Name(Get_GameObj(pID)) == "CnC_Nod_FlameThrower_2SF" then
			InputConsole("ppage %d You cannot buy !up1k with this character, it would be too powerful.", pID)
		else
			if Get_Money(pID) < 35000 then
				if Get_Team(pID) == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
				end				
				InputConsole("ppage %d You need 35000 credits to buy !up1k", pID)
			else
				uhp = Get_Health(Get_GameObj(pID))
				uap = Get_Shield_Strength(Get_GameObj(pID))
				if Get_Preset_Name(Get_GameObj(pID)) == "Civ_Resist_Female_v0d" or Get_Preset_Name(Get_GameObj(pID)) == "Farmer" or Get_Preset_Name(Get_GameObj(pID)) == "Civ_Resist_Babushka" or Get_Preset_Name(Get_GameObj(pID)) == "civ_lab_tech_03" or Get_Preset_Name(Get_GameObj(pID)) == "civ_lab_tech_01" or Get_Preset_Name(Get_GameObj(pID)) == "Civ_Male_v5a" or Get_Preset_Name(Get_GameObj(pID)) == "Mutant_0_GDI" then
					Set_Max_Health(Get_GameObj(pID),Get_Max_Health(Get_GameObj(pID))+1000)
					InputConsole("msg %s has +1000 hp and +1000 armor", sName)
					Set_Health(Get_GameObj(pID), uhp+35)		
					Set_Money(pID, Get_Money(pID)-35000)
				else
					Set_Max_Health(Get_GameObj(pID),Get_Max_Health(Get_GameObj(pID))+1000)
					Set_Max_Shield_Strength(Get_GameObj(pID),Get_Max_Shield_Strength(Get_GameObj(pID))+1000)
					InputConsole("msg %s has +1000 hp and +1000 armor", sName)
					Set_Health(Get_GameObj(pID), uhp+35)
					Set_Shield_Strength(Get_GameObj(pID), uap+35)		
					Set_Money(pID, Get_Money(pID)-35000)
				end
			end
		end
	end
	if Message == "!plane" then
		if Get_Money(pID) < 900000 then
			InputConsole("ppage %d You need 900000 credits to buy a plane", pID)
		else
			local pos = Get_Position(Get_GameObj(pID))
			X = 7*math.cos(Get_Facing(Get_GameObj(pID))*(math.pi / 180))
			Y = 7*math.sin(Get_Facing(Get_GameObj(pID))*(math.pi / 180))
			local pos2 = {X = pos.X + X, Y = pos.Y + Y, Z = pos.Z + 3}
			turret = Create_Object("CnC_GDI_Orca", pos2)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			Set_Model(turret, "v_nod_cplane")
			if turret == nil then
				InputConsole("ppage %d Error creating buggy", pID)
			else 
				Set_Money(pID, Get_Money(pID)-900000)
			end
		end
	end
	if Message == "!holybuckets" then
		if Get_Money(pID) < 90000 then
			if Get_Team(pID) == 1 then
				InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
			else
				InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
			end				
			InputConsole("ppage %d You need 90000 credits", pID)
		else
			local pos = Get_Position(Get_GameObj(pID))
			local Facing = Get_Facing(Get_GameObj(pID))
			local Distance = 0 --the distance, of how far to create the object from the player.
			pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
			pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
			pos.Z = pos.Z + 1
			pos.Y = pos.Y - 3
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			pos.Z = pos.Z + 1
			pos.Y = pos.Y + 1
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			pos.Z = pos.Z + 1
			pos.X = pos.X - 2
			pos.Y = pos.Y + 1
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			pos.Z = pos.Z + 1
			pos.X = pos.X - 1
			pos.Y = pos.Y + 1
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			pos.X = pos.X - 2
			pos.Y = pos.Y - 1
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			pos.Y = pos.Y - 2
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			pos.Z = pos.Z + 1
			pos.X = pos.X + 3
			pos.Y = pos.Y - 2
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			pos.Z = pos.Z + 1
			pos.X = pos.X - 3
			pos.Y = pos.Y + 2
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			pos.Z = pos.Z + 1
			pos.X = pos.X + 2
			pos.Y = pos.Y + 3
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			pos.Z = pos.Z + 1
			pos.X = pos.X - 4
			pos.Y = pos.Y - 2
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			pos.X = pos.X - 3
			pos.Y = pos.Y + 4
			turret = Create_Object("Mutant_3Boss_Raveshaw", pos)
			Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
			if turret == nil then
				InputConsole("ppage %d Error creating turret", pID)
			else
				InputConsole("cmsg 0,250,250 %s has bought bots!", sName)
				Set_Money(pID, Get_Money(pID)-90000)
			end
		end
	end
      -- player info made by SxDarkOne, using the table you can get form the function cPlayer(PlayerID)
        -- Needs the FindWords function from PsuFan or something similar.
        -- This currently needs the exact player name, as I don't feel like making a Find Name function and
        -- I couldn't find the Find Player function.
        
        -- Spots the player has hit. This doesn't count the shots made while in a vehicle.



        if FirstW == "!shots" then
                if SecondW ~= "" then
			Player = FindPlayerName("FullName", SecondW) -- Finds Full Name
			if Player == "None" then -- User entered string that didnt match a player
				InputConsole("page %s %s is does not appear to be ingame.", Get_Player_Name_By_ID(pID), SecondW)
			elseif Player == "Many" then -- Not Unique
				InputConsole("page %s %s is not unique.", Get_Player_Name_By_ID(pID), SecondW)
			else -- Found Player Successfully
				ID = FindPlayerName("FindID", Player)
                        	tobj = Get_GameObj_By_Player_Name(Player)
                        	tid = Get_Player_ID(tobj)
                        	tinf = {}
                        	tinf = cPlayer(tid)
                        	InputConsole("msg %s has fired a total of %d bullets this game. %d of those shots where Head Shots.", Player, tinf['ShotsFired'], tinf['HeadShots'])
                        	InputConsole("msg Other hits: %d Torso shots, %d Arm shots, %d Crotch shots and %d Leg Shots.", tinf['TorsoShots'], tinf['ArmShots'], tinf['CrotchShots'], tinf['LegShots'])
			end
                elseif SecondW == "" then
                        tinf = {}
                        tinf = cPlayer(pID)
                        InputConsole("msg %s has fired a total of %d bullets this game. %d of those shots where Head Shots.", sName, tinf['ShotsFired'], tinf['HeadShots'])
                        InputConsole("msg Other hits: %d Torso shots, %d Arm shots, %d Crotch shots and %d Leg Shots.", tinf['TorsoShots'], tinf['ArmShots'], tinf['CrotchShots'], tinf['LegShots'])
                end
        end
        
        -- Spots the player got hit.This doesn't count the shots taken while in a vehicle.
        if FirstW == "!hits" then
                if SecondW == "" then
                        tinf = {}
                        tinf = cPlayer(pID)
                        InputConsole("msg %s got hit %d times in the head, %d times in the torso, %d times in the arms, %d times in the crotch and %d times in the legs.", sName, tinf['HeadHit'], tinf['TorsoHit'], tinf['ArmHit'], tinf['CrotchHit'], tinf['LegHit'])
                else
			Player = FindPlayerName("FullName", SecondW) -- Finds Full Name
			if Player == "None" then -- User entered string that didnt match a player
				InputConsole("page %s %s is does not appear to be ingame.", Get_Player_Name_By_ID(pID), SecondW)
			elseif Player == "Many" then -- Not Unique
				InputConsole("page %s %s is not unique.", Get_Player_Name_By_ID(pID), SecondW)
			else -- Found Player Successfully
                        	tobj = Get_GameObj_By_Player_Name(Player)
                        	tid = Get_Player_ID(tobj)
                        	tinf = {}
                        	tinf = cPlayer(tid)
                        	InputConsole("msg %s got hit %d times in the head, %d times in the torso, %d times in the arms, %d times in the crotch and %d times in the legs.", Player, tinf['HeadHit'], tinf['TorsoHit'], tinf['ArmHit'], tinf['CrotchHit'], tinf['LegHit'])
			end
                end
        end
        
        -- Fps of the player.
        if FirstW == "!fps" then
                if SecondW == "" then
                        tinf = {}
                        tinf = cPlayer(pID)
                        InputConsole("msg %s his/her fps is: %d", sName, tinf['Fps'])
                else
			Player = FindPlayerName("FullName", SecondW) -- Finds Full Name
			if Player == "None" then -- User entered string that didnt match a player
				InputConsole("page %s %s is does not appear to be ingame.", Get_Player_Name_By_ID(pID), SecondW)
			elseif Player == "Many" then -- Not Unique
				InputConsole("page %s %s is not unique.", Get_Player_Name_By_ID(pID), SecondW)
			else -- Found Player Successfully
                        	tobj = Get_GameObj_By_Player_Name(Player)
                        	tid = Get_Player_ID(tobj)
                        	tinf = {}
                        	tinf = cPlayer(tid)
                        	InputConsole("msg %s his/her fps is: %d", Player, tinf['Fps'])
			end
                end
        end
        
      
        -- Powerups the player has collected (Crates, Weapons, Grant_Powerup, etc)
        if FirstW == "!powerups" then
                if SecondW == "" then
                        tinf = {}
                        tinf = cPlayer(pID)
                        InputConsole("msg %s has collected %d powerups this game.", sName, tinf['PowerupsCollected'])
                else
			Player = FindPlayerName("FullName", SecondW) -- Finds Full Name
			if Player == "None" then -- User entered string that didnt match a player
				InputConsole("page %s %s is does not appear to be ingame.", Get_Player_Name_By_ID(pID), SecondW)
			elseif Player == "Many" then -- Not Unique
				InputConsole("page %s %s is not unique.", Get_Player_Name_By_ID(pID), SecondW)
			else -- Found Player Successfully
                        	tobj = Get_GameObj_By_Player_Name(Player)
                        	tid = Get_Player_ID(tobj)
                        	tinf = {}
                        	tinf = cPlayer(tid)
                        	InputConsole("msg %s has collected %d powerups this game.", Player, tinf['PowerupsCollected'])
			end
                end
        end
        
        -- How many times the player has squished an enemy.
        if FirstW == "!squishes" then
                if SecondW == "" then
                        tinf = {}
                        tinf = cPlayer(pID)
                        InputConsole("msg %s has squished %d enemies this game.", sName, tinf['Squishes'])
                else
			Player = FindPlayerName("FullName", SecondW) -- Finds Full Name
			if Player == "None" then -- User entered string that didnt match a player
				InputConsole("page %s %s is does not appear to be ingame.", Get_Player_Name_By_ID(pID), SecondW)
			elseif Player == "Many" then -- Not Unique
				InputConsole("page %s %s is not unique.", Get_Player_Name_By_ID(pID), SecondW)
			else -- Found Player Successfully
                        	tobj = Get_GameObj_By_Player_Name(Player)
                        	tid = Get_Player_ID(tobj)
                        	tinf = {}
                        	tinf = cPlayer(tid)
                        	InputConsole("msg %s has squished %d enemies this game.", Player, tinf['Squishes'])
			end
                end
        end
-----------------
	if Message == "!building upgrade" or Message == "!upb" then	
		local PlayerId = pID --your player
		local PlayerObj = Get_GameObj(PlayerId)
		local pos1 = Get_Position(PlayerObj)
		for _,Building in pairs(Get_All_Buildings()) do
			local distance = Get_Distance(Get_GameObj(pID), Building)
			if distance < 10 then -- less then 40 meters
				if Get_Object_Type(Building) == Get_Team(pID) then 
					if Get_Money(pID) > 3000 then
						local bzhp = Get_Health(Building)
						local bzap = Get_Shield_Strength(Building)
						Set_Max_Health(Building, Get_Max_Health(Building)+25)
						local bhp = Get_Max_Health(Building)
						local bap = Get_Max_Shield_Strength(Building)
						Set_Health(Building, bzhp)
						Set_Money(pID, Get_Money(pID)-3000)
          					Console_Input(string.format("msg %s has upgraded the %s, which now has a max hp of %d and a max armor of %d", Get_Player_Name(PlayerObj),Get_Preset_Name(Building), bhp, bap))
					else		
						if Get_Team(pID) == 1 then
							InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
						else
							InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
						end						
						InputConsole("ppage %d You need 3000 credits to buy a building upgrade", pID)
					end
				else
					InputConsole("ppage %d The building you are trying to upgrade is not on your team.",pID)
    			 	end
			end
		end
	end
	if FirstW == "!bhp" then
		if Get_Money(pID) > 500 then
			if SecondW == "airstrip" or SecondW == "air strip" or SecondW == "as" then
				--Find_Airstrip?
				local hpbuild = Find_Airstrip(pID)
				local hp = Get_Health(hpbuild)
				local ap = Get_Shield_Strength(hpbuild)
				InputConsole("msg The %s is at %d health and %d armor. ", Get_Preset_Name(hpbuild),hp,ap)
				Set_Money(pID, Get_Money(pID)-500)
			elseif SecondW == "warfactory" or SecondW == "wf" or SecondW == "war factory" then
				--Find_Airstrip?
				local hpbuild = Find_War_Factory(pID)
				local hp = Get_Health(hpbuild)
				local ap = Get_Shield_Strength(hpbuild)
				InputConsole("msg The %s is at %d health and %d armor. ", Get_Preset_Name(hpbuild),hp,ap)
				Set_Money(pID, Get_Money(pID)-500)
			elseif SecondW == "bar racks" or SecondW == "bar" or SecondW == "barracks" then
				--Find_Airstrip?
				local hpbuild = Find_Soldier_Factory(1)
				local hp = Get_Health(hpbuild)
				local ap = Get_Shield_Strength(hpbuild)
				InputConsole("msg The %s is at %d health and %d armor. ", Get_Preset_Name(hpbuild),hp,ap)
				Set_Money(pID, Get_Money(pID)-500)
			elseif SecondW == "handofnod" or SecondW == "hon" or SecondW == "hand of nod" then
				--Find_Airstrip?
				local hpbuild = Find_Soldier_Factory(0)
				local hp = Get_Health(hpbuild)
				local ap = Get_Shield_Strength(hpbuild)
				InputConsole("msg The %s is at %d health and %d armor. ", Get_Preset_Name(hpbuild),hp,ap)
				Set_Money(pID, Get_Money(pID)-500)
			elseif SecondW == "nod ref" or SecondW == "nref" or SecondW == "nod refinery" then
				--Find_Airstrip?
				local hpbuild = Find_Refinery(0)
				local hp = Get_Health(hpbuild)
				local ap = Get_Shield_Strength(hpbuild)
				InputConsole("msg The %s is at %d health and %d armor. ", Get_Preset_Name(hpbuild),hp,ap)
				Set_Money(pID, Get_Money(pID)-500)
			elseif SecondW == "gdi ref" or SecondW == "gref" or SecondW == "gdi refinery" then
				--Find_Airstrip?
				local hpbuild = Find_Refinery(1)
				local hp = Get_Health(hpbuild)
				local ap = Get_Shield_Strength(hpbuild)
				InputConsole("msg The %s is at %d health and %d armor. ", Get_Preset_Name(hpbuild),hp,ap)
				Set_Money(pID, Get_Money(pID)-500)
			elseif SecondW == "nodpowerplant" or SecondW == "npp" or SecondW == "nod powerplant" then
				--Find_Airstrip?
				local hpbuild = Find_Power_Plant(0)
				local hp = Get_Health(hpbuild)
				local ap = Get_Shield_Strength(hpbuild)
				InputConsole("msg The %s is at %d health and %d armor. ", Get_Preset_Name(hpbuild),hp,ap)
				Set_Money(pID, Get_Money(pID)-500)
			elseif SecondW == "gdipowerplant" or SecondW == "gpp" or SecondW == "gdi powerplant" then
				--Find_Airstrip?
				local hpbuild = Find_Power_Plant(1)
				local hp = Get_Health(hpbuild)
				local ap = Get_Shield_Strength(hpbuild)
				InputConsole("msg The %s is at %d health and %d armor. ", Get_Preset_Name(hpbuild),hp,ap)
				Set_Money(pID, Get_Money(pID)-500)
			elseif SecondW == "obelisk" or SecondW == "obby" or SecondW == "ob" then
				--Find_Airstrip?
				local hpbuild = Find_Base_Defense(0)
				local hp = Get_Health(hpbuild)
				local ap = Get_Shield_Strength(hpbuild)
				InputConsole("msg The %s is at %d health and %d armor. ", Get_Preset_Name(hpbuild),hp,ap)
				Set_Money(pID, Get_Money(pID)-500)
			elseif SecondW == "advanced guard tower" or SecondW == "AGT" or SecondW == "agt" then
				--Find_Airstrip?
				local hpbuild = Find_Base_Defense(1)
				local hp = Get_Health(hpbuild)
				local ap = Get_Shield_Strength(hpbuild)
				InputConsole("msg The %s is at %d health and %d armor. ", Get_Preset_Name(hpbuild),hp,ap)
				Set_Money(pID, Get_Money(pID)-500)
			else
				InputConsole("ppage %d Avaliable buildings: bar,hon,as,wf,agt,obby,gpp,npp,nref,gref",pID)
			end
		else
			InputConsole("ppage %d You need 500 credits to check a buildings health and armor. Press 'K' if your too cheap!",pID)	
		end	
	end
	if Message == "!war" then
		if sName == "Darkorbit" then
			if Get_Money(pID) < 10 then
				InputConsole("ppage %d You need 11 credits", pID)
			else
				local pos = Get_Position(Get_GameObj(pID))
				local Facing = Get_Facing(Get_GameObj(pID))
				local Distance = 0 --the distance, of how far to create the object from the player.
				pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
				pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
				pos.Z = pos.Z + 1
				pos.Y = pos.Y - 3
				turret = Create_Object("GDI_Minigunner_0", pos)
				pos.Z = pos.Z + 1
				pos.Y = pos.Y + 1
				turret = Create_Object("GDI_Minigunner_1Off", pos)
				pos.Z = pos.Z + 1
				pos.X = pos.X - 2
				pos.Y = pos.Y + 1
				turret = Create_Object("GDI_Minigunner_0", pos)
				pos.X = pos.X - 1
				pos.Y = pos.Y + 1
				turret = Create_Object("GDI_Minigunner_0", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y - 1
				turret = Create_Object("GDI_RocketSoldier_0", pos)
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
				pos.Y = pos.Y + 1
				turret = Create_Object("Nod_Minigunner_0", pos)
				pos.X = pos.X - 2
				pos.Y = pos.Y - 1
				turret = Create_Object("Nod_Minigunner_1Off", pos)
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
				turret = Create_Object("Nod_RocketSoldier_0", pos)
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
				if turret == nil then
					InputConsole("ppage %d Error creating turret", pID)
				else
					InputConsole("cmsg 0,250,250 %s has demanded that there shall be a war at %s's location!", sName)
					Set_Money(pID, Get_Money(pID)-10)
				end
			end
		else
			InputConsole("ppage %d You need to be God.", pID)
		end
	end
	if Message == "!nmultibot" then 
		if sName == "Darkorbit" then
			local pos = Get_Position(Get_GameObj(pID))
			local Facing = Get_Facing(Get_GameObj(pID))
			local Distance = 0 --the distance, of how far to create the object from the player.
			pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
			pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
			pos.Z = pos.Z + 1
			pos.Y = pos.Y + 1
			turret = Create_Object("Nod_Minigunner_0", pos)	
			Attach_Script_Once(turret, "multiscript", "") 
			multi = 2
			if turret == nil then
				InputConsole("ppage %d Error creating bot", pID)
			else
				InputConsole("cmsg 0,250,250 %s has bought a Nod Multibot!! Prepare for devastation!", sName)					
			end
		end		
	end
	if Message == "!gmultibot" then 
		if sName == "Darkorbit" then
			local pos = Get_Position(Get_GameObj(pID))
			local Facing = Get_Facing(Get_GameObj(pID))
			local Distance = 0 --the distance, of how far to create the object from the player.
			pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
			pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
			pos.Z = pos.Z + 1
			pos.Y = pos.Y + 1
			turret = Create_Object("GDI_Minigunner_0", pos)
			Attach_Script_Once(turret, "gmultiscript", "") 	
			multi = 2
			if turret == nil then
				InputConsole("ppage %d Error creating bot", pID)
			else
				InputConsole("cmsg 0,250,250 %s has bought a GDI Multibot!! Prepare for devastation!", sName)					
			end
		end		
	end
	if Message == "!nomulti" then 
		if sName == "Darkorbit" then
			multi = 1
			InputConsole("ppage %d multi turned off", pID)
		end		
	end
--This is where the first word functions start
--This is where the first word functions start
--This is where the first word functions start
--This is where the first word functions start
--This is where the first word functions start
	if FirstW == "!cmsg" then
		if SecondW == "green" then
			Message = ThirdPlus
			InputConsole("cmsg 0,250,0 %s: " .. Message .. "", sName, ThirdPlus)
		elseif SecondW == "cyan" then
			Message = ThirdPlus
			InputConsole("cmsg 0,250,250 %s: " .. Message .. "", sName, ThirdPlus)
		elseif SecondW == "yellow" then 
			Message = ThirdPlus
			InputConsole("cmsg 250,250,0 %s: " .. Message .. "", sName, ThirdPlus)
		elseif SecondW == "purple" then
			Message = ThirdPlus
			InputConsole("cmsg 250,0,250 %s: " .. Message .. "", sName, ThirdPlus)
		elseif SecondW == "blue" then
			Message = ThirdPlus
			InputConsole("cmsg 0,0,250 %s: " .. Message .. "", sName, ThirdPlus)
		elseif SecondW == "red" then
			Message = ThirdPlus
			InputConsole("cmsg 250,0,0 %s: " .. Message .. "", sName, ThirdPlus)
		elseif SecondW == "orange" then
			Message = ThirdPlus
			InputConsole("cmsg 250,140,0 %s: " .. Message .. "", sName, ThirdPlus)
		elseif SecondW == "random" then
			color1 = math.random(0,250)
			color2 = math.random(0,250)
			color3 = math.random(0,250)
			Message = ThirdPlus
			InputConsole("cmsg %d,%d,%d %s: " .. Message .. "",color1,color2,color3, sName, ThirdPlus)
		end
	end
--mod commands
	if FirstW == "!postnote" then
		if SecondW ~= "" then
			InputConsole("ppage %d Any previous note you have written has been erased.", pID)
			InputConsole("msg %s has written a note to Darkorbit! I will check it when i get time!", sName)
			WriteINI("notes.ini", "Notes", Get_Player_Name_By_ID(pID), SecondPlus)
		end
	end
	if FirstW == "!connection" or FirstW == "!ping" then
		Player = FindPlayerName("FullName", SecondW) -- Finds Full Name
		if Player == "None" then -- User entered string that didnt match a player
			InputConsole("page %s %s is does not appear to be ingame.", Get_Player_Name_By_ID(pID), SecondW)
		elseif Player == "Many" then -- Not Unique
			InputConsole("page %s %s is not unique.", Get_Player_Name_By_ID(pID), SecondW)
		elseif Player == "".. sName .."" then 
			local PING = Get_Ping(pID)
			local PORT = Get_IP_Port(pID)
			local KBPS = Get_Kbits(pID)
			local BANDWIDTH = Get_Bandwidth(pID)
			InputConsole("cmsg 61,89,171 (%s's Connection Info) SPEED: %s Kb/s", sName, KBPS)
			InputConsole("cmsg 61,89,171 (%s's Connection Info) BANDWIDTH: %s", sName, BANDWIDTH)
			InputConsole("cmsg 61,89,171 (%s's Connection Info) PING: %s", sName, PING)
		else -- Found Player Successfully
			local ID = FindPlayerName("FindID", Player)
			local PING = Get_Ping(ID)
			local PORT = Get_IP_Port(ID)
			local KBPS = Get_Kbits(ID)
			local BANDWIDTH = Get_Bandwidth(ID)
			InputConsole("cmsg 61,89,171 (%s's Connection Info) SPEED: %s Kb/s", Player, KBPS)
			InputConsole("cmsg 61,89,171 (%s's Connection Info) BANDWIDTH: %s", Player, BANDWIDTH)
			InputConsole("cmsg 61,89,171 (%s's Connection Info) PING: %s", Player, PING)
		end
	end
--
--user


	
--VIP

	if Message == "!lightbot" then
		if user[pID]['access'] >= 1 then
			if user[pID]['vip'] == 1 then
				if Get_Team(pID) == 0 then
					if Get_Money(pID) < 3500 then
						if Get_Team(pID) == 1 then
							InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
						else
							InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
						end				
						InputConsole("ppage %d You need 3500 credits to buy a light tank", pID)
					else
						local pos = Get_Position(Get_GameObj(pID))
						X = 7*math.cos(Get_Facing(Get_GameObj(pID))*(math.pi / 180))
						Y = 7*math.sin(Get_Facing(Get_GameObj(pID))*(math.pi / 180))
						local pos2 = {X = pos.X + X, Y = pos.Y + Y, Z = pos.Z + 3}
						tankbot = Create_Object("CNC_Nod_Light_tank", pos2)
						Attach_Script(tankbot, "JFW_Base_Defence", "5,999,20")
						Attach_Script(tankbot, "M00_Disable_Transition", "")
						Attach_Script(tankbot, "z_Set_Team", Get_Team(pID))
						if tankbot == nil then
							InputConsole("ppage %d Error creating light tank", pID)
						else
							Set_Money(pID, Get_Money(pID)-3500)
						end
					end
				else
					InputConsole("ppage %d You need to be on Nod.", pID)
				end
			else 
				InputConsole("ppage %d Sign up for the premium package to use this command! !packagehelp", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command, because your not logged in.", pID)
		end
	end
	if Message == "!medbot" then
		if user[pID]['access'] >= 1 then
			if user[pID]['vip'] == 1 then
				if Get_Team(pID) == 1 then
					if Get_Money(pID) < 3500 then
						if Get_Team(pID) == 1 then
							InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav",pID)
						else
							InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav",pID)
						end						
						InputConsole("ppage %d You need 3500 credits to buy a light tank", pID)
					else
						local pos = Get_Position(Get_GameObj(pID))
						X = 7*math.cos(Get_Facing(Get_GameObj(pID))*(math.pi / 180))
						Y = 7*math.sin(Get_Facing(Get_GameObj(pID))*(math.pi / 180))
						local pos2 = {X = pos.X + X, Y = pos.Y + Y, Z = pos.Z + 3}
						tankbot = Create_Object("CNC_Nod_Light_tank", pos2)
						Set_Model(tankbot, "v_gdi_medtnk")
						Attach_Script(tankbot, "JFW_Base_Defence", "5,999,20")
						Attach_Script(tankbot, "M00_Disable_Transition", "")
						Attach_Script(tankbot, "z_Set_Team", Get_Team(pID))
						if tankbot == nil then
							InputConsole("ppage %d Error creating med tank", pID)
						else
							Set_Money(pID, Get_Money(pID)-3500)
						end
					end
				else
					InputConsole("ppage %d You need to be on GDI.", pID)
				end
			else 
				InputConsole("ppage %d Sign up for the premium package to use this command! !packagehelp", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command, because your not logged in.", pID)
		end
	end
	

--end
   return 1
end

function OnPlayerJoin(pID, Nick)
Players[pID].NickName = Nick

sName = Get_Player_Name_By_ID(pID)
--
--
--
--
	if Nick == "SxDarkOne" then
 		if Get_IP_Address(pID) == "193.141.49.49" then
 			InputConsole("msg This message confirms that %s is NOT a nickname spoofer!", sName)
 		else
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
			WriteINI("MutedPlayers.ini", "Muted", sName, 1)
 		end
	elseif Nick == "bearmach" then
 		if Get_IP_Address(pID) == "69.126.109.25" then
 			InputConsole("msg This message confirms that %s is NOT a nickname spoofer!", sName)
 		else
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
			WriteINI("MutedPlayers.ini", "Muted", sName, 1)
 		end
	elseif Nick == "Cotsuma" or Nick == "cotsuma" then
	 	if Get_IP_Address(pID) == "204.13.180.89" or Get_IP_Address(pID) == "24.121.58.177" then
 			--InputConsole("msg This message confirms that %s is NOT a nickname spoofer!", sName)
 		else
 			--InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
			WriteINI("MutedPlayers.ini", "Muted", sName, 1)
 		end
	elseif Nick == "canisnip" or Nick == "Canisnip" then
		if Get_IP_Address(pID) == "86.87.252.22" or Get_IP_Address(pID) == "213.84.205.103" then
 			InputConsole("msg This message confirms that %s is NOT a nickname spoofer!", sName)
 		else
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
 			InputConsole("msg %s is a nickname spoofer!!! (or on a different IP) They are muted!!!", sName)
			WriteINI("MutedPlayers.ini", "Muted", sName, 1)
 		end
 	end
	if Nick == "canisnip" then
		InputConsole("snda ambcheer1.wav")
	elseif Nick == "Banddroid|s2" then
		InputConsole("snda heli_chinook_dropen.wav")
	elseif Nick == "Jadedrgn" then
		local Random = math.random(1,2)
		if Random == 1 then
			InputConsole("snda m00gcc1_poco0001i1gcc1_snd.wav")
		elseif Random == 2 then
			InputConsole("snda m00gctk_pori0001i1gctk_snd.wav")	
		end	
	end		
end 

function OnPlayerLeave(pID)
	sName = Get_Player_Name_By_ID(pID)
	WriteINI("absorb.ini", "HP", sName,2)


--
end

function OnHostMessage(PlayerID, Type, Message)

end

function OnLevelLoaded()
	gcaniclone = 0
	ncaniclone = 0	
	gdiblessh = 0
	nodblessh = 0
	gdicurseh = 0
	nodcurseh = 0		
end

function OnGameOver()

end

function OnConsoleOutput(Message)

end

function OnObjectCreate(Object)
--
--
--
--
--
--

	if Get_Preset_Name(Object) == "GDI_Humm-vee_Player" then
		Set_Model(Object, "w_a-10bomb")
	end
	if gdiblessh == 2 then
        	if Is_A_Star(Object) then
            		if Get_Team(Get_Player_ID(Object)) == 1 then
                		Attach_Script(Object, "JFW_Health_Regen", "1.5,3,10")
	            		Attach_Script(Object, "JFW_Armour_Regen", "1.5,3,10")
	        	end
	    	end        
	end
	if nodblessh == 2 then
        	if Is_A_Star(Object) then
            		if Get_Team(Get_Player_ID(Object)) == 0 then
                		Attach_Script(Object, "JFW_Health_Regen", "1.5,3,10")
	            		Attach_Script(Object, "JFW_Armour_Regen", "1.5,3,10")
	        	end
	   	 end 
	end
	if gdicurseh == 2 then
        	if Is_A_Star(Object) then
            		if Get_Team(Get_Player_ID(Object)) == 0 then
                		Attach_Script(Object, "JFW_Health_Regen", "1.5,3,-7")
	            		Attach_Script(Object, "JFW_Armour_Regen", "1.5,3,-7")
	            		Attach_Script(Object, "youdie", "")
	        	end
	    	end        
	end
	if nodcurseh == 2 then
        	if Is_A_Star(Object) then
            		if Get_Team(Get_Player_ID(Object)) == 1 then
                		Attach_Script(Object, "JFW_Health_Regen", "1.5,3,-5")
	            		Attach_Script(Object, "JFW_Armour_Regen", "1.5,3,-5")
	            		Attach_Script(Object, "youdie", "")
	        	end
	   	 end 
	end
	if Is_A_Star(Object) then
		Attach_Script_Once(Object, "healthsteal", "")
		Attach_Script_Once(Object, "clone2", "")
	end
end



function OnCharacterPurchase(Purchaser, Cost, Preset, PurchaserRet) -- Preset is NOT a string. It's a preset ID. Use Get_Translated_String to get the preset name.
--PurchaserRet, 0 means they purchased it.
--Purchaser is a GameObject of the person who bought it.

end

function OnVehiclePurchase(Purchaser, Cost, Preset, PurchaserRet) 

end

function OnPowerupPurchase(Purchaser, Cost, Preset, PurchaserRet) 

end

function OnDDE(Message)

end

function OnThink()
   
end

function Serial_Hook(PlayerId, Serial)

end

function Loading_Hook(pID, Loading)
sName = Get_Player_Name_By_ID(pID)
	if pID ~= "" then
		WriteINI("absorb.ini", "HP", sName,2)
	end
end

function Damage_Hook(PlayerId, Damager, Target, Damage, Warhead)


   return 1
end

function Ping_Hook(PlayerId, Ping)

end

function Suicide_Hook(PlayerId)

end

function Radio_Hook(Team, PlayerId, a, RadioId, b)


   return 1
end



myscript = {}
function myscript:Created(ID, obj)   

end

function myscript:Destroyed(ID, obj)

end

function myscript:Killed(ID, obj, killer)

end

function myscript:Damaged(ID, obj, shooter, damage)

end

function myscript:Custom(ID, obj, message, param, sender)

end

function myscript:Enemy_Seen(ID, obj, seen)

end

function myscript:Action_Complete(ID, obj, action)

end

function myscript:Animation_Complete(ID, obj, anim)

end

function myscript:Poked(ID, obj, poker)

end

function myscript:Entered(ID, obj, enter)

end

function myscript:Exited(ID, obj, exiter)

end

function myscript:Timer_Expired(ID, obj, num)

end

--
--
--
--

clonemachine = {}

function clonemachine:Killed(ID, obj, killer)
	ncaniclone = 0
end

Register_Script("clonemachine", "", clonemachine)


gdiclone = {}


function gdiclone:Killed(ID, obj, killer)
	gcaniclone = 0
end

Register_Script("gdiclone", "", gdiclone)

clone2 = {}
function clone2:Created(ID, obj)   
	Start_Timer(ID,obj,16, 0)
end

function clone2:Timer_Expired(ID, obj, num)
	if Get_Team(Get_Player_ID(obj)) == 1 then
		if gcaniclone == 1 then
			local veh = Get_Vehicle(obj)
			if veh == 0 then
				local pos = Get_Position(obj)
				local preset = Get_Preset_Name(obj)
				pos.Z = pos.Z + 1
				pos.Y = pos.Y + 2   
				local turret = Create_Object(preset, pos)
				Attach_Script(turret, "M05_Nod_Gun_Emplacement", "")
				Attach_Script(turret, "z_Set_Team", Get_Team(Get_Player_ID(obj)))
				InputConsole("ppage %d Your team has a clone machine! A bot has spawned near you!",Get_Player_ID(obj))
			else
				InputConsole("ppage %d You cannot recieve a clone in a vehicle.",Get_Player_ID(obj))
			end
		end
	elseif Get_Team(Get_Player_ID(obj)) == 0 then
		if ncaniclone == 1 then
			local veh = Get_Vehicle(obj)
			if veh == 0 then
				local pos = Get_Position(obj)
				local preset = Get_Preset_Name(obj)
				pos.Z = pos.Z + 2
				pos.Y = pos.Y + 2   
				local turret = Create_Object(preset, pos)
				Attach_Script(turret, "M05_Nod_Gun_Emplacement", "")
				Attach_Script(turret, "z_Set_Team", Get_Team(Get_Player_ID(obj)))
				InputConsole("ppage %d Your team has a clone machine! A bot has spawned near you!",Get_Player_ID(obj))
			else
				InputConsole("ppage %d You cannot recieve a clone in a vehicle.",Get_Player_ID(obj))
			end
		end
	end		
end
Register_Script("clone2", "", clone2)




teslatower = {}
function teslatower:Created(ID, obj)   

end
function teslatower:Destroyed(ID, obj)

end

function teslatower:Killed(ID, obj, killer)
	if Is_A_Star(killer) then
		local pos = Get_Position(obj)
		boom = Create_Object("CnC_Nod_Buggy", pos)
		Attach_Script_Once(boom, "JFW_Blow_Up_On_Death", "Explosion_IonCannonBeacon")
		Apply_Damage(boom,9999, "blamokiller", 0)
	end
end

Register_Script("teslatower", "", teslatower) 



artybeacon = {}
function artybeacon:Created(ID, obj)   
	Start_Timer(ID,obj,3, 0)
	InputConsole("snda 00-n036e.wav")
end

function artybeacon:Timer_Expired(ID, obj, num)
	Attach_Script_Once(obj, "artybeaconz", "")
end
Register_Script("artybeacon", "", artybeacon)

artybeaconz = {}
function artybeaconz:Created(ID, obj)   
	Start_Timer(ID,obj,2, 0)
end

function artybeaconz:Timer_Expired(ID, obj, num)
	Attach_Script_Once(obj, "artybeacon2", "")
	invisi = Create_Object("invisible_object", Get_Position(obj))
	if invisi ~= nil then
   		Attach_Script_Once(invisi, "Test_Cinematic", "bombdrop.txt")
	end
	InputConsole("snda mxxdsgn_dsgn0006i1evag_snd.wav")
end
Register_Script("artybeaconz", "", artybeaconz)

artybeacon2 = {}
function artybeacon2:Created(ID, obj)   
	Start_Timer(ID,obj,1, 0)
end

function artybeacon2:Timer_Expired(ID, obj, num)
	Attach_Script_Once(obj, "artybeacon3", "")
	InputConsole("snda mxxdsgn_dsgn0005i1evag_snd.wav")
end
Register_Script("artybeacon2", "", artybeacon2)


artybeacon3 = {}
function artybeacon3:Created(ID, obj)   
	Start_Timer(ID,obj,1, 0)
end

function artybeacon3:Timer_Expired(ID, obj, num)
	InputConsole("snda mxxdsgn_dsgn0002i1evan_snd.wav")
	Attach_Script_Once(obj, "artybeacon4", "")
end
Register_Script("artybeacon3", "", artybeacon3)

artybeacon4 = {}
function artybeacon4:Created(ID, obj)   
	Start_Timer(ID,obj,1, 0)
end

function artybeacon4:Timer_Expired(ID, obj, num)
	InputConsole("snda mxxdsgn_dsgn0003i1evag_snd.wav")
	Attach_Script_Once(obj, "artybeacon5", "")
end
Register_Script("artybeacon4", "", artybeacon4)


artybeacon5 = {}
function artybeacon5:Created(ID, obj)   
	Start_Timer(ID,obj,1, 0)
end

function artybeacon5:Timer_Expired(ID, obj, num)


-- use the Get_distance to damage buildings and lookinto how the marker flag is positioned, could fix random thing

	InputConsole("snda mxxdsgn_dsgn0005i1evan_snd.wav")
	InputConsole("snda aircraft_bombs_fall3s.wav")
--        pos = Get_Position(obj)
--        object = Create_Object("M09_Rnd_Door", pos)
  --      Attach_Script_Once(object, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
    --    Apply_Damage(object, 9999, "blamokiller", 0)
	for _,Building in pairs(Get_All_Buildings()) do
		local distance = Get_Distance(obj, Building)
		if distance < 10 then -- less then 40 meters
			health = Get_Health(Building)
			onetwenty = health*.2
			Apply_Damage(Building, onetwenty, "sharpnel", 0) 
        		pos = Get_Position(Building)
       			object = Create_Object("M09_Rnd_Door", pos)
        		Attach_Script_Once(object, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
        		Apply_Damage(object, 9999, "blamokiller", 0)
			Console_Input(string.format("msg %s was damaged by the bomb beacon!",Get_Preset_Name(Building)))
		end
	end
			
	Attach_Script_Once(obj, "artybeacon6", "")

end
Register_Script("artybeacon5", "", artybeacon5)


artybeacon6 = {}
function artybeacon6:Created(ID, obj)   
	Start_Timer(ID,obj,1, 0)
end

function artybeacon6:Timer_Expired(ID, obj, num)
--        pos = Get_Position(obj)
  --      object = Create_Object("M09_Rnd_Door", pos)
    --    Attach_Script_Once(object, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
      --  Apply_Damage(object, 9999, "blamokiller", 0)
	Attach_Script_Once(obj, "artybeacon7", "")
end
Register_Script("artybeacon6", "", artybeacon6)



artybeacon7 = {}
function artybeacon7:Created(ID, obj)   
	Start_Timer(ID,obj,1, 0)
end

function artybeacon7:Timer_Expired(ID, obj, num)
--        pos = Get_Position(obj)
  --      object = Create_Object("M09_Rnd_Door", pos)
    --    Attach_Script_Once(object, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
      --  Apply_Damage(object, 9999, "blamokiller", 0)
	Attach_Script_Once(obj, "artybeacon8", "")
end
Register_Script("artybeacon7", "", artybeacon7)




artybeacon8 = {}
function artybeacon8:Created(ID, obj)   
	Start_Timer(ID,obj,1, 0)
end

function artybeacon8:Timer_Expired(ID, obj, num)
--        pos = Get_Position(obj)
  --      object = Create_Object("M09_Rnd_Door", pos)
    --    Attach_Script_Once(object, "JFW_Blow_Up_On_Death", "Explosion_Shell_Artillery")
      --  Apply_Damage(object, 9999, "blamokiller", 0)
        Apply_Damage(obj, 9999, "blamokiller", 0)
end

Register_Script("artybeacon8", "", artybeacon8)


--memorywrite = {}
--function memorywrite:Created(ID, obj)   
--	Start_Timer(ID, obj,300, 0)
--end
--function memorywrite:Timer_Expired(ID, obj, num)
--	clear = collectgarbage("collect")
--	local Memory = collectgarbage("count") 
--	local randomhaha = math.random(1,50000)
--	WriteINI("mem.ini", "newmem", randomhaha, tonumber(Memory))
--	Attach_Script(obj, "memorywrite", "")
--end
--
--Register_Script("memorywrite", "", memorywrite)


