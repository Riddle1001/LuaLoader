-- Scraped by chicken
-- Author: anue
-- Title [Release] Reduce HC/DMG
-- Forum link https://aimware.net/forum/thread/87998

local gui_set = gui.SetValue
local gui_get = gui.GetValue
local c_reg = callbacks.Register
local button_held = input.IsButtonDown

local key = "mouse5"

-- cache old hc/dmg to restore later
local old_hc = gui_get("rbot_shared_hitchance") 
local old_dmg = gui_get("rbot_shared_mindamage")

-- the amount to adjust
local new_hc = 45 
local new_dmg = 5

function reduce()
-- amount to display
local hc = gui_get("rbot_shared_hitchance")
local dmg = gui_get("rbot_shared_mindamage")

 if button_held(key) then
  draw.Color(0,255,0,255);
 draw.Text(10,615, "Accuracy Mode: Reduced")
  
  draw.Color(255,255,255,255)
  draw.Text(10, 630, "Hitchance: " .. math.floor(hc))
  draw.Text(10, 645, "Minimum DMG: " .. math.floor(dmg))
  
  gui_set("rbot_shared_hitchance", new_hc) 
  gui_set("rbot_shared_mindamage", new_dmg) 
  
 else
  draw.Color(255,255,255,255)
 draw.Text(10,615, "Accuracy Mode: Default")
  draw.Color(255,255,255,255)
  
  draw.Text(10, 630, "Hitchance: " .. math.floor(old_hc))
  draw.Text(10, 645, "Minimum DMG: " .. math.floor(old_dmg))
  
  gui_set("rbot_shared_hitchance", old_hc) 
  gui_set("rbot_shared_mindamage", old_dmg) 
 end
end

c_reg("Draw", "reduce", reduce)