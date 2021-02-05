-- Scraped by chicken
-- Author: Clipper
-- Title [Release] MolotovESP
-- Forum link https://aimware.net/forum/thread/120140

--- Made by Superyu'#7167
--- Feel free to make it better! :)

local enable = gui.Checkbox(gui.Reference("VISUALS", "OTHER", "Filter"), "esp_molotovesp", "Molotov ESP", 0) --- The Checkbox
local color = gui.ColorEntry("esp_molotovesp_circle_clr", "Molotov ESP", 255, 25, 25, 255 )
local colorCircle = gui.ColorEntry("esp_molotovesp_clr", "Molotov ESP Circle", 255, 25, 25, 255 )
local Molotovs = {} --- Molotov Object Table
client.AllowListener("inferno_startburn") --- The Listener

--- Get the Molotov data into a table.
callbacks.Register("FireGameEvent", function(event)

  if enable:GetValue() then --- Check if it's enabled.
    if event:GetName() == "inferno_startburn" then --- If the event is the "inferno_startburn" event then continue.

      local x, y, z = event:GetFloat("x"), event:GetFloat("y"), event:GetFloat("z") --- Get the Molotovs XYZ coordinates. 
      table.insert(Molotovs, {x,y,z,globals.CurTime()}) --- Insert coordinates into a table and the current time too.
    end
  end
end)

local function drawCircle(x, y, z, radius, thickness, quality) --- Made by RadicalMario
  local quality = quality or 20
  local thickness = thickness or 8
  local Screen_X_Line_Old, Screen_Y_Line_Old
  for rot = 0, 360, quality do
    local rot_temp = math.rad(rot)
    local LineX, LineY, LineZ = radius * math.cos(rot_temp) + x, radius * math.sin(rot_temp) + y, z
    local Screen_X_Line, Screen_Y_Line = client.WorldToScreen(LineX, LineY, LineZ)
    if Screen_X_Line ~= nil and Screen_X_Line_Old ~= nil then
      draw.SetFont(draw.CreateFont("Tahoma", 12));
      draw.Line(Screen_X_Line, Screen_Y_Line, Screen_X_Line_Old, Screen_Y_Line_Old)
      for i = 0, thickness do
        draw.Line(Screen_X_Line, Screen_Y_Line + i, Screen_X_Line_Old, Screen_Y_Line_Old + i)
      end
    end
    Screen_X_Line_Old, Screen_Y_Line_Old = Screen_X_Line, Screen_Y_Line
  end
end

callbacks.Register("Draw", function ()
  
  if enable:GetValue() then --- Check if it's enabled.

    local font = draw.CreateFont("Tahoma", 20, 250) --- Create the font.
    draw.SetFont(font) --- Set the created font for drawing.

    for k, v in pairs(Molotovs) do --- Iterate through the Mootov Object table.
      local w2sX, w2sY = client.WorldToScreen(Molotovs[k][1], Molotovs[k][2], Molotovs[k][3]) --- World to screen the coordinates of the current Molotov Object.
      if w2sX and w2sY then
        draw.Color(color:GetValue()) --- Set current drawing color to the color entry for the molotov esp.
        draw.Text(w2sX, w2sY, "Molotov") --- Draw the text at the world to screen position.
        draw.Color(colorCircle:GetValue()) --- Set current drawing color to the color entry for the molotov esp circle.
        drawCircle(Molotovs[k][1], Molotovs[k][2], Molotovs[k][3], 133, 1, 1) --- Draw Circle
        if Molotovs[k][4] <= globals.CurTime() - 7.03125 then --- If the table entry is older than the molotov burn time then...
          table.remove(Molotovs, k) --- remove the table entry.
        end
      end
    end
  end
end)