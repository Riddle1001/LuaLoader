-- Scraped by chicken
-- Author: password
-- Title [Release] Client Info 
-- Forum link https://aimware.net/forum/thread/86037


local kills = {}
local deaths = {};

local frametimes = {}
local fps_prev = 0

local function accumulate_fps()
 local ft = globals.AbsoluteFrameTime()
 if ft > 0 then
   table.insert(frametimes, 1, ft)
 end

 local count = #frametimes
 if count == 0 then
   return 0
 end

 local i, accum = 0, 0
 while accum < 0.5 do
   i = i + 1
   accum = accum + frametimes[i]
   if i >= count then
     break
   end
 end
 accum = accum / i
 while i < count do
   i = i + 1
   table.remove(frametimes)
 end
 
 local fps = 1 / accum
 local rt = globals.RealTime()
 if math.abs(fps - fps_prev) > 4 or rt - last_update_time > 2 then
   fps_prev = fps
   last_update_time = rt
 else
   fps = fps_prev
 end
 
 return math.floor(fps + 0.5)
end


local function events_stuff( event )
   if event:GetName( ) == "player_disconnect" then
     kills = {}
     deaths = {}
end

 if event:GetName( ) == "player_death" then
 local local_player = client.GetLocalPlayerIndex( );
 local INDEX_Attacker = client.GetPlayerIndexByUserID( event:GetInt( 'attacker' ) );
 local INDEX_Victim = client.GetPlayerIndexByUserID( event:GetInt( 'userid' ) );

 if INDEX_Attacker == local_player then
  kills[#kills + 1] = {}
 end
 if (INDEX_Victim == local_player) then
   deaths[#deaths + 1] = {};
   end
 end
end

local function drawing_stuff( )
 if not entities.GetLocalPlayer() then
   return 
 end
 if #deaths > 0 then 
   kdratio = string.format("%.2f", math.floor(#kills/#deaths))
 else
   kdratio = string.format("%.2f", #kills/1)
 end

 if accumulate_fps( ) > 60 then
   r,g,b = 0,255,0
else
   r,g,b = 255,0,0
 end
 draw.Color(r,g,b,255)
 draw.Text(5, 360, "FPS: ".. accumulate_fps())
 draw.Color(255,255,255,255)
 draw.Text(5, 380, "Kills: ".. #kills)  
 draw.Text(5, 400, "Deaths: ".. #deaths)   
 draw.Text(5, 420, "K/D: ".. kdratio)   

 
end
client.AllowListener( "round_start" );
client.AllowListener( "player_death" );
client.AllowListener( "player_disconnect" );
callbacks.Register( "FireGameEvent", "events_stuff", events_stuff);
callbacks.Register( "Draw", "drawing_stuff", drawing_stuff );


