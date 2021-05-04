-- Scraped by chicken
-- Author: lntranets
-- Title [Release] Multiple Lines Name Spam
-- Forum link https://aimware.net/forum/thread/151227

--different name spammer by lntranets
local ref = gui.Reference('Misc', 'Enhancement', 'Appearance')
local text_box = gui.Editbox(ref, 't_box', 'Name')
local switch = false
local switch2 = false

-- buttons
local ui_button = gui.Button(ref, 'Set Name', function()
 switch = true
end)

local ui_button2 = gui.Button(ref, 'Set Long Name', function()
 switch2 = true
end)
--------------------------

-- handle button press
callbacks.Register('Draw', function()
 if switch then
 local get_t = gui.GetValue('misc.t_box')
 client.SetConVar('name', get_t .. ' ' .. get_t .. ' ' .. get_t .. ' ' .. get_t .. ' ' .. get_t .. ' ', 1)
 end
end)

callbacks.Register('Draw', function()
 if switch2 then
 local get_t = gui.GetValue('misc.t_box')
 client.SetConVar('name', get_t .. '                                                                                            ', 1)
 end
end)
--------------------------
