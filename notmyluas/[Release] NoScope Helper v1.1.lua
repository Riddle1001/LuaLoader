-- Scraped by chicken
-- Author: RageHvH
-- Title [Release] NoScope Helper v1.1
-- Forum link https://aimware.net/forum/thread/144376

local noscope_gui = gui.Groupbox(gui.Reference("Ragebot", "Accuracy"), "NoScope Helper", 328, 440, 297);
local noscope_slider = gui.Slider(noscope_gui, "Settings", "NoScope HC", 0, 0, 100);
local scoped_slider = gui.Slider(noscope_gui, "Settings", "Scoped HC", 0, 0, 100)

callbacks.Register("Draw", function()

local noscope_damage = noscope_slider:GetValue()
local scoped_damage = scoped_slider:GetValue()

if entities.GetLocalPlayer():GetProp("m_bIsScoped") ~= 256 and entities.GetLocalPlayer():GetProp("m_bIsScoped") ~= 0 then
gui.SetValue("rbot.accuracy.weapon.asniper.doublefirehc", scoped_damage)
else
gui.SetValue("rbot.accuracy.weapon.asniper.doublefirehc", noscope_damage)

end
end)

