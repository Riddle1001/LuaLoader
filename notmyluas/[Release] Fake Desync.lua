-- Scraped by chicken
-- Author: PUSYBOI
-- Title [Release] Fake Desync
-- Forum link https://aimware.net/forum/thread/143119

callbacks.Register("Draw", function()
  if globals.TickCount() % 7 == 0 then
    gui.SetValue("rbot.antiaim.desync", 1)
    gui.SetValue("rbot.antiaim.desyncleft", 1)
    gui.SetValue("rbot.antiaim.desyncright", 1)
    gui.SetValue("rbot.antiaim.yaw", 179)
  else
    gui.SetValue("rbot.antiaim.desync", 0)
    gui.SetValue("rbot.antiaim.desyncleft", 0)
    gui.SetValue("rbot.antiaim.desyncright", 0)
    gui.SetValue("rbot.antiaim.yaw", 180)
  end
end)



