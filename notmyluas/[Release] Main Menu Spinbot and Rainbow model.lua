-- Scraped by chicken
-- Author: ShadyRetard
-- Title [Release] Main Menu Spinbot and Rainbow model
-- Forum link https://aimware.net/forum/thread/130789

--RetardedmenuspinbotbyShadyRetard

locallast_spinbot_speed=1
localrainbow_speed=0
localextra_reference=gui.Reference("Misc","General","Extra")
localspinbot_speed_slider=gui.Slider(extra_reference,"menu_spinbot_speed_slider","Menuspinbotspeed",0,-50,50,1)
localrainbow_speed_slider=gui.Slider(extra_reference,"menu_model_rainbow_speed_slider","Menumodelrainbowspeed",0,0,10,1)

panorama.RunScript([[
mainMenuSpinbot=undefined
mainMenuRainbow=undefined
vanityPanel.SetDirectionalLightAmount(0);
]])

panorama.RunScript([[
varvanityPanel=$.GetContextPanel().GetChild(0).FindChildInLayoutFile('JsMainmenu_Vanity');

varmenuSpinbotDegrees=0;
varmenuSpinbotSpeed=1

functionmainMenuSpinbot(){
menuSpinbotDegrees+=menuSpinbotSpeed/10;

if(menuSpinbotDegrees>360){
menuSpinbotDegrees=menuSpinbotDegrees-360;
}

vanityPanel.SetSceneAngles(0,menuSpinbotDegrees,0,0)

$.Schedule(0.01,menuSpinbot)
}

varmainMenuRainbowEnabled=false;
varrainbowSpeed=0;
varr=0.0;
varg=0.0;
varb=0.0;
varx=0.0;
vary=0.0;

functionmainMenuRainbow(){
if(rainbowSpeed>0){
if(y>=0&&y<255){
r=255;
g=0;
b=x;
}elseif(y>=255&&y<510){
r=255-x;
g=0;
b=255;
}elseif(y>=510&&y<765){
r=0;
g=x;
b=255;
}elseif(y>=765&&y<1020){
r=0;
g=255;
b=255-x;
}elseif(y>=1020&&y<1275){
r=x;
g=255;
b=0;
}elseif(y>=1275&&y<1530){
r=255;
g=255-x;
b=0;
}

x+=rainbowSpeed;
if(x>=255)
x=0;

y+=rainbowSpeed;
if(y>1530){
y=0;
}

vanityPanel.SetAmbientLightColor(r,g,b);
}
$.Schedule(0.01,mainMenuRainbow)
}

mainMenuRainbow();
mainMenuSpinbot();
]])

callbacks.Register("Draw",function()
localspinbot_speed_value=spinbot_speed_slider:GetValue()
if(spinbot_speed_value~=last_spinbot_speed)then
panorama.RunScript([[menuSpinbotSpeed=]]..spinbot_speed_value..[[;]])
last_spinbot_speed=spinbot_speed_value
end

localrainbow_speed_value=rainbow_speed_slider:GetValue()
if(rainbow_speed_value~=rainbow_speed)then
panorama.RunScript([[rainbowSpeed=]]..rainbow_speed_value..[[;]])
rainbow_speed=rainbow_speed_value
end
end)



