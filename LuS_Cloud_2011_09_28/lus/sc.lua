module('sc', package.seeall)

function Save()
	Section = "Lotto"
	
	mf.WriteINI(Config_File, Section, "pot", lotto_total_credits)
	mf.WriteINI(Config_File, Section, "last_time", last_lotto)
	
	if irc ~= nil and irc.IRC_Client ~= -1 then
		msg = irc.ToColor("[Config] Saved.", "03")
		irc.SendMsg(msg)
	end
end

function Load()
	Section = "Bank"

	banklimit = tonumber(mf.ReadINI(Config_File, Section, "limit"))
	interest = tonumber(mf.ReadINI(Config_File, Section, "interest"))
	vipinterest = tonumber(mf.ReadINI(Config_File, Section, "interest_vip"))
	depotax = tonumber(mf.ReadINI(Config_File, Section, "depotax"))
	bank_wait = tonumber(mf.ReadINI(Config_File, Section, "wait_time"))
	
	Section = "Lotto"
	
	loti_price_credit = tonumber(mf.ReadINI(Config_File, Section, "price_credit"))
	loti_price_perc = tonumber(mf.ReadINI(Config_File, Section, "price_percent"))
	lotto_prizes = tonumber(mf.ReadINI(Config_File, Section, "max_prizes"))
	lotto_max_prize = tonumber(mf.ReadINI(Config_File, Section, "max_prize"))
	lotto_wait = tonumber(mf.ReadINI(Config_File, Section, "wait_time"))
	to_lotto = tonumber(mf.ReadINI(Config_File, Section, "loti_to_pot"))
	lotto_limit = tonumber(mf.ReadINI(Config_File, Section, "pot_limit"))
	lotto_total_credits = tonumber(mf.ReadINI(Config_File, Section, "pot"))
	last_lotto = tonumber(mf.ReadINI(Config_File, Section, "last_time"))

	if irc ~= nil and irc.IRC_Client ~= -1 then
		msg = irc.ToColor("[Config] Loaded.", "03")
		irc.SendMsg(msg)
	end
end