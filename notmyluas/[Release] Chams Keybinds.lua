-- Scraped by chicken
-- Author: usapude
-- Title [Release] Chams Keybinds
-- Forum link https://aimware.net/forum/thread/146935

-----------------------------------------------------------------------
---- For Problems or suggestions, contact me!           ----
---- Discord: Leshii#0975                     ----
-----------------------------------------------------------------------
local ref = gui.Tab(gui.Reference("Visuals"), "Wall Binds", "Binds");
gui.Text(ref, "Wall Binds")
local Off_Key = gui.Keybox(ref , "OffKey", "Off Key", 0)
local Occluded_Key = gui.Keybox(ref , "OccludedKey", "Occluded Key", 0)
local Visible_Key = gui.Keybox(ref , "VisibleKey", "Visible Key", 0)
local Left = true
local Off = true
local font = draw.CreateFont('Tahoma', 25, 100)

callbacks.Register( "Draw", function()
  draw.SetFont(font)
  draw.Color(128,0,0,255)
  if Occluded_Key:GetValue() ~= 0 then
    if input.IsButtonPressed(Occluded_Key:GetValue()) then
      Occluded = true
      Off = false
    end
  end
if Visible_Key:GetValue() ~= 0 then
    if input.IsButtonPressed(Visible_Key:GetValue()) then
      Occluded = false
      Off = false
    end
  end
  if Off_Key:GetValue() ~= 0 then
    if input.IsButtonPressed(Off_Key:GetValue()) then
      Off = true
      gui.SetValue("esp.chams.enemy.visible", 0)
      gui.SetValue("esp.chams.enemy.occluded", 0)
    end
  end
  if Occluded and not Off then
      gui.SetValue("esp.chams.enemy.visible", 0)
      gui.SetValue("esp.chams.enemy.occluded", 2)
  elseif not Occluded and not Off then
      gui.SetValue("esp.chams.enemy.visible", 2)
      gui.SetValue("esp.chams.enemy.occluded", 0)
  end
end)