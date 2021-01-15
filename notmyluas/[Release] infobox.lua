-- Scraped by chicken
-- Author: _Bannany_
-- Title [Release] infobox
-- Forum link https://aimware.net/forum/thread/88418

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

function Velocity()

  local w, h = draw.GetScreenSize();
  
  if entities.GetLocalPlayer() ~= nil then
  
    local Entity = entities.GetLocalPlayer();

    local velocityX = Entity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
    local velocityY = Entity:GetPropFloat( "localdata", "m_vecVelocity[1]" );
  
    local velocity = math.sqrt( velocityX^2 + velocityY^2 );
    local FinalVelocity  = math.min( 9999, velocity ) + 0.2;

    draw.Color( 255, 255, 255, 255 );
    draw.Text( 1850, h - 500, "Vel: " .. math.floor(FinalVelocity) );

  end

end

callbacks.Register( "Draw", "Velocity", Velocity )

local function drawing_stuff( ) 
if not entities.GetLocalPlayer() then 
return 
end 


if accumulate_fps( ) > 60 then 
r,g,b = 0,255,0 
else 
r,g,b = 255,0,0 
end 


 draw.Color(5,5,5,255)
  draw.RoundedRectFill( 1600, 8, 1900, 40 )
 draw.Color(60,60,60,255)
  draw.FilledRect( 1601, 9, 1899, 39 )
 draw.Color(40,40,40,255)
  draw.FilledRect( 1602, 10, 1898, 38 )
 draw.Color(60,60,60,255)
  draw.FilledRect( 1604, 12, 1896, 36 )
 draw.Color(17,17,17,255)
  draw.FilledRect( 1605, 13, 1895, 35 )
 draw.Color(gui.GetValue("clr_gui_window_header_tab2"))
  draw.Line( 1606, 14, 1894, 14 )
  draw.Color(255, 255, 255, 255)
  draw.Text(1620, 20, "OO")  
  draw.Color(gui.GetValue("clr_gui_window_header_tab2"))
  draw.Text(1655, 20, "KURVA")  
  draw.Color(255, 255, 255, 255)
  draw.Text(1710, 20, " | ")  
  draw.Color(r,g,b,255)
  draw.Text(1728, 20, accumulate_fps())
  draw.Text(1748, 20, "fps")
  draw.Color(255, 255, 255, 255)
  draw.Text(1765, 20, " | ")
  draw.Color(255, 100, 0, 255)
  draw.Text(1780, 20, #kills) 
  draw.Text(1793, 20, "Kills")
  draw.Color(255, 255, 255, 255)
  draw.Text(1820, 20, " | ")  
  draw.Color(255, 0, 0,255)
  draw.Text(1835, 20, #deaths)
  draw.Text(1850, 20, "deaths")

end 
client.AllowListener( "round_start" ); 
client.AllowListener( "player_death" ); 
client.AllowListener( "player_disconnect" ); 
callbacks.Register( "FireGameEvent", "events_stuff", events_stuff); 
callbacks.Register( "Draw", "drawing_stuff", drawing_stuff );