-- Scraped by chicken
-- Author: Nexxed
-- Title [Release] NexUtils (301218)
-- Forum link https://aimware.net/forum/thread/88385

-- -- -- Tables -- -- --
NexUtils = {};
NexUtils.draw = {};
NexUtils.AntiAims = {};


-- -- -- Variables -- -- --
NexUtils.r,NexUtils.g,NexUtils.b,NexUtils.a = 0, 0, 0, 0; -- rainbow starting values
NexUtils.sw = 0; -- screen width
NexUtils.sh = 0; -- screen height
NexUtils.blockHeight = 0; -- spacing for listitems
NexUtils.numItems = 0; -- number of active listitems
NexUtils.frame_rate = 0.0 -- frame rate

-- -- -- Initialization -- -- --
-- randomize rainbow start values
NexUtils.randomRGB = function()
  local n = math.random(3);
  if(n == 1) then
    NexUtils.r = 255;
  elseif(n == 2) then
    NexUtils.g = 255;
  elseif(n == 3) then
    NexUtils.b = 255;
  end

  -- remove usage after initial run
  NexUtils.randomRGB = nil;
end
NexUtils.randomRGB();


NexUtils.log = function(type, text)
  local date = os.date("%d/%m/%y %H:%M:%S");
  if (type == "info") then
    print("[" .. date .. "] [INFO] " .. text);
  elseif (type == "debug" and NexUtils.debug == true) then
    print("[" .. date .. "] [DEBUG] " .. text);
  elseif (type == "warn") then
    print("[" .. date .. "] [WARN] " .. text);
  elseif (type == "error") then
    print("[" .. date .. "] [ERROR] " .. text);
  end
end

NexUtils.log("info", "-----------------------------------");
NexUtils.log("info", "----   N E X  U T I L S   ----");
NexUtils.log("info", "-----------------------------------");
NexUtils.log("info", "----   Version: v1.1.3   ----");
NexUtils.log("info", "----   Author: Nexxed   ----");
NexUtils.log("info", "---- Date: 30/Dec/2018 @ 19:00 ----");
NexUtils.log("info", "-----------------------------------");

-- -- -- Drawing Utils -- -- --

-- Credit: QBER
NexUtils.draw.Block = function(left, top, height, width)
  draw.FilledRect(left, top, left+width, top+height)
end

-- Credit: QBER
NexUtils.draw.BlockRound = function(left, top, height, width)
  draw.RoundedRectFill(left, top, left+width, top+height)
end

-- Credit: QBER
NexUtils.draw.Triangle = function(peak_left, peak_top, height, position)
  height_t = height
  left_l = peak_left
  left_r = peak_left
  top_l = peak_top
  top_r = peak_top

  if position == 1 then
    draw.Line(peak_left, peak_top, peak_left, peak_top-height)
  end
  if position == 2 then
    draw.Line(peak_left, peak_top, peak_left, peak_top+height)
  end
  if position == 3 then
    draw.Line(peak_left, peak_top, peak_left+height, peak_top)
  end
  if position == 4 then
    draw.Line(peak_left, peak_top, peak_left-height, peak_top)
  end
  
  for i = 1, 1000 do 
    height_t = height_t - 1
    left_l = left_l - 1
    left_r = left_r + 1
    top_l = top_l - 1
    top_r = top_r + 1
    if height_t < 0 then
      break
    end
    if position == 1 then
      draw.Line(left_l, peak_top-height_t, left_l, peak_top)
      draw.Line(left_r, peak_top-height_t, left_r, peak_top)
    end    
    if position == 2 then
      draw.Line(left_l, peak_top, left_l, peak_top+height_t)
      draw.Line(left_r, peak_top, left_r, peak_top+height_t)
    end      
    if position == 3 then
      draw.Line(peak_left, top_l, peak_left+height_t, top_l)
      draw.Line(peak_left, top_r, peak_left+height_t, top_r)
    end  
    if position == 4 then
      draw.Line(peak_left-height_t, top_l, peak_left, top_l)
      draw.Line(peak_left-height_t, top_r, peak_left, top_r)
    end  
  end
end

NexUtils.draw.TriangleOutline = function(peak_left, peak_top, color, outlineColor, size, outlineSize, direction)
  draw.Color(outlineColor[1], outlineColor[2], outlineColor[3], outlineColor[4]);
  NexUtils.draw.Triangle(peak_left, peak_top, size+outlineSize, direction)
  draw.Color(color[1], color[2], color[3], color[4]);
  NexUtils.draw.Triangle(peak_left, peak_top, size, direction)
end

-- Credit: QBER
NexUtils.draw.Line = function(left, top, angle, width)
  draw.Line(left, top, left+width, top+angle)
