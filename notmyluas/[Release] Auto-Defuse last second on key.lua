-- Scraped by chicken
-- Author: velololxd
-- Title [Release] Auto-Defuse last second on key
-- Forum link https://aimware.net/forum/thread/86618


local key = 'r'

-- api shit
local gui_set = gui.SetValue
local gui_get = gui.GetValue
local entity_find_by_class = entities.FindByClass;
local entity_get_local_player = entities.GetLocalPlayer
local client_get_local_player_index = client.GetLocalPlayerIndex
local curtime = globals.CurTime

-- vars
local planted_time = 0
local bomb_time = 0
local bomb_time_remaining = 0
local last_command = ""

local function on_bomb_planted(Event)
 if Event:GetName() ~= "bomb_planted" then
  return
 end
 planted_time = curtime()
 bomb_time = 0
 bomb_time_remaining = 0
 last_command = ""
end

local function has_defuser(local_player)
 if local_player:GetProp("m_bHasDefuser") == 1 then
  return true
 else
  return false
 end
end

local function can_defuse(local_player)
 if local_player:GetTeamNumber() ~= 3 then
  return false
 end

 local bomb = entity_find_by_class("CPlantedC4")

 if bomb == nil or bomb[1] == nil then
  return false
 end

 bomb_time = bomb[1]:GetProp("m_flTimerLength")

 if bomb_time == nil or bomb_time <= 0 then
  return false
 end

 bomb_time_remaining = (planted_time - curtime()) + bomb_time

 if bomb_time_remaining <= 0 then
  return false
 end

 return true
end

-- on draw check if key is being pressed, if so check bomb timer and defuse at the last second
local function on_draw()
 local local_player = entity_get_local_player()

 if local_player == nil or not local_player:IsAlive() then
  return
 end

 if not can_defuse(local_player) then
  if last_command ~= "-use" then
   client.Command("-use", true)
   last_command = "-use"
  end
  return
 end

 if input.IsButtonDown(key) then
  if has_defuser(local_player) and bomb_time_remaining > 5.3 then
   return
  end

  if not has_defuser(local_player) and bomb_time_remaining > 10.3 then
   return
  end

  if last_command ~= "+use" then
   client.Command("+use", true)
   last_command = "+use"
  end
 end
end

client.AllowListener("bomb_planted")
callbacks.Register("FireGameEvent", "on_bomb_planted", on_bomb_planted);
callbacks.Register("Draw", "on_draw", on_draw) 

