-- Scraped by chicken
-- Author: corh
-- Title [Release] lua (INVERTER, ANTI-KNIFE,FD AA&FL FIX)
-- Forum link https://aimware.net/forum/thread/110144

local set = gui.SetValue
local button = input.IsButtonDown
callbacks.Register("Draw", function()
	set("msc_autostrafer_wasd", 1)

	if button(65) or button(68) or button(83) or button(87) then
		set("msc_autostrafer_enable", 1)
	else
		set("msc_autostrafer_enable", 0)
	end
end)