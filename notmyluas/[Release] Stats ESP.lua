-- Scraped by chicken
-- Author: Nexxed
-- Title [Release] Stats ESP
-- Forum link https://aimware.net/forum/thread/88477

local references = {
  ["self"] = gui.Reference("VISUALS", "YOURSELF", "Options"),
  ["enemy"] = gui.Reference("VISUALS", "ENEMIES", "Options"),
  ["team"] = gui.Reference("VISUALS", "TEAMMATES", "Options")
};

local controls = {
  ["self"] = gui.Checkbox(references.self, "nex_esp_stats_self", "Stats", false),
  ["enemy"] = gui.Checkbox(references.enemy, "nex_esp_stats_enemy", "Stats", false),
  ["team"] = gui.Checkbox(references.team, "nex_esp_stats_team", "Stats", false)
}

local function DrawStats(Entity, Builder)
  local Kills = entities.GetPlayerResources():GetPropInt("m_iKills", Entity:GetIndex());
  local Deaths = entities.GetPlayerResources():GetPropInt("m_iDeaths", Entity:GetIndex());

  -- this is to prevent X.#INF displaying as ratio
  local rDeaths = Deaths;
  if (Deaths == 0) then rDeaths = 1; end

  local Ratio = math.floor((Kills / rDeaths) * (10^(2 or 0)) + 0.5) / (10^(2 or 0));

  if (Ratio >= 3.00) then Builder:Color(255, 20, 147, 255);
  elseif (Ratio >= 2.00) then Builder:Color(0, 255, 0, 255);
  elseif (Ratio >= 1.00) then Builder:Color(255, 255, 0, 255);
  elseif (Ratio < 1.00) then Builder:Color(255, 0, 0, 255);
  else Builder:Color(255, 255, 255, 255); end

  Builder:AddTextBottom("K: "..Kills.." | D: "..Deaths.." | R: "..Ratio);
end

callbacks.Register("DrawESP", "Nex.StatsESP", function(Builder)
  local LocalPlayer = entities.GetLocalPlayer();
  local Entity = Builder:GetEntity();

  if (Entity:IsPlayer() and Entity:IsAlive()) then
    if (Entity:GetIndex() == LocalPlayer:GetIndex()) then
      if (controls.self:GetValue()) then DrawStats(Entity, Builder); end

    elseif (Entity:GetTeamNumber() == LocalPlayer:GetTeamNumber()) then
      if (controls.team:GetValue()) then DrawStats(Entity, Builder); end

    elseif (Entity:GetTeamNumber() ~= LocalPlayer:GetTeamNumber()) then
      if (controls.enemy:GetValue()) then DrawStats(Entity, Builder); end
    end
  end
end);
