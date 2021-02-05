-- Scraped by chicken
-- Author: ambien55
-- Title [Release] Chicken aimbot
-- Forum link https://aimware.net/forum/thread/100885

local function get_pelvis_position(chicken)
 local x, y, z = chicken:GetHitboxPosition(0)
 return {x, y, z}
end

local function calc_angle(src, dst)
 local _1, _2, _3 = vector.Subtract(dst, src)
 local vectorangles1, vectorangles2, vectorangles3 = vector.Angles({_1, _2, _3})
 return {vectorangles1, vectorangles2, vectorangles3}
end

local function nearest_target()
 local closestEntity = nil 
 local targetEntity = nil
 local last_lowest_dist = 999999
 local local_player = entities.GetLocalPlayer()

 local players = entities.FindByClass("CChicken")
 if next(players) ~= nil then
  for i = 1, #players do
   local targetEntity = players[i]

   if(targetEntity ~= nil) then
    -- thanks to SEGnosis for math tutorial
    local enemy_head_x, enemy_head_y, enemy_head_z = targetEntity:GetHitboxPosition(0)
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

 return closestEntity
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

 -- check if our clip isn't empty
 if (weapon:GetProp("m_iClip1") == 0) then
  return false
 end

 -- check if our gun is still being pulled out
 local m_flNextAttack = local_player:GetPropFloat("bcc_localdata", "m_flNextAttack")
 if (m_flNextAttack >= globals.CurTime()) then
  return false
 end

 return true
end

callbacks.Register("Draw", function()
 screen_w, screen_h = draw.GetScreenSize()
 screen_w = screen_w / 2
 screen_h = screen_h / 2
end)

callbacks.Register("CreateMove", function(UserCmd)
 if(screen_w == nil or screen_h == nil) then return end

 local local_player = entities.GetLocalPlayer()

 if(not input.IsButtonDown(1)) then
  return
 end

 if(local_player == nil) then return end
 local weapon = local_player:GetPropEntity("m_hActiveWeapon")
 if(weapon == nil) then return end

 if (not can_shoot) then
  return
 end

 local start_x, start_y, start_z = local_player:GetHitboxPosition(0)

 local nearest = nearest_target()
 if(nearest == nil) then return end

 local _end = get_pelvis_position(nearest)

 local contents, fraction = engine.TraceLine( start_x, start_y, start_z, _end[1], _end[2], _end[3], 1 )
 if (fraction >= 0.9) then
  local angle = calc_angle({start_x, start_y, start_z}, _end)
  if(angle ~= nil and angle ~= NULL) then
   UserCmd:SetViewAngles(angle[1], angle[2], angle[3])
  end
 end
end)



