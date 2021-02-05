-- Scraped by chicken
-- Author: zack
-- Title [Release] Hit Say
-- Forum link https://aimware.net/forum/thread/87567


function HitGroup( INT_HITGROUP )
if INT_HITGROUP == nil then return;
elseif INT_HITGROUP == 0 then return "body";
elseif INT_HITGROUP == 1 then return "head";
elseif INT_HITGROUP == 2 then return "chest";
elseif INT_HITGROUP == 3 then return "stomach";
elseif INT_HITGROUP == 4 then return "left arm";
elseif INT_HITGROUP == 5 then return "right arm";
elseif INT_HITGROUP == 6 then return "left leg";
elseif INT_HITGROUP == 7 then return "right leg";
elseif INT_HITGROUP == 10 then return "body";
end end

function ChatLogger( Event, Entity )
if ( Event:GetName() == nil ) then return;
elseif ( Event:GetName() == 'player_hurt' ) then
local ME = client.GetLocalPlayerIndex();
local INT_UID = Event:GetInt( 'userid' );
local INT_ATTACKER = Event:GetInt( 'attacker' );
local INT_DMG = Event:GetString( 'dmg_health' );
local INT_HEALTH = Event:GetString( 'health' );
local INT_HITGROUP = Event:GetInt( 'hitgroup' );
local INT_WEAPON = Event:GetString('weapon');

local INDEX_ATTACKER = client.GetPlayerIndexByUserID( INT_ATTACKER );
local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
local INDEX_VICTIM = client.GetPlayerIndexByUserID( INT_UID );
local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );

hitPlayerName = "";   hitPlayerName = NAME_Victim;
hitDmg = "";          hitDmg = INT_DMG;
hitSpot = "";         hitSpot = INT_HITGROUP;
hitHealthRemaining = "";    hitHealthRemaining = INT_HEALTH;
hitByWeapon = "";     hitByWeapon = INT_WEAPON;

response = string.format( "[AIMWARE] Hit %s in the %s for %s damage (%s health remaining)\n", hitPlayerName, HitGroup(hitSpot), hitDmg, hitHealthRemaining);
if ( INDEX_ATTACKER == ME and INDEX_Victim ~= ME ) then
        client.ChatSay(response );
				print(response);
end end end
client.AllowListener( 'player_hurt' );
callbacks.Register( 'FireGameEvent', 'ChatLogger', ChatLogger );

