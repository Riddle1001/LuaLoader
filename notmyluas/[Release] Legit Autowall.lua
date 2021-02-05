-- Scraped by chicken
-- Author: Bean07
-- Title [Release] Legit Autowall
-- Forum link https://aimware.net/forum/thread/142601


local ref = gui.Reference("Ragebot", "Aimbot", "Target")
local chk_legitaw = gui.Checkbox(ref, "chk_legitaw", "Legit Autowall", false)
local hitbox_threshold = gui.Slider(ref, "hitbox_threshold", "Visible Hitbox Threshold", 2, 1, 18)
local kb_legitaw = gui.Keybox(ref, "kb_legitaw", "Autowall Key", 0)

local weapn_strings = {
"shared",
"zeus",
"pistol",
"hpistol",
"smg",
"rifle",
"shotgun",
"scout",
"asniper",
"sniper",
"lmg"
}

local autowall_var1 = false
local autowall_var2 = false

local PI = math.pi
local DEG_TO_RAD = PI / 180.0
local RAD_TO_DEG = 180.0 / PI

local function vec3_normalize(x, y, z)
  local len = math.sqrt(x * x + y * y + z * z)
  if len == 0 then
    return 0, 0, 0
  end
  local r = 1 / len
  return x * r, y * r, z * r
end

local function vec3_dot(ax, ay, az, bx, by, bz)
  return ax * bx + ay * by + az * bz
end

local function angle_to_vec(pitch, yaw)
  local pitch_rad, yaw_rad = DEG_TO_RAD * pitch, DEG_TO_RAD * yaw
  local sp, cp, sy, cy = math.sin(pitch_rad), math.cos(pitch_rad), math.sin(yaw_rad), math.cos(yaw_rad)
  return cp * cy, cp * sy, -sp
end
function calculate_fov_to_player(ent, lx, ly, lz, fx, fy, fz)
local pOrigin = ent:GetProp("m_vecOrigin")
  local px, py, pz = pOrigin.x, pOrigin.y, pOrigin.z
  local dx, dy, dz = vec3_normalize(px - lx, py - ly, lz - lz)
  local dot_product = vec3_dot(dx, dy, dz, fx, fy, fz)
  local cos_inverse = math.acos(dot_product)
  return RAD_TO_DEG * cos_inverse
end

local function get_enemy_players()
local players = entities.FindByClass("CCSPlayer")
  local enemy_players = {}
  for i, v in next, players do
  if v:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() then
  table.insert(enemy_players, v)
  end
  end

  return enemy_players
end

local function get_closest_player_to_crosshair(lx, ly, lz, pitch, yaw)
  local fx, fy, fz = angle_to_vec(pitch, yaw)
  local enemy_players = get_enemy_players()
  local nearest_player = nil
  local nearest_player_fov = math.huge
  for i = 1, #enemy_players do
    local enemy_ent = enemy_players[i]
    local fov_to_player = calculate_fov_to_player(enemy_ent, lx, ly, lz, fx, fy, fz)
    if fov_to_player <= nearest_player_fov then
      nearest_player = enemy_ent
      nearest_player_fov = fov_to_player
    end
  end
  return nearest_player, nearest_player_fov
end

local function calculate_fov_to_player(ent, lx, ly, lz, fx, fy, fz)
local pOrigin = ent:GetProp("m_vecOrigin")
  local px, py, pz = pOrigin.x, pOrigin.y, pOrigin.z
  local dx, dy, dz = vec3_normalize(px - lx, py - ly, lz - lz)
  local dot_product = vec3_dot(dx, dy, dz, fx, fy, fz)
  local cos_inverse = math.acos(dot_product)
  return RAD_TO_DEG * cos_inverse
end

local function is_player_visible(local_player, lx, ly, lz, ent)
  local visible_hitboxes = 0
  local visible_hitbox_threshold = hitbox_threshold:GetValue()
  for i = 0, 18 do
  local epos = ent:GetHitboxPosition(i)
    local ex, ey, ez = epos.x, epos.y, epos.z
    local entindex = engine.TraceLine(Vector3(lx, ly, lz), Vector3(ex, ey, ez))
    print(entindex.contents)
    if entindex.contents <= 1 then
      visible_hitboxes = visible_hitboxes + 1
    end
  end
  return visible_hitboxes >= visible_hitbox_threshold
