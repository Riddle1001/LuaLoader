-- Scraped by chicken
-- Author: Clipper
-- Title [Release] Proper Nightmode
-- Forum link https://aimware.net/forum/thread/130762

--- Made by superyu'#7167
VALUE = gui.Slider(gui.Reference("Visuals", "World", "Materials"), "esp.world.materials.nightmode", "Nightmode", 0, 0, 100, 1);
APPLY = gui.Button(gui.Reference("Visuals", "World", "Materials"), "Apply Nightmode", function()
  local v = (100 - VALUE:GetValue()) / 100
  materials.Enumerate(function(mat)
    if string.find(mat:GetTextureGroupName(), "World") then
      mat:ColorModulate(v, v, v);
    end
  end)
end)
