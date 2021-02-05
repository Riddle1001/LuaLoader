-- Scraped by chicken
-- Author: senator
-- Title [Release] how to correctly calculate fps
-- Forum link https://aimware.net/forum/thread/86999

-- localisation
local abs_frame_time = globals.AbsoluteFrameTime;
local math_floor = math.floor;
local callbacks_register = callbacks.Register;
local draw_text = draw.Text;

-- globals
local frame_rate = 0.0; -- flt

-- referenced: https://github.com/ValveSoftware/******/vgui_netgraphpanel.cpp#L729-L744
local get_abs_fps = function()
	frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * abs_frame_time();
	return math_floor((1.0 / frame_rate) + 0.5);
end

callbacks_register("Draw", "test", function()
	draw_text(25, 25, "fps:" .. get_abs_fps());
end);
