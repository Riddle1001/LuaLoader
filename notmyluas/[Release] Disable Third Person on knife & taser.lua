-- Scraped by chicken
-- Author: stacky
-- Title [Release] Disable Third Person on knife & taser
-- Forum link https://aimware.net/forum/thread/98164

local gui_set = gui.SetValue;
local gui_get = gui.GetValue;
local previous3p = gui.GetValue('vis_thirdperson_dist');

function DisableThirdPerson(Event)

  if (Event:GetName() ~= 'item_equip') then
    return;
  end
  
  local local_player, userid, item, weptype = client.GetLocalPlayerIndex(), Event:GetInt('userid'), Event:GetString('item'), Event:GetInt('weptype');
	
	if (local_player == client.GetPlayerIndexByUserID(userid)) then
    if (item == "taser" ) then
			gui_set( "vis_thirdperson_dist", 0 )
    elseif (item=="knife")then
			gui_set( "vis_thirdperson_dist", 0 )
    else 
			gui_set( "vis_thirdperson_dist", previous3p )
    end
   
end
end

client.AllowListener('item_equip');
callbacks.Register("FireGameEvent", "on_knife", DisableThirdPerson);