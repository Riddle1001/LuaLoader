-- Scraped by chicken
-- Author: prat2kajs
-- Title [Release] Default Config
-- Forum link https://aimware.net/forum/thread/149232

local setAsDefault = gui.Reference("Settings", "Configurations", "Manage Configurations", "Set As Default")
 setAsDefault:SetInvisible(true)

local refreshList = gui.Reference("Settings", "Configurations", "Manage Configurations", "Refresh List")
 refreshList:SetPosX(296)
 refreshList:SetPosY(304)

local setDefaultConfig = gui.Editbox(gui.Reference("Settings", "Configurations", "Manage Configurations"), " ", " ")
 setDefaultConfig:SetPosX(296)
 setDefaultConfig:SetPosY(344)
 setDefaultConfig:SetWidth(280)
 setDefaultConfig:SetValue(file.Read("default_cfg.txt"))
 setDefaultConfig:SetDescription("Default config filename")

local applyDefault = gui.Button(gui.Reference("Settings", "Configurations", "Manage Configurations"), 'Set Default', function() file.Write("default_cfg.txt", setDefaultConfig:GetString()) end)
 applyDefault:SetPosX(440)
 applyDefault:SetPosY(304)
 applyDefault:SetWidth(136)
 applyDefault:SetHeight(28)
 
local prefix = "cfg.load "
 
local suffix = file.Read("default_cfg.txt")
 
local command = prefix .. suffix

local runLoadDefault = gui.Command(command)