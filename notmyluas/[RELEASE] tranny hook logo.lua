-- Scraped by chicken
-- Author: nullflex
-- Title [RELEASE] tranny hook logo
-- Forum link https://aimware.net/forum/thread/86074

local name = 'bad and boujee hook';
local seperator = '|';
local fps = "fps";

local count = 0;
local last = globals.RealTime();
function get_fps()
	
	local now = globals.RealTime();
	
	local fps = 0;

	count = count + 1;

	if now - last > 1 then
		fps = count;
		count = 0;
		last = now;
		return fps;
	end

	return count;
end


function draw_logo( )
	draw.Color(110,110,110, 255)
	draw.FilledRect(5, 5, 245, 35)
	draw.Color(255, 255, 255, 255)
	draw.FilledRect(10, 10, 240, 30)
	draw.Color(0, 0, 0, 255)
	draw.Text(15, 15, name)
	draw.Text(137, 14, seperator)

	local fps_val = get_fps()

if fps_val<30 then
draw.Color(255, 0, 0, 255)
elseif fps_val<60 then
draw.Color(255, 255, 0, 255)
else
draw.Color(0, 255, 0, 255)
end
	
	draw.Text(143, 15, get_fps())
	draw.Text(165, 15, fps)
end

callbacks.Register( 'Draw', 'Logo', draw_logo );