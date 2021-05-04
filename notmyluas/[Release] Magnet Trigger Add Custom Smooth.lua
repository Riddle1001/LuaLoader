-- Scraped by chicken
-- Author: Keepertp
-- Title [Release] Magnet Trigger Add Custom Smooth
-- Forum link https://aimware.net/forum/thread/140180

local ref = gui.Reference("Legitbot", "Triggerbot", "Toggle")
local magnet = gui.Checkbox(ref, "magnet_trg", "Magnet Trigger", false)
local smooth = gui.Slider( ref, "magnet_trg_smooth", "Magnet Trigger Smooth", 10, 0, 30);

magnet:SetDescription("Pulls your crosshair towards the enemy")

local weapon_groups = 
{
"asniper", "hpistol", "lmg", "pistol", "rifle", "scout", "shared", "shotgun", "smg", "sniper" 
};

local pressed = false
local old_val = { 
on_press = gui.GetValue("lbot.aim.fireonpress"),
autofire = gui.GetValue("lbot.aim.autofire"),
smoothes = {
["asniper"] = 10,
["hpistol"] = 10,
["lmg"] = 10,
["pistol"] = 10,
["rifle"] = 10,
["scout"] = 10,
["shared"] = 10,
["shotgun"] = 10,
["smg"] = 10,
["sniper"] = 10
},
}

for key, weapvalue in ipairs(weapon_groups) do
old_val.smoothes[weapvalue] = gui.GetValue("lbot.weapon.aim." .. weapvalue .. ".smooth");
end


callbacks.Register("Draw", function()
if magnet:GetValue() then
if gui.GetValue("lbot.trg.enable") then
if gui.GetValue("lbot.trg.key") ~= 0 or gui.GetValue("lbot.trg.autofire") then
if gui.GetValue("lbot.trg.autofire") or input.IsButtonDown(gui.GetValue("lbot.trg.key")) then
if pressed == false then
pressed = true
old_val.on_press = gui.GetValue("lbot.aim.fireonpress");
old_val.autofire = gui.GetValue("lbot.aim.autofire");
end
for key, weapvalue in ipairs(weapon_groups) do
gui.SetValue("lbot.weapon.aim." .. weapvalue .. ".smooth", smooth:GetValue());
end
gui.SetValue("lbot.aim.fireonpress", false);
gui.SetValue("lbot.aim.autofire", true);
else
if pressed then
pressed = false
for key, weapvalue in ipairs(weapon_groups) do
gui.SetValue("lbot.weapon.aim." .. weapvalue .. ".smooth", old_val.smoothes[weapvalue]);
end
gui.SetValue("lbot.aim.fireonpress", old_val.on_press);
gui.SetValue("lbot.aim.autofire", old_val.autofire);
end
end
end
end
end
end)