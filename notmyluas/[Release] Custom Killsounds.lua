-- Scraped by chicken
-- Author: blobsarecute
-- Title [Release] Custom Killsounds
-- Forum link https://aimware.net/forum/thread/86034

--killsounds
local killswitch = 0

local function KillSound(event)--used the listener code from anue because im too lazy xd 
local attackerIndex = client.GetPlayerIndexByUserID( event:GetInt( "attacker" ) )
local localPlayer = client.GetLocalPlayerIndex();
if event:GetName() == "player_death" then
if attackerIndex == localPlayer then   


if event:GetInt( "headshot" ) ~= 0 then -- thanks to polak!
client.Command("playvol head_shot.wav 1", true)
else
killswitch = killswitch + 1
if killswitch == 1 then
client.Command("playvol firstblood.wav 1", true)
end
if killswitch == 2 then
client.Command("playvol Double_Kill.wav 1", true)
end
if killswitch == 3 then
client.Command("playvol triple_kill.wav 1", true)
end
if killswitch == 4 then
client.Command("playvol monster_kill.wav 1", true)
end
if killswitch == 5 then
client.Command("playvol Killing_Spree.wav 1", true)
end
if killswitch == 6 then
client.Command("playvol Dominating.wav 1", true)
end
if killswitch == 7 then
client.Command("playvol Ownage.wav 1", true)
end
if killswitch == 8 then
client.Command("playvol Unstoppable.wav 1", true)
end
if killswitch == 9 then
client.Command("playvol GodLike.wav 1", true)
end
if killswitch == 10 then
client.Command("playvol HolyShit.wav 1", true)
end
if killswitch == 11 then
client.Command("playvol WhickedSick.wav 1", true)
end
if killswitch == 12 then
client.Command("playvol MegaKill.wav 1", true)
killswitch = 0
end
end

--splitted(blobsarecute) was here
   

local attackerIndex = nil
local localPlayer = nil

end
end
end

function DrawingHook()
-- will be used later!
end

client.AllowListener( "player_death" );
callbacks.Register( "FireGameEvent", "KillSound", KillSound);
callbacks.Register( "Draw", "DrawingHook", DrawingHook );