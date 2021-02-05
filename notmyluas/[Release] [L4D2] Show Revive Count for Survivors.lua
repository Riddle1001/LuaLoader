-- Scraped by chicken
-- Author: bluntsmoker1995
-- Title [Release] [L4D2] Show Revive Count for Survivors
-- Forum link https://aimware.net/forum/thread/96542

local vis_options_ref = gui.Reference('VISUALS','Options');
local vis_thirdstrike_bool = gui.Checkbox(vis_options_ref,'lua_thirdstrike','Show Revivecount',0);

function draw_revivecount(esp)
if vis_thirdstrike_bool:GetValue() then
local entity = esp:GetEntity();
if entity and entity:IsPlayer() and entity:GetTeamNumber() == 2 then 
local revivecount = entity:GetPropInt('m_currentReviveCount');
local revcount_percentage = revivecount / 3; 
if revivecount == 0 then
esp:Color(0,255,0,255);
esp:AddBarTop(revcount_percentage);
elseif revivecount == 1 then
esp:Color(255,255,0,255);
esp:AddBarTop(revcount_percentage);
elseif revivecount == 2 then
esp:Color(255,0,0,255);
esp:AddBarTop(revcount_percentage);
end
end
end
end 

callbacks.Register('DrawESP','draw_revivecount',draw_revivecount);
