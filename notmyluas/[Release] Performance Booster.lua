-- Scraped by chicken
-- Author: Cheeseot
-- Title [Release] Performance Booster
-- Forum link https://aimware.net/forum/thread/133983

localwindow=gui.Window("rabisapaster.performance.window","PerformanceBooster",200,400,250,386)
localgroup=gui.Groupbox(window,"Settings",16,16,218,354)
localpostprocess=gui.Checkbox(group,"rabisapaster.performance.postprocess","DisablePostProcessing",0)
postprocess:SetDescription("Thisisalreadyapartofthecheat...")
localnoshadows=gui.Checkbox(group,"rabisapaster.performance.noshadows","DisableShadows",0)
noshadows:SetDescription("Theonlydecentoption")
localnosky=gui.Checkbox(group,"rabisapaster.performance.nosky","Disable3Dsky",0)
nosky:SetDescription("Thiswouldreducefps,soitdoes'twork")
localfpsboost=gui.Checkbox(group,"rabisapaster.performance.fpsboost","SmartFPSBooster",0)
fpsboost:SetDescription("There'snothingsmartaboutit")
localfpsslider=gui.Slider(group,"rabisapaster.performance.fpsslider","FPStomaintain",60,30,145,5)
fpsslider:SetDescription("Reallyonlyjusttry,thisisn'tmagic")
localmenuref=gui.Reference("MENU")

locallastpostprocess,lastnoshadows,active,lastfpsboost=nil,nil,false,nil

localfunctionconvars()

ifnoshadows:GetValue()then
client.SetConVar("r_shadows",0,true);
client.SetConVar("cl_csm_static_prop_shadows",0,true);
client.SetConVar("cl_csm_shadows",0,true);
client.SetConVar("cl_csm_world_shadows",0,true);
client.SetConVar("cl_foot_contact_shadows",0,true);
client.SetConVar("cl_csm_viewmodel_shadows",0,true);
client.SetConVar("cl_csm_rope_shadows",0,true);
client.SetConVar("cl_csm_sprite_shadows",0,true);
else
client.SetConVar("r_shadows",1,true);
client.SetConVar("cl_csm_static_prop_shadows",1,true);
client.SetConVar("cl_csm_shadows",1,true);
client.SetConVar("cl_csm_world_shadows",1,true);
client.SetConVar("cl_foot_contact_shadows",1,true);
client.SetConVar("cl_csm_viewmodel_shadows",1,true);
client.SetConVar("cl_csm_rope_shadows",1,true);
client.SetConVar("cl_csm_sprite_shadows",1,true);
end

ifpostprocess:GetValue()then
client.SetConVar("mat_postprocess_enable",0,true);
else
client.SetConVar("mat_postprocess_enable",1,true);
end

end

localtime=nil

localframe_rate=0.0
localfunctionget_abs_fps()
frame_rate=0.9*frame_rate+(1.0-0.9)*globals.AbsoluteFrameTime()
returnmath.floor((1.0/frame_rate)+0.5)
end

localfunctionondraw()

iflastfpsboost~=fpsboost:GetValue()then
lastfpsboost=fpsboost:GetValue()
iffpsboost:GetValue()then
fpsslider:SetDisabled(false)
else
fpsslider:SetDisabled(true)
end
end

ifnotactiveandmenuref:IsActive()then
window:SetActive(true)
active=true
elseifactiveandnotmenuref:IsActive()then
window:SetActive(false)
active=false
end

iftime==nilthen
time=globals.CurTime()
end

iflastpostprocess~=postprocess:GetValue()orlastnoshadows~=noshadows:GetValue()then
lastpostprocess=postprocess:GetValue()
lastnoshadows=noshadows:GetValue()
convars()
end

iffpsboost:GetValue()andglobals.CurTime()-time>=0.25then
localproctime=gui.GetValue("rbot.hitscan.maxprocessingtime")
print(proctime)
ifget_abs_fps()<fpsslider:GetValue()then
ifproctime>=10then
gui.SetValue("rbot.hitscan.maxprocessingtime",proctime-5)
end
elseifget_abs_fps()>fpsslider:GetValue()then
ifproctime<=70then
gui.SetValue("rbot.hitscan.maxprocessingtime",proctime+5)
end
end
time=nil
end
end

callbacks.Register("Draw",ondraw)

localfunctionevent(e)
ife:GetName()=="round_start"then
convars()
end
end

client.AllowListener("round_start")
callbacks.Register("FireGameEvent",event)

