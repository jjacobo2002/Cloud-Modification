module('blackjack', package.seeall)



function OnPlayerJoin(pID, Nick)
user[pID] = {}

--blackjack stuff
user[pID].BlackJack = "No"
user[pID].bjdealeractualcount = 0
user[pID].bjplayeractualcount = 0
user[pID].bjdealeracecount = 0
user[pID].bjplayeracecount = 0
user[pID].bjplayerbet = 0

user[pID].bjplayercard1 = 0
user[pID].bjplayercard2 = 0
user[pID].bjdealercard1 = 0
user[pID].bjdealercard2 = 0

end

function Command(pID, Message)
	if Message[1] == "!mycards" then
		if user[pID].BlackJack == "Yes" then	
			InputConsole("ppage %d Dealer's cards are %s X", pID, tostring(user[pID].bjdealercard1))
			InputConsole("ppage %d Your first two cards are %s %s. The count of all your cards, including hits, is %d.. Would you like to !hit or !stay ?", pID, tostring(user[pID].bjplayercard1), tostring(user[pID].bjplayercard2), user[pID].bjplayeractualcount)
		else
			InputConsole("ppage %d Error. No blackjack game for you found. Try !blackjack <bet> to start a game.", pID)
		end
		return 1
	end
	if Message[1] == "!blackjackstats" then
		if tcg == nil and tcw == nil and tcl == nil and tbjh == nil and tpbj == nil and tdbj == nil then
			tcg = 0
			tcw = 0 
			tcl = 0
			tbjh = 0
			tpbj = 0 
			tdbj = 0
		end
		InputConsole("msg Total Credits Gambled: %d Total Credits Won: %d Total Credits Lost: %d Total Blackjack Hands: %d Total Player Blackjacks: %d Total Dealer Blackjacks: %d", tonumber(tcg), tonumber(tcw), tonumber(tcl), tonumber(tbjh), tonumber(tpbj), tonumber(tdbj))
		return 1
	end
	if Message[1] == "!hit" then
		if user[pID].BlackJack == "Yes" then
			if user[pID].bjplayeractualcount < 21 then
				hitcard = math.random(2,14)


				if hitcard == 11 then
					hitcard = "J"
				elseif hitcard == 12 then
					hitcard = "Q"	
				elseif hitcard == 13 then
					hitcard = "K"
				elseif hitcard == 14 then
					hitcard = "A"	
				end	
				if hitcard == "J" or hitcard == 10 or hitcard == "Q" or hitcard == "K" then
					user[pID].bjplayeractualcount = user[pID].bjplayeractualcount + 10



					if user[pID].bjplayeractualcount > 21 then
						if user[pID].bjplayeracecount > 0 then
							if user[pID].playerhandsoft == "Yes" then
								user[pID].playerhandsoft = "No"
								user[pID].bjplayeractualcount = user[pID].bjplayeractualcount - 11
								user[pID].bjplayeractualcount = user[pID].bjplayeractualcount + 1
								if user[pID].bjplayeractualcount > 21 then
									user[pID].BlackJack = "No"
									tcl = tcl + user[pID].bjplayerbet
									InputConsole("ppage %d Your hit card was %s for a total count of %d. You busted!", pID, tostring(hitcard), user[pID].bjplayeractualcount)
									InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
									InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
									user[pID].bjplayeractualcount = 0
								else
									InputConsole("ppage %d Your hit card was %s for a total count of %d. Would you like to !hit or !stay?", pID, tostring(hitcard), user[pID].bjplayeractualcount)
								end
							else
								user[pID].BlackJack = "No"
								tcl = tcl + user[pID].bjplayerbet
								InputConsole("ppage %d Your hit card was %s for a total count of %d. You busted!", pID, tostring(hitcard), user[pID].bjplayeractualcount)
								InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
								InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
								user[pID].bjplayeractualcount = 0
							end
						else
							user[pID].BlackJack = "No"
							tcl = tcl + user[pID].bjplayerbet
							InputConsole("ppage %d Your hit card was %s for a total count of %d. You busted!", pID, tostring(hitcard), user[pID].bjplayeractualcount)
							InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
							InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
							user[pID].bjplayeractualcount = 0
						end
					else
						InputConsole("ppage %d Your hit card was %s for a total count of %d. Would you like to !hit or !stay?", pID, tostring(hitcard), user[pID].bjplayeractualcount)
					end
				elseif hitcard == "A" then
					if user[pID].bjplayeracecount >= 1 then
						user[pID].bjplayeractualcount = user[pID].bjplayeractualcount + 1
						user[pID].bjplayeracecount = user[pID].bjplayeracecount + 1
						if user[pID].bjplayeractualcount > 21 then
							user[pID].BlackJack = "No"
							tcl = tcl + user[pID].bjplayerbet
							InputConsole("ppage %d Your hit card was %s for a total count of %d. You busted!", pID, tostring(hitcard), user[pID].bjplayeractualcount)
							InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
							InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
							user[pID].bjplayeractualcount = 0
						else
							InputConsole("ppage %d Your hit card was %s for a total count of %d. Would you like to !hit or !stay?", pID, tostring(hitcard), user[pID].bjplayeractualcount)
						end
					elseif user[pID].bjplayeracecount < 1 then
						user[pID].playerhandsoft = "Yes"
						user[pID].bjplayeractualcount = user[pID].bjplayeractualcount + 11
						user[pID].bjplayeracecount = user[pID].bjplayeracecount + 1
						if user[pID].bjplayeractualcount > 21 then
							user[pID].playerhandsoft = "No"
							user[pID].bjplayeractualcount = user[pID].bjplayeractualcount - 11
							user[pID].bjplayeractualcount = user[pID].bjplayeractualcount + 1
							if user[pID].bjplayeractualcount > 21 then
								user[pID].BlackJack = "No"
								tcl = tcl + user[pID].bjplayerbet
								InputConsole("ppage %d Your hit card was %s for a total count of %d. You busted!", pID, tostring(hitcard), user[pID].bjplayeractualcount)
								InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
								InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
								user[pID].bjplayeractualcount = 0
							else
								InputConsole("ppage %d Your hit card was %s for a total count of %d. Would you like to !hit or !stay?", pID, tostring(hitcard), user[pID].bjplayeractualcount)
							end
						else
							if user[pID].bjplayeractualcount > 21 then
								user[pID].BlackJack = "No"
								tcl = tcl + user[pID].bjplayerbet
								InputConsole("ppage %d Your hit card was %s for a total count of %d. You busted!", pID, tostring(hitcard), user[pID].bjplayeractualcount)
								InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
								InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
								user[pID].bjplayeractualcount = 0
							else
								InputConsole("ppage %d Your hit card was %s for a total count of %d. Would you like to !hit or !stay?", pID, tostring(hitcard), user[pID].bjplayeractualcount)
							end
						end
					end
				elseif hitcard <= 9 then
					user[pID].bjplayeractualcount = user[pID].bjplayeractualcount + hitcard
					if user[pID].bjplayeractualcount > 21 then
						if user[pID].bjplayeracecount > 0 then
							if user[pID].playerhandsoft == "Yes" then
								user[pID].playerhandsoft = "No"
								user[pID].bjplayeractualcount = user[pID].bjplayeractualcount - 11
								user[pID].bjplayeractualcount = user[pID].bjplayeractualcount + 1
								if user[pID].bjplayeractualcount > 21 then
									user[pID].BlackJack = "No"
									tcl = tcl + user[pID].bjplayerbet
									InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
									InputConsole("ppage %d Your hit card was %s for a total count of %d. You busted!", pID, tostring(hitcard), user[pID].bjplayeractualcount)
									InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
									user[pID].bjplayeractualcount = 0
								else
									InputConsole("ppage %d Your hit card was %s for a total count of %d. Would you like to !hit or !stay?", pID, tostring(hitcard), user[pID].bjplayeractualcount)
								end
							else
								user[pID].BlackJack = "No"
								tcl = tcl + user[pID].bjplayerbet
								InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
								InputConsole("ppage %d Your hit card was %s for a total count of %d. You busted!", pID, tostring(hitcard), user[pID].bjplayeractualcount)
								InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
								user[pID].bjplayeractualcount = 0
							end
						else
							user[pID].BlackJack = "No"
							tcl = tcl + user[pID].bjplayerbet
							InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
							InputConsole("ppage %d Your hit card was %s for a total count of %d. You busted!", pID, tostring(hitcard), user[pID].bjplayeractualcount)
							InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
							user[pID].bjplayeractualcount = 0
						end
					else
						InputConsole("ppage %d Your hit card was %s for a total count of %d. Would you like to !hit or !stay?", pID, tostring(hitcard), user[pID].bjplayeractualcount)
					end
				end
			else
				InputConsole("ppage %d You don't want to hit with 21 or higher do you??? Try !stay to fix the problem.", pID)
			end

		else
			InputConsole("ppage %d Error. No blackjack game for you found. Try !blackjack <bet> to start a game.", pID)
		end
		return 1
	end

