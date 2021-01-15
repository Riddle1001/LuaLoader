-- Scraped by chicken
-- Author: ItsArmiii
-- Title [Release] FOV Changer (V5)
-- Forum link https://aimware.net/forum/thread/127437

local REF = gui.Reference( "Settings" )

local TAB = gui.Tab(REF, "lua_fov_tab", "L.A#5212")
local SLIDER = gui.Slider( TAB, "lua_fov_slider", "Field of View", 60, 0, 180 )
local SLIDER_VIEW = gui.Slider( TAB, "lua_fov_slider_view", "Viewmodel Field of View", 60, 0, 180 )

callbacks.Register( "Draw", function()
    client.Command("fov_cs_debug "..SLIDER:GetValue(), true)
    client.SetConVar("viewmodel_fov", SLIDER_VIEW:GetValue(), true)
end)