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
					
					newpos = mf.CalcPos(pos, Facing, 1, 1)
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
					
					newpos = mf.CalcPos(pos, Facing, 1, 1)
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
					MultiSpawn(Get_GameObj(pID), "CnC_Ignatio_Mobius_Skirmish", 3, 2, 0.1, false)
					
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
					MultiSpawn(Get_GameObj(pID), "CnC_Nod_FlameThrower_3Boss_Skirmish", 3, 2, 0.1, false)
					
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
	
	return false
end

function MultiSpawn(CenterObj, Preset, Units, Distance, Z, Random)
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
		
		newpos = mf.CalcPos(pos, Facing, Distance, Z)
		obj = Create_Object(objname, newpos)

		Facing = Facing + FaceInc
		if Facing > 180 then
			Facing = -180+(Facing-180)
		end
	end
end
