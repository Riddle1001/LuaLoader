-- Scraped by chicken
-- Author: - Luiz
-- Title [Release] [Remake] Default Crosshair on Snipers
-- Forum link https://aimware.net/forum/thread/88377

-- Crosshair on sniper by Nyanpasu!

-- Configuration --
local disable_on_scope = 2; -- 0 for off, 1 for always, 2 for if lines are enabled
-------------------

local function drawing_callback()
    
    local player_local = entities.GetLocalPlayer();
    
    if player_local == nil then
        return;
    end
	
    if disable_on_scope == 0 or 
    ( disable_on_scope == 1 and player_local:GetProp("m_bIsScoped") % 2 == 0 ) or
    ( disable_on_scope == 2 and gui.GetValue("vis_scoperemover") == 1) or
    ( disable_on_scope == 2 and gui.GetValue("vis_scoperemover") ~= 1 and player_local:GetProp("m_bIsScoped") % 2 == 0 ) then
        if client.GetConVar("weapon_debug_spread_show") ~= 3 then -- You just need to set it once and leave it be
            client.SetConVar( "weapon_debug_spread_show", 3, true );
        end
    else
        if client.GetConVar("weapon_debug_spread_show") ~= 0 then -- You just need to set it once and leave it be
            client.SetConVar( "weapon_debug_spread_show", 0, true );
        end    
    end
    
end

-- Crosshair on sniper by Nyanpasu!

callbacks.Register("Draw", "force_crosshair_draw", drawing_callback); -- Calling draw everytime because no one cares