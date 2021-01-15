-- Scraped by chicken
-- Author: zestrilluxe
-- Title [Release] legit aimbot on certain weapons
-- Forum link https://aimware.net/forum/thread/103878

function LegitOof()
  local lp = entities.GetLocalPlayer();

  if(lp == nil) then
    return;
  end

  local weapontype = lp:GetWeaponType();

  if(weapontype == 2 or weapontype == 3) then
    gui.SetValue("lbot_enable", 1);
  else
    gui.SetValue("lbot_enable", 0);
  end

  local i = draw.CreateFont("Tahoma", 24, 750);
  draw.SetFont(i);

  if(gui.GetValue("lbot_enable")) then
    draw.Color(50, 205, 50, 200);
  else
    draw.Color(220, 0, 0, 200);
  end
  draw.TextShadow(7, 1000, "AIMBOT");
end

callbacks.Register("Draw", "LegitOof", LegitOof);
