-- Scraped by chicken
-- Author: JohnK.
-- Title [Release] Advanced Rainbow Configuration System
-- Forum link https://aimware.net/forum/thread/87823

local show_menu = true
local a = 0
local speed = 0
local rainbow = false
local handrainbow = false
local rainbowchams = false
local chams = false
local speed3 = 0
local rainbowguns = false
local speed5 = 0
local speed5s = 0
local speed7 = 0
local speed7s = 0
local syncrainbow = false

function Main()
 if show_menu then

 local am = 1000
 local bm = 340
 local cm = 450
 local dm = 600


 mgui.max_component(50, 100)
 mgui.menu(am, bm, cm, dm, "Rainbow Configuration System", 1)
 mgui.panel(10, 10, 190, 280, "General Settings", 19, 1)

 slider_int_1 = mgui.slider(20, 100, 255,255, "Alpha", "", 35, 13, 1)

 checkbox = mgui.checkbox(20, 30,30, "Activate", false, 19, 1)
 if checkbox == true then
 rainbow = true
 end
 if checkbox == false then
 rainbow = false
 end
 slider_int_2 = mgui.slider(20, 150, 100,30, "Speed", "", 15, 15, 1)


 checkbox = mgui.checkbox(120, 30,30, "Syncedrainbow", false, 31, 1)
 if checkbox == true then
 syncrainbow = true
 end
 if checkbox == false then
 syncrainbow = false
 end

 checkbox = mgui.checkbox(20, 70,30, "Switch-Alpha", false, 16, 1)
 if checkbox == true then
 rainbowalpha = true
 end
 if checkbox == false then
 rainbowalpha = false
 end

 checkbox = mgui.checkbox(120, 50,30, "Rainbow-Chams", false, 18, 1)
 if checkbox == true then
 rainbowchams = true
 end
 if checkbox == false then
 rainbowchams = false
 end

 checkbox = mgui.checkbox(120, 70,30, "Rainbow-Weapons", false, 25, 1)
 if checkbox == true then
 rainbowguns = true
 end
 if checkbox == false then
 rainbowguns = false
 end

 checkbox = mgui.checkbox(20, 50,30, "Rainbow-Hands", false, 17, 1)
 if checkbox == true then
 handrainbow = true
 end
 if checkbox == false then
 handrainbow = false
 end
 end




 if show_menu then

 --mgui.menu(1100, 340, 150, 300, "rainbowchams", 20)
 mgui.panel(300, 10, 190, 280, "Settings Chams", 21, 1)

 slider_int_3 = mgui.slider(310, 60, 255,255, "Alpha", "", 35, 22, 1)

 slider_int_4 = mgui.slider(310, 100, 100,30, "Speed", "", 15, 23, 1)

 checkbox = mgui.checkbox(310, 30,30, "Switch-Alpha", false, 24, 1)
 if checkbox == true then
 rainbowalphac = true
 end
 if checkbox == false then
 rainbowalphac = false
 end
 end




 if show_menu then

 -- mgui.menu(1100, 600, 150, 300, "Rainbow_weapon", 26)
 mgui.panel(10, 210, 230, 280, "Settings Weapons", 0, 1)

 slider_int_5 = mgui.slider(20, 260, 255,255, "Alpha Primary", "", 35, 28, 1)

 slider_int_6 = mgui.slider(20, 300, 100,30, "Speed Primary", "", 15, 29, 1)

 checkbox = mgui.checkbox(20, 230,30, "Switch-Alpha", false, 30, 1)
 if checkbox == true then
 rainbowalphag = true
 end
 if checkbox == false then
 rainbowalphag = false
 end

 slider_int_5s = mgui.slider(20, 340, 255,255, "Alpha Secondary", "", 35, 39, 1)

 slider_int_6s = mgui.slider(20, 380, 100,30, "Speed Secondary", "", 15, 40, 1)
 end
 if show_menu then

 -- mgui.menu(1400, 500, 150, 300, "rainbowhands", 32)
 mgui.panel(300, 210, 230, 280, "Settings Hands", 33, 1)

 slider_int_7 = mgui.slider(310, 260, 255,255, "Alpha Primary", "", 35, 34, 1)

 slider_int_8 = mgui.slider(310, 300, 100,30, "Speed Primary", "", 15, 35, 1)



 checkbox = mgui.checkbox(310, 230,30, "Switch-Alpha", false, 36, 1)
 if checkbox == true then
 rainbowalphah = true
 end
 if checkbox == false then
 rainbowalphah = false
 end

 slider_int_7s = mgui.slider(310, 340, 255,255, "Alpha Secondary", "", 35, 37, 1)

 slider_int_8s = mgui.slider(310, 380, 100,30, "Speed Secondary", "", 15, 38, 1)
 end



 if input.IsButtonPressed(36) then
 if show_menu then
 show_menu = false
 else
 show_menu = true
 end
 end

 mgui.menu_mouse(1)

 mgui.item_show()
end

function chams()
end

