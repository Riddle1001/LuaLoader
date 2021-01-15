-- Scraped by chicken
-- Author: imacookie
-- Title [Release] Nice looking rainbow ESP
-- Forum link https://aimware.net/forum/thread/86086

function rainbowesp()

 local speed = 3
 local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
 local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
 local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
 local a = 255
 
 for k,v in pairs({ "clr_chams_ct_invis",
 "clr_chams_ct_vis",
 "clr_chams_weapon_primary",
 "clr_chams_weapon_secondary",
 "clr_esp_bar_ammo1",
 "clr_esp_bar_ammo2",
 "clr_esp_bar_armor1",
 "clr_esp_bar_armor2",
 "clr_esp_bar_health1",
 "clr_esp_bar_health2",
 "clr_esp_bar_lbytimer1",
 "clr_esp_bar_lbytimer2",
 "clr_esp_box_ct_invis",
 "clr_chams_ghost_fake",
 "clr_chams_ghost_lby",
 "clr_chams_hands_primary",
 "clr_chams_hands_secondary",
 "clr_chams_historyticks",
 "clr_chams_other_invis",
 "clr_chams_other_vis",
 "clr_chams_t_invis",
 "clr_chams_t_vis",
 "clr_esp_box_ct_vis",
 "clr_esp_box_other_invis",
 "clr_esp_box_other_vis",
 "clr_esp_box_t_invis",
 "clr_esp_box_t_vis",
 "clr_esp_crosshair",
 "clr_esp_crosshair_recoil",
 "clr_esp_outofview",
 "clr_misc_hitmarker"}) do
 
 gui.SetValue(v, r,g,b,a)
 
 end
end

callbacks.Register( "Draw", "owo", rainbowesp);