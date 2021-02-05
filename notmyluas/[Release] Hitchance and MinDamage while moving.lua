-- Scraped by chicken
-- Author: Izi hax
-- Title [Release] Hitchance and MinDamage while moving
-- Forum link https://aimware.net/forum/thread/121248


local gui_set = gui.SetValue;
local gui_get = gui.GetValue;

local currentAccuracy = "MOVING";
local currentWeapon = "empty";
local currentAutoMinDamage = nil;
local currentAutoHitChance = nil;
local currentScoutMinDamage = nil;
local currentScoutMinHitChance = nil;
local sharedConfig = gui_get("rbot_sharedweaponcfg");
local SetupAutoRef = nil;
local SetupScoutRef = nil;
local DamageToggGroupBox = nil;
local ScoutMOVINGHitChance = nil;
local ScoutMOVINGMinDamage = nil;
local ScoutNormalHitChance = nil;
local ScoutNormalMinDamage = nil;

local SetupRef = gui.Reference("RAGE", "MAIN", "Aimbot");
local SetupConfigGroupBox = gui.Groupbox(SetupRef, "Toggle Damage Settings")
local DamageMode = gui.Combobox(SetupConfigGroupBox, "lua_damage_mode", "Damage Mode", "Movement", "Toggle");
local DamageToggKeyBind = gui.Keybox(SetupConfigGroupBox, "lua_damageToggleKey", "Toggle Key", 88);


-- check for shared config setup
if(sharedConfig == false) then
  SetupAutoRef = gui.Reference("RAGE", "WEAPON", "A. SNIPER", "Accuracy");
SetupAwpRef = gui.Reference("RAGE", "WEAPON", "SNIPER", "Accuracy");
  SetupScoutRef = gui.Reference("RAGE", "WEAPON", "SCOUT", "Accuracy");
SetupPistolRef = gui.Reference("RAGE", "WEAPON", "PISTOL", "Accuracy");
  SetupSmgRef = gui.Reference("RAGE", "WEAPON", "SMG", "Accuracy");
SetupRevolverRef = gui.Reference("RAGE", "WEAPON", "REVOLVER", "Accuracy");
  SetupRifleRef = gui.Reference("RAGE", "WEAPON", "RIFLE", "Accuracy");
SetupShotgunRef = gui.Reference("RAGE", "WEAPON", "SHOTGUN", "Accuracy");
SetupLmgRef = gui.Reference("RAGE", "WEAPON", "LMG", "Accuracy");

DamageInAirScout = gui.Checkbox(SetupScoutRef, "lua_inair_mode", "Scout Normal Accuracy In Air", false);
DamageInAirAuto = gui.Checkbox(SetupAutoRef, "lua_inair1_mode", "Auto Normal Accuracy In Air", false);
DamageInAirPistol = gui.Checkbox(SetupPistolRef, "lua_inair2_mode", "Pistol Normal Accuracy In Air", false);
DamageInAirSmg = gui.Checkbox(SetupSmgRef, "lua_inair3_mode", "Smg Normal Accuracy In Air", false);
DamageInAirRevolver = gui.Checkbox(SetupRevolverRef, "lua_inair4_mode", "Revolver Normal Accuracy In Air", false);
DamageInAirShotgun = gui.Checkbox(SetupShotgunRef, "lua_inair5_mode", "Shotgun Normal Accuracy In Air", false);
DamageInAirLmg = gui.Checkbox(SetupLmgRef, "lua_inair6_mode", "Lmg Normal Accuracy In Air", false);
DamageInAirRifle = gui.Checkbox(SetupRifleRef, "lua_inair7_mode", "Rifle Normal Accuracy In Air", false);


  DamageToggGroupBox = gui.Groupbox(SetupAutoRef, "Damage Toggle");
  ScoutDamageToggGroupBox = gui.Groupbox(SetupScoutRef, "Damage Toggle");
AwpDamageToggGroupBox = gui.Groupbox(SetupAwpRef, "Damage Toggle");
PistolDamageToggGroupBox = gui.Groupbox(SetupPistolRef, "Damage Toggle");
SmgDamageToggGroupBox = gui.Groupbox(SetupSmgRef, "Damage Toggle");
RevolverDamageToggGroupBox = gui.Groupbox(SetupRevolverRef, "Damage Toggle");
RifleDamageToggGroupBox = gui.Groupbox(SetupRifleRef, "Damage Toggle");
ShotgunDamageToggGroupBox = gui.Groupbox(SetupShotgunRef, "Damage Toggle");
LmgDamageToggGroupBox = gui.Groupbox(SetupLmgRef, "Damage Toggle");


  currentAutoMinDamage = math.floor(gui_get("rbot_autosniper_mindamage") + 0.5);
  currentAutoHitChance = math.floor(gui_get("rbot_autosniper_hitchance") + 0.5);
