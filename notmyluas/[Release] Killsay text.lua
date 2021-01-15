-- Scraped by chicken
-- Author: Madnn
-- Title [Release] Killsay text
-- Forum link https://aimware.net/forum/thread/130451

local killsays = {
  [1] = "1 sniff",
  [2] = "1 nn",
  [3] = "n1",
  [4] = "rip",
  [5] = "Fat nn",
  [6] = "sit dog",

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