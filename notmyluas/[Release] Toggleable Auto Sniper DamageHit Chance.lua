-- Scraped by chicken
-- Author: illusive101
-- Title [Release] Toggleable Auto Sniper Damage/Hit Chance
-- Forum link https://aimware.net/forum/thread/89915

local gui_set = gui.SetValue;
local gui_get = gui.GetValue;

local currentAccuracy = "NORMAL";
local currentWeapon = "empty";
local currentAutoMinDamage = nil;
local currentAutoHitChance = nil;
local currentScoutMinDamage = nil;
local currentScoutMinHitChance = nil;
local sharedConfig = gui_get("rbot_sharedweaponcfg");
local SetupAutoRef = nil;
local SetupScoutRef = nil;
local DamageToggGroupBox = nil;
local ScoutNormalHitChance = nil;
local ScoutNormalMinDamage = nil;
local ScoutLowHitChance = nil;
local ScoutLowMinDamage = nil;

local SetupRef = gui.Reference("RAGE", "MAIN", "Aimbot");
local SetupConfigGroupBox = gui.Groupbox(SetupRef, "Toggle Damage Settings", 0, 500, 213, 125)
local DamageMode = gui.Combobox(SetupConfigGroupBox, "lua_damage_mode", "Damage Mode", "Movement", "Toggle");
local DamageToggKeyBind = gui.Keybox(SetupConfigGroupBox, "lua_damageToggleKey", "Toggle Key", 88);
local DamageInAirRadio = gui.Checkbox(SetupConfigGroupBox, "lua_inair_mode", "Scout Low Accuracy In Air", 0);


-- check for shared config setup
if(sharedConfig == false) then
  SetupAutoRef = gui.Reference("RAGE", "WEAPON", "A. SNIPER", "Accuracy");
  SetupScoutRef = gui.Reference("RAGE", "WEAPON", "SCOUT", "Accuracy");
  DamageToggGroupBox = gui.Groupbox(SetupAutoRef, "Damage Toggle", 0, 310, 213, 220);
  ScoutDamageToggGroupBox = gui.Groupbox(SetupScoutRef, "Damage Toggle", 0, 310, 213, 220);
  currentAutoMinDamage = math.floor(gui_get("rbot_autosniper_mindamage") + 0.5);
  currentAutoHitChance = math.floor(gui_get("rbot_autosniper_hitchance") + 0.5);
  currentScoutMinDamage = math.floor(gui_get("rbot_scout_mindamage") + 0.5);
  currentScoutMinHitChance = math.floor(gui_get("rbot_scout_hitchance") + 0.5);

 -- scout setup
 ScoutNormalHitChance = gui.Slider(ScoutDamageToggGroupBox, "lua_scoutNormalHitChance", "Normal Hit Chance", currentScoutMinHitChance, 0, 100);
 ScoutNormalMinDamage = gui.Slider(ScoutDamageToggGroupBox, "lua_scoutNormalMinDamage", "Normal Damage", currentScoutMinDamage, 0, 100);
 ScoutLowHitChance = gui.Slider(ScoutDamageToggGroupBox, "lua_scoutLowHitChance", "Low Hit Chance", 70, 0, 100);
 ScoutLowMinDamage = gui.Slider(ScoutDamageToggGroupBox, "lua_scoutLowMinDamage", "Low Damage", 15, 0, 100);

else
  SetupAutoRef = gui.Reference("RAGE", "WEAPON", "SHARED", "Accuracy");
  DamageToggGroupBox = gui.Groupbox(SetupAutoRef, "Damage Toggle", 0, 400, 213, 245);
  currentAutoMinDamage = math.floor(gui_get("rbot_shared_mindamage") + 0.5);
  currentAutoHitChance = math.floor(gui_get("rbot_shared_hitchance") + 0.5);
end

