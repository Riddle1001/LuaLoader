-- Scraped by chicken
-- Author: zack
-- Title [Release] makeshift aimbot after 1 shot
-- Forum link https://aimware.net/forum/thread/87828


function WhenWeaponFired( Event )
gui.SetValue("lbot_enable", false)
local _uid_to_index = client.GetPlayerIndexByUserID;
local _localplayerindex = client.GetLocalPlayerIndex;
if Event:GetName() == 'weapon_fire' then
local _local = _localplayerindex();
local _uid = Event:GetInt("userid");
if _local == _uid_to_index(_uid) then
local _weapon = Event:GetString("weapon");
if _weapon == "weapon_ak47" or _weapon == "weapon_m4a1" or _weapon == "weapon_famas" or _weapon == "weapon_galilar" or _weapon == "weapon_aug" or _weapon == "weapon_sg556" then
gui.SetValue("lbot_enable", true)
end end
elseif Event:GetName() ~= 'weapon_fire' and Event:GetName() ~= 'bullet_impact' then
gui.SetValue("lbot_enable", false)
return
end end

callbacks.Register("FireGameEvent", "WhenWeaponFired", WhenWeaponFired);
client.AllowListener("item_equip");
client.AllowListener("weapon_fire");

