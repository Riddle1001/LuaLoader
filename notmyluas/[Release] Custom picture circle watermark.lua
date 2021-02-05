-- Scraped by chicken
-- Author: 2878713023
-- Title  [Release] Custom picture circle watermark
-- Forum link https://aimware.net/forum/thread/147831

--Workingonaimware
--byqi

--gui
localX,Y=draw.GetScreenSize();
localAvatars_Circle_Reference=gui.Reference("Visuals","Local","Camera");
localAvatars_Circle_Checkbox=gui.Checkbox(Avatars_Circle_Reference,"avatarscircle.enable","AvatarsEnable",0);
localAvatars_Circle_X=gui.Slider(Avatars_Circle_Checkbox,"avatarscircle.x","X",400,0,X);--Youcansavethedragposition
localAvatars_Circle_Y=gui.Slider(Avatars_Circle_Checkbox,"avatarscircle.y","Y",70,0,Y);
Avatars_Circle_X:SetInvisible(true);
Avatars_Circle_Y:SetInvisible(true);

--varandDecodeJPEG
localtX,tY,offsetX,offsetY,_drag
localfont=draw.CreateFont('Verdana',13.5,11.5);
localfont2=draw.CreateFont('Verdana',12,11.5);

localavatarsdata=file.Open("picture/1.jpg","r")
localavatars=avatarsdata:Read()
avatarsdata:Close()
localRGBA,width,height=common.DecodeJPEG(avatars);
localtexture=draw.CreateTexture(RGBA,width,height);

--function

--Mousedrag
localfunctionis_inside(a,b,x,y,w,h)
return
a>=xanda<=wandb>=yandb<=h
end

localfunctiondrag_menu(x,y,w,h)
ifnotgui.Reference("MENU"):IsActive()then
returntX,tY
end

localmouse_down=input.IsButtonDown(1)

ifmouse_downthen
localX,Y=input.GetMousePos()

ifnot_dragthen
localw,h=x+w,y+h
ifis_inside(X,Y,x,y,w,h)then
offsetX,offsetY=X-x,Y-y
_drag=true
end
else
tX,tY=X-offsetX,Y-offsetY
Avatars_Circle_X:SetValue(tX)
Avatars_Circle_Y:SetValue(tY)
end
else
_drag=false
end
returntX,tY
end

--Gradientshadow
localfunctiongradientH(x1,y1,x2,y2,col1,left)
localw=x2-x1
localh=y2-y1

fori=0,wdo
locala=(i/w)*col1[4]
localr,g,b=col1[1],col1[2],col1[3];
draw.Color(r,g,b,a)
ifleftthen
draw.FilledRect(x1+i,y1,x1+i+1,y1+h)
else
draw.FilledRect(x1+w-i,y1,x1+w-i+1,y1+h)
end
end
end

--alpha
localfunctionalpha_stop(val,min,max)
ifval<minthenreturnminend
ifval>maxthenreturnmaxend
returnval;
end

--Circular
localfunctionCircular(x,y,radius,position,thickness)

ifthickness>radiusthen
thickness=radius
end

forsteps=0.1,position,1do

localsin_cur=math.sin(math.rad(steps))
localsin_old=math.sin(math.rad(steps-1))
localcos_cur=math.cos(math.rad(steps))
localcos_old=math.cos(math.rad(steps-1))

localcur_point=nil;
localold_point=nil;

localcur_point={x+sin_cur*radius,y+cos_cur*radius};
localold_point={x+sin_old*radius,y+cos_old*radius};

localcur_point2=nil;
localold_point2=nil;

localcur_point2={x+sin_cur*(radius-thickness),y+cos_cur*(radius-thickness)};
localold_point2={x+sin_old*(radius-thickness),y+cos_old*(radius-thickness)};

draw.Triangle(cur_point[1],cur_point[2],old_point[1],old_point[2],old_point2[1],old_point2[2])
draw.Triangle(cur_point2[1],cur_point2[2],old_point2[1],old_point2[2],cur_point[1],cur_point[2])

end

end

--Ondraw

--Letdragpositionsave
localfunctionPositionSave()
iftX~=Avatars_Circle_X:GetValue()ortY~=Avatars_Circle_Y:GetValue()then
tX,tY=Avatars_Circle_X:GetValue(),Avatars_Circle_Y:GetValue()
end
end

--Informationbar
localfunctionInformation()

