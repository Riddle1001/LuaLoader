-- Scraped by chicken
-- Author: xwk1337
-- Title [Release] UpperHook - Semirage Helper
-- Forum link https://aimware.net/forum/thread/148158




--{shitsemiragehelpercreatedbyxwk1337}--
localfont=draw.CreateFont("MicrosoftTaiLe",32,1000);
localfont1=draw.CreateFont("Verdana",22,400);
localref=gui.Reference("Ragebot");
localtab=gui.Tab(ref,"upper","UpperHook");
localscreen_w,screen_h=draw.GetScreenSize();

localmain_box=gui.Groupbox(tab,"Main",16,16,200,0);
localmain_customsc=gui.Checkbox(main_box,"main.newscope","CustomScope",false);
localmain_forcech=gui.Checkbox(main_box,"main.forcech","ForceCrossHair",false);
localmain_unlockinv=gui.Checkbox(main_box,"main.unlockinv","UnlockInventory",false);
localmain_fixrevolver=gui.Checkbox(main_box,"main.fixrevolver","DisableFLWithRevolver",false);
localmain_clr=gui.ColorPicker(main_box,"main.color","AccentColor",255,130,255,255);

locallegit_aa_box=gui.Groupbox(tab,"LegitAnti-Aim",232,16,200,0);
locallegit_aa_enable=gui.Checkbox(legit_aa_box,"aa.enable","Enable",false);
locallegit_aa_dis_on_fd=gui.Checkbox(legit_aa_box,"aa.disonfd","DisableOnFD",false);
locallegit_aa_type=gui.Combobox(legit_aa_box,"aa.type","DeSyncType","Default","Low");
locallegit_aa_key=gui.Keybox(legit_aa_box,"aa.inverter","Inverter",0);

localswitch_box=gui.Groupbox(tab,"Switch",448,16,174,0);
localswitch_enable=gui.Checkbox(switch_box,"switch.enable","Enable",false);
localswitch_fbaim_key=gui.Keybox(switch_box,"switch.force","ForceBaim",0);
localswitch_awall_key=gui.Keybox(switch_box,"switch.autowall","AutoWall",0);

localdynamic_box=gui.Groupbox(tab,"DynamicFov",232,264,200,0);
localdynamic_enable=gui.Checkbox(dynamic_box,"dynamic.enable","Enable",false);
localdynamic_min_slider=gui.Slider(dynamic_box,"dynamic.min","FovMin",9,1,30);
localdynamic_max_slider=gui.Slider(dynamic_box,"dynamic.max","FovMax",15,1,30);

localview_model_box=gui.Groupbox(tab,"ViewModel",448,227,174,0);
localview_model_aspect=gui.Slider(view_model_box,"model.aspect","AspectRatio",0,0,18);
localview_model_x=gui.Slider(view_model_box,"model.x","OffsetX",1,-40,40);
localview_model_y=gui.Slider(view_model_box,"model.y","OffsetY",1,-40,40);
localview_model_z=gui.Slider(view_model_box,"model.z","OffsetZ",-1,-40,40);

localaspect_table={0,2.0,1.9,1.8,1.7,1.6,1.5,1.4,1.3,1.2,1.1,1.0,0.9,0.8,0.7,0.6,0.5,0.4,0.3};
localweapons_table={"asniper","hpistol","lmg","pistol","rifle","scout","smg","shotgun","sniper","zeus",
"shared"};
localaa_side=false;
localswitch_fbaim=false;
localswitch_awall=false;
localfakeducking=false;
localtime=0.0;

localfunctionrect(x,y,w,h,col)
draw.Color(col[1],col[2],col[3],col[4]);
draw.FilledRect(x,y,x+w,y+h);
end

localfunctiongradient_h(x1,y1,x2,y2,col1,left)
localw=x2-x1;
localh=y2-y1;

fori=0,wdo
locala=(i/w)*200;
localr,g,b=col1[1],col1[2],col1[3];
draw.Color(r,g,b,a);
ifleftthen
draw.FilledRect(x1+i,y1,x1+i+1,y1+h);
else
draw.FilledRect(x1+w-i,y1,x1+w-i+1,y1+h);
end
end
end

localfunctiongradient_v(x,y,w,h,col1,col2,down)
rect(x,y,w,h,col1);

localr,g,b=col2[1],col2[2],col2[3];

fori=1,hdo
locala=i/h*255;
ifdownthen
rect(x,y+i,w,1,{r,g,b,a});
else
rect(x,y-i,w,1,{r,g,b,a});
end
end
end

localfunctioncheck(option)
ifnotoption:GetValue()then
returnfalse;
end
ifnotgui.GetValue("rbot.master")then
returnfalse;
end
locallc=entities.GetLocalPlayer();
ifnotlcornotlc:IsAlive()then
returnfalse;
end
returntrue;
end

