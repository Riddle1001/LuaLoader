-- Scraped by chicken
-- Author: AnAnAn
-- Title [Release] AutoWall Key Bind 
-- Forum link https://aimware.net/forum/thread/127003

local An_1 = gui.Reference("RAGE", "MAIN", "Extra")
local Doubletap = gui.Keybox( An_1, "AutowallKey", "AutowallKeyBind", 0 )
local font1 = draw.CreateFont('Verdana', 20, 700)
  function DoubleTapActive()
    if Doubletap:GetValue() ~= 0 then
      if input.IsButtonDown(Doubletap:GetValue()) then
        return true
      else 
      return false
      end
    end
  end
  local function Main()
  w, h = draw.GetScreenSize()
  draw.SetFont(RenderFont)
  draw.Color(112, 255, 0)

    if DoubleTapActive() == true then
      draw.SetFont(font1)
      draw.Text(w/2 - 942, h/2 - 45, "Autowall")
 draw.TextShadow(w/2 - 942, h/2 -45, "Autowall")
      gui.SetValue('rbot_scout_autowall', 2)
      gui.SetValue('rbot_sniper_autowall', 2)
    else
      gui.SetValue('rbot_scout_autowall', 0)
      gui.SetValue('rbot_sniper_autowall', 0)
    end
  end

callbacks.Register( "Draw", "AutowallKey", Main);
------AutowallKey By AnAnAn 
------作者 An QQ 2926669800

