-- Scraped by chicken
-- Author: Scape
-- Title [Release] Disable third person on grenade
-- Forum link https://aimware.net/forum/thread/134620

--FirstpersongrenadehelperbyScape#4313
--Requestfromlaorentonfourms
localdisableOnNade=gui.Checkbox(gui.Reference("Visuals","Local","Camera"),"thirdpersonnade","DisableOnNade",false);
disableOnNade:SetDescription("Disablethirdpersonwhenholdingagrenade");

localthirdpersonKey=gui.GetValue("esp.local.thirdpersonkey");
localthirdpersonActive=true;
client.Command("thirdperson",true);

localfunctionfirstPersonGrenade()
locallocalPlayer=entities.GetLocalPlayer();

ifinput.IsButtonPressed(thirdpersonKey)then
thirdpersonActive=notthirdpersonActive;
end

ifdisableOnNade:GetValue()andlocalPlayerthen
localweaponType=localPlayer:GetPropEntity('m_hActiveWeapon'):GetWeaponType()

ifweaponType==9then
client.Command("firstperson",true);
else
ifthirdpersonActivethen
client.Command("thirdperson",true);
end
end
end
end

callbacks.Register("Draw",firstPersonGrenade);