end

local function AWHandler()
for i, v in next, weapn_strings do
gui.SetValue("rbot.hitscan.mode."..v..".autowall", autowall_var1 or autowall_var2)
end
end

-- check for key press
callbacks.Register("Draw", function()
if not entities.GetLocalPlayer() then return end
if not entities.GetLocalPlayer():IsAlive() then return end

if kb_legitaw:GetValue() ~= 0 then
if input.IsButtonPressed(kb_legitaw:GetValue()) then
autowall_var1 = not autowall_var1
end
end
AWHandler()
end)

-- check for enemy visible
callbacks.Register("Draw", function()
hitbox_threshold:SetInvisible(not chk_legitaw:GetValue())
kb_legitaw:SetInvisible(not chk_legitaw:GetValue())

local local_player = entities.GetLocalPlayer()

if not local_player then return end
if not local_player:IsAlive() then return end

local maximum_fov = gui.GetValue("rbot.aim.target.fov")
local engine_view_angles = engine.GetViewAngles()
local pitch, yaw = engine_view_angles.pitch, engine_view_angles.yaw
local lOrigin = local_player:GetProp("m_vecOrigin")
local lx, ly, lz = lOrigin.x, lOrigin.y, lOrigin.z
local nearest_player, nearest_player_fov = get_closest_player_to_crosshair(lx, ly, lz, pitch, yaw)
local view_offset = 0 -- local_player:GetProp("m_vecViewOffset")
local lz = lz + view_offset

if nearest_player ~= nil and nearest_player_fov <= maximum_fov and chk_legitaw:GetValue() then
    autowall_var2 = is_player_visible(local_player, lx, ly, lz, nearest_player)
  else
    autowall_var2 = false
  end
  AWHandler()
end)

-- Scraped by chicken
-- Author: helloabcdf123
-- Title [Release] Legit AutoWall
-- Forum link https://aimware.net/forum/thread/139856


local ref = gui.Reference("Ragebot", "Aimbot", "Target")
local chk_legitaw = gui.Checkbox(ref, "chk_legitaw", "Legit Autowall", false)
local kb_legitaw = gui.Keybox(ref, "kb_legitaw", "Autowall Key", 0)

local aw_toggled = false

DEG_TO_RAD = math.pi / 180.0
RAD_TO_DEG = 180.0 / math.pi

local lpitch, lyaw;

local function weapon_info(id)
if id == 1 then
return "hpistol"
elseif id == 2 or id == 3 or id == 4 or id == 30 or id == 32 or id == 36 or id == 61 or id == 63 then
return "pistol"
elseif id == 7 or id == 8 or id == 10 or id == 13 or id == 16 or id == 39 or id == 60 then
return "rifle"
elseif id == 11 or id == 38 then
return "asniper"
elseif id == 17 or id == 19 or id == 23 or id == 24 or id == 26 or id == 33 or id == 34 then
return "smg"
elseif id == 14 or id == 28 then
return "lmg"
elseif id == 25 or id == 27 or id == 29 or id == 35 then
return "shotgun"
elseif id == 9 then
return "sniper"
elseif id == 40 then
return "scout"
end
end

function vec3_normalize(x, y, z)
  local len = math.sqrt(x * x + y * y + z * z)
  if len == 0 then
    return 0, 0, 0
  end
  local r = 1 / len
  return x * r, y * r, z * r
end

function vec3_dot(ax, ay, az, bx, by, bz)
  return ax * bx + ay * by + az * bz
end

function angle_to_vec(pitch, yaw)
  local pitch_rad, yaw_rad = DEG_TO_RAD * pitch, DEG_TO_RAD * yaw
  local sp, cp, sy, cy = math.sin(pitch_rad), math.cos(pitch_rad), math.sin(yaw_rad), math.cos(yaw_rad)
  return cp * cy, cp * sy, -sp
end

