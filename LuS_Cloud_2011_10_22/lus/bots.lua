module('bots', package.seeall)

function Command(pID, Message)
	if Message[1] == "!grbot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 1800
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					MultiSpawn(Get_GameObj(pID), "GDI_RocketSoldier_0", 3, 2, 0.1, false)
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!nrbot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 1800
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					MultiSpawn(Get_GameObj(pID), "Nod_RocketSoldier_0", 3, 2, 0.1, false)
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on Nod.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end

	if Message[1] == "!rgbot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 2800
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					botr = math.random(2, 20)
					if botr < 10 then
						Distance = 2
					else
						Distance = botr/5
					end
					
					MultiSpawn(Get_GameObj(pID), "CnC_GDI_MiniGunner_0_Skirmish", botr, Distance, 0.1, false)
					
					InputConsole("cmsg 0,250,250 %s has bought random bots, and recieved %d!", user[pID]:GetName(), botr)
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!rnbot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 2800
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					botr = math.random(2, 20)
					if botr < 10 then
						Distance = 2
					else
						Distance = botr/5
					end
					
					MultiSpawn(Get_GameObj(pID), "Nod_Minigunner_0", botr, Distance, 0.1, false)
					
					InputConsole("cmsg 0,250,250 %s has bought random bots, and recieved %d!", user[pID]:GetName(), botr)
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on Nod.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!gdicommander" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 4000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					pObj = Get_GameObj(pID)
					
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
					
					newpos = mf.CalcPos(pos, Facing, 1, {Z=1})
					obj = Create_Object("MX0_GDI_MiniGunner_1Off", newpos)
					
					InputConsole("cmsg 0,250,250 %s has bought a GDI commander, he will spawn bots.", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!nodcommander" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 4000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					pObj = Get_GameObj(pID)
					
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
					
					newpos = mf.CalcPos(pos, Facing, 1, {Z=1})
					obj = Create_Object("Nod_Minigunner_1Off_LaserChaingun", newpos)
					
					InputConsole("cmsg 0,250,250 %s has bought a Nod commander, he will spawn bots.", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on Nod.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!mobot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 2500
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					MultiSpawn(Get_GameObj(pID), "CnC_Ignatio_Mobius_Skirmish", 3, 2, 0.1, false, { lus_damaged="", lus_poked="", lus_killed="" })
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!mebot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 2500
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					MultiSpawn(Get_GameObj(pID), "CnC_Nod_FlameThrower_3Boss_Skirmish", 3, 2, 0.1, false, { lus_damaged="", lus_poked="", lus_killed="" })
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on Nod.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!techbot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 3500
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					Scripts = { z_Set_Team=2, RA_Infantry_Spy="" }
					MultiSpawn(Get_GameObj(pID), "Nod_Technician_0", 3, 2, 0.1, false, Scripts)
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on Nod.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!hotbot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 3500
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					Scripts = { z_Set_Team=2, RA_Infantry_Spy="" }
					MultiSpawn(Get_GameObj(pID), "GDI_Engineer_2SF", 3, 2, 0.1, false, Scripts)
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!nodarmy" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 4000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					Bots = 	{ 	"Nod_Minigunner_0", "Nod_Minigunner_1Off", "Nod_Minigunner_0", "Nod_Minigunner_0", "Nod_Minigunner_0", "Nod_Minigunner_0", 
								"Nod_RocketSoldier_0", "Nod_RocketSoldier_0", "Nod_Minigunner_0", "Nod_Minigunner_0", "Nod_Minigunner_0"
							}
					
					MultiSpawn(Get_GameObj(pID), Bots, table.maxn(Bots), 3, 0.1, false)
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on Nod.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!gdiarmy" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 4000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					Bots = 	{ 	"GDI_Minigunner_0", "GDI_Minigunner_1Off", "GDI_Minigunner_0", "GDI_Minigunner_0", "GDI_RocketSoldier_0", "GDI_Minigunner_0", 
								"GDI_RocketSoldier_0", "GDI_Minigunner_0", "GDI_Minigunner_0", "GDI_Minigunner_0", "GDI_Minigunner_0"
							}
							
					MultiSpawn(Get_GameObj(pID), Bots, table.maxn(Bots), 3, 0.1, false)
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!rbot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 5000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					MultiSpawn(Get_GameObj(pID), "Nod_RocketSoldier_3Boss", 3, 2, 0.1, false, { lus_damaged="", lus_poked="", lus_killed="" })
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on Nod.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!sbot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 5000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					MultiSpawn(Get_GameObj(pID), "GDI_RocketSoldier_3Boss", 3, 2, 0.1, false, { lus_damaged="", lus_poked="", lus_killed="" })
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!nbot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 1000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					MultiSpawn(Get_GameObj(pID), "Nod_Minigunner_0", 3, 2, 0.1, false)
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on Nod.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!gbot" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 1000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)			
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					MultiSpawn(Get_GameObj(pID), "CnC_GDI_MiniGunner_0_Skirmish", 3, 2, 0.1, false)
					
					InputConsole("cmsg 0,250,250 %s has bought bots!", user[pID]:GetName())
					
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI.", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!rambot" then
		if user[pID]:HasAccess(1) then
			price = 3000
			team = Get_Team(pID)
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				if team == 1 then
					Bot = "GDI_MiniGunner_3Boss"
				elseif team == 0 then
					Bot = "Nod_Minigunner_3Boss"
				end
				
				MultiSpawn(Get_GameObj(pID), Bot, 2, 2, 0.1, false, { z_Set_Team=team, lus_damaged="", lus_poked="", lus_killed="" })
				
				InputConsole("cmsg 0,250,250 %s has bought ramjet bots!!", user[pID]:GetName())
				
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	-- Buy w/ recs	--
	if Message[1] == "!buyshockerbot" then
		if user[pID]:HasAccess(1) then
			price = 10
			team = Get_Team(pID)
			if user[pID]:GetRecs() < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d recs", pID, price)
			else			
				MultiSpawn(Get_GameObj(pID), "civ_lab_tech_01", 1, 1, 0.1, false, { z_Set_Team=team, lus_damaged="", lus_poked="", lus_killed="", changemodel="dino" })
				
				InputConsole("cmsg 0,250,0 %s has bought a shockerbot, using recs!", user[pID]:GetName())
				user[pID]:RemoveRecs(price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	return false
end

function MultiSpawn(CenterObj, Preset, Units, Distance, Z, Random, Scripts)
	Facing = Get_Facing(CenterObj)
	FaceInc = 360/Units

	pos = Get_Position(CenterObj)

	for i=1, Units do
		if type(Preset) == "string" then
			objname = Preset
		elseif Random then
			objname = Preset[math.random(1, table.maxn(Preset))]
		else
			objname = Preset[i]
		end
		
		newpos = mf.CalcPos(pos, Facing, Distance, {Z=Z})
		obj = Create_Object(objname, newpos)
		if Scripts ~= nil and type(Scripts) == "table" then
			LuS_Attach_Scripts(obj, Scripts)
		end

		Facing = Facing + FaceInc
		if Facing > 180 then
			Facing = -180+(Facing-180)
		end
	end
end
