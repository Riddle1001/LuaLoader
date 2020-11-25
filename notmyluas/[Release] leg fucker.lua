-- Scraped by chicken
-- Author: Eagle
-- Title [Release] leg fucker
-- Forum link https://aimware.net/forum/thread/144904

local slidewalk = "misc.slidewalk"
local last = 0
local state = true

function Draw()
if not legfucker:GetValue() then return end
if globals.CurTime() > last then
state = not state
last = globals.CurTime() + 0.01
gui.SetValue(slidewalk, state and true or false)
end
end

function UI()
    legfucker = gui.Checkbox(gui.Reference("Ragebot","Anti-Aim","Extra"),"legfucker","Leg Fucker", false);
end
UI();

callbacks.Register( "Draw", "Legfucker", Draw );