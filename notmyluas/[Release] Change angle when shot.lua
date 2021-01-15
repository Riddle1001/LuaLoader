-- Scraped by chicken
-- Author: waynegan24
-- Title [Release] Change angle when shot
-- Forum link https://aimware.net/forum/thread/93779

local setvalue = gui.SetValue;
local getvalue = gui.GetValue;

function randomwhenshot()
local local_player = entities.GetLocalPlayer();

if local_player and local_player:IsAlive() and local_player:GetHealth() >100 then
setvalue("rbot_antiaim_stand_real_add", (0))

elseif local_player and local_player:IsAlive() and local_player:GetHealth() >90 then
setvalue("rbot_antiaim_stand_real_add", (0))

elseif local_player and local_player:IsAlive() and local_player:GetHealth() >80 then
setvalue("rbot_antiaim_stand_real_add", (-120))

elseif local_player and local_player:IsAlive() and local_player:GetHealth() >70 then
setvalue("rbot_antiaim_stand_real_add", (120))

elseif local_player and local_player:IsAlive() and local_player:GetHealth() >60 then
setvalue("rbot_antiaim_stand_real_add", (-30))

elseif local_player and local_player:IsAlive() and local_player:GetHealth() >50 then
setvalue("rbot_antiaim_stand_real_add", (60))

elseif local_player and local_player:IsAlive() and local_player:GetHealth() >40 then
setvalue("rbot_antiaim_stand_real_add", (-55))

elseif local_player and local_player:IsAlive() and local_player:GetHealth() >30 then
setvalue("rbot_antiaim_stand_real_add", (134))

elseif local_player and local_player:IsAlive() and local_player:GetHealth() >20 then
setvalue("rbot_antiaim_stand_real_add", (-23))

elseif local_player and local_player:IsAlive() and local_player:GetHealth() >10 then
setvalue("rbot_antiaim_stand_real_add", (30))

elseif local_player and local_player:IsAlive() and local_player:GetHealth() >0 then
setvalue("rbot_antiaim_stand_real_add", (-160))
end
end

callbacks.Register("Draw", "randomwhenshot", randomwhenshot);