currentAwpMinDamage = math.floor(gui_get("rbot_sniper_mindamage") + 0.5);
  currentAwpHitChance = math.floor(gui_get("rbot_sniper_hitchance") + 0.5);
  currentPistolMinDamage = math.floor(gui_get("rbot_pistol_mindamage") + 0.5);
  currentPistolMinHitChance = math.floor(gui_get("rbot_pistol_hitchance") + 0.5);
currentSmgMinDamage = math.floor(gui_get("rbot_smg_mindamage") + 0.5);
  currentSmgMinHitChance = math.floor(gui_get("rbot_smg_hitchance") + 0.5);
currentRevolverMinDamage = math.floor(gui_get("rbot_revolver_mindamage") + 0.5);
  currentRevolverMinHitChance = math.floor(gui_get("rbot_revolver_hitchance") + 0.5);
currentRifleMinDamage = math.floor(gui_get("rbot_rifle_mindamage") + 0.5);
  currentRifleMinHitChance = math.floor(gui_get("rbot_rifle_hitchance") + 0.5);
currentScoutMinDamage = math.floor(gui_get("rbot_scout_mindamage") + 0.5);
  currentScoutMinHitChance = math.floor(gui_get("rbot_scout_hitchance") + 0.5);
currentShotgunMinDamage = math.floor(gui_get("rbot_shotgun_mindamage") + 0.5);
  currentShotgunHitChance = math.floor(gui_get("rbot_shotgun_hitchance") + 0.5);
currentLmgMinDamage = math.floor(gui_get("rbot_lmg_mindamage") + 0.5);
  currentLmgHitChance = math.floor(gui_get("rbot_lmg_hitchance") + 0.5);

-- scout setup
ScoutMOVINGHitChance = gui.Slider(ScoutDamageToggGroupBox, "lua_scoutMOVINGHitChance", "MOVING Hit Chance", currentScoutMinHitChance, 0, 100);
ScoutMOVINGMinDamage = gui.Slider(ScoutDamageToggGroupBox, "lua_scoutMOVINGMinDamage", "MOVING Damage", currentScoutMinDamage, 0, 100);
ScoutNormalHitChance = gui.Slider(ScoutDamageToggGroupBox, "lua_scoutNormalHitChance", "Normal Hit Chance", 70, 0, 100);
ScoutNormalMinDamage = gui.Slider(ScoutDamageToggGroupBox, "lua_scoutNormalMinDamage", "Normal Damage", 15, 0, 100);

else

  SetupAutoRef = gui.Reference("RAGE", "WEAPON", "SHARED", "Accuracy");
  DamageToggGroupBox = gui.Groupbox(SetupAutoRef, "Damage Toggle");
  currentAutoMinDamage = math.floor(gui_get("rbot_shared_mindamage") + 0.5);
  currentAutoHitChance = math.floor(gui_get("rbot_shared_hitchance") + 0.5);
end





-- auto setup
local MOVINGHitChance = gui.Slider(DamageToggGroupBox, "lua_MOVINGHitChance", "MOVING Hit Chance", currentAutoHitChance, 0, 100);
local MOVINGMinDamage = gui.Slider(DamageToggGroupBox, "lua_MOVINGMinDamage", "MOVING Damage", currentAutoMinDamage, 0, 100);
local NormalHitChance = gui.Slider(DamageToggGroupBox, "lua_NormalHitChance", "Normal Hit Chance", 40, 0, 100);
local NormalMinDamage = gui.Slider(DamageToggGroupBox, "lua_NormalMinDamage", "Normal Damage", 20, 0, 100);

--RIFLE

