-- Scraped by chicken
-- Author: DemTimbs
-- Title [Release] Disable FOV Changer While Scoped
-- Forum link https://aimware.net/forum/thread/87995

function sectime()
 local Player = entities.GetLocalPlayer();
 if Player:GetProp("m_bIsScoped") == 1 then
  gui.SetValue( "vis_view_fov", 0);
  else
   gui.SetValue( "vis_view_fov", 107);
 end
end
callbacks.Register( "Draw", "sectime", sectime );
