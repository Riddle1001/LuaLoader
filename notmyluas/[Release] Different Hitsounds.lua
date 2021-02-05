-- Scraped by chicken
-- Author: Chipss
-- Title [Release] Different Hitsounds
-- Forum link https://aimware.net/forum/thread/85992

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
    client.Command("playvol hitmarker.mp3 3", true);
    end

  end

end

client.AllowListener( 'player_hurt' );

callbacks.Register( 'FireGameEvent', 'Hitsound', Sounds );