localx,y=drag_menu(tX,tY,100,100)
localx,y=x+50,y+50
locallp=entities.GetLocalPlayer();
iflp~=nilandAvatars_Circle_Checkbox:GetValue()then
--Health
localr,g,b,a=34,34,34,255
gradientH(x-130,y,x,y-23,{r,g,b,a*0.6},true);
gradientH(x-125,y,x,y-23,{r,g,b,a*0.8},true);
gradientH(x-120,y,x,y-23,{r,g,b,a},true);
gradientH(x-115,y,x,y-23,{r,g,b,a},true);
gradientH(x-112,y,x,y-23,{r,g,b,a},true);
gradientH(x-110,y,x,y-23,{r,g,b,a},true);
gradientH(x-108,y,x,y-23,{r,g,b,a},true);
gradientH(x-106,y,x,y-23,{r,g,b,a},true);
--Money
localr,g,b,a=40,40,40,255
gradientH(x,y,x+170,y+20,{r,g,b,a*0.6},false);
gradientH(x,y,x+165,y+20,{r,g,b,a*0.8},false);
gradientH(x,y,x+165,y+20,{r,g,b,a},false);
gradientH(x,y,x+160,y+20,{r,g,b,a},false);
gradientH(x,y,x+155,y+20,{r,g,b,a},false);
gradientH(x,y,x+152,y+20,{r,g,b,a},false);
gradientH(x,y,x+150,y+20,{r,g,b,a},false);
gradientH(x,y,x+148,y+20,{r,g,b,a},false);
gradientH(x,y,x+146,y+20,{r,g,b,a},false);
--Misc
localr,g,b,a=34,34,34,255
gradientH(x+42,y-10,x+220,y-35,{r,g,b,a*0.8},false);
gradientH(x+42,y-10,x+215,y-35,{r,g,b,a*0.6},false);
gradientH(x+42,y-10,x+210,y-35,{r,g,b,a},false);
gradientH(x+42,y-10,x+208,y-35,{r,g,b,a},false);
gradientH(x+42,y-10,x+206,y-35,{r,g,b,a},false);
gradientH(x+42,y-10,x+204,y-35,{r,g,b,a},false);
gradientH(x+42,y-10,x+202,y-35,{r,g,b,a},false);

end

end

--HealthTransitionanimation
localfunctionanimation()

locallp=entities.GetLocalPlayer();
localx,y=drag_menu(tX,tY,100,100)
localx,y=x+50,y+50
localfade_factor=((1.0/0.15)*globals.FrameTime())*65
iflp~=nilandAvatars_Circle_Checkbox:GetValue()then
localhealth=lp:GetHealth()
ifhealthA==nilthen
healthA={alpha=360};
end
ifhealth*3.6~=360then--alphaanimation
healthA.alpha=alpha_stop(healthA.alpha-fade_factor,health*3.6,360)
else
healthA.alpha=alpha_stop(healthA.alpha+fade_factor,0,health*3.6)
end

ifhealth>75then--Multiplebloodcolors
draw.Color(134,200,134,200)
elseifhealth>60then
draw.Color(171,151,106,200)
elseifhealth>40then
draw.Color(190,90,90,200)
elseifhealth>20then
draw.Color(200,0,60,200)
elseifhealth>=0then
draw.Color(255,0,0,200)
end
Circular(x,y,57,healthA.alpha,1)

ifhealth>75then--MultiplebloodcolorsForsmoothedges
draw.Color(134,200,134,150)
elseifhealth>60then
draw.Color(171,151,106,150)
elseifhealth>40then
draw.Color(190,90,90,150)
elseifhealth>20then
draw.Color(200,0,60,150)
elseifhealth>=0then
draw.Color(255,0,0,150)
end
Circular(x,y,57.5,healthA.alpha,1)

end

end

--Circle
localfunctionCircle()

localx,y=drag_menu(tX,tY,100,100)
localx,y=x+50,y+50

locallp=entities.GetLocalPlayer();

iflp~=nilandAvatars_Circle_Checkbox:GetValue()then
--Tomaketheedgessmooth
localr,g,b,a=36,36,36,255
draw.Color(r,g,b,a)
draw.FilledCircle(x,y,55)
draw.Color(r,g,b,a*0.8)
draw.FilledCircle(x,y,55.1)
draw.FilledCircle(x,y,55.2)
draw.Color(r,g,b,a*0.6)
draw.FilledCircle(x,y,55.3)
draw.FilledCircle(x,y,55.4)
draw.FilledCircle(x,y,55.5)
draw.Color(r,g,b,a*0.4)
draw.FilledCircle(x,y,55.6)
draw.FilledCircle(x,y,55.7)
draw.FilledCircle(x,y,55.8)
draw.FilledCircle(x,y,55.9)
draw.Color(r,g,b,a*0.2)
draw.FilledCircle(x,y,56)
draw.FilledCircle(x,y,56.1)
draw.FilledCircle(x,y,56.2)