--user[pID].BlackJack = "No"
--user[pID].bjdealeractualcount = 0
--user[pID].bjplayeractualcount = 0
--user[pID].bjdealeracecount = 0
--user[pID].bjplayeracecount = 0
--user[pID].bjplayerbet = 0

--user[pID].bjplayercard1 = 0
--user[pID].bjplayercard2 = 0
--user[pID].bjdealercard1 = 0
--user[pID].bjdealercard2 = 0
--user[pID].dealerhandsoft = "No"
--user[pID].playerhandsoft = "No"

	if Message[1] == "!stay" then
		if user[pID].BlackJack == "Yes" then
			InputConsole("ppage %d Dealer's cards are %s %s", pID, tostring(user[pID].bjdealercard1),tostring(user[pID].bjdealercard2))
			if user[pID].bjdealeractualcount >= 17 then
				InputConsole("ppage %d Dealer stands.", pID)
				if user[pID].bjdealeractualcount > user[pID].bjplayeractualcount then
					user[pID].BlackJack = "No"
					tcl = tcl + user[pID].bjplayerbet
					InputConsole("ppage %d Your total card count was %d and the dealers was %d. You lose :(", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
					InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
					InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
				elseif user[pID].bjdealeractualcount < user[pID].bjplayeractualcount then
					InputConsole("ppage %d Your total card count was %d and the dealers was %d. You win!!!!! :D", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
					InputConsole("ppage %d You win %d credits!!! Congratulations!", pID, user[pID].bjplayerbet)
					tcw = tcw + user[pID].bjplayerbet
					user[pID].BlackJack = "No"
                        	      	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
					InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
				elseif user[pID].bjdealeractualcount == user[pID].bjplayeractualcount then
					InputConsole("ppage %d Your total card count was %d and the dealers was %d.", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
					InputConsole("ppage %d You push.. no win or lose! Your bet of %d credits is given back", pID,user[pID].bjplayerbet)
                        	      	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
					user[pID].BlackJack = "No"
				end
			end
			while user[pID].bjdealeractualcount < 17 do


				hitcard = math.random(2,14)

				if hitcard == 11 then
					hitcard = "J"
				elseif hitcard == 12 then
					hitcard = "Q"	
				elseif hitcard == 13 then
					hitcard = "K"
				elseif hitcard == 14 then
					hitcard = "A"	
				end	

				if hitcard == "J" or hitcard == 10 or hitcard == "Q" or hitcard == "K" then
					user[pID].bjdealeractualcount = user[pID].bjdealeractualcount + 10



					if user[pID].bjdealeractualcount > 21 then
						if user[pID].bjdealeracecount > 0 then
							if user[pID].dealerhandsoft == "Yes" then
								user[pID].dealerhandsoft = "No"
								user[pID].bjdealeractualcount = user[pID].bjdealeractualcount - 11
								user[pID].bjdealeractualcount = user[pID].bjdealeractualcount + 1
								if user[pID].bjdealeractualcount > 21 then
									user[pID].BlackJack = "No"
									tcw = tcw + user[pID].bjplayerbet
									InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d. He busted!", pID, tostring(hitcard), user[pID].bjdealeractualcount)
									InputConsole("ppage %d You win %d credits! Congratulations!", pID, user[pID].bjplayerbet)
                                		       			Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
									InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
								else
									InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d.", pID, tostring(hitcard), user[pID].bjdealeractualcount)
									if user[pID].bjdealeractualcount >= 17 then
										InputConsole("ppage %d Dealer stands.", pID)
										if user[pID].bjdealeractualcount > user[pID].bjplayeractualcount then
											user[pID].BlackJack = "No"
											tcl = tcl + user[pID].bjplayerbet
											InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
											InputConsole("ppage %d Your total card count was %d and the dealers was %d. You lose :(", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
											InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
										elseif user[pID].bjdealeractualcount < user[pID].bjplayeractualcount then
											tcw = tcw + user[pID].bjplayerbet
											InputConsole("ppage %d Your total card count was %d and the dealers was %d. You win!!!!! :D", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
											InputConsole("ppage %d You win %d credits!!! Congratulations!", pID, user[pID].bjplayerbet)
											user[pID].BlackJack = "No"
											InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
                        	      				   	    		Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
										elseif user[pID].bjdealeractualcount == user[pID].bjplayeractualcount then
											InputConsole("ppage %d Your total card count was %d and the dealers was %d.", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
											InputConsole("ppage %d You push.. no win or lose! Your bet of %d credits is given back", pID,user[pID].bjplayerbet)
											user[pID].BlackJack = "No"
                        	      				       			Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
										end	
									end
								end
							else
								user[pID].BlackJack = "No"
								tcw = tcw + user[pID].bjplayerbet
								InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d. He busted!", pID, tostring(hitcard), user[pID].bjdealeractualcount)
								InputConsole("ppage %d You win %d credits! Congratulations!", pID, user[pID].bjplayerbet)
                                		       		Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
								InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
							end
						else
							if user[pID].bjdealeractualcount > 21 then
									user[pID].BlackJack = "No"
									tcw = tcw + user[pID].bjplayerbet
									InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d. He busted!", pID, tostring(hitcard), user[pID].bjdealeractualcount)
									InputConsole("ppage %d You win %d credits! Congratulations!", pID, user[pID].bjplayerbet)
                                		       			Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
									InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
							else
								InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d.", pID, tostring(hitcard), user[pID].bjdealeractualcount)
								if user[pID].bjdealeractualcount >= 17 then
									InputConsole("ppage %d Dealer stands.", pID)
									if user[pID].bjdealeractualcount > user[pID].bjplayeractualcount then
										user[pID].BlackJack = "No"
										tcl = tcl + user[pID].bjplayerbet
										InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
										InputConsole("ppage %d Your total card count was %d and the dealers was %d. You lose :(", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
										InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
									elseif user[pID].bjdealeractualcount < user[pID].bjplayeractualcount then
										InputConsole("ppage %d Your total card count was %d and the dealers was %d. You win!!!!! :D", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
										InputConsole("ppage %d You win %d credits!!! Congratulations!", pID, user[pID].bjplayerbet)
										InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
										tcw = tcw + user[pID].bjplayerbet
										user[pID].BlackJack = "No"
                        	      						Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
									elseif user[pID].bjdealeractualcount == user[pID].bjplayeractualcount then
										InputConsole("ppage %d Your total card count was %d and the dealers was %d.", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
										InputConsole("ppage %d You push.. no win or lose! Your bet of %d credits is given back", pID,user[pID].bjplayerbet)
										user[pID].BlackJack = "No"
                        	      				       		Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
									end
								end
							end
						end
					else
						InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d.", pID, tostring(hitcard), user[pID].bjdealeractualcount)
						if user[pID].bjdealeractualcount >= 17 then
							InputConsole("ppage %d Dealer stands.", pID)
							if user[pID].bjdealeractualcount > user[pID].bjplayeractualcount then
								user[pID].BlackJack = "No"
								tcl = tcl + user[pID].bjplayerbet
								InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
								InputConsole("ppage %d Your total card count was %d and the dealers was %d. You lose :(", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
								InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
							elseif user[pID].bjdealeractualcount < user[pID].bjplayeractualcount then
								InputConsole("ppage %d Your total card count was %d and the dealers was %d. You win!!!!! :D", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
								InputConsole("ppage %d You win %d credits!!! Congratulations!", pID, user[pID].bjplayerbet)
								tcw = tcw + user[pID].bjplayerbet
								InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
								user[pID].BlackJack = "No"
                        	      				Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
							elseif user[pID].bjdealeractualcount == user[pID].bjplayeractualcount then
								InputConsole("ppage %d Your total card count was %d and the dealers was %d.", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
								InputConsole("ppage %d You push.. no win or lose! Your bet of %d credits is given back", pID,user[pID].bjplayerbet)
								user[pID].BlackJack = "No"
                        	      				Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
							end
						end
					end
				elseif hitcard == "A" then
					if user[pID].bjdealeracecount >= 1 then
						user[pID].bjdealeractualcount = user[pID].bjdealeractualcount + 1
						user[pID].bjdealeracecount = user[pID].bjdealeracecount + 1

						if user[pID].bjdealeractualcount > 21 then
							user[pID].BlackJack = "No"
							tcw = tcw + user[pID].bjplayerbet
							InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d. He busted!", pID, tostring(hitcard), user[pID].bjdealeractualcount)
							InputConsole("ppage %d You win %d credits! Congratulations!", pID, user[pID].bjplayerbet)
                                		       	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
							InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
						else
							InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d.", pID, tostring(hitcard), user[pID].bjdealeractualcount)
							if user[pID].bjdealeractualcount >= 17 then
								InputConsole("ppage %d Dealer stands.", pID)
								if user[pID].bjdealeractualcount > user[pID].bjplayeractualcount then
									user[pID].BlackJack = "No"
									tcl = tcl + user[pID].bjplayerbet
									InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
									InputConsole("ppage %d Your total card count was %d and the dealers was %d. You lose :(", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
									InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
								elseif user[pID].bjdealeractualcount < user[pID].bjplayeractualcount then
									tcw = tcw + user[pID].bjplayerbet
									InputConsole("ppage %d Your total card count was %d and the dealers was %d. You win!!!!! :D", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
									InputConsole("ppage %d You win %d credits!!! Congratulations!", pID, user[pID].bjplayerbet)
									InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
									user[pID].BlackJack = "No"
                        	      				       	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
								elseif user[pID].bjdealeractualcount == user[pID].bjplayeractualcount then
									InputConsole("ppage %d Your total card count was %d and the dealers was %d.", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
									InputConsole("ppage %d You push.. no win or lose! Your bet of %d credits is given back", pID,user[pID].bjplayerbet)
									user[pID].BlackJack = "No"
                        	      				       	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
								end
							end
						end
					elseif user[pID].bjdealeracecount < 1 then
						user[pID].dealerhandsoft = "Yes"
						user[pID].bjdealeractualcount = user[pID].bjdealeractualcount + 11
						user[pID].bjdealeracecount = user[pID].bjdealeracecount + 1
						if user[pID].bjdealeractualcount > 21 then
							user[pID].bjdealeractualcount = user[pID].bjdealeractualcount - 11
							user[pID].bjdealeractualcount = user[pID].bjdealeractualcount + 1
							user[pID].dealerhandsoft = "No"
							if user[pID].bjdealeractualcount > 21 then
								user[pID].BlackJack = "No"
								tcw = tcw + user[pID].bjplayerbet
								InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d. He busted!", pID, tostring(hitcard), user[pID].bjdealeractualcount)
								InputConsole("ppage %d You win %d credits! Congratulations!", pID, user[pID].bjplayerbet)
								InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
                                			       	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
							else
								InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d.", pID, tostring(hitcard), user[pID].bjdealeractualcount)
								if user[pID].bjdealeractualcount >= 17 then
									InputConsole("ppage %d Dealer stands.", pID)
									if user[pID].bjdealeractualcount > user[pID].bjplayeractualcount then
										user[pID].BlackJack = "No"
										tcl = tcl + user[pID].bjplayerbet
										InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
										InputConsole("ppage %d Your total card count was %d and the dealers was %d. You lose :(", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
										InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
 
									elseif user[pID].bjdealeractualcount < user[pID].bjplayeractualcount then
										tcw = tcw + user[pID].bjplayerbet
										InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
										InputConsole("ppage %d Your total card count was %d and the dealers was %d. You win!!!!! :D", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
										InputConsole("ppage %d You win %d credits!!! Congratulations!", pID, user[pID].bjplayerbet)
										user[pID].BlackJack = "No"
                        	      					       	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
									elseif user[pID].bjdealeractualcount == user[pID].bjplayeractualcount then
										InputConsole("ppage %d Your total card count was %d and the dealers was %d.", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
										InputConsole("ppage %d You push.. no win or lose! Your bet of %d credits is given back", pID,user[pID].bjplayerbet)
										user[pID].BlackJack = "No"
                        	      				       		Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
									end
								end
							end
						else
							InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d.", pID, tostring(hitcard), user[pID].bjdealeractualcount)
							if user[pID].bjdealeractualcount >= 17 then
								InputConsole("ppage %d Dealer stands.", pID)
								if user[pID].bjdealeractualcount > user[pID].bjplayeractualcount then
									user[pID].BlackJack = "No"
									tcl = tcl + user[pID].bjplayerbet
									InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
									InputConsole("ppage %d Your total card count was %d and the dealers was %d. You lose :(", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
									InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
								elseif user[pID].bjdealeractualcount < user[pID].bjplayeractualcount then
									InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
									InputConsole("ppage %d Your total card count was %d and the dealers was %d. You win!!!!! :D", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
									InputConsole("ppage %d You win %d credits!!! Congratulations!", pID, user[pID].bjplayerbet)
									tcw = tcw + user[pID].bjplayerbet
									user[pID].BlackJack = "No"
                        	      				      	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
								elseif user[pID].bjdealeractualcount == user[pID].bjplayeractualcount then
									InputConsole("ppage %d Your total card count was %d and the dealers was %d.", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
									InputConsole("ppage %d You push.. no win or lose! Your bet of %d credits is given back", pID,user[pID].bjplayerbet)
									user[pID].BlackJack = "No"
                        	      				       	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
								end
							end
						end
					end
				elseif hitcard <= 9 then
					user[pID].bjdealeractualcount = user[pID].bjdealeractualcount + hitcard





					if user[pID].bjdealeractualcount > 21 then
						if user[pID].bjdealeracecount > 0 then
							if user[pID].dealerhandsoft == "Yes" then
								user[pID].dealerhandsoft = "No"
								user[pID].bjdealeractualcount = user[pID].bjdealeractualcount - 11
								user[pID].bjdealeractualcount = user[pID].bjdealeractualcount + 1
								if user[pID].bjdealeractualcount > 21 then
									user[pID].BlackJack = "No"
									tcw = tcw + user[pID].bjplayerbet
									InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
									InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d. He busted!", pID, tostring(hitcard), user[pID].bjdealeractualcount)
									InputConsole("ppage %d You win %d credits! Congratulations!", pID, user[pID].bjplayerbet)
                                		       			Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
								else
									InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d.", pID, tostring(hitcard), user[pID].bjdealeractualcount)
									if user[pID].bjdealeractualcount >= 17 then
										InputConsole("ppage %d Dealer stands.", pID)
										if user[pID].bjdealeractualcount > user[pID].bjplayeractualcount then
											user[pID].BlackJack = "No"
											tcl = tcl + user[pID].bjplayerbet
											InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
											InputConsole("ppage %d Your total card count was %d and the dealers was %d. You lose :(", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
											InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
										elseif user[pID].bjdealeractualcount < user[pID].bjplayeractualcount then
											InputConsole("ppage %d Your total card count was %d and the dealers was %d. You win!!!!! :D", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
											InputConsole("ppage %d You win %d credits!!! Congratulations!", pID, user[pID].bjplayerbet)
											user[pID].BlackJack = "No"
											tcw = tcw + user[pID].bjplayerbet
											InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
                        	      				   	    		Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
										elseif user[pID].bjdealeractualcount == user[pID].bjplayeractualcount then
											InputConsole("ppage %d Your total card count was %d and the dealers was %d.", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
											InputConsole("ppage %d You push.. no win or lose! Your bet of %d credits is given back", pID,user[pID].bjplayerbet)
											user[pID].BlackJack = "No"
                        	      				       			Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
										end	
									end
								end
							else
								user[pID].BlackJack = "No"
								tcw = tcw + user[pID].bjplayerbet
								InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d. He busted!", pID, tostring(hitcard), user[pID].bjdealeractualcount)
								InputConsole("ppage %d You win %d credits! Congratulations!", pID, user[pID].bjplayerbet)
                                		       		Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
								InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
							end
						else
							if user[pID].bjdealeractualcount > 21 then
								user[pID].BlackJack = "No"
								tcw = tcw + user[pID].bjplayerbet
								InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d. He busted!", pID, tostring(hitcard), user[pID].bjdealeractualcount)
								InputConsole("ppage %d You win %d credits! Congratulations!", pID, user[pID].bjplayerbet)
								InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
                                		       		Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
							else
								if user[pID].bjdealeractualcount >= 17 then
									InputConsole("ppage %d Dealer stands.", pID)
									if user[pID].bjdealeractualcount > user[pID].bjplayeractualcount then
										user[pID].BlackJack = "No"
										tcl = tcl + user[pID].bjplayerbet
										InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
										InputConsole("ppage %d Your total card count was %d and the dealers was %d. You lose :(", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
										InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
									elseif user[pID].bjdealeractualcount < user[pID].bjplayeractualcount then
										InputConsole("ppage %d Your total card count was %d and the dealers was %d. You win!!!!! :D", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
										InputConsole("ppage %d You win %d credits!!! Congratulations!", pID, user[pID].bjplayerbet)
										InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
										user[pID].BlackJack = "No"
										tcw = tcw + user[pID].bjplayerbet
                        	      						Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
									elseif user[pID].bjdealeractualcount == user[pID].bjplayeractualcount then
										InputConsole("ppage %d Your total card count was %d and the dealers was %d.", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
										InputConsole("ppage %d You push.. no win or lose! Your bet of %d credits is given back", pID,user[pID].bjplayerbet)
										user[pID].BlackJack = "No"
                        	      				       		Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
									end
								end
							end
						end
					else
						if user[pID].bjdealeractualcount > 21 then
							user[pID].BlackJack = "No"
							tcw = tcw + user[pID].bjplayerbet
							InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d. He busted!", pID, tostring(hitcard), user[pID].bjdealeractualcount)
							InputConsole("ppage %d You win %d credits! Congratulations!", pID, user[pID].bjplayerbet)
							InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
                                		       	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
						else
							InputConsole("ppage %d The dealer hits and receives a %s for a total count of %d.", pID, tostring(hitcard), user[pID].bjdealeractualcount)
							if user[pID].bjdealeractualcount >= 17 then
								InputConsole("ppage %d Dealer stands.", pID)
								if user[pID].bjdealeractualcount > user[pID].bjplayeractualcount then
									user[pID].BlackJack = "No"
									tcl = tcl + user[pID].bjplayerbet
									InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
									InputConsole("ppage %d Your total card count was %d and the dealers was %d. You lose :(", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
									InputConsole("ppage %d You lost %d credits", pID, user[pID].bjplayerbet)
								elseif user[pID].bjdealeractualcount < user[pID].bjplayeractualcount then
									InputConsole("msg %s just won %d credits playing blackjack :D ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
									InputConsole("ppage %d Your total card count was %d and the dealers was %d. You win!!!!! :D", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
									InputConsole("ppage %d You win %d credits!!! Congratulations!", pID, user[pID].bjplayerbet)
									user[pID].BlackJack = "No"
									tcw = tcw + user[pID].bjplayerbet
                        	      				       	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet*2)
								elseif user[pID].bjdealeractualcount == user[pID].bjplayeractualcount then
									InputConsole("ppage %d Your total card count was %d and the dealers was %d.", pID, user[pID].bjplayeractualcount, user[pID].bjdealeractualcount)
									InputConsole("ppage %d You push.. no win or lose! Your bet of %d credits is given back", pID,user[pID].bjplayerbet)
									user[pID].BlackJack = "No"
                        	      				       	Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
								end
							end
						end
					end
				end
			end
		else
			InputConsole("ppage %d Error. No blackjack game for you found. Try !blackjack <bet> to start a game.", pID)
		end
		return 1
	end
	if Message[1] == "!blackjack" then
      		if user[pID]:HasAccess(1) then
			if user[pID].BlackJack == "Yes" then
				InputConsole("ppage %d Error. You must already be playing blackjack. Type !mycards to see the current game.", pID)
			else

                		bet = tonumber(Message[2])

 				if bet == nil then
                     	        	InputConsole("ppage %d Error. Your bet must be a number. Try !blackjack <number> to bet.", pID)
                        	elseif bet < 0 then
                                	InputConsole("ppage %d You cannot bet a negative number.", pID)
                        	elseif bet > Get_Money(pID)*0.5 then
                                	InputConsole("ppage %d You can only bet up to half of your current credits.", pID)
                       		elseif bet > 10000 then
                                	InputConsole("ppage %d You can only bet up to 10,000 credits. Subject to change.", pID)
				elseif bet < 1000 then
					InputConsole("ppage %d You need to bet at least 1000 credits. Subject to change.", pID)
				else
		if tcg == nil and tcw == nil and tcl == nil and tbjh == nil and tpbj == nil and tdbj == nil then
			tcg = 0
			tcw = 0 
			tcl = 0
			tbjh = 0
			tpbj = 0 
			tdbj = 0
		end
					user[pID].BlackJack = "Yes"
					tbjh = tbjh + 1
					tcg = tcg + bet
					user[pID].bjdealeractualcount = 0
					user[pID].bjplayeractualcount = 0
					user[pID].bjdealeracecount = 0
					user[pID].bjplayeracecount = 0
					user[pID].dealerhandsoft = "No"
					user[pID].playerhandsoft = "No"	

					user[pID].bjplayercard1 = 0
					user[pID].bjplayercard2 = 0
					user[pID].bjdealercard1 = 0
					user[pID].bjdealercard2 = 0

					user[pID].bjplayerbet = bet
                                	InputConsole("ppage %d Your bet of %d has been taken from you, please finish your hand.", pID, bet)
                        	  	Set_Money(pID, Get_Money(pID)-bet)

					--cards = { "2", "3", "4", "5", "6", "7", "8", "9", "Jack", "Queen", "King", "Ace" }
					--suits = { "1", "2", "3", "4" }
					--decks = 4

					--dealing the cards
					cards = math.random(2,14)
					dealercard1 = math.random(2,14)
					dealercard2 = math.random(2,14)
					dealersoftcount = 0
					dealerhardcount = 0
					dealeracecount = 0



					-- Converting to facecards
					if dealercard1 == 11 then
						dealercard1 = "J"
					elseif dealercard1 == 12 then
						dealercard1 = "Q"	
					elseif dealercard1 == 13 then
						dealercard1 = "K"
					elseif dealercard1 == 14 then
						dealercard1 = "A"	
					end	
					if dealercard2 == 11 then
						dealercard2 = "J"
					elseif dealercard2 == 12 then
						dealercard2 = "Q"	
					elseif dealercard2 == 13 then
						dealercard2 = "K"
					elseif dealercard2 == 14 then
						dealercard2 = "A"	
					end	
					--
				
		
					--DEALER checking for blackjack / counting cards dealer

					--SOFT COUNT DEALER
					--first card
					if dealercard1 == "J" or dealercard1 == 10 or dealercard1 == "Q" or dealercard1 == "K" then
						dealersoftcount = dealersoftcount + 10
					elseif dealercard1 == "A" then
						dealeracecount = dealeracecount + 1
						dealersoftcount = dealersoftcount + 11
					elseif dealercard1 <= 9 then
						dealersoftcount = dealersoftcount + dealercard1
					end
					--second card
					if dealercard2 == "J" or dealercard2 == 10 or dealercard2 == "Q" or dealercard2 == "K" then
						dealersoftcount = dealersoftcount + 10
					elseif dealercard2 == "A" then
						dealeracecount = dealeracecount + 1
						dealersoftcount = dealersoftcount + 11
					elseif dealercard2 <= 9 then
						dealersoftcount = dealersoftcount + dealercard2
					end


					--HARD COUNT DEALER
					--first card
					if dealercard1 == "J" or dealercard1 == 10 or dealercard1 == "Q" or dealercard1 == "K" then
						dealerhardcount = dealerhardcount + 10
					elseif dealercard1 == "A" then
						dealerhardcount = dealerhardcount + 1
					elseif dealercard1 <= 9 then
						dealerhardcount = dealerhardcount + dealercard1
					end
					--second card
					if dealercard2 == "J" or dealercard2 == 10 or dealercard2 == "Q" or dealercard2 == "K" then
						dealerhardcount = dealerhardcount + 10
					elseif dealercard2 == "A" then
						dealerhardcount = dealerhardcount + 1
					elseif dealercard2 <= 9 then
						dealerhardcount = dealerhardcount + dealercard2
					end
					
				
					--which count for the dealer
					if dealeracecount > 1 then
						dealeractualcount = dealerhardcount
						user[pID].dealerhandsoft = "No"
					elseif dealeracecount == 1 then
						dealeractualcount = dealersoftcount
						user[pID].dealerhandsoft = "Yes"
					elseif dealeracecount == 0 then
						dealeractualcount = dealersoftcount
						user[pID].dealerhandsoft = "No"
					end

	



					--DEALING PLAYER CARDS
					playercard1 = math.random(2,14)
					playercard2 = math.random(2,14)
					useroftcount = 0
					playerhardcount = 0
					playeracecount = 0
	


					-- Converting to facecards
					if playercard1 == 11 then
						playercard1 = "J"
					elseif playercard1 == 12 then
						playercard1 = "Q"	
					elseif playercard1 == 13 then
						playercard1 = "K"
					elseif playercard1 == 14 then
						playercard1 = "A"	
					end	

					if playercard2 == 11 then
						playercard2 = "J"
					elseif playercard2 == 12 then
						playercard2 = "Q"	
					elseif playercard2 == 13 then
						playercard2 = "K"
					elseif playercard2 == 14 then
						playercard2 = "A"	
					end	



					--SOFT COUNT PLAYER
					--PLAYER checking for blackjack / counting cards player
					--first card
					if playercard1 == "J" or playercard1 == 10 or playercard1 == "Q" or playercard1 == "K" then
						useroftcount = useroftcount + 10
					elseif playercard1 == "A" then
						useroftcount = useroftcount + 11
						playeracecount = playeracecount + 1
					elseif playercard1 <= 9 then
						useroftcount = useroftcount + playercard1
					end
					--second card
					if playercard2 == "J" or playercard2 == 10 or playercard2 == "Q" or playercard2 == "K" then
						useroftcount = useroftcount + 10
					elseif playercard2 == "A" then
						useroftcount = useroftcount + 11
						playeracecount = playeracecount + 1
					elseif playercard2 <= 9 then
						useroftcount = useroftcount + playercard2
					end


					--HARD COUNT PLAYER
					--first card
					if playercard1 == "J" or playercard1 == 10 or playercard1 == "Q" or playercard1 == "K" then
						playerhardcount = playerhardcount + 10
					elseif playercard1 == "A" then
						playerhardcount = playerhardcount + 1
					elseif playercard1 <= 9 then
						playerhardcount = playerhardcount + playercard1
					end
					--second card
					if playercard2 == "J" or playercard2 == 10 or playercard2 == "Q" or playercard2 == "K" then
						playerhardcount = playerhardcount + 10
					elseif playercard2 == "A" then
						playerhardcount = playerhardcount + 1
					elseif playercard2 <= 9 then
						playerhardcount = playerhardcount + playercard2
					end







					--which count for the player


					if playeracecount > 1 then
						playeractualcount = playerhardcount
						user[pID].playerhandsoft = "No"
					elseif playeracecount == 1 then
						playeractualcount = useroftcount
						user[pID].playerhandsoft = "Yes"
					elseif playeracecount == 0 then
						playeractualcount = useroftcount
						user[pID].playerhandsoft = "No"
					end





					if dealeractualcount == 21 then
						if playeractualcount ~= 21 then
							InputConsole("ppage %d Dealer's cards are %s %s", pID, tostring(dealercard1), tostring(dealercard2))
							InputConsole("ppage %d Your cards are %s %s", pID, tostring(playercard1), tostring(playercard2))
							InputConsole("ppage %d Dealer has blackjack! You lose :( Try again!", pID)
							InputConsole("msg %s just lost %d credits playing blackjack :( ",Get_Player_Name_By_ID(pID), user[pID].bjplayerbet)
							user[pID].BlackJack = "No"
							tdbj = tdbj + 1
							tcl = tcl + user[pID].bjplayerbet
						else
							InputConsole("ppage %d Dealer's cards are %s %s", pID, tostring(dealercard1), tostring(dealercard2))
							InputConsole("ppage %d Your cards are %s %s", pID, tostring(playercard1), tostring(playercard2))
							InputConsole("ppage %d You both have blackjack! You push.. no win or lose!", pID)
							user[pID].BlackJack = "No"
							tdbj = tdbj + 1
							tpbj = tpbj + 1
                        	      			Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
						end
					end
					if playeractualcount == 21 then
						if dealeractualcount ~= 21 then
							blackjackwinnings = bet+bet*1.5
							InputConsole("ppage %d Dealer's cards are %s %s", pID, tostring(dealercard1), tostring(dealercard2))
							InputConsole("ppage %d Your cards are %s %s", pID, tostring(playercard1), tostring(playercard2))
							InputConsole("ppage %d You have blackjack! You win 1.5 X your bet, which is %d credits!!! Congratulations!", pID, blackjackwinnings)
							InputConsole("msg %s just got a blackjack and is awarded %d credits!!!!",Get_Player_Name_By_ID(pID), blackjackwinnings)
							user[pID].BlackJack = "No"
                                	       		Set_Money(pID, Get_Money(pID)+blackjackwinnings)
							tcw = tcw + bet + bet*0.5
							tpbj = tpbj + 1
						else
							InputConsole("ppage %d Dealer's cards are %s %s", pID, tostring(dealercard1), tostring(dealercard2))
							InputConsole("ppage %d Your cards are %s %s", pID, tostring(playercard1), tostring(playercard2))
							InputConsole("ppage %d You both have blackjack! You push.. no win or lose!", pID)
							user[pID].BlackJack = "No"
							tdbj = tdbj + 1
							tpbj = tpbj + 1
                        	      			Set_Money(pID, Get_Money(pID)+user[pID].bjplayerbet)
						end
					elseif playeractualcount < 21 and dealeractualcount ~= 21 then
						user[pID].bjdealeractualcount = dealeractualcount
						user[pID].bjplayeractualcount = playeractualcount
						user[pID].bjdealeracecount = dealeracecount
						user[pID].bjplayeracecount = playeracecount

						user[pID].bjplayercard1 = playercard1
						user[pID].bjplayercard2 = playercard2
						user[pID].bjdealercard1 = dealercard1
						user[pID].bjdealercard2 = dealercard2
						InputConsole("ppage %d Dealer's cards are %s X", pID, tostring(dealercard1))
						InputConsole("ppage %d Your cards are %s %s .. Would you like to !hit or !stay ?", pID, tostring(playercard1), tostring(playercard2))

					end

					
								


				--dealer msgs
				--InputConsole("ppage %d Dealer's cards are %s X", pID, tostring(dealercard1))
				--InputConsole("ppage %d Test. Dealer softcount is %d", pID, dealersoftcount)
				--InputConsole("ppage %d Test. Dealer hardcount is %d", pID, dealerhardcount)
				--InputConsole("ppage %d Test. Dealer acecount is %d", pID, dealeracecount)
				--InputConsole("ppage %d Test. Dealer actualcount is %d", pID, dealeractualcount)
				--player msgs
				--InputConsole("ppage %d Test. Player softcount is %d", pID, useroftcount)
				--InputConsole("ppage %d Test. Player hardcount is %d", pID, playerhardcount)
				--InputConsole("ppage %d Test. Player acecount is %d", pID, playeracecount)
				--InputConsole("ppage %d Test. Player actualcount is %d", pID, playeractualcount)
				--InputConsole("ppage %d Your cards are %s %s", pID, tostring(playercard1), tostring(playercard2))
				



				end                                     
                        end
                else
                        InputConsole("ppage %d You do not have access to this command.", pID)
                end
        end
	
	return false
end

