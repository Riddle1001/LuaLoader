-- Scraped by chicken
-- Author: hemuyang
-- Title [Release] Minimum Damage Indicator
-- Forum link https://aimware.net/forum/thread/145644

--悠然
local fon = draw.CreateFont("Verdana",50,50)
callbacks.Register("Draw",function()
local x,y = draw.GetScreenSize()
draw.SetTexture(texture)
--连狙
      if entities.GetByIndex(client.GetLocalPlayerIndex()):GetWeaponID()==38 or entities.GetByIndex(client.GetLocalPlayerIndex()):GetWeaponID()==11 then
draw.SetFont(fon)
draw.TextShadow(x-100,y-460,gui.GetValue("rbot.accuracy.weapon.asniper.mindmg"))
        --自动步枪
      elseif entities.GetByIndex(client.GetLocalPlayerIndex()):GetWeaponType()==3 then
draw.SetFont(fon)
draw.TextShadow(x-100,y-460,gui.GetValue("rbot.accuracy.weapon.rifle.mindmg"))
--大狙
elseif entities.GetByIndex(client.GetLocalPlayerIndex()):GetWeaponID()==9 then
draw.SetFont(fon)
draw.TextShadow(x-100,y-460,gui.GetValue("rbot.accuracy.weapon.sniper.mindmg"))
        --重型手枪
      elseif entities.GetByIndex(client.GetLocalPlayerIndex()):GetWeaponID()==64 then
draw.SetFont(fon)
draw.TextShadow(x-100,y-460,gui.GetValue("rbot.accuracy.weapon.hpistol.mindmg"))
        --轻型手枪
      elseif entities.GetByIndex(client.GetLocalPlayerIndex()):GetWeaponType()==1 and entities.GetByIndex(client.GetLocalPlayerIndex()):GetWeaponID()~=1 then
draw.SetFont(fon)
draw.TextShadow(x-100,y-460,gui.GetValue("rbot.accuracy.weapon.pistol.mindmg"))
        --冲锋枪
      elseif entities.GetByIndex(client.GetLocalPlayerIndex()):GetWeaponType()==2 then
draw.SetFont(fon)
draw.TextShadow(x-100,y-460,gui.GetValue("rbot.accuracy.weapon.smg.mindmg"))
        --重机枪
      elseif entities.GetByIndex(client.GetLocalPlayerIndex()):GetWeaponType()==6 then
draw.SetFont(fon)
draw.TextShadow(x-100,y-460,gui.GetValue("rbot.accuracy.weapon.lmg.mindmg"))
--鸟狙
      elseif entities.GetByIndex(client.GetLocalPlayerIndex()):GetWeaponID()==40 then
draw.SetFont(fon)
draw.TextShadow(x-100,y-460,gui.GetValue("rbot.accuracy.weapon.scout.mindmg"))
      end
end)



