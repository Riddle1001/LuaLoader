-- Scraped by chicken
-- Author: zarzap477
-- Title [Release] [L4D2] View Models
-- Forum link https://aimware.net/forum/thread/98037

-- Yes this is pasted from Zack's Viewmodel Extender from csgo. if u have csgo i highy suggest his scripts (P Lua Maker)
-------------- View Model Extender Edited By Tessa#2676
local VMY = gui.Reference("VISUALS", "Main")
local function VM_Cache() xO = client.GetConVar("cl_viewmodelfovsurvivor"); yO = client.GetConVar("cl_viewmodelfovboomer"); zO = client.GetConVar("cl_viewmodelfovhunter"); fO = client.GetConVar("cl_viewmodelfovsmoker"); f1 = client.GetConVar("cl_viewmodelfovtank"); end; VM_Cache()
local VMStuff = gui.Groupbox(VMY, "Viewmodel Stuff", 15, 650, 170, 240)
local VM_e = gui.Checkbox(VMStuff, "msc_vme", "Enable", false)
local xS = gui.Slider(VMStuff, "VM_X", "Survivor", xO, 0, 360)
local yS = gui.Slider(VMStuff, "VM_Y", "Bommer", yO, 0, 360)
local zS = gui.Slider(VMStuff, "VM_Z", "Hunter", zO, 0, 360)
local vfov = gui.Slider(VMStuff, "VM_fov", "Smoker", fO, 0, 360)
local FT = gui.Slider(VMStuff, "VM_Tank", "Tank", f1, 0, 360)

function VM_E() if VM_e:GetValue() then client.SetConVar("cl_viewmodelfovsurvivor", xS:GetValue(), true); client.SetConVar("cl_viewmodelfovboomer", yS:GetValue(), true); client.SetConVar("cl_viewmodelfovhunter", zS:GetValue(), true); client.SetConVar("cl_viewmodelfovsmoker", vfov:GetValue(), true); client.SetConVar("cl_viewmodelfovtank", FT:GetValue(), true); end end
callbacks.Register("Draw", "vm sets", VM_E);



