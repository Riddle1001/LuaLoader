-- Scraped by chicken
-- Author: LowKey
-- Title [Release] nxzMovement
-- Forum link https://aimware.net/forum/thread/147578

--[[shittymovementluamadeforbreezetix(breezysticks)
madebynaz#6660]]--

localui_keybox=gui.Keybox(gui.Reference("MISC","Movement","Jump"),"msc_movement_edge","eggbog",0)
localui_checkbox=gui.Checkbox(gui.Reference("MISC","Movement","Jump"),"misc.autojumpbug.scroll","FakeScrollOnJump-bugFail",false)
localmain_font=draw.CreateFont("Verdana",26)
localcombo=gui.Combobox(gui.Reference("MISC","Movement","Jump"),'msc_edgejump_vars','LongJumpType','Normal','LJBind-forward','LJBind-back','LJBind-moveleft','LJBind-moveright')
localljbind=gui.Checkbox(gui.Reference("MISC","Movement","Jump"),"lj_bind","LJBindEdgeJump",false)
localui_checkbox=gui.Checkbox(gui.Reference("Visuals","Other","Extra"),"lj_bind_status","LJBindStatus",false)
localvelocityInd=gui.Checkbox(gui.Reference("MISC","Movement","Jump"),"lj_bind","Velocityindicatoooooor",false)
localposSlider=gui.Slider(gui.Reference("MISC","Movement","Jump"),"pos1","velposx",940,0,1920)
localposSlider2=gui.Slider(gui.Reference("MISC","Movement","Jump"),"pos2","velposy",1000,0,1080)
localjumpshotcb=gui.Checkbox(gui.Reference("MISC","Movement","Jump"),"jsshit","jumpshotshit",false);
localgslider=gui.Slider(gui.Reference("MISC","Movement","Jump"),"groundhc","hitchanceonground",40,0,100)
localaslider=gui.Slider(gui.Reference("MISC","Movement","Jump"),"airhc","hitchanceinair",0,0,100)
ui_keybox:******")
ui_checkbox:******will)")
ljbind:SetDescription("Jumpfurtherwithafewmoreunitsofjumphight.")
jumpshotcb:SetDescription("Selfexplanitory")

localfunctionget_local_player()

localplayer=entities.GetLocalPlayer()

ifplayer==nilthenreturnend

if(notplayer:IsAlive())then

player=player:GetPropEntity("m_hObserverTarget")

end

returnplayer

end

localfunctionEDGEBUG_CREATEMOVE(UserCmd)

localflags=get_local_player():GetPropInt("m_fFlags")

ifflags==nilthenreturnend

localonground=bit.band(flags,1)~=0

ifui_keybox:GetValue()==0thenreturnend

ifongroundandinput.IsButtonDown(ui_keybox:GetValue())then

UserCmd:SetButtons(4)
return

end
end

ui_checkbox:******will)")

localfunctionget_local_player()

localplayer=entities.GetLocalPlayer()

ifplayer==nilthenreturnend

if(notplayer:IsAlive())then

player=player:GetPropEntity("m_hObserverTarget")

end

returnplayer

end

localfunctionJUMPBUG_SCROLL(UserCmd)

localflags=get_local_player():GetPropInt("m_fFlags")

ifflags==nilthenreturnend

localonground=bit.band(flags,1)~=0

ifongroundandinput.IsButtonDown(gui.GetValue("misc.autojumpbug"))then

UserCmd:SetButtons(4)
else
return

end
end


localedgejump=gui.GetValue("misc.edgejump");
callbacks.Register("CreateMove",function(cmd)

if(ljbind:GetValue()~=true)then
return
end
localflags=entities.GetLocalPlayer():GetPropInt("m_fFlags")
ifflags==nilthenreturnend

localonground=bit.band(flags,1)~=0


if(notongroundandinput.IsButtonDown(edgejump))then
cmd:SetButtons(86)
if(combo:GetValue()==0)then
return;
end
if(combo:GetValue()==1)then
client.Command("-forward",true)
end

if(combo:GetValue()==2)then
client.Command("-back",true)
end
if(combo:GetValue()==3)then
client.Command("-moveright",true)
end
if(combo:GetValue()==4)then
client.Command("-moveleft",true)
end
return
end

end)

callbacks.Register("Draw",function()
localx,y=draw.GetScreenSize()
localcenterX=x/2
locallp=entities.GetLocalPlayer()
localflags=entities.GetLocalPlayer():GetPropInt("m_fFlags")
ifflags==nilthenreturnend
localonground=bit.band(flags,1)~=0
draw.SetFont(main_font)
ifedgejump~=0andinput.IsButtonDown(edgejump)then
draw.Color(255,255,255,255)
draw.Text(centerX,y-150,"lj")
end
if(onground)thenreturn
end
ifedgejump~=0andinput.IsButtonDown(edgejump)then
draw.Color(30,255,109)
draw.Text(centerX,y-150,"lj")
end
end)


functionround(num,numDecimalPlaces)
localmult=10^(numDecimalPlacesor0)
ifnotentities.GetLocalPlayer()thenreturnend
ifnotentities.GetLocalPlayer():IsAlive()thenreturnend
returnmath.floor(num*mult+0.5)/mult
end


localfunctionveloc()
localVelocityX=entities.GetLocalPlayer():GetPropFloat("localdata","m_vecVelocity[0]")
localVelocityY=entities.GetLocalPlayer():GetPropFloat("localdata","m_vecVelocity[1]")
localVelocityZ=entities.GetLocalPlayer():GetPropFloat("localdata","m_vecVelocity[2]")
localspeed=math.sqrt(VelocityX^2+VelocityY^2)
draw.Color(200,30,30,255)
font=draw.CreateFont("Bahnschrift",30)
draw.SetFont(font)
ifvelocityInd:GetValue()==truethen
draw.Text(gui.GetValue("misc.pos1"),gui.GetValue("misc.pos2"),round(speed,0))
end
end

localfunctionjumpshot()
localflags=entities.GetLocalPlayer():GetPropInt("m_fFlags")
ifflags==nilthenreturnend
localonground=bit.band(flags,1)~=0
if(notongroundandjumpshotcb:GetValue()==true)then
gui.SetValue("rbot.accuracy.weapon.shared.hitchance",gui.GetValue("misc.airhc"))
else
gui.SetValue("rbot.accuracy.weapon.shared.hitchance",gui.GetValue("misc.groundhc"))
end
end

callbacks.Register("CreateMove",jumpshot)
callbacks.Register("CreateMove",EDGEBUG_CREATEMOVE)
callbacks.Register("Draw","EDGEBUG",DRAW_STATUS)
callbacks.Register("CreateMove",JUMPBUG_SCROLL)
callbacks.Register("Draw",veloc)



