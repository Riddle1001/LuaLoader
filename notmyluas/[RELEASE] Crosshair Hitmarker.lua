-- Scraped by chicken
-- Author: merda
-- Title [RELEASE] Crosshair Hitmarker
-- Forum link https://aimware.net/forum/thread/135715

--crosshair hitmarker
--by rex

local HITMARKER_GBOX = gui.Groupbox(gui.Reference("Visuals","Local"), "Hitmarker", 330, 220, 295 , 0);
local HITMARKER_MASTERSWITCH = gui.Checkbox(HITMARKER_GBOX, "hitmarker.masterswitch", "Enable", 1);
local HITMARKER_COLOR = gui.ColorPicker(HITMARKER_GBOX, "hitmarker.color", "Color", 255, 255, 255, 255);
local HITMARKER_FADE_VEL = gui.Slider(HITMARKER_GBOX, "hitmarker.fade", "Fade velocity", 5, 1, 10)
local hurt = 0
local rt9999 = 0
local alpha = 255

local function player_hurt( Event )

   if ( Event:GetName() == 'player_hurt' )then

       local localplayer = client.GetLocalPlayerIndex();

       local userid = Event:GetInt( 'userid' );
       local attacker = Event:GetInt( 'attacker' );

       local victim_name = client.GetPlayerNameByUserID( userid );
       local vinctim_index = client.GetPlayerIndexByUserID( userid );

       local attacker_name = client.GetPlayerNameByUserID( attacker );
       local attacker_index = client.GetPlayerIndexByUserID( attacker );



        if (attacker_index == localplayer and vinctim_index ~= attacker_index) then
            rt9999 = globals.RealTime()
            hurt = 1
            alpha = 255
        end
    end
end



local function hitmarker()
    if  gui.GetValue("esp.local.hitmarker.masterswitch") == true and hurt == 1 then
        local r,g,b = gui.GetValue("esp.local.hitmarker.color")
        draw.Color(r,g,b,alpha);
        local ss1, ss2 = draw.GetScreenSize();
        ss1, ss2 = ss1/2, ss2/2;
        draw.Line(ss1-10, ss2-10, ss1-5, ss2-5)
        draw.Line(ss1-10, ss2+10, ss1-5, ss2+5)
        draw.Line(ss1+10, ss2-10, ss1+5, ss2-5)
        draw.Line(ss1+10, ss2+10, ss1+5, ss2+5)
    end
    if globals.RealTime() > rt9999 + 0.5 then
        if alpha < 10 then
            hurt = 0
        else 
            alpha = alpha - gui.GetValue("esp.local.hitmarker.fade")
        end
    end
end

client.AllowListener( 'player_hurt' );

callbacks.Register( 'FireGameEvent', 'AWKS', player_hurt );
callbacks.Register( 'Draw', 'hitmarker', hitmarker );