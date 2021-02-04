-- Scraped by chicken
-- Author: Morturem
-- Title [Release] Nade Throwsay
-- Forum link https://aimware.net/forum/thread/131384

function on_nade(Event)
if (Event:GetName() ~= 'grenade_thrown') then return; end
if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
 if Event:GetString('weapon') == "hegrenade" then
     client.ChatSay( 'Catch retard!' );
     return;
   end    end  end
client.AllowListener('grenade_thrown');
callbacks.Register("FireGameEvent", "nadesay", on_nade);

----------------------------------------------------------------
function fl_nade(Event)

if (Event:GetName() ~= 'grenade_thrown') then return; end
if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
 if Event:GetString('weapon') == "flashbang" then
     client.ChatSay( 'Look a bird!' );
     return;
   end    end  end
client.AllowListener('grenade_thrown');
callbacks.Register("FireGameEvent", "nadesay", fl_nade);
--------------------------------------------------------------
function mol_nade(Event)

if (Event:GetName() ~= 'grenade_thrown') then return; end
if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
 if Event:GetString('weapon') == "molotov" then
     client.ChatSay( 'BURN BABY BURN!!!' );
     return;
   end    end  end
client.AllowListener('grenade_thrown');
callbacks.Register("FireGameEvent", "nadesay", mol_nade);
---------------------------------------------------------------
function sm_nade(Event)

if (Event:GetName() ~= 'grenade_thrown') then return; end
if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
 if Event:GetString('weapon') == "smokegrenade" then
     client.ChatSay( 'I am a ninja' );
     return;
   end    end  end
client.AllowListener('grenade_thrown');
callbacks.Register("FireGameEvent", "nadesay", sm_nade);
----------------------------------
function inc_nade(Event)

if (Event:GetName() ~= 'grenade_thrown') then return; end
if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
 if Event:GetString('weapon') == "incgrenade" then
     client.ChatSay( 'BURN BABY BURN!!!' );
     return;
   end    end  end
client.AllowListener('grenade_thrown');
callbacks.Register("FireGameEvent", "nadesay", inc_nade);