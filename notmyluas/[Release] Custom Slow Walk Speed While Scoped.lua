-- Scraped by chicken
-- Author: atk3001
-- Title [Release] Custom Slow Walk Speed While Scoped
-- Forum link https://aimware.net/forum/thread/133903

local ref = gui.Reference("RAGEBOT", "ACCURACY", "Movement")
local SLIDER = gui.Slider(ref, "lua_slowwalk_speed_zoom_slider", "Slow Walk Speed While Scoped", 30, 1, 100)
SLIDER:SetDescription("Scale movement speed by this value while scoped.")
local speed = gui.GetValue( "rbot.accuracy.movement.slowspeed")
local set

local player_local = entities.GetLocalPlayer();
local scoped = player_local:GetProp("m_bIsScoped")

if scoped ~= 0 and scoped ~= 256 then
  set = 1
elseif scoped == 0 or scoped == 256 then
  set = 0
end

callbacks.Register( "Draw", function()
if(entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
  local player_local = entities.GetLocalPlayer();
  local scoped = player_local:GetProp("m_bIsScoped")
  if scoped ~= 0 and scoped ~= 256 then
    if set == 1 then
      speed = gui.GetValue( "rbot.accuracy.movement.slowspeed")
      gui.SetValue( "rbot.accuracy.movement.slowspeed", SLIDER:GetValue() )
      set = 0
    end
  elseif scoped == 0 or scoped == 256 then
    if set == 0 then
      gui.SetValue( "rbot.accuracy.movement.slowspeed", speed )
      set = 1
    end
  end
end
end)



