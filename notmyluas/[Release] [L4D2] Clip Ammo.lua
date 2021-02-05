-- Scraped by chicken
-- Author: Flaco Bey
-- Title [Release] [L4D2] Clip Ammo
-- Forum link https://aimware.net/forum/thread/105455

function iAmmoCheck(esp)
local entity = esp:GetEntity();
if entity and entity:IsPlayer() and entity:GetTeamNumber() == 2 then 
local Weapon = entity:GetPropEntity("m_hActiveWeapon")
if Weapon == nil then return; end
local iClip = Weapon:GetProp("m_iClip1")
esp:Color(255,0,0,255);
esp:AddTextTop(iClip);
end
end

callbacks.Register('DrawESP','iAmmoCheck',iAmmoCheck);

