-- Scraped by chicken
-- Author: TooHypedUp
-- Title [Release] Rainbow menu
-- Forum link https://aimware.net/forum/thread/117472

function rainbowmenu() 

	local bla = 0
  local speed = 3
  local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
  local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
  local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
  local a = 255

  
  for k,v in pairs({ 
            "clr_gui_checkbox_off_hover",
            "clr_gui_checkbox_on",
            "clr_gui_checkbox_on_hover",
            "clr_gui_combobox_drop2",
            "clr_gui_combobox_drop3",
            "clr_gui_combobox_shadow",
            "clr_gui_controls1",
						"clr_gui_controls2",
						"clr_gui_controls3",
						"clr_gui_combobox_arrow",
						"clr_gui_button_hover",
						"clr_gui_button_idle",
						"clr_gui_button_outline",
						"clr_gui_groupbox_scroll",
						"clr_gui_groupbox_shadow",
						"clr_gui_slider_bar2",
						"clr_gui_slider_bar3",
						"clr_gui_slider_button",
						"clr_gui_listbox_scroll",
						"clr_gui_listbox_select",
						"clr_gui_listbox_active",
						"clr_gui_tablist2",
						"clr_gui_tablist3",
						"clr_gui_window_header_tab1",
						"clr_gui_window_header_tab2",
						"clr_gui_window_logo1",
						"clr_gui_tablist_shadow",
            "clr_gui_window_background",
            "clr_gui_window_footer",
            "clr_gui_hover",
            "clr_misc_hitmarker"}) do           
      gui.SetValue(v, r,g,b,a)

	 for k,x in pairs({
						 "clr_gui_window_footer_desc",
						 "clr_gui_window_footer_text",
	          "clr_gui_text1",
	          "clr_gui_button_clicked",
            "clr_gui_checkbox_off",
            "clr_gui_combobox_drop1",
            "clr_gui_groupbox_outline",
						 "clr_gui_window_header",
            "clr_gui_listbox_outline",
            "clr_gui_tablist1",
            "clr_gui_tablist4",
						 "clr_gui_text3",
						 "clr_gui_text2",
						 "clr_gui_window_logo2",
            "clr_gui_window_shadow"})do
			gui.SetValue(x, bla,bla,bla,255)


			for k,c in pairs({

 						 "clr_gui_listbox_background",   
            "clr_gui_groupbox_background"})do
			  gui.SetValue(c, 255, 255, 255, 255)

 end 
 end
 end
end

callbacks.Register( "Draw", "oops", rainbowmenu);