-- Scraped by chicken
-- Author: Chipss
-- Title [Release] Anti Trigger
-- Forum link https://aimware.net/forum/thread/86671

local sqrt, sin, cos = math.sqrt, math.sin, math.cos

local pi = 3.14159265358979323846
local deg2rad = pi / 180.0
local rad2deg = 180.0 / pi


local function vec3_normalize(x, y, z)
local len = sqrt(x * x + y * y + z * z)
if len == 0 then
return 0, 0, 0
end
local r = 1 / len
return x*r, y*r, z*r
end

local function angle_to_vec(pitch, yaw)
local p, y = deg2rad*pitch, deg2rad*yaw
local sp, cp, sy, cy = sin(p), cos(p), sin(y), cos(y)
return cp*cy, cp*sy, -sp
end

local function vec3_dot(ax, ay, az, bx, by, bz)
return ax*bx + ay*by + az*bz
end

local function aiming_at_me(ent, lx, ly, lz)
local pitch, yaw, roll = ent:GetProp("m_angEyeAngles")
if pitch == nil then
return
end

local ex, ey, ez = angle_to_vec(pitch, yaw)
local px, py, pz = ent:GetProp("m_vecOrigin")
if px == nil then
return
end

local dx, dy, dz = vec3_normalize(lx-px, ly-py, lz-pz)
return vec3_dot(dx, dy, dz, ex, ey, ez) > 0.98480775301
end


local function AntiTrigger()

local entindex = entities.GetLocalPlayer();
if entindex == nil then
return
end

local lx, ly, lz = entindex:GetProp("m_vecOrigin");
if lx == nil then
return
end

for i = 1, globals.MaxClients() do
    local players = client.GetPlayerNameByIndex( i );
    local guy = entities.GetByIndex(i);
    if not guy then return end

    if aiming_at_me(guy, lx, ly, lz) then

    gui.SetValue( "msc_fakelag_enable", true )

    else

    gui.SetValue( "msc_fakelag_enable", false )

    end
   
 end

end

callbacks.Register( 'Draw', 'AT', AntiTrigger );