local RifleMOVINGHitChance = gui.Slider(RifleDamageToggGroupBox, "lua_rifleMOVINGHitChance", "MOVING Hit Chance", currentRifleMinHitChance, 0, 100);
local RifleMOVINGMinDamage = gui.Slider(RifleDamageToggGroupBox, "lua_rifleMOVINGMinDamage", "MOVING Damage", currentRifleMinDamage, 0, 100);
local RifleNormalHitChance = gui.Slider(RifleDamageToggGroupBox, "lua_rifleNormalHitChance", "Normal Hit Chance", 35, 0, 100);
local RifleNormalMinDamage = gui.Slider(RifleDamageToggGroupBox, "lua_rifleNormalMinDamage", "Normal Damage", 25, 0, 100);

--REVOLVER

local RevolverMOVINGHitChance = gui.Slider(RevolverDamageToggGroupBox, "lua_revolverMOVINGHitChance", "MOVING Hit Chance", currentRevolverMinHitChance, 0, 100);
local RevolverMOVINGMinDamage = gui.Slider(RevolverDamageToggGroupBox, "lua_revolverMOVINGMinDamage", "MOVING Damage", currentRevolverMinDamage, 0, 100);
local RevolverNormalHitChance = gui.Slider(RevolverDamageToggGroupBox, "lua_revolverNormalHitChance", "Normal Hit Chance", 25, 0, 100);
local RevolverNormalMinDamage = gui.Slider(RevolverDamageToggGroupBox, "lua_revolverNormalMinDamage", "Normal Damage", 25, 0, 100);

--SMG

local SmgMOVINGHitChance = gui.Slider(SmgDamageToggGroupBox, "lua_smgMOVINGHitChance", "MOVING Hit Chance", currentSmgMinHitChance, 0, 100);
local SmgMOVINGMinDamage = gui.Slider(SmgDamageToggGroupBox, "lua_smgMOVINGMinDamage", "MOVING Damage", currentSmgMinDamage, 0, 100);
local SmgNormalHitChance = gui.Slider(SmgDamageToggGroupBox, "lua_smgNormalHitChance", "Normal Hit Chance", 15, 0, 100);
local SmgNormalMinDamage = gui.Slider(SmgDamageToggGroupBox, "lua_smgNormalMinDamage", "Normal Damage", 20, 0, 100);

--PISTOL
local PistolMOVINGHitChance = gui.Slider(PistolDamageToggGroupBox, "lua_pistolMOVINGHitChance", "MOVING Hit Chance", currentPistolMinHitChance, 0, 100);
local PistolMOVINGMinDamage = gui.Slider(PistolDamageToggGroupBox, "lua_pistolMOVINGMinDamage", "MOVING Damage", currentPistolMinDamage, 0, 100);
local PistolNormalHitChance = gui.Slider(PistolDamageToggGroupBox, "lua_pistolNormalHitChance", "Normal Hit Chance", 30, 0, 100);
local PistolNormalMinDamage = gui.Slider(PistolDamageToggGroupBox, "lua_pistolNormalMinDamage", "Normal Damage", 20, 0, 100);

--AWP
local AwpMOVINGHitChance = gui.Slider(AwpDamageToggGroupBox, "lua_sniperMOVINGHitChance", "MOVING Hit Chance", currentAwpMinHitChance, 0, 100);
local AwpMOVINGMinDamage = gui.Slider(AwpDamageToggGroupBox, "lua_sniperMOVINGMinDamage", "MOVING Damage", currentAwpMinDamage, 0, 100);
local AwpNormalHitChance = gui.Slider(AwpDamageToggGroupBox, "lua_sniperNormalHitChance", "Normal Hit Chance", 55, 0, 100);
local AwpNormalMinDamage = gui.Slider(AwpDamageToggGroupBox, "lua_sniperNormalMinDamage", "Normal Damage", 40, 0, 100);

--Shotgun
local ShotgunMOVINGHitChance = gui.Slider(ShotgunDamageToggGroupBox, "lua_shotgunMOVINGHitChance", "MOVING Hit Chance", currentShotgunMinHitChance, 0, 100);
local ShotgunMOVINGMinDamage = gui.Slider(ShotgunDamageToggGroupBox, "lua_shotgunMOVINGMinDamage", "MOVING Damage", currentShotgunMinDamage, 0, 100);
local ShotgunNormalHitChance = gui.Slider(ShotgunDamageToggGroupBox, "lua_shotgunNormalHitChance", "Normal Hit Chance", 10, 0, 100);
local ShotgunNormalMinDamage = gui.Slider(ShotgunDamageToggGroupBox, "lua_shotgunNormalMinDamage", "Normal Damage", 20, 0, 100);

