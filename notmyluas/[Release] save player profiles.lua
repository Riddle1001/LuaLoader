-- Scraped by chicken
-- Author: zRekon
-- Title [Release] save player profiles
-- Forum link https://aimware.net/forum/thread/114358

json = {_version = "0.1.1"} local b local c = {["\\"] = "\\\\", ['"'] = '\\"', ["\b"] = "\\b", ["\f"] = "\\f", ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t"} local d = {["\\/"] = "/"} for e, f in pairs(c) do d[f] = e end local function g(h) return c[h] or string.format("\\u%04x", h:byte()) end local function i(j) return "null" end local function k(j, l) local m = {} l = l or {} if l[j] then error("circular reference") end l[j] = true if j[1] ~= nil or next(j) == nil then local n = 0 for e in pairs(j) do if type(e) ~= "number" then error("invalid table: mixed or invalid key types") end n = n + 1 end if n ~= #j then error("invalid table: sparse array") end for o, f in ipairs(j) do table.insert(m, b(f, l)) end l[j] = nil return "[" .. table.concat(m, ",") .. "]" else for e, f in pairs(j) do if type(e) ~= "string" then error("invalid table: mixed or invalid key types") end table.insert(m, b(e, l) .. ":" .. b(f, l)) end l[j] = nil return "{" .. table.concat(m, ",") .. "}" end end local function p(j) return '"' .. j:gsub('[%z\1-\31\\"]', g) .. '"' end local function q(j) if j ~= j or j <= -math.huge or j >= math.huge then error("unexpected number value '" .. tostring(j) .. "'") end return string.format("%.14g", j) end local r = {["nil"] = i, ["table"] = k, ["string"] = p, ["number"] = q, ["boolean"] = tostring} b = function(j, l) local s = type(j) local t = r[s] if t then return t(j, l) end error("unexpected type '" .. s .. "'") end function json.encode(j) return b(j) end local u local function v(...) local m = {} for o = 1, select("#", ...) do m[select(o, ...)] = true end return m end local w = v(" ", "\t", "\r", "\n") local x = v(" ", "\t", "\r", "\n", "]", "}", ",") local y = v("\\", "/", '"', "b", "f", "n", "r", "t", "u") local z = v("true", "false", "null") local A = {["true"] = true, ["false"] = false, ["null"] = nil} local function B(C, D, E, F) for o = D, #C do if E[C:sub(o, o)] ~= F then return o end end return #C + 1 end local function G(C, D, H) local I = 1 local J = 1 for o = 1, D - 1 do J = J + 1 if C:sub(o, o) == "\n" then I = I + 1 J = 1 end end error(string.format("%s at line %d col %d", H, I, J)) end local function K(n) local t = math.floor if n <= 0x7f then return string.char(n) elseif n <= 0x7ff then return string.char(t(n / 64) + 192, n % 64 + 128) elseif n <= 0xffff then return string.char(t(n / 4096) + 224, t(n % 4096 / 64) + 128, n % 64 + 128) elseif n <= 0x10ffff then return string.char(t(n / 262144) + 240, t(n % 262144 / 4096) + 128, t(n % 4096 / 64) + 128, n % 64 + 128) end error(string.format("invalid unicode codepoint '%x'", n)) end local function L(M) local N = tonumber(M:sub(3, 6), 16) local O = tonumber(M:sub(9, 12), 16) if O then return K((N - 0xd800) * 0x400 + O - 0xdc00 + 0x10000) else return K(N) end end local function P(C, o) local Q = false local R = false local S = false local T for U = o + 1, #C do local V = C:byte(U) if V < 32 then G(C, U, "control character in string") end if T == 92 then if V == 117 then local W = C:sub(U + 1, U + 5) if not W:find("%x%x%x%x") then G(C, U, "invalid unicode escape in string") end if W:find("^[dD][89aAbB]") then R = true else Q = true end else local h = string.char(V) if not y[h] then G(C, U, "invalid escape char '" .. h .. "' in string") end S = true end T = nil elseif V == 34 then local M = C:sub(o + 1, U - 1) if R then M = M:gsub("\\u[dD][89aAbB]..\\u....", L) end if Q then M = M:gsub("\\u....", L) end if S then M = M:gsub("\\.", d) end return M, U + 1 else T = V end end G(C, o, "expected closing quote for string") end local function X(C, o) local V = B(C, o, x) local M = C:sub(o, V - 1) local n = tonumber(M) if not n then G(C, o, "invalid number '" .. M .. "'") end return n, V end local function Y(C, o) local V = B(C, o, x) local Z = C:sub(o, V - 1) if not z[Z] then G(C, o, "invalid literal '" .. Z .. "'") end return A[Z], V end local function _(C, o) local m = {} local n = 1 o = o + 1 while 1 do local V o = B(C, o, w, true) if C:sub(o, o) == "]" then o = o + 1 break end V, o = u(C, o) m[n] = V n = n + 1 o = B(C, o, w, true) local a0 = C:sub(o, o) o = o + 1 if a0 == "]" then break end if a0 ~= "," then G(C, o, "expected ']' or ','") end end return m, o end local function a1(C, o) local m = {} o = o + 1 while 1 do local a2, j o = B(C, o, w, true) if C:sub(o, o) == "}" then o = o + 1 break end if C:sub(o, o) ~= '"' then G(C, o, "expected string for key") end a2, o = u(C, o) o = B(C, o, w, true) if C:sub(o, o) ~= ":" then G(C, o, "expected ':' after key") end o = B(C, o + 1, w, true) j, o = u(C, o) m[a2] = j o = B(C, o, w, true) local a0 = C:sub(o, o) o = o + 1 if a0 == "}" then break end if a0 ~= "," then G(C, o, "expected '}' or ','") end end return m, o end local a3 = {['"'] = P, ["0"] = X, ["1"] = X, ["2"] = X, ["3"] = X, ["4"] = X, ["5"] = X, ["6"] = X, ["7"] = X, ["8"] = X, ["9"] = X, ["-"] = X, ["t"] = Y, ["f"] = Y, ["n"] = Y, ["["] = _, ["{"] = a1} u = function(C, D) local a0 = C:sub(D, D) local t = a3[a0] if t then return t(C, D) end G(C, D, "unexpected character '" .. a0 .. "'") end function json.decode(C) if type(C) ~= "string" then error("expected argument of type string, got " .. type(C)) end local m, D = u(C, B(C, 1, w, true)) D = B(C, D, w, true) if D <= #C then G(C, D, "trailing garbage") end return m end
local LUA_PLAYER_INFO_REFERENCE = gui.Reference("MISC", "General", "Main")
local LUA_PLAYER_INFO_ENABLE = gui.Checkbox(LUA_PLAYER_INFO_REFERENCE, "LUA_PLAYER_INFO_ENABLE", "LUA PlayerInfo Enable", 0)
local LUA_PLAYER_INFO_CONFIGURATION = gui.Checkbox(LUA_PLAYER_INFO_REFERENCE, "LUA_PLAYER_INFO_CONFIGURATION", "LUA PlayerInfo Settings", 0)
local LUA_PLAYER_INFO_WINDOW = gui.Window("LUA_PLAYER_INFO_WINDOW", "PlayerInfo Settings", 0, 400, 221, 400)
local LUA_PLAYER_INFO_GROUPBOX = gui.Groupbox(LUA_PLAYER_INFO_WINDOW, "General", 10, 10, 200, 350)
local multibox_ref = gui.Multibox(LUA_PLAYER_INFO_GROUPBOX, "Show/Hide")
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_1", "Show Level", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_2", "Show Vac", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_3", "Show GameBans", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_4", "Show Last Bans", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_5", "Show Hours", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_6", "Show matches", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_7", "Show Wins", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_8", "Show Kills", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_9", "Show Deaths", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_10", "Show Friends", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_11", "Show Account Created", 1)
gui.Checkbox(multibox_ref, "LUA_PLAYER_INFO_12", "Show Last Online", 1)
local AUTO_OPEN_CONSOLE = gui.Checkbox(LUA_PLAYER_INFO_GROUPBOX, "AUTO_OPEN_CONSOLE", "Profile link opens console", 1)
local AUTO_CLEAR_CONSOLE = gui.Checkbox(LUA_PLAYER_INFO_GROUPBOX, "AUTO_CLEAR_CONSOLE", "Profile link clears console", 1)
local SHOW_AVATAR_IMAGE = gui.Checkbox(LUA_PLAYER_INFO_GROUPBOX, "SHOW_AVATAR_IMAGE", "Show profile picture", 0)
local IGNORE_BANNED_PROFILES_TOGGLE = gui.Checkbox(LUA_PLAYER_INFO_GROUPBOX, "IGNORE_BANNED_PROFILES_TOGGLE", "Don't update banned profiles", 0)
local HIGHLIGHT_BANNED_RETARDS = gui.Checkbox(LUA_PLAYER_INFO_GROUPBOX, "HIGHLIGHT_BANNED_RETARDS", "Highlight banned profiles", 1)
local SHOW_AVATAR_IMAGE_QUALITY = gui.Combobox(LUA_PLAYER_INFO_GROUPBOX, "SHOW_AVATAR_IMAGE_QUALITY", "Profile picture quality", "High", "Medium","Low")
local SHOW_DAYS_SINCE_CREATED = gui.Combobox(LUA_PLAYER_INFO_GROUPBOX, "SHOW_DAYS_SINCE_CREATED", "Account Created", "Show Days", "Show Date")
local SCROLL_SPEED = gui.Slider(LUA_PLAYER_INFO_GROUPBOX, "SCROLL_SPEED", "Scroll Speed", 3, 1, 5)
local color_entry_1 = gui.ColorEntry("clr_lua_pl_background", "Player list background", 16, 16, 16, 255)
local color_entry_2 = gui.ColorEntry("clr_lua_pl_background_2", "Player list background 2", 20, 20, 20, 255)
local color_entry_3 = gui.ColorEntry("clr_lua_pl_header", "Player list header", 253, 163, 255, 123)
local color_entry_4 = gui.ColorEntry("clr_lua_pl_header_tab2", "Player list header_2", 253, 163, 255, 255)
local color_entry_5 = gui.ColorEntry("clr_lua_pl_footer", "Player list footer", 25, 25, 25, 255)
local color_entry_6 = gui.ColorEntry("clr_lua_pl_text_1", "Player list text_1", 255, 255, 255, 255)
local color_entry_7 = gui.ColorEntry("clr_lua_pl_text_2", "Player list text_2", 45, 255, 0, 255)
local color_entry_8 = gui.ColorEntry("clr_lua_pl_list", "Player list Button", 22, 22, 22, 255)
local listen_to_events = {
  "game_init",
  "player_team",
  "player_changename",
  "game_end",
  "player_disconnect"
}
local options_array_optional = {
  {"Level", 45, 1, {"level"}, "", 0},
  {"Vac", 35, 2, {"bans", "vacBans"}, "", 0},
  {"GameBan", 55, 2, {"bans", "gameBans"}, "", 0},
  {"Last Ban", 50, 2, {"bans", "daysSinceLastBan"}, " days", 0},
  {"Hours", 55, 3, {"stats", "stats", "total_time_played"}, "h", 1},
  {"Matches", 55, 3, {"stats", "stats", "total_matches_played"}, "", 0},
  {"Wins", 55, 3, {"stats", "stats", "total_matches_won"}, "", 0},
  {"Kills", 55, 3, {"stats", "stats", "total_kills"}, "", 0},
  {"Deaths", 55, 3, {"stats", "stats", "total_deaths"}, "", 0},
  {"Friends", 50, 1, {"friends"}, "", 1},
  {"Account Created", 110, 2, {"summary", "created"}, "", 1},
  {"Last Online", 100, 2, {"summary", "lastLogOff"}, "", 1}
}
local last_write_interval = globals.TickCount()
local playerinfo_cache_match = {}
local cached_player_list = {}
local playerinfo_cache = {}
local options_array = {}
local player_list = {}
local mouse_x_right_click, mouse_y_right_click = 0,0
local menu_box_width, menu_box_height = 865, 257
local menu_box_x, menu_box_y = 0, 50
local current_active_player = 0
local rows_start_stat_match = 0
local currently_updating = 0
local dragging_offset_x = 0
local dragging_offset_y = 0
local resizing_offset_x = 0
local resizing_offset_y = 0
local rows_start_stat = 0
local rows_start = 0
local count_bans = 0
local color1
local color2
local color3
local color4
local color5
local color6
local color7
local color8
local show_right_click_menu = false
local updating_in_progress = false
local updating_in_progress_cache = false
local is_dragging = false
local is_resizing = false
local show_mode = true
local imgRGBA, imgWidth, imgHeight = nil,nil,nil
local texture = nil
local NETWORK_GET_ADDR = "https://api.shadyretard.io/playerinfo/%s"
local LUA_GAME_SAVE_FILE_NAME = "save_user_data.dat"
local my_file = file.Open(LUA_GAME_SAVE_FILE_NAME, "a")
my_file:Close()
local char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end
local function parseStringtoTable(stringified_table)
  local strings_to_parse = {}
  for i in string.gmatch(stringified_table, "([^\n]*)\n?") do
    table.insert(strings_to_parse, i)
  end
  return strings_to_parse
end
for _, v in ipairs(listen_to_events) do
  client.AllowListener(v)
end
local function update_players()
  player_list = {}
  if entities.GetLocalPlayer() ~= nil then
    for i = 1, globals.MaxClients(), 1 do
      if client.GetPlayerInfo(i) ~= nil and client.GetPlayerInfo(i)["IsBot"] == false and client.GetPlayerInfo(i)["IsGOTV"] == false then
        table.insert(player_list, i)
      end
    end
  end
end
local function switch_modes()
  if show_mode == true then
    show_mode = false
  else
    show_mode = true
  end
end
local function draw_window()
  color1 = {color_entry_1:GetValue()}
  color2 = {color_entry_3:GetValue()}
  color3 = {color_entry_4:GetValue()}
  color4 = {color_entry_6:GetValue()}
  color5 = {color_entry_2:GetValue()}
  color6 = {color_entry_5:GetValue()}
  color7 = {color_entry_7:GetValue()}
  color8 = {color_entry_8:GetValue()}
  if globals.TickCount() - last_write_interval > (64 * 5) then
    update_players()
    last_write_interval = globals.TickCount()
  end
  if current_active_player ~= 0 and SHOW_AVATAR_IMAGE:GetValue() == true and menu_box_height < 350 then
    menu_box_height = 350
  end
  draw.Color(color1[1],color1[2],color1[3],color1[4])
  draw.FilledRect(menu_box_x, menu_box_y - 25, menu_box_x + menu_box_width, menu_box_y + menu_box_height)
  draw.FilledRect(menu_box_x + menu_box_width + 2, menu_box_y + menu_box_height - 10, menu_box_x + menu_box_width + 7, menu_box_y + menu_box_height + 6)
  draw.FilledRect(menu_box_x + menu_box_width - 10, menu_box_y + menu_box_height + 2, menu_box_x + menu_box_width + 6, menu_box_y + menu_box_height + 7)
  draw.Color(color2[1],color2[2],color2[3],color2[4])
  draw.FilledRect(menu_box_x, menu_box_y - 50, menu_box_x + menu_box_width, menu_box_y - 25)
  draw.Color(color3[1],color3[2],color3[3],color3[4])
  draw.FilledRect(menu_box_x, menu_box_y - 25, menu_box_x + menu_box_width, menu_box_y - 25 + 4)
  draw.Color(color4[1],color4[2],color4[3],color4[4])
  draw.TextShadow(menu_box_x + 8, menu_box_y - 25 - 18, "Player Information")
  draw.Color(color5[1],color5[2],color5[3],color5[4])
  if current_active_player ~= 0 and SHOW_AVATAR_IMAGE:GetValue() == true and show_mode == true then
    draw.FilledRect(menu_box_x + 10, menu_box_y - 10, menu_box_x + 210, menu_box_y + menu_box_height - 255)
  else
    draw.FilledRect(menu_box_x + 10, menu_box_y - 10, menu_box_x + 210, menu_box_y + menu_box_height - 55)
  end
end
local function urlencode(url)
  if url == nil then
    return
  end
  url = url:gsub("\n", "\r\n")
  url = url:gsub("([^%w ])", char_to_hex)
  url = url:gsub(" ", "+")
  return url
end
local function value_in_table(tbl, value)
  for _, v in ipairs(tbl) do
    if value == v then
      return true
    end
  end
  return false
end
local function key_in_table(tbl, key)
  for k, _ in pairs(tbl) do
    if key == k then
      return true
    end
  end
  return false
end
local function cache_the_current_mathc_player()
    updating_in_progress_cache = true
    playerinfo_cache_match = {}
    for i, v in pairs(player_list) do
      local steamid = client.GetPlayerInfo(v)
      if (steamid ~= nil and steamid["IsBot"] == false) then
        http.Get(
          string.format(NETWORK_GET_ADDR, urlencode(steamid["SteamID"])),
          function(response)
            if (response == nil or response == "error") then
              return
            end
            local playerinfo_cache_temp = json.decode(response)
            table.insert(playerinfo_cache_match, i, playerinfo_cache_temp)
            if i == #player_list then
              updating_in_progress_cache = false
            end
          end
        )
      end
    end
end
local function read_player_data()
  local my_file = file.Open(LUA_GAME_SAVE_FILE_NAME, "r")
  local file_read = my_file:Read()
  if file_read ~= "" then
    local read_file_parsed = parseStringtoTable(file_read)
    cached_player_list = {}
    for i, v in pairs(read_file_parsed) do
      table.insert(cached_player_list, i, json.decode(v))
    end
  end
  count_bans = 0
  for i = 1, #cached_player_list, 1 do
    if (cached_player_list[i]["bans"]["vacBans"] ~= 0 or cached_player_list[i]["bans"]["gameBans"] ~= 0) then
      count_bans = count_bans + 1
    end
  end

  my_file:Close()
end
local function is_mouse_in_rect(left, top, width, height)
  local mouse_x, mouse_y = input.GetMousePos()
  local xpos, ypos = gui.GetValue("wnd_menu")
  return (mouse_x >= left and mouse_x <= left + width and mouse_y >= top and mouse_y <= top + height) and not (mouse_x >= xpos and mouse_x <= xpos + 800 and mouse_y >= ypos and mouse_y <= ypos + 600)
end
local function set_active_player(id)
  if input.IsButtonPressed(1) then
    current_active_player = id
    show_right_click_menu = false
    mouse_x_right_click, mouse_y_right_click = -500,-500
  end
  if input.IsButtonPressed(2) then
    current_active_player = id
    show_right_click_menu = false
    mouse_x_right_click, mouse_y_right_click = -500,-500
    if id ~= 0 then
    current_active_player = id
    show_right_click_menu = true
    mouse_x_right_click, mouse_y_right_click = input.GetMousePos()
    end
  end
end
local function add_player_to_list(info)
  local my_file = file.Open(LUA_GAME_SAVE_FILE_NAME, "a")
  my_file:Write(json.encode(info) .. "\n")
  my_file:Close()
  read_player_data()
end
local function remove_player_from_list(id)
  if id ~= 0 then
    table.remove(cached_player_list, id)
    local edit_file = file.Open(LUA_GAME_SAVE_FILE_NAME, "w")
    for _, v in pairs(cached_player_list) do
      edit_file:Write(json.encode(v) .. "\n")
    end
    edit_file:Close()
    read_player_data()
    set_active_player(0)
  end
end
local function update_selected_player(id)
  if id ~= 0 then
    local steamid = cached_player_list[id]["summary"]["steamID"]
    if steamid ~= nil then
      http.Get(
        string.format(NETWORK_GET_ADDR, urlencode(steamid)),
        function(response)
          if (response == nil or response == "error" or key_in_table(playerinfo_cache, steamid) == true) then
            return
          end
          playerinfo_cache = {}
          playerinfo_cache = json.decode(response)
          cached_player_list[id] = playerinfo_cache
          local edit_file = file.Open(LUA_GAME_SAVE_FILE_NAME, "w")
          for _, v in pairs(cached_player_list) do
            edit_file:Write(json.encode(v) .. "\n")
          end
          edit_file:Close()
          read_player_data()
        end
      )
    end
  end
end
local function update_all_players(starting_id)
  updating_in_progress = true
  --currently_updating = 1
  for i = starting_id, #cached_player_list, 1 do
    local skip = false
    if (cached_player_list[i]["bans"]["vacBans"] ~= 0 or cached_player_list[i]["bans"]["gameBans"] ~= 0) and IGNORE_BANNED_PROFILES_TOGGLE:GetValue() then
      skip = true
    end
    if skip == false then
      local steamid = cached_player_list[i]["summary"]["steamID"]
      if steamid ~= nil then
        http.Get(
          string.format(NETWORK_GET_ADDR, urlencode(steamid)),
          function(response)
            if (response == nil or response == "error" or key_in_table(playerinfo_cache, steamid) == true) then
              return
            end
            playerinfo_cache = {}
            playerinfo_cache = json.decode(response)
            cached_player_list[i] = playerinfo_cache
            currently_updating = i
            if i == #cached_player_list then
              local edit_file = file.Open(LUA_GAME_SAVE_FILE_NAME, "w")
              for _, vv in pairs(cached_player_list) do
                edit_file:Write(json.encode(vv) .. "\n")
              end
              currently_updating = 0
              updating_in_progress = false
              edit_file:Close()
              read_player_data()
            end
          end
        )
      end
    end
  end
  --for i = starting_id, v in pairs(cached_player_list) do
  --  local steamid = v["summary"]["steamID"]
  --  if steamid ~= nil then
  --    http.Get(
  --      string.format(NETWORK_GET_ADDR, urlencode(steamid)),
  --      function(response)
  --        currently_updating = currently_updating + 1
  --        if (response == nil or response == "error" or key_in_table(playerinfo_cache, steamid) == true) then
  --          return
  --        end
  --        playerinfo_cache = {}
  --        playerinfo_cache = json.decode(response)
  --        cached_player_list[i] = playerinfo_cache
  --        if i == #cached_player_list then
  --          local edit_file = file.Open(LUA_GAME_SAVE_FILE_NAME, "w")
  --          for _, vv in pairs(cached_player_list) do
  --            edit_file:Write(json.encode(vv) .. "\n")
  --          end
  --          currently_updating = 0
  --          updating_in_progress = false
  --          edit_file:Close()
  --          read_player_data()
  --        end
  --      end
  --    )
  --  end
  --end
end
local function print_to_console(id)
  if id ~= 0 then
    local steamid = "echo " .. cached_player_list[id]["summary"]["nickname"] .. " - steamcommunity.com/profiles/" .. cached_player_list[id]["summary"]["steamID"]
    if AUTO_CLEAR_CONSOLE:GetValue() then
      client.Command("clear", true)
    end
    if AUTO_OPEN_CONSOLE:GetValue() then
      client.Command("showconsole", true)
    end
    client.Command("echo --------------------------------------------------------------------------------", true)
    client.Command(steamid, true)
    client.Command("echo --------------------------------------------------------------------------------", true)

  end
end
local is_list_empty = true
local function show_task_options()
  if #player_list == 0 then
    is_list_empty = true
  else
    is_list_empty = false
  end
  if is_mouse_in_rect(menu_box_x + 10, menu_box_y + menu_box_height - 45, menu_box_x + 190 - menu_box_x + 10, (menu_box_y + menu_box_height - 30) - (menu_box_y + menu_box_height - 45)) then
    if input.IsButtonPressed(1) then
      switch_modes()
    end
    draw.Color(color3[1],color3[2],color3[3],color3[4])
  else
    draw.Color(color2[1],color2[2],color2[3],color2[4])
  end
  draw.FilledRect(menu_box_x + 10, menu_box_y + menu_box_height - 45, menu_box_x + 210, menu_box_y + menu_box_height - 30)
  if (is_mouse_in_rect(menu_box_x + 10, menu_box_y + menu_box_height - 25, menu_box_x + 190 - menu_box_x + 10, (menu_box_y + menu_box_height - 10) - (menu_box_y + menu_box_height - 25)) and show_mode and not updating_in_progress) or (is_mouse_in_rect(menu_box_x + 10, menu_box_y + menu_box_height - 25, menu_box_x + 190 - menu_box_x + 10, (menu_box_y + menu_box_height - 10) - (menu_box_y + menu_box_height - 25)) and not show_mode and not updating_in_progress_cache and not is_list_empty) then
    if input.IsButtonPressed(1) then
      if show_mode == true then
        update_all_players(1)
      else
        cache_the_current_mathc_player()
      end
    end
    draw.Color(color3[1],color3[2],color3[3],color3[4])
  else
    if (updating_in_progress and show_mode) or (updating_in_progress_cache and not show_mode) or (is_list_empty and not show_mode) then
      draw.Color(color8[1],color8[2],color8[3],color8[4])
    else
      draw.Color(color2[1],color2[2],color2[3],color2[4])
    end
  end
  draw.FilledRect(menu_box_x + 10, menu_box_y + menu_box_height - 25, menu_box_x + 210, menu_box_y + menu_box_height - 10)
  draw.Color(color4[1],color4[2],color4[3],color4[4])
  if show_mode == true then
    draw.TextShadow(menu_box_x + 71, menu_box_y + menu_box_height - 24, "UPDATE SAVED")
    draw.TextShadow(menu_box_x + 72, menu_box_y + menu_box_height - 44, "SHOW IN-GAME")
  else
    draw.TextShadow(menu_box_x + 67, menu_box_y + menu_box_height - 24, "UPDATE IN-GAME")
    draw.TextShadow(menu_box_x + 77, menu_box_y + menu_box_height - 44, "SHOW SAVED")
  end
end

local function draw_player_info_match()
  show_task_options()
  if entities.GetLocalPlayer() == nil then
    player_list = {}
  end
  options_array = {{"Nickname", 175, 2, {"summary", "nickname"}, "", 0}}
  for idd = 1, #options_array_optional, 1 do
    if gui.GetValue("LUA_PLAYER_INFO_" .. idd) then
      table.insert(options_array, options_array_optional[idd])
    end
  end
  local gap = 10
  draw.Color(color6[1],color6[2],color6[3],color6[4])
  draw.FilledRect(menu_box_x + 220 + 10, menu_box_y, menu_box_x + menu_box_width - 20, menu_box_y + 15)
  draw.Color(color4[1],color4[2],color4[3],color4[4])
  local rows_end_stat_match = (menu_box_y + menu_box_height - 10 - menu_box_y + (15 / 15)) / 15
  if is_mouse_in_rect(menu_box_x + 210 + 10, menu_box_y - 10, (menu_box_x + menu_box_width) - (menu_box_x + 220 + 10), (menu_box_y + menu_box_height - 10) - (menu_box_y - 10)) then
    local scroll_get = math.floor(SCROLL_SPEED:GetValue())
    if input.IsButtonPressed(254) then
      rows_start_stat_match = scroll_get- 1
    end
    if input.IsButtonPressed(255) then
      if rows_end_stat_match + rows_start_stat_match - 2.5 < #playerinfo_cache_match then
        rows_start_stat_match = scroll_get + 1
      end
    end
  end
  if rows_start_stat_match > #playerinfo_cache_match then
    rows_start_stat_match = #playerinfo_cache_match + 1
  end
  if rows_start_stat_match < 1 then
    rows_start_stat_match = 1
  end
  local spacing = 5
  for _, v in pairs(options_array) do
    draw.TextShadow(menu_box_x + 225 + gap + spacing, menu_box_y, v[1])
    spacing = spacing + v[2]
  end
  if playerinfo_cache_match ~= nil then
    for i = rows_start_stat_match, rows_end_stat_match + rows_start_stat_match - 2.5, 1 do
      if playerinfo_cache_match[i] ~= nil then
        draw.Color(color6[1],color6[2],color6[3],color6[4])
        draw.FilledRect(menu_box_x + 220 + 10, menu_box_y + (15 * (i - rows_start_stat_match + 1)), menu_box_x + menu_box_width - 20, menu_box_y + (15 * (i - rows_start_stat_match + 1)) + 15)
        if HIGHLIGHT_BANNED_RETARDS:GetValue() and (playerinfo_cache_match[i]["bans"]["vacBans"] ~= 0 or playerinfo_cache_match[i]["bans"]["gameBans"] ~= 0) then
          draw.Color(255,65,65,255)
        else
          draw.Color(color4[1],color4[2],color4[3],color4[4])
        end
        if playerinfo_cache_match[i] ~= nil then
          local spacing = 5
          for _, vv in pairs(options_array) do
            if playerinfo_cache_match[i][vv[4][1]] ~= "" then
              if vv[3] == 1 then
                local message = nil
                if vv[6] == 1 then
                  message = #playerinfo_cache_match[i][vv[4][1]]
                else
                  message = playerinfo_cache_match[i][vv[4][1]]
                end
                if message == nil then
                  message = "HIDDEN"
                end
                draw.TextShadow(menu_box_x + 225 + gap + spacing, menu_box_y + (15 * (i - rows_start_stat_match + 1)), message .. vv[5])
              elseif vv[3] == 2 then
                local message = nil
                if vv[6] == 1 then
                  if playerinfo_cache_match[i][vv[4][1]][vv[4][2]] ~= nil then
                    if SHOW_DAYS_SINCE_CREATED:GetValue() == 0 then
                      local daysfrom = math.floor(os.difftime(os.time(), playerinfo_cache_match[i][vv[4][1]][vv[4][2]]) / (24 * 60 * 60))
                      message = daysfrom .. " days ago"
                    else
                      message = os.date("%Y-%m-%d %H:%M:%S", playerinfo_cache_match[i][vv[4][1]][vv[4][2]])
                    end
                    
                  else
                    message = "HIDDEN"
                  end
                else
                  message = playerinfo_cache_match[i][vv[4][1]][vv[4][2]]
                end
                if message == nil then
                  message = "HIDDEN"
                end
                draw.TextShadow(menu_box_x + 225 + gap + spacing, menu_box_y + (15 * (i - rows_start_stat_match + 1)), message .. vv[5])
              elseif vv[3] == 3 then
                local message = nil
                if vv[6] == 1 then
                  message = math.floor(playerinfo_cache_match[i][vv[4][1]][vv[4][2]][vv[4][3]] / 60 / 60)
                else
                  message = playerinfo_cache_match[i][vv[4][1]][vv[4][2]][vv[4][3]]
                end
                if message == nil then
                  message = "HIDDEN"
                end
                draw.TextShadow(menu_box_x + 225 + gap + spacing, menu_box_y + (15 * (i - rows_start_stat_match + 1)), message .. vv[5])
              end
            else
              draw.TextShadow(menu_box_x + 225 + gap + spacing, menu_box_y + (15 * (i - rows_start_stat_match + 1)), "HIDDEN")
            end
            spacing = spacing + vv[2]
          end
        end
      end
    end
  end
end
local function get_profile_pic(index)
  if index ~= 0 then
    local url
    if SHOW_AVATAR_IMAGE_QUALITY:GetValue() == 0 then
      url = cached_player_list[index]["summary"]["avatar"]["large"]
    elseif SHOW_AVATAR_IMAGE_QUALITY:GetValue() == 1 then
      url = cached_player_list[index]["summary"]["avatar"]["medium"]
    elseif SHOW_AVATAR_IMAGE_QUALITY:GetValue() == 2 then
      url = cached_player_list[index]["summary"]["avatar"]["small"]
    end
    imgRGBA, imgWidth, imgHeight = common.DecodeJPEG(http.Get(url))
    texture = draw.CreateTexture(imgRGBA, imgWidth, imgHeight)
  end
end
local function draw_profile_pic()
  if current_active_player ~= 0 then
    draw.Color(255,255,255,255)
    if texture ~= nil and imgWidth ~= nil and imgHeight ~= nil then
      draw.SetTexture(texture);
      draw.FilledRect(menu_box_x + 10, menu_box_y + menu_box_height - 55 - 190, menu_box_x + 210, menu_box_y + menu_box_height - 55)
      draw.SetTexture(draw.CreateTexture());
    end
  end 
end
local function draw_player_info()
  show_task_options()
  if entities.GetLocalPlayer() == nil then
    player_list = {}
  end
  options_array = {{"Nickname", 175, 2, {"summary", "nickname"}, "", 0}}
  for idd = 1, #options_array_optional, 1 do
    if gui.GetValue("LUA_PLAYER_INFO_" .. idd) then
      table.insert(options_array, options_array_optional[idd])
    end
  end
  local gap = 10
  draw.Color(color6[1],color6[2],color6[3],color6[4])
  draw.FilledRect(menu_box_x + 220 + 10, menu_box_y, menu_box_x + menu_box_width - 20, menu_box_y + 15)
  draw.Color(color4[1],color4[2],color4[3],color4[4])
  local rows_end_stat = (menu_box_y + menu_box_height - 10 - menu_box_y + (15 / 15)) / 15
  if is_mouse_in_rect(menu_box_x + 210 + 10, menu_box_y - 10, (menu_box_x + menu_box_width) - (menu_box_x + 220 + 10), (menu_box_y + menu_box_height - 10) - (menu_box_y - 10)) then
    local scroll_get = math.floor(SCROLL_SPEED:GetValue())
    if input.IsButtonPressed(254) then
      rows_start_stat = rows_start_stat - scroll_get - 1
    end
    if input.IsButtonPressed(255) then
      if rows_end_stat + rows_start_stat - 2.5 < #cached_player_list then
        rows_start_stat = rows_start_stat + scroll_get + 1
      end
    end
  end
  if rows_start_stat > #cached_player_list then
    rows_start_stat = #cached_player_list + 1
  end
  if rows_start_stat < 1 then
    rows_start_stat = 1
  end
  local spacing = 5
  for ii, _ in pairs(options_array) do
    draw.TextShadow(menu_box_x + 225 + gap + spacing, menu_box_y, options_array[ii][1])
    spacing = spacing + options_array[ii][2]
  end
  draw.Color(color2[1],color2[2],color2[3],color2[4])
  local wwwwwww = ((menu_box_y + menu_box_height - 17)-(menu_box_y - 15))/(#cached_player_list / (rows_start_stat - 1))
  local top = menu_box_y + wwwwwww
  local lengthing = ((menu_box_y + menu_box_height - 17)-(menu_box_y - 15))/(#cached_player_list / (rows_end_stat - 3.5))
  local bottom = top + lengthing
  if (top + lengthing) > (menu_box_y + menu_box_height - 17) then
    bottom = menu_box_y + menu_box_height - 17
  end
  draw.FilledRect(menu_box_x + menu_box_width - 15, top , menu_box_x + menu_box_width - 10, bottom)
  if cached_player_list ~= nil then
    for i = rows_start_stat, rows_end_stat + rows_start_stat - 2.5, 1 do
      if cached_player_list[i] ~= nil then
        if current_active_player == i then
          draw.Color(color2[1],color2[2],color2[3],color2[4])
        else
          draw.Color(color6[1],color6[2],color6[3],color6[4])
        end
        if is_mouse_in_rect(menu_box_x + 220 + 10, (menu_box_y + (15 * (i - rows_start_stat + 1))), (menu_box_x + menu_box_width - 20) - (menu_box_x + 220 + 10), (menu_box_y + (15 * (i - rows_start_stat + 1)) + 15) - (menu_box_y + (15 * (i - rows_start_stat + 1)))) and is_resizing == false and not is_mouse_in_rect(mouse_x_right_click + 5, mouse_y_right_click - 5, (mouse_x_right_click + 214)-(mouse_x_right_click + 5), (mouse_y_right_click + 80)-(mouse_y_right_click - 5)) then
          if input.IsButtonPressed(1) or input.IsButtonPressed(2) then
            set_active_player(i)
            if SHOW_AVATAR_IMAGE:GetValue() then
              get_profile_pic(i)
            end
          end
          draw.Color(color3[1],color3[2],color3[3],color3[4])
        elseif current_active_player ~= i then
          draw.Color(color6[1],color6[2],color6[3],color6[4])
        end
        if current_active_player ~= 0 then
          if not is_mouse_in_rect(menu_box_x + 220 + 10, (menu_box_y + (15 * (current_active_player - rows_start_stat + 1))), (menu_box_x + menu_box_width - 20) - (menu_box_x + 220 + 10), (menu_box_y + (15 * (current_active_player - rows_start_stat + 1)) + 15) - (menu_box_y + (15 * (current_active_player - rows_start_stat + 1)))) and
              not is_mouse_in_rect(menu_box_x + 10, menu_box_y + menu_box_height - 65, (menu_box_x + 210) - (menu_box_x + 10), (menu_box_y + menu_box_height - 10) - (menu_box_y + menu_box_height - 65)) and not is_mouse_in_rect(mouse_x_right_click + 5, mouse_y_right_click - 5, (mouse_x_right_click + 214)-(mouse_x_right_click + 5), (mouse_y_right_click + 80)-(mouse_y_right_click - 5))
          then
            set_active_player(0)
          end    
        end 
        draw.FilledRect(menu_box_x + 220 + 10, menu_box_y + (15 * (i - rows_start_stat + 1)), menu_box_x + menu_box_width - 20, menu_box_y + (15 * (i - rows_start_stat + 1)) + 15)
        if currently_updating == i then
          draw.Color(color7[1],color7[2],color7[3],color7[4])
        elseif HIGHLIGHT_BANNED_RETARDS:GetValue() and (cached_player_list[i]["bans"]["vacBans"] ~= 0 or cached_player_list[i]["bans"]["gameBans"] ~= 0) then
          draw.Color(255,65,65,255)
        else
          draw.Color(color4[1],color4[2],color4[3],color4[4])
        end
        if cached_player_list[i] ~= nil then
          local spacing = 5
          for _, vv in pairs(options_array) do
            if cached_player_list[i][vv[4][1]] ~= "" then
              if vv[3] == 1 then
                local message = nil
                if vv[6] == 1 then
                  message = #cached_player_list[i][vv[4][1]]
                else
                  message = cached_player_list[i][vv[4][1]]
                end
                if message == nil then
                  message = "HIDDEN"
                end
                draw.TextShadow(menu_box_x + 225 + gap + spacing, menu_box_y + (15 * (i - rows_start_stat + 1)), message .. vv[5])
              elseif vv[3] == 2 then
                local message = nil
                if vv[6] == 1 then
                  if cached_player_list[i][vv[4][1]][vv[4][2]] ~= nil then
                    if SHOW_DAYS_SINCE_CREATED:GetValue() == 0 then
                      local daysfrom = math.floor(os.difftime(os.time(), cached_player_list[i][vv[4][1]][vv[4][2]]) / (24 * 60 * 60))
                      message = daysfrom .. " days ago"
                    else
                      message = os.date("%Y-%m-%d %H:%M:%S", cached_player_list[i][vv[4][1]][vv[4][2]])
                    end
                    
                  else
                    message = "HIDDEN"
                  end
                else
                  message = cached_player_list[i][vv[4][1]][vv[4][2]]
                end
                if message == nil then
                  message = "HIDDEN"
                end
                draw.TextShadow(menu_box_x + 225 + gap + spacing, menu_box_y + (15 * (i - rows_start_stat + 1)), message .. vv[5])
              elseif vv[3] == 3 then
                local message = nil
                if vv[6] == 1 then
                  message = math.floor(cached_player_list[i][vv[4][1]][vv[4][2]][vv[4][3]] / 60 / 60)
                else
                  message = cached_player_list[i][vv[4][1]][vv[4][2]][vv[4][3]]
                end
                if message == nil then
                  message = "HIDDEN"
                end
                draw.TextShadow(menu_box_x + 225 + gap + spacing, menu_box_y + (15 * (i - rows_start_stat + 1)), message .. vv[5])
              end
            else
              draw.TextShadow(menu_box_x + 225 + gap + spacing, menu_box_y + (15 * (i - rows_start_stat + 1)), "HIDDEN")
            end
            spacing = spacing + vv[2]
          end
        end
      end
    end
  end
  if show_right_click_menu == true then
    draw.Color(color1[1],color1[2],color1[3],color1[4])
    draw.FilledRect(mouse_x_right_click + 5, mouse_y_right_click - 5, mouse_x_right_click + 214, mouse_y_right_click + 80)  
    if is_mouse_in_rect(mouse_x_right_click + 10, mouse_y_right_click + 0, (mouse_x_right_click + 210)-(mouse_x_right_click + 10), (mouse_y_right_click + 15)-(mouse_y_right_click + 0)) and current_active_player ~= 0 and not updating_in_progress then
      if input.IsButtonPressed(1) then
        update_selected_player(current_active_player)
        show_right_click_menu = false
        mouse_x_right_click, mouse_y_right_click = -500,-500
      end
      draw.Color(color3[1],color3[2],color3[3],color3[4])
    elseif current_active_player ~= 0 and not updating_in_progress then
      draw.Color(color2[1],color2[2],color2[3],color2[4])
    end
    draw.FilledRect(mouse_x_right_click + 10, mouse_y_right_click + 0, mouse_x_right_click + 210, mouse_y_right_click + 15)
    if is_mouse_in_rect(mouse_x_right_click + 10, mouse_y_right_click + 20, (mouse_x_right_click + 210)-(mouse_x_right_click + 10), (mouse_y_right_click + 35)-(mouse_y_right_click + 20)) and current_active_player ~= 0 and not updating_in_progress then
      if input.IsButtonPressed(1) then
        print_to_console(current_active_player)
        show_right_click_menu = false
        mouse_x_right_click, mouse_y_right_click = -500,-500
      end
      draw.Color(color3[1],color3[2],color3[3],color3[4])
    elseif current_active_player ~= 0 and not updating_in_progress then
      draw.Color(color2[1],color2[2],color2[3],color2[4])
    end
    draw.FilledRect(mouse_x_right_click + 10, mouse_y_right_click + 20, mouse_x_right_click + 210, mouse_y_right_click + 35)
    if is_mouse_in_rect(mouse_x_right_click + 10, mouse_y_right_click + 40, (mouse_x_right_click + 210)-(mouse_x_right_click + 10), (mouse_y_right_click + 55)-(mouse_y_right_click + 40)) and current_active_player ~= 0 and not updating_in_progress then
      if input.IsButtonPressed(1) then
        remove_player_from_list(current_active_player)
        show_right_click_menu = false
        mouse_x_right_click, mouse_y_right_click = -500,-500
      end
      draw.Color(color3[1],color3[2],color3[3],color3[4])
    elseif current_active_player ~= 0 and not updating_in_progress then
      draw.Color(color2[1],color2[2],color2[3],color2[4])
    end
    draw.FilledRect(mouse_x_right_click + 10, mouse_y_right_click + 40, mouse_x_right_click + 210, mouse_y_right_click + 55)
    if is_mouse_in_rect(mouse_x_right_click + 10, mouse_y_right_click + 60, (mouse_x_right_click + 210)-(mouse_x_right_click + 10), (mouse_y_right_click + 75)-(mouse_y_right_click + 40)) and current_active_player ~= 0 and not updating_in_progress then
      if input.IsButtonPressed(1) then
        update_all_players(current_active_player)
        show_right_click_menu = false
        mouse_x_right_click, mouse_y_right_click = -500,-500
      end
      draw.Color(color3[1],color3[2],color3[3],color3[4])
    elseif current_active_player ~= 0 and not updating_in_progress then
      draw.Color(color2[1],color2[2],color2[3],color2[4])
    end
    draw.FilledRect(mouse_x_right_click + 10, mouse_y_right_click + 60, mouse_x_right_click + 210, mouse_y_right_click + 75)
    draw.Color(color4[1],color4[2],color4[3],color4[4])
    draw.TextShadow(mouse_x_right_click + 90, mouse_y_right_click + 1, "UPDATE")
    draw.TextShadow(mouse_x_right_click + 75, mouse_y_right_click + 21, "PROFILE LINK")
    draw.TextShadow(mouse_x_right_click + 91, mouse_y_right_click + 41, "REMOVE")
    draw.TextShadow(mouse_x_right_click + 57, mouse_y_right_click + 61, "UPDATE FROM HERE")
  end
  --draw.TextShadow(255,255,#options_array)
  --draw.TextShadow(255,265,#playerinfo_cache)
  --draw.TextShadow(255,275,#playerinfo_cache_match)
  --draw.TextShadow(255,285,#cached_player_list)
  --draw.TextShadow(255,295,#player_list)
end
local function draw_list()
  if player_list ~= nil then
    draw.Color(color4[1],color4[2],color4[3],color4[4])
    draw.TextShadow(menu_box_x + 15, menu_box_y - 15, "Player List" .. "(" .. #player_list .. ")")
    if show_mode == true then
      if currently_updating ~= 0 then
        draw.TextShadow(menu_box_x + 240, menu_box_y - 15, "Player Info Saved" .. "(" .. currently_updating .. "/" .. #cached_player_list .. ") Banned(" .. count_bans .. ")")
      else
        draw.TextShadow(menu_box_x + 240, menu_box_y - 15, "Player Info Saved" .. "(" .. #cached_player_list .. ") Banned(" .. count_bans .. ")")
      end
    else
      draw.TextShadow(menu_box_x + 240, menu_box_y - 15, "Player Info In-Game" .. "(" .. #playerinfo_cache_match .. ")")
    end

    local rows_end = (menu_box_y + menu_box_height - 10 - menu_box_y + (20 / 20)) / 20
    local size_image = 0
    if current_active_player ~= 0 and SHOW_AVATAR_IMAGE:GetValue() == true then
      size_image = 9.5
    end
  
    if is_mouse_in_rect(menu_box_x + 10, menu_box_y - 10, (menu_box_x + 210) - (menu_box_x + 10), (menu_box_y + menu_box_height - 10) - (menu_box_y - 10)) then
      if input.IsButtonPressed(254) then
        rows_start = rows_start - 1
      end
      if input.IsButtonPressed(255) then
        if rows_end + rows_start - (3.3 + size_image) < #player_list then
          rows_start = rows_start + 1
        end
      end
    end
    if rows_start > #player_list then
      rows_start = #player_list + 1
    end
    if rows_start < 1 then
      rows_start = 1
    end
    for i = rows_start, rows_end + rows_start - (3.3 + size_image), 1 do
      i = i - 1
      if player_list[i] ~= nil then
        if client.GetPlayerInfo(player_list[i]) ~= nil then
          if is_mouse_in_rect(menu_box_x + 20, menu_box_y + (20 * (i - rows_start + 1)), (menu_box_x + 200) - (menu_box_x + 20), (menu_box_y + (20 * (i - rows_start + 1)) + 15) - (menu_box_y + (20 * (i - rows_start + 1)))) then
            draw.Color(color3[1],color3[2],color3[3],color3[4])
            if input.IsButtonPressed(1) then
              local add_new = true
              local steamid = client.GetPlayerInfo(player_list[i])
              if (steamid ~= nil and steamid["IsBot"] == false and key_in_table(playerinfo_cache, steamid["SteamID"]) == false) then
                http.Get(
                  string.format(NETWORK_GET_ADDR, urlencode(steamid["SteamID"])),
                  function(response)
                    if (response == nil or response == "error" or key_in_table(playerinfo_cache, steamid["SteamID"]) == true) then
                      return
                    end
                    playerinfo_cache = {}
                    table.insert(playerinfo_cache, 1, steamid)
                    playerinfo_cache = json.decode(response)
                    for _, v in pairs(cached_player_list) do
                      if v["summary"]["steamID"] == playerinfo_cache["summary"]["steamID"] then
                        add_new = false
                      end
                    end
                    if add_new == true then
                      add_player_to_list(playerinfo_cache)
                    end
                  end
                )
              end
            end
          else
            draw.Color(color6[1],color6[2],color6[3],color6[4])
          end
          draw.FilledRect(menu_box_x + 20, menu_box_y + (20 * (i - rows_start + 1)), menu_box_x + 200, menu_box_y + (20 * (i - rows_start + 1)) + 15)
          draw.Color(255, 255, 255, 255)
          if client.GetPlayerInfo(player_list[i])["Name"] == client.GetPlayerInfo(client.GetLocalPlayerIndex())["Name"] then
            draw.Color(48, 252, 3, 255)
          end
          draw.TextShadow(menu_box_x + 24, menu_box_y + (20 * (i - rows_start + 1)) + 1, client.GetPlayerInfo(player_list[i])["Name"])
        end
      end
    end
  end
end
callbacks.Register(
  "Draw",
  function()
    if (gui.GetValue("lua_allow_http") == false or gui.GetValue("lua_allow_cfg") == false) then
      return
    end
    local mouse_x, mouse_y = input.GetMousePos()
    local left_mouse_down = input.IsButtonDown(1)
    local left_mouse_pressed = input.IsButtonPressed(1)
    if (is_dragging == true and left_mouse_down == false) then
      is_dragging = false
      dragging_offset_x = 0
      dragging_offset_y = 0
      return
    end
    if (is_resizing == true and left_mouse_down == false) then
      is_resizing = false
      resizing_offset_x = 0
      resizing_offset_y = 0
      return
    end
    if (is_dragging == true) then
      menu_box_x = mouse_x - dragging_offset_x
      menu_box_y = mouse_y - dragging_offset_y
      return
    end
    if menu_box_y < 0 then 
      menu_box_y = 50
    end
    if menu_box_y < 0 then 
      menu_box_y = 50
    end
    local wndw_x, wndw_y = draw.GetScreenSize()
    if menu_box_y > wndw_y + 20 then 
      menu_box_y = wndw_y + 20
    end
    local max_width = 269
    for _, v in pairs(options_array) do
      max_width = max_width + v[2]
    end
    if menu_box_width < max_width then
      menu_box_width = max_width
    end
    if (is_resizing == true) then
      menu_box_width = mouse_x - resizing_offset_x
      menu_box_height = mouse_y - resizing_offset_y
      if menu_box_width < max_width then
        menu_box_width = max_width
      end
      if menu_box_height < 140 then
        menu_box_height = 140
      end
      if menu_box_height > wndw_y - 50 then
        menu_box_height = wndw_y - 50
      end
      if menu_box_width > wndw_x - 50 then
        menu_box_width = wndw_x - 50
      end
      return
    end
   
    if (left_mouse_pressed and is_mouse_in_rect(menu_box_x, menu_box_y - 50, menu_box_width, 25)) then
      is_dragging = true
      dragging_offset_x = mouse_x - menu_box_x
      dragging_offset_y = mouse_y - menu_box_y
      return
    end
    if (left_mouse_pressed and is_mouse_in_rect(menu_box_x + menu_box_width - 10, menu_box_y + menu_box_height - 10, 17, 17)) then
      is_resizing = true
      resizing_offset_x = mouse_x - menu_box_width
      resizing_offset_y = mouse_y - menu_box_height
      return
    end
  end
)
local get_current_aw_state_on_load = gui.Reference("MENU"):IsActive() --because spamming this command too many times will give shit FPS on a long run
callbacks.Register(
  "Draw",
  function()
    if input.IsButtonPressed(45) then
      if get_current_aw_state_on_load then
        get_current_aw_state_on_load = false
      else
        get_current_aw_state_on_load = true
      end
    end
    if LUA_PLAYER_INFO_CONFIGURATION:GetValue() == true and get_current_aw_state_on_load == true then
      LUA_PLAYER_INFO_WINDOW:SetActive(1)
    else
      LUA_PLAYER_INFO_WINDOW:SetActive(0)
    end
    if gui.GetValue("lua_allow_http") == false then
      draw.Color(255, 0, 0, 255)
      draw.Text(25, 25, "[PIT] Allow internet connections from lua needs to be enabled to use this script")
      return
    end
    if gui.GetValue("lua_allow_cfg") == false then
      draw.Color(255, 0, 0, 255)
      draw.Text(25, 25, "[PIT] Allow script/config editing from lua need to be enabled to use this script")
      return
    end
    if (last_click ~= nil and last_click > globals.RealTime()) then
      last_click = globals.RealTime()
    end
    if LUA_PLAYER_INFO_ENABLE:GetValue() and get_current_aw_state_on_load == true then
      draw_window()
      draw_list()
      if show_mode then
        draw_player_info()
        if SHOW_AVATAR_IMAGE:GetValue() then
          draw_profile_pic()
        end
      else
        draw_player_info_match()
      end
    else
      return
    end
  end
)
callbacks.Register(
  "FireGameEvent",
  function(event)
    if (value_in_table(listen_to_events, event:GetName())) then
      update_players()
    end
  end
)
update_players()
read_player_data()[/s]