-- Scraped by chicken
-- Author: password
-- Title [Release] Default Crosshair Snipers
-- Forum link https://aimware.net/forum/thread/88372


--and player:GetProp( "m_bIsScoped" ) == 0
local is_sniper = false;

function manage_event( Event )
  if ( Event:GetName( ) ~= 'item_equip' ) then return; end
  local item = Event:GetString( "item" );
  if ( item ~= nil and item == "g3sg1" or
  item == "scar20" or
  item == "awp" or
  item == "ssg08" ) then
    is_sniper = true;
  else
    is_sniper = false;
  end
end

function default_crosshair( )
  local player = entities.GetLocalPlayer( );
 
  if ( player ~= nil and player:IsAlive( ) and player:GetProp( "m_bIsScoped" ) == 0 and is_sniper ) then
    client.SetConVar( "weapon_debug_spread_show", 3, true );
  else
    client.SetConVar( "weapon_debug_spread_show", 0, true );
  end
end

client.AllowListener('item_equip');
callbacks.Register( 'FireGameEvent', 'manage_events', manage_event );
callbacks.Register( "Draw", "default_crosshair", default_crosshair );
