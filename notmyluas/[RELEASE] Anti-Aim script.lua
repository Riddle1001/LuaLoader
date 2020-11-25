-- Scraped by chicken
-- Author: picocode
-- Title [RELEASE] Anti-Aim script
-- Forum link https://aimware.net/forum/thread/130122

local RotationJitter = 10
local LBYJitter = 1

local MENU = gui.Tab(gui.Reference("Ragebot"), "aa.settings", "PICOCODE AA")

local Jitter1 = gui.Slider(MENU, "first_jitter", "First Jitter", 0, -58, 58)
local Jitter2 = gui.Slider(MENU, "second_jitter", "Second Jitter", 0, -58, 58)
local LBYJitter1 = gui.Slider(MENU, "first_LBYjitter", "First LBY Jitter", 0, -180, 180)
local LBYJitter2 = gui.Slider(MENU, "second_LBYjitter", "Second LBY Jitter", 0, -180, 180)

function JitterOffset()
    if (RotationJitter == 10) then
        gui.SetValue("rbot.antiaim.base.rotation", Jitter1:GetValue())
        RotationJitter = 11
    elseif (RotationJitter == 11) then
        gui.SetValue("rbot.antiaim.base.rotation", Jitter2:GetValue())
        RotationJitter = 10
        end
end
function LBY()
    if (LBYJitter == 1) then
        gui.SetValue("rbot.antiaim.base.lby", LBYJitter1:GetValue())
        LBYJitter = 0
    elseif (LBYJitter == 0) then
        gui.SetValue("rbot.antiaim.base.lby", LBYJitter2:GetValue())
        LBYJitter = 1
        end
end

callbacks.Register("Draw", LBY)
callbacks.Register("Draw", JitterOffset)