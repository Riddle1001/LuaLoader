-- Scraped by chicken
-- Author: Exration
-- Title [Release] FOV Changer [V5]
-- Forum link https://aimware.net/forum/thread/127512

local xO = 0; local yO = 0; local zO = 0; local fO = 0; 
local function cache() xO = client.GetConVar("viewmodel_offset_x"); yO = client.GetConVar("viewmodel_offset_y"); zO = client.GetConVar("viewmodel_offset_z"); fO = client.GetConVar("viewmodel_fov"); end cache()
local visref = gui.Reference("SETTINGS", "Miscellaneous"); 
local wind = gui.Window("wind", "Viewmodel Extender", 200,200,200,290);
local gr = gui.Groupbox(wind, "Viewmodel Stuff", 10,10, 180,218)
local c = gui.Checkbox(visref, "c", "Show Viewmodel Extender", false)
local xS = gui.Slider(gr, "xS", "X", xO, -20, 20); 
local yS = gui.Slider(gr, "yS", "Y", yO, -100, 100); 
local zS = gui.Slider(gr, "zS", "Z", zO, -20, 20); 
local vfov = gui.Slider(gr, "vfov", "Viewmodel FOV", fO, 0, 120); 

function doesthing()
if c:GetValue() then wind:SetActive(1); else wind:SetActive(0); end
client.SetConVar("viewmodel_offset_x", xS:GetValue(), true); 
client.SetConVar("viewmodel_offset_y", yS:GetValue(), true); 
client.SetConVar("viewmodel_offset_z", zS:GetValue(), true); 
client.SetConVar("viewmodel_fov", vfov:GetValue(), true); end
callbacks.Register("Draw", "sets", doesthing);-- Scraped by chicken
-- Author: ItsArmiii
-- Title [Release] FOV Changer [V5]
-- Forum link https://aimware.net/forum/thread/127437

local REF = gui.Reference( "Settings" )

local TAB = gui.Tab(REF, "lua_fov_tab", "L.A#5212")
local SLIDER = gui.Slider( TAB, "lua_fov_slider", "Field of View", 60, 0, 180 )
local SLIDER_VIEW = gui.Slider( TAB, "lua_fov_slider_view", "Viewmodel Field of View", 60, 0, 180 )

callbacks.Register( "Draw", function()
  client.Command("fov_cs_debug "..SLIDER:GetValue(), true)
  client.SetConVar("viewmodel_fov", SLIDER_VIEW:GetValue(), true)
end)
