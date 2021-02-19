-- Scraped by chicken
-- Author: JohnK.
-- Title [Release] Slow Walk Indicator
-- Forum link https://aimware.net/forum/thread/102001

local entity;
local Standing = "";
local Moving = "";
local InAir = "";
local SlowWalk = "";
local time = 0;
local time1 = 0;
local speed_bar = gui.Combobox(gui.Reference('VISUALS', "ENEMIES", "Options"), "speed_bar", "Show Speed", "Off", "Bar", "Number", "Both");
local Moving_box = gui.Combobox(gui.Reference('VISUALS', "ENEMIES", "Options"), "Moving_box", "Velocity Flag", "Off", "Show Slow Walk", "Show all modes");
local gui_color = gui.ColorEntry("random_speed_shit_color","Velocity Flag",255,0,0,255)


function speed_stuff()



  if entity ~= nil then

    if entity:IsAlive() and entity:IsPlayer() then

      local fFlags = entity:GetProp("m_fFlags");

      local VelocityX = entity:GetPropFloat("localdata", "m_vecVelocity[0]");
      local VelocityY = entity:GetPropFloat("localdata", "m_vecVelocity[1]");

      local Velocity = math.sqrt(VelocityX ^ 2 + VelocityY ^ 2);
      local FL_DUCKING = (1<<1);
      local FL_STADNING = (1<<0);

      if math.floor(Velocity + 0.5) <= 1 and ((fFlags & FL_DUCKING) == FL_DUCKING or (fFlags & FL_STADNING) == FL_STADNING) then
        Standing = "Standing";
        time = globals.CurTime();
      else
        Standing = "";
      end;

      if math.floor(Velocity + 0.5) >= 95 and ((fFlags & FL_DUCKING) ~= FL_DUCKING and (fFlags & FL_STADNING) == FL_STADNING) and time1 + 0.5 < globals.CurTime() then
        time = globals.CurTime();
        Moving = "Moving";
        SlowWalk = "";
      elseif (math.floor(Velocity + 0.5) <= 95 and math.floor(Velocity + 0.5) >= 36) and ((fFlags & FL_DUCKING) == FL_DUCKING and (fFlags & FL_STADNING) == FL_STADNING) and time1 + 0.5 < globals.CurTime() then
        Moving = "Moving";
        SlowWalk = "";
      elseif (math.floor(Velocity + 0.5) <= 95 and math.floor(Velocity + 0.5) > 1) and ((fFlags & FL_DUCKING) ~= FL_DUCKING and (fFlags & FL_STADNING) == FL_STADNING) and time + 0.25 < globals.CurTime() then
        SlowWalk = "Slow Walking";
        Moving = "";
      elseif (math.floor(Velocity + 0.5) <= 36 and math.floor(Velocity + 0.5) > 1) and ((fFlags & FL_DUCKING) == FL_DUCKING and (fFlags & FL_STADNING) == FL_STADNING) and time + 0.7 < globals.CurTime() then
        SlowWalk = "Slow Walking";
        Moving = "";
      else
        Moving = "";
        SlowWalk = ""
      end
      if (fFlags & FL_STADNING) ~= FL_STADNING then
        InAir = "In Air";
        time1 = globals.CurTime();
      else
        InAir = "";
      end;
      return math.floor(Velocity + 0.5);
    end;
  end;
end;


local function debug_builder(Builder)


  maxspeed = tonumber(client.GetConVar("sv_maxspeed"));
  entity = Builder:GetEntity();
  local speed = speed_bar:GetValue();
  local mode = Moving_box:GetValue();

  if entities.GetLocalPlayer():GetTeamNumber() ~= entity:GetTeamNumber() then

    Builder:Color(gui_color:GetValue());
    if speed_stuff() ~= nil and entity:IsPlayer() then
      if speed == 1 then
        Builder:AddBarLeft((speed_stuff() / maxspeed));
      elseif speed == 2 then
        Builder:AddTextBottom(speed_stuff());
      elseif speed == 3 then
        Builder:AddTextBottom(speed_stuff());
        Builder:AddBarLeft((speed_stuff() / maxspeed));
      end;
      if mode == 1 then
        Builder:AddTextTop(SlowWalk);
      elseif mode == 2 then
        Builder:AddTextTop(Moving .. Standing .. InAir .. SlowWalk);
      end;
    end;
  end;
end;

callbacks.Register("DrawESP", "debug_builder", debug_builder);