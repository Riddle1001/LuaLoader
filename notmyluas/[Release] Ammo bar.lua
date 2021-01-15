-- Scraped by chicken
-- Author: gooksmasher
-- Title [Release] Ammo bar
-- Forum link https://aimware.net/forum/thread/128592

localmax_ammos={7,30,20,20,-1,-1,30,30,10,25,20,-1,35,100,-1,30,30,-1,50,-1,-1,-1,
30,25,7,64,5,150,7,18,1,13,30,30,8,13,-1,20,30,10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
-1,25,12,12,8}

localfunctionAmmobar(E)
localteam_weapon=gui.GetValue("esp.overlay.friendly.weapon");
localenemy_weapon=gui.GetValue("esp.overlay.enemy.weapon");
localcurrent_entity=E:GetEntity();
locallocal_player=entities.GetLocalPlayer();
ifcurrent_entity:IsPlayer()then
ifcurrent_entity:GetTeamNumber()==local_player:GetTeamNumber()andteam_weapon==0then
return
end

ifcurrent_entity:GetTeamNumber()~=local_player:GetTeamNumber()andenemy_weapon==0then
return
end

localweapon=current_entity:GetPropEntity("m_hActiveWeapon");
ifweapon==nilthen
return
end
ifweapon:GetWeaponID()>64ormax_ammos[weapon:GetWeaponID()]==-1then
return
end

localpercent=weapon:GetPropInt("m_iClip1")/max_ammos[weapon:GetWeaponID()];
E:Color(102,173,255,200);
E:AddBarBottom(percent);
end
end

callbacks.Register("DrawESP","Ammobar",Ammobar);