-- auto setup
local NormalHitChance = gui.Slider(DamageToggGroupBox, "lua_normalHitChance", "Normal Hit Chance", currentAutoHitChance, 0, 100);
local NormalMinDamage = gui.Slider(DamageToggGroupBox, "lua_normalMinDamage", "Normal Damage", currentAutoMinDamage, 0, 100);
local LowHitChance = gui.Slider(DamageToggGroupBox, "lua_lowHitChance", "Low Hit Chance", 50, 0, 100);
local LowMinDamage = gui.Slider(DamageToggGroupBox, "lua_lowMinDamage", "Low Damage", 5, 0, 100);


function equipListener( Event ) 

  if ( Event:GetName() ~= "item_equip" ) then
    return;
  end

  local mPlayer = client.GetLocalPlayerIndex();
  local mPlayerID = Event:GetInt( "userid" );
  local mPlayerIndex = client.GetPlayerIndexByUserID(mPlayerID);

  if(mPlayer == mPlayerIndex) then

  local itemEquipped = Event:GetString("item");

  if (itemEquipped == "scar20" or itemEquipped == "g3sg1") then
  currentWeapon = "AUTO";
 elseif (itemEquipped == "ssg08") then
 currentWeapon = "SCOUT";
 else
 currentWeapon = "empty";
 end

  end

end

function reduceMain()

  currentMode = DamageMode:GetValue();

  if(currentWeapon == "SCOUT") then

    if (input.IsButtonPressed(DamageToggKeyBind:GetValue()) and currentWeapon ~= "empty") then

      local currentAccuracy = getAccuracy();

      if (currentAccuracy == "NORMAL") then
        setAccuracy("LOW");
      elseif (currentAccuracy == "LOW") then
        setAccuracy("NORMAL");
      else
        setAccuracy("NORMAL");
      end

    end

  else

   if(currentMode == 0) then

     currentPlayerStatus = getPlayerStatus();
     inAirMode = DamageInAirRadio:GetValue();

     if(inAirMode == true and currentPlayerStatus == "InAir" and currentWeapon == "SCOUT") then
       setAccuracy("LOW");
     elseif(currentPlayerStatus == "Moving" and currentWeapon == "AUTO") then
       setAccuracy("NORMAL");
     elseif(currentPlayerStatus == "Standing" and currentWeapon == "AUTO") then
       setAccuracy("LOW");
     else
       setAccuracy("NORMAL");
     end

   elseif(currentMode == 1) then

     if (input.IsButtonPressed(DamageToggKeyBind:GetValue()) and currentWeapon ~= "empty") then

       local currentAccuracy = getAccuracy();

       if (currentAccuracy == "NORMAL") then
         setAccuracy("LOW");
       elseif (currentAccuracy == "LOW") then
         setAccuracy("NORMAL");
       else
         setAccuracy("NORMAL");
       end

     end

   end

  end


end

function getAccuracy()
  return currentAccuracy;
end

function setAccuracy(newMode)

  if (sharedConfig == false) then

    if(newMode == "NORMAL") then
      gui_set("rbot_autosniper_hitchance", math.floor(NormalHitChance:GetValue() + 0.5));
      gui_set("rbot_autosniper_mindamage", math.floor(NormalMinDamage:GetValue() + 0.5));
      gui_set("rbot_scout_hitchance", math.floor(ScoutNormalHitChance:GetValue() + 0.5));
      gui_set("rbot_scout_mindamage", math.floor(ScoutNormalMinDamage:GetValue() + 0.5));
      currentAccuracy = "NORMAL";
    elseif(newMode == "LOW") then
      gui_set("rbot_autosniper_hitchance", math.floor(LowHitChance:GetValue() + 0.5));
      gui_set("rbot_autosniper_mindamage", math.floor(LowMinDamage:GetValue() + 0.5));
      gui_set("rbot_scout_hitchance", math.floor(ScoutLowHitChance:GetValue() + 0.5));
      gui_set("rbot_scout_mindamage", math.floor(ScoutLowMinDamage:GetValue() + 0.5));
      currentAccuracy = "LOW";
    end

  else

    if(newMode == "NORMAL") then
      gui_set("rbot_shared_hitchance", math.floor(NormalHitChance:GetValue() + 0.5));
      gui_set("rbot_shared_mindamage", math.floor(NormalMinDamage:GetValue() + 0.5));
      currentAccuracy = "NORMAL";
    elseif(newMode == "LOW") then
      gui_set("rbot_shared_hitchance", math.floor(LowHitChance:GetValue() + 0.5));
      gui_set("rbot_shared_mindamage", math.floor(LowMinDamage:GetValue() + 0.5));
      currentAccuracy = "LOW";
    end

  end

