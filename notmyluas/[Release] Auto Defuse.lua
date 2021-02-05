-- Scraped by chicken
-- Author: mshkreli
-- Title [Release] Auto Defuse
-- Forum link https://aimware.net/forum/thread/104749

local ENABLE_AUTODEFUSER = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "Other"), "ENABLE_AUTODEFUSER", "Enable Autodefuser", false);

local AUTODEFUSER_DEFUSE_SAFETY = 0.07; -- increase this if it defuses too late 

local function moveEventHandler(UserCmd)
  if (ENABLE_AUTODEFUSER:GetValue() == true and entities.GetLocalPlayer():GetTeamNumber() == 3) then
    -- Find the bomb
    local bombs = entities.FindByClass("CPlantedC4");
    local bomb;
    for i=1, #bombs do
      if (bombs[i]:IsAlive()) then
        bomb = bombs[i];
      end
    end
    
    -- We have a bomb
    if (bomb ~= nil) then
      local bx, by, bz = bomb:GetAbsOrigin();
      
      local my_x, my_y, my_z = entities.GetLocalPlayer():GetAbsOrigin();
      local distance = getDistanceToTarget(my_x, my_y, 0, bx, by, 0);

      local explosion = bomb:GetPropFloat("m_flC4Blow") - globals.CurTime();

      -- Calculate when to defuse
      local treshold = 10 + AUTODEFUSER_DEFUSE_SAFETY;
      if (entities.GetLocalPlayer():GetPropBool("m_bHasDefuser") == true) then
        treshold = 5 + AUTODEFUSER_DEFUSE_SAFETY;
      end

      -- Defuse if all criterias are met
      if (distance < 75 and is_defusing == false and explosion < treshold) then
        is_defusing = true;
        client.Command("+use", true);
        return;
      end

      is_defusing = false;
    end
  end
end

local function gameEventHandler(event)
  local lPIndex = client.GetLocalPlayerIndex();
  local deathIndex = client.GetPlayerIndexByUserID(event:GetInt('userid'));
  
  if event:GetName() == "player_death" and lpIndex == deathIndex then
    client.Command("-use", true); -- stop defusing if we die
    return;
  end

  if ENABLE_AUTODEFUSER:GetValue() == false or entities.GetLocalPlayer():GetTeamNumber() ~= 3 then
    return;
  end
  client.Command("-use", true); -- stop defusing if the round ends
end

function getDistanceToTarget(my_x, my_y, my_z, t_x, t_y, t_z)
  local dx = my_x - t_x;
  local dy = my_y - t_y;
  local dz = my_z - t_z;
  return math.sqrt(dx^2 + dy^2 + dz^2);
end

client.AllowListener("round_officially_ended");
client.AllowListener("player_death");

callbacks.Register("FireGameEvent", gameEventHandler);
callbacks.Register("CreateMove", moveEventHandler);



