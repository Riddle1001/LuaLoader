-- Scraped by chicken
-- Author: ambien55
-- Title [Release] 360 Trickshooter
-- Forum link https://aimware.net/forum/thread/103746


local speed = 17.5 -- trickshot spin speed (12.5-17.5 works best)
local keycode = 88 -- trickshot activates after pressing this key (x) (https://keycode.info/)
local fov_limit = 35 -- how close (in hammer units) does your crosshair have to be to chosen hitbox in order for trickshooter to work
local target_hitbox = 0 -- which hitbox you want to target
local ignore_team_check = false -- check if you want trickshooter to target teammates
local autoscope = true -- automatically scope in if you're trying to trickshoot with sniper

-- don't edit below this line
local function calc_angle(src, dst)
 local diff1, diff2, diff3 = vector.Subtract(dst, src)  
 local vectorangles1, vectorangles2, vectorangles3 = vector.Angles({diff1, diff2, diff3})
 return {vectorangles1, vectorangles2, vectorangles3}
end

local function nearest_crosshair()
 local closestEntity = nil 
 local targetEntity = nil
 local last_lowest_dist = 999999
 local local_player = entities.GetLocalPlayer()

 local players = entities.FindByClass("CCSPlayer")
 if next(players) ~= nil then
 for i = 1, #players do
 local targetEntity = players[i]

 if(targetEntity:IsAlive() and targetEntity ~= nil) then
 if(targetEntity:GetIndex() ~= client.GetLocalPlayerIndex()) then
 if(local_player:GetTeamNumber() ~= targetEntity:GetTeamNumber() or ignore_team_check) then
 
 -- thanks to SEGnosis for math tutorial
 local enemy_head_x, enemy_head_y, enemy_head_z = targetEntity:GetHitboxPosition(target_hitbox)
 local enemy_head_x_onscreen, enemy_head_y_onscreem = client.WorldToScreen(enemy_head_x, enemy_head_y, enemy_head_z)
 if(enemy_head_x_onscreen ~= nil and enemy_head_y_onscreem ~= nil) then
 local local_head_x, local_head_y, local_head_z = local_player:GetHitboxPosition(0)
 local local_eye_x, local_eye_y, local_eye_z = local_player:GetProp("m_angEyeAngles")

 local angles_to_target = calc_angle({local_head_x, local_head_y, local_head_z}, {enemy_head_x, enemy_head_y, enemy_head_z}) 
 local distance_to_target = vector.Distance( {targetEntity:GetAbsOrigin()}, {local_player:GetAbsOrigin()} )

 local yaw_diff = math.abs(local_eye_y - angles_to_target[2])
 yaw_diff = math.sin((math.pi / 180) * (yaw_diff)) * distance_to_target

 local pitch_diff = math.abs(local_eye_x - angles_to_target[1])
 pitch_diff = math.sin((math.pi / 180) * (pitch_diff)) * distance_to_target

 local c_dist = math.sqrt(pitch_diff ^ 2 + yaw_diff ^ 2)

 if (c_dist < last_lowest_dist) then
 last_lowest_dist = c_dist
 closestEntity = targetEntity
 end
 end

 end
 end
 end
 end
 end

 return {closestEntity, last_lowest_dist}
end

local function table_find_index(tab, val)
 for index, value in pairs(tab) do
 if value == val then
 return index
 end
 end

 return nil
end

local guns = {"glock", "hkp2000", "usp silencer", "fiveseven", "elite", "p250", "tec9", "revolver", "deagle", "cz75a", "nova", "xm1014", "sawedoff", 
"m249", "negev", "mp5sd", "mac10", "mp7", "ump45", "p90", "bizon", "galilar", "famas", "ak47", "m4a1", "m4a1 silencer", "ssg08", "sg556", "awp", "g3sg1", "scar20"}
local function can_shoot()
 local local_player = entities.GetLocalPlayer()
 local weapon = local_player:GetPropEntity("m_hActiveWeapon")
 if (weapon == nil) then
 return false
 end

 local weapon_name = weapon:GetName()

 -- check if we're holding a gun that's capable of shooting
 if (table_find_index(guns, weapon_name) == nil) then
 return false
 end

 -- revolver not supported as of now
 if (weapon_name == "revolver") then
 return false 
 end

 -- check if our clip isn't empty
 if (weapon:GetProp("m_iClip1") == 0) then
 return false
 end

 -- check if our gun is still being pulled out
 local m_flNextAttack = local_player:GetPropFloat("bcc_localdata", "m_flNextAttack")
 if (m_flNextAttack >= globals.CurTime()) then
 --[[
 local m_flNextPrimaryAttack = weapon:GetPropFloat("LocalActiveWeaponData", "m_flNextPrimaryAttack")
 if (m_flNextPrimaryAttack > globals.CurTime()) then
 return false
 end

 local m_flNextSecondaryAttack = weapon:GetPropFloat("LocalActiveWeaponData", "m_flNextSecondaryAttack")
 if (m_flNextPrimaryAttack > globals.CurTime()) then
 return false
 end
 --]]
 return false
 end

 return true
end

local snipers = {"awp", "ssg08", "g3sg1", "scar20"}
local function is_holding_sniper()
 local weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
 local weapon_name = weapon:GetName()
 if (weapon == nil) then 
 return false
 end

 if (table_find_index(snipers, weapon_name) ~= nil) then
 return true
 end

 return false
end

local target_ent, target_distance = nil
local aim_angle, aim_angle_y = nil
local DO_TRICKSHOT = false
local spin_progress = 0

callbacks.Register("Draw", function()
 if (entities.GetLocalPlayer() == nil) then return end

 if (input.IsButtonReleased(keycode) and can_shoot()) then
 spin_progress = 0
 target_ent, target_distance = nil
 DO_TRICKSHOT = true

 local target_and_fov = nearest_crosshair()
 target_ent = target_and_fov[1]
 target_distance = target_and_fov[2]
 end
end)

callbacks.Register("CreateMove", function(cmd)
 if (entities.GetLocalPlayer() == nil) then return end
 if (entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon") == nil) then return end

 local is_scoped = entities.GetLocalPlayer():GetPropBool("m_bIsScoped")

 local multiplier = 1
 if (is_holding_sniper()) then
 multiplier = 2
 end

 if(DO_TRICKSHOT and target_ent ~= nil and target_distance < fov_limit * multiplier) then
 if(spin_progress < math.floor(360/speed)) then
 if (autoscope and is_holding_sniper() and not is_scoped) then
 cmd:SetButtons(cmd:GetButtons() | (1 << 11))
 end

 local x, y, z = target_ent:GetHitboxPosition(target_hitbox)
 local enemy_head_pos = {x, y, z}

 local local_x, local_y, local_z = entities.GetLocalPlayer():GetHitboxPosition(0)
 local start = {local_x, local_y, local_z}

 aim_angle = calc_angle(start, enemy_head_pos)
 aim_angle_y = aim_angle[2]

 cmd:SetViewAngles(aim_angle[1], aim_angle_y, aim_angle[3])

 aim_angle_y = aim_angle_y - speed
 spin_progress = spin_progress + 1
 else
 DO_TRICKSHOT = false
 spin_progress = 0
 cmd:SetViewAngles(aim_angle[1], aim_angle[2], aim_angle[3])
 cmd:SetButtons(cmd:GetButtons() | (1 << 0))
 target_ent, target_distance, aim_angle, aim_angle_y = nil
 end
 end
end)

