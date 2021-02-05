-- Scraped by chicken
-- Author: QBER
-- Title [Release] AA Indicators of Zeus
-- Forum link https://aimware.net/forum/thread/87192

local show_menu = true
local show_indk = false



function AA_Indicators_Zeus()
	if show_menu then
	mgui.max_component(10,100)
	mgui.menu(300,340,165,250,"AA Indicators of Zeus",1)

	mgui.panel(10,15,135,230,"Settings AA Indicators",2,1)


	slider_int = mgui.slider(20,50,200,"Scale indicator","",15,10,1)

	mgui.label(20,98, "Position indicator",4,1)

	itembox_index,itembox_text = mgui.itembox(20,115,210,{"Top","Centet","Bottom"},2,5,1)

		checkbox_indk = mgui.checkbox(20,30,"Activate",false,3,1)
		if checkbox_indk == true then
			show_indk = true
		end
		if checkbox_indk == false then
			show_indk = false
		end
	mgui.menu_mouse(1)
	end
	if input.IsButtonPressed(36) then
		if show_menu then
			show_menu = false
		else
			show_menu = true
		end
	end
	if show_indk then
	show_indicators(slider_int,itembox_index)
	
	end
end

local pos_aa = 0

function show_indicators(scale,pos)
s_w,s_h = draw.GetScreenSize()

if pos == 1 then
cor_top = 200
end

if pos == 2 then
cor_top = s_h/2
end

if pos == 3 then
cor_top = s_h - 200
end

s_w,s_h = draw.GetScreenSize()
	draw.Color( 242, 242, 242, 200 )
	if input.IsButtonPressed(37) or pos_aa == 1 then
		draw.Color( 214, 54, 54, 200 )
		pos_aa = 1
		gui.SetValue( "rbot_antiaim_stand_real_add", 90 )
		gui.SetValue( "rbot_antiaim_stand_fake_add", -90 )
		gui.SetValue( "rbot_antiaim_move_real_add", 90 )
		gui.SetValue( "rbot_antiaim_move_fake_add", -90 )
		gui.SetValue( "rbot_antiaim_edge_real_add", -180 )
		gui.SetValue( "lbot_antiaim", 90 )
		gui.SetValue( "rbot_antiaim_edge_fake_add", 0 )
		gui.SetValue("rbot_antiaim_autodir", false);
	end	
	drawing.triangle(s_w/2-scale-20,cor_top,scale,4)
	draw.Color( 242, 242, 242, 200 )
	if input.IsButtonPressed(39) or pos_aa == 2 then
		draw.Color( 214, 54, 54, 200 )
		pos_aa = 2
		gui.SetValue( "rbot_antiaim_stand_real_add", -90 )
		gui.SetValue( "rbot_antiaim_stand_fake_add", 90 )
		gui.SetValue( "rbot_antiaim_move_real_add", -90 )
		gui.SetValue( "rbot_antiaim_move_fake_add", 90 )
		gui.SetValue( "rbot_antiaim_edge_real_add", -0 )
		gui.SetValue( "rbot_antiaim_edge_fake_add", 180 )
		gui.SetValue( "lbot_antiaim", 270 )
		gui.SetValue("rbot_antiaim_autodir", false);
	end
	drawing.triangle(s_w/2+scale+20,cor_top,scale,3)
	draw.Color( 242, 242, 242, 200 );
	if input.IsButtonPressed(40) or pos_aa == 3 then
		draw.Color( 214, 54, 54, 200 )
		pos_aa = 3
		gui.SetValue( "rbot_antiaim_stand_real_add", 0 )
		gui.SetValue( "rbot_antiaim_stand_fake_add", 0 )
		gui.SetValue( "rbot_antiaim_move_real_add", 0 )
		gui.SetValue( "rbot_antiaim_move_fake_add", 0 )
		gui.SetValue( "rbot_antiaim_edge_real_add", 0 )
		gui.SetValue( "rbot_antiaim_edge_fake_add", 0 )
		gui.SetValue( "lbot_antiaim", 180 )
		gui.SetValue("rbot_antiaim_autodir", false);
	end	
	drawing.triangle(s_w/2,cor_top+scale+20,scale,2)
	
	if input.IsButtonPressed(38) then
		pos_aa = 0
		gui.SetValue( "lbot_antiaim", 0 )
		gui.SetValue("rbot_antiaim_autodir", true);
	end	
end

RunScript( "mgui.lua" )
callbacks.Register( "Draw", "AA_Indicators_Zeus", AA_Indicators_Zeus );