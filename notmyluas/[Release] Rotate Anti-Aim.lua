-- Scraped by chicken
-- Author: Wistlex
-- Title [Release] Rotate Anti-Aim
-- Forum link https://aimware.net/forum/thread/87854

slider_int = ""
edit_text = ""
msg_text = "Example Text"
itembox_index = 0
sfakei = 0
sreali = 0
mfakei = 0
mreali = 0
rotate = 90
drotate = 0
ccsreal = 0
crotate = gui.GetValue( "rbot_antiaim_stand_real_add")
crotate2 = gui.GetValue( "rbot_antiaim_move_real_add")
crotate3 = gui.GetValue( "rbot_antiaim_stand_fake_add")
crotate4 = gui.GetValue( "rbot_antiaim_move_fake_add")
RunScript( "mgui.lua" ) -- Library connections


function example()
mrotate = crotate + drotate
--NECESSARILY
mgui.max_component(10,100) -- The number of menus, Number of components
mgui.menu(300,340,450,250,"Rotate AA Settings",1)

mgui.panel(10,15,55,230,"Main",2,1)
mgui.panel(10,90,145,230,"Rotate AA",5,1)
mgui.panel(10,250,85,230,"Move Real Head Bind", 9,1)
hnrotate = mgui.slider(25,285,115,"New Angle after key pressed ","",0,11,1)
if mgui.button(25,30,28,200,"Update Angle",4,1) then
crotate = gui.GetValue( "rbot_antiaim_stand_real_add")
crotate2 = gui.GetValue( "rbot_antiaim_move_real_add")
crotate3 = gui.GetValue( "rbot_antiaim_stand_fake_add")
crotate4 = gui.GetValue( "rbot_antiaim_move_fake_add")
end

if mgui.bind_field(25,265,200,15,1) then
print ("Test 0")
if sreali == 1 then
sreali = 0
sreal2 = 0
ccsreal = 1
print ("Test 1")
end
gui.SetValue( "rbot_antiaim_stand_real_add", 90)
print ("Test 2")
if ccsreal == 1 then
ccsreal = 0
sreali = 1
sreal2 = 1
print ("Test 3")
end
print ("Test 4")
end


itembox_index,itembox_text = mgui.itembox(25,200,200,{"Off","Enabled"},1,14,1)
sreal2 = mgui.checkbox(25,110,"Stand Real",false,6,1)
sfake3 = mgui.checkbox(120,110,"Stand Fake",false,3,1)
mreal4 = mgui.checkbox(25,130,"Move Real",false,2,1)
mfake5 = mgui.checkbox(120,130,"Move Fake",false,1,1)
drotate = mgui.slider(25,150,115,"Rotate Angle"," ",35,10,1)
if sreal2 == true then
print("Stand Real Rotate AA Enabled")
sreali = 1
end
if sfake3 == false then
print("Stand Fake Rotate AA Disabled")
gui.SetValue( "rbot_antiaim_stand_fake_add", crotate3)
sfakei = 0
end
if sfake3 == true then
print("Stand Fake Rotate AA Enabled")
sfakei = 1
end
if sreal2 == false then
print("Stand Real Rotate AA Disabled")
gui.SetValue( "rbot_antiaim_stand_real_add", crotate)
sreali = 0
end
if mreal4 == true then
print("Move Real Rotate AA Enabled")
mreali = 1
end
if mreal4 == false then
print("Move Real Rotate AA Disabled")
gui.SetValue( "rbot_antiaim_move_real_add", crotate2)
mreali = 0
end
if mfake5 == true then																	
crotate4 = gui.GetValue( "rbot_antiaim_move_fake_add")
print("Move Fake Rotate AA Enabled")
mfakei = 1
end
if mfake5 == false then
print("Move Fake Rotate AA Disabled")
gui.SetValue( "rbot_antiaim_move_fake_add", crotate4)
mfakei = 0
end
if itembox_index == 2 then
rotate = rotate + 1.2
	if sreali == 1 then
		gui.SetValue( "rbot_antiaim_stand_real_add", crotate + rotate)
	end
	if mreali == 1 then
		gui.SetValue( "rbot_antiaim_move_real_add", crotate + rotate)
	end
	if mfakei == 1 then
		gui.SetValue( "rbot_antiaim_move_fake_add", crotate + rotate)
	end
	if sfakei == 1 then
		gui.SetValue( "rbot_antiaim_stand_fake_add", crotate + rotate)
	end
end
if rotate > mrotate then
rotate = 0
end




mgui.menu_mouse(1) -- If you need to move the menu with the mouse
mgui.msg_show() -- If you want to open dialog boxes
mgui.item_show() -- If there is an itembox component on the form, add this line
end

callbacks.Register( "Draw", "example", example );