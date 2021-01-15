-- Scraped by chicken
-- Author: MriSuckAtLife
-- Title [Release] Hit event log
-- Forum link https://aimware.net/forum/thread/86507


hitPlayerName = "";
hitDmg = "";
hitSpot = "";
hitHealthRemaining = "";

local hurt_time = 0;
local alpha = 0;

function HitGroup( INT_HITGROUP )
if INT_HITGROUP == 0 then
return "body";
elseif INT_HITGROUP == 1 then
return "head";
elseif INT_HITGROUP == 2 then
return "chest";
elseif INT_HITGROUP == 3 then
return "stomach";
elseif INT_HITGROUP == 4 then
return "left arm";
elseif INT_HITGROUP == 5 then
return "right arm";
elseif INT_HITGROUP == 6 then
return "left leg";
elseif INT_HITGROUP == 7 then
return "right leg";
elseif INT_HITGROUP == 10 then
return "body";
end
end

function EventLogger( Event, Entity )
if ( Event:GetName() == 'player_hurt' ) then
local ME = client.GetLocalPlayerIndex();

local INT_UID = Event:GetInt( 'userid' );
local INT_ATTACKER = Event:GetInt( 'attacker' );
local INT_DMG = Event:GetString( 'dmg_health' );
local INT_HEALTH = Event:GetString( 'health' );
local INT_HITGROUP = Event:GetInt( 'hitgroup' );

local INDEX_ATTACKER = client.GetPlayerIndexByUserID( INT_ATTACKER );
local INDEX_VICTIM = client.GetPlayerIndexByUserID( INT_UID );
local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );

if ( INDEX_ATTACKER == ME and INDEX_Victim ~= ME ) then
hitPlayerName = NAME_Victim;
hitDmg = INT_DMG;
hitSpot = INT_HITGROUP;
hitHealthRemaining = INT_HEALTH;

hurt_time = globals.RealTime();
end
end
end

function DrawLogs()
local screenCenterX, screenCenterY = draw.GetScreenSize();

local step = 255 / 4.0 * globals.FrameTime()

if hurt_time + 5.0 > globals.RealTime() then
alpha = 255
else
alpha = alpha - step
end

for i = 0, 10 do
if ( hurt_time + 5.0 > globals.RealTime() ) then
draw.Color(255, 255, 255, alpha);
if ( alpha > 0 ) then
stringz = string.format( "Hit %s in the %s for %s damage (%s health remaining)\n", hitPlayerName, HitGroup(hitSpot), hitDmg, hitHealthRemaining);
draw.Text( 5, 5 + i * 10, stringz );
end
end
end
end

client.AllowListener( 'player_hurt' );
callbacks.Register( 'Draw', 'DrawLogs', DrawLogs );
callbacks.Register( 'FireGameEvent', 'EventsLogger', EventLogger );