localfunctionget_weapon_class(lp)
localweapon_id=lp:GetWeaponID();

ifweapon_id==11orweapon_id==38then
return"asniper";
elseifweapon_id==1orweapon_id==64then
return"hpistol";
elseifweapon_id==14orweapon_id==28then
return"lmg";
elseifweapon_id==2orweapon_id==3orweapon_id==4orweapon_id==30orweapon_id==32orweapon_id==36orweapon_id==61orweapon_id==63then
return"pistol";
elseifweapon_id==7orweapon_id==8orweapon_id==10orweapon_id==13orweapon_id==16orweapon_id==39orweapon_id==60then
return"rifle";
elseifweapon_id==40then
return"scout";
elseifweapon_id==17orweapon_id==19orweapon_id==23orweapon_id==24orweapon_id==26orweapon_id==33orweapon_id==34then
return"smg";
elseifweapon_id==25orweapon_id==27orweapon_id==29orweapon_id==35then
return"shotgun";
elseifweapon_id==9then
return"sniper";
elseifweapon_id==31then
return"zeus";
end

return"shared";
end

localfunctionantiaim()
ifnotcheck(legit_aa_enable)then
return;
end

iflegit_aa_enable:GetValue()andnotfakeduckingthen
draw.SetFont(font);
ifgui.GetValue("rbot.antiaim.base.lby")==-120then
draw.Color(255,255,255,255);
draw.TextShadow(screen_w/2-148,screen_h/2-10,"⮜");
draw.Color(main_clr:GetValue());
draw.TextShadow(screen_w/2+132,screen_h/2-10,"⮞");
elseifgui.GetValue("rbot.antiaim.base.lby")==120then
draw.Color(main_clr:GetValue());
draw.TextShadow(screen_w/2-148,screen_h/2-10,"⮜");
draw.Color(255,255,255,255);
draw.TextShadow(screen_w/2+132,screen_h/2-10,"⮞");
end
end

iffakeduckingthen
gui.SetValue("rbot.antiaim.base","0.0Off");
return;
end

gui.SetValue("rbot.antiaim.base","0.0Desync");
gui.SetValue("rbot.antiaim.advanced.pitch",0);
gui.SetValue("rbot.antiaim.advanced.autodir.edges",0);
gui.SetValue("rbot.antiaim.advanced.autodir.targets",0);

iflegit_aa_key:GetValue()~=0then
ifinput.IsButtonPressed(legit_aa_key:GetValue())then
ifnotaa_sidethen
iflegit_aa_type:GetValue()==0then
gui.SetValue("rbot.antiaim.base.rotation",-58);
elseiflegit_aa_type:GetValue()==1then
gui.SetValue("rbot.antiaim.base.rotation",-35);
end
gui.SetValue("rbot.antiaim.base.lby",120);
aa_side=true;
else
iflegit_aa_type:GetValue()==0then
gui.SetValue("rbot.antiaim.base.rotation",58);
elseiflegit_aa_type:GetValue()==1then
gui.SetValue("rbot.antiaim.base.rotation",35);
end
gui.SetValue("rbot.antiaim.base.lby",-120);
aa_side=false;
end
end
end
end

localfunctiondynamic()
ifnotcheck(dynamic_enable)then
return;
end

ifdynamic_min_slider:GetValue()>dynamic_max_slider:GetValue()then
return;
end

ifmath.abs(globals.CurTime()-time)>1then
gui.SetValue("rbot.aim.target.fov",math.random(dynamic_min_slider:GetValue(),dynamic_max_slider:GetValue()));
time=globals.CurTime();
end
end

localfunctionswitch()

locallc=entities.GetLocalPlayer();
iflcandlc:IsAlive()then
draw.SetFont(font1);

draw.Color(255,255,255,255);
draw.Text(screen_w/2-883,screen_h/2,"Fov:");
draw.Text(screen_w/2-927,screen_h/2+20,"Damage:");
draw.Text(screen_w/2-928,screen_h/2+40,"Autowall:");
draw.Text(screen_w/2-945,screen_h/2+60,"Forcebaim:");
draw.Text(screen_w/2-930,screen_h/2+80,"Resolver:");
draw.Text(screen_w/2-931,screen_h/2+100,"Accuracy:");

draw.Color(main_clr:GetValue());
draw.Text(screen_w/2-833,screen_h/2,gui.GetValue("rbot.aim.target.fov"));

draw.Text(screen_w/2-833,screen_h/2+20,gui.GetValue("rbot.accuracy.weapon."..get_weapon_class(lc)..".mindmg"));

ifswitch_awallthen
draw.Color(0,255,0,255);
draw.Text(screen_w/2-833,screen_h/2+40,"On");
else
draw.Color(255,0,0,255);
draw.Text(screen_w/2-833,screen_h/2+40,"Off");
end

