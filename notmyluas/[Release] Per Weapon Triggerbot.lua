-- Scraped by chicken
-- Author: JohnK.
-- Title [Release] Per Weapon Triggerbot
-- Forum link https://aimware.net/forum/thread/114487

localvar={"enable","autofire","key","hitchance","mode","delay","burst","throughsmoke"}
localweapon_list={"pistol","smg","rifle","shotgun","sniper"}


localcheckbox_weapon_trigger=gui.Checkbox(gui.Reference("legit","trigger","triggerbot"),"triggerbot_weapon_cfg","WeaponCFG",false)
fori=1,#weapon_listdo
localref=gui.Reference("legit",weapon_list[i],"accuracy")
localbox=gui.Groupbox(ref,"Triggerbot")
localcheckbox_enable=gui.Checkbox(box,"triggerbot_"..weapon_list[i].."_legit_"..var[1],"Enable",false)
localcheckbox_autofire=gui.Checkbox(box,"triggerbot_"..weapon_list[i].."_legit_"..var[2],"AutoFire",false)
localkey=gui.Keybox(box,"triggerbot_"..weapon_list[i].."_legit_"..var[3],"Key",0)
localhc=gui.Slider(box,"triggerbot_"..weapon_list[i].."_legit_"..var[4],"Hitchance",0,0,100)
localmode=gui.Combobox(box,"triggerbot_"..weapon_list[i].."_legit_"..var[5],"Mode","Normal","RecoilOnly","SpreadOnly","Recoil/Spread")
localdelay=gui.Slider(box,"triggerbot_"..weapon_list[i].."_legit_"..var[6],"Dealy",0,0,1)
localburst=gui.Slider(box,"triggerbot_"..weapon_list[i].."_legit_"..var[7],"Burst",0,0,2)
localcheckbox_smoke=gui.Checkbox(box,"triggerbot_"..weapon_list[i].."_legit_"..var[8],"TroughSmoke",false)
end

localadaptive_weapons={
["sniper"]={5},
["pistol"]={1},
["rifle"]={3},
["smg"]={2},
["shotgun"]={4},
["false"]={},
}

localfunctiontable_contains(table,item)--seeline219
fori=1,#tabledo
iftable[i]==itemthen
returntrue
end
end
returnfalse
end

localfunctionfind_key(value)--seeline219
fork,vinpairs(adaptive_weapons)do
iftable_contains(v,value)then
returnk
end
end
end


localvar_gui={}
fori=1,#vardo
table.insert(var_gui,"lbot_trg_"..var[i])
end

callbacks.Register("Draw",function()


ifentities.GetLocalPlayer()==nilthen
return
end

localweapon=weapon_list[entities.GetLocalPlayer():GetWeaponType()]

ifweapon==nilthen
return
end

ifcheckbox_weapon_trigger:GetValue()then
fori=1,#vardo
gui.SetValue(var_gui[i],gui.GetValue("triggerbot_"..weapon.."_legit_"..var[i]))
end
end


end)
