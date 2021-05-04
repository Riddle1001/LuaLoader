-- Scraped by chicken
-- Author: 2878713023
-- Title [Release] Valorant Kill GIF
-- Forum link https://aimware.net/forum/thread/150897

--makevalorantkillgifforaw
--byqi/https://aimware.net/forum/user/366789

localmath_min=math.min
localmath_max=math.max
localmath_modf=math.modf
localmath_floor=math.floor
localdraw_CreateTexture,draw_GetScreenSize,draw_SetTexture,draw_FilledRect=
draw.CreateTexture,
draw.GetScreenSize,
draw.SetTexture,
draw.FilledRect
localglobals_CurTime=globals.CurTime
localcommon_DecodePNG=common.DecodePNG
localfile_Open,file_Write,file_Enumerate=file.Open,file.Write,file.Enumerate
localclient_GetLocalPlayerIndex,client_GetPlayerIndexByUserID=client.GetLocalPlayerIndex,client.GetPlayerIndexByUserID

localevent_kill
localcounter=0
localnext_frame=0
localgif={}

localfunctionfile_inspect(name)
localfile_exists
file_Enumerate(
function(file)
iffile==namethen
file_exists=true
end
end
)
returnfile_exists
end

fori=0,49do
iffile_inspect("picture/valorant/"..i..".png")then
localpng_open=file_Open("picture/valorant/"..i..".png","r")
localpng_data=png_open:Read()
png_open:Close()
localtexture=draw_CreateTexture(common_DecodePNG(png_data))
gif[#gif+1]=texture
else
http.Get(
--ch"https://aimware28.coding.net/p/coding-code-guide/d/aimware/git/raw/master/picture/valorant/"..i..".png?download=false",
"https://raw.githubusercontent.com/287871/aimware/renderer/picture/valorant/"..i..".png",
function(body)
file_Write("picture/valorant/"..i..".png",body)
end
)
end
end

if#gif~=50then
error("DownloadingPNGimage,waitforamomentandthenreload")
end

localfunctionon_fire_fame_event(event)
locallp=entities.GetLocalPlayer()
locallp_index=client_GetLocalPlayerIndex()
localattacker=client_GetPlayerIndexByUserID(event:GetInt("attacker"))
localuserid=client_GetPlayerIndexByUserID(event:GetInt("userid"))

ifevent:GetName()andlpandlp:IsAlive()andevent:GetName()=="player_death"anduserid~=lp_indexthen
ifattacker==lp_indexthen
event_kill=true
end
end
end

localfunctionon_draw()
localscreen_size={draw_GetScreenSize()}

ifevent_killthen
localtime=math_floor(globals_CurTime()*1000)

ifnext_frame-time>30then
next_frame=0
end

ifnext_frame-time<1then
counter=counter+1

next_frame=time+30
end

localgif_texture=gif[(counter%#gif+1)]

localw,h=350,175
localx,y=screen_size[1]*0.5-w*0.5,screen_size[2]*0.7

draw_SetTexture(gif_texture)
draw_FilledRect(x,y,x+w,y+h)
end
ifcounter%#gif+1==50then
event_kill=nil
end
end

callbacks.Register("Draw",on_draw)
client.AllowListener("player_death")
callbacks.Register("FireGameEvent",on_fire_fame_event)


