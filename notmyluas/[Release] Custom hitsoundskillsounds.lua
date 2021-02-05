-- Scraped by chicken
-- Author: _^^
-- Title [Release] Custom hitsoundskillsounds
-- Forum link https://aimware.net/forum/thread/135777

local curHitSound = nil;		 --Unused
local curKillSound = nil;		--Unused

local msc_ref = gui.Reference( "VISUALS", "WORLD", "EXTRA" );
local msc_enable_hitsound = gui.Checkbox( msc_ref, "msc_enable_hitsound", "Enable HitSound", false );
local msc_hitsound = gui.Editbox(msc_ref,curHitSound,"Hitsound dirrectory");
local msc_enable_killsound = gui.Checkbox( msc_ref, "msc_enable_killsound", "Enable KillSound", false );
local msc_killsound = gui.Editbox(msc_ref,curHitSound,"Killsound dirrectory");


local localplayer, localplayerindex, listen, GetPlayerIndexByUserID, g_curtime = entities.GetLocalPlayer, client.GetLocalPlayerIndex, client.AllowListener, client.GetPlayerIndexByUserID, globals.CurTime
listen('player_hurt')
listen('player_death')

local function healthshot_hitmarker(e)
 local event_name = e:GetName()
 if (event_name ~= 'player_hurt' and event_name ~= 'player_death') then return end

 local hit = GetPlayerIndexByUserID(e:GetInt("hitgroup"))
 local me = localplayerindex()
 local victim = GetPlayerIndexByUserID(e:GetInt('userid'))
 local attacker = GetPlayerIndexByUserID(e:GetInt('attacker'))
 local im_attacker = attacker == me and victim ~= me
 
 if im_attacker then

 	if (event_name == 'player_death') then
		if(msc_enable_killsound:GetValue()) then
  		local killsoundcmd = "play " .. msc_killsound:GetValue();
    	client.Command(killsoundcmd, true);
		end
 	end
 
 	if (event_name == 'player_hurt') then
		if(msc_enable_hitsound:GetValue()) then
  		local hitsoundcmd = "play " .. msc_hitsound:GetValue();
   	 client.Command(hitsoundcmd, true);
		end
 	 end

	end
end
callbacks.Register('FireGameEvent', healthshot_hitmarker)
callbacks.Register('Draw',function()
	if(msc_enable_hitsound:GetValue() or msc_enable_killsound:GetValue()) then
		gui.SetValue("esp.world.hiteffects.sound", "Off");
	end
end)