--picture
localr,g,b,a=255,255,255,255
draw.Color(255,255,255,255)
draw.SetTexture(texture)
draw.FilledRect(x-39,y-39,width-145+x,height-145+y)
--Numberplate
localr,g,b,a=80,163,248,50
draw.Color(r,g,b,a)
draw.FilledCircle(x,y+37,14)
draw.Color(r,g,b,a*0.8)
draw.FilledCircle(x,y+37,14.1)
draw.Color(r,g,b,a*0.6)
draw.FilledCircle(x,y+37,14.2)
draw.FilledCircle(x,y+37,14.3)
draw.Color(r,g,b,a*0.4)
draw.FilledCircle(x,y+37,14.4)
draw.FilledCircle(x,y+37,14.5)
draw.FilledCircle(x,y+37,14.6)
draw.Color(r,g,b,a*0.2)
draw.FilledCircle(x,y+37,14.7)
draw.FilledCircle(x,y+37,14.8)
draw.FilledCircle(x,y+37,14.9)
draw.FilledCircle(x,y+37,15)

--drawCircular
draw.Color(34,34,34,255)
Circular(x,y,55,360,16)
--Forsmoothing
localr,g,b,a=34,34,34,255
draw.Color(r,g,b,a*0.8)
draw.OutlinedCircle(x,y,39.9)
draw.Color(r,g,b,a*0.6)
draw.OutlinedCircle(x,y,39.8)
draw.OutlinedCircle(x,y,39.7)
draw.Color(r,g,b,a*0.4)
draw.OutlinedCircle(x,y,39.6)
draw.OutlinedCircle(x,y,39.5)
draw.OutlinedCircle(x,y,39.4)
draw.Color(r,g,b,a*0.2)
draw.OutlinedCircle(x,y,39.3)
draw.OutlinedCircle(x,y,39.2)
draw.OutlinedCircle(x,y,39.1)
draw.OutlinedCircle(x,y,39)

end

end

--NeedtocoverArmor
localfunctioncover()

locallp=entities.GetLocalPlayer();
localx,y=drag_menu(tX,tY,100,100)
localx,y=x+50,y+50
localfade_factor=((1.0/0.15)*globals.FrameTime())*65
iflp~=nilandAvatars_Circle_Checkbox:GetValue()then

localarmor=lp:GetProp("m_ArmorValue")
ifarmorA==nilthen
armorA={alpha=360};
end
ifarmor*3.6~=360then--alphaanimation
armorA.alpha=alpha_stop(armorA.alpha-fade_factor,armor*3.6,360)
else
armorA.alpha=alpha_stop(armorA.alpha+fade_factor,0,armor*3.6)
end

draw.Color(80,163,248,200)--Idon'twanttorepeatthat,butforthesakeofsmoothness
Circular(x,y-0.5,41,armorA.alpha,0.8)
draw.Color(80,163,248,150)
Circular(x,y-0.5,41.2,armorA.alpha,0.8)
draw.Color(80,163,248,150)
Circular(x,y-0.5,40.8,armorA.alpha,0.8)


end
end

--Health,MoneyText
localfunctionText()

locallp=entities.GetLocalPlayer();
localx,y=drag_menu(tX,tY,100,100)
localx,y=x+50,y+50

localindexlp=client.GetLocalPlayerIndex()
localuserName=client.GetPlayerNameByIndex(indexlp);

iflp~=nilandAvatars_Circle_Checkbox:GetValue()then

localhealth=lp:GetHealth()
localmoney=lp:GetProp("m_iAccount")
localteamnumber=lp:GetTeamNumber()
localx1,y1=draw.GetTextSize(teamnumber)

ifhealth>75then--Multiplebloodcolors
draw.Color(134,200,134,255)
elseifhealth>60then
draw.Color(171,151,106,255)
elseifhealth>40then
draw.Color(190,90,90,255)
elseifhealth>20then
draw.Color(200,0,60,255)
elseifhealth>=0then
draw.Color(255,0,0,255)
end
draw.SetFont(font2)
draw.TextShadow(x-92,y-16,health.."hp")--Health

draw.Color(254,255,0,255)
draw.TextShadow(x+65,y+5,"Money●")
draw.Color(255,255,255,255)
draw.TextShadow(x+110,y+5,"$"..money)--Money

draw.SetFont(font)
draw.Color(255,255,255,255)
draw.TextShadow(x-x1+4,y+27,teamnumber)--Teamnumber

if(engine.GetServerIP()=="loopback")then--Server
server="localhost"
elseifstring.find(engine.GetServerIP(),"A")then
server="valve"
else
server="unknown"
end

ifstring.len(userName)>8then--Calculatenamelength
userName=string.match(userName,[[........]]);
userName=userName.."..."
end

draw.Color(255,255,255,255)
draw.SetFont(font2)
draw.TextShadow(x+65,y-27,server.."Hello"..userName)--ServerUserName


end
end

--Callbacks
callbacks.Register("Draw",function()
PositionSave()
Information()
animation()
Circle()
cover()
Text()
end)
--end





