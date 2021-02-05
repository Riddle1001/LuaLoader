-- Scraped by chicken
-- Author: Scape
-- Title [Release] Much Better Money Esp
-- Forum link https://aimware.net/forum/thread/134440

local function moneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeey(please)
	local cardHolder = please:GetEntity();
	
	if cardHolder:IsPlayer() and cardHolder:GetTeamNUmber() ~= entities.GetLocalPlayer():GetTeamNumber()then
		local molah = cardHolder:GetProp("m_iAccount");
		local bettermoneystringthatwontlagyouatall = ""	;
		
		for eye = 1, molah, 1 do
			bettermoneystringthatwontlagyouatall = bettermoneystringthatwontlagyouatall.."|"
		end
		
		please:AddTextTop(bettermoneystringthatwontlagyouatall);
	end
end 

callbacks.Register("DrawESP", moneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeey);
