-- Scraped by chicken
-- Author: BQJ
-- Title [Release] Ragdoll Editor
-- Forum link https://aimware.net/forum/thread/145833

local wnd = gui.Reference("Misc")
local cvar_tab = gui.Tab(wnd, "con", "Cvars")
gui.Groupbox(cvar_tab, "Ragdoll Physics", 10, 10, 300)
gui.Groupbox(cvar_tab, "Visual", 320, 10, 300)
local wnd_phys = gui.Reference("Misc", "cvars", "Ragdoll Physics")
local wnd_vis = gui.Reference("Misc", "cvars", "Visual")

local gravity_slider = gui.Slider(wnd_phys, "gravity_slider", "Gravity (default: 60)", 60, -120, 120)
local speed_slider = gui.Slider(wnd_phys, "speed_slider", "Speed (default: 10)", 10, 0, 100)
local headshot_slider = gui.Slider(wnd_phys, "headshot_slider", "Headshot Push Scale (default: 13)", 13, -100, 100)
local push_slider = gui.Slider(wnd_phys, "push_slider", "Push Scale Multiplier (default: 1)", 1, -100, 100)
local impact_checkbox = gui.Checkbox(wnd_vis, "impact_checkbox", "Show Bullet Impacts", false)

local function OnDraw()

if client.GetConVar("sv_cheats") == "1" then
client.Command("cl_ragdoll_gravity " .. gravity_slider:GetValue()*10, true)
client.Command("cl_phys_timescale " .. speed_slider:GetValue()/10, true)
client.SetConVar("phys_headshotscale", headshot_slider:GetValue()/10, true) client.SetConVar("phys_pushscale", push_slider:GetValue(), true)

if impact_checkbox:GetValue() == true then
client.SetConVar("sv_showbullethits", 1, true)
else
client.SetConVar("sv_showbullethits", 0, true)

end
end
end

callbacks.Register("Draw", OnDraw)
