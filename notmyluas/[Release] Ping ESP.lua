-- Scraped by chicken
-- Author: Nexxed
-- Title [Release] Ping ESP
-- Forum link https://aimware.net/forum/thread/88386

local references = {
    ["self"] = gui.Reference("VISUALS", "YOURSELF", "Options"),
    ["enemy"] = gui.Reference("VISUALS", "ENEMIES", "Options"),
    ["team"] = gui.Reference("VISUALS", "TEAMMATES", "Options")
};

local controls = {
    ["self"] = gui.Checkbox(references.self, "nex_esp_ping_self", "Latency", false),
    ["enemy"] = gui.Checkbox(references.enemy, "nex_esp_ping_enemy", "Latency", false),
    ["team"] = gui.Checkbox(references.team, "nex_esp_ping_team", "Latency", false)
}

local function DrawLatency(Entity, Builder)
    local function GetLatencyColor(latency)
        local color = {};
    
        if (latency <= 50) then
            color = {0, 255, 0, 255}; -- green
        elseif (latency <= 100) then
            color = {50, 255, 0, 255};
        elseif (latency <= 200) then
            color = {100, 255, 0, 255};
        elseif (latency <= 300) then
            color = {150, 255, 0, 255};
        elseif (latency <= 400) then
            color = {200, 255, 0, 255};
        elseif (latency <= 500) then
            color = {255, 255, 0, 255}; -- orange
        elseif (latency <= 600) then
            color = {255, 200, 0, 255}; 
        elseif (latency <= 700) then
            color = {255, 150, 0, 255};
        elseif (latency <= 800) then
            color = {255, 100, 0, 255};
        elseif (latency <= 900) then
            color = {255, 50, 0, 255};
        else
            color = {255, 0, 0, 255}; -- red
        end
    
        return color;
    end

    local latency = entities.GetPlayerResources():GetPropInt("m_iPing", Entity:GetIndex());
    local color = GetLatencyColor(latency, 1);
    Builder:Color(color[1], color[2], color[3], 255);
    Builder:AddTextBottom(latency.."MS");
    Builder:Color(255, 255, 255, 255);
end

callbacks.Register("DrawESP", "Nex.PingESP", function(Builder)
    local LocalPlayer = entities.GetLocalPlayer();
    local Entity = Builder:GetEntity();

    if (Entity:IsPlayer() and Entity:IsAlive()) then
        if (Entity:GetIndex() == LocalPlayer:GetIndex()) then
            if (controls.self:GetValue()) then DrawLatency(Entity, Builder); end

        elseif (Entity:GetTeamNumber() == LocalPlayer:GetTeamNumber()) then
            if (controls.team:GetValue()) then DrawLatency(Entity, Builder); end

        elseif (Entity:GetTeamNumber() ~= LocalPlayer:GetTeamNumber()) then
            if (controls.enemy:GetValue()) then DrawLatency(Entity, Builder); end
        end
    end
end);
