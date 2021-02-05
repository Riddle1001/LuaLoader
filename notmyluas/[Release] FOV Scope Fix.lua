-- Scraped by chicken
-- Author: 90D5p33D
-- Title [Release] FOV Scope Fix
-- Forum link https://aimware.net/forum/thread/139093

gui.Reference("Visuals","Local","Camera","ViewFOV"):SetInvisible(1)
gui.Reference("Visuals","Local","Camera","ViewmodelFOV"):SetInvisible(1)
localviewfovs=gui.Slider(gui.Reference("Visuals","Local","Camera"),"esp.local.fov.custom","ViewFOV",100,50,120)
localviewmodelfovs=gui.Slider(gui.Reference("Visuals","Local","Camera"),"esp.local.viewmodelfov.custom","ViewmodelFOV",54,40,90)
iFOV=90
vFOV=54
gui.SetValue("esp.local.fov",90)
gui.SetValue("esp.local.viewmodelfov",54)
oldv=gui.GetValue("esp.local.viewmodelfov")
oldi=gui.GetValue("esp.local.fov")
callbacks.Register("Draw",function()
ifnotentities.GetLocalPlayer()thenreturnend
ifnotentities.GetLocalPlayer():IsAlive()theniFOV=90vFOV=54returnend
ifentities.GetLocalPlayer():GetProp("m_bIsScoped")~=256andentities.GetLocalPlayer():GetProp("m_bIsScoped")~=0then
iFOV=90
vFOV=54
else
iFOV=viewfovs:GetValue()
vFOV=viewmodelfovs:GetValue()
end
gui.SetValue("esp.local.fov",iFOV)
gui.SetValue("esp.local.viewmodelfov",vFOV)
end)
callbacks.Register("Unload",function()
gui.Reference("Visuals","Local","Camera","ViewFOV"):SetInvisible(0)
gui.Reference("Visuals","Local","Camera","ViewmodelFOV"):SetInvisible(0)
iFOV=90
vFOV=54
viewfovs:SetValue(90)
viewmodelfovs:SetValue(54)
end)


