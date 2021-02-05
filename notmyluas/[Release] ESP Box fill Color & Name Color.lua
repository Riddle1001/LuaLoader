-- Scraped by chicken
-- Author: 2878713023
-- Title  [Release] ESP Box fill Color & Name Color
-- Forum link https://aimware.net/forum/thread/147562

----Producers:Qi--QIDAIMWAREQI
--Writeforaimware

--gui
localenemy_enable=gui.Checkbox(gui.Reference("VISUALS","Overlay","Enemy"),"enemy_enable","Boxfill",0)
localenemy_enable_clr=gui.ColorPicker(enemy_enable,"clr","clr",240,60,30,255)
localenemy_enable_clr2=gui.ColorPicker(enemy_enable,"clr2","clr2",240,60,30,255)
enemy_enable:SetDescription("Draw2Dboxfillaroundentity.")
localenemy_name_Reference=gui.Reference("Visuals","Overlay","Enemy","Name");
localenemy_name_Checkbox=gui.Checkbox(gui.Reference("Visuals","Overlay","Enemy"),"esp.overlay.enemy.name2.","Name",0);
localenemy_name_ColorPicker=gui.ColorPicker(enemy_name_Checkbox,"clr","clr",255,255,255,255)
enemy_name_Checkbox:SetDescription("Drawentityname.")

localfriendly_enable=gui.Checkbox(gui.Reference("VISUALS","Overlay","Friendly"),"Friendly_enable","Boxfill",0)
localfriendly_enable_clr=gui.ColorPicker(friendly_enable,"clr","clr",30,154,247,255)
localfriendly_enable_clr2=gui.ColorPicker(friendly_enable,"clr2","clr2",30,154,247,255)
friendly_enable:SetDescription("Draw2Dboxfillaroundentity.")
localfriendly_name_Reference=gui.Reference("Visuals","Overlay","Friendly","Name");
localfriendly_name_Checkbox=gui.Checkbox(gui.Reference("Visuals","Overlay","Friendly"),"esp.overlay.friendly.name2.","Name",0);
localfriendly_name_ColorPicker=gui.ColorPicker(friendly_name_Checkbox,"clr","clr",255,255,255,255)
friendly_name_Checkbox:SetDescription("Drawentityname.")

--drawfunction
localfunctionrect(x,y,w,h,col)
draw.Color(col[1],col[2],col[3],col[4]);
draw.FilledRect(x,y,x+w,y+h);
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

--DrawESP
callbacks.Register("DrawESP",function(builder)
localbuilderEntity=builder:GetEntity()
iffriendly_enable:GetValue()andbuilderEntity:IsPlayer()andbuilderEntity:IsAlive()andbuilderEntity:GetTeamNumber()==entities.GetLocalPlayer():GetTeamNumber()then
x1,y1,x2,y2=builder:GetRect()
r,g,b,a=gui.GetValue("esp.overlay.friendly.Friendly_enable.clr")
r2,g2,b2,a2=gui.GetValue("esp.overlay.friendly.Friendly_enable.clr2")
gradientV(x1,y2,x2-x1,y2-y1,{r2,g2,b2,a2},down)
gradientV(x1,y1,x2-x1,y2-y1,{r,g,b,a},0)
end
ifenemy_enable:GetValue()andbuilderEntity:IsPlayer()andbuilderEntity:IsAlive()andbuilderEntity:GetTeamNumber()~=entities.GetLocalPlayer():GetTeamNumber()then
x1,y1,x2,y2=builder:GetRect()
r,g,b,a=gui.GetValue("esp.overlay.enemy.enemy_enable.clr")
r2,g2,b2,a2=gui.GetValue("esp.overlay.enemy.enemy_enable.clr2")
gradientV(x1,y2,x2-x1,y2-y1,{r2,g2,b2,a2},down)
gradientV(x1,y1,x2-x1,y2-y1,{r,g,b,a},0)
end
localname=builderEntity:GetName();
localweaponName=builderEntity:GetWeaponID();
iffriendly_name_Checkbox:GetValue()andbuilderEntity:IsPlayer()andbuilderEntity:IsAlive()andbuilderEntity:GetTeamNumber()==entities.GetLocalPlayer():GetTeamNumber()then
gui.SetValue("esp.overlay.friendly.name",0)
builder:Color(friendly_name_ColorPicker:GetValue());
builder:AddTextTop(name);
end
ifenemy_name_Checkbox:GetValue()andbuilderEntity:IsPlayer()andbuilderEntity:IsAlive()andbuilderEntity:GetTeamNumber()~=entities.GetLocalPlayer():GetTeamNumber()then
gui.SetValue("esp.overlay.enemy.name",0)
builder:Color(enemy_name_ColorPicker:GetValue());
builder:AddTextTop(name);
end
end)
client.Command("echo[Aim-ware]LoadingcompleteBoxfill",1)
--end


