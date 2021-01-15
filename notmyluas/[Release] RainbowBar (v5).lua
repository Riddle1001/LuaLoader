-- Scraped by chicken
-- Author: Exration
-- Title [Release] RainbowBar (v5)
-- Forum link https://aimware.net/forum/thread/127504

callbacks.Register("Draw", function()
  local screenSize = draw.GetScreenSize();
  local r = math.floor(math.sin(globals.RealTime() * 1) * 127 + 128);
  local g = math.floor(math.sin(globals.RealTime() * 1 + 2) * 127 + 128);
  local b = math.floor(math.sin(globals.RealTime() * 1 + 4) * 127 + 128);
 
  draw.Color(r, g, b, 255);
  draw.FilledRect(0, 0, screenSize, 5.5);
end)