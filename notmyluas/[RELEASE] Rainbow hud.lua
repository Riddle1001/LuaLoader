-- Scraped by chicken
-- Author: nezn9887
-- Title [RELEASE] Rainbow hud
-- Forum link https://aimware.net/forum/thread/140595

local colors = {
"cl_hud_color 1",
"cl_hud_color 2",
"cl_hud_color 3",
"cl_hud_color 4",
"cl_hud_color 5",
"cl_hud_color 6",
"cl_hud_color 7",
"cl_hud_color 8",
"cl_hud_color 9",
"cl_hud_color 10",
};

local colorChange = globals.TickCount()

local function hudColor()
  local colorspam = tostring(colors[math.random(#colors)]);
  if globals.TickCount() - colorChange > 12 then
    client.Command(colorspam)
    colorChange = globals.TickCount()
  end
end

callbacks.Register( "Draw", "hudColor", hudColor);