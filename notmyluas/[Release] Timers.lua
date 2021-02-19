-- Scraped by chicken
-- Author: zack
-- Title [Release] Timers
-- Forum link https://aimware.net/forum/thread/86245

------------------------------------------------------------------------------------------------------
local function MolotovTimer()
local entity_get = entities.FindByClass
local tickcount = globals.TickCount
local tickinterval = globals.TickInterval
local w2s = client.WorldToScreen
local duration = 7
  local molotov_grenades = entity_get("CMolotovProjectile")
  local tick_current = tickcount()
  local seconds_per_tick = tickinterval()
  
  for i=1, #molotov_grenades do
 local molotov_grenade = molotov_grenades[i]

if molotov_grenade:GetProp(" HERE ") then  ---- change " "
 local ticks = molotov_grenade:GetProp(" HERE ") --change " "
 local time_since_explosion = seconds_per_tick * (tick_current - ticks)
 if time_since_explosion > 0 and time_since_explosion < duration +1 then
local x, y, z = molotov_grenade:GetProp("m_vecOrigin")
 local worldX, worldy = w2s(x, y, z)
 if worldX ~= nil then
 local progress = 1 - time_since_explosion / duration
draw.Color(255,20 + progress * 235,20 + progress * 235,255)
message = string.format(".lf s", duration-time_since_explosion)
draw.TextShadow(worldX, worldY, message)

-- if it works this will show
draw.Color(255,255,255,255)
  draw.Text(970, 1000, "FIRE GRENADE")  

 end
 end
 end
 end
end
------------------------------------------------------------------------------------------------------
local function DecoyTimer()
local entity_get = entities.FindByClass
local tickcount = globals.TickCount
local tickinterval = globals.TickInterval
local w2s = client.WorldToScreen
local duration = 16
  local decoy_grenades = entity_get("CDecoyProjectile")
  local tick_current = tickcount()
  local seconds_per_tick = tickinterval()

  for i=1, #decoy_grenades do
    local decoy_grenade = decoy_grenades[i]

 if decoy_grenade:GetProp(" HERE ") then  --change " "
 local ticks = decoy_grenade:GetProp(" HERE ")  --change " "
      local time_since_explosion = seconds_per_tick * (tick_current - ticks)
      if time_since_explosion > 0 and time_since_explosion < duration +1 then
local x, y, z = decoy_grenade:GetProp("m_vecOrigin")
        local worldX, worldY = w2s(x, y, z)
        if worldX ~= nil then
          local progress = 1 - time_since_explosion / duration

draw.Color(255,20 + progress * 235,20 + progress * 235,255)
message = string.format("%.1f s", duration-time_since_explosion)
draw.TextShadow(worldX, worldY, message) 

-- if it works this will show
draw.Color(255,255,255,255)
  draw.Text(950, 1000, "DECOY GRENADE") 

        end
      end
    end
  end
end
------------------------------------------------------------------------------------------------------