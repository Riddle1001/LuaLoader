-- Scraped by chicken
-- Author: tripped
-- Title [Release] Switch Desync & Manual AA with indicators
-- Forum link https://aimware.net/forum/thread/146452

local guiRef = gui.Reference( "Ragebot", "Anti-Aim", "Advanced" )
local Indicators = gui.Checkbox(guiRef, "indicators_lua", "Indicators", false);
local Inverter_Key = gui.Keybox(guiRef, "inverter_key", "Invert anti-aim", 0)
local Left_Key = gui.Keybox(guiRef, "left_key", "Left manual", 0)
local Right_Key = gui.Keybox(guiRef, "right_key", "Right manual", 0)
local Back_Key = gui.Keybox(guiRef, "back_key", "Back manual", 0)
local font = draw.CreateFont("Verdana", 25, 25)
local font1 = draw.CreateFont("Verdana", 35, 35)
local font2 = draw.CreateFont("Bahnschrift", 13)
local toggled = false
local toggled_left = false
local toggled_right = false
local toggled_back = false

local function keys()

  if Inverter_Key:GetValue() ~= 0 then
    if input.IsButtonPressed(Inverter_Key:GetValue()) then
      toggled = not toggled
    end
  end
  if Left_Key:GetValue() ~= 0 then
    if input.IsButtonPressed(Left_Key:GetValue()) then
      toggled_left = not toggled_left
      toggled_right = false
      toggled_back = false
    end
  end
  if Right_Key:GetValue() ~= 0 then
    if input.IsButtonPressed(Right_Key:GetValue()) then
      toggled_right = not toggled_right
      toggled_left = false
      toggled_back = false
    end
  end
  if Back_Key:GetValue() ~= 0 then
    if input.IsButtonPressed(Back_Key:GetValue()) then
      toggled_back = not toggled_back
      toggled_left = false
      toggled_right = false
    end
  end
end

local function drawHook()
  keys()
end

local function drawIndicators()
  if Indicators:GetValue() then
    if (not toggled_left and not toggled_right and not toggled_back) then
      draw.SetFont(font);
      draw.Color(255, 255, 255, 255);
      draw.Text(953, 600, "V");
      draw.SetFont(font1);
      draw.Color(255, 255, 255, 255);
      draw.Text(885, 527, "<");
      draw.Color(255, 255, 255, 255);
      draw.Text(1015, 527, ">");
    end
    if (toggled_left) then
      draw.SetFont(font);
      draw.Color(255, 255, 255, 255);
      draw.Text(953, 600, "V");
 
      draw.SetFont(font1);
      draw.Color(0, 225, 255, 255);
      draw.Text(885, 527, "<");
 
      draw.Color(255, 255, 255, 255);
      draw.Text(1015, 527, ">");
    end
    if (toggled_right) then
      draw.SetFont(font);
      draw.Color(255, 255, 255, 255);
      draw.Text(953, 600, "V");

      draw.SetFont(font1);
      draw.Color(255, 255, 255, 255);
      draw.Text(885, 527, "<");

      draw.Color(0, 225, 255, 255);
      draw.Text(1015, 527, ">");
    end
    if (toggled_back) then
      draw.SetFont(font);
      draw.Color(0, 225, 255, 255);
      draw.Text(953, 600, "V");
 
      draw.SetFont(font1);
      draw.Color(255, 255, 255, 255);
      draw.Text(885, 527, "<");
 
      draw.Color(255, 255, 255, 255);
      draw.Text(1015, 527, ">");
    end
    if (not toggled) then
      draw.SetFont(font2);
      draw.Color(0, 255, 0, 255);
      draw.Text(945, 570, "LEFT");
    end
    if toggled then
      draw.SetFont(font2);
      draw.Color(0, 255, 0, 255);
      draw.Text(945, 570, "RIGHT");
    end
  end
end

local function createMoveHook(cmd)
    if toggled then
     gui.SetValue("rbot.antiaim.base", -180)
     gui.SetValue("rbot.antiaim.base.rotation", 58)
     gui.SetValue("rbot.antiaim.base.lby", -120)
     else
     gui.SetValue("rbot.antiaim.base", 180)
     gui.SetValue("rbot.antiaim.base.rotation", -58)
     gui.SetValue("rbot.antiaim.base.lby", 120)
  end
     if toggled_left then
    gui.SetValue("rbot.antiaim.base", 110)
   end
   if toggled_right then
    gui.SetValue("rbot.antiaim.base", -110)
   end
   if toggled_back then
    gui.SetValue("rbot.antiaim.base", 180)
   end
end

callbacks.Register("CreateMove", createMoveHook)
callbacks.Register("Draw", drawHook);
callbacks.Register("Draw", drawIndicators);