--Lmg
local LmgMOVINGHitChance = gui.Slider(LmgDamageToggGroupBox, "lua_lmgMOVINGHitChance", "MOVING Hit Chance", currentLmgMinHitChance, 0, 100);
local LmgMOVINGMinDamage = gui.Slider(LmgDamageToggGroupBox, "lua_lmgMOVINGMinDamage", "MOVING Damage", currentLmgMinDamage, 0, 100);
local LmgNormalHitChance = gui.Slider(LmgDamageToggGroupBox, "lua_lmgNormalHitChance", "Normal Hit Chance", 10, 0, 100);
local LmgNormalMinDamage = gui.Slider(LmgDamageToggGroupBox, "lua_lmgNormalMinDamage", "Normal Damage", 20, 0, 100);

function equipListener( Event ) 

  if ( Event:GetName() ~= "item_equip" ) then
    return;
  end

  local mPlayer = client.GetLocalPlayerIndex();
  local mPlayerID = Event:GetInt( "userid" );
  local mPlayerIndex = client.GetPlayerIndexByUserID(mPlayerID);
  if(mPlayer == mPlayerIndex) then

    local itemEquipped = Event:GetString("item");
local WepType = Event:GetInt("weptype");
    if (itemEquipped == "scar20" or itemEquipped == "g3sg1") then
      currentWeapon = "AUTO";
    elseif (itemEquipped == "ssg08") then
      currentWeapon = "SCOUT";
  elseif (itemEquipped == "tec9" or itemEquipped == "elite" or itemEquipped == "fiveseven" or itemEquipped == "glock" or itemEquipped == "hkp2000" or itemEquipped == "p250" or itemEquipped == "cz75a" or itemEquipped == "usp_silencer") then 
      currentWeapon = "PISTOL";
  elseif (WepType == 3) then
      currentWeapon = "RIFLE";
elseif (WepType == 2) then
      currentWeapon = "SMG";
elseif (itemEquipped == "revolver" or itemEquipped == "deagle") then
      currentWeapon = "REVOLVER";
elseif (itemEquipped == "awp") then
      currentWeapon = "AWP";
  elseif (WepType == 4) then
      currentWeapon = "SHOTGUN";
  elseif (WepType == 6) then
      currentWeapon = "LMG";
    else
      currentWeapon = "empty";
    end

  end

end

function reduceMain()

  
inAirModeAuto = DamageInAirAuto:GetValue();
inAirModeScout = DamageInAirScout:GetValue();
inAirModePistol = DamageInAirPistol:GetValue();
inAirModeSmg = DamageInAirSmg:GetValue();
inAirModeRevolver = DamageInAirRevolver:GetValue();
inAirModeShotgun = DamageInAirShotgun:GetValue();
inAirModeLmg = DamageInAirLmg:GetValue();
inAirModeRifle = DamageInAirRifle:GetValue();

currentMode = DamageMode:GetValue();
if(currentMode == 1) then

      if (input.IsButtonPressed(DamageToggKeyBind:GetValue()) and currentWeapon ~= "empty") then

        local currentAccuracy = getAccuracy();

        if (currentAccuracy == "MOVING") then
          setAccuracy("Normal");
       
  elseif (currentAccuracy == "Normal") then
          setAccuracy("MOVING");
        else
          setAccuracy("MOVING");
       end
 end
  else

    if(currentMode == 0) then

      currentPlayerStatus = getPlayerStatus();
if(inAirModeScout == true and currentPlayerStatus == "InAir" and currentWeapon == "SCOUT") then
        setAccuracy("Normal");
elseif(inAirModeAuto == true and currentPlayerStatus == "InAir" and currentWeapon == "AUTO") then
        setAccuracy("Normal");
elseif(inAirModePistol == true and currentPlayerStatus == "InAir" and currentWeapon == "PISTOL") then
        setAccuracy("Normal");
elseif(inAirModeSmg == true and currentPlayerStatus == "InAir" and currentWeapon == "SMG") then
        setAccuracy("Normal");
elseif(inAirModeRevolver == true and currentPlayerStatus == "InAir" and currentWeapon == "REVOLVER") then
        setAccuracy("Normal");
elseif(inAirModeShotgun == true and currentPlayerStatus == "InAir" and currentWeapon == "SHOTGUN") then
        setAccuracy("Normal");
