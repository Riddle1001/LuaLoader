-- Scraped by chicken
-- Author: password
-- Title [Release] Low Health Alert 
-- Forum link https://aimware.net/forum/thread/88373


local last_spam = globals.TickCount( );

function draw_low_health( )
 local x, h = draw.GetScreenSize();
 
  local player = entities.GetLocalPlayer( );
 if (player ~= nil and player:IsAlive( ) ) then
   local player_health = player:GetHealth( );
 if ( player_health <= 25 ) then
   if globals.TickCount( ) - last_spam > 39 then
   draw.Color( 255, 0, 0, 88 );
     draw.RoundedRectFill( 0, 0, x, h );
   last_spam = globals.TickCount( )
 end
 end
 end
end

callbacks.Register( "Draw", "draw_low_health", draw_low_health );


