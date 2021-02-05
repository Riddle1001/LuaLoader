-- Scraped by chicken
-- Author: anyád
-- Title [Release] Multi lua by KoiLoi
-- Forum link https://aimware.net/forum/thread/144815

--------KoiLoi--------

local ref = gui.Reference("Ragebot", "Anti-Aim", "Extra")
local lagsync = gui.Checkbox(ref, "chk_legitaw", "lagsync", false)
local ref =gui.Window

hsounds = {"bass.wav", "bf4.wav", "Bowhit.wav", "bruh.wav", "uagay.wav", "kovaakhit.wav", "Cookie.wav", "windows-error.wav", "roblox.mp3", "vitas.wav", "mhit1.mp3", "gachi.wav", "metro2033.mp3", "minecraft.mp3", "rust.wav", "toy.wav", "Mediumimpact.wav"}
ksounds = {"bass.wav", "bf4.wav", "Bowhit.wav", "bruh.wav", "uagay.wav", "kovaakded.wav", "Cookie.wav", "windows-error.wav", "roblox.mp3", "vitas.wav", "mhit1.mp3", "gachi.wav", "metro2033.mp3", "minecraft.mp3", "rust.wav", "toy.wav", "Hardimpact.wav"}

local killsays = {
 [1] = "1 sniff",
 [2] = "1 nn",
 [3] = "n1",
 [4] = "rip",
 [5] = "Fat nn",
 [6] = "sit dog",
 [7] = "ah",

}
local activeFovs = {};

local localplayer, localplayerindex, listen, GetPlayerIndexByUserID, g_curtime = entities.GetLocalPlayer, client.GetLocalPlayerIndex, client.AllowListener, client.GetPlayerIndexByUserID, globals.CurTime
local ref = gui.Reference("Misc", "Enhancement")
local msc_ref = gui.Groupbox(ref, "Healthshot hitsound", 328,313, 296,400)
local allenabled = gui.Checkbox(msc_ref, 'lua_healthshot_hitsound_enabled', 'Hitsound/marker lua enabled', 1)
local killsay = gui.Checkbox(msc_ref, 'lua_healthshot_killsay_enabled', 'Enable killsay', 0)
killsay:SetDescription("Writing random messages on kill")
local hitcross = gui.Checkbox(msc_ref, 'lua_healthshot_hitcross_enabled', 'Enable crosshair marker', 0)
local hitmarkerColor = gui.ColorPicker(hitcross, "lua_healthshot_hitcross_color", "", 255, 165, 10, 255);
hitcross:SetDescription("Drawing a marker on the center of screen")
local linesize = gui.Slider(msc_ref, 'lua_healthshot_hitcross_slider', 'Crosshair marker size', 15, 1, 30)
local hitcrossrotate = gui.Checkbox(msc_ref, 'lua_healthshot_hitcross_rotated', 'Rotate marker by 45', 0)

local killssounds = gui.Combobox(msc_ref, 'lua_healthshot_killsound_combobox', 'Killsound', "Off", "Bass", "Battlefield 4", "Bowhit", "Bruh", "You a gay", "Kovaak", "Cookie", "Windows XP error", "Roblox", "Vitas", "Minecraft hit", "Gachimuchi", "Metro 2033", "Minecraft oh", "Rust HS", "Toy", "Impact (loud)")
killssounds:SetDescription("Overrides the headshot and hit sound on kill")
local hssounds = gui.Combobox(msc_ref, 'lua_healthshot_hssounds_combobox', 'Headshot sound', "Off", "Bass", "Battlefield 4", "Bowhit", "Bruh", "You a gay", "Kovaak", "Cookie", "Windows XP error", "Roblox", "Vitas", "Minecraft hit", "Gachimuchi", "Metro 2033", "Minecraft oh", "Rust HS", "Toy", "Impact")
hssounds:SetDescription("Overrides the hitsound on HS")
local hitssounds = gui.Combobox(msc_ref, 'lua_healthshot_hitsound_combobox', 'Hitsound', "Off", "Bass", "Battlefield 4", "Bowhit", "Bruh", "You a gay", "Kovaak", "Cookie", "Windows XP error", "Roblox", "Vitas", "Minecraft hit", "Gachimuchi", "Metro 2033", "Minecraft oh", "Rust HS", "Toy", "Impact")
local Healthshot = gui.Combobox(msc_ref, 'lua_healthshot_hitmarker_combobox', 'Healthshot hitmarker', 'Off', 'On hit', 'On kill')
local slider = gui.Slider(msc_ref, 'lua_healthshot_hitmarker_slider', 'Healthshot duration (sec)', 1, 0, 10)

local FOVenabled = gui.Checkbox(msc_ref, 'lua_healthshot_fovmarker_enabled', 'FOVmarker enabled', 0)
local FovshotMode = gui.Combobox(msc_ref, 'lua_healthshot_fovmarker_combobox', 'Fovmarker', 'On hit', 'On kill')
local sliderFOV = gui.Slider(msc_ref, 'lua_healthshot_fovmarker_duration', 'Animation duration (sec)', 1, 0, 10)
local sliderSmooth = gui.Slider(msc_ref, 'lua_healthshot_fovmarker_smoothing', 'Animation smoothing', 80, 1, 100)
local sliderStart = gui.Slider(msc_ref, 'lua_healthshot_fovmarker_startfov', 'Start FOV', 110, 50, 150)
local sliderEnd = gui.Slider(msc_ref, 'lua_healthshot_fovmarker_endfov', 'End FOV', 120, 50, 150)

local CrossTime = 0
local alpha = 0;
local screenCenterX, screenCenterY = draw.GetScreenSize();
screenCenterX = screenCenterX / 2;
screenCenterY = screenCenterY / 2;

listen('player_hurt')
listen('player_death')
local function add(time, ...)
 table.insert(activeFovs, {
   ["time"] = time,
   ["delay"] = globals.RealTime() + time,
   ["fov"] = sliderStart:GetValue(),
 })