elseif(inAirModeLmg == true and currentPlayerStatus == "InAir" and currentWeapon == "LMG") then
        setAccuracy("Normal");
elseif(inAirModeRifle == true and currentPlayerStatus == "InAir" and currentWeapon == "RIFLE") then
        setAccuracy("Normal");

elseif(currentPlayerStatus == "Moving" and currentWeapon == "SCOUT") then
        setAccuracy("MOVING");
      elseif(currentPlayerStatus == "Standing" and currentWeapon == "SCOUT") then
        setAccuracy("Normal");
      elseif(currentPlayerStatus == "Moving" and currentWeapon == "AUTO") then
        setAccuracy("MOVING");
      elseif(currentPlayerStatus == "Standing" and currentWeapon == "AUTO") then
        setAccuracy("Normal");
  elseif(currentPlayerStatus == "Moving" and currentWeapon == "RIFLE") then
        setAccuracy("MOVING");
      elseif(currentPlayerStatus == "Standing" and currentWeapon == "RIFLE") then
        setAccuracy("Normal");
elseif(currentPlayerStatus == "Moving" and currentWeapon == "REVOLVER") then
        setAccuracy("MOVING");
      elseif(currentPlayerStatus == "Standing" and currentWeapon == "REVOLVER") then
        setAccuracy("Normal");
elseif(currentPlayerStatus == "Moving" and currentWeapon == "SMG") then
        setAccuracy("MOVING");
      elseif(currentPlayerStatus == "Standing" and currentWeapon == "SMG") then
        setAccuracy("Normal");
elseif(currentPlayerStatus == "Moving" and currentWeapon == "PISTOL") then
        setAccuracy("MOVING");
      elseif(currentPlayerStatus == "Standing" and currentWeapon == "PISTOL") then
        setAccuracy("Normal");
elseif(currentPlayerStatus == "Moving" and currentWeapon == "AWP") then
        setAccuracy("MOVING");
      elseif(currentPlayerStatus == "Standing" and currentWeapon == "AWP") then
        setAccuracy("Normal");
elseif(currentPlayerStatus == "Moving" and currentWeapon == "SHOTGUN") then
        setAccuracy("MOVING");
      elseif(currentPlayerStatus == "Standing" and currentWeapon == "SHOTGUN") then
        setAccuracy("Normal");
elseif(currentPlayerStatus == "Moving" and currentWeapon == "LMG") then
        setAccuracy("MOVING");
      elseif(currentPlayerStatus == "Standing" and currentWeapon == "LMG") then
        setAccuracy("Normal");
      else
        setAccuracy("MOVING");
      end


    end

  end
end

function getAccuracy()
  return currentAccuracy;
end

function setAccuracy(newMode)

  if (sharedConfig == false) then

    if(newMode == "MOVING") then
      gui_set("rbot_autosniper_hitchance", math.floor(MOVINGHitChance:GetValue() + 0.5));
      gui_set("rbot_autosniper_mindamage", math.floor(MOVINGMinDamage:GetValue() + 0.5));
      gui_set("rbot_scout_hitchance", math.floor(ScoutMOVINGHitChance:GetValue() + 0.5));
      gui_set("rbot_scout_mindamage", math.floor(ScoutMOVINGMinDamage:GetValue() + 0.5));
gui_set("rbot_rifle_hitchance", math.floor(RifleMOVINGHitChance:GetValue() + 0.5));
      gui_set("rbot_rifle_mindamage", math.floor(RifleMOVINGMinDamage:GetValue() + 0.5));
gui_set("rbot_revolver_hitchance", math.floor(RevolverMOVINGHitChance:GetValue() + 0.5));
      gui_set("rbot_revolver_mindamage", math.floor(RevolverMOVINGMinDamage:GetValue() + 0.5));
gui_set("rbot_pistol_hitchance", math.floor(PistolMOVINGHitChance:GetValue() + 0.5));
      gui_set("rbot_pistol_mindamage", math.floor(PistolMOVINGMinDamage:GetValue() + 0.5));
gui_set("rbot_smg_hitchance", math.floor(SmgMOVINGHitChance:GetValue() + 0.5));
      gui_set("rbot_smg_mindamage", math.floor(SmgMOVINGMinDamage:GetValue() + 0.5));
