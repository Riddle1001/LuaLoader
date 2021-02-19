-- Scraped by chicken
-- Author: mshkreli
-- Title [Release] Distance ESP
-- Forum link https://aimware.net/forum/thread/104890

gui.Text(gui.Reference("VISUALS", "ENEMIES", "Options"), "Distance ESP");
gui.Text(gui.Reference("VISUALS", "TEAMMATES", "Options"), "Distance ESP");
local ENABLE_DISTANCEESP_FRIENDLIES = gui.Checkbox(gui.Reference("VISUALS", "TEAMMATES", "Options"), "ENABLE_DISTANCEESP_FRIENDLIES", "Draw distance", false);
local ENABLE_DISTANCEESP_ENEMIES = gui.Checkbox(gui.Reference("VISUALS", "ENEMIES", "Options"), "ENABLE_DISTANCEESP_ENEMIES", "Draw distance", false);
local DISTANCEESP_UNIT = gui.Combobox(gui.Reference("VISUALS", "SHARED"), "DISTANCEESP_UNIT", "Distance ESP Length Unit", "meters", "feet", "units");

local function SourceToLengthUnit(base)
 if DISTANCEESP_UNIT:GetValue() == 0 then -- meters
 return math.floor(base / 52.459) .. "m";
 elseif DISTANCEESP_UNIT:GetValue() == 1 then -- feet
 return math.floor(base / 12) .. "ft"; 
 elseif DISTANCEESP_UNIT:GetValue() == 2 then -- source engine units
 return math.floor(base) .. "u";
 end
end

local function DistanceESP(ESPBuilder)
 local lPlayer = entities.GetLocalPlayer();
 local entity = ESPBuilder:GetEntity();
 if not entity:IsPlayer() then return end;

 if entity:GetTeamNumber() == lPlayer:GetTeamNumber() and ENABLE_DISTANCEESP_FRIENDLIES:GetValue() then
 local mx, my, mz = lPlayer:GetAbsOrigin();
 local x, y, z = entity:GetAbsOrigin();
 ESPBuilder:AddTextBottom(SourceToLengthUnit(math.sqrt((mx - x)^2 + (my - y)^2 + (mz - z)^2)));
 end
 
 if entity:GetTeamNumber() ~= lPlayer:GetTeamNumber() and ENABLE_DISTANCEESP_ENEMIES:GetValue() then
 local mx, my, mz = lPlayer:GetAbsOrigin();
 local x, y, z = entity:GetAbsOrigin();
 ESPBuilder:AddTextBottom(SourceToLengthUnit(math.sqrt((mx - x)^2 + (my - y)^2 + (mz - z)^2)));
 end
end

callbacks.Register("DrawESP", DistanceESP);