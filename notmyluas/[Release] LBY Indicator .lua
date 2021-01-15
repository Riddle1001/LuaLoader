-- Scraped by chicken
-- Author: ImoriNel
-- Title [Release] LBY Indicator 
-- Forum link https://aimware.net/forum/thread/86168

local pitch, yaw, roll;
local w, h;
function angles_util( UCMD )

  pitch, yaw, roll = UCMD:GetViewAngles();
end
callbacks.Register( 'CreateMove', 'angles_util', angles_util );

function draw_lby()
  draw.GetScreenSize()(w, h);

  local local_player = entities.GetLocalPlayer();
  local lowerbody = local_player:GetProp('m_flLowerBodyYawTarget');
  if (math.abs(yaw - lowerbody) >= 35 ) then
    r,g,b = 125,176,17
 else
    r,g,b = 241,33,13
 end
 
  draw.Color( r, g, b, 255 )
  draw.Text( 10, h - 78, "LBY" )
end

callbacks.Register('Draw', 'draw_lby', draw_lby)