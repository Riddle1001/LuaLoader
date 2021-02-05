-- Scraped by chicken
-- Author: nazefx
-- Title [Release] Doublefire Hold & Toggle
-- Forum link https://aimware.net/forum/thread/130955

--[[
███▄▄▄▄▄████████▄███████▄▄████████
███▀▀▀██▄████████▀▄████████
████████████▄███▀████▀
████████████▀█▀▄███▀▄▄▄███▄▄▄
██████▀███████████▄███▀▀▀▀███▀▀▀
████████████▄███▀████▄
███████████████▄▄███████
▀██▀████▀▀████████▀██████████
--]]


localDT_REF=gui.Reference("RAGEBOT","Accuracy","Weapon")
localBETTERCHAMS_TAB=gui.Tab(gui.Reference("RAGEBOT"),"ragebot.doubletap.tab","Doubletaponkey")
localDT_GB=gui.Groupbox(gui.Reference("RAGEBOT","Doubletaponkey"),"Settings",15,15,600,600)
localselectMode=gui.Combobox(DT_GB,"ragebot.doubletap.mode","Mode","Off","Hold","Toggle")
localselectInterval=gui.Combobox(DT_GB,"ragebot.doubletap.interval","Interval","Off","Shift","Rapid")
localselectWeapon=gui.Combobox(DT_GB,"ragebot.doubletap.weapon","Weapon","Autosniper","Pistols","Rifles","SMG","LMG","HeavyPistol","Current")
local******.doubletap.key","Doubletapkey",0)
localpressed=false;

localweapons={

[0]="asniper",
[1]="pistol",
[2]="rifle",
[3]="smg",
[4]="lmg",
[5]="hpistol"

}

localweaponID={
[61]="pistol",
[2]="pistol",
[26]="pistol",
[63]="pistol",
[1]="hpistol",
[3]="pistol",
[4]="pistol",
[32]="pistol",
[30]="pistol",
[7]="rifle",
[8]="rifle",
[10]="rifle",
[13]="rifle",
[60]="rifle",
[16]="rifle",
[39]="rifle",
[17]="smg",
[33]="smg",
[34]="smg",
[23]="smg",
[26]="smg",
[19]="smg",
[24]="smg",
[27]="shotgun",
[35]="shotgun",
[29]="shotgun",
[25]="shotgun",
[14]="lmg",
[28]="lmg",
[11]="asniper",
[38]="asniper",
}

localfunctionmainFunction()
localLocalPlayerEntity=entities.GetLocalPlayer()
locallp=LocalPlayerEntity:GetWeaponID()
ifsetKey:GetValue()==0then
return
end
ifsetKey:GetValue()~=0andselectMode:GetValue()~=0andselectInterval:GetValue()~=0then
ifinput.IsButtonDown(gui.GetValue("rbot.ragebot.doubletap.tab.ragebot.doubletap.key"))andselectInterval:GetValue()==1andselectWeapon:GetValue()~=6then
gui.SetValue("rbot.accuracy.weapon."..(weapons[selectWeapon:GetValue()])..".doublefire",1)
end
ifinput.IsButtonDown(gui.GetValue("rbot.ragebot.doubletap.tab.ragebot.doubletap.key"))andselectInterval:GetValue()==2andselectWeapon:GetValue()~=6then
gui.SetValue("rbot.accuracy.weapon."..(weapons[selectWeapon:GetValue()])..".doublefire",2)
end
ifnotinput.IsButtonDown(gui.GetValue("rbot.ragebot.doubletap.tab.ragebot.doubletap.key"))andselectWeapon:GetValue()~=6then
gui.SetValue("rbot.accuracy.weapon."..(weapons[selectWeapon:GetValue()])..".doublefire",0)
end
end

ifsetKey:GetValue()~=0andselectMode:GetValue()~=0andselectMode:GetValue()~=2andselectInterval:GetValue()~=0andselectWeapon:GetValue()==6andweaponID[lp]~=nilthen
gui.SetValue("rbot.accuracy.weapon."..(weaponID[lp])..".doublefire",1)
end
ifinput.IsButtonDown(gui.GetValue("rbot.ragebot.doubletap.tab.ragebot.doubletap.key"))andselectInterval:GetValue()==2andselectWeapon:GetValue()==6andweaponID[lp]~=nilthen
gui.SetValue("rbot.accuracy.weapon."..(weaponID[lp])..".doublefire",2)
end
ifnotinput.IsButtonDown(gui.GetValue("rbot.ragebot.doubletap.tab.ragebot.doubletap.key"))andselectWeapon:GetValue()==6andweaponID[lp]~=nilthen
gui.SetValue("rbot.accuracy.weapon."..(weaponID[lp])..".doublefire",0)
end

ifsetKey:GetValue()~=0andselectMode:GetValue()==2andselectInterval:GetValue()~=0andselectWeapon:GetValue()==6then
ifinput.IsButtonPressed(******toggle
end
iftoggleandselectInterval:GetValue()==1andweaponID[lp]~=nilthen
gui.SetValue("rbot.accuracy.weapon."..(weaponID[lp])..".doublefire",1)
end
iftoggleandselectInterval:GetValue()==2andweaponID[lp]~=nilthen
gui.SetValue("rbot.accuracy.weapon."..(weaponID[lp])..".doublefire",2)
ifnottoggleandweaponID[lp]~=nilthen
gui.SetValue("rbot.accuracy.weapon.pistol.doublefire",0)
gui.SetValue("rbot.accuracy.weapon.rifle.doublefire",0)
gui.SetValue("rbot.accuracy.weapon.hpistol.doublefire",0)
gui.SetValue("rbot.accuracy.weapon.shotgun.doublefire",0)
gui.SetValue("rbot.accuracy.weapon.asniper.doublefire",0)
gui.SetValue("rbot.accuracy.weapon.smg.doublefire",0)
gui.SetValue("rbot.accuracy.weapon.lmg.doublefire",0)
end
end
end

ifsetKey:GetValue()~=0andselectMode:GetValue()==2andselectInterval:GetValue()~=0andselectWeapon:GetValue()~=6then
ifinput.IsButtonPressed(******toggle
end
iftoggleandselectInterval:GetValue()==1then
gui.SetValue("rbot.accuracy.weapon."..(weapons[selectWeapon:GetValue()])..".doublefire",1)
end
iftoggleandselectInterval:GetValue()==2then
gui.SetValue("rbot.accuracy.weapon."..(weapons[selectWeapon:GetValue()])..".doublefire",2)
ifnottogglethen
gui.SetValue("rbot.accuracy.weapon."..(weapons[selectWeapon:GetValue()])..".doublefire",0)
end
end
end
end

callbacks.Register('Draw',mainFunction)





