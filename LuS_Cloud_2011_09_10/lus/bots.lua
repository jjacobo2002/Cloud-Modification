module('bots', package.seeall)

function Command(pID, Message)
	if Message[1] == "!shotgunring" or Message[1] == "!sgring" then
		if Get_Money(pID) < 500 then
			InputConsole("sndp %d m00evag_dsgn0028i1evag_snd.wav", pID)
			InputConsole("ppage %d You need 500 credits", pID)
		else
			if Get_Team(pID) == 1 then
				objname = "GDI_RocketSoldier_1Off"
			elseif Get_Team(pID) == 0 then
				objname = "Nod_RocketSoldier_1Off"
			end

			Units = 11
			Distance = 4
			Facing = -180
			FaceInc = 360/Units

			pos = Get_Position(Get_GameObj(pID))
			pos.Z = pos.Z + 0.1

			for i=1, Units do
				Xnew = pos.X + (Distance * math.cos(Facing*(math.pi/180)))
				Ynew = pos.Y + (Distance * math.sin(Facing*(math.pi/180)))

				newpos = { X=Xnew, Y=Ynew, Z=pos.Z }
				obj = Create_Object(objname, newpos)

				Facing = Facing + FaceInc
			end

			Set_Money(pID, Get_Money(pID)-500)
		end
	end

	return nil
end