gui_set("rbot_sniper_hitchance", math.floor(AwpMOVINGHitChance:GetValue() + 0.5));
      gui_set("rbot_sniper_mindamage", math.floor(AwpMOVINGMinDamage:GetValue() + 0.5));
gui_set("rbot_shotgun_hitchance", math.floor(ShotgunMOVINGHitChance:GetValue() + 0.5));
      gui_set("rbot_shotgun_mindamage", math.floor(ShotgunMOVINGMinDamage:GetValue() + 0.5));
gui_set("rbot_lmg_hitchance", math.floor(LmgMOVINGHitChance:GetValue() + 0.5));
      gui_set("rbot_lmg_mindamage", math.floor(LmgMOVINGMinDamage:GetValue() + 0.5));
      currentAccuracy = "MOVING";
    elseif(newMode == "Normal") then
      gui_set("rbot_autosniper_hitchance", math.floor(NormalHitChance:GetValue() + 0.5));
      gui_set("rbot_autosniper_mindamage", math.floor(NormalMinDamage:GetValue() + 0.5));
      gui_set("rbot_scout_hitchance", math.floor(ScoutNormalHitChance:GetValue() + 0.5));
      gui_set("rbot_scout_mindamage", math.floor(ScoutNormalMinDamage:GetValue() + 0.5));
gui_set("rbot_rifle_hitchance", math.floor(RifleNormalHitChance:GetValue() + 0.5));
      gui_set("rbot_rifle_mindamage", math.floor(RifleNormalMinDamage:GetValue() + 0.5));
gui_set("rbot_revolver_hitchance", math.floor(RevolverNormalHitChance:GetValue() + 0.5));
      gui_set("rbot_revolver_mindamage", math.floor(RevolverNormalMinDamage:GetValue() + 0.5));
gui_set("rbot_pistol_hitchance", math.floor(PistolNormalHitChance:GetValue() + 0.5));
      gui_set("rbot_pistol_mindamage", math.floor(PistolNormalMinDamage:GetValue() + 0.5));
gui_set("rbot_smg_hitchance", math.floor(SmgNormalHitChance:GetValue() + 0.5));
      gui_set("rbot_smg_mindamage", math.floor(SmgNormalMinDamage:GetValue() + 0.5));
gui_set("rbot_sniper_hitchance", math.floor(AwpNormalHitChance:GetValue() + 0.5));
      gui_set("rbot_sniper_mindamage", math.floor(AwpNormalMinDamage:GetValue() + 0.5));
gui_set("rbot_shotgun_hitchance", math.floor(ShotgunNormalHitChance:GetValue() + 0.5));
      gui_set("rbot_shotgun_mindamage", math.floor(ShotgunNormalMinDamage:GetValue() + 0.5));
gui_set("rbot_lmg_hitchance", math.floor(LmgNormalHitChance:GetValue() + 0.5));
      gui_set("rbot_lmg_mindamage", math.floor(LmgNormalMinDamage:GetValue() + 0.5));
      currentAccuracy = "Normal";
    end

  else

    if(newMode == "MOVING") then
      gui_set("rbot_shared_hitchance", math.floor(MOVINGHitChance:GetValue() + 0.5));
      gui_set("rbot_shared_mindamage", math.floor(MOVINGMinDamage:GetValue() + 0.5));
      currentAccuracy = "MOVING";
    elseif(newMode == "Normal") then
      gui_set("rbot_shared_hitchance", math.floor(NormalHitChance:GetValue() + 0.5));
      gui_set("rbot_shared_mindamage", math.floor(NormalMinDamage:GetValue() + 0.5));
      currentAccuracy = "Normal";
    end

  end

end

