-- Scraped by chicken
-- Author: ambien55
-- Title [Release] Money Revealer
-- Forum link https://aimware.net/forum/thread/104120

local ct_color = {162, 190, 212, 255}
local tt_color = {226, 202, 134, 255}

local enemies = {}

local function get_current_round_number()
 -- I was unable to do this properly (using DT_CSGameRulesProxy->m_totalRoundsPlayed) and honestly I don't think it's possible at the moment
 local team1 = entities.FindByClass("CTeam")[3]
 local team2 = entities.FindByClass("CTeam")[4]

 if (team1 == nil or team2 == nil) then
  return nil
 end

 local team1_score = team1:GetPropInt("m_scoreTotal")
 local team2_score = team2:GetPropInt("m_scoreTotal")

 return (team1_score + team2_score + 1)
end

local function refresh()
 enemies = {}
 for i = globals.MaxClients(), 1, -1 do
  local forced_index = math.floor(i)
  local name = client.GetPlayerNameByIndex(forced_index)

  if (name ~= nil and forced_index ~= client.GetLocalPlayerIndex()) then
   local info = client.GetPlayerInfo(forced_index)
   if (not info["IsGOTV"]) then
    local team = entities.GetPlayerResources():GetPropInt("m_iTeam", forced_index)
    if (entities.GetLocalPlayer():GetTeamNumber() ~= team and (team == 2 or team == 3)) then
     table.insert(enemies, {["userid"] = info["UserID"], ["index"] = forced_index, ["score"] = 0, ["money"] = 0})
    end
   end
  end
 end
 
 if (next(enemies) ~= nil and enemies ~= nil) then
  for index, player in pairs(enemies) do
   local cash_earned = 800 + entities.GetPlayerResources():GetPropInt("m_iMatchStats_CashEarned_Total", player.index)
   local cash_spent = entities.GetPlayerResources():GetPropInt("m_iTotalCashSpent", player.index)
   local total = cash_earned - cash_spent
   if (total > 16000) then
    total = 16000
   elseif (total < 0) then
    total = 0
   end

   local entity = entities.GetByIndex(player.index)
   if (entity == nil) then
    enemies[index]["money"] = total
   elseif (entity ~= nil) then
    enemies[index]["money"] = entity:GetProp("m_iAccount")
   end

   if (get_current_round_number() ~= nil) then
    if (get_current_round_number() >= 15) then
     enemies[index]["money"] = "???"
     if (entity ~= nil) then
      enemies[index]["money"] = entity:GetProp("m_iAccount")
     end
    end
   end

   local score = entities.GetPlayerResources():GetPropInt("m_iScore", player.index)
   enemies[index]["score"] = score
  end

  table.sort(enemies, function(a, b)
   if (b.score ~= 0 or a.score ~= 0) then
    return a.score > b.score
   end
   return a.userid < b.userid
  end)
 end
end

client.AllowListener("client_disconnect")
client.AllowListener("round_announce_match_start")
callbacks.Register("FireGameEvent", function(event)
 if (event:GetName() == "client_disconnect" or event:GetName() == "round_announce_match_start") then
  enemies = {}
 end
end)

callbacks.Register("Draw", function()
 if (engine.GetServerIP() == nil) then return end
 if (engine.GetServerIP() == "loopback") then return end

 local local_player = entities.GetLocalPlayer()
 if (local_player == nil) then return end

 if (client.GetConVar("game_type") ~= "0" or client.GetConVar("game_mode") ~= "1") then return end

 local local_team = local_player:GetTeamNumber()
 if (local_team ~= 2 and local_team ~= 3) then return end

 if (not input.IsButtonDown(9)) then return end

 local w, h = draw.GetScreenSize()
 local font_size = 20
 if (w <= 1366) then
  font_size = 16
 end

 draw.SetFont(draw.CreateFont("Stratum2-Regular", font_size))

 refresh()
 if (next(enemies) == nil and enemies == nil) then return end

 local count = 0
 for _ in pairs(enemies) do count = count + 1 end
 if (count ~= 5) then return end

 local y
 if (local_team == 2) then -- ct
  y = h*0.364
 elseif (local_team == 3) then -- tt
  y = h*0.577
 end

 for i = 1, #enemies do
  if (local_team == 2) then -- ct
   draw.Color(ct_color[1], ct_color[2], ct_color[3], ct_color[4])
  elseif (local_team == 3) then -- tt
   draw.Color(tt_color[1], tt_color[2], tt_color[3], tt_color[4])
  end

  draw.Text(w*0.596, y, "$" .. enemies[i]["money"])

  y = y + h*0.02453
 end
end)



