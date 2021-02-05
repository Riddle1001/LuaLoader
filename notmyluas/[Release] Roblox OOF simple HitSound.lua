-- Scraped by chicken
-- Author: EURONELSONVALOARE
-- Title [Release] Roblox OOF simple HitSound
-- Forum link https://aimware.net/forum/thread/87494

function Sounds(Event, Entity) 
if ( Event:GetName() == 'player_hurt' ) then 
local local_player = client.GetLocalPlayerIndex(); 
local attacker_uid = Event:GetInt('attacker'); 
local attacker_index = client.GetPlayerIndexByUserID(attacker_uid) 

if ( attacker_index == local_player ) then 
client.Command("playvol oof.wav 1", true); 
end 
end 
end 

client.AllowListener('player_hurt'); 

callbacks.Register('FireGameEvent', 'Hitsound', Sounds);

