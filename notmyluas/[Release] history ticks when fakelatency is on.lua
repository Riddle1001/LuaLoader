-- Scraped by chicken
-- Author: gust1
-- Title [Release] history ticks when fakelatency is on
-- Forum link https://aimware.net/forum/thread/88276

local gui_set = gui.SetValue
local gui_get = gui.GetValue
function draw_ping()
local ping = gui_get("msc_fakelatency_enable");
if (ping) then
gui_set("vis_historyticks",2)
else
gui_set("vis_historyticks",0)
end
end
callbacks.Register('Draw', 'draw_ping', draw_ping)