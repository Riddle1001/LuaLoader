-- Scraped by chicken
-- Author: micpet
-- Title [Release] left right indicator + lby inverter
-- Forum link https://aimware.net/forum/thread/132607

callbacks.Register("Draw", function()
  draw.Color(130,200,0,255)
  draw.SetFont(draw.CreateFont("Calibri", 30, 100))
  if (gui.GetValue("rbot.antiaim.advanced.autodir") == true) then
    draw.TextShadow(2, 500, "AUTODIR")
  end
  if (gui.GetValue("rbot.antiaim.base.rotation") == -58) then
    draw.TextShadow(2, 530, "Left")
  end
  if (gui.GetValue("rbot.antiaim.base.rotation") == 58) then
    draw.TextShadow(2, 530, "Right")
  end
  if (gui.GetValue("rbot.antiaim.base.rotation") == -58) then
    gui.SetValue("rbot.antiaim.base.lby", 50) 
  end
  if (gui.GetValue("rbot.antiaim.base.rotation") == 58) then
    gui.SetValue("rbot.antiaim.base.lby", -50) 
  end
 end)

--coded by nigga l33t#5156