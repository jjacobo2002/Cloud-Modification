-- CHRISTMAS
--xmas
	if Message == "!present" then
		if Players[pID].Present == "No" then
			Attach_Script_Once(Get_GameObj(pID), "present","")
			InputConsole("ppage %d You must wait 10 seconds before you can recieve another present.", pID)
			InputConsole("ppage %d Sometimes the presents get confused, and you may have to wait an additional 20 seconds! Be Patient!", pID)
		else
			Players[pID].Present = "No"
			random = math.random(0,7)
			if random == 0 then
				Attach_Script(Get_GameObj(pID), "present","")
				InputConsole("ppage %d You just gained 50 max health thanks to a present from santa!", pID)
				InputConsole("cmsg 255,0,0 Happy Holidays! Enjoy your +50 health!")
				InputConsole("cmsg 0,100,0 Happy Holidays! Enjoy your +50 health!")
				huhp = Get_Max_Health(Get_GameObj(pID))				
				Set_Max_Health(Get_GameObj(pID), huhp+50)
				Set_Health(Get_GameObj(pID), huahp+50)
			elseif random == 1 then
				Attach_Script(Get_GameObj(pID), "present","")
				local pos = Get_Position(Get_GameObj(pID))
				local Facing = Get_Facing(Get_GameObj(pID))
				local Distance = 0 --the distance, of how far to create the object from the player.
				pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
				pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
				pos.Z = pos.Z + 1
				pos.Y = pos.Y + 1
				turret = Create_Object("civ_lab_tech_01", pos)
				Attach_Script_Once(turret, "z_Set_Team", Get_Team(pID))
				Attach_Script_Once(turret, "dinochange", "") 
				InputConsole("ppage %d You got a shockerbot in your present!", pID)
				InputConsole("cmsg 255,0,0 Happy Holidays! Enjoy your shockerbot!")
				InputConsole("cmsg 0,100,0 Happy Holidays! Enjoy your shockerbot!")
			elseif random == 2 or random == 3 then
				Attach_Script(Get_GameObj(pID), "present","")
				moneyrandom = math.random(2,10000)
				Set_Money(pID, Get_Money(pID)+moneyrandom) 
				InputConsole("ppage %d You open your present and you see %d credits! Hurray!", pID,moneyrandom)
				InputConsole("cmsg 135,206,250 Happy Holidays! Enjoy your %d credits!",moneyrandom)
				InputConsole("cmsg 30,144,255 Happy Holidays! Enjoy your %d credits!",moneyrandom)
			elseif random == 4 then
				Attach_Script(Get_GameObj(pID), "present","")
				local pos = Get_Position(Get_GameObj(pID))
				X = 7*math.cos(Get_Facing(Get_GameObj(pID))*(math.pi / 180))
				Y = 7*math.sin(Get_Facing(Get_GameObj(pID))*(math.pi / 180))
				local pos2 = {X = pos.X + X, Y = pos.Y + Y, Z = pos.Z + 3}
				turret = Create_Object("CnC_Nod_Stealth_Tank", pos2)
				Attach_Script(turret, "z_Set_Team", Get_Team(pID))
				InputConsole("ppage %d You got a stealth tank in your present!", pID)
				InputConsole("cmsg 255,0,0 Happy Holidays! Enjoy your stealth tank!")
				InputConsole("cmsg 0,100,0 Happy Holidays! Enjoy your stealth tank!")
			elseif random == 5 then
				Attach_Script(Get_GameObj(pID), "present","")
				Grant_Powerup(Get_GameObj(pID), "POW_Railgun_Player")  
				InputConsole("ppage %d You open your present and you see a shiny new railgun!", pID)
				InputConsole("cmsg 135,206,250 Happy Holidays! Enjoy your railgun!")
				InputConsole("cmsg 30,144,255 Happy Holidays! Enjoy your railgun!") 
			elseif random == 6 then
				Attach_Script(Get_GameObj(pID), "present","")
				Grant_Powerup(Get_GameObj(pID), "POW_Head_Band")
				InputConsole("ppage %d You open your present and you see an unlimited supply of proxy mines!", pID)
				InputConsole("cmsg 135,206,250 Happy Holidays! Enjoy your proxys!!")
				InputConsole("cmsg 30,144,255 Happy Holidays! Enjoy your proxys!!") 
			elseif random == 7 then
				Attach_Script(Get_GameObj(pID), "present","")
				local pos = Get_Position(Get_GameObj(pID))
				InputConsole("ppage %d You open your present and you find out you've been a naughty child! Burrrrrrn!!!!!!", pID)
				InputConsole("cmsg 255,255,0 Happy Holidays! BURN FOR BEING NAUGHTY")
				InputConsole("cmsg 255,140,0 Happy Holidays! BURN FOR BEING NAUGHTY")
				turret = Create_Object("CnC_Nod_Stealth_Tank", pos)
	 			Attach_Script_Once(turret, "JFW_Blow_Up_On_Death", "Explosion_NukeBeacon")
				Apply_Damage(turret,9999, "blamokiller", 0)
			end
		end
	end	
	if Message == "!santa" then
		local pos = Get_Position(Get_GameObj(pID))
		local Facing = Get_Facing(Get_GameObj(pID))
		local Distance = 0 --the distance, of how far to create the object from the player.
		pos.X = pos.X + Distance*math.cos(Facing)*(math.pi / 180)
		pos.Y = pos.Y + Distance*math.sin(Facing)*(math.pi / 180)
		pos.Z = pos.Z + 1
		pos.Y = pos.Y + 1
		turret = Create_Object("M04 Ship First Mate", pos)
		Attach_Script(turret, "z_Set_Team", Get_Team(pID))
		pos.X = pos.X + 1
		turret = Create_Object("M04 Ship First Mate", pos)
		Attach_Script(turret, "z_Set_Team", Get_Team(pID))
	end
	if Message == "!elf" then
		if Get_Preset_Name(Get_GameObj(pID)) == "CnC_GDI_Mutant_2SF_Templar" then
			InputConsole("msg Lol, %s tried to buy elf when they already had it.",sName)
		else
		Change_Character(Get_GameObj(pID),"CnC_GDI_Mutant_2SF_Templar") 
		InputConsole("cmsg 255,255,0 Happy Holidays! Try shooting people with the AI pistol!")
		InputConsole("cmsg 255,140,0 Happy Holidays! Try shooting people with the AI pistol!")
		Grant_Powerup(Get_GameObj(pID), "POW_Pistol_AI")
		end
	end	
