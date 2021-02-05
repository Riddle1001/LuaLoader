-- Scraped by chicken
-- Author: gayware
-- Title [Release] Health-based HUD color
-- Forum link https://aimware.net/forum/thread/102685

--code by prost
localPlayer = entities.GetLocalPlayer();
-- cl_hud_color values
-- 0: Default
-- 1: White
-- 2: Light Blue
-- 3: Blue
-- 4: Purple
-- 5: Red
-- 6: Orange
-- 7: Yellow
-- 8: Green
-- 9: Aqua
-- 10: Pink
function healthHud()
 if(localPlayer ~= nil) then
 health = entities.GetLocalPlayer():GetHealth();
 if(health > 95) then
 client.Command("cl_hud_color 8", true) -- 8: Green
 elseif(health > 69) then --69 makes your resolver better
 client.Command("cl_hud_color 7", true) -- 7: Yellow
 elseif(health > 39) then
 client.Command("cl_hud_color 6", true) -- 6: Orange
 else
 client.Command("cl_hud_color 5", true)-- 5: Red
end
end
end

callbacks.Register( "Draw", "healthHud", healthHud);





