-- Scraped by chicken
-- Author: ambien55
-- Title [Release] Blip ESP (sonar)
-- Forum link https://aimware.net/forum/thread/101870

-- settings --

local crosshair_mode = false -- "true" - will beep more the closer your crosshair gets to enemy's head; "false": will beep more the closer you get to enemy
local volume = 1 -- blip volume; min: 0.0, max: 1.0;
local min_dist_distance = 0 -- how close (in meters) do you have to get to enemy in order for sonar to stop working (0 = off)
local max_dist_distance = 200 -- how far away (in meters) from enemy do you have to get in order for sonar to stop working (0 = off)
local min_dist_crosshair = 0 -- how close (in units) does your crosshair have to get to enemy's head in order for sonar to stop working (0 = off)
local max_dist_crosshair = 300 -- how far away (in units) does your crosshair have to get from the enemy's head in order for sonar to stop working (0 = off)
local ignore_team_check = false -- set to "true" if you want sonar to work in deathmatch / dangerzone

-- end --

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
  end
 end

 return last_lowest_dist
end

local function nearest_distance()
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
      local dist = vector.Distance( {targetEntity:GetAbsOrigin()}, {local_player:GetAbsOrigin()} )
      if (dist < last_lowest_dist) then
       last_lowest_dist = dist
       closestEntity = targetEntity
      end
     end
    end
   end
  end
 end

 return last_lowest_dist * 0.0254
end

local last_blip = globals.RealTime()
local function blip(frequency) 
 if ((globals.RealTime()) > last_blip + frequency) then
  client.Command("playvol /buttons/blip1.wav " .. volume, true)
  last_blip = globals.RealTime()
 end
end

callbacks.Register("CreateMove", function()
 if (entities.GetLocalPlayer() == nil) then return end
 if (not entities.GetLocalPlayer():IsAlive()) then return end

 if(crosshair_mode == false) then
  local dist = nearest_distance()
  if(dist ~= 999999 and dist >= min_dist_distance and (dist <= max_dist_distance or max_dist_distance == 0)) then
   if (dist <= 5) then blip(0.2)
   elseif (dist <= 15) then blip((dist/5)*0.2)
   elseif (dist <= 20) then blip((dist/5)*0.25)
   else blip((dist/5)*0.3)
   end
  end
 elseif(crosshair_mode) then
  local dist = nearest_crosshair()
  if(dist ~= 999999 and dist >= min_dist_crosshair and (dist <= max_dist_crosshair or max_dist_crosshair == 0)) then
   if dist <= 10 then blip(0.2)
   elseif dist <= 25 then blip(0.25)
   elseif dist <= 50 then blip(0.3)
   else blip(dist*0.005)
   end
  end
 end
end)



