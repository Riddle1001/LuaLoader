-- Scraped by chicken
-- Author: password
-- Title [Release] LBY Indicator
-- Forum link https://aimware.net/forum/thread/86151


function draw_lby()
  local local_player = entities.GetLocalPlayer();
  local lowerbody = local_player:GetProp('m_flLowerBodyYawTarget');
 if (lowerbody >= 27) then
    r,g,b = 0,255,0
 else
    r,g,b = 255,0,0
 end

  draw.Color( r, g, b, 255 )
  draw.Text( 5, 753, "LBY" )
end

callbacks.Register('Draw', 'draw_lby', draw_lby)


