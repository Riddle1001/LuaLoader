-- Scraped by chicken
-- Author: password
-- Title [Release] Player ESP Infos
-- Forum link https://aimware.net/forum/thread/88411


function handle_checks( entity )
  local checks = "";
 
 local velocity_x = entity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
 local velocity_y = entity:GetPropFloat( "localdata", "m_vecVelocity[1]" );
  local velocity = math.sqrt( velocity_x^2 + velocity_y^2 );
 
 if ( velocity < 0.1 ) then
   checks = "Standing";
 else if ( velocity > 0.1 and entity:GetProp( "m_fFlags" ) ~= 774) then
   checks = "Running";
 else if ( entity:GetProp( "m_fFlags" ) == 774 ) then
   checks = "In Air";
     end
   end
 end
 return checks;
end

function handle_esp( cx )
  local entity = cx:GetEntity( );
 if (entity:GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber()) then
   return;
 end
  if ( entity:IsPlayer( ) and entity:IsAlive( ) ) then
    cx:AddTextBottom( handle_checks( entity ) );
 end
end

callbacks.Register("DrawESP", "handle_esp", handle_esp);