onob
		Attach_Script_Once(Object, "nukepistol", "")

--xmas
nukepistol = {}

function nukepistol:Created(ID, obj)   

end

function nukepistol:Damaged(ID, obj, shooter, damage)
	if Get_Preset_Name(shooter) == "CnC_GDI_Mutant_2SF_Templar" then
		if Get_Current_Max_Bullets(shooter) == 8 then
			if Get_Object_Type(shooter) ~= Get_Object_Type(obj) then
				veh = Get_Vehicle(shooter)
				if veh == 0 then
					local pos = Get_Position(obj)
					InputConsole("cmsg 255,255,0 Happy Holidays! Enjoy being blown up by an elf :p")
					InputConsole("cmsg 255,140,0 Happy Holidays! Enjoy being blown up by an elf :p")
					turret = Create_Object("Nod_Minigunner_0", pos)
 					Attach_Script_Once(turret, "JFW_Blow_Up_On_Death", "Explosion_NukeBeacon")
					Apply_Damage(turret,9999, "blamokiller", 0)
				end
			end
		end
	end
end


present = {}
function present:Created(ID, obj)   
	Start_Timer(ID, obj,10, 0)
end

function present:Timer_Expired(ID, obj, num)
	objpid = Get_Player_ID(obj)
	Players[objpid].Present = "Yes"
end

Register_Script("present", "", present)