function calculate_fov_to_player(ent, lx, ly, lz, fx, fy, fz)
local vOrigin = ent:GetProp("m_vecOrigin")
  local px, py, pz = vOrigin.x, vOrigin.y, vOrigin.z
  local dx, dy, dz = vec3_normalize(px - lx, py - ly, lz - lz)
  local dot_product = vec3_dot(dx, dy, dz, fx, fy, fz)
  local cos_inverse = math.acos(dot_product)
  return RAD_TO_DEG * cos_inverse
end

function get_closest_player_to_crosshair(lx, ly, lz, pitch, yaw)

  -- Calculate our forward vector once instead of doing it for each player

  local fx, fy, fz = angle_to_vec(pitch, yaw)
  local players = entities.FindByClass("CCSPlayer")
  local enemy_players = {}
  local nearest_player = nil
  local nearest_player_fov = math.huge

  for i = 1, #players do
  if players[i]:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and not players[i]:IsDormant() and players[i]:IsAlive() then
  table.insert(enemy_players, players[i])
  end
  end

  for i = 1, #enemy_players do
    local enemy_ent = enemy_players[i]

    -- Calculate the FOV to the player so we can determine if they are closer than the stored player

    local fov_to_player = calculate_fov_to_player(enemy_ent, lx, ly, lz, fx, fy, fz)
    if fov_to_player <= nearest_player_fov then
      nearest_player = enemy_ent
      nearest_player_fov = fov_to_player
    end
  end

  return nearest_player, nearest_player_fov
end

local function is_vis(lp, lx, ly, lz, ent)
if ent == nil then return false end
local visibility = false
  for i = 0, 4 do
    for x = 0, 4 do
      local v = ent:GetHitboxPosition(i)

      if x == 0 then
        v.x = v.x
        v.y = v.y
      elseif x == 1 then
        v.x = v.x
        v.y = v.y + 4
      elseif x == 2 then
        v.x = v.x
        v.y = v.y - 4
      elseif x == 3 then
        v.x = v.x + 4
        v.y = v.y
      elseif x == 4 then
        v.x = v.x - 4
        v.y = v.y
      end

      local c = (engine.TraceLine(Vector3(lx,ly,lz), v, 0x1)).contents
      if c == 0 then
        visibility = true
        break
      end
    end
  end
  return visibility
end

callbacks.Register("CreateMove", function(cmd)
if cmd.sendpacket then
lpitch, lyaw = cmd:GetViewAngles().pitch, cmd:GetViewAngles().yaw
end
end)

callbacks.Register("Draw", function()
local lp = entities.GetLocalPlayer()
if not lp then return end
if not lp:IsAlive() then return end
if kb_legitaw:GetValue() ~= 0 then
if input.IsButtonPressed(kb_legitaw:GetValue()) then
aw_toggled = not aw_toggled
end
end
end)

callbacks.Register("Draw", function()
local lp = entities.GetLocalPlayer()
if not lp then return end
if not lp:IsAlive() then return end
if not chk_legitaw:GetValue() then return end
local lViewAngles = entities.GetLocalPlayer():GetAbsOrigin()
local nearest_player, nearest_player_fov = get_closest_player_to_crosshair(lViewAngles.x, lViewAngles.y, lViewAngles.z, lpitch, lyaw)
if (nearest_player ~= nil and nearest_player_fov <= gui.GetValue("rbot.aim.target.fov") and chk_legitaw:GetValue()) or aw_toggled then
local wepInfo = weapon_info(lp:GetWeaponID())
if wepInfo ~= nil then
local aw_on
if is_vis(lp, lViewAngles.x, lViewAngles.y, lViewAngles.z, nearest_player) or aw_toggled then
aw_on = true
else
aw_on = false
end
if gui.GetValue("rbot.hitscan.mode") == [["Shared"]] then
gui.SetValue("rbot.hitscan.mode.shared.autowall", aw_on)
else
gui.SetValue("rbot.hitscan.mode."..wepInfo..".autowall", aw_on)
end
end
else
local wepInfo = weapon_info(lp:GetWeaponID())
if wepInfo ~= nil then
if gui.GetValue("rbot.hitscan.mode") == [["Shared"]] then
gui.SetValue("rbot.hitscan.mode.shared.autowall", false)
else
gui.SetValue("rbot.hitscan.mode."..wepInfo..".autowall", false)
end
end
end
end)


