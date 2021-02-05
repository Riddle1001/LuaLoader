-- Scraped by chicken
-- Author: MarcinTPLV2
-- Title [Release] Killsay form public EZfrags
-- Forum link https://aimware.net/forum/thread/86101

local killsays = {
  [1] = "Visit www.EZfrags.co.uk for the finest public & private CS:GO cheats",
  [2] = "Stop being a noob! Get good with www.EZfrags.co.uk",
  [3] = "I'm not using www.EZfrags.co.uk, you're just bad",
  [4] = "You just got pwned by EZfrags, the #1 CS:GO cheat",
  [5] = "If I was cheating, I'd use www.EZfrags.co.uk",
  [6] = "Think you could do better? Not without www.EZfrags.co.uk",

}

function CHAT_KillSay( Event )
  
  if ( Event:GetName() == 'player_death' ) then
    
    local ME = client.GetLocalPlayerIndex();
    
    local INT_UID = Event:GetInt( 'userid' );
    local INT_ATTACKER = Event:GetInt( 'attacker' );
    
    local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
    local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
    
    local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
    local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
    
    if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
    
        local response = tostring(killsays[math.random(#killsays)]);
        response = response:gsub("_name_", NAME_Victim);
        client.ChatSay( ' ' .. response );
    
    end
  
  end
  
end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );
