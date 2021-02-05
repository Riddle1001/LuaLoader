-- Scraped by chicken
-- Author: ambien55
-- Title [Release] 3D lethal C4 radius
-- Forum link https://aimware.net/forum/thread/102137

local C4Distance = 0

local function modifier(map_name)
 if (map_name == "de_zoo" or map_name == "de_vertigo" or map_name == "de_nuke" or map_name == "de_shortnuke") then
  return 2.6 -- 400
 end

 if (map_name == "de_biome") then
  return 1.5 -- 450
 end

 return 1 -- 500
end

local function calc_dmg(Bomb, Player, dist)
 local _1, _2, PlayerZ = Player:GetHitboxPosition(0)
 local _1, _2, BombZ = Bomb:GetAbsOrigin()

 local Gauss

 if (dist == nil) then
  dist = vector.Distance({Bomb:GetAbsOrigin()}, {Player:GetHitboxPosition(0)})
  Gauss = (dist - 75.68) / 789.2
 else 
  Gauss = ((math.sqrt((dist ^ 2) + ((BombZ-PlayerZ) ^ 2)) - 75.68) / 789.2)
 end

 local flDamage = (450.7 / modifier(engine.GetMapName()) * math.exp(-Gauss ^ 2))
 local armor = Player:GetProp("m_ArmorValue")

 if armor > 0 then
  local flArmorRatio, flArmorBonus = 0.5, 0.5

  local flNew = flDamage * flArmorRatio
  local flArmor = (flDamage - flNew) * flArmorBonus

  if flArmor > armor then
   flArmor = armor * (1 / flArmorBonus)
   flNew = flDamage - flArmor
  end

  flDamage = flNew
 end

 return math.max(flDamage, 0)
end

local function drawCircle(x, y, z, radius, thickness, quality)
 local quality = quality or 20
 local thickness = thickness or 8
 local Screen_X_Line_Old, Screen_Y_Line_Old
 for rot = 0, 360, quality do
  local rot_temp = math.rad(rot)
  local LineX, LineY, LineZ = radius * math.cos(rot_temp) + x, radius * math.sin(rot_temp) + y, z
  local Screen_X_Line, Screen_Y_Line = client.WorldToScreen(LineX, LineY, LineZ)
  if Screen_X_Line ~= nil and Screen_X_Line_Old ~= nil then
   draw.SetFont(draw.CreateFont("Tahoma", 12));
   draw.Line(Screen_X_Line, Screen_Y_Line, Screen_X_Line_Old, Screen_Y_Line_Old)
   for i = 0, thickness do
    draw.Line(Screen_X_Line, Screen_Y_Line + i, Screen_X_Line_Old, Screen_Y_Line_Old + i)
   end
  end
  Screen_X_Line_Old, Screen_Y_Line_Old = Screen_X_Line, Screen_Y_Line
 end
end

client.AllowListener('bomb_exploded')
client.AllowListener('round_start')
callbacks.Register('FireGameEvent', function(event)
 if (event:GetName() == "bomb_exploded" or event:GetName() == "round_start") then
  C4Distance = 0
 end
end)

callbacks.Register("Draw", function()
 if (not gui.GetValue("esp_active")) then
  return
 end

 local local_player = entities.GetLocalPlayer()
 local bomb = entities.FindByClass("CPlantedC4")[1]
 local map_name = engine.GetMapName()

 if (bomb == nil or local_player == nil) then return end
 if (map_name == "dz_blacksite") then return end
 if (not local_player:IsAlive()) then return end

 if not (bomb:GetProp("m_bBombTicking") and bomb:GetProp("m_bBombDefused") == 0 and globals.CurTime() < bomb:GetProp("m_flC4Blow")) then
  return
 end

 local _1, _2, player_z = local_player:GetAbsOrigin()
 local bomb_origin_x, bomb_origin_y = bomb:GetAbsOrigin()
 local damage
 local radius = 0
 local healthW = 0.01

 repeat
  damage = calc_dmg(bomb, local_player, C4Distance)
  health_left = local_player:GetHealth() - damage
  if (math.ceil(health_left) < local_player:GetHealth() * healthW + (1 - healthW)) then
   C4Distance = C4Distance + 1
  end

  if (math.ceil(health_left) > local_player:GetHealth() * healthW + (1 - healthW) + 1 and math.ceil(health_left) ~= local_player:GetHealth() * healthW + (1 - healthW) + 1) then
   C4Distance = C4Distance - 1
  end
 until (C4Distance == 1500 or health_left > 0)

 radius = C4Distance
  
 -- thick circle (3d radius)
 draw.Color(211, 33, 33, 80)
 drawCircle(bomb_origin_x, bomb_origin_y, player_z, radius, 10, 1)

 -- bomb damage text
 draw.SetFont(draw.CreateFont("Tahoma", 25, 100))
 local w, h = draw.GetScreenSize()
 local hitpoints_left = (local_player:GetHealth() - math.ceil(calc_dmg(bomb, local_player, nil)))

 if (hitpoints_left < 100) then
  if (hitpoints_left <= 0) then
   draw.Color(255, 0, 0, 255)
  else
   draw.Color(255, 255, 255, 255)
  end
  draw.TextShadow(w*0.23, h*0.965, hitpoints_left .. " HP")
 end
end)



