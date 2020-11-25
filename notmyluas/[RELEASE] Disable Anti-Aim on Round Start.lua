-- Scraped by chicken
-- Author: arpac
-- Title [RELEASE] Disable Anti-Aim on Round Start
-- Forum link https://aimware.net/forum/thread/142785

function FireGameEvent ( Event )
    local player = entities.GetLocalPlayer()
    if ( Event:GetName() == 'round_prestart' ) then
        gui.SetValue( "rbot.antiaim.enable", 0 )
    elseif ( Event:GetName() == 'round_freeze_end' or Event:GetName() == 'game_newmap' ) then
        gui.SetValue( "rbot.antiaim.enable", 1 )
    end
end

client.AllowListener( 'round_prestart' );
client.AllowListener( 'round_freeze_end' );
client.AllowListener( 'game_newmap' );
callbacks.Register( 'FireGameEvent', 'FireGameEvent', FireGameEvent );

