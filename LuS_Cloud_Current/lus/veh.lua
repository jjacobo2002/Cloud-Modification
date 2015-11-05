module('veh', package.seeall)

trooptrans = {}; trooptrans[0] = false; trooptrans[1] = false

function Command(pID, Message)
	if Message[1] == "!hovercraft" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 2500
			msg = string.format("You need %d credits to buy a hovercraft.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a hovercraft because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 10
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 2
					
				vehobj = Create_Object("CnC_GDI_Orca", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				Set_Model(vehobj, "v_ag_hcraft")
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating hovercraft.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!gditrans" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 1500
			msg = string.format("You need %d credits to buy a gditrans.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a gditrans because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_GDI_Transport", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating gditrans.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!nodtrans" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 1500
			msg = string.format("You need %d credits to buy a nodtrans.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a nodtrans because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_Nod_Transport", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating nodtrans.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!med" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 1500
			msg = string.format("You need %d credits to buy a med.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a med because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_GDI_Medium_Tank", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating med.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!mammy" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 3800
			msg = string.format("You need %d credits to buy a mammy.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a mammy because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 10
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_GDI_Mammoth_Tank", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating mammy.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!mrls" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 1200
			msg = string.format("You need %d credits to buy a mrls.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a mrls because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_gdi_mrls", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating mrls.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!gapc" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 2000
			msg = string.format("You need %d credits to buy a gdi apc.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a gdi apc because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_gdi_apc", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating gapc.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!napc" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 2000
			msg = string.format("You need %d credits to buy a nod apc.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a nod apc because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_nod_apc", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating napc.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!humvee" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 850
			msg = string.format("You need %d credits to buy a humvee.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a humvee because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_GDI_Humm-vee", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating humvee.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!light" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 2200
			msg = string.format("You need %d credits to buy a light tank.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a light tank because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_nod_light_tank", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating light.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!demossm" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 5500
			msg = string.format("You need %d credits to buy a demossm.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a demossm because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 8
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("Nod_SSM_Launcher_Player", pos)
				Set_Model(vehobj, "v_nod_ssm")
 				Attach_Script_Once(vehobj, "JFW_Blow_Up_On_Death", "Explosion_IonCannonBeacon")
				Attach_Script_Once(vehobj, "z_Set_Team", team)
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating demossm.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					InputConsole("cmsg 0,230,57 [LuS] %s has bought a ssm launcher.", user[pID]:GetName())
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!stank" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 2800
			msg = string.format("You need %d credits to buy a stank.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a stank because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_Nod_Stealth_Tank", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating stank.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!recon" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 1000
			msg = string.format("You need %d credits to buy a recon.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a recon because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_Nod_Recon_Bike", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating recon.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!flame" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 2000
			msg = string.format("You need %d credits to buy a flame.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a flame because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_Nod_Flame_Tank", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating flame.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!buggy" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 700
			msg = string.format("You need %d credits to buy a buggy.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a buggy because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_Nod_Buggy", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating buggy.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!arty" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			
			price = 1500
			msg = string.format("You need %d credits to buy an arty.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy an arty because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				Distance = 7
				
				pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
				pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
				pos.Z = pos.Z + 3
					
				vehobj = Create_Object("CnC_Nod_Mobile_Artillery", pos)
				Attach_Script_Once(vehobj, "z_Set_Team", team)	
				
				if vehobj == nil then
					InputConsole("ppage %d Error creating arty.", pID)
				else 
					Set_Money(pID, Get_Money(pID) - price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!trooptrans" then
		if user[pID]:HasAccess(1) then
			team = Get_Team(pID)
			health = Get_Health(Find_Vehicle_Factory(team))
			preset = {}; preset[0] = "CnC_Nod_Transport"; preset[1] = "CnC_GDI_Transport"
			buysnd = {}; buysnd[0] = "m00gnod_hesx0018i1nomg_snd"; buysnd[1] = "m00ggdi_secx0041i1gbmg_snd"
			
			price = 12000
			msg = string.format("You need %d credits to buy a trooptrans.", price)
			if health == 0 then
				price = price * 2
				msg = string.format("You need %d credits to buy a trooptrans because you have no Vehicle Factory.", price)
			end
			
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d %s", pID, msg)
			else
				if trooptrans[team] == false then
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
					Distance = 7
					
					pos.X = pos.X + (Distance*math.cos(Facing*(math.pi / 180)))
					pos.Y = pos.Y + (Distance*math.sin(Facing*(math.pi / 180)))
					pos.Z = pos.Z + 3
						
					vehobj = Create_Object(preset[team], pos)
					Attach_Script_Once(vehobj, "z_Set_Team", team)	
					Attach_Script(vehobj, "troopdrop", "")
					
					if vehobj == nil then
						InputConsole("ppage %d Error creating trooptrans.", pID)
					else 
						Set_Money(pID, Get_Money(pID) - price)
						gi.AddMoneySpend(user[pID]:GetName(), price)
						InputConsole("msg %s has bought a %s troop transport! Will spawn bots every 20 seconds!", user[pID]:GetName(), mf.TeamName(team))
						InputConsole("snda %s", buysnd[team])
						trooptrans[team] = true
					end
				else
					InputConsole("ppage %d Someone else has already bought a troop transport. 1 allowed per team.", pID)
				end
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	return false
end

function TroopTrans(tObj)
	preset_name = Get_Preset_Name(tObj)
	if preset_name == "CnC_Nod_Transport" then
		bot = "Nod_Minigunner_0"
	elseif preset_name == "CnC_GDI_Transport" then
		bot = "CnC_GDI_MiniGunner_0_Skirmish"
	end

	driver = Get_Vehicle_Driver(tObj)
	if driver ~= 0 then
		team = Get_Team(Get_Player_ID(driver))
		
		if team == 0 or team == 1 then
			pos = Get_Position(tObj)
			Facing = Get_Facing(tObj)
			
			newpos = mf.CalcPos(pos, Facing, 3, {Z=-3})
			soldier = Create_Object(bot, newpos)
			Attach_Script(soldier, "M00_No_Falling_Damage_DME", "")
			Attach_Script_Once(soldier, "z_Set_Team", team)
			
			newpos = mf.CalcPos(pos, Facing, -3, {Z=-3})
			soldier = Create_Object(bot, newpos)
			Attach_Script(soldier, "M00_No_Falling_Damage_DME", "")
			Attach_Script_Once(soldier, "z_Set_Team", team)
		end
	end
end

function TroopTransKilled(preset_name)
	if preset_name == "CnC_Nod_Transport" then
		trooptrans[0] = false
	elseif preset_name == "CnC_GDI_Transport" then
		trooptrans[1] = false
	end
end
