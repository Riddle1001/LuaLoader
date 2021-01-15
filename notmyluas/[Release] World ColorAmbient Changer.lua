-- Scraped by chicken
-- Author: Spekbillen
-- Title [Release] World Color/Ambient Changer
-- Forum link https://aimware.net/forum/thread/133504

local ref = gui.Reference("Visuals", "World");
local worldcolorgroup = gui.Groupbox(ref, "World Color", 328, 220, 295, 50)
local worldcolortoggle = gui.Checkbox(worldcolorgroup, "worldcolor", "Custom World Color", false)
local controlR = gui.Slider(worldcolorgroup, "worldcolorr", "Color: Red", 0, - 100, 100);
local controlG = gui.Slider(worldcolorgroup, "worldcolorg", "Color: Green", 0, - 100, 100);
local controlB = gui.Slider(worldcolorgroup, "worldcolorb", "Color: Blue", 0, - 100, 100);
local ColorR local ColorG local ColorB
local function SetWorldColors()
 if worldcolortoggle:GetValue() then
  if(entities.GetLocalPlayer()) then
   if(controlR:GetValue() / 100 ~= ColorR) then
    client.SetConVar("mat_ambient_light_r", controlR:GetValue() / 100, true);
    ColorR = controlR:GetValue() / 100
   end
   if(controlG:GetValue() / 100 ~= ColorG) then
    client.SetConVar("mat_ambient_light_g", controlG:GetValue() / 100, true);
    ColorG = controlG:GetValue() / 100
   end
   if(controlB:GetValue() / 100 ~= ColorB) then
    client.SetConVar("mat_ambient_light_b", controlB:GetValue() / 100, true);
    ColorB = controlB:GetValue() / 100
   end
  end
 else
  if(entities.GetLocalPlayer()) then
   client.SetConVar("mat_ambient_light_r", 0, true);
   client.SetConVar("mat_ambient_light_g", 0, true);
   client.SetConVar("mat_ambient_light_b", 0, true);
  end
 end
end;
callbacks.Register("Draw", "SetWorldColors", SetWorldColors)