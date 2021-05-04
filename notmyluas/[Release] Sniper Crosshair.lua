-- Scraped by chicken
-- Author: Envelope
-- Title [Release] Sniper Crosshair
-- Forum link https://aimware.net/forum/thread/128766

local function drawing_callback()

local player_local = entities.GetLocalPlayer();

if player_local == nil then 
 return;
end


local scoped = player_local:GetProp("m_bIsScoped");

if scoped == 1 then
client.SetConVar("weapon_debug_spread_show", 0, true);
end
if scoped == 0 then
client.SetConVar("weapon_debug_spread_show", 1, true);
client.SetConVar("weapon_debug_spread_gap", 5, true);
end
end
callbacks.Register("Draw", "force_crosshair_draw", drawing_callback); 