-- Scraped by chicken
-- Author: bucofanPASSARINHO
-- Title [Release] hitsound
-- Forum link https://aimware.net/forum/thread/86569

local hurt_time = 0
local alpha = 0;

--Change linesize here:
local linesize = 5

function Sounds( Event, Entity )

if ( Event:GetName() == 'player_hurt' ) then

  local ME = client.GetLocalPlayerIndex();

  local INT_UID = Event:GetInt( 'userid' );
  local INT_ATTACKER = Event:GetInt( 'attacker' );

  local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
  local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

  local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
  local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

  if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
   hurt_time = globals.RealTime()
   client.Command("play buttons\\hitsound.wav", true); 
  end

end

end