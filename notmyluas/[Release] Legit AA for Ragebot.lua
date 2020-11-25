-- Scraped by chicken
-- Author: helloabcdf123
-- Title [Release] Legit AA for Ragebot
-- Forum link https://aimware.net/forum/thread/140319


local ref = gui.Reference("Ragebot", "Anti-aim", "Anti-aim")
local chk = gui.Checkbox(ref, "chk_legitaa", "Legit Anti-aim", false)
local kb = gui.Keybox(ref, "kb_invert_legitaa", "Invert Legit Anti-aim", 0)
local arrows = gui.Checkbox(ref, "chk_arrows", "Indicator Arrows", false)
local clr_arrows = gui.ColorPicker(arrows, "clr_arrows", "", 90, 80, 185, 255)

local w, h = draw.GetScreenSize()
local midW, midH = w/2, h/2

local arrowFnt = draw.CreateFont("Tahoma", 32, 3000)

local inverted = false

callbacks.Register("Draw", function()
local lp = entities.GetLocalPlayer()
if not lp then return end
if not lp:IsAlive() then return end

if kb:GetValue() ~= 0 then
if input.IsButtonPressed(kb:GetValue()) then
inverted = not inverted
end
end

if chk:GetValue() then
gui.SetValue("rbot.antiaim.yawfakestyle", inverted and 2 or 1)
gui.SetValue("rbot.antiaim.autodir", 0)
gui.SetValue("rbot.antiaim.yawstyle", 0)
gui.SetValue("rbot.antiaim.pitchstyle", 0)

if arrows:GetValue() then
if inverted then
draw.Color(255, 255, 255, 255)
else
draw.Color(clr_arrows:GetValue())
end
draw.SetFont(arrowFnt)
draw.Text(midW-60, midH, "<")
if inverted then
draw.Color(clr_arrows:GetValue())
else
draw.Color(255, 255, 255, 255)
end
draw.Text(midW+60, midH, ">")
end
end
end)

