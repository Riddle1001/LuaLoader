-- Scraped by chicken
-- Author: iSun
-- Title [Release] [Not working anymore] Animated name reverser
-- Forum link https://aimware.net/forum/thread/131721

local aye = 1
local curutime = globals.CurTime()
local gay = globals.CurTime()

local ref = gui.Reference("Misc", "Enhancement", "Appearance")
local slider = gui.Slider(ref, 'lua_reverser_slider', 'How fast reverse (s)', 1, 0, 10)

local function changename()
    if (entities.GetLocalPlayer() == nil or engine.GetServerIP() == nil or engine.GetMapName() == nil or slider:GetValue() == 0) then return end
    curutime = globals.CurTime()
    if curutime >= gay + slider:GetValue() then
        gay = globals.CurTime()
        if aye == 1 then
            client.Command( "cl_clanid 1593893", true )
            aye = 0
        else
            client.Command( "cl_clanid 0", true )
            aye = 1
        end
        
    else
        curutime = curutime + 1
    end
end
callbacks.Register("Draw", changename)