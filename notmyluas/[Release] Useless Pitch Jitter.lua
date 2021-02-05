-- Scraped by chicken
-- Author: Spekbillen
-- Title [Release] Useless Pitch Jitter
-- Forum link https://aimware.net/forum/thread/133404

local pitch = "Off"
local ref = gui.Reference("Ragebot", "Anti-Aim", "Advanced")
local JitterButton = gui.Checkbox(ref, "pitchjitter", "Pitch Jitter", false);
JitterButton:SetDescription("Jitter Your Pitch")
function Jitter()
 if JitterButton:GetValue() then
  if pitch == "Off" then
   gui.SetValue("rbot.antiaim.advanced.pitch", pitch)
   pitch = "89"
  else
   gui.SetValue("rbot.antiaim.advanced.pitch", pitch)
   pitch = "Off"
  end
 end
end
callbacks.Register( "Draw", "Jitter", Jitter );
