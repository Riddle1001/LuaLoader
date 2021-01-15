-- Scraped by chicken
-- Author: anue
-- Title [Release] Disable Autostrafer
-- Forum link https://aimware.net/forum/thread/88598

local gui_set = gui.SetValue
local gui_get = gui.GetValue
local c_reg = callbacks.Register
local b_down = input.IsButtonDown

local key = 16 -- Shift

function disableStrafe()
 if b_down(key) then
  gui_set("msc_autostrafer_enable", false)
 else
  gui_set("msc_autostrafer_enable", true)
 end
end

c_reg("Draw", "disableStrafe", disableStrafe)