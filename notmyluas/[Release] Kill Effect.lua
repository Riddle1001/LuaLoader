-- Scraped by chicken
-- Author: 2878713023
-- Title [Release] Kill Effect
-- Forum link https://aimware.net/forum/thread/151100

--byqihttps://aimware.net/forum/user/366789

localkill_effect=gui.Checkbox(gui.Reference("visuals","world","extra"),"killeffect","Killeffect",1)
localclr=gui.ColorPicker(kill_effect,"clr","clr",234,142,255,255)
localtime=1.5

localalpha=0
localglobals_frametime=globals.FrameTime
localtexture=
draw.CreateTexture(
common.RasterizeSVG(
[[<svgxmlns="http://www.w3.org/2000/svg"version="1.1">
<defs>
<radialGradientid="grad1"cx="50%"cy="50%"r="50%"fx="50%"fy="50%">
<stopoffset="0%"style="stop-color:rgb(255,255,255);
stop-opacity:0"/>
<stopoffset="100%"style="stop-color:rgb(255,255,255);stop-opacity:1"/>
</radialGradient>
</defs>
<ellipsecx="200"cy="70"rx="85"ry="55"fill="url(#grad1)"/>
</svg>]]
)
)

localfunctionon_fire_fame_event(event)
locallp=entities.GetLocalPlayer()
locallp_index=client.GetLocalPlayerIndex()
localattacker=client.GetPlayerIndexByUserID(event:GetInt("attacker"))
localuserid=client.GetPlayerIndexByUserID(event:GetInt("userid"))

ifkill_effect:GetValue()andevent:GetName()andlpandlp:IsAlive()andevent:GetName()=="player_death"anduserid~=lp_indexthen
ifattacker==lp_indexthen
alpha=255*time
end
end
end

localfunctionon_draw()
localr,g,b=clr:GetValue()
localx,y=draw.GetScreenSize()

alpha=alpha>1andalpha-1or0

draw.SetTexture(texture)
draw.Color(r,g,b,alpha/time)
draw.FilledRect(-300,-300,x+300,y+300)
end

callbacks.Register("Draw",on_draw)
client.AllowListener("player_death")
callbacks.Register("FireGameEvent",on_fire_fame_event)


