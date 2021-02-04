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
callbacks.Register("Draw", "force_crosshair_draw", drawing_callback); -- Scraped by chicken
-- Author: zack
-- Title [Release] Sniper Crosshair
-- Forum link https://aimware.net/forum/thread/87874


function on_sniper(Event)    
if (Event:GetName() ~= 'item_equip') then return; end
if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
    if Event:GetString('item') == "awp" or Event:GetString('item') == "ssg08" or Event:GetString('item') == "scar20" or Event:GetString('item') == "g3sg1" then
            drawCrosshair = true
	elseif Event:GetString('item') ~= "awp" and Event:GetString('item') ~= "ssg08" and Event:GetString('item') ~= "scar20" and Event:GetString('item') ~= "g3sg1" then
            drawCrosshair = false
            return;
       end end end 
function ifCrosshair()
local screenCenterX, screenY = draw.GetScreenSize(); scX = screenCenterX / 2; scY = screenY / 2;
if drawCrosshair == true then
		draw.Line(scX, scY - 8, scX, scY + 8);  --line down
		draw.Line(scX - 8, scY, scX + 8, scY); --line across
elseif drawCrosshair == false then 
--HERE--
return
end end
client.AllowListener('item_equip');
callbacks.Register("FireGameEvent", "if on sniper", on_sniper); callbacks.Register("Draw", "sniper crosshairs", ifCrosshair);
