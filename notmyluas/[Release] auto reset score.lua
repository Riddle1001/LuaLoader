-- Scraped by chicken
-- Author: hlop
-- Title [Release] auto reset score
-- Forum link https://aimware.net/forum/thread/89110


function rs( Event ) 
	if ( Event:GetName() == 'player_death' ) then 	
		local ME = client.GetLocalPlayerIndex();
		local INT_UID = Event:GetInt( 'userid' );
    local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
		
		if (INDEX_Victim == ME) then
			client.Command( "rs", true) 
		end		
	end 
end 

client.AllowListener( 'player_death' ); 
callbacks.Register( 'FireGameEvent', 'rs', rs );