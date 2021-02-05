-- Scraped by chicken
-- Author: sette
-- Title [Release] Viewmodel Changer, with floating point [V5]
-- Forum link https://aimware.net/forum/thread/127989

local client_GetConVar, client_SetConVar

local xO = 0.0; local yO = 0.0; local zO = 0.0; local fO = 0.0; 
local function cache()
 xO = (client.GetConVar("viewmodel_offset_x"))*1000.0;
 yO = (client.GetConVar("viewmodel_offset_y"))*1000.0;
 zO = (client.GetConVar("viewmodel_offset_z"))*1000.0;
 fO = (client.GetConVar("viewmodel_fov"))*1000.0;
end
cache()

local visref = gui.Reference( "MISC", "Part 1" ); 
local xS = gui.Slider(visref, "xS", "X", xO, -12000, 12000);
local yS = gui.Slider(visref, "yS", "Y", yO, -12000, 12000);
local zS = gui.Slider(visref, "zS", "Z", zO, -12000, 12000);
local vfov = gui.Slider(visref, "vfov", "Viewmodel FOV", fO, 50000, 120000);
--viewmodel_offset_x 2; viewmodel_offset_y 2; viewmodel_offset_z 2;

function doesthing()
 client.SetConVar("viewmodel_offset_x", xS:GetValue()/1000.0, true); 
 client.SetConVar("viewmodel_offset_y", yS:GetValue()/1000.0, true); 
 client.SetConVar("viewmodel_offset_z", zS:GetValue()/1000.0, true); 
 client.SetConVar("viewmodel_fov", vfov:GetValue()/1000.0, true);
end
callbacks.Register("Draw", "sets", doesthing);