Register_Script("nukepistol", "", nukepistol) --Ammo_Pistol_Ai
--end xmas



	if Message == "!turkey" then
		local pos = Get_Position(Get_GameObj(pID))
		pos.Z = pos.Z + 1
		pos.Y = pos.Y + 1
		chicken = Create_Object("CnC_Nod_RocketSoldier_2SF", pos)
		Set_Model(chicken, "c_chicken")
		Attach_Script_Once(chicken, "chickendie", "")
		Attach_Script(chicken, "z_Set_Team", Get_Team(pID))
		Attach_Script(chicken, "M05_Nod_Gun_Emplacement", "")
		Attach_Script(chicken, "M01_Hunt_The_Player", "")
		InputConsole("msg %s has a chicken friend! When you kill him, you gain 100 credits!",sName)
	end


chickendie = {}
function chickendie:Created(ID, obj)   

end
function chickendie:Destroyed(ID, obj)

end

function chickendie:Killed(ID, obj, killer)
	local halfofhp = Get_Health(killer)*.6
	Set_Money(Get_Player_ID(killer), Get_Money(Get_Player_ID(killer))+100)
	Apply_Damage(killer, halfofhp, "sharpnel", 0) 
	InputConsole("ppage %d You have gained 100 credits!",Get_Player_ID(killer))
	InputConsole("ppage %d You have lost some health because you killed the chicken!! Greedy Bastard!",Get_Player_ID(killer), halfofhp)	
end

function chickendie:Damaged(ID, obj, shooter, damage)

end

function chickendie:Custom(ID, obj, message, param, sender)

end

function chickendie:Enemy_Seen(ID, obj, seen)

end

function chickendie:Action_Complete(ID, obj, action)

end

function chickendie:Animation_Complete(ID, obj, anim)

end

function chickendie:Poked(ID, obj, poker)

end

function chickendie:Entered(ID, obj, enter)

end

function chickendie:Exited(ID, obj, exiter)

end
function chickendie:Timer_Expired(ID, obj, num)

end

Register_Script("chickendie", "", chickendie)

------------





----------------------------------------------------------------------------------------------------------


--------------
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
zombie = {}
function zombie:Created(ID, obj)   

end
function zombie:Destroyed(ID, obj)

end

function zombie:Killed(ID, obj, killer)
if Get_Model(obj) == "DSP_BEAKER" or Get_Model(obj) == "DSP_DESK" or Get_Model(obj) == "DSP_BOOKSHELF" or Get_Model(obj) ==  "DSP_BUNKBEDS" or Get_Model(obj) ==  "DSP_COUCH" or Get_Model(obj) ==  "DSP_COUCH3" or Get_Model(obj) ==  "DSP_COUCH4" or Get_Model(obj) ==  "DSP_CRYOBIG" or Get_Model(obj) ==  "DSP_FIRESIGN" or Get_Model(obj) ==  "DSP_GASCAN" or Get_Model(obj) ==  "DSP_SEABUOY" or Get_Model(obj) ==  "DSP_TIBTREE2" or Get_Model(obj) ==  "DSP_TOILET" or Get_Model(obj) ==  "DSP_TVMONITOR" or Get_Model(obj) ==  "DSP_URINAL" or Get_Model(obj) ==  "DSP_VENDING" then
	avi = nothing
else
	local pos = Get_Position(obj)
	local preset = Get_Preset_Name(obj)
	pos.Z = pos.Z + 1
	pos.Y = pos.Y + 1   
	local turret = Create_Object(preset, pos)
	InputConsole("msg %s has died, and a Zombie has come to eat your brains!!",Get_Player_Name(obj))
	Attach_Script(turret, "M05_Nod_Gun_Emplacement", "")
	Attach_Script(turret, "z_Set_Team", Get_Team(Get_Player_ID(obj)))
	Attach_Script(turret, "M01_Hunt_The_Player_JDG", "")
end		
end

function zombie:Damaged(ID, obj, shooter, damage)

end

function zombie:Custom(ID, obj, message, param, sender)

end

function zombie:Enemy_Seen(ID, obj, seen)

end

function zombie:Action_Complete(ID, obj, action)

end

function zombie:Animation_Complete(ID, obj, anim)

end

function zombie:Poked(ID, obj, poker)

end

function zombie:Entered(ID, obj, enter)

end

function zombie:Exited(ID, obj, exiter)

end
function zombie:Timer_Expired(ID, obj, num)

end

Register_Script("zombie", "", zombie)
------------------------------------------------------------------

