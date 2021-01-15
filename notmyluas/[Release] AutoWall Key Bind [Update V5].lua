-- Scraped by chicken
-- Author: AnAnAn
-- Title [Release] AutoWall Key Bind [Update V5]
-- Forum link https://aimware.net/forum/thread/128440

local An = gui.Reference("Ragebot", "aimbot","Extra");
local Wall = gui.Keybox(An, "AutoWallKeyKeybind", "AutoWall KeyKey Bind", 69);

function AutoWall()

  local font = draw.CreateFont("Verdana", 20, 700)
  draw.SetFont(font)
  w, h = draw.GetScreenSize()
  if input.IsButtonDown(Wall:GetValue()) then
    gui.SetValue( "rbot.hitscan.mode.scout.autowall", 1);
    gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 1);
    draw.Color(112, 255, 0)
    draw.Text(18, h - 447, "Auto Wall")
    draw.TextShadow(18, h - 447, "Auto Wall")
  else
    gui.SetValue( "rbot.hitscan.mode.scout.autowall", 0);
    gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 0);
    draw.Color(255, 0, 0)
    draw.Text(18, h - 447, "Auto Wall")
    draw.TextShadow(18, h - 447, "Auto Wall")
  end

end

callbacks.Register('Draw', 'AutoWallKeyKeybind', AutoWall);
--By An
--QQ 2926669800