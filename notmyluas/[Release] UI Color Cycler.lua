-- Scraped by chicken
-- Author: thyrell
-- Title [Release] UI Color Cycler
-- Forum link https://aimware.net/forum/thread/101972

local elements = {
 {"gui_button_clicked", 255},
 {"gui_button_outline", 128},
 {"gui_checkbox_off", 128},
 {"gui_checkbox_off_hover", 175},
 {"gui_checkbox_on", 200},
 {"gui_checkbox_on_hover", 255},
 {"gui_combobox_drop1", 128},
 {"gui_combobox_drop2", 200},
 {"gui_combobox_drop3", 128},
 {"gui_listbox_select", 50},
 {"gui_slider_bar1", 50},
 {"gui_slider_bar2", 255},
 {"gui_slider_bar3", 128},
 {"gui_window_header", 225, 128},
 {"gui_window_header_tab1", 255, 255, -.1},
 {"gui_window_header_tab2", 255},
 {"gui_window_logo1", 255, 255, .1},
 {"gui_window_logo2", 255},
 {"gui_window_shadow", 255}
}

local p = math.pi*2

local function cycleColors()
 for n, e in ipairs(elements) do
 gui.SetValue("clr_"..e[1], --too lazy to type clr_ that many times lol
 math.floor( (math.sin(common.Time()+(e[4] or 0)*p)/2+.5) * (e[2] or 255)),
 math.floor( (math.sin(common.Time()+(e[4] or 0)*p+p/3)/2+.5) * (e[2] or 255)),
 math.floor( (math.sin(common.Time()+(e[4] or 0)*p+p*2/3)/2+.5) * (e[2] or 255)),
 (e[3] or 255)
 );
 end
end

callbacks.Register("Draw", cycleColors)