function rainbow_hands()

 if slider_int_2 ~= nil then
 speed = slider_int_2 * 0.2
 end


 if slider_int_4 ~= nil then
 speed3 = slider_int_4 * 0.2
 end

 if slider_int_6 ~= nil then
 speed5 = slider_int_6 * 0.2
 end

 if slider_int_6s ~= nil then
 speed5s = slider_int_6s * 0.2
 end


 if slider_int_8 ~= nil then
 speed7 = slider_int_8 * 0.2
 end

 if slider_int_8s ~= nil then
 speed7s = slider_int_8s * 0.2
 end

 if rainbow then


 if rainbowalpha then
 a = math.floor(math.sin(globals.RealTime() * speed + 4) * 120 + 129)
 else
 a = slider_int_1
 end


 if rainbowalphac then
 ac = math.floor(math.sin(globals.RealTime() * speed3 + 2) * 120 + 129)
 else
 if slider_int_3 ~= nil then
 ac = slider_int_3
 end
 end

 if rainbowalphag then
 ag = math.floor(math.sin(globals.RealTime() * speed5 + 2) * 120 + 129)
 ags = math.floor(math.sin(globals.RealTime() * speed5 + 2) * 120 + 129)
 else
 if slider_int_5 ~= nil then
 ag = slider_int_5
 end
 if slider_int_5s ~= nil then
 ags = slider_int_5s
 end
 end

 if rainbowalphah then
 ah = math.floor(math.sin(globals.RealTime() * speed7 + 2) * 120 + 129)
 ahs = math.floor(math.sin(globals.RealTime() * speed7 + 2) * 120 + 129)
 else
 if slider_int_7 ~= nil then
 ah = slider_int_7
 end

 if slider_int_7s ~= nil then
 ahs = slider_int_7s
 end
 end





 --print(a)


 local r = math.floor(math.sin(globals.RealTime() * speed) * 128 + 128)
 local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 128 + 128)
 local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 128 + 128)

 local speed2 = speed * 0.55
 local x = math.floor(math.sin(globals.RealTime() * speed2) * 127 + 128)
 local y = math.floor(math.sin(globals.RealTime() * speed2 + 2) * 127 + 128)
 local z = math.floor(math.sin(globals.RealTime() * speed2 + 4) * 127 + 128)


 local rc = math.floor(math.sin(globals.RealTime() * speed3) * 128 + 128)
 local gc = math.floor(math.sin(globals.RealTime() * speed3 + 2) * 128 + 128)
 local bc = math.floor(math.sin(globals.RealTime() * speed3 + 4) * 128 + 128)

  local speed3c = speed3*0.55
  local r1c = math.floor(math.sin(globals.RealTime() * speed3c) * 128 + 128)
 local g1c = math.floor(math.sin(globals.RealTime() * speed3c + 2) * 128 + 128)
 local b1c = math.floor(math.sin(globals.RealTime() * speed3c + 4) * 128 + 128)
  
  
 local rg = math.floor(math.sin(globals.RealTime() * speed5) * 128 + 128)
 local gg = math.floor(math.sin(globals.RealTime() * speed5 + 2) * 128 + 128)
 local bg = math.floor(math.sin(globals.RealTime() * speed5 + 4) * 128 + 128)

 local xg = math.floor(math.sin(globals.RealTime() * speed5s) * 127 + 128)
 local yg = math.floor(math.sin(globals.RealTime() * speed5s + 2) * 127 + 128)
 local zg = math.floor(math.sin(globals.RealTime() * speed5s + 4) * 127 + 128)

 local rh = math.floor(math.sin(globals.RealTime() * speed7) * 128 + 128)
 local gh = math.floor(math.sin(globals.RealTime() * speed7 + 2) * 128 + 128)
 local bh = math.floor(math.sin(globals.RealTime() * speed7 + 4) * 128 + 128)


 local xh = math.floor(math.sin(globals.RealTime() * speed7s) * 127 + 128)
 local yh = math.floor(math.sin(globals.RealTime() * speed7s + 2) * 127 + 128)
 local zh = math.floor(math.sin(globals.RealTime() * speed7s + 4) * 127 + 128)


 if syncrainbow then


 for k, v in pairs({
 "clr_chams_hands_primary",
 "clr_chams_ghost_fake",
 "clr_chams_t_vis",
 "clr_chams_t_invis",
 "clr_chams_ct_vis",
 "clr_chams_ct_invis",
 "clr_esp_box_ct_invis",
 "clr_esp_box_ct_vis",
 "clr_esp_box_t_invis",
 "clr_esp_box_t_vis",
 "clr_chams_weapon_secondary",
 "clr_chams_hands_secondary",
 "clr_chams_historyticks",
 "clr_chams_weapon_primary",
    "clr_esp_crosshair_recoil"
 }) do

 gui.SetValue(v, r, g, b, a)
 end
 end


 if handrainbow then


 for k1, v2 in pairs({
 "clr_chams_hands_primary"
 }) do

 gui.SetValue(v2, rh, gh, bh, ah)
 end
 gui.SetValue("clr_chams_hands_secondary", xh, yh, zh, ahs)
 end


 if rainbowguns then

 for l1, v1 in pairs({
 "clr_chams_weapon_primary"
 }) do

 gui.SetValue(v1, rg, gg, bg, ag)
 end

 gui.SetValue("clr_chams_weapon_secondary", xg, yg, zg, ags)
 end

 if rainbowchams then

 for l, n in pairs({
 "clr_chams_ghost_fake",
 "clr_chams_t_vis",
 "clr_chams_t_invis",
 "clr_chams_ct_vis",
 "clr_chams_ct_invis",
 "clr_esp_box_ct_invis",
 "clr_esp_box_ct_vis",
 "clr_esp_box_t_invis",
 "clr_esp_box_t_vis"
 }) do
 gui.SetValue(n, rc, gc, bc, ac)
 end
 gui.SetValue("clr_chams_historyticks", r1c, g1c, b1c, ac)
 end
 else
 end
end

RunScript("mgui.lua")
callbacks.Register("Draw", "Main", Main);
callbacks.Register("Draw", "chams", chams);

callbacks.Register("Draw", "rainbow_hands", rainbow_hands);





