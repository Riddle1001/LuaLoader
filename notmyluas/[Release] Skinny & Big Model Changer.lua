-- Scraped by chicken
-- Author: lntranets
-- Title [Release] Skinny & Big Model Changer
-- Forum link https://aimware.net/forum/thread/150071

--references
local player = entities.GetLocalPlayer()
local ref = gui.Reference('Misc', 'General', 'Extra')
local checkbox = gui.Checkbox(ref, 'skinny_man', 'Enable Skinny Man', false)
local edit = gui.Editbox(ref, 'skinny_edit', 'Skinny or big value - can go negative')

--skinny function if you put it negative it will destroy your model
--in the words of clipper the great
--Clipper — Today at 3:40 PM
--r/aimwaregore
local function skinny()
 local get = edit:GetValue()
 if checkbox:GetValue() then
 if player:IsAlive() then 
 player:SetProp('m_flModelScale', get)
 end
 else 
 player:SetProp('m_flModelScale', 1)
 end
end
callbacks.Register('CreateMove', skinny)