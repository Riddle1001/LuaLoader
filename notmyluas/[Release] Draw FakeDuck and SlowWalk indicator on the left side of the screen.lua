-- Scraped by chicken
-- Author: Dajiba
-- Title [Release] Draw FakeDuck and SlowWalk indicator on the left side of the screen
-- Forum link https://aimware.net/forum/thread/109669

--------------------Draw Fake Duck
local font0 = draw.CreateFont('Verdana', 20, 700)
local FDKey=gui.GetValue("rbot_antiaim_fakeduck");
local function Main()
w, h = draw.GetScreenSize()
draw.SetFont(RenderFont)
draw.Color(112, 255, 0)
if input.IsButtonDown(FDKey) then
draw.SetFont(font0)
draw.Text(18, h - 447, "Fake Duck")
draw.TextShadow(18, h - 447, "Fake Duck")
else
draw.SetFont(font0)
draw.Color(255, 0, 0,255)
draw.Text(18, h - 447, "Fake Duck")
draw.TextShadow(18, h - 447, "Fake Duck")
end
end
callbacks.Register( "Draw", "FD", Main);

--------------------Draw Slow Wakl
local font1 = draw.CreateFont('Verdana', 20, 700)
local SWKey=gui.GetValue("msc_slowwalk");
local function Main()
w, h = draw.GetScreenSize()
draw.SetFont(RenderFont)
draw.Color(112, 255, 0)
if input.IsButtonDown(SWKey) then
draw.SetFont(font1)
draw.Text(18, h - 424, "Slow Walk")
draw.TextShadow(18, h - 424, "Slow Walk")
else
draw.SetFont(font1)
draw.Color(255, 0, 0,255)
draw.Text(18, h - 424, "Slow Walk")
draw.TextShadow(18, h - 424, "Slow Walk")
end
end
callbacks.Register( "Draw", "SW", Main);
--------------------------------------------------By An QQ 2926669800