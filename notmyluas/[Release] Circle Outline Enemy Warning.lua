-- Scraped by chicken
-- Author: 2878713023
-- Title [Release] Circle Outline Enemy Warning
-- Forum link https://aimware.net/forum/thread/150149

--makingenemycirclewarningforaw
--byqihttps://aimware.net/forum/user/366789

--ui
localreference=gui.Reference("visuals","local","helper")
localui_circle_esp_rgb=gui.Checkbox(reference,"circle_esp.rgb","CircleOutlineRgb",0)
localui_circle_esp_clr=gui.ColorPicker(reference,"circle_esp.clr","CircleEspClr",255,56,56,64)
localui_circle_esp_interval=gui.Slider(reference,"circle_esp.interval","Interval",5,0,30)
localui_circle_esp_percentage=gui.Slider(reference,"circle_esp.percentage","percentage",0.2,0,0.5,0.01)

--require
localfunctionrequire(filename,url)
localfilename=filename..".lua"

localfunctionhttp_write(body)
file.Write(filename,body)
end

localmodule=RunScript(filename)orhttp.Get(url,http_write)

returnmoduleorerror("unabletoloadmodule"..filename,2)
end

localrenderer=require("libraries/renderer","https://raw.githubusercontent.com/287871/aimware/renderer/renderer.lua")

--clamp
localfunctionclamp(val,min,max)
ifval>maxthen
returnmax
elseifval<minthen
returnmin
else
returnval
end
end

--colorrgb
localfunctionhsv_to_rgb(h,s,v,a)
localr,g,b

locali=math.floor(h*6)
localf=h*6-i
localp=v*(1-s)
localq=v*(1-f*s)
localt=v*(1-(1-f)*s)

i=i%6

ifi==0then
r,g,b=v,t,p
elseifi==1then
r,g,b=q,v,p
elseifi==2then
r,g,b=p,v,t
elseifi==3then
r,g,b=p,q,v
elseifi==4then
r,g,b=t,p,v
elseifi==5then
r,g,b=v,p,q
end

returnr*255,g*255,b*255,a*255
end

--localglobalvar
localalpha={}
localplayers={activity={}}

--espinformation
localfunctionesp_info(builder)
locallp=entities.GetLocalPlayer()

localbuilder_ent=builder:GetEntity()

ifbuilder_ent:IsPlayer()andbuilder_ent:GetTeamNumber()~=lp:GetTeamNumber()then
ifbuilder_ent:IsAlive()then
players[builder_ent:GetIndex()]=true
players.activity[builder_ent:GetIndex()]=true
else
players[builder_ent:GetIndex()]=nil
end
end
end

--drawcircle
localfunctionesp_draw_circle()
locallp=entities.GetLocalPlayer()

ifnotlpthen
return
end

localfade=((1.0/0.15)*globals.FrameTime())*80
localr,g,b,a=ui_circle_esp_clr:GetValue()

ifui_circle_esp_rgb:GetValue()then
r,g,b=hsv_to_rgb(globals.RealTime()*0.1,1,1,0.5)
end

localscreen_size={draw.GetScreenSize()}
localscreen_size_x=screen_size[1]*0.5
localscreen_size_y=screen_size[2]*0.5

localout_of_view_scale=gui.GetValue("esp.local.outofviewscale")
localinterval=ui_circle_esp_interval:GetValue()+30
localpercentage=ui_circle_esp_percentage:GetValue()

localtemp={}
locallp_abs=lp:GetAbsOrigin()
localview_angles=engine.GetViewAngles()

localCCSPlayer=entities.FindByClass("CCSPlayer")
fork,vinpairs(CCSPlayer)do
localindex=v:GetIndex()

localv_abs=v:GetAbsOrigin()
localdist=vector.Distance({v_abs.x,v_abs.y,v_abs.z},{lp_abs.x,lp_abs.y,lp_abs.z})

alpha[index]=alpha[index]or0
ifplayers.activity[index]then
alpha[index]=players[index]andlp:IsAlive()andclamp(alpha[index]+fade,0,a)orclamp(alpha[index]-fade,0,a)
else
alpha[index]=
v:IsPlayer()andv:GetTeamNumber()~=lp:GetTeamNumber()andv:IsAlive()andlp:IsAlive()anddist<=1500and
clamp(alpha[index]+fade,0,a)or
clamp(alpha[index]-fade,0,a)
end

ifalpha[index]~=0then
table.insert(temp,CCSPlayer[k])
end
players[index]=nil
players.activity[index]=nil
end

fork,vinpairs(temp)do
localindex=v:GetIndex()
localv_abs=v:GetAbsOrigin()
angle=(v_abs-lp_abs):Angles()
angle.y=angle.y-view_angles.y
fori=1,2,0.2do
localalpha=i/5*alpha[index]

renderer.circle_outline(
screen_size_x,
screen_size_y,
r,
g,
b,
alpha,
(50+out_of_view_scale+(interval*k))+i,
(270-percentage*170)-angle.y+(i*0.2),
percentage+(i*0.00005),
25+(i*2)
)
end
end
end

--callbacks
callbacks.Register("DrawESP",esp_info)
callbacks.Register("Draw",esp_draw_circle)
--end


