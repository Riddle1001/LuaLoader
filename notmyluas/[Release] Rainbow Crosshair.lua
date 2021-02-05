-- Scraped by chicken
-- Author: gayware
-- Title [Release] Rainbow Crosshair
-- Forum link https://aimware.net/forum/thread/102578

--credit: Template taken from a lua pack coded by Spec122, thx guys from aimware.net forum, separate thanks Salvatore aka Legended and L3D451R7
--crosshair code by prost
frequency = 0.08 -- range: [0, oo) | lower is slower
intensity = 255 -- range: [0, 255] | lower is darker
saturation = 1 -- range: [0.00, 1.00] | lower is less saturated

client.Command("cl_crosshaircolor 5", true);
function hsvToR(h, s, v)
 local r, g, b

 local i = math.floor(h * 6);
 local f = h * 6 - i;
 local p = v * (1 - s);
 local q = v * (1 - f * s);
 local t = v * (1 - (1 - f) * s);

 i = i % 6

 if i == 0 then r, g, b = v, t, p
 elseif i == 1 then r, g, b = q, v, p
 elseif i == 2 then r, g, b = p, v, t
 elseif i == 3 then r, g, b = p, q, v
 elseif i == 4 then r, g, b = t, p, v
 elseif i == 5 then r, g, b = v, p, q
 end

 return r * intensity
end

function hsvToG(h, s, v)
 local r, g, b

 local i = math.floor(h * 6);
 local f = h * 6 - i;
 local p = v * (1 - s);
 local q = v * (1 - f * s);
 local t = v * (1 - (1 - f) * s);

 i = i % 6

 if i == 0 then r, g, b = v, t, p
 elseif i == 1 then r, g, b = q, v, p
 elseif i == 2 then r, g, b = p, v, t
 elseif i == 3 then r, g, b = p, q, v
 elseif i == 4 then r, g, b = t, p, v
 elseif i == 5 then r, g, b = v, p, q
 end

 return g * intensity
end

function hsvToB(h, s, v)
 local r, g, b

 local i = math.floor(h * 6);
 local f = h * 6 - i;
 local p = v * (1 - s);
 local q = v * (1 - f * s);
 local t = v * (1 - (1 - f) * s);

 i = i % 6

 if i == 0 then r, g, b = v, t, p
 elseif i == 1 then r, g, b = q, v, p
 elseif i == 2 then r, g, b = p, v, t
 elseif i == 3 then r, g, b = p, q, v
 elseif i == 4 then r, g, b = t, p, v
 elseif i == 5 then r, g, b = v, p, q
 end

 return b * intensity
end
function returnR(num)
 return "cl_crosshaircolor_r " .. num
end
function returnG(num)
 return "cl_crosshaircolor_g " .. num
end
function returnB(num)
 return "cl_crosshaircolor_b " .. num
end



function rainbowcolors()
  local R = math.ceil(hsvToR((globals.RealTime() * frequency) % 1, saturation, 1))
  local G = math.ceil(hsvToG((globals.RealTime() * frequency) % 1, saturation, 1))
  local B = math.ceil(hsvToB((globals.RealTime() * frequency) % 1, saturation, 1))

 client.Command(returnR(R), true);
 client.Command(returnG(G), true);
 client.Command(returnB(B), true);



end



callbacks.Register( "Draw", "xd", rainbowcolors);
