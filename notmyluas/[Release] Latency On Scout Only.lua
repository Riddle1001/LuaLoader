-- Scraped by chicken
-- Author: BigTrap
-- Title [Release] Latency On Scout Only
-- Forum link https://aimware.net/forum/thread/86648


local gui_set = gui.SetValue;
local gui_get = gui.GetValue;


function LatencyScout(Event)
   if (Event:GetName() ~= 'item_equip') then
    return;
   end

  if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
    if Event:GetString('item') == "ssg08" then
 gui_set( "msc_fakelatency_enable", true )
    else
    gui_set( "msc_fakelatency_enable", false )
    end
  end
end

client.AllowListener('item_equip');
callbacks.Register("FireGameEvent", "on_ssg08", LatencyScout);

