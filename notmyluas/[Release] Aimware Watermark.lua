-- Scraped by chicken
-- Author: mammrtvehootce
-- Title [Release] Aimware Watermark
-- Forum link https://aimware.net/forum/thread/100757

----- watermark lua for aimware by solo -----

local abs_frame_time = globals.AbsoluteFrameTime;   local frame_rate = 0.0; local get_abs_fps = function() frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * abs_frame_time(); return math.floor((1.0 / frame_rate) + 0.5); end
local ref = gui.Reference("MISC", "GENERAL", "Main");
local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 5, 10, 0, 0, 185, 35;
local shouldDrag = false;
local fontaw = draw.CreateFont("Verdana", 25, 25);
local fontinfo = draw.CreateFont("Verdana", 15, 15);
local awshow = gui.Checkbox( ref, "solo_wm_text", "Show watermark", false );
local wm_r = gui.Slider( ref, "solo_wm_customr", "Red", "%%", 1, 100)
local wm_g = gui.Slider( ref, "solo_wm_customg", "Green", "%%", 1, 100)
local wm_b = gui.Slider( ref, "solo_wm_customb", "Blue", "%%", 1, 100)

-- Draggable script by Ruppet
local function dragFeature()
  if input.IsButtonDown(1) then
    mouseX, mouseY = input.GetMousePos();
    if shouldDrag then
      x = mouseX - dx;
      y = mouseY - dy;
    end
    if mouseX >= x and mouseX <= x + w and mouseY >= y and mouseY <= y + 40 then
      shouldDrag = true;
      dx = mouseX - x;
      dy = mouseY - y;
    end
  else
    shouldDrag = false;
  end
end

local function drawWM()
local rw = wm_r:GetValue() * 2,5;
local gw = wm_g:GetValue() * 2,5;
local bw = wm_b:GetValue() * 2,5;
if entities.GetLocalPlayer() == nil then
   return
	 end
	 local m_iPing = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex())
   if awshow:GetValue() then
	 	draw.Color(35, 35, 35, 180)
    draw.FilledRect(x, y, x + w, y + h)
		draw.Color(0, 0, 0, 180)
		draw.OutlinedRect(x,y,x + w, y + h)
		draw.Color(60, 60, 60, 180)
		draw.OutlinedRect(x - 1,y - 1,x + w + 1, y + h + 1)
		draw.Color(80, 80, 80, 180)
		draw.OutlinedRect(x + 1,y + 1,x + w - 1, y + h - 1)
		draw.SetFont(fontaw)
		draw.Color(rw, gw, bw, 230)
		draw.Text(x + 5, y + 5, "AW")
		draw.SetFont(fontaw)
		draw.Color(255, 255, 255, 230)
		draw.Text(x + 40, y + 10, "^")
		draw.SetFont(fontinfo)
		draw.Color(rw, gw, bw, 230)
		draw.Text(x + 60, y + 12, get_abs_fps())
		draw.Color(255, 255, 255, 230)
		draw.Text(x + 85, y + 12, "fps")
		draw.SetFont(fontaw)
		draw.Text(x + 107, y + 10, "^")
		draw.SetFont(fontinfo)
		draw.Color(rw, gw, bw, 230)
		draw.Text(x + 127, y + 12, m_iPing)
		draw.Color(255, 255, 255, 230)
		draw.Text(x + 152, y + 12, "ping")
	 end
	 end
	 


callbacks.Register( "Draw", "Epic WATERMARK", drawWM );
callbacks.Register( "Draw", "drag", dragFeature );
