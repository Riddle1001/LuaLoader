-- Scraped by chicken
-- Author: imabeanerboy
-- Title [Release] Rainbow ESP [EPIC]
-- Forum link https://aimware.net/forum/thread/86073

function rainbowesp() 
gui.SetValue( "clr_chams_ct_invis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_ct_vis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_weapon_primary", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_weapon_secondary", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_bar_ammo1", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_bar_ammo2", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_bar_armor1", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_bar_armor2", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_bar_health1", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_bar_health2", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_bar_lbytimer1", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_bar_lbytimer2", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_box_ct_invis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_ghost_fake", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_ghost_lby", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_hands_primary", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_hands_secondary", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_historyticks", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_other_invis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_other_vis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_t_invis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_chams_t_vis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_box_ct_vis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_box_other_invis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_box_other_vis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_box_t_invis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_box_t_vis", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_crosshair", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_crosshair_recoil", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_esp_outofview", math.random(255) ,math.random(255),math.random(255),255)
gui.SetValue( "clr_misc_hitmarker", math.random(255) ,math.random(255),math.random(255),255)
end

callbacks.Register( "Draw", "rainbowesp", rainbowesp);