end

NexUtils.draw.VLine = function(left, top, angle, width, height, direction)
  for i = 0, height, 1 do
    if (direction == "up") then
      draw.Line(left, top-i, left+width, top+angle-i)
    elseif (direction == "down") then
      draw.Line(left, top+i, left+width, top+angle+i)
    end
  end
end

NexUtils.drawRainbow = function()
  if(NexUtils.r > 0 and NexUtils.b == 0) then
    NexUtils.r = NexUtils.r - 1;
    NexUtils.g = NexUtils.g + 1;
  end
  if(NexUtils.g > 0 and NexUtils.r == 0) then
    NexUtils.g = NexUtils.g - 1;
    NexUtils.b = NexUtils.b + 1;
  end
  if(NexUtils.b > 0 and NexUtils.g == 0) then
    NexUtils.b = NexUtils.b - 1;
    NexUtils.r = NexUtils.r + 1;
  end
end

NexUtils.drawWatermark = function(text, padding, exInfo)
  if (NexUtils.a ~= 200) then NexUtils.a = NexUtils.a + 1; end
  NexUtils.drawRainbow();

  tw,th = draw.GetTextSize(text);

  -- background
  draw.Color(0, 0, 0, NexUtils.a);
  NexUtils.draw.Block(NexUtils.sw-tw-25, th, th+padding, tw+padding);

  -- text
  draw.Color(NexUtils.r, NexUtils.g, NexUtils.b, NexUtils.a);
  draw.TextShadow(NexUtils.sw-tw-25+(padding/2), th+(padding/2), text);

  -- top border
  draw.Color(NexUtils.r, NexUtils.g, NexUtils.b, NexUtils.a);
  NexUtils.draw.VLine(NexUtils.sw-tw-25, th-0, 0, tw+padding, 3, "up");

  if (exInfo == true) then
    local tickrate = client.GetConVar("sv_maxupdaterate");
    local scaling = client.GetConVar("hud_scaling");
    local latency = 0;
    local fps = NexUtils.get_abs_fps();

    if (entities.GetLocalPlayer()) then
      latency = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex());
    else
      latency = 0;
    end

    local text = "FPS: ".. fps .."  Rate: ".. tickrate .."  RTT: "..latency.."ms";
    tw,th = draw.GetTextSize(text);

    -- background
    draw.Color(0, 0, 0, NexUtils.a);
    NexUtils.draw.Block(NexUtils.sw-tw-100, NexUtils.sh-th-75 * scaling-8, th+padding, tw+padding);

    -- text
    draw.Color(NexUtils.r, NexUtils.g, NexUtils.b, NexUtils.a);
    draw.TextShadow(NexUtils.sw-tw-100+(padding/2), NexUtils.sh-th-73 * scaling-8+(padding/2), text);

    -- top border
    draw.Color(NexUtils.r, NexUtils.g, NexUtils.b, NexUtils.a);
    NexUtils.draw.VLine(NexUtils.sw-tw-100, NexUtils.sh-th-75 * scaling-8, 0, tw+padding, 3, "down");
  end
end

NexUtils.drawTextBlock = function(left, top, text, shadow, textcolor, bgcolor, padding)
  tw,th = draw.GetTextSize(text);

  draw.Color(bgcolor[1], bgcolor[2], bgcolor[3], bgcolor[4]);
  NexUtils.draw.Block(left-tw-padding, top-th-padding, th+padding, tw+padding);

  draw.Color(textcolor[1], textcolor[2], textcolor[3], textcolor[4]);
  if (shadow == true) then
    draw.TextShadow(left-tw-(padding/2), top-th-(padding/2), text);
  elseif(shadow == false) then
    draw.Text(left+(padding/2), top+(padding/2), text);
  end
end

NexUtils.addListItem = function(key, value, keyColor, valueColor)
  draw.Color(20, 20, 20, 200);
  NexUtils.draw.Block(NexUtils.sw-180-5, NexUtils.blockHeight, 25, 180);

  draw.Color(keyColor[1], keyColor[2], keyColor[3], keyColor[4]);
  draw.TextShadow(NexUtils.sw-172, NexUtils.blockHeight+6, key);

  tw,th = draw.GetTextSize(value);

  draw.Color(valueColor[1], valueColor[2], valueColor[3], valueColor[4]);
  draw.TextShadow(NexUtils.sw-tw-20, NexUtils.blockHeight+6, value);

  NexUtils.numItems = NexUtils.numItems + 1;
  NexUtils.blockHeight = NexUtils.blockHeight + 25;
end

