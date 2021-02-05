-- Scraped by chicken
-- Author: 90D5p33D
-- Title [Release] Static Jitter Desync
-- Forum link https://aimware.net/forum/thread/128334

local luck = 0
local function desync_changer()
  if luck < 3 then
    gui.SetValue("rbot.antiaim.base.rotation", 58);
 gui.SetValue("rbot.antiaim.base.lby", 58);
luck = luck + 1;
print(luck)
  else
    gui.SetValue("rbot.antiaim.base.rotation", -58);
 gui.SetValue("rbot.antiaim.base.lby", -58);
    luck = 0;
    print(luck)
 end
end
callbacks.Register("Draw", desync_changer)
