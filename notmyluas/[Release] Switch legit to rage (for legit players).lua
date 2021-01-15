-- Scraped by chicken
-- Author: gowork88
-- Title [Release] Switch legit to rage (for legit players)
-- Forum link https://aimware.net/forum/thread/117726

-- Powered by El Credito
-- Contact mail: [emailprotected]
-- have fun ;)

local guiSet = gui.SetValue;

local legitRage_refGUI = gui.Reference("LEGIT", "Extra");
local chengeDamageText = gui.Text(legitRage_refGUI, "--- Switch to rage ---");
local legitRageKey = gui.Keybox(legitRage_refGUI, "Switch key", "Key rage", 0);

local fov_rage = gui.Slider(legitRage_refGUI, "fov", "Fov rage", 1, 0, 180);

local firstTime = 1;

function legitRage()
 if (legitRageKey:GetValue() == 0) then
 return -1;
 end
 if (input.IsButtonPressed(legitRageKey:GetValue())) then
 if (firstTime == 1) then
 guiSet("rbot_enable", 1);
 guiSet("rbot_active", 1);
 guiSet("rbot_aimkey", 0);
 guiSet("rbot_shared_autowall", 0);
 guiSet("rbot_silentaim", 1);
 guiSet("rbot_antirecoil", 1);
 guiSet("rbot_fov", fov_rage:GetValue());
 firstTime = 0
 end
 elseif (input.IsButtonDown(legitRageKey:GetValue())) then
 -- do nothing ;)
 elseif (input.IsButtonReleased(legitRageKey:GetValue())) then
 guiSet("rbot_enable", 0);
 guiSet("rbot_active", 0);
 guiSet("rbot_aimkey", 0);
 guiSet("rbot_shared_autowall", 0);
 firstTime = 1;
 end
end

callbacks.Register("Draw", "changeDmgMain", legitRage);