ifswitch_fbaimthen
draw.Color(0,255,0,255);
draw.Text(screen_w/2-833,screen_h/2+60,"On");
else
draw.Color(255,0,0,255);
draw.Text(screen_w/2-833,screen_h/2+60,"Off");
end

ifgui.GetValue("rbot.accuracy.posadj.resolver")then
draw.Color(0,255,0,255);
draw.Text(screen_w/2-833,screen_h/2+80,"On");
else
draw.Color(255,0,0,255);
draw.Text(screen_w/2-833,screen_h/2+80,"Off");
end

localaccuracy=100-math.floor(entities.GetLocalPlayer():GetWeaponInaccuracy()*10^3+0.5)/10^3*100;

ifaccuracy>90then
draw.Color(0,255,0,255);
draw.Text(screen_w/2-833,screen_h/2+100,"High");
else
draw.Color(255,0,0,255);
draw.Text(screen_w/2-833,screen_h/2+100,"Low");
end
end

ifnotcheck(switch_enable)then
return;
end

ifswitch_fbaim_key:GetValue()~=0then
ifinput.IsButtonPressed(switch_fbaim_key:GetValue())then
ifnotswitch_fbaimthen
fori,vinnext,weapons_tabledo
gui.SetValue("rbot.hitscan.mode."..v..".bodyaim.force",1);
end
switch_fbaim=true;
else
fori,vinnext,weapons_tabledo
gui.SetValue("rbot.hitscan.mode."..v..".bodyaim.force",0);
end
switch_fbaim=false;
end
end
end

ifswitch_awall_key:GetValue()~=0then
ifinput.IsButtonPressed(switch_awall_key:GetValue())then
ifnotswitch_awallthen
fori,vinnext,weapons_tabledo
gui.SetValue("rbot.hitscan.mode."..v..".autowall",1);
end
switch_awall=true;
else
fori,vinnext,weapons_tabledo
gui.SetValue("rbot.hitscan.mode."..v..".autowall",0);
end
switch_awall=false;
end
end
end
end

localfunctionviewmodel()
ifnotgui.GetValue("rbot.master")then
return;
end

locallc=entities.GetLocalPlayer();
ifnotlcornotlc:IsAlive()then
return;
end

client.SetConVar("r_aspectratio",aspect_table[view_model_aspect:GetValue()+1],true);
client.SetConVar("viewmodel_offset_x",view_model_x:GetValue(),true);
client.SetConVar("viewmodel_offset_y",view_model_y:GetValue(),true);
client.SetConVar("viewmodel_offset_z",view_model_z:GetValue(),true);
end

localfunctionmain()
iflegit_aa_dis_on_fd:GetValue()then
localfdvalue=gui.GetValue("rbot.antiaim.extra.fakecrouchkey");
iffdvalue~=0then
ifinput.IsButtonDown(fdvalue)then
fakeducking=true;
else
fakeducking=false;
end
end
else
fakeducking=false;
end

ifcheck(main_fixrevolver)then
localweaponid=entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetWeaponID();

ifweaponid==64then
gui.SetValue("misc.fakelag.enable",false);
else
gui.SetValue("misc.fakelag.enable",true);
end
end

ifcheck(main_customsc)then
localscoped=entities.GetLocalPlayer():GetPropBool("m_bIsScoped");
localr,g,b,a=main_clr:GetValue();

gui.SetValue("esp.other.noscopeoverlay",false);
gui.SetValue("esp.other.crosshair",false);

ifscopedthen
gradient_h(screen_w/2,screen_h/2,screen_w/2+130,screen_h/2-1,{r,g,b,a},true);
gradient_h(screen_w/2-130,screen_h/2,screen_w/2,screen_h/2-1,{r,g,b,a},false);
gradient_v(screen_w/2,screen_h/2,1,130,{255,255,255,0},{r,g,b,a},true);
gradient_v(screen_w/2,screen_h/2,1,130,{255,255,255,0},{r,g,b,a},false);
client.SetConVar("r_drawvgui","0",true);
else
client.SetConVar("r_drawvgui","1",true);
end
else
client.SetConVar("r_drawvgui","1",true);
end

ifcheck(main_forcech)then
client.SetConVar("weapon_debug_spread_show",3,true);
else
client.SetConVar("weapon_debug_spread_show",0,true);
end

ifcheck(main_unlockinv)then
panorama.RunScript([[LoadoutAPI.IsLoadoutAllowed=()=>{returntrue;};]]);
end
end

callbacks.Register("Draw","legit_aa",antiaim);
callbacks.Register("Draw","dynamic_fov",dynamic);
callbacks.Register("Draw","switch",switch);
callbacks.Register("Draw","view_model",viewmodel);
callbacks.Register("Draw","defaults",main);


