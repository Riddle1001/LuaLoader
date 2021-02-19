-- Scraped by chicken
-- Author: zack
-- Title [Release] Team Based Knife
-- Forum link https://aimware.net/forum/thread/91174


local reference = gui.Reference("SETTINGS", "Miscellaneous")
local window = gui.Window("tb_knife_glove", "Knife Changer", 200, 200, 200, 188)
local group = gui.Groupbox(window, "Knives", 12, 15, 176, 130)
local ctknifebox = gui.Combobox(group, "ct_knife", "CT Knife", "Bayonet", "Flip Knife", "Gut Knife", "Karambit", "M9 Bayonet", "Huntsman Knife", "Falchion Knife", "Bowie Knife", "Butterfly Knife", "Shadow Daggers", "Ursus Knife", "Navaja Knife", "Stiletto Knife", "Talon Knife")
local tknifebox = gui.Combobox(group, "t_knife", "T Knife", "Bayonet", "Flip Knife", "Gut Knife", "Karambit", "M9 Bayonet", "Huntsman Knife", "Falchion Knife", "Bowie Knife", "Butterfly Knife", "Shadow Daggers", "Ursus Knife", "Navaja Knife", "Stiletto Knife", "Talon Knife")

local menu = true
function j() if input.IsButtonPressed(gui.GetValue("msc_menutoggle")) then if menu == true then menu = false else menu = true end end end callbacks.Register("Draw", 'b', j)
function k() if menu == true then window:SetActive(1) elseif menu == false then window:SetActive(0) end end callbacks.Register("Draw", 'x', k)

function knives()
if entities.GetLocalPlayer() ~= nil then
if entities.GetLocalPlayer():GetTeamNumber() == 1 then
elseif entities.GetLocalPlayer():GetTeamNumber() == 2 then
  if tknifebox:GetValue() == 0 then tknife = 0 elseif tknifebox:GetValue() == 1 then tknife = 1 elseif tknifebox:GetValue() == 2 then tknife = 2 elseif
   tknifebox:GetValue() == 3 then tknife = 3 elseif tknifebox:GetValue() == 4 then tknife = 4 elseif tknifebox:GetValue() == 5 then tknife = 5 elseif
   tknifebox:GetValue() == 6 then tknife = 6 elseif tknifebox:GetValue() == 7 then tknife = 7 elseif tknifebox:GetValue() == 8 then tknife = 8 elseif
   tknifebox:GetValue() == 9 then tknife = 9 elseif tknifebox:GetValue() == 10 then tknife = 10 elseif tknifebox:GetValue() == 11 then tknife = 11 elseif
   tknifebox:GetValue() == 12 then tknife = 12 elseif tknifebox:GetValue() == 13 then tknife = 13 end gui.SetValue("skin_knife", tknife)
   
elseif entities.GetLocalPlayer():GetTeamNumber() == 3 then
  if ctknifebox:GetValue() == 0 then ctknife = 0 elseif ctknifebox:GetValue() == 1 then ctknife = 1 elseif ctknifebox:GetValue() == 2 then ctknife = 2 elseif
   ctknifebox:GetValue() == 3 then ctknife = 3 elseif ctknifebox:GetValue() == 4 then ctknife = 4 elseif ctknifebox:GetValue() == 5 then ctknife = 5 elseif
   ctknifebox:GetValue() == 6 then ctknife = 6 elseif ctknifebox:GetValue() == 7 then ctknife = 7 elseif ctknifebox:GetValue() == 8 then ctknife = 8 elseif
   ctknifebox:GetValue() == 9 then ctknife = 9 elseif ctknifebox:GetValue() == 10 then ctknife = 10 elseif ctknifebox:GetValue() == 11 then ctknife = 11 elseif
   ctknifebox:GetValue() == 12 then ctknife = 12 elseif ctknifebox:GetValue() == 13 then ctknife1 = 13 end gui.SetValue("skin_knife", ctknife)
end end end
callbacks.Register("Draw", "k", knives);