-- Scraped by chicken
-- Author: JohnK.
-- Title [Release] Command List Updated
-- Forum link https://aimware.net/forum/thread/107454

local active = true
local text_display = false
local gui_setup = true
local slider_x
local slider_y
local font_size_command = 25

-- in this list at the end, add ","New Command"" 
local command_list = {
  "mp_limitteams 0",
  "mp_autoteambalance 0",
  "mp_maxmoney 60000",
  "mp_startmoney 60000",
  "mp_freezetime 0",
  "mp_buytime 9999",
  "mp_buy_anywhere 1",
  "sv_infinite_ammo 1",
  "ammo_grenade_limit_total 5",
  "sv_grenade_trajectory 1",
  "sv_grenade_trajectory_time 10",
  "sv_showimpacts 1",
  "sv_showimpacts_time 10",
  "bot_stop 1",
  "bot_mimic 1",
}

-- in this list at the end, add ","Command which resets the Command used above""
local command_list_rest = {
  "mp_limitteams 1",
  "mp_autoteambalance 1",
  "mp_maxmoney 16000",
  "mp_startmoney 800",
  "mp_freezetime 15",
  "mp_buytime 35",
  "mp_buy_anywhere 0",
  "sv_infinite_ammo 0",
  "ammo_grenade_limit_total 4",
  "sv_grenade_trajectory 0",
  "sv_grenade_trajectory_time 0",
  "sv_showimpacts 0",
  "sv_showimpacts_time 0",
  "bot_stop 0",
  "bot_mimic 0",
}

function table.clone(org)
  return { table.unpack(org) }
end

local listakt = table.clone(command_list_rest)

local ref = gui.Window("Bot_Commands", "Bot Commands", 1000, 400, 220, 820)
for i = 1, #command_list_rest do
  client.Command("sv_cheats 1;" .. command_list_rest[i])
end
client.Command("sv_cheats 1;" .. "gods")

local function gui_stuff()

  if active then
    ref:SetActive(0)
    active = false
  else
    ref:SetActive(1)
    active = true
  end
end

local multibox = gui.Multibox(ref, "Commands")
for i = 1, #command_list do
  local check_box = gui.Checkbox(multibox, "command_" .. command_list[i], command_list[i], false)
end

local function execute_commands()
  for i = 1, #command_list do
    if gui.GetValue("command_" .. command_list[i]) and (listakt[i] ~= command_list[i]) then
      listakt[i] = command_list[i]

    elseif not gui.GetValue("command_" .. command_list[i]) and (listakt[i] ~= command_list_rest[i]) then
      listakt[i] = command_list_rest[i]
    end

    client.Command("sv_cheats 1;" .. listakt[i])

    text_display = true
  end
end


local godmode = false
local function round_prestart_event(Event)
  if Event:GetName() == "round_prestart" then
    godmode = false
  end
end

local function godmode_function()
  client.Command("sv_cheats 1;" .. "gods")
  if not godmode then
    godmode = true
  elseif godmode then
    godmode = false
  end
end

local command_color = gui.ColorEntry(bot_command_color, "Active Commands", 51, 255, 51, 200)
local function text_drawing_command()

  local sw, sh = draw.GetScreenSize();
  draw.SetFont(draw.CreateFont("Arial", math.floor(font_size_command:GetValue())))

  if gui.GetValue("msc_restrict") ~= 0 then 
    local textsize = draw.GetTextSize("Disable Anti-Ut when on Offline Server for sv_cheats to work")
    draw.Color(255,0,0,255)
    draw.TextShadow(sw / 2 - textsize / 2, 40 + math.floor(font_size_command:GetValue()) * 2, "Disable Anti-Ut when on Offline Server for sv_cheats to work")
  end
  
  draw.Color(command_color:GetValue())
  
  if gui_setup then
    slider_x = gui.Slider(ref, "bot_command_slider_x", "X Pos", 0, 0, sw);
    slider_Y = gui.Slider(ref, "bot_command_slider_y", "Y Pos", 0, 0, sh);
    gui_setup = false
  end
  local x = 1
  for i = 1, #command_list do
    if (listakt[i] == command_list[i]) then
      x = x + 1
      draw.TextShadow(slider_x:GetValue(), slider_Y:GetValue() - math.floor(font_size_command:GetValue()) * 2 + math.floor(font_size_command:GetValue()) * x, listakt[i])
    end
  end
  if godmode then
    local textsize = draw.GetTextSize("Godmode")
    draw.TextShadow(sw / 2 - textsize / 2, 40 + math.floor(font_size_command:GetValue()) * 2, "Godmode")
  end
end

callbacks.Register("Draw", "text_drawing_command", text_drawing_command);

local button = gui.Button(ref, "Refresh Commmands", execute_commands)

local button_window = gui.Button((gui.Reference("MISC", "GENERAl", "Extra")), "Command Window", gui_stuff)

