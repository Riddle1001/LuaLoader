-- Scraped by chicken
-- Author: leexx
-- Title [Release] Disable Desync on fakeduck.
-- Forum link https://aimware.net/forum/thread/118582

local gui_set = gui.SetValue
local gui_get = gui.GetValue
local key = gui.GetValue("rbot_antiaim_fakeduck")
local b_hold = input.IsButtonDown
local b_released = input.IsButtonReleased
local dpi_scale = gui.GetValue("dpi_scale")
local font_main = draw.CreateFont("Tahoma Bold", math.floor(25 * dpi_scale), math.floor(25 * dpi_scale))


function disabledesync()
  
  local w, h = draw.GetScreenSize()

  if b_hold(key) then
   draw.Color(255, 255, 255, 255);
   draw.Text( w / 2, h / 2, DUCK)
   draw.SetFont(font_main)
   draw.Text( 50, h - 464, "DUCK" )
   draw.TextShadow( 50, h - 464, "DUCK" )
   
    gui_set("rbot_antiaim_stand_desync", 0)
    gui_set("rbot_antiaim_move_desync", 0)
    gui_set("rbot_antiaim_autodir", 0)
  end 
  if b_released(key) then
    gui_set("rbot_antiaim_stand_desync", 2)
    gui_set("rbot_antiaim_move_desync", 2)
    gui_set("rbot_antiaim_autodir", 2)
  end
end


callbacks.Register("Draw", "disabledesync", disabledesync)

