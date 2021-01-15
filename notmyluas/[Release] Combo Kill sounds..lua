-- Scraped by chicken
-- Author: CorruptEvil_
-- Title [Release] Combo Kill sounds.
-- Forum link https://aimware.net/forum/thread/94845

local kills = 0;
--local MISC_MAIN_REF = gui.Reference( "MISC", "Part 3" );
--local KillSounds = gui.Checkbox( MISC_MAIN_REF, "lua_KillSounds", "Combo kill sounds", 0 ); will add menu support later if people care, maybe a fancy message too.

function KillEvent( Event )
if ( Event:GetName() == 'player_death' ) then
   print(KillSounds)
   local ME = client.GetLocalPlayerIndex();
   local INT_UID = Event:GetInt( 'userid' );
   local INT_ATTACKER = Event:GetInt( 'attacker' );
   local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
   local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
   local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
   local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
	 
   if ( INDEX_Attacker ~= ME and INDEX_Victim == ME ) then
		kills = 0;
	 end
   if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
		kills = kills + 1;
		
		
	 if kills == 2 then
		client.Command("playvol */double_kill 1", true); 
			
	 end
	 if kills == 4 then
		client.Command("playvol */multikill 1", true);
			
	 end
	 if kills == 6 then
		client.Command("playvol */godlike 1", true);
	 end	
	 if kills == 8 then
		client.Command("playvol */monsterkill_f 1", true);
	 end	
	 if kills == 10 then
		client.Command("playvol */unstoppable 1", true);
	 end	
	 if kills == 12 then
		client.Command("playvol */whickedsick 1", true);
	 end
			
	 end
		
	end
 
end
client.AllowListener( 'player_death' );
callbacks.Register( 'FireGameEvent', 'KILLS', KillEvent );