local weapon_list = { "glock", "elite", "fiveseven", "usp_silencer", "deagle", "tec9", "p250", "hkp2000", "m4a1", "m4a1_silencer", "aug", "awp", "g3sg1", "sg552", "ak47", "scar20", "ssg08", "flashbang", "smokegrenade", "hegrenade", "molotov", "decoy", "m249", "mag7", "negev", "nova", "sawedoff", "xm1014", "bizon", "mac10", "mp7", "mp9", "p90", "ump45", "mp5sd" }
local weapon_box = gui.Combobox(ref, "command_weapon_box", "Weapon", "glock", "elite", "fiveseven", "usp_silencer", "deagle", "tec9", "p250", "hkp2000", "m4a1", "m4a1_silencer", "aug", "awp", "g3sg1", "sg552", "ak47", "scar20", "ssg08", "flashbang", "smokegrenade", "hegrenade", "molotov", "decoy", "m249", "mag7", "negev", "nova", "sawedoff", "xm1014", "bizon", "mac10", "mp7", "mp9", "p90", "ump45", "mp5sd")
local function drop_weapon()
  client.Command("sv_cheats 1;" .. "give weapon_" .. weapon_list[weapon_box:GetValue() + 1])
end

local drop_button = gui.Button(ref, "Drop Weapon", drop_weapon)

local bot_list = { "bot_kick", "bot_add_t", "bot_add_ct", "bot_add_t;bot_add_ct" }
local bot_command_box = gui.Combobox(ref, "Bot_Command", "Bot Command", "Kick Bot", "Add T", "Add CT", "Add CT and T")

local function execute_bot_command()
  client.Command("sv_cheats 1;" .. bot_list[bot_command_box:GetValue() + 1])
end

local bot_command_button = gui.Button(ref, "Execute Bot Command", execute_bot_command)

local bot_place_list = { "bot_place t", "bot_place ct", "bot_place 1" }

local bot_combobox_place = gui.Combobox(ref, "bot_combobox_place", "Bot Place", "Place T", "Place CT", "Place Random")
local function place_bot()
  print(bot_combobox_place:GetValue() + 1)
  client.Command("sv_cheats 1;" .. bot_place_list[bot_combobox_place:GetValue() + 1])
end

local place_bot_button = gui.Button(ref, "Place Bot at your Location", place_bot)

local function restart_game()
  client.Command("sv_cheats 1;" .. "mp_restartgame 1")
end

client.AllowListener("round_prestart")
callbacks.Register("FireGameEvent", "round_prestart_event", round_prestart_event)
local god_botton = gui.Button(ref, "Godmode", godmode_function)
local restart_button = gui.Button(ref, "Restart Game", restart_game)
local noclip_key_mode = gui.Combobox(ref,"no_clip_key","Toggle Mode Noclip","Toggle","On Hold")
local no_clip_key = gui.Keybox(ref, "no_clip_key", "Noclip", 0)
local host_timescale_key_mode = gui.Combobox(ref,"no_clip_key","Toggle Mode Host_Timescale","Toggle","On Hold")
local host_timescale_key = gui.Keybox(ref, "host_timescale_key", "Host Timscale", 0)
local host_timescale_value = gui.Slider(ref, "host_timescale_value", "Host Timescale Value", 0, 0, 12)
font_size_command = gui.Slider(ref, "font_size_command", "Font Size", 25, 0, 50)
local no_clip_active = false
local host_timescale_active = false


local function key_commands() 

  if no_clip_key:GetValue() ~= 0 then
    if noclip_key_mode:GetValue() == 0 then
      if input.IsButtonPressed(no_clip_key:GetValue())then
        client.Command("sv_cheats 1;" .. "noclip")
      end
    else
      if input.IsButtonDown(no_clip_key:GetValue()) and not no_clip_active then
        no_clip_active = true 
        client.Command("sv_cheats 1;" .. "noclip",true)
      elseif input.IsButtonReleased(no_clip_key:GetValue()) and no_clip_active then
        no_clip_active = false 
        client.Command("sv_cheats 1;" .. "noclip",false)
      end
    end
  end

  if host_timescale_key:GetValue() ~= 0 then
    if host_timescale_key_mode:GetValue() == 0 then
      if input.IsButtonPressed(host_timescale_key:GetValue()) then
        client.Command("sv_cheats 1;" .. "host_timescale " .. math.floor(host_timescale_value:GetValue() + 0.5))
      end
    else
      if input.IsButtonDown(host_timescale_key:GetValue()) and not host_timescale_active then
        host_timescale_active = true 
        client.Command("sv_cheats 1;" .. "host_timescale " .. math.floor(host_timescale_value:GetValue() + 0.5))
      elseif input.IsButtonReleased(host_timescale_key:GetValue()) and host_timescale_active then
        host_timescale_active = false 
        client.Command("sv_cheats 1;" .. "host_timescale 1")
      end
    end
  end

end
callbacks.Register("Draw", "key_commands", key_commands);
