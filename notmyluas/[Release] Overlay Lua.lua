-- Scraped by chicken
-- Author: zack
-- Title [Release] Overlay Lua
-- Forum link https://aimware.net/forum/thread/89246


--version 1
local abs_frame_time = globals.AbsoluteFrameTime;  local frame_rate = 0.0; local get_abs_fps = function() frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * abs_frame_time(); return math.floor((1.0 / frame_rate) + 0.5); end
function use_Crayon()
local ff = draw.CreateFont('Tahoma')
local name = client.GetPlayerNameByIndex(client.GetLocalPlayerIndex())
local x, y = draw.GetScreenSize()
local z, v, b, n = gui.GetValue('clr_gui_window_header_tab1');  local s, g, f, r = gui.GetValue('clr_gui_window_header_tab2'); local q, e, t, u = gui.GetValue('clr_gui_tablist4');   local h, a, o, i = gui.GetValue('clr_gui_text2');
--Back
draw.Color(s, g, f, r)
draw.FilledRect(0, 0, x, 44)
draw.Color(q, e, t, u)
draw.OutlinedRect(1,1,x - 1,43)
--welcome thing
draw.Color(z, v, b, n)
draw.FilledRect(8, 8, 150, 30)
draw.Color(q, e, t, u)
draw.OutlinedRect(7,7,149,29)
--
draw.Color(214,214,214, 255)
draw.Text(15, 12, "welcome back ")
draw.Color(149,189,54, 255)
draw.Text(95, 12, name)
-- back thing for time and fps
draw.Color(z, v, b, n)
draw.FilledRect(170, 8, 650, 30)
draw.Color(q, e, t, u)
draw.OutlinedRect(169,7,649,29)
-- os time
draw.Color(214,214,214, 255)
-- Tuesday, 10 October 2018 | 03:14:17 AM
draw.Text(190, 12 , os.date("%A, %d %B %Y | %I:%M:%S %p"))
--fps
draw.Color(214,214,214, 255)
draw.Text(550, 12, "fps: ".. get_abs_fps())
-- aw
local font = draw.CreateFont('Calibri', 40)
draw.SetFont(font)
draw.Color(h, a, o, i)
draw.Text((x / 2) - 70, -1, "AIM ")
draw.Color(q, e, t, u)
draw.Text((x / 2) - 14, -1, "WARE")
draw.Color(h, a, o, i)
draw.Text((x / 2) + 67, -1, ".NET")
draw.SetFont(ff)
end
callbacks.Register('Draw', 'use_Crayon', use_Crayon)



