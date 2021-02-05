-- Scraped by chicken
-- Author: JohnK.
-- Title [Release] Hide head from height
-- Forum link https://aimware.net/forum/thread/129673

localref=gui.Reference("Ragebot","Anti-Aim","Advanced")
localcheckbox=gui.Checkbox(ref,"hide.head.z","Anti-HightAdvantage",false)
checkbox:SetDescription("Triestohideheadfromplayerwithhightadvantage")
localbase_old=gui.GetValue("rbot.antiaim.base")
localbase_left=gui.GetValue("rbot.antiaim.left")
localbase_right=gui.GetValue("rbot.antiaim.right")
localfunctionget_closed_enemy(players)
localpos
localmin=math.huge
localnearest
fori,playerinpairs(players)do
ifplayer:GetTeamNumber()~=entities.GetLocalPlayer():GetTeamNumber()then

localpos=player:GetAbsOrigin()
ifpos==nilthen
return
end

locallenght=(pos-entities.GetLocalPlayer():GetAbsOrigin()):Length()
iflenght<minthen
min=lenght
nearest=player
end
end
end
returnnearest
end

localfunctionget_distance(entity1,entity2)
localabs2=entity2:GetAbsOrigin()
localabs1=entity1:GetAbsOrigin()
return((abs2-abs1):Length()),abs1.z,abs2.z
end


callbacks.Register("CreateMove",function(cmd)

ifnotcheckbox:GetValue()then
return
end
localplayers=entities.FindByClass("CCSPlayer")
localcloset_enemy=get_closed_enemy(players)
localdistance,pPosZ,posZ=get_distance(entities.GetLocalPlayer(),get_closed_enemy(players))
ifposZ+10>pPosZand(math.abs(posZ-pPosZ))^1.05>distancethen
gui.SetValue("rbot.antiaim.base",0,"Desync")
gui.SetValue("rbot.antiaim.left",40.0,"Desync")
gui.SetValue("rbot.antiaim.right",-40.0,"Desync")
else
gui.SetValue("rbot.antiaim.base",base_old,"Desync")
gui.SetValue("rbot.antiaim.left",base_left,"Desync")
gui.SetValue("rbot.antiaim.right",base_right,"Desync")
end
end)

