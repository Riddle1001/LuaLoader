-- Scraped by chicken
-- Author: merda
-- Title [Release] Crosshair Hitmarker
-- Forum link https://aimware.net/forum/thread/135715

--crosshairhitmarker
--byrex

localHITMARKER_GBOX=gui.Groupbox(gui.Reference("Visuals","Local"),"Hitmarker",330,220,295,0);
localHITMARKER_MASTERSWITCH=gui.Checkbox(HITMARKER_GBOX,"hitmarker.masterswitch","Enable",1);
localHITMARKER_COLOR=gui.ColorPicker(HITMARKER_GBOX,"hitmarker.color","Color",255,255,255,255);
localHITMARKER_FADE_VEL=gui.Slider(HITMARKER_GBOX,"hitmarker.fade","Fadevelocity",5,1,10)
localhurt=0
localrt9999=0
localalpha=255

localfunctionplayer_hurt(Event)

if(Event:GetName()=='player_hurt')then

locallocalplayer=client.GetLocalPlayerIndex();

localuserid=Event:GetInt('userid');
localattacker=Event:GetInt('attacker');

localvictim_name=client.GetPlayerNameByUserID(userid);
localvinctim_index=client.GetPlayerIndexByUserID(userid);

localattacker_name=client.GetPlayerNameByUserID(attacker);
localattacker_index=client.GetPlayerIndexByUserID(attacker);



if(attacker_index==localplayerandvinctim_index~=attacker_index)then
rt9999=globals.RealTime()
hurt=1
alpha=255
end
end
end



localfunctionhitmarker()
ifgui.GetValue("esp.local.hitmarker.masterswitch")==trueandhurt==1then
localr,g,b=gui.GetValue("esp.local.hitmarker.color")
draw.Color(r,g,b,alpha);
localss1,ss2=draw.GetScreenSize();
ss1,ss2=ss1/2,ss2/2;
draw.Line(ss1-10,ss2-10,ss1-5,ss2-5)
draw.Line(ss1-10,ss2+10,ss1-5,ss2+5)
draw.Line(ss1+10,ss2-10,ss1+5,ss2-5)
draw.Line(ss1+10,ss2+10,ss1+5,ss2+5)
end
ifglobals.RealTime()>rt9999+0.5then
ifalpha<10then
hurt=0
else
alpha=alpha-gui.GetValue("esp.local.hitmarker.fade")
end
end
end

client.AllowListener('player_hurt');

callbacks.Register('FireGameEvent','AWKS',player_hurt);
callbacks.Register('Draw','hitmarker',hitmarker);
