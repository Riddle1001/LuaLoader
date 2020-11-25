-- Scraped by chicken
-- Author: helloabcdf123
-- Title [Release] Unlock yaw feature
-- Forum link https://aimware.net/forum/thread/140312


local ref = gui.Reference("Ragebot", "Anti-Aim", "Anti-Aim")
local yaw = gui.Slider(ref, "sld_yaw", "Yaw", 0, -180, 180)

callbacks.Register("Draw", function()
if gui.GetValue("rbot.antiaim.yawstyle") ~= 1 then
return
end
yaw:SetInvisible(gui.GetValue("rbot.antiaim.yawstyle") ~= 1)
local y = 180 + yaw:GetValue()
if y > 180 then
y = y - 360
elseif y < -180 then
y = y + 360
end 

gui.SetValue("rbot.antiaim.yaw", y)
end)
