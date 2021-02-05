-- Scraped by chicken
-- Author: 2878713023
-- Title  [Release] DT Ready indicator
-- Forum link https://aimware.net/forum/thread/147837

--Workingonaimware
--byqi

--gui
localdt_storage_indicator_reference=gui.Reference("Misc","General","Extra");
localdt_storage_indicator_enable=gui.Checkbox(dt_storage_indicator_reference,'dtstorageind.enable',"EnableDTindicator",1)
localdt_storage_indicator_clr1=gui.ColorPicker(dt_storage_indicator_enable,'clr','clr',255,255,255,255)
localdt_storage_indicator_clr2=gui.ColorPicker(dt_storage_indicator_enable,'clr2','clr2',255,255,255,255)
localdt_storage_indicator_text_clr=gui.ColorPicker(dt_storage_indicator_enable,'text.clr','textclr',255,255,255,255)
localx,y=draw.GetScreenSize()
localdt_storage_indicator_x=gui.Slider(dt_storage_indicator_reference,"dtstorageind.x","dt_storage_indicator_x",500,0,x)
localdt_storage_indicator_y=gui.Slider(dt_storage_indicator_reference,"dtstorageind.y","dt_storage_indicator_y",500,0,y)
dt_storage_indicator_x:SetInvisible(true)
dt_storage_indicator_y:SetInvisible(true)

--var
localtX,tY,offsetX,offsetY,_drag
localfont=draw.CreateFont("Verdana",12.5,11.5)
localtickbase=gui.Reference("Misc","General","Server","sv_maxusrcmdprocessticks")

--function

--Mousedrag
localis_inside=function(a,b,x,y,w,h)
return
a>=xanda<=wandb>=yandb<=h
end

localdrag_menu=function(x,y,w,h)
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
dt_storage_indicator_x:SetValue(tX)
dt_storage_indicator_y:SetValue(tY)
end
else
_drag=false
end
returntX,tY
end

--Gradualchange
localfunctionrect(x,y,w,h,col)
draw.Color(col[1],col[2],col[3],col[4]);
draw.FilledRect(x,y,x+w,y+h);
end

localfunctiongradientH(x1,y1,x2,y2,col1,left)
localw=x2-x1
localh=y2-y1

fori=0,wdo
locala=(i/w)*col1[4]
localr,g,b=col1[1],col1[2],col1[3],col1[4];
draw.Color(r,g,b,a)
ifleftthen
draw.FilledRect(x1+i,y1,x1+i+1,y1+h)
else
draw.FilledRect(x1+w-i,y1,x1+w-i+1,y1+h)
end
end
end

localfunctiongradientV(x,y,w,h,col1,down)

localr,g,b,a=col1[1],col1[2],col1[3],col1[4];
fori=1,hdo
locala=i/h*col1[4];
ifdownthen
rect(x,y+i,w,1,{r,g,b,a});
else
rect(x,y-i,w,1,{r,g,b,a});
end
end
end

localfunctiondraw_GradientRect(x,y,w,h,dir,col1,col2)

localr,g,b,a=col1[1],col1[2],col1[3],col1[4];
localr2,g2,b2,a2=col2[1],col2[2],col2[3],col2[4];
ifdir==0then
gradientV(x,y,w,h,{r2,g2,b2,a2},true)
gradientV(x,y+h,w,h,{r,g,b,a},false)
elseifdir==1then
gradientH(x,y,w+x,h+y,{r,g,b,a},true)
gradientH(x,y,w+x,h+y,{r2,g2,b2,a2},false)
elseifdir~=1or0then
print("GradientRect:Unexpectedcharacters'"..dir.."'(Pleaseuseit0or1)")
end

end

--Ondrawindicator
localfunctiondraw_indicator()

locallp=entities.GetLocalPlayer()
iflp~=nilthen

localhActiveWeapon=lp:GetPropEntity("m_hActiveWeapon")
local_SecondaryAttack=hActiveWeapon:GetPropFloat("LocalActiveWeaponData","m_flNextSecondaryAttack")--Getammunitionreply

if_SecondaryAttack~=nilanddt_storage_indicator_enable:GetValue()then

--Letdragpositionsave
iftX~=dt_storage_indicator_x:GetValue()ortY~=dt_storage_indicator_y:GetValue()then
tX,tY=dt_storage_indicator_x:GetValue(),dt_storage_indicator_y:GetValue()
end
--var
localwid=lp:GetWeaponID()
localx,y=drag_menu(tX,tY,300,25)
localr,g,b,a=dt_storage_indicator_clr1:GetValue()
localr2,g2,b2,a2=dt_storage_indicator_clr2:GetValue()
localr3,g3,b3,a3=dt_storage_indicator_text_clr:GetValue()
localtickbase=tickbase:GetValue()

localstorage=false
localready="Chaging"
if_SecondaryAttack<=globals.CurTime()then
storage=true
ready="Ready"
end

localtext="[Aimware]|Tickbase("..tickbase.."tick):"..ready
localw,h=draw.GetTextSize(text);

ifstoragethen
r2,g2,b2,a2=r2,g2,b2,a2
else
r2,g2,b2,a2=r,g,b,a
end
draw_GradientRect(x,y,w-50,2,1,{r,g,b,a},{r2,g2,b2,a2})
draw.Color(r3,g3,b3,a3)
draw.SetFont(font)
draw.TextShadow(x+3,y+5,text)
--CheckwhetherDTison
localDoubletap=false
ifgui.GetValue("rbot.master")and(wid==1)andgui.GetValue("rbot.accuracy.weapon.hpistol.doublefire")~=0then
Doubletap=true
elseifgui.GetValue("rbot.master")and(wid==2orwid==3orwid==4orwid==30orwid==32orwid==36orwid==61orwid==63)andgui.GetValue("rbot.accuracy.weapon.pistol.doublefire")~=0then
Doubletap=true
elseifgui.GetValue("rbot.master")and(wid==7orwid==8orwid==10orwid==13orwid==16orwid==39orwid==60)andgui.GetValue("rbot.accuracy.weapon.rifle.doublefire")~=0then
Doubletap=true
elseifgui.GetValue("rbot.master")and(wid==11orwid==38)andgui.GetValue("rbot.accuracy.weapon.asniper.doublefire")~=0then
Doubletap=true
elseifgui.GetValue("rbot.master")and(wid==17orwid==19orwid==23orwid==24orwid==26orwid==33orwid==34)andgui.GetValue("rbot.accuracy.weapon.smg.doublefire")~=0then
Doubletap=true
elseifgui.GetValue("rbot.master")and(wid==14orwid==28)andgui.GetValue("rbot.accuracy.weapon.lmg.doublefire")~=0then
Doubletap=true
elseifgui.GetValue("rbot.master")and(wid==25orwid==27orwid==29orwid==35)andgui.GetValue("rbot.accuracy.weapon.shotgun.doublefire")~=0then
Doubletap=true
end
--Setcolor
ifDoubletapthen
a3_1=255
else
a3_1=math.floor(math.sin((globals.RealTime())*4)*100+200)-80
end
ifstoragethen
r3,g3,b3=r3,g3,b3
else
r3,g3,b3=255,0,0,a3_1
end
draw.Color(r3,g3,b3,a3_1)
draw.Text(x+3,y+5.5,'DT')
end
end

end
--callbacks
callbacks.Register('Draw',draw_indicator)
--end