end
local function healthshot_hitmarker(e)

 if not allenabled:GetValue() then
  return
 end
 if (entities.GetLocalPlayer() == nil) then return end

 local event_name = e:GetName()
 if (event_name ~= 'player_hurt' and event_name ~= 'player_death') then return end

 local hit = GetPlayerIndexByUserID(e:GetInt("hitgroup"))
 local me = localplayerindex()
 local victim = GetPlayerIndexByUserID(e:GetInt('userid'))
 local attacker = GetPlayerIndexByUserID(e:GetInt('attacker'))
 local im_attacker = attacker == me and victim ~= me
 local duration = slider:GetValue()

 if not im_attacker then
  return
 end

 if (event_name == 'player_death') then
  if (killsay:GetValue() == true) then 
   client.ChatSay( killsays[ math.random( #killsays ) ] );
  end
  if (killssounds:GetValue() ~= 0 ) then
   local hitcmd = "play " .. ksounds[killssounds:GetValue()];
    client.Command(hitcmd, true);
  end
  if (Healthshot:GetValue() ~= 0 ) and (Healthshot:GetValue() == 2 ) then
   localplayer():SetProp('m_flHealthShotBoostExpirationTime', g_curtime() + duration)
  end
 
  if ((FOVenabled:GetValue()) and (FovshotMode:GetValue() == 1)) then
   add(slider:GetValue())
  end
 end

 if (event_name == 'player_hurt') then
  if (hssounds:GetValue() ~= 0 ) then
   if (e:GetInt("hitgroup") == 1) then -- If hit head
    local hitcmd = "play " .. hsounds[hssounds:GetValue()];
     client.Command(hitcmd, true);
   else -- If hit not-head
    if (hitssounds:GetValue() ~= 0 ) then
     local hitcmd = "play " .. hsounds[hitssounds:GetValue()];
      client.Command(hitcmd, true);
    end
   end
  else
   if (hitssounds:GetValue() ~= 0 ) then
    local hitcmd = "play " .. hsounds[hitssounds:GetValue()];
     client.Command(hitcmd, true);
   end
  end
  if (Healthshot:GetValue() ~= 0 ) and (Healthshot:GetValue() == 1 ) then
   localplayer():SetProp('m_flHealthShotBoostExpirationTime', g_curtime() + duration)
  end
  if ((FOVenabled:GetValue()) and (FovshotMode:GetValue() == 0)) then
   add(slider:GetValue())
  end
  if (hitcross:GetValue() == true) then
   CrossTime = globals.RealTime()
  end
 end
end

local function showFov(count, player)
 local nd = sliderEnd:GetValue()
 if globals.RealTime() < player.delay then
   if sliderStart:GetValue() > nd then
    if player.fov > nd then player.fov = player.fov - (nd + player.fov) * sliderSmooth:GetValue()/1000 end -- время анимации
    if player.fov < nd then player.fov = nd end
    client.SetConVar("fov_cs_debug", player.fov, true)
   else
   if player.fov < nd then player.fov = player.fov + (nd - player.fov) * sliderSmooth:GetValue()/1000 end -- время анимации
   if player.fov > nd then player.fov = nd end
   client.SetConVar("fov_cs_debug", player.fov, true)
 end
 else
  table.remove(activeFovs, count)
 end
end

callbacks.Register('FireGameEvent', healthshot_hitmarker)
callbacks.Register('Draw', function()
 for index, hitfov in pairs(activeFovs) do
   showFov(index, hitfov)
 end
 local step = 255 / 0.3 * globals.FrameTime()
 local r,g,b,a = hitmarkerColor:GetValue()
 if CrossTime + 0.4 > globals.RealTime() then
  alpha = 255
 else
  alpha = alpha - step
 end
 if (alpha > 0) then
  linesizeValue = linesize:GetValue()
  draw.Color( r,g,b,alpha)
   if(hitcrossrotate:GetValue() == true) then
    draw.Line( screenCenterX - linesizeValue / 2, screenCenterY - linesizeValue / 2, screenCenterX - ( linesizeValue ), screenCenterY - ( linesizeValue ))
    draw.Line( screenCenterX - linesizeValue / 2, screenCenterY + linesizeValue / 2, screenCenterX - ( linesizeValue ), screenCenterY + ( linesizeValue ))
    draw.Line( screenCenterX + linesizeValue / 2, screenCenterY + linesizeValue / 2, screenCenterX + ( linesizeValue ), screenCenterY + ( linesizeValue ))
    draw.Line( screenCenterX + linesizeValue / 2, screenCenterY - linesizeValue / 2, screenCenterX + ( linesizeValue ), screenCenterY - ( linesizeValue ))
   else
    draw.Line( screenCenterX, screenCenterY - linesizeValue / 2, screenCenterX, screenCenterY - ( linesizeValue ))
    draw.Line( screenCenterX - linesizeValue / 2, screenCenterY, screenCenterX - ( linesizeValue ), screenCenterY)
    draw.Line( screenCenterX, screenCenterY + linesizeValue / 2, screenCenterX, screenCenterY + ( linesizeValue ))
    draw.Line( screenCenterX + linesizeValue / 2, screenCenterY, screenCenterX + ( linesizeValue ), screenCenterY)
   end
  end
 if not allenabled:GetValue() then
  FovshotMode:SetInvisible( true )
  sliderFOV:SetInvisible( true )
  sliderSmooth:SetInvisible( true )
  sliderStart:SetInvisible( true )
  sliderEnd:SetInvisible( true )
  slider:SetInvisible( true )
  hitcross:SetInvisible( true )
  linesize:SetInvisible( true )
 else
  FovshotMode:SetInvisible( not FOVenabled:GetValue() )
  sliderFOV:SetInvisible( not FOVenabled:GetValue() )
  sliderSmooth:SetInvisible( not FOVenabled:GetValue() )
  sliderStart:SetInvisible( not FOVenabled:GetValue() )
  sliderEnd:SetInvisible( not FOVenabled:GetValue() )
  if Healthshot:GetValue() == 0 then
   slider:SetInvisible( true )
  else
   slider:SetInvisible( false )
  end
  if hitcross:GetValue() == false then
   linesize:SetInvisible( true )
   hitcrossrotate:SetInvisible( true )
  else
   linesize:SetInvisible( false )
   hitcrossrotate:SetInvisible( false )
  end
 end
 killsay:SetInvisible( not allenabled:GetValue() )
 FOVenabled:SetInvisible( not allenabled:GetValue() )
 killssounds:SetInvisible( not allenabled:GetValue() )
 hssounds:SetInvisible( not allenabled:GetValue() )
 hitssounds:SetInvisible( not allenabled:GetValue() )
 Healthshot:SetInvisible( not allenabled:GetValue() )
 hitcross:SetInvisible( not allenabled:GetValue() )
end);
local CrossTime = 0
local alpha = 0;
local screenCenterX, screenCenterY = draw.GetScreenSize();
screenCenterX = screenCenterX / 2;
screenCenterY = screenCenterY / 2;

listen('player_hurt')
listen('player_death')
local function add(time, ...)
 table.insert(activeFovs, {
   ["time"] = time,
   ["delay"] = globals.RealTime() + time,
   ["fov"] = sliderStart:GetValue(),
 })
end
local function healthshot_hitmarker(e)

 if not allenabled:GetValue() then
  return
 end
 if (entities.GetLocalPlayer() == nil) then return end

 local event_name = e:GetName()
 if (event_name ~= 'player_hurt' and event_name ~= 'player_death') then return end

 local hit = GetPlayerIndexByUserID(e:GetInt("hitgroup"))
 local me = localplayerindex()
 local victim = GetPlayerIndexByUserID(e:GetInt('userid'))
 local attacker = GetPlayerIndexByUserID(e:GetInt('attacker'))
 local im_attacker = attacker == me and victim ~= me
 local duration = slider:GetValue()

 if not im_attacker then
  return
 end

 if (event_name == 'player_death') then
  if (killsay:GetValue() == true) then 
   client.ChatSay( killsays[ math.random( #killsays ) ] );
  end
  if (killssounds:GetValue() ~= 0 ) then
   local hitcmd = "play " .. ksounds[killssounds:GetValue()];
    client.Command(hitcmd, true);
  end
  if (Healthshot:GetValue() ~= 0 ) and (Healthshot:GetValue() == 2 ) then
   localplayer():SetProp('m_flHealthShotBoostExpirationTime', g_curtime() + duration)
  end
 
  if ((FOVenabled:GetValue()) and (FovshotMode:GetValue() == 1)) then
   add(slider:GetValue())
  end
 end

 if (event_name == 'player_hurt') then
  if (hssounds:GetValue() ~= 0 ) then
   if (e:GetInt("hitgroup") == 1) then -- If hit head
    local hitcmd = "play " .. hsounds[hssounds:GetValue()];
     client.Command(hitcmd, true);
   else -- If hit not-head
    if (hitssounds:GetValue() ~= 0 ) then
     local hitcmd = "play " .. hsounds[hitssounds:GetValue()];
      client.Command(hitcmd, true);
    end
   end
  else
   if (hitssounds:GetValue() ~= 0 ) then
    local hitcmd = "play " .. hsounds[hitssounds:GetValue()];
     client.Command(hitcmd, true);
   end
  end
  if (Healthshot:GetValue() ~= 0 ) and (Healthshot:GetValue() == 1 ) then
   localplayer():SetProp('m_flHealthShotBoostExpirationTime', g_curtime() + duration)
  end
  if ((FOVenabled:GetValue()) and (FovshotMode:GetValue() == 0)) then
   add(slider:GetValue())
  end
  if (hitcross:GetValue() == true) then
   CrossTime = globals.RealTime()
  end
 end
end

local function showFov(count, player)
 local nd = sliderEnd:GetValue()
 if globals.RealTime() < player.delay then
   if sliderStart:GetValue() > nd then
    if player.fov > nd then player.fov = player.fov - (nd + player.fov) * sliderSmooth:GetValue()/1000 end -- время анимации
    if player.fov < nd then player.fov = nd end
    client.SetConVar("fov_cs_debug", player.fov, true)
   else
   if player.fov < nd then player.fov = player.fov + (nd - player.fov) * sliderSmooth:GetValue()/1000 end -- время анимации
   if player.fov > nd then player.fov = nd end
   client.SetConVar("fov_cs_debug", player.fov, true)
 end
 else
  table.remove(activeFovs, count)
 end
end

callbacks.Register('FireGameEvent', healthshot_hitmarker)
callbacks.Register('Draw', function()
 for index, hitfov in pairs(activeFovs) do
   showFov(index, hitfov)
 end
 local step = 255 / 0.3 * globals.FrameTime()
 local r,g,b,a = hitmarkerColor:GetValue()
 if CrossTime + 0.4 > globals.RealTime() then
  alpha = 255
 else
  alpha = alpha - step
 end
 if (alpha > 0) then
  linesizeValue = linesize:GetValue()
  draw.Color( r,g,b,alpha)
   if(hitcrossrotate:GetValue() == true) then
    draw.Line( screenCenterX - linesizeValue / 2, screenCenterY - linesizeValue / 2, screenCenterX - ( linesizeValue ), screenCenterY - ( linesizeValue ))
    draw.Line( screenCenterX - linesizeValue / 2, screenCenterY + linesizeValue / 2, screenCenterX - ( linesizeValue ), screenCenterY + ( linesizeValue ))
    draw.Line( screenCenterX + linesizeValue / 2, screenCenterY + linesizeValue / 2, screenCenterX + ( linesizeValue ), screenCenterY + ( linesizeValue ))
    draw.Line( screenCenterX + linesizeValue / 2, screenCenterY - linesizeValue / 2, screenCenterX + ( linesizeValue ), screenCenterY - ( linesizeValue ))
   else
    draw.Line( screenCenterX, screenCenterY - linesizeValue / 2, screenCenterX, screenCenterY - ( linesizeValue ))
    draw.Line( screenCenterX - linesizeValue / 2, screenCenterY, screenCenterX - ( linesizeValue ), screenCenterY)
    draw.Line( screenCenterX, screenCenterY + linesizeValue / 2, screenCenterX, screenCenterY + ( linesizeValue ))
    draw.Line( screenCenterX + linesizeValue / 2, screenCenterY, screenCenterX + ( linesizeValue ), screenCenterY)
   end
  end
 if not allenabled:GetValue() then
  FovshotMode:SetInvisible( true )
  sliderFOV:SetInvisible( true )
  sliderSmooth:SetInvisible( true )
  sliderStart:SetInvisible( true )
  sliderEnd:SetInvisible( true )
  slider:SetInvisible( true )
  hitcross:SetInvisible( true )
  linesize:SetInvisible( true )
 else
  FovshotMode:SetInvisible( not FOVenabled:GetValue() )
  sliderFOV:SetInvisible( not FOVenabled:GetValue() )
  sliderSmooth:SetInvisible( not FOVenabled:GetValue() )
  sliderStart:SetInvisible( not FOVenabled:GetValue() )
  sliderEnd:SetInvisible( not FOVenabled:GetValue() )
  if Healthshot:GetValue() == 0 then
   slider:SetInvisible( true )
  else
   slider:SetInvisible( false )
  end
  if hitcross:GetValue() == false then
   linesize:SetInvisible( true )
   hitcrossrotate:SetInvisible( true )
  else
   linesize:SetInvisible( false )
   hitcrossrotate:SetInvisible( false )
  end
 end
 killsay:SetInvisible( not allenabled:GetValue() )
 FOVenabled:SetInvisible( not allenabled:GetValue() )
 killssounds:SetInvisible( not allenabled:GetValue() )
 hssounds:SetInvisible( not allenabled:GetValue() )
 hitssounds:SetInvisible( not allenabled:GetValue() )
 Healthshot:SetInvisible( not allenabled:GetValue() )
 hitcross:SetInvisible( not allenabled:GetValue() )
end);


local function switch(var)
  if var == 1 then
    return 2
  else
    return 1
  end
end

local primaryWeapons = {
  { "SCAR 20 | G3SG1", "scar20" };
  { "SG 008", "ssg08" };
  { "AWP", "awp" };
  { "G3 SG1 | AUG", "sg556" };
  { "AK 47 | M4A1", "ak47" };
};
local secondaryWeapons = {
  { "Dual Elites", "elite" };
  { "Desert Eagle | R8 Revolver", "deagle" };
  { "Five Seven | Tec 9", "tec9" };
  { "P250", "p250" };
};
local armors = {
  { "None", nil, nil };
  { "Kevlar Vest", "vest", nil };
  { "Kevlar Vest + Helmet", "vest", "vesthelm" };
};
local granades = {
  { "Off", nil, nil };
  { "Grenade", "hegrenade", nil };
  { "Flashbang", "flashbang", nil };
  { "Smoke Grenade", "smokegrenade", nil };
  { "Decoy Grenade", "decoy", nil };
  { "Molotov | Incindiary Grenade", "molotov", "incgrenade" };
};
local TAB = gui.Tab(gui.Reference "KOILOI", "UPDATE", "Autobuy")
local GROUP = gui.Groupbox(gui.Reference("KOILOI", "Autobuy" ), "Menu", 15, 15, 600, 600);
local ENABLED = gui.Checkbox(GROUP, "autobuy.active", "Enable Auto Buy", false);
local PRINT_LOGS = gui.Checkbox(GROUP, "autobuy.printlogs", "Print Logs To Aimware Console", false);
local PRIMARY_WEAPON = gui.Combobox(GROUP, "autobuy.primary", "Primary Weapon", primaryWeapons[1][1], primaryWeapons[2][1], primaryWeapons[3][1], primaryWeapons[4][1], primaryWeapons[5][1]);
local SECONDARY_WEAPON = gui.Combobox(GROUP, "autobuy.secondary", "Secondary Weapon", secondaryWeapons[1][1], secondaryWeapons[2][1], secondaryWeapons[3][1], secondaryWeapons[4][1]);
local ARMOR = gui.Combobox(GROUP, "autobuy.armor", "Armor", armors[1][1], armors[2][1], armors[3][1]);
local GRENADE_SLOT1 = gui.Combobox(GROUP, "autobuy.grenade1", "Grenade Slot #1", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
local GRENADE_SLOT2 = gui.Combobox(GROUP, "autobuy.grenade2", "Grenade Slot #2", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
local GRENADE_SLOT3 = gui.Combobox(GROUP, "autobuy.grenade3", "Grenade Slot #3", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
local GRENADE_SLOT4 = gui.Combobox(GROUP, "autobuy.grenade4", "Grenade Slot #4", granades[1][1], granades[2][1], granades[3][1], granades[4][1], granades[5][1], granades[6][1]);
local TASER = gui.Checkbox(GROUP, "autobuy.taser", "Buy Taser", false);
local DEFUSER = gui.Checkbox(GROUP, "autobuy.defuser", "Buy Defuse Kit", false);
gui.Text(GROUP, "Auto Buy - Csinalta KoiLoi :)");

local function buy(wat)
  if (wat == nil) then return end;
  if (printLogs) then
    print('Bought x1 ' .. wat);
  end;
  client.Command('buy "' .. wat .. '";', true);
end


local function buyTable(table)
  for i, j in pairs(table) do
    buy(j);
  end;
end

local function buyWeapon(selection, table)
  local selection = selection:GetValue();
  local weaponToBuy = table[selection + 1][2];
  buy(weaponToBuy);
end

local function buyGrenades(selections)
  for k, selection in pairs(selections) do
    local selection = selection:GetValue();
    local grenadeTable = granades[selection + 1];
    buyTable({ grenadeTable[2], grenadeTable[3] });
  end
end

callbacks.Register('FireGameEvent', function(e)
  if (ENABLED:GetValue() ~= true) then return end;
  local localPlayer = entities.GetLocalPlayer();
  local en = e:GetName();
  if (localPlayer == nil or en ~= "player_spawn") then return end;
  local userIndex = client.GetPlayerIndexByUserID(e:GetInt('userid'));
  local localPlayerIndex = localPlayer:GetIndex();
  if (userIndex ~= localPlayerIndex) then return end;
  buyWeapon(PRIMARY_WEAPON, primaryWeapons);
  buyWeapon(SECONDARY_WEAPON, secondaryWeapons);
  local armorSelected = ARMOR:GetValue();
  local armorTable = armors[armorSelected + 1];
  buyTable({ armorTable[2], armorTable[3] });
  if (DEFUSER:GetValue()) then
    buy('defuser');
  end
  if (TASER:GetValue()) then
    buy('taser');
  end
  buyGrenades({ GRENADE_SLOT1, GRENADE_SLOT2, GRENADE_SLOT3, GRENADE_SLOT4 });
end);

client.AllowListener("player_spawn");

callbacks.Register("Draw", function( )
  if globals.TickCount() % 7 == 0 then
    gui.SetValue("rbot.antiaim.desync", 10)
    gui.SetValue("rbot.antiaim.desyncleft", 10)
    gui.SetValue("rbot.antiaim.desyncright", 10)
    gui.SetValue("rbot.antiaim.yaw", 179)
  else
    gui.SetValue("rbot.antiaim.desync", 3)
    gui.SetValue("rbot.antiaim.desyncleft", 3)
    gui.SetValue("rbot.antiaim.desyncright", 3)
    gui.SetValue("rbot.antiaim.yaw", 180)
  end
end)

local guiSet = gui.SetValue
local guiGet = gui.GetValue
local togglekey = input.IsButtonDown
local ref = gui.Reference("RAGEBOT");
local tab = gui.Tab(ref,"Extra","MinDamage")
local dmgsettings = gui.Groupbox(tab,"MinDamage by Ryanchiew#7167",16,16,280,300)
local togglekey = gui.Keybox(dmgsettings, "ChangeDmgKey", "Mindamage Key", 0)
local setDmg = gui.Combobox(dmgsettings, "mindmgmode", "Min Damage Mode", "Off", "Toggle", "Hold")
local awpdmg = gui.Groupbox(tab,"Awp Damage Settings",16,190,280,300)
local awpDamage = gui.Slider(awpdmg, "awpDamage", "Awp Min Damage", 1, 0, 100)
local awpori = gui.Slider(awpdmg, "awpori", "Awp Original Min Damage", 1, 0, 100)
local scoutdmg = gui.Groupbox(tab,"Scout Damage Settings",310,16,280,300)
local scoutDamage = gui.Slider(scoutdmg, "scoutDamage", "Scout Min Damage", 1, 0, 100)
local scoutori = gui.Slider(scoutdmg, "scoutori", "Scout Original Min Damage", 1, 0, 100)
local autodmg = gui.Groupbox(tab,"Auto Damage Settings",310,190,280,300)
local autoDamage = gui.Slider(autodmg, "autoDamage", "Auto Min Damage", 1, 0, 100)
local autoori = gui.Slider(autodmg, "autoori", "Auto Original Min Damage", 1, 0, 100)
local position = gui.Groupbox(tab,"Indicators position",16,350,280,300)
local xpos = gui.Slider(position, "xpos", "X Position", 1, 0, 1980)
local ypos = gui.Slider(position, "ypos", "Y Position", 1, 0, 1080)
local Toggle =-1
local pressed = false

function changeMinDamage()
if (setDmg:GetValue()==1) then
    if input.IsButtonPressed(togglekey:GetValue()) then
      pressed=true;
Toggle = Toggle *-1

    elseif (pressed and input.IsButtonReleased(togglekey:GetValue())) then
      pressed=false;

      if Toggle == 1 then
      guiSet("rbot.accuracy.weapon.sniper.mindmg", awpDamage:GetValue())
      guiSet("rbot.accuracy.weapon.scout.mindmg", scoutDamage:GetValue())
      guiSet("rbot.accuracy.weapon.asniper.mindmg", autoDamage:GetValue())
      else
    guiSet("rbot.accuracy.weapon.asniper.mindmg", autoori:GetValue())
    guiSet("rbot.accuracy.weapon.sniper.mindmg", awpori:GetValue())
    guiSet("rbot.accuracy.weapon.scout.mindmg", scoutori:GetValue())

      end
    end
  elseif (setDmg:GetValue()==2) then
    if input.IsButtonDown(togglekey:GetValue()) then
      guiSet("rbot.accuracy.weapon.sniper.mindmg", awpDamage:GetValue())
      guiSet("rbot.accuracy.weapon.scout.mindmg", scoutDamage:GetValue())
      guiSet("rbot.accuracy.weapon.asniper.mindmg", autoDamage:GetValue())
    else
    guiSet("rbot.accuracy.weapon.asniper.mindmg", autoori:GetValue())
    guiSet("rbot.accuracy.weapon.sniper.mindmg", awpori:GetValue())
    guiSet("rbot.accuracy.weapon.scout.mindmg", scoutori:GetValue())
    end
  elseif (setDmg:GetValue()==0) then
    Toggle = -1
    guiSet("rbot.accuracy.weapon.asniper.mindmg", autoori:GetValue())
    guiSet("rbot.accuracy.weapon.sniper.mindmg", awpori:GetValue())
    guiSet("rbot.accuracy.weapon.scout.mindmg", scoutori:GetValue())
  end
end

function Drawtext()
  w = xpos:GetValue()
  h = ypos:GetValue()
if (setDmg:GetValue()==1) then
  if Toggle == 1 then
    draw.Color(0, 255, 0, 255);
    draw.Text(w, h-60, "Min Damage Mode On (toggle)");
    draw.Color(255, 255, 0, 255);
    draw.Text(w+90, h-40, awpDamage:GetValue());
    draw.Color(255, 255, 0, 255);
    draw.Text(w+30, h-40, "awp:");
    draw.Color(255, 255, 0, 255);
    draw.Text(w+90, h-20, scoutDamage:GetValue());
    draw.Color(255, 255, 0, 255);
    draw.Text(w+30, h-20, "scout:");
    draw.Color(255, 255, 0, 255);
    draw.Text(w+90, h, autoDamage:GetValue());
    draw.Color(255, 255, 0, 255);
    draw.Text(w+30, h, "auto:");
  elseif Toggle == -1 then
  draw.Color(255, 255, 255, 255);
  draw.Text(w, h-60, "Min Damage Mode Off");
  draw.Color(255, 255, 255, 255);
  draw.Text(w+90, h-20, scoutori:GetValue());
  draw.Color(255, 255, 255, 255);
  draw.Text(w+90, h-40, awpori:GetValue());
  draw.Color(255, 255, 255, 255);
  draw.Text(w+90, h, autoori:GetValue());
  draw.Color(255, 255, 255, 255);
  draw.Text(w+30, h-20, "scout:");
  draw.Color(255, 255, 255, 255);
  draw.Text(w+30, h-40, "awp:");
  draw.Color(255, 255, 255, 255);
  draw.Text(w+30, h, "auto:");
  end
elseif (setDmg:GetValue()==2) then
  if input.IsButtonDown(togglekey:GetValue()) then
     draw.Color(0, 255, 0, 255);
    draw.Text(w, h-60, "Min Damage Mode On (toggle)");
    draw.Color(255, 255, 0, 255);
    draw.Text(w+90, h-40, awpDamage:GetValue());
    draw.Color(255, 255, 0, 255);
    draw.Text(w+30, h-40, "awp:");
    draw.Color(255, 255, 0, 255);
    draw.Text(w+90, h-20, scoutDamage:GetValue());
    draw.Color(255, 255, 0, 255);
    draw.Text(w+30, h-20, "scout:");
    draw.Color(255, 255, 0, 255);
    draw.Text(w+90, h, autoDamage:GetValue());
    draw.Color(255, 255, 0, 255);
    draw.Text(w+30, h, "auto:");
  else
  draw.Color(255, 255, 255, 255);
  draw.Text(w, h-60, "Min Damage Mode Off");
  draw.Color(255, 255, 255, 255);
  draw.Text(w+90, h-20, scoutori:GetValue());
  draw.Color(255, 255, 255, 255);
  draw.Text(w+90, h-40, awpori:GetValue());
  draw.Color(255, 255, 255, 255);
  draw.Text(w+90, h, autoori:GetValue());
  draw.Color(255, 255, 255, 255);
  draw.Text(w+30, h-20, "scout:");
  draw.Color(255, 255, 255, 255);
  draw.Text(w+30, h-40, "awp:");
  draw.Color(255, 255, 255, 255);
  draw.Text(w+30, h, "auto:");
   
 
  end
else
  draw.Color(255, 255, 255, 255);
  draw.Text(w, h-60, "Min Damage Mode Off");
  draw.Color(255, 255, 255, 255);
  draw.Text(w+90, h-20, scoutori:GetValue());
  draw.Color(255, 255, 255, 255);
  draw.Text(w+90, h-40, awpori:GetValue());
  draw.Color(255, 255, 255, 255);
  draw.Text(w+90, h, autoori:GetValue());
  draw.Color(255, 255, 255, 255);
  draw.Text(w+30, h-20, "scout:");
  draw.Color(255, 255, 255, 255);
  draw.Text(w+30, h-40, "awp:");
  draw.Color(255, 255, 255, 255);
  draw.Text(w+30, h, "auto:");
end
end
callbacks.Register("Draw", "Drawtext", Drawtext);
callbacks.Register("Draw", "changeMinDamage", changeMinDamage);

local gui_gref = gui.Reference("Ragebot", "Aimbot", "Extra")
local gui_dtap = gui.Checkbox(gui_gref, "lua.dtap", "Double Tap Fix", 1)
local gui_shotswitch = gui.Checkbox(gui_gref, "lua.shotswitch", "Switch Desync On Shot", 0)
local cache = {shot, dtap}

local function switch(var)
  if var == 1 then
    return 2
  else
    return 1
  end
end

callbacks.Register("Draw", function()
  if cache.shot then
    gui.SetValue("rbot.antiaim.fakeyawstyle", switch(gui.GetValue("rbot.antiaim.fakeyawstyle")))
    cache.shot = false
  end
end)

callbacks.Register("CreateMove", function(cmd)
  if cache.dtap then
    cmd.sidemove = 0
    cmd.forwardmove = 0
    cache.dtap = false
  end
end)

callbacks.Register("FireGameEvent", function(event)
if not entities.GetLocalPlayer() then return end
  if ( event:GetName() == 'weapon_fire' ) then

    local lp = client.GetLocalPlayerIndex()
    local int_shooter = event:GetInt('userid')
    local index_shooter = client.GetPlayerIndexByUserID(int_shooter)

    if ( index_shooter == lp) then
      if gui_shotswitch:GetValue() then
        cache.shot = true
      end
      if gui_dtap:GetValue() then
        cache.dtap = true
      end
    end
  end
end)

local aspect_ratio_table = {};
local REF = gui.Reference("MISC", "Enhancement")
local aspect_misc = gui.Groupbox(REF, "AspectRatio", 16, 710, 297)
local aspect_ratio_check = gui.Checkbox(aspect_misc, "aspect_ratio_check", "Aspect Ratio Changer", false);
local aspect_ratio_reference = gui.Slider(aspect_misc, "aspect_ratio_reference", "Force aspect ratio", 100, 1, 199)
local function gcd(m, n)  while m ~= 0 do m, n = math.fmod(n, m), m;
end
return n
end

local function set_aspect_ratio(aspect_ratio_multiplier)
local screen_width, screen_height = draw.GetScreenSize(); local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height;
  if aspect_ratio_multiplier == 1 or not aspect_ratio_check:GetValue() then aspectratio_value = 0; end
    client.SetConVar( "r_aspectratio", tonumber(aspectratio_value), true); end

local function on_aspect_ratio_changed()
local screen_width, screen_height = draw.GetScreenSize();
for i=1, 200 do local i2=i*0.01;  i2 = 2 - i2; local divisor = gcd(screen_width*i2, screen_height);  if screen_width*i2/divisor < 100 or i2 == 1 then aspect_ratio_table[i] = screen_width*i2/divisor .. ":" .. screen_height/divisor; end end
local aspect_ratio = aspect_ratio_reference:GetValue()*0.01; aspect_ratio = 2 - aspect_ratio; set_aspect_ratio(aspect_ratio); end
callbacks.Register('Draw', "Aspect Ratio" ,on_aspect_ratio_changed)

local ref = gui.Reference("Visuals", "World", "Extra");
local hitmarkerCheckbox = gui.Checkbox(ref, "lua_hitmarker", "Hit Indicators", true);
local headshotCheckbox = gui.Checkbox(ref, "lua_headshot", "Headshot Indicators", true);
local hitmarkerColor = gui.ColorPicker(hitmarkerCheckbox, "lua_hitmarker_color", "", 255, 255, 255, 255);
local headshotColor = gui.ColorPicker(headshotCheckbox, "lua_headshot_color", "", 0, 255, 0, 255);

hitPositions = {};
hitTimes = {};
hitTypes = {};
bulletImpactPositions = {};
deltaTimes = {};

local hitCount = 0;
local newHitCount = 0;
local bulletImpactCount = 0;
local hitFlag = false;

--Change if you want
local markerSize = 5;
local fadeTime = 1;
local headshotSpeed = 5;

local function AddHit(hitPos, type)
  table.insert(hitPositions, hitPos);
  table.insert(hitTimes, globals.CurTime());
  table.insert(hitTypes, type);
  hitCount = hitCount + 1;
end

local function RemoveHit(index)
  table.remove(hitPositions, index);
  table.remove(hitTimes, index);
  table.remove(hitTypes, index);
  table.remove(deltaTimes, index);
  newHitCount = newHitCount - 1;
end

local function GetClosestImpact(point)
  local bestImpactIndex;
  local bestDist = 11111111111;
  for i = 0, bulletImpactCount, 1 do
    if (bulletImpactPositions[i] ~= nil) then
      local delta = bulletImpactPositions[i] - point;
      local dist = delta:Length();
      if (dist < bestDist) then
        bestDist = dist;
        bestImpactIndex = i;
      end
    end
  end

  return bulletImpactPositions[bestImpactIndex];
end

local function hFireGameEvent(GameEvent)
  if (GameEvent:GetName() == "bullet_impact") then
    local attacker = entities.GetByUserID(GameEvent:GetInt("userid"));
    if (attacker ~= nil and attacker:GetName() == entities.GetLocalPlayer():GetName()) then
      hitFlag = true;
      local hitPos = Vector3(GameEvent:GetFloat("x"), GameEvent:GetFloat("y"), GameEvent:GetFloat("z"));
      table.insert(bulletImpactPositions, hitPos);
      bulletImpactCount = bulletImpactCount + 1;
    end

  elseif (GameEvent:GetName() == "player_hurt") then
    local victim = entities.GetByUserID(GameEvent:GetInt("userid"));
    local attacker = entities.GetByUserID(GameEvent:GetInt("attacker"));
    if (attacker ~= nil and victim ~= nil and attacker:GetName() == entities.GetLocalPlayer():GetName() and victim:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber()) then
      local hitGroup = GameEvent:GetInt("hitgroup");
      if (hitFlag) then
        hitFlag = false;
        local impact = GetClosestImpact(victim:GetHitboxPosition(hitGroup));
        if (hitGroup == 1 and headshotCheckbox:GetValue()) then
          impact.z = impact.z + 5
          AddHit(impact, 1);
        elseif (hitmarkerCheckbox:GetValue()) then
          AddHit(impact, 0);
        end
        bulletImpactPositions = {};
        bulletImpactCount = 0;
      end
    end
  end
end

local function hDraw()
  if ((headshotCheckbox:GetValue() or hitmarkerCheckbox:GetValue()) and entities.GetLocalPlayer() ~= nil) then
    newHitCount = hitCount;
    for i = 0, hitCount, 1 do
      if (hitTimes[i] ~= nil and hitPositions[i] ~= nil and hitTypes[i] ~= nil) then
        local deltaTime = globals.CurTime() - hitTimes[i];
        if (deltaTime > fadeTime) then
          RemoveHit(i);
          goto continue;
        end

        if (hitTypes[i] == 1) then
          hitPositions[i].z = hitPositions[i].z + deltaTime / headshotSpeed;
        end

        local xHit, yHit = client.WorldToScreen(hitPositions[i]);
        if xHit ~= nil and yHit ~= nil then
          local alpha;
          if (deltaTime > fadeTime / 2) then
            alpha = (1 - (deltaTime - deltaTimes[i]) / fadeTime * 2) * 255;
            if (alpha < 0) then
              alpha = 0
            end
          else
            table.insert(deltaTimes, i, deltaTime)
            alpha = 255;
          end

          if (hitTypes[i] == 1) then
            local r, g, b, a = headshotColor:GetValue();
            draw.Color(r, g, b, alpha);
            local width, height = draw.GetTextSize("HEADSHOT");
            draw.Text(xHit - width / 2, yHit, "HEADSHOT");
          else
            local r, g, b, a = hitmarkerColor:GetValue();
            draw.Color(r, g, b, alpha);
            draw.Line(xHit - markerSize, yHit - markerSize, xHit + markerSize, yHit + markerSize);
            draw.Line(xHit - markerSize, yHit + markerSize, xHit + markerSize, yHit - markerSize);
          end
        end
      end

      ::continue::
    end

    hitCount = newHitCount;
  end
end

client.AllowListener("bullet_impact");
client.AllowListener("player_hurt");
callbacks.Register("FireGameEvent", hFireGameEvent);
callbacks.Register("Draw", hDraw);

panorama.RunScript([[
  var model = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
]] )

local models = {
  {"Invisible"},
{"Local T Agent", "models/player/custom_player/legacy/tm_phoenix.mdl"},
{"Local CT Agent", "models/player/custom_player/legacy/ctm_sas.mdl"},
{"Blackwolf | Sabre", "models/player/custom_player/legacy/tm_balkan_variantj.mdl"},
{"Rezan The Ready | Sabre", "models/player/custom_player/legacy/tm_balkan_variantg.mdl"},
{"Maximus | Sabre", "models/player/custom_player/legacy/tm_balkan_varianti.mdl"},
{"Dragomir | Sabre", "models/player/custom_player/legacy/tm_balkan_variantf.mdl"},
{"Lt. Commander Ricksaw | NSWC SEAL", "models/player/custom_player/legacy/ctm_st6_varianti.mdl"},
{"'Two Times' McCoy | USAF TACP", "models/player/custom_player/legacy/ctm_st6_variantm.mdl"},
{"Buckshot | NSWC SEAL", "models/player/custom_player/legacy/ctm_st6_variantg.mdl"},
{"Seal Team 6 Soldier | NSWC SEAL", "models/player/custom_player/legacy/ctm_st6_variante.mdl"},
{"3rd Commando Company | KSK", "models/player/custom_player/legacy/ctm_st6_variantk.mdl"},
{"'The Doctor' Romanov | Sabre", "models/player/custom_player/legacy/tm_balkan_varianth.mdl"},
{"Michael Syfers | FBI Sniper", "models/player/custom_player/legacy/ctm_fbi_varianth.mdl"},
{"Markus Delrow | FBI HRT", "models/player/custom_player/legacy/ctm_fbi_variantg.mdl"},
{"Operator | FBI SWAT", "models/player/custom_player/legacy/ctm_fbi_variantf.mdl"},
{"Slingshot | Phoenix", "models/player/custom_player/legacy/tm_phoenix_variantg.mdl"},
{"Enforcer | Phoenix", "models/player/custom_player/legacy/tm_phoenix_variantf.mdl"},
{"Soldier | Phoenix", "models/player/custom_player/legacy/tm_phoenix_varianth.mdl"},
{"The Elite Mr. Muhlik | Elite Crew", "models/player/custom_player/legacy/tm_leet_variantf.mdl"},
{"Prof. Shahmat | Elite Crew", "models/player/custom_player/legacy/tm_leet_varianti.mdl"},
{"Osiris | Elite Crew", "models/player/custom_player/legacy/tm_leet_varianth.mdl"},
{"Ground Rebel | Elite Crew", "models/player/custom_player/legacy/tm_leet_variantg.mdl"},
{"Special Agent Ava | FBI", "models/player/custom_player/legacy/ctm_fbi_variantb.mdl"},
{"B Squadron Officer | SAS", "models/player/custom_player/legacy/ctm_sas_variantf.mdl"},
{"Anarchist", "models/player/custom_player/legacy/tm_anarchist.mdl"},
{"Anarchist (Variant A)", "models/player/custom_player/legacy/tm_anarchist_varianta.mdl"},
{"Anarchist (Variant B)", "models/player/custom_player/legacy/tm_anarchist_variantb.mdl"},
{"Anarchist (Variant C)", "models/player/custom_player/legacy/tm_anarchist_variantc.mdl"},
{"Anarchist (Variant D)", "models/player/custom_player/legacy/tm_anarchist_variantd.mdl"},
{"Pirate", "models/player/custom_player/legacy/tm_pirate.mdl"},
{"Pirate (Variant A)", "models/player/custom_player/legacy/tm_pirate_varianta.mdl"},
{"Pirate (Variant B)", "models/player/custom_player/legacy/tm_pirate_variantb.mdl"},
{"Pirate (Variant C)", "models/player/custom_player/legacy/tm_pirate_variantc.mdl"},
{"Pirate (Variant D)", "models/player/custom_player/legacy/tm_pirate_variantd.mdl"},
{"Professional", "models/player/custom_player/legacy/tm_professional.mdl"},
{"Professional (Variant 1)", "models/player/custom_player/legacy/tm_professional_var1.mdl"},
{"Professional (Variant 2)", "models/player/custom_player/legacy/tm_professional_var2.mdl"},
{"Professional (Variant 3)", "models/player/custom_player/legacy/tm_professional_var3.mdl"},
{"Professional (Variant 4)", "models/player/custom_player/legacy/tm_professional_var4.mdl"},
{"Separatist", "models/player/custom_player/legacy/tm_separatist.mdl"},
{"Separatist (Variant A)", "models/player/custom_player/legacy/tm_separatist_varianta.mdl"},
{"Separatist (Variant B)", "models/player/custom_player/legacy/tm_separatist_variantb.mdl"},
{"Separatist (Variant C)", "models/player/custom_player/legacy/tm_separatist_variantc.mdl"},
{"Separatist (Variant D)", "models/player/custom_player/legacy/tm_separatist_variantd.mdl"},
{"GIGN", "models/player/custom_player/legacy/ctm_gign.mdl"},
{"GIGN (Variant A)", "models/player/custom_player/legacy/ctm_gign_varianta.mdl"},
{"GIGN (Variant B)", "models/player/custom_player/legacy/ctm_gign_variantb.mdl"},
{"GIGN (Variant C)", "models/player/custom_player/legacy/ctm_gign_variantc.mdl"},
{"GIGN (Variant D)", "models/player/custom_player/legacy/ctm_gign_variantd.mdl"},
{"GSG-9", "models/player/custom_player/legacy/ctm_gsg9.mdl"},
{"GSG-9 (Variant A)", "models/player/custom_player/legacy/ctm_gsg9_varianta.mdl"},
{"GSG-9 (Variant B)", "models/player/custom_player/legacy/ctm_gsg9_variantb.mdl"},
{"GSG-9 (Variant C)", "models/player/custom_player/legacy/ctm_gsg9_variantc.mdl"},
{"GSG-9 (Variant D)", "models/player/custom_player/legacy/ctm_gsg9_variantd.mdl"},
{"IDF", "models/player/custom_player/legacy/ctm_idf.mdl"},
{"IDF (Variant B)", "models/player/custom_player/legacy/ctm_idf_variantb.mdl"},
{"IDF (Variant C)", "models/player/custom_player/legacy/ctm_idf_variantc.mdl"},
{"IDF (Variant D)", "models/player/custom_player/legacy/ctm_idf_variantd.mdl"},
{"IDF (Variant E)", "models/player/custom_player/legacy/ctm_idf_variante.mdl"},
{"IDF (Variant F)", "models/player/custom_player/legacy/ctm_idf_variantf.mdl"},
{"SWAT", "models/player/custom_player/legacy/ctm_swat.mdl"},
{"SWAT (Variant A)", "models/player/custom_player/legacy/ctm_swat_varianta.mdl"},
{"SWAT (Variant B)", "models/player/custom_player/legacy/ctm_swat_variantb.mdl"},
{"SWAT (Variant C)", "models/player/custom_player/legacy/ctm_swat_variantc.mdl"},
{"SWAT (Variant D)", "models/player/custom_player/legacy/ctm_swat_variantd.mdl"},
{"SAS (Variant A)", "models/player/custom_player/legacy/ctm_sas_varianta.mdl"},
{"SAS (Variant B)", "models/player/custom_player/legacy/ctm_sas_variantb.mdl"},
{"SAS (Variant C)", "models/player/custom_player/legacy/ctm_sas_variantc.mdl"},
{"SAS (Variant D)", "models/player/custom_player/legacy/ctm_sas_variantd.mdl"},
{"ST6", "models/player/custom_player/legacy/ctm_st6.mdl"},
{"ST6 (Variant A)", "models/player/custom_player/legacy/ctm_st6_varianta.mdl"},
{"ST6 (Variant B)", "models/player/custom_player/legacy/ctm_st6_variantb.mdl"},
{"ST6 (Variant C)", "models/player/custom_player/legacy/ctm_st6_variantc.mdl"},
{"ST6 (Variant D)", "models/player/custom_player/legacy/ctm_st6_variantd.mdl"},
{"Balkan (Variant E)", "models/player/custom_player/legacy/tm_balkan_variante.mdl"},
{"Balkan (Variant A)", "models/player/custom_player/legacy/tm_balkan_varianta.mdl"},
{"Balkan (Variant B)", "models/player/custom_player/legacy/tm_balkan_variantb.mdl"},
{"Balkan (Variant C)", "models/player/custom_player/legacy/tm_balkan_variantc.mdl"},
{"Balkan (Variant D)", "models/player/custom_player/legacy/tm_balkan_variantd.mdl"},
{"Jumpsuit (Variant A)", "models/player/custom_player/legacy/tm_jumpsuit_varianta.mdl"},
{"Jumpsuit (Variant B)", "models/player/custom_player/legacy/tm_jumpsuit_variantb.mdl"},
{"Jumpsuit (Variant C)", "models/player/custom_player/legacy/tm_jumpsuit_variantc.mdl"},
{"Phoenix Heavy", "models/player/custom_player/legacy/tm_phoenix_heavy.mdl"},
{"Heavy", "models/player/custom_player/legacy/ctm_heavy.mdl"},
{"Leet (Variant A)", "models/player/custom_player/legacy/tm_leet_varianta.mdl"},
{"Leet (Variant B)", "models/player/custom_player/legacy/tm_leet_variantb.mdl"},
{"Leet (Variant C)", "models/player/custom_player/legacy/tm_leet_variantc.mdl"},
{"Leet (Variant D)", "models/player/custom_player/legacy/tm_leet_variantd.mdl"},
{"Leet (Variant E)", "models/player/custom_player/legacy/tm_leet_variante.mdl"},
{"Phoenix", "models/player/custom_player/legacy/tm_phoenix.mdl"},
{"Phoenix (Variant A)", "models/player/custom_player/legacy/tm_phoenix_varianta.mdl"},
{"Phoenix (Variant B)", "models/player/custom_player/legacy/tm_phoenix_variantb.mdl"},
{"Phoenix (Variant C)", "models/player/custom_player/legacy/tm_phoenix_variantc.mdl"},
{"Phoenix (Variant D)", "models/player/custom_player/legacy/tm_phoenix_variantd.mdl"},
{"FBI", "models/player/custom_player/legacy/ctm_fbi.mdl"},
{"FBI (Variant A)", "models/player/custom_player/legacy/ctm_fbi_varianta.mdl"},
{"FBI (Variant C)", "models/player/custom_player/legacy/ctm_fbi_variantc.mdl"},
{"FBI (Variant D)", "models/player/custom_player/legacy/ctm_fbi_variantd.mdl"},
{"FBI (Variant E)", "models/player/custom_player/legacy/ctm_fbi_variante.mdl"},
  {"SAS", "models/player/custom_player/legacy/ctm_sas.mdl"},
  {"Chicken", "models/chicken/chicken.mdl"},
  {"Cuddle Team Leader", "models/player/custom_player/legacy/cuddleleader.mdl"}
}

local dances = {
  {"None"},
  {"Fonzie Pistol", "Emote_Fonzie_Pistol"},
  {"Bring It On", "Emote_Bring_It_On"},
  {"Thumbs Down", "Emote_ThumbsDown"},
  {"Thumbs Up", "Emote_ThumbsUp"},
  {"Celebration Loop", "Emote_Celebration_Loop"},
  {"Blow Kiss", "Emote_BlowKiss"},
  {"Calculated", "Emote_Calculated"},
  {"Confused", "Emote_Confused",},
  {"Chug", "Emote_Chug"},
  {"Cry", "Emote_Cry"},
  {"Dusting Off Hands", "Emote_DustingOffHands"},
  {"Dust Off Shoulders", "Emote_DustOffShoulders",},
  {"Facepalm", "Emote_Facepalm"},
  {"Fishing", "Emote_Fishing"},
  {"Flex", "Emote_Flex"},
  {"Golfclap", "Emote_golfclap",},
  {"Hand Signals", "Emote_HandSignals"},
  {"Heel Click", "Emote_HeelClick"},
  {"Hotstuff", "Emote_Hotstuff"},
  {"IBreakYou", "Emote_IBreakYou",},
  {"IHeartYou", "Emote_IHeartYou"},
  {"Kung", "Emote_Kung-Fu_Salute"},
  {"Laugh", "Emote_Laugh"},
  {"Luchador", "Emote_Luchador",},
  {"Make It Rain", "Emote_Make_It_Rain"},
  {"Not Today", "Emote_NotToday"},
  {"[RPS] Paper", "Emote_RockPaperScissor_Paper"},
  {"[RPS] Rock", "Emote_RockPaperScissor_Rock",},
  {"[RPS] Scissor", "Emote_RockPaperScissor_Scissor"},
  {"Salt", "Emote_Salt"},
  {"Salute", "Emote_Salute"},
  {"Smooth Drive", "Emote_SmoothDrive",},
  {"Snap", "Emote_Snap"},
  {"StageBow", "Emote_StageBow",},
  {"Wave2", "Emote_Wave2"},
  {"Yeet", "Emote_Yeet"},
  {"Dance Moves", "DanceMoves"},
  {"Zippy Dance", "Emote_Zippy_Dance"},
  {"Electro Shuffle", "ElectroShuffle"},
  {"Aerobic Champ", "Emote_AerobicChamp"},
  {"Bendy", "Emote_Bendy"},
  {"Band Of The Fort", "Emote_BandOfTheFort"},
  {"Capoeira", "Emote_Capoeira"},
  {"Charleston", "Emote_Charleston"},
  {"Chicken", "Emote_Chicken"},
  {"No Bones", "Emote_Dance_NoBones",},
  {"Shoot", "Emote_Dance_Shoot"},
  {"Swipe It", "Emote_Dance_SwipeIt"},
  {"Disco 1", "Emote_Dance_Disco_T3"},
  {"Disco 2", "Emote_DG_Disco",},
  {"Worm", "Emote_Dance_Worm"},
  {"Loser", "Emote_Dance_Loser"},
  {"Breakdance", "Emote_Dance_Breakdance"},
  {"Pump", "Emote_Dance_Pump",},
  {"Ride The Pony", "Emote_Dance_RideThePony"},
  {"Dab", "Emote_Dab"},
  {"Fancy Feet", "Emote_FancyFeet",},
  {"Floss Dance", "Emote_FlossDance"},
  {"Flippn Sexy", "Emote_FlippnSexy"},
  {"Fresh", "Emote_Fresh"},
  {"Groove Jam", "Emote_GrooveJam",},
  {"Guitar", "Emote_guitar"},
  {"Hiphop", "Emote_Hiphop_01"},
  {"Korean Eagle", "Emote_KoreanEagle",},
  {"Kpop", "Emote_Kpop_02"},
  {"Living Large", "Emote_LivingLarge"},
  {"Maracas", "Emote_Maracas"},
  {"Pop Lock", "Emote_PopLock"},
  {"Pop Rock", "Emote_PopRock"},
  {"Robot Dance", "Emote_RobotDance"},
  {"T-Rex", "Emote_T-Rex",},
  {"Techno Zombie", "Emote_TechnoZombie"},
  {"Twist", "Emote_Twist"},
  {"Wiggle", "Emote_Wiggle"},
  {"You're Awesome", "Emote_Youre_Awesome"}
}

local lastModel = models[1][1]

local REFERENCE = gui.Reference( "Visuals", "Other" )
local GBOX = gui.Groupbox( REFERENCE, "Main Menu Model Changer", 328, 365, 298, 0 )

local MODEL = gui.Combobox( GBOX, "model.change", "Main Menu Model", "" )

local DANCE = gui.Combobox( GBOX, "model.dance", "Fortnite Dance", "" )
local APPLY_DANCE = gui.Button( GBOX, "Apply Dance", function()
  local model_path = models[MODEL:GetValue() + 1][2]
  local dance_path = dances[DANCE:GetValue() + 1][2]
  panorama.RunScript([[
    model = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
    model.visible = true;
    model.SetScene("resource/ui/fornite_dances.res", "]] .. model_path .. [[", false)
    model.PlaySequence("]] .. dance_path .. [[", true)
  ]] )
end )

local MODEL_CHANGECOLOR = gui.Checkbox( GBOX, "model.changecolor", "Change Color", false )
local MODEL_COLOR = gui.ColorPicker( MODEL_CHANGECOLOR, "model.color", "cock", 255, 0, 0, 255 )

local model_names = {}
for i = 1, #models do
  table.insert(model_names, models[i][1])
end
MODEL:SetOptions(unpack(model_names))

local dance_names = {}
for i = 1, #dances do
  table.insert(dance_names, dances[i][1])
end
DANCE:SetOptions(unpack(dance_names))

callbacks.Register( "Draw", function()
  if entities.GetLocalPlayer() then return end
  if MODEL_CHANGECOLOR:GetValue() then
    local r, g, b, a = MODEL_COLOR:GetValue()
    panorama.RunScript( [[
      model = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
      model.SetAmbientLightColor(]] .. r .. [[, ]] .. g .. [[, ]] .. b .. [[);
    ]] )
  end

  if lastModel ~= models[MODEL:GetValue() + 1][1] then
    lastModel = models[MODEL:GetValue() + 1][1]
    local model_path = models[MODEL:GetValue() + 1][2]
    if model_path == nil then
      panorama.RunScript([[
        model = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
        model.visible = false;
      ]] ) 
    else
      panorama.RunScript([[
        model = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
        model.visible = true;
        model.SetScene("resource/ui/econ/ItemModelPanelCharMainMenu.res", "models/player/custom_player/legacy/ctm_sas.mdl", false)
        model.SetSceneModel("]] .. model_path .. [[")
      ]] ) 
    end
  end
end )









