-- Scraped by chicken
-- Author: Sl1tex
-- Title [Release] Fake Desync by PUSYBOI
-- Forum link https://aimware.net/forum/thread/144300

callbacks.Register("Draw", function()
  if globals.TickCount() % 7 == 0 then
    gui.SetValue("rbot.antiaim.base.rotation", 1)
    gui.SetValue("rbot.antiaim.left.lby", 1)
    gui.SetValue("rbot.antiaim.right", 1)
    gui.SetValue("rbot.antiaim.left", 179)
  else
    gui.SetValue("rbot.antiaim.base.rotation", 0)
    gui.SetValue("rbot.antiaim.left.lby", 0)
    gui.SetValue("rbot.antiaim.right", 0)
    gui.SetValue("rbot.antiaim.left", 180)
  end
end)