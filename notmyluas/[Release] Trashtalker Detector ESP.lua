-- Scraped by chicken
-- Author: password
-- Title [Release] Trashtalker Detector ESP
-- Forum link https://aimware.net/forum/thread/86670


--list where we store all the stuff
local trash_talker = {};

function draw_esp( builder )
  -- get entity's name from the drawesp reference
  local entity = builder:GetEntity();
 
  --gets entity's name
  local entityname = client.GetPlayerNameByIndex( entity:GetIndex( ) );
  
 --if entity's team is localplayer's team then it returns
  if (entity:GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber()) then
    return;
  end
  
  --if the entity is in the trash_talker list then draws at the bottom a text "*trashtalker*"
  if (entity:IsAlive() and entity:IsPlayer() and trash_talker[1] == entityname ) then 
  builder:AddTextBottom( "*trashtalker*" );
  end
end


function events_detection( Event )
  if ( Event:GetName() == 'client_disconnect' ) then
    --if the player disconnects then we reset the list trash_talker
  trash_talker = {};
  end
  
  if ( Event:GetName() == 'player_say' ) then
    --gets player's userid
 local player = client.GetPlayerNameByUserID( Event:GetString("userid") ); 
 
 --gets players's text
    local message = Event:GetString("text"); 
 
 --checks if the trashtalker is the localplayer or the trashtalker is already in the list, if so return
 if (player == client.GetPlayerNameByIndex(entities.GetLocalPlayer():GetIndex()) or trash_talker[1] == player) then 
  return;
 end
 
 if (string.find(message, "1") or
 string.find(message, "nn") or
 string.find(message, "owned") ) then
  trash_talker = {player};
 end
  end
end

--Allow listeners
client.AllowListener( 'player_say' );
client.AllowListener( 'client_disconnect' );

--Register things
callbacks.Register( 'DrawESP', 'draw_esp', draw_esp );
callbacks.Register( 'FireGameEvent', 'events_detection', events_detection );

