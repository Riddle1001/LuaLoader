-- Scraped by chicken
-- Author: demonicpbunny
-- Title [Release] Location Spammer
-- Forum link https://aimware.net/forum/thread/88472


local last_spam = globals.TickCount()
function LocationSpam() 


local Random_Index = math.random(1, math.floor(globals.MaxClients()))
local Entity = entities.GetByIndex( Random_Index )

local Wep = entities.FindByClass( "CBaseCombatWeapon" ) 

local WepBase = Wep[Random_Index]

if Entity ~= nil and WepBase ~= nil then
if Entity:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and Entity:IsPlayer() and Entity:IsAlive() and WepBase:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() then


local WepName = WepBase:GetClass()
local Health = Entity:GetHealth()
local Name = Entity:GetName()
local Location = Entity:GetPropString('m_szLastPlaceName');


if globals.TickCount() - last_spam > 64 and Location ~= nil then
client.ChatSay(Name.." | "..Location.." | HP: "..Health.." | Gun: "..string.gsub(WepName, "CWeapon", ""))
last_spam = globals.TickCount()
    end
   end 
 end
end
callbacks.Register( "Draw", "Spam Player Location", LocationSpam );


