-- Scraped by chicken
-- Author: scripted
-- Title [Release] Auto Double Peek
-- Forum link https://aimware.net/forum/thread/112612

local DP_WINDOW_ACTIVE = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "MOVEMENT"), "DP_WINDOW_ACTIVE", "Double Peek", 0);

local DP_WINDOW = gui.Window("DP_WINDOW", "Auto Double Peek", 200, 200, 450, 250);
local DP_GROUPBOX = gui.Groupbox(DP_WINDOW, "Settings", 5, 10, 435, 200);
local DP_ENABLE_KEYBINDS = gui.Checkbox(DP_GROUPBOX, "DP_ENABLE_KEYBINDS", "Enable", 0);

local DP_ON_TARGET_SHOT = gui.Checkbox(DP_GROUPBOX, "DP_ON_TARGET_SHOT", "Double peek if target shot", 1);
local DP_ON_TARGET_SHOOTING = gui.Checkbox(DP_GROUPBOX, "DP_ON_TARGET_SHOOTING", "Double peek if target shoots", 1);
local DP_DRAW_CIRCLE = gui.Checkbox(DP_GROUPBOX, "DP_DRAW_CIRCLE", "Draw circle under target", 1);
local DP_FOLLOW_LENGTH = gui.Slider(DP_GROUPBOX, "DP_FOLLOW_LENGTH", "How long to follow player on double peek (seconds)", 2, 1, 10);



local DP_KEY = gui.Keybox(DP_GROUPBOX, "DP_KEY", "Double Peek key (hold)", 6);

local target = entities.GetLocalPlayer()
local me = entities.GetLocalPlayer()

local double_peek_delay = globals.CurTime() + DP_FOLLOW_LENGTH

local window_cb_pressed = true
function showWindow()
  window_show = DP_WINDOW_ACTIVE:GetValue();

  if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then
    window_cb_pressed = not window_cb_pressed;
  end

  if (window_show and window_cb_pressed) then
    
    DP_WINDOW:SetActive(1);
  else
    
    DP_WINDOW:SetActive(0);
  end
end


local function drawCircle(Position, Radius) -- Will keep this function since the new api's circles aren't capable of drawing 3D circles
  draw.Color(0, 255, 0)
for degrees = 1, 360, 1 do
    local thisPoint = nil;
    local lastPoint = nil;
        
    if Position[3] == nil then
      thisPoint = {Position[1] + math.sin(math.rad(degrees)) * Radius, Position[2] + math.cos(math.rad(degrees)) * Radius}; 
      lastPoint = {Position[1] + math.sin(math.rad(degrees - 1)) * Radius, Position[2] + math.cos(math.rad(degrees - 1)) * Radius};
    else
      thisPoint = {client.WorldToScreen(Position[1] + math.sin(math.rad(degrees)) * Radius, Position[2] + math.cos(math.rad(degrees)) * Radius, Position[3])};
      lastPoint = {client.WorldToScreen(Position[1] + math.sin(math.rad(degrees - 1)) * Radius, Position[2] + math.cos(math.rad(degrees - 1)) * Radius, Position[3])};
    end
          
    if thisPoint[1] ~= nil and thisPoint[2] ~= nil and lastPoint[1] ~= nil and lastPoint[2] ~= nil then 
      draw.Line(thisPoint[1], thisPoint[2], lastPoint[1], lastPoint[2]); 
    end
    
  end
end

function moveToPos(cmd, pos)

local distance = vector.Distance(pos, {entities.GetLocalPlayer():GetAbsOrigin()})
if (distance < 0.1 ) then return end


local world_forward = {vector.Subtract( pos, {entities.GetLocalPlayer():GetAbsOrigin()} )}
local ang_LocalPlayer = {cmd:GetViewAngles()}

if (distance <= 1) then
cmd:SetForwardMove( ( (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[2]) + (math.cos(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 0.75 )
cmd:SetSideMove( ( (math.cos(math.rad(ang_LocalPlayer[2]) ) * -world_forward[2]) + (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 0.75 )
return
end

cmd:SetForwardMove( ( (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[2]) + (math.cos(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 300 )
cmd:SetSideMove( ( (math.cos(math.rad(ang_LocalPlayer[2]) ) * -world_forward[2]) + (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 300 )
end


local function get_closest_teammate()
local closest = nil
lowest_dist = 999999
local players = entities.FindByClass( "CCSPlayer" );
for k, v in pairs(players) do
local distance = vector.Distance(v:GetAbsOrigin(), {entities.GetLocalPlayer():GetAbsOrigin()})
if distance < lowest_dist and v:IsAlive() and tostring(v) ~= tostring(me) and v:GetTeamNumber() == me:GetTeamNumber() then
lowest_dist = distance
closest = v
end
end
return closest
end

function is_movement_keys_down()
if not target then return end
return target:IsAlive() or input.IsButtonDown( 87 ) or input.IsButtonDown( 65 ) or input.IsButtonDown( 83 ) or input.IsButtonDown( 68 ) or input.IsButtonDown( 32 )
end

function onEventMain(GameEvent)

DP_ON_TARGET_SHOT_VALUE = DP_ON_TARGET_SHOT:GetValue()
DP_ON_TARGET_SHOOTING_VALUE = DP_ON_TARGET_SHOOTING:GetValue()


if GameEvent:GetName() == "weapon_fire" and DP_ON_TARGET_SHOOTING_VALUE then
player_fired = entities.GetByUserID(GameEvent:GetInt("userid"))
if tostring(player_fired) == tostring(target) then
double_peek_delay = globals.CurTime() + DP_FOLLOW_LENGTH
end
elseif GameEvent:GetName() == "player_hurt" and DP_ON_TARGET_SHOT_VALUE then

victim = entities.GetByUserID(GameEvent:GetInt("userid"))
if tostring(victim) == tostring(target) then
double_peek_delay = globals.CurTime() + DP_FOLLOW_LENGTH
end
end
end

client.AllowListener("player_hurt")
client.AllowListener("weapon_fire")
callbacks.Register("FireGameEvent", onEventMain)



callbacks.Register("Draw", function()
showWindow()
target = get_closest_teammate()
has_target, err = pcall(function() target:GetAbsOrigin() end) -- idk how to handle this.. tried if target == nil then return end.. somehow gets passed this check and goes to drawCircle({target:GetAbsOrigin()}, 20) before going nil
if err and not has_target then return end

DP_DRAW_CIRCLE_VALUE = DP_DRAW_CIRCLE:GetValue()
DP_KEY_VALUE = DP_KEY:GetValue()



if DP_DRAW_CIRCLE ~= 0 then
drawCircle({target:GetAbsOrigin()}, 1)
drawCircle({target:GetAbsOrigin()}, 20)
end



end)





callbacks.Register("CreateMove", function(cmd)
if entities.GetLocalPlayer() == nil then return end
if not target then return end
if not is_movement_keys_down() then return end

has_target, err = pcall(function() target:GetAbsOrigin() end)
if err then return end

DP_KEY_VALUE = DP_KEY:GetValue()
if globals.CurTime() < double_peek_delay and input.IsButtonDown(DP_KEY_VALUE) then 
moveToPos(cmd, {target:GetAbsOrigin()})
end
end)