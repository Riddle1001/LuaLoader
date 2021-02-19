-- Scraped by chicken
-- Author: thyrell
-- Title [Release] Bot-only AFK script
-- Forum link https://aimware.net/forum/thread/99630


local function ignoreESP(ESPENT)
 local player=ESPENT:GetEntity()
 if not(entities.GetPlayerResources():GetPropInt("m_iBotDifficulty", player:GetIndex()) > 0) then
 player:SetProp("m_bGunGameImmunity", 1)
 end
end
callbacks.Register("DrawESP", ignoreESP)
