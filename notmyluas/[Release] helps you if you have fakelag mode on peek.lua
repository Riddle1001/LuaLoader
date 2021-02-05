-- Scraped by chicken
-- Author: password
-- Title [Release] helps you if you have fakelag mode on peek
-- Forum link https://aimware.net/forum/thread/86528


function fakelagthings()
 local local_player = entities.GetLocalPlayer();
 local flags = local_player:GetProp("m_fFlags");
 if (flags == 256) then
   gui.SetValue( "msc_fakelag_mode", 0 );
else 
 gui.SetValue( "msc_fakelag_mode", 4 );
 end
end

callbacks.Register( "Draw", "fakelagthings", fakelagthings);

