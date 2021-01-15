-- Scraped by chicken
-- Author: xaNe
-- Title [Release] EPIC HITSOUND SCRIPT
-- Forum link https://aimware.net/forum/thread/94676


function on_player_death(e)
if (e:GetName() == "player_hurt") then
local ENTITY_LOCAL_PLAYER = client.GetLocalPlayerIndex();

local ID_VICTIM, ID_ATTACKER, HITGROUP = e:GetInt("userid"), e:GetInt("attacker"), e:GetInt("hitgroup");
local INDEX_VICTIM, INDEX_ATTACKER = client.GetPlayerIndexByUserID(ID_VICTIM), client.GetPlayerIndexByUserID(ID_ATTACKER);

if (INDEX_ATTACKER == ENTITY_LOCAL_PLAYER and HITGROUP == 1) then
client.Command("playvol */rust_hs.mp3 1", true);
end
if (INDEX_ATTACKER == ENTITY_LOCAL_PLAYER and HITGROUP ~= 1) then
client.Command("play buttons/arena_switch_press_02.wav", true);
end
end
end

client.AllowListener("player_hurt");
callbacks.Register("FireGameEvent", "HS_SOUND", on_player_death);
