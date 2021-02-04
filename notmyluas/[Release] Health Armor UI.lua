-- Scraped by chicken
-- Author: 2878713023
-- Title [Release] Health Armor UI
-- Forum link https://aimware.net/forum/thread/147789

--Workingonaimware
--byqi

--gui
localHealthArmor_Reference=gui.Reference("Visuals","Local","Camera")
localHealthArmor_Checkbox=gui.Checkbox(HealthArmor_Reference,"hparmorui.enable","HealthArmorUI",0);

--var
localw,h=draw.GetScreenSize()
localfont=draw.CreateFont("SegoeUI",28,500)

--alphafunction
localfunctionalpha_stop(val,min,max)
ifval<minthenreturnminend
ifval>maxthenreturnmaxend
returnval;
end
--Ondarw
localfunctionOndarw()

locallp=entities.GetLocalPlayer()
iflp~=nilandHealthArmor_Checkbox:GetValue()then
localx,y=15,1025
localhp=lp:GetHealth()
localarmor=lp:GetProp("m_ArmorValue")
client.SetConVar("hidehud",8,true)

localfade_factor=((1.0/0.15)*globals.FrameTime())*25;

ifalpha==nilthen
alpha={hp=100};
end
ifhp~=100then--hpalphaanimation
alpha.hp=alpha_stop(alpha.hp-fade_factor,hp,100);
else
alpha.hp=alpha_stop(alpha.hp+fade_factor,0,hp);
end

ifalpha2==nilthen
alpha2={armor=100};
end
ifarmor~=100then--armoralphaanimation
alpha2.armor=alpha_stop(alpha2.armor-fade_factor,armor,100);
else
alpha2.armor=alpha_stop(alpha2.armor+fade_factor,0,armor);
end

draw.SetFont(font)
draw.Color(4,4,4,200)
draw.Text(x+4,y+6,hp)
draw.Text(x+154,y+6,armor)

ifhp>85then
draw.Color(0,255,0,255)
elseifhp>75then
draw.Color(173,255,47,255)
elseifhp>60then
draw.Color(255,255,0,255)
elseifhp>40then
draw.Color(209,154,102,255)
elseifhp>20then
draw.Color(238,99,99,255)
elseifhp>=0then
draw.Color(255,0,0,255)
end

draw.FilledRect(x,y+30,x+alpha.hp*1.15,y+45)
draw.Text(x+5,y+7,hp)
draw.Color(8,165,224,255)
draw.Text(x+155,y+7,armor)
draw.FilledRect(x+150,y+30,x+150+alpha2.armor*1.6,y+45)

draw.Color(4,4,4,255)
draw.Text(x+74,y+6,"HP")
draw.Text(x+224,y+6,"ARMOR")
draw.Color(255,255,255,255)
draw.Text(x+75,y+7,"HP")
draw.Text(x+225,y+7,"ARMOR")

draw.Color(4,4,4,255)
draw.OutlinedRect(x-1,y+30,x+115,y+45)
draw.OutlinedRect(x+149,y+30,x+310,y+45)
else
client.SetConVar("hidehud",0,true)
end

end
--callbacks
callbacks.Register("Draw",Ondarw)
--end
--

