-- Scraped by chicken
-- Author: 2878713023
-- Title [Release] Multinomial Indicator
-- Forum link https://aimware.net/forum/thread/151107

localfunctionrequire(name,url)
package=packageor{}

package.loaded=package.loadedor{}

package.loaded[name]=
package.loaded[name]orRunScript(name..".lua")or
http.Get(
url,
function(body)
file.Write(name..".lua",body)
end
)

returnpackage.loaded[name]orerror("unabletoloadmodule"..name.."(trytoreload)",2)
end
localdraw=require("libraries/draw","https://aimware28.coding.net/p/coding-code-guide/d/aim_lib/git/raw/master/draw/draw.lua?download=false")

localfunctionmenu_weapon(var)
localw=var:match("%a+"):lower()
localw=w:find("heavy")and"hpistol"orw:find("auto")and"asniper"orw:find("submachine")and"smg"orw:find("light")and"lmg"orw
returnw
end

localui={}
ui.ref=gui.Reference("visuals","other","extra")
ui.multi_box=gui.Multibox(ui.ref,"Indicators")
ui.multi_box:SetDescription("Indicatorshownontheleft.")

ui.option={
gui.Checkbox(ui.multi_box,"indicators.ct","Custom",1),
gui.Checkbox(ui.multi_box,"indicators.lr","Legit/Rage",1),
gui.Checkbox(ui.multi_box,"indicators.af","Autofire",1),
gui.Checkbox(ui.multi_box,"indicators.fov","FOV",1),
gui.Checkbox(ui.multi_box,"indicators.hc","HitChance",1),
gui.Checkbox(ui.multi_box,"indicators.dmg","MinDamage",1),
gui.Checkbox(ui.multi_box,"indicators.aw","AutoWall",1),
gui.Checkbox(ui.multi_box,"indicators.fl","Fakelag",1),
gui.Checkbox(ui.multi_box,"indicators.fd","FakeDuck",1),
gui.Checkbox(ui.multi_box,"indicators.dt","Doubletap",1),
gui.Checkbox(ui.multi_box,"indicators.lc","LagCompensation",1)
}

ui.edit_box=gui.Editbox(ui.ref,"indicators.custom.text","Customindicators")
ui.edit_box:SetDescription("Customindicatortext.")
ui.edit_box:SetValue("aimware.net")
ui.edit_box:SetHeight(45)
ui.option.clr={}
fori=1,#ui.optiondo
ui.option.clr[i]=gui.ColorPicker(ui.option[i],"clr","clr",255,255,255,255)
end

localorigin_records={}
localglobals_CurTime,globals_TickInterval=globals.CurTime,globals.TickInterval
localmath_floor=math.floor

localfunctiontime_to_ticks(a)
returnmath_floor(1+a/globals_TickInterval())
end

localfunctionon_create_move(cmd)
locallp=entities.GetLocalPlayer()
ifnot(lpandlp:IsAlive())then
return
end
ifui.option[11]:GetValue()then
ifcmd.sendpacketthen
origin_records[#origin_records+1]=lp:GetAbsOrigin()
end
end
end

localfunctionon_draw()
locallp=entities.GetLocalPlayer()

ifnot(lpandlp:IsAlive())then
return
end

locallbot=gui.GetValue("lbot.master")
localrbot=gui.GetValue("rbot.master")

ifui.option[11]:GetValue()andorigin_records[1]andorigin_records[2]then
localr,g,b,a=ui.option.clr[11]:GetValue()
localdelta=
Vector3(origin_records[2].x-origin_records[1].x,origin_records[2].y-origin_records[1].y,origin_records[2].z-origin_records[1].z)
ifdelta:Length2D()^2>4096then
draw.indicator(r,g,b,a,"LC")
end
iforigin_records[3]then
table.remove(origin_records,1)
end
end

ifui.option[10]:GetValue()then
localweapon=menu_weapon(gui.GetValue("rbot.accuracy.weapon"))
localdt_pcall=pcall(gui.GetValue,"rbot.accuracy.weapon."..weapon..".doublefire")

ifdt_pcallandgui.GetValue("rbot.accuracy.weapon."..weapon..".doublefire")>1then
localm_flNextSecondaryAttack=lp:GetPropEntity("m_hActiveWeapon"):GetPropFloat("LocalActiveWeaponData","m_flNextSecondaryAttack")
localr,g,b,a=ui.option.clr[10]:GetValue()
ifm_flNextSecondaryAttack>globals_CurTime()+0.03then
r,g,b,a=255,0,0,255
end
draw.indicator(r,g,b,a,"DT")
end
end

ifui.option[9]:GetValue()then
localfakecrouchkey=gui.GetValue("rbot.antiaim.extra.fakecrouchkey")
iffakecrouchkey~=0andinput.IsButtonDown(fakecrouchkey)then
localr,g,b,a=ui.option.clr[9]:GetValue()
draw.indicator(r,g,b,a,"FD")
end
end

ifui.option[8]:GetValue()then
localr,g,b,a=ui.option.clr[8]:GetValue()

localfl=time_to_ticks(globals_CurTime()-lp:GetPropFloat("m_flSimulationTime"))+2
draw.indicator(r,g,b,a,"FL"..fl)
end

ifui.option[7]:GetValue()andgui.GetValue("rbot.hitscan.mode."..menu_weapon(gui.GetValue("rbot.hitscan.mode"))..".autowall")then
localr,g,b,a=ui.option.clr[7]:GetValue()
draw.indicator(r,g,b,a,"AW")
end

ifui.option[6]:GetValue()then
localr,g,b,a=ui.option.clr[6]:GetValue()
localweapon=menu_weapon(gui.GetValue("rbot.accuracy.weapon"))
localtext=gui.GetValue("rbot.accuracy.weapon."..weapon..".mindmg")
draw.indicator(r,g,b,a,"DMG:"..((text>100)and("HP+"..(text-100))ortext))
end

ifui.option[5]:GetValue()then
localr,g,b,a=ui.option.clr[5]:GetValue()
localweapon=menu_weapon(gui.GetValue("rbot.accuracy.weapon"))
localtext=gui.GetValue("rbot.accuracy.weapon."..weapon..".hitchance")
draw.indicator(r,g,b,a,"HC:"..text)
end

ifui.option[4]:GetValue()then
localr,g,b,a=ui.option.clr[4]:GetValue()
localweapon=menu_weapon(gui.GetValue("lbot.weapon.target"))
localtext=
lbotand("%.1f"):format(gui.GetValue("lbot.weapon.target."..weapon..".maxfov"))orrbotandgui.GetValue("rbot.aim.target.fov")
draw.indicator(r,g,b,a,text.."°")
end

ifui.option[3]:GetValue()and((lbotandgui.GetValue("lbot.aim.autofire"))or(rbotandgui.GetValue("rbot.aim.enable")))then
localr,g,b,a=ui.option.clr[3]:GetValue()
draw.indicator(r,g,b,a,"AF")
end

ifui.option[2]:GetValue()then
localr,g,b,a=ui.option.clr[2]:GetValue()
localtext=lbotand"Legit"orrbotand"Rage"
draw.indicator(r,g,b,a,text)
end

ui.edit_box:SetInvisible(notui.option[1]:GetValue())
ifui.option[1]:GetValue()then
localr,g,b,a=ui.option.clr[1]:GetValue()
localtext=ui.edit_box:GetValue()
draw.indicator(r,g,b,a,text)
end
end

callbacks.Register("CreateMove",on_create_move)
callbacks.Register("Draw",on_draw)


