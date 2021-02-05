-- Scraped by chicken
-- Author: password
-- Title [Release] Self-Player filter off when scoped
-- Forum link https://aimware.net/forum/thread/88603



function shit_scope( )
  local player = entities.GetLocalPlayer();
  if (player ~= nil and player:GetProp("m_bIsScoped") == 1) then
    gui.SetValue("esp_filter_self", false);
  else
    gui.SetValue("esp_filter_self", true);
  end
 
end
callbacks.Register( "Draw", "shit_scope", shit_scope);


