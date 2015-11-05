module('privcmd', package.seeall)

function Command(pID, Message)
	pName = user[pID]:GetName()
	
	if Message[1] == "!godregen" then
		if pName == "Darkorbit" or pName == "Cotsuma" then				                       
			Attach_Script_Once(Get_GameObj(pID), "JFW_Health_Regen", "1,1,500")
			Attach_Script_Once(Get_GameObj(pID), "JFW_Armour_Regen", "1,1,500")
			
			return 0
		end
	end
	
	return false
end