end

function drawMode()

  if(currentAccuracy == "NORMAL" and currentWeapon ~= "empty") then
  if(currentWeapon == "AUTO") then
     draw.Color(66,244,78,255);
     draw.Text(10,615, "Accuracy: NORMAL");
     draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
     draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
  elseif(currentWeapon == "SCOUT") then
  if(sharedConfig == false) then
     draw.Color(66,244,78,255);
     draw.Text(10,615, "Accuracy: NORMAL");
     draw.Text(10, 630, "Hit Chance: " .. math.floor(ScoutNormalHitChance:GetValue() + 0.5) .. "%");
     draw.Text(10, 645, "Min Damage: " .. math.floor(ScoutNormalMinDamage:GetValue() + 0.5));
   else
     draw.Color(66,244,78,255);
     draw.Text(10,615, "Accuracy: NORMAL");
     draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
     draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
   end
  end
  elseif(currentAccuracy == "LOW" and currentWeapon ~= "empty") then
  if(currentWeapon == "AUTO") then
     draw.Color(223,244,66,255);
     draw.Text(10,615, "Accuracy: LOW");
     draw.Text(10, 630, "Hit Chance: " .. math.floor(LowHitChance:GetValue() + 0.5) .. "%");
     draw.Text(10, 645, "Min Damage: " .. math.floor(LowMinDamage:GetValue() + 0.5));
  elseif(currentWeapon == "SCOUT") then
  if(sharedConfig == false) then
     draw.Color(223,244,66,255);
     draw.Text(10,615, "Accuracy: LOW");
     draw.Text(10, 630, "Hit Chance: " .. math.floor(ScoutLowHitChance:GetValue() + 0.5) .. "%");
     draw.Text(10, 645, "Min Damage: " .. math.floor(ScoutLowMinDamage:GetValue() + 0.5));
  else
     draw.Color(223,244,66,255);
     draw.Text(10,615, "Accuracy: LOW");
     draw.Text(10, 630, "Hit Chance: " .. math.floor(LowHitChance:GetValue() + 0.5) .. "%");
     draw.Text(10, 645, "Min Damage: " .. math.floor(LowMinDamage:GetValue() + 0.5));
  end
  end
  else
    draw.Color(244,66,66,255);
    draw.Text(10,615, "Auto/Scout Not Equipped");
  end

end

function getPlayerStatus()

  if entities.GetLocalPlayer() ~= nil then

    local localPlayer = entities.GetLocalPlayer();
    local localPlayerFlags = localPlayer:GetProp("m_fFlags");

    local xVel = localPlayer:GetPropFloat("localdata", "m_vecVelocity[0]");
    local yVel = localPlayer:GetPropFloat("localdata", "m_vecVelocity[1]");

    local playerVelocity = math.sqrt(xVel^2 + yVel^2);

    if (localPlayerFlags == 256 or localPlayerFlags == 262) then
      return "InAir";
    end

    if (playerVelocity == 0 and (localPlayerFlags == 257 or localPlayerFlags == 261 or localPlayerFlags == 263)) then
      return "Standing";
    end

    if (playerVelocity > 0 and (localPlayerFlags == 257 or localPlayerFlags == 261 or localPlayerFlags == 263)) then
      return "Moving";
    end

  end

end

client.AllowListener("item_equip");

callbacks.Register("FireGameEvent", "equipListener", equipListener);

callbacks.Register("Draw", "Check Movement", getPlayerStatus);
callbacks.Register("Draw", "reduceMain", reduceMain);
callbacks.Register("Draw", "setAccuracy", setAccuracy);
callbacks.Register("Draw", "getAccuracy", getAccuracy);
callbacks.Register("Draw", "drawMode", drawMode);