function drawMode()

  if(currentAccuracy == "MOVING" and currentWeapon ~= "empty") then
    if(currentWeapon == "AUTO") then
      draw.Color(128,255,0,255);
      draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
      draw.Text(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
      draw.Text(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
    elseif(currentWeapon == "SCOUT") then
      if(sharedConfig == false) then
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(ScoutMOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(ScoutMOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(ScoutMOVINGMinDamage:GetValue() + 0.5));
        draw.TextShadow(10, 645, "Min Damage: " .. math.floor(ScoutMOVINGMinDamage:GetValue() + 0.5));
      else
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "RIFLE") then
      if(sharedConfig == false) then
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(RifleMOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(RifleMOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(RifleMOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(RifleMOVINGMinDamage:GetValue() + 0.5));
      else
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "REVOLVER") then
      if(sharedConfig == false) then
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(RevolverMOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(RevolverMOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(RevolverMOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(RevolverMOVINGMinDamage:GetValue() + 0.5));
      else
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "PISTOL") then
      if(sharedConfig == false) then
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(PistolMOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(PistolMOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(PistolMOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(PistolMOVINGMinDamage:GetValue() + 0.5));
      else
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "SMG") then
      if(sharedConfig == false) then
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(SmgMOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(SmgMOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(SmgMOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(SmgMOVINGMinDamage:GetValue() + 0.5));
      else
        draw.Color(66,244,78,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "AWP") then
      if(sharedConfig == false) then
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(AwpMOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(AwpMOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(AwpMOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(AwpMOVINGMinDamage:GetValue() + 0.5));
      else
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "SHOTGUN") then
      if(sharedConfig == false) then
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(ShotgunMOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(ShotgunMOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(ShotgunMOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(ShotgunMOVINGMinDamage:GetValue() + 0.5));
      else
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "LMG") then
      if(sharedConfig == false) then
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(LmgMOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(LmgMOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(LmgMOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(LmgMOVINGMinDamage:GetValue() + 0.5));
      else
        draw.Color(128,255,0,255);
        draw.Text(10,615, "Accuracy: MOVING");
draw.TextShadow(10,615, "Accuracy: MOVING");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(MOVINGHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(MOVINGMinDamage:GetValue() + 0.5));
      end
    end
  elseif(currentAccuracy == "Normal" and currentWeapon ~= "empty") then
    if(currentWeapon == "AUTO") then
      draw.Color(223,244,66,255);
      draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
      draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
      draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
    elseif(currentWeapon == "SCOUT") then
      if(sharedConfig == false) then
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(ScoutNormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(ScoutNormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(ScoutNormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(ScoutNormalMinDamage:GetValue() + 0.5));
      else
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "RIFLE") then
      if(sharedConfig == false) then
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(RifleNormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(RifleNormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(RifleNormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(RifleNormalMinDamage:GetValue() + 0.5));
      else
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "REVOLVER") then
      if(sharedConfig == false) then
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(RevolverNormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(RevolverNormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(RevolverNormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(RevolverNormalMinDamage:GetValue() + 0.5));
      else
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "PISTOL") then
      if(sharedConfig == false) then
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(PistolNormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(PistolNormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(PistolNormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(PistolNormalMinDamage:GetValue() + 0.5));
      else
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "SMG") then
      if(sharedConfig == false) then
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(SmgNormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(SmgNormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(SmgNormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(SmgNormalMinDamage:GetValue() + 0.5));
      else
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "AWP") then
      if(sharedConfig == false) then
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(AwpNormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(AwpNormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(AwpNormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(AwpNormalMinDamage:GetValue() + 0.5));
      else
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
        draw.TextShadow(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "SHOTGUN") then
      if(sharedConfig == false) then
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(ShotgunNormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(ShotgunNormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(ShotgunNormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(ShotgunNormalMinDamage:GetValue() + 0.5));
      else
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
        draw.TextShadow(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
      end
elseif(currentWeapon == "LMG") then
      if(sharedConfig == false) then
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.Text(10, 630, "Hit Chance: " .. math.floor(LmgNormalHitChance:GetValue() + 0.5) .. "%");
draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(LmgNormalHitChance:GetValue() + 0.5) .. "%");
        draw.Text(10, 645, "Min Damage: " .. math.floor(LmgNormalMinDamage:GetValue() + 0.5));
draw.TextShadow(10, 645, "Min Damage: " .. math.floor(LmgNormalMinDamage:GetValue() + 0.5));
      else
        draw.Color(223,244,66,255);
        draw.Text(10,615, "Accuracy: Normal");
draw.TextShadow(10,615, "Accuracy: Normal");
        draw.TextShadow(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
draw.Text(10, 630, "Hit Chance: " .. math.floor(NormalHitChance:GetValue() + 0.5) .. "%");
        draw.TextShadow(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
draw.Text(10, 645, "Min Damage: " .. math.floor(NormalMinDamage:GetValue() + 0.5));
      end
    end
  else
    draw.Color(244,66,66,255);
    draw.Text(10,615, "Weapon Not Equipped");
draw.TextShadow(10,615, "Weapon Not Equipped");
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


