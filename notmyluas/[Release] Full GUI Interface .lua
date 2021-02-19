-- Scraped by chicken
-- Author: QBER
-- Title [Release] Full GUI Interface 
-- Forum link https://aimware.net/forum/thread/87062

slider_int = ""
edit_text = ""
msg_text = "Example Text"
itembox_index = 0


function example()
--NECESSARILY
mgui.max_component(10,100) -- The number of menus, Number of components

mgui.menu(300,340,490,250,"Example Menu",1)

mgui.panel(10,15,55,230,"Example Panel 1",2,1)
mgui.panel(10,90,50,230,"Example Panel 2",5,1)
mgui.panel(10,160,70,230,edit_text,7,1)
mgui.panel(10,250,70,230,"Example Panel "..slider_int,9,1)
mgui.panel(10,340,70,230,"Example Panel "..itembox_index,12,1)
mgui.panel(10,425,50,230,"Example Panel 6",13,1)

if mgui.button(25,30,28,200,"Example Button",4,1) then
print("Button Click")
end

checkbox_bool = mgui.checkbox(25,105,200,"Example Checkbox",false,6,1)
if checkbox_bool == true then
print("CheckBox On")
end
if checkbox_bool == false then
print("CheckBox Off")
end

edit_text = mgui.edit(25,175,200,"Example Edit","Example Text",8,1)


slider_int = mgui.slider(25,265,200,10,"Example Slider","$",1,10,1)

if mgui.bind_field(25,440,200,"Example Bind",15,1) then
print("Key Pressed")
end

itembox_index,itembox_text = mgui.itembox(25,355,200,"Example ItemBox",{"item 1","item 2","item 3","item 4","item 5","item 6"},5,14,1)

mgui.menu_mouse(1) -- If you need to move the menu with the mouse
mgui.msg_show() -- If you want to open dialog boxes
mgui.item_show() -- If there is an itembox component on the form, add this line
end

RunScript( "mgui.lua" ) -- Library connections

callbacks.Register( "Draw", "example", example );