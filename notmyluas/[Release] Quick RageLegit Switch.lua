-- Scraped by chicken
-- Author: DaveLTC
-- Title [Release] Quick RageLegit Switch
-- Forum link https://aimware.net/forum/thread/128904

-- Thank you for using my script. If you like it recommend me. Special Thanks to superyu'#7167 aka. Clipper whose fakelaggFix.lua was used as a template.
-- Hit me up on discord to request new features and maybe I add them.

local author = "DaveLTC";

local ref = gui.Tab(gui.Reference("Misc"), "QuickToggle.settings", "QuickSwitch")
local key = gui.Keybox (ref, "lua_keybox", "Key for QuickToggle",0)
key:SetDescription("This Key will switch between Rage and Legit.")
local pressed = false;


callbacks.Register("Draw", function()
  if key:GetValue() ~= 0 then
    if input.IsButtonPressed(key:GetValue()) then
 pressed=true;
 elseif (pressed and input.IsButtonReleased(key:GetValue())) then
 pressed=false;
 if gui.GetValue("rbot.master") then
 gui.SetValue("rbot.master", false)
 gui.SetValue("lbot.master", true)
 else
 gui.SetValue("rbot.master", true)
 gui.SetValue("lbot.master", false)
 end
 end
  end
 
end)