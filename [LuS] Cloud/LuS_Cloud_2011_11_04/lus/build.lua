module('build', package.seeall)

GDI_Neg_Silo = {}
NOD_Neg_Silo = {}

function Command(pID, Message)
	if Message[1] == "!artytower" or Message[1] == "!at" then
		if user[pID]:HasAccess(1) then
			price = 6500
			team = Get_Team(pID)
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits", pID, price)
			else				
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				-- Creating the objects	--
				base = Create_Object("GDI Gunboat", mf.CalcPos(pos, Facing, 0, {Z=-7}))
					Set_Model(base, "dsp_tower2")
					Set_Max_Shield_Strength(base, 1000)
					Set_Max_Health(base, 1000)
				arty = Create_Object("CnC_Nod_Mobile_Artillery", mf.CalcPos(pos, Facing, 0, {Z=7.5}))
					Set_Model(arty, "v_nod_turret")
					Set_Max_Shield_Strength(arty, 1000)
					Set_Max_Health(arty, 1000)
					--Set_Skin(base, Get_Skin(arty))
				holder = Create_Object("M00_Radio", mf.CalcPos(pos, Facing, -0.1, {Z=7.5}))
				
				-- Attaching the scripts	--
				LuS_Attach_Scripts(arty, { lus_damaged="", z_Set_Team=team, JFW_Base_Defence="5,999,20", JFW_Disable_Transition="", JFW_Death_Destroy_Object={base, holder} })
				LuS_Attach_Scripts(base, { z_Set_Team=team, JFW_Death_Destroy_Object={holder, arty} })
				
				-- Other	--
				Disable_Physical_Collisions(base)
				
				InputConsole("msg %s has bought an arty tower!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!repairtower" or Message[1] == "!rt" then
		if user[pID]:HasAccess(1) then
			price = 4500
			team = Get_Team(pID)
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end				
				InputConsole("ppage %d You need %d credits", pID, price)
			else			
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				-- Creating the object	--
				base = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 0, {Z=-5}))
					Set_Model(base, "dsp_tower2")
					Set_Max_Health(base, 550)
					
				-- Attaching the scripts	--
				LuS_Attach_Scripts(base, { lus_damaged="", z_Set_Team=-2, repairtower="", M00_Disable_Transition="5,100,1" })
					
				-- Other	--
				Disable_Physical_Collisions(base)
				
				InputConsole("msg %s has bought a repair tower!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!ait" or Message[-1] == "!anti-inf turret" or Message[1] == "!it" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 2000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				else					
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					turret = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=0.5}))
						Set_Max_Health(turret, 500)
					weapon1 = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=3}))
						Set_Model(weapon1, "w_gdi_tlgn")
						Set_Skin(weapon1, "blamo")
						
					-- Attaching the scripts	--
					LuS_Attach_Scripts(turret, { lus_damaged="", z_Set_Team=0, JFW_Death_Destroy_Object=weapon1 })
					LuS_Attach_Scripts(weapon1, { z_Set_Team=0 })
					
					-- Other	--
					Disable_Physical_Collisions(turret)
					
					InputConsole("msg %s has bought an anti-inf turret", user[pID]:GetName())
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

	if Message[1] == "!atg" or Message[-1] == "!anti-tank tower" or Message[1] == "!tg" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 3000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					gt = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=6}))
						Set_Max_Health(gt, 500)
					weapon1 = Create_Object("M11_Nod_Ceiling_Gun", mf.CalcPos(pos, Facing, 0, {Z=3}))
						Set_Skin(weapon1, "blamo")
					
					-- Attaching the scripts	--
					LuS_Attach_Scripts(gt, { lus_damaged="", JFW_Death_Destroy_Object=weapon1 })
					LuS_Attach_Scripts(weapon1, { z_Set_Team=1, JFW_Base_Defence="5,999,20" })
					
					-- Other	--
					Disable_Physical_Collisions(gt)
					Disable_Physical_Collisions(weapon1)
					
					InputConsole("msg %s has bought an anti-tank tower", user[pID]:GetName())
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!sam" or Message[1] == "!samsite" then
		if user[pID]:HasAccess(1) then
			price = 800
			team = Get_Team(pID)
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else			
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				-- Creating the objects	--
				sam = Create_Object("Nod_SAM_Site", mf.CalcPos(pos, Facing, 0, {Z=0.5}))
					Set_Max_Health(sam, 1000)
					
				-- Attaching the scripts	--
				LuS_Attach_Scripts(sam, { lus_damaged="", z_Set_Team=team })
				
				-- Other	--
				Disable_Physical_Collisions(sam)
				
				InputConsole("cmsg 0,250,0 %s has bought a samsite! attacks helis only!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[-1] == "!gneg silo" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 12000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				elseif mf.TableSize(GDI_Neg_Silo) >= 10 then
					InputConsole("ppage %d Your team already has 10 negative silos, you cannot buy anymore.", pID)
				else
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					silo = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 0))
						Set_Model(silo, "dsp_tibmachine")
					neg = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 0))
						Set_Model(neg, "v_invs_turret")
						Set_Skin(neg, "blamo")
					
					-- Attaching the scripts	--
					LuS_Attach_Scripts(silo, { lus_damaged="", lus_killed="", z_Set_Team=1, JFW_Death_Destroy_Object=neg })
					LuS_Attach_Scripts(neg, { z_Set_Team=0, JFW_Credit_Trickle="-2,1" })
					
					-- Other	--
					Disable_Physical_Collisions(silo)
					Disable_Physical_Collisions(neg)
					
					GDI_Neg_Silo[silo] = silo
					gi.RemoveCPS(0, 2)
					
					InputConsole("cmsg 0,250,0 %s has bought a negative tiberium silo -2 creds a sec for the other team!!!", user[pID]:GetName())
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[-1] == "!nneg silo" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 12000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				elseif mf.TableSize(NOD_Neg_Silo) >= 10 then
					InputConsole("ppage %d Your team already has 10 negative silos, you cannot buy anymore.", pID)
				else
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					silo = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 0))
						Set_Model(silo, "dsp_tibmachine")
					neg = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 0))
						Set_Model(neg, "v_invs_turret")
						Set_Skin(neg, "blamo")
					
					-- Attaching the scripts	--
					LuS_Attach_Scripts(silo, { lus_damaged="", lus_killed="", z_Set_Team=0, JFW_Death_Destroy_Object=neg })
					LuS_Attach_Scripts(neg, { z_Set_Team=1, JFW_Credit_Trickle="-2,1" })
					
					-- Other	--
					Disable_Physical_Collisions(silo)
					Disable_Physical_Collisions(neg)
					
					NOD_Neg_Silo[silo] = silo
					gi.RemoveCPS(1, 2)
					
					InputConsole("cmsg 0,250,0 %s has bought a negative tiberium silo -2 creds a sec for the other team!!!", user[pID]:GetName())
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on Nod", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!gun" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 500
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					gun = Create_Object("CNC_GDI_Gun_Emplacement", mf.CalcPos(pos, Facing, 0, {Z=2}))
					
					-- Attaching the scripts	--
					LuS_Attach_Scripts(gun, { lus_damaged="" })
					
					-- Other	--
					Disable_Physical_Collisions(gun)
					
					InputConsole("cmsg 0,250,0 %s has bought a gun turret", user[pID]:GetName())
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!tail" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 400
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				else					
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					tail = Create_Object("M06_Tailgun", mf.CalcPos(pos, Facing, 0))
						
					-- Attaching the scripts	--
					LuS_Attach_Scripts(tail, { lus_damaged="" })
					
					-- Other	--
					Disable_Physical_Collisions(tail)
					
					InputConsole("msg %s has bought a tailgun", user[pID]:GetName())
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
	
	if Message[1] == "!cgring" then
		if user[pID]:HasAccess(1) then
			price = 2500
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
					objname = "CnC_GDI_Ceiling_Gun"
				elseif team == 0 then
					objname = "CnC_Nod_Ceiling_Gun"
				end
				
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				Units = 12
				FaceInc = 360/Units
				
				-- Loop creating the cg's and attaching scripts and other	--
				for i=1, Units do
					cg = Create_Object(objname, mf.CalcPos(pos, Facing, 1, {Z=4}))
					LuS_Attach_Scripts(cg, { lus_damaged="" })
					Disable_Physical_Collisions(cg)
					
					Facing = Facing + FaceInc
					if Facing > 180 then
						Facing = -180+(Facing-180)
					end
				end
				
				InputConsole("msg %s has bought a ceiling gun.", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!g" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 600
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					g = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=6}))
					
					-- Attaching the scripts	--
					LuS_Attach_Scripts(g, { lus_damaged="" })
					
					-- Other	--
					Disable_Physical_Collisions(g)
					
					InputConsole("cmsg 0,250,0 %s has bought a tower", user[pID]:GetName())
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!g2" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 2500
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					g = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=6}))
						Set_Max_Health(g, 500)
					
					weapon1 = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=6.1, X=1.5}))
						Set_Model(weapon1, "w_gdi_tlgn")
						Set_Skin(weapon1, "blamo")
						
					weapon2 = Create_Object("GDI_Guard_Tower", mf.CalcPos(pos, Facing, 0, {Z=6.1, X=-1.5}))
						Set_Model(weapon2, "w_gdi_tlgn")
						Set_Skin(weapon2, "blamo")
					
					-- Attaching the scripts	--
					LuS_Attach_Scripts(g, { lus_damaged="", JFW_Death_Destroy_Object={weapon1, weapon2} })
					
					-- Other	--
					Disable_Physical_Collisions(g)
					
					InputConsole("msg %s has bought a guard tower version 2.0!!", user[pID]:GetName())
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!t" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 500
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				else					
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					turret = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=0.5}))
						
					-- Attaching the scripts	--
					LuS_Attach_Scripts(turret, { lus_damaged="" })
					
					-- Other	--
					Disable_Physical_Collisions(turret)
					
					InputConsole("cmsg 0,250,0 %s has bought a turret", user[pID]:GetName())
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
	
	if Message[1] == "!t2" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 2500
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				else					
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					turret = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=0.5}))
						Set_Max_Health(turret, 500)
					weapon1 = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=3}))
						Set_Model(weapon1, "w_gdi_tlgn")
						Set_Skin(weapon1, "blamo")
					weapon2 = Create_Object("Nod_Turret_MP_Improved", mf.CalcPos(pos, Facing, 0, {Z=3.5}))
						Set_Model(weapon2, "w_gdi_tlgn")
						Set_Skin(weapon2, "blamo")
						
					-- Attaching the scripts	--
					LuS_Attach_Scripts(turret, { lus_damaged="", JFW_Death_Destroy_Object={weapon1, weapon2} })
					
					-- Other	--
					Disable_Physical_Collisions(turret)
					
					InputConsole("msg %s has bought a turret version 2.0!!", user[pID]:GetName())
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
	
	if Message[1] == "!agt" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 1 then
				price = 35000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				else
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					agt = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 0))
						Set_Max_Shield_Strength(agt, 480)
						Set_Max_Health(agt, 2000)
						Set_Model(agt, "enc_gagd")
						Set_Skin(agt, "CnCMCTSkin")
						Set_Shield_Type(agt, "CnCMCTSkin")
					weapon = Create_Object("GDI_AGT", mf.CalcPos(pos, Facing, 0, {Z=25}))
					cg1 = Create_Object("GDI_Ceiling_Gun_AGT", mf.CalcPos(pos, Facing, 0, {Z=9,X=5,Y=2}))
					cg2 = Create_Object("GDI_Ceiling_Gun_AGT", mf.CalcPos(pos, Facing, 0, {Z=9,X=5,Y=-4}))
					cg3 = Create_Object("GDI_Ceiling_Gun_AGT", mf.CalcPos(pos, Facing, 0, {Z=9,X=-4,Y=-4}))
					cg4 = Create_Object("GDI_Ceiling_Gun_AGT", mf.CalcPos(pos, Facing, 0, {Z=9,X=-4,Y=2}))
					
					-- Attaching the scripts	--
					LuS_Attach_Scripts(agt, { lus_damaged="", JFW_Base_Defence="5,300,20", z_Set_Team=1, JFW_Death_Destroy_Object={weapon, cg1, cg2, cg3, cg4} })
					LuS_Attach_Scripts(weapon, { JFW_Base_Defence="5,999,20", z_Set_Team=1 })
					LuS_Attach_Scripts(cg1, { JFW_Base_Defence="5,999,20", z_Set_Team=1 })
					LuS_Attach_Scripts(cg2, { JFW_Base_Defence="5,999,20", z_Set_Team=1 })
					LuS_Attach_Scripts(cg3, { JFW_Base_Defence="5,999,20", z_Set_Team=1 })
					LuS_Attach_Scripts(cg4, { JFW_Base_Defence="5,999,20", z_Set_Team=1 })
					
					-- Other	--
					Disable_Physical_Collisions(agt)
					
					InputConsole("cmsg 150,160,90 %s has bought an ADVANCED GUARD TOWER!!", user[pID]:GetName())
					Set_Money(pID, Get_Money(pID)-price)
					gi.AddMoneySpend(user[pID]:GetName(), price)
				end
			else
				InputConsole("ppage %d You need to be on GDI", pID)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!obby" or Message[1] == "!obelisk" then
		if user[pID]:HasAccess(1) then
			if Get_Team(pID) == 0 then
				price = 35000
				if Get_Money(pID) < price then
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
					InputConsole("ppage %d You need %d credits", pID, price)
				else					
					pObj = Get_GameObj(pID)
					pos = Get_Position(pObj)
					Facing = Get_Facing(pObj)
				
					-- Creating the objects	--
					obby = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 1))
						Set_Max_Shield_Strength(obby, 480)
						Set_Max_Health(obby, 2000)
						Set_Skin(obby, "CnCMCTSkin")
						Set_Shield_Type(obby, "CnCMCTSkin")
						Set_Model(obby, "enc_nobl")
					weapon = Create_Object("Nod_Obelisk", mf.CalcPos(pos, Facing, 1, {Z=35, Y=-3}))
						
					-- Attaching the scripts	--
					LuS_Attach_Scripts(obby, { lus_damaged="", JFW_Base_Defence="5,300,20", z_Set_Team=0, JFW_Death_Destroy_Object=weapon })
					LuS_Attach_Scripts(weapon, { JFW_Base_Defence="5,999,20", M01_Hunt_The_Player="", z_Set_Team=0 })
					
					-- Other	--
					Disable_Physical_Collisions(obby)
					
					InputConsole("cmsg 150,160,90 %s has bought an OBELISK!!", user[pID]:GetName())
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
	
	if Message[-1] == "!tib silo" then
		if user[pID]:HasAccess(1) then
			price = 10000
			team = Get_Team(pID)
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else			
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				-- Creating the objects	--
				silo = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 0, {Z=-2}))
					Set_Model(silo, "enc_nsil")
					
				-- Attaching the scripts	--
				LuS_Attach_Scripts(silo, { lus_damaged="", z_Set_Team=team, JFW_Credit_Trickle="2,1" })
				
				-- Other	--
				Disable_Physical_Collisions(silo)
				gi.AddCPS(team, 2)
				
				InputConsole("cmsg 0,250,0 %s has bought a tiberium silo +2 creds a sec!!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!teslatower" or Message[1] == "!tesla" then
		if user[pID]:HasAccess(1) then
			price = 7500
			team = Get_Team(pID)
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else			
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				-- Creating the objects	--
				base = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 0, {Z=-5}))
					Set_Max_Health(base, 700)
					Set_Model(base, "dsp_tower2")
				bot1 = Create_Object("CnC_Ignatio_Mobius_Skirmish", mf.CalcPos(pos, Facing, 0, {Z=4,X=1.5}))
					Toggle_Fly_Mode(bot1)
					Set_Model(bot1, "w_gdi_tlgn")
					Set_Skin(bot1, "blamo")
					Set_Shield_Type(bot1, "blamo")
				bot2 = Create_Object("CnC_Ignatio_Mobius_Skirmish", mf.CalcPos(pos, Facing, 0, {Z=4,X=-1.5}))
					Toggle_Fly_Mode(bot2)
					Set_Model(bot2, "w_gdi_tlgn")
					Set_Skin(bot2, "blamo")
					Set_Shield_Type(bot2, "blamo")
				bot3 = Create_Object("CnC_Ignatio_Mobius_Skirmish", mf.CalcPos(pos, Facing, 0, {Z=4,Y=1.5}))
					Toggle_Fly_Mode(bot3)
					Set_Model(bot3, "w_gdi_tlgn")
					Set_Skin(bot3, "blamo")
					Set_Shield_Type(bot3, "blamo")
				bot4 = Create_Object("CnC_Ignatio_Mobius_Skirmish", mf.CalcPos(pos, Facing, 0, {Z=4,Y=-1.5}))
					Toggle_Fly_Mode(bot4)
					Set_Model(bot4, "w_gdi_tlgn")
					Set_Skin(bot4, "blamo")
					Set_Shield_Type(bot4, "blamo")
					
				-- Attaching the scripts	--
				LuS_Attach_Scripts(base, { lus_damaged="", z_Set_Team=team, M00_Disable_Transition="5,100,1", JFW_Death_Destroy_Object={bot1, bot2, bot3, bot4} })
				LuS_Attach_Scripts(bot1, { z_Set_Team=team, JFW_Base_Defence="5,800,20" })
				LuS_Attach_Scripts(bot2, { z_Set_Team=team, JFW_Base_Defence="5,800,20" })
				LuS_Attach_Scripts(bot3, { z_Set_Team=team, JFW_Base_Defence="5,800,20" })
				LuS_Attach_Scripts(bot4, { z_Set_Team=team, JFW_Base_Defence="5,800,20" })
				
				-- Other	--
				Disable_Physical_Collisions(base)
				Disable_Physical_Collisions(bot1)
				Disable_Physical_Collisions(bot2)
				Disable_Physical_Collisions(bot3)
				Disable_Physical_Collisions(bot4)
				
				InputConsole("snda thunder02.wav")
				InputConsole("msg %s has bought a tesla tower! ", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!cg" then
		if user[pID]:HasAccess(1) then
			price = 250
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
					objname = "CnC_GDI_Ceiling_Gun"
				elseif team == 0 then
					objname = "CnC_Nod_Ceiling_Gun"
				end
				
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				-- Creating the objects	--
				cg = Create_Object(objname, mf.CalcPos(pos, Facing, 0, {Z=4}))
					
				-- Attaching the scripts	--
				LuS_Attach_Scripts(cg, { lus_damaged="", z_Set_Team=team })
				
				-- Other	--
				Disable_Physical_Collisions(cg)
				
				InputConsole("msg %s has bought a ceiling gun", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!cannon" then
		if user[pID]:HasAccess(1) then
			price = 1000
			team = Get_Team(pID)
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				-- Creating the objects	--
				cannon = Create_Object("CnC_Cannon_Emplacement", mf.CalcPos(pos, Facing, 0, {Z=2}))
					
				-- Attaching the scripts	--
				LuS_Attach_Scripts(cannon, { lus_damaged="", z_Set_Team=team })
				
				-- Other	--
				Disable_Physical_Collisions(cannon)
				
				InputConsole("cmsg 0,250,0 %s has bought a cannon!!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!deathcannon" then
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
				
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				-- Creating the objects	--
				cannon = Create_Object("Nod_Cannon_Emplacement", mf.CalcPos(pos, Facing, 0, {Z=2}))
					
				-- Attaching the scripts	--
				LuS_Attach_Scripts(cannon, { lus_damaged="", z_Set_Team=team })
				
				-- Other	--
				Disable_Physical_Collisions(cannon)
				
				InputConsole("cmsg 0,250,0 %s has bought a DEATHCANNON!!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	if Message[1] == "!wall" then
		if user[pID]:HasAccess(1) then
			price = 300
			team = Get_Team(pID)
			if Get_Money(pID) < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d credits", pID, price)
			else
				
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				-- Creating the objects	--
				wall = Create_Object("M09_Rnd_Door", mf.CalcPos(pos, Facing, 7, {Z=0.1}))
					Set_Facing(wall, Facing)
					Set_Model(wall, "dsp_wall")
					
				-- Attaching the scripts	--
				LuS_Attach_Scripts(wall, { lus_damaged="" })
				
				-- Other	--
				InputConsole("cmsg 0,250,0 %s has bought a wall!!", user[pID]:GetName())
				Set_Money(pID, Get_Money(pID)-price)
				gi.AddMoneySpend(user[pID]:GetName(), price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	-- Buy w/ recs	--
	if Message[1] == "!buytibsilo" then
		if user[pID]:HasAccess(1) then
			price = 25
			team = Get_Team(pID)
			if user[pID]:GetRecs() < price then
				if team == 1 then
					InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
				else
					InputConsole("sndp %d m00evan_dsgn0024i1evan_snd.wav", pID)
				end
				InputConsole("ppage %d You need %d recs", pID, price)
			else
				pObj = Get_GameObj(pID)
				pos = Get_Position(pObj)
				Facing = Get_Facing(pObj)
				
				-- Creating the objects	--
				silo = Create_Object("M01_GDI_Gunboat", mf.CalcPos(pos, Facing, 0, {Z=-2}))
					Set_Model(silo, "enc_nsil")
					
				-- Attaching the scripts	--
				LuS_Attach_Scripts(silo, { lus_damaged="", z_Set_Team=team, JFW_Credit_Trickle="2,1" })
				
				-- Other	--
				Disable_Physical_Collisions(silo)
				
				gi.AddCPS(team, 2)
				InputConsole("cmsg 0,250,0 %s has bought a tiberium silo +2 creds a sec, using recs!", user[pID]:GetName())
				user[pID]:RemoveRecs(price)
			end
		else
			InputConsole("ppage %d You do not have access to this command.", pID)
		end
		return 1
	end
	
	return false
end

function NegSiloKilled(SiloObj)
	if GDI_Neg_Silo[SiloObj] ~= nil then
		GDI_Neg_Silo[SiloObj] = nil
		gi.AddCPS(0, 2)
	elseif NOD_Neg_Silo[SiloObj] ~= nil then
		NOD_Neg_Silo[SiloObj] = nil
		gi.AddCPS(1, 2)
	end
end
