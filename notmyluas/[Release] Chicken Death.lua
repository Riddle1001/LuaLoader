-- Scraped by chicken
-- Author: zack
-- Title [Release] Chicken Death
-- Forum link https://aimware.net/forum/thread/89020


function chickendead(Event)
if Event:GetName() ~= nil then
local uid = Event:GetInt('userid');  
local Killer_int = Event:GetInt('attacker'); 
local Killer_Name = client.GetPlayerNameByUserID(Killer_int); 
local _weapon = Event:GetString('weapon');
local locate = entities.FindByClass('CBasePlayer');
for i = 1, #locate do
local Location = locate[i]:GetPropString('m_szLastPlaceName');
if Location == nil then Location = 'Unknown'; end

chatsay = string.format('%s murdered a chicken with the %s at %s!', Killer_Name, _weapon, Location)
if Event:GetName() == "other_death" then
client.ChatSay(chatsay)
end end end end
client.AllowListener('other_death'); callbacks.Register('FireGameEvent', "chicken die", chickendead);



