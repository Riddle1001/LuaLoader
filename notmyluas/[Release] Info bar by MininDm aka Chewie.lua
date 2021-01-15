-- Scraped by chicken
-- Author: Chewie
-- Title [Release] Info bar by MininDm aka Chewie
-- Forum link https://aimware.net/forum/thread/89119

local frame_rate = 0.0
local get_abs_fps = function()
  frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
  return math.floor((1.0 / frame_rate) + 0.5)
end
local function setMath(int, max, declspec)
	local int = (int > max and max or int)

	local tmp = max / int;
	local i = (declspec / tmp)
	i = (i >= 0 and math.floor(i + 0.5) or math.ceil(i - 0.5))

	return i
end
function gradient(x1, y1, x2, y2, left)
  local w = x2 - x1
  local h = y2 - y1

  for i = 0, w do
    local a = (i / w) * 200

    draw.Color(0, 0, 0, a)
    if left then
      draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
    else
      draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
    end
  end
end
local function getColor(number, max)
	local r, g, b
	i = setMath(number, max, 9)

	if i <= 1 then r, g, b = 255, 0, 0
		elseif i == 2 then r, g, b = 237, 27, 3
		elseif i == 3 then r, g, b = 235, 63, 6
		elseif i == 4 then r, g, b = 229, 104, 8
		elseif i == 5 then r, g, b = 228, 126, 10
		elseif i == 6 then r, g, b = 220, 169, 16
		elseif i == 7 then r, g, b = 213, 201, 19
		elseif i == 8 then r, g, b = 176, 205, 10
		elseif i == 9 then r, g, b = 124, 195, 13
	end

	return r, g, b
end
local speed =0
function paint_traverse()
  local x, y = draw.GetScreenSize()
  local centerX = x / 2
 local latency=0;
	 if entities.FindByClass( "CBasePlayer" )[1] ~= nil then
 latency=entities.GetPlayerResources():GetPropInt( "m_iPing", client.GetLocalPlayerIndex() )
 end;
	 local rw,rh
  gradient(centerX - 200, y - 30, centerX - 51, y, 0, true)
  gradient(centerX - 200, y - 30, centerX - 51, y - 29, true)
  draw.Color(0, 0, 0, 200)
  draw.FilledRect(centerX - 50, y - 30, centerX + 70, y)
  draw.Color(0, 0, 0, 255)
  draw.FilledRect(centerX - 50, y - 30, centerX + 70, y - 29)
  gradient(centerX + 70, y - 30, centerX + 200, y, false)
  gradient(centerX + 70, y - 30, centerX + 200, y - 29, false)
	local r, g, b = getColor(get_abs_fps(), 100)
  draw.Color(r, g, b, 255)
	 rw,rh =draw.GetTextSize(get_abs_fps())
  draw.Text(centerX - 1 -(rw/2), y - 20, get_abs_fps()) 
  draw.Text(centerX + 1+ (rw/2), y - 20, "fps")
	r,g,b=getColor(latency,700)
  draw.Color(r, g, b, 255)
	rw,rh =draw.GetTextSize(latency)
  draw.Text(centerX - 80-(rw/2), y - 20, latency)
  draw.Text(centerX - 78+(rw/2), y - 20, "ping")
  draw.Color(255, 255, 255, 255)
  if entities.GetLocalPlayer() ~= nil then

    local Entity = entities.GetLocalPlayer();
    local Alive = Entity:IsAlive();
    local velocityX = Entity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
    local velocityY = Entity:GetPropFloat( "localdata", "m_vecVelocity[1]" );
    local velocity = math.sqrt( velocityX^2 + velocityY^2 );
    local FinalVelocity = math.min( 9999, velocity ) + 0.2;
    draw.Color( 255, 255, 255, 255 );
    if ( Alive == true ) then
     speed= math.floor(FinalVelocity) ;
    else
     speed=0;
    end
  end
	rw,rh =draw.GetTextSize(speed)
  draw.Text(centerX + 73-(rw/2), y - 20, speed) 
  draw.Text(centerX + 75+(rw/2), y - 20, "speed")

end

callbacks.Register("Draw", "paint_traverse", paint_traverse)