-- Scraped by chicken
-- Author: xaimg0d
-- Title [Release] Roundsay
-- Forum link https://aimware.net/forum/thread/86138

local roundsays = {
  [1] = "fill, you can add more",

}

function CHAT_roundsay( Event )
if ( Event:GetName() == 'round_start' ) then
local response = tostring(roundsays[math.random(#roundsays)]);
        client.ChatSay( ' ' .. response );

 end
end
client.AllowListener( "round_start" );
callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_roundsay );