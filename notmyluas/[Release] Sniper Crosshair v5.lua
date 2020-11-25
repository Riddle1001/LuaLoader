-- Scraped by chicken
-- Author: stylerzin
-- Title [Release] Sniper Crosshair v5
-- Forum link https://aimware.net/forum/thread/128202

-- Crosshair on sniper by stylerzin! (youtube.com/c/styxhvhchannel)

-- Configuration --
local disable_on_scope = 1; 

local function drawing_callback()
    
    local player_local = entities.GetLocalPlayer();
    
    if player_local == nil then
        return;
    end
    
    if disable_on_scope == 0 or 
    ( disable_on_scope == 1 and player_local:GetProp("m_bIsScoped") % 1 == 0 ) or
    ( disable_on_scope == 2 and gui.GetValue("vis_scoperemover") == 1) or
    ( disable_on_scope == 2 and gui.GetValue("vis_scoperemover") ~= 1 and player_local:GetProp("m_bIsScoped") % 2 == 0 ) then
        if client.GetConVar("weapon_debug_spread_show") ~= 3 then 
            client.SetConVar( "weapon_debug_spread_show", 3, true );
        end
    else
        if client.GetConVar("weapon_debug_spread_show") ~= 0 then 
            client.SetConVar( "weapon_debug_spread_show", 0, true );
        end    
    end
    
end

-- Crosshair on sniper by stylerzin! (youtube.com/c/styxhvhchannel)

callbacks.Register("Draw", "force_crosshair_draw", drawing_callback);