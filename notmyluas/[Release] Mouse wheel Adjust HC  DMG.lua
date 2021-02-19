-- Scraped by chicken
-- Author: AnAnAn
-- Title [Release] Mouse wheel Adjust HC  DMG
-- Forum link https://aimware.net/forum/thread/148048


--MouseWhellAdjustByAn
localWheelTab=gui.Tab(gui.Reference("MISC"),"MISC.Wheel","WhellAdjust")
localKeyGroup=gui.Groupbox(WheelTab,"Master",20,20,240,200)
localWheelGroup=gui.Groupbox(WheelTab,"Value",280,20,300,200)

localDMGKey=gui.Checkbox(KeyGroup,"DMGKey","DMGCheckbox",0)
localDMGValue=gui.Slider(WheelGroup,"DMGValue","DMGValue",5,1,20)
localHCKey=gui.Checkbox(KeyGroup,"HCKey","HCCheckbox",0)
localHCValue=gui.Slider(WheelGroup,"HCValue","HCValue",5,1,20)

localIndicator=gui.Checkbox(KeyGroup,"Indicator","Indicator",1)

functionMouseWhell()

DMGOver=DMGKey:GetValue()
HCOver=HCKey:GetValue()
MouseW=input.GetMouseWheelDelta
ScreenW,ScreenH=draw.GetScreenSize()
XCenter=ScreenW/2
YCenter=ScreenH/2

if(entities.GetLocalPlayer()~=nil)then
hLocalPlayer=entities.GetLocalPlayer()
wid=hLocalPlayer:GetWeaponID()
end

if(wid==1orwid==64)then
Weapon="hpistol"

elseif(wid==2orwid==3orwid==4orwid==30orwid==32orwid==36orwid==61orwid==63)then
Weapon="pistol"

elseif(wid==7orwid==8orwid==10orwid==13orwid==16orwid==39orwid==60)then
Weapon="rifle"

elseif(wid==11orwid==38)then
Weapon="asniper"

elseif(wid==40)then
Weapon="scout"

elseif(wid==9)then
Weapon="sniper"

elseif(wid==17orwid==19orwid==23orwid==24orwid==26orwid==33orwid==34)then
Weapon="smg"

elseif(wid==14orwid==28)then
Weapon="lmg"

elseif(wid==25orwid==27orwid==29orwid==35)then
Weapon="shotgun"
end

ifDMGOverorHCOverthen
client.Command("unbindMWHEELUP",true)
client.Command("unbindMWHEELDOWN",true)
ifDMGOverthen
DMGWheel()
end
ifHCOverthen
HCWheel()
end
else
client.Command("bindMWHEELUPinvprev",true)
client.Command("bindMWHEELDOWNinvnext",true)
end


end

functionDMGWheel()
ifMouseW()<=0then
WeaponDMGValue=gui.GetValue("rbot.accuracy.weapon."..Weapon..".mindmg")
else
gui.SetValue("rbot.accuracy.weapon."..Weapon..".mindmg",WeaponDMGValue+DMGValue:GetValue())
end
ifMouseW()>=0then
WeaponDMGValue=gui.GetValue("rbot.accuracy.weapon."..Weapon..".mindmg")
else
gui.SetValue("rbot.accuracy.weapon."..Weapon..".mindmg",WeaponDMGValue-DMGValue:GetValue())
end

ifIndicator:GetValue()then
draw.Color(255,255,255,255)
draw.Text(XCenter-150,YCenter+30,"———"..WeaponDMGValue+2)
draw.Text(XCenter-150,YCenter+15,"——"..WeaponDMGValue+1)
draw.Text(XCenter-150,YCenter-15,"——"..WeaponDMGValue-1)
draw.Text(XCenter-150,YCenter-30,"———"..WeaponDMGValue-2)
draw.Color(0,255,0,255)
draw.Text(XCenter-150,YCenter,"—"..WeaponDMGValue.."DMG")
end
end

functionHCWheel()
ifMouseW()<=0then
WeaponHCValue=gui.GetValue("rbot.accuracy.weapon."..Weapon..".hitchance")
else
gui.SetValue("rbot.accuracy.weapon."..Weapon..".hitchance",WeaponHCValue+HCValue:GetValue())
end
ifMouseW()>=0then
WeaponHCValue=gui.GetValue("rbot.accuracy.weapon."..Weapon..".hitchance")
else
gui.SetValue("rbot.accuracy.weapon."..Weapon..".hitchance",WeaponHCValue-HCValue:GetValue())
end

ifIndicator:GetValue()then
draw.Color(255,255,255,255)
draw.Text(XCenter+100,YCenter+30,WeaponHCValue+2.."———")
draw.Text(XCenter+100,YCenter+15,""..WeaponHCValue+1.."——")
draw.Text(XCenter+100,YCenter-15,""..WeaponHCValue-1.."——")
draw.Text(XCenter+100,YCenter-30,WeaponHCValue-2.."———")
draw.Color(0,255,0,255)
draw.Text(XCenter+76,YCenter,"HC"..WeaponHCValue.."—")
end
end

callbacks.Register("Draw",'MouseWhell',MouseWhell)