NexUtils.newFrame = function()
  NexUtils.sw,NexUtils.sh = draw.GetScreenSize();
  
  NexUtils.blockHeight = (NexUtils.sw/2)/2 + 25;
  NexUtils.numItems = 0;
end

-- Credit: Senator
NexUtils.get_abs_fps = function()
  NexUtils.frame_rate = 0.9 * NexUtils.frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime();
  return math.floor((1.0 / NexUtils.frame_rate) + 0.5)
end

NexUtils.AntiAims.SetLeft = function()
  gui.SetValue("rbot_antiaim_stand_real_add", -90);
  gui.SetValue("rbot_antiaim_move_real_add", -90);

  gui.SetValue("rbot_antiaim_autodir", 0);
end

NexUtils.AntiAims.SetRight = function()
  gui.SetValue("rbot_antiaim_stand_real_add", 90);
  gui.SetValue("rbot_antiaim_move_real_add", 90);

  gui.SetValue("rbot_antiaim_autodir", 0);
end

NexUtils.AntiAims.SetBack = function()
  gui.SetValue("rbot_antiaim_stand_real_add", 0);
  gui.SetValue("rbot_antiaim_move_real_add", 0);

  gui.SetValue("rbot_antiaim_autodir", 0);
end

NexUtils.AntiAims.SetForward = function()
  gui.SetValue("rbot_antiaim_stand_real_add", 180);
  gui.SetValue("rbot_antiaim_move_real_add", 180);

  gui.SetValue("rbot_antiaim_autodir", 0);
end

NexUtils.AntiAims.SetCustom = function(angle, stand, move)
  if (stand) then gui.SetValue("rbot_antiaim_stand_real_add", angle); end
  if (move) then gui.SetValue("rbot_antiaim_move_real_add", angle); end

  gui.SetValue("rbot_antiaim_autodir", 0);
end

NexUtils.AntiAims.SetAuto = function()
  gui.SetValue("rbot_antiaim_stand_real_add", 0);
  gui.SetValue("rbot_antiaim_move_real_add", 0);

  gui.SetValue("rbot_antiaim_autodir", 1);
end

NexUtils.AntiAims.SetDesync = function(s, m)
  gui.SetValue("rbot_antiaim_stand_desync", s);
  gui.SetValue("rbot_antiaim_move_desync", m);
end

NexUtils.GetLatencyColor = function(latency, type)
  local color = {};

  if (type == 0) then -- gui value (X.XXX)
    latency = tonumber(math.floor(latency * 1000));
  end

  if (latency <= 50) then
    color = {0, 255, 0, 255}; -- green
  elseif (latency <= 100) then
    color = {50, 255, 0, 255};
  elseif (latency <= 200) then
    color = {100, 255, 0, 255};
  elseif (latency <= 300) then
    color = {150, 255, 0, 255};
  elseif (latency <= 400) then
    color = {200, 255, 0, 255};
  elseif (latency <= 500) then
    color = {255, 255, 0, 255}; -- orange
  elseif (latency <= 600) then
    color = {255, 200, 0, 255}; 
  elseif (latency <= 700) then
    color = {255, 150, 0, 255};
  elseif (latency <= 800) then
    color = {255, 100, 0, 255};
  elseif (latency <= 900) then
    color = {255, 50, 0, 255};
  else
    color = {255, 0, 0, 255}; -- red
  end

  return color;
end

NexUtils.GetDistance = function(from, to)
  return math.sqrt(
    (select(1, to:GetAbsOrigin()) - select(1, from:GetAbsOrigin())) ^ 2 + 
    (select(2, to:GetAbsOrigin()) - select(2, from:GetAbsOrigin())) ^ 2 + 
    (select(3, to:GetAbsOrigin()) - select(3, from:GetAbsOrigin())) ^ 2);
end

NexUtils.GetBombDamage = function(Bomb, Player)
  local C4Distance = NexUtils.GetDistance(Player, Bomb);
  local Gauss = (C4Distance - 75.68) / 789.2
  local flDamage = 450.7 * math.exp(-Gauss * Gauss);

  if (Player:GetProp("m_ArmorValue") > 0) then
    local flArmorRatio = 0.5;
    local flArmorBonus = 0.5;

    if (Player:GetProp("m_ArmorValue") > 0) then
      local flNew = flDamage * flArmorRatio;
      local flArmor = (flDamage - flNew) * flArmorBonus;

      if (flArmor > Player:GetProp("m_ArmorValue")) then
        flArmor = Player:GetProp("m_ArmorValue") * (1 / flArmorBonus);
        flNew = flDamage - flArmor;
      end
      flDamage = flNew;
    end
  end
  return math.max(flDamage, 0);
end



