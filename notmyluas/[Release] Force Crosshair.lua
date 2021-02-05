-- Scraped by chicken
-- Author: D1versantniK
-- Title [Release] Force Crosshair
-- Forum link https://aimware.net/forum/thread/145310

local function forcecrosshair() 
 client.SetConVar("weapon_debug_spread_show", 3, 1);
end
callbacks.Register( "Draw", "forcecrosshair", forcecrosshair);




