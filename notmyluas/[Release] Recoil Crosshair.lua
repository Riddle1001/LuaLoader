-- Scraped by chicken
-- Author: Dracer
-- Title [Release] Recoil Crosshair
-- Forum link https://aimware.net/forum/thread/127925

--RecoilCrosshairbyCheeseot,portedtoV5byDracer
localButtonPosition=gui.Reference("VISUALS","Other","Extra");
localPunchCheckbox=gui.Checkbox(ButtonPosition,"lua_recoilcrosshair","RecoilCrosshair",0);
localCrosshairColorPicker=gui.ColorPicker(PunchCheckbox,"crosshairColor","CrosshairColor",255,255,255,255);
localIdleCheckbox=gui.Checkbox(ButtonPosition,"lua_recoilidle","HideRecoilCrosshairWhenIdle",0);


localWeaponTypes={
"zeus",
"pistol",
"smg",
"rifle",
"shotgun",
"sniper",
"lmg",
}

functionpunch()

localrifle=0;
localme=entities.GetLocalPlayer();
ifme~=nilandgui.GetValue("esp.master")then
localscoped=me:GetProp("m_bIsScoped");
ifscoped==256thenscoped=0end
ifscoped==257thenscoped=1end
localmy_weapon=me:GetPropEntity("m_hActiveWeapon");
ifmy_weapon~=nilthen
localweapon_name=my_weapon:GetClass();
ifweapon_name==nilthenreturnend
localcanDraw=0;
localsnipercrosshair=0;
weapon_name=weapon_name:gsub("CWeapon","");
ifweapon_name=="Aug"orweapon_name=="SG556"then
rifle=1;
else
rifle=0;
end

ifscoped==0or(scoped==1andrifle==1)then
canDraw=1;
else
canDraw=0;
end

ifweapon_name=="Taser"orweapon_name=="CKnife"then
canDraw=0;
end

ifweapon_name=="AWP"orweapon_name=="SCAR20"orweapon_name=="G3SG1"orweapon_name=="SSG08"then
snipercrosshair=1;
end

--RecoilCrosshairbyCheeseot,portedtoV5byDracer

ifme:IsAlive()andPunchCheckbox:GetValue()andcanDraw==1then
localrecoilVector=me:GetPropVector("localdata","m_Local","m_aimPunchAngle");
localpunchAngleX=recoilVector.x
localpunchAngleY=recoilVector.y
localw,h=draw.GetScreenSize();
localx=w/2;
localy=h/2;
localfov=client.GetConVar("viewmodel_fov");

iffov==0then
fov=90;
end
ifscoped==1andrifle==1then
fov=45;
end

localdx=w/fov;
localdy=h/fov;

localpx=0
localpy=0
localantiRecoil=false
localweaponType=""
localcurrWeaponType=me:GetWeaponType()
ifcurrWeaponType>0andcurrWeaponType<7then
weaponType=WeaponTypes[currWeaponType]
localweaponID=me:GetWeaponID()
ifcurrWeaponType==1and(weaponID==1orweaponID==64)then--Deagle/Revolver
weaponType="hpistol"
end
ifcurrWeaponType==5then
ifweaponID==40then
weaponType="scout"
elseifweaponID==38orweaponID==11then
weaponType="asniper"
end
end

antiRecoil=gui.GetValue("rbot.accuracy.weapon."..weaponType..".antirecoil")
end

if(gui.GetValue("esp.other.norecoil")andgui.GetValue("rbot.master")andantiRecoil)or(gui.GetValue("rbot.master")andantiRecoil)then
px=x;
py=y;
elseifgui.GetValue("esp.other.norecoil")then
px=x-(dx*punchAngleY)*1.2;
py=y+(dy*punchAngleX)*2;
else
px=x-(dx*punchAngleY)*0.6;
py=y+(dy*punchAngleX)*0.9;
end

ifpx>x-0.5andpx<xthenpx=xend
ifpx<x+0.5andpx>xthenpx=xend
ifpy>y-0.5andpy<ythenpy=yend
ifpy<y+0.5andpy>ythenpy=yend

ifIdleCheckbox:GetValue()then
ifpx==xandpy==yandsnipercrosshair~=1thenreturn;end
end

draw.Color(CrosshairColorPicker:GetValue());
draw.Color();
draw.FilledRect(px-3,py-1,px+3,py+1);
draw.FilledRect(px-1,py-3,px+1,py+3);
end
end
end
end
callbacks.Register("Draw","punch",punch);
--RecoilCrosshairbyCheeseot,portedtoV5byDracer

