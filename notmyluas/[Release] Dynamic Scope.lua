-- Scraped by chicken
-- Author: Giperfast.tk
-- Title [Release] Dynamic Scope
-- Forum link https://aimware.net/forum/thread/144521

local msc_ref = gui.Reference( "Ragebot", "Aimbot", "Automation");
local ref = gui.Reference( "Ragebot", "Aimbot", "Automation", "Auto Scope");
local Enable_checkbox = gui.Checkbox( msc_ref, "msc_lua_checkbox", "Dynamic Scope", true);
local Scar_only = gui.Checkbox( msc_ref, "msc_lua_checkbox", "Scar Only", true);

local function GetTarget(pEntity)
if(pEntity:IsAlive()) then
if(Enable_checkbox:GetValue() == true) then
local localPlayerСoord = entities:GetLocalPlayer():GetAbsOrigin();
local pEntityСoord = pEntity:GetAbsOrigin();
Distance = math.sqrt((pEntityСoord.x-localPlayerСoord.x)*(pEntityСoord.x-localPlayerСoord.x)+(pEntityСoord.y-localPlayerСoord.y)*(pEntityСoord.y-localPlayerСoord.y)+(pEntityСoord.z-localPlayerСoord.z)*(pEntityСoord.z-localPlayerСoord.z));
print(DistanceCalculate(Distance))
if(Scar_only:GetValue() == true and entities:GetLocalPlayer():GetWeaponID() == 11 or entities:GetLocalPlayer():GetWeaponID() == 38) then
if (Distance <= 400) then
print(Distance)
gui.SetValue( 'rbot.aim.automation.scope', 0 )
else
gui.SetValue( 'rbot.aim.automation.scope', 2 )
end
elseif (Scar_only:GetValue() == false) then
if (Distance <= 400) then
gui.SetValue( 'rbot.aim.automation.scope', 0 )
else
gui.SetValue( 'rbot.aim.automation.scope', 2 )
end
else
gui.SetValue( 'rbot.aim.automation.scope', 2 )
end
end
end
end
local function Draw()
  ref:SetInvisible( Enable_checkbox:GetValue() )
end
callbacks.Register("Draw", Draw);
callbacks.Register("AimbotTarget", GetTarget);
