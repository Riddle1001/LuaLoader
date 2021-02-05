-- Scraped by chicken
-- Author: helloabcdf123
-- Title [Release] Disable OnUse with Desync+AA on RescueDefuse
-- Forum link https://aimware.net/forum/thread/140609


local ref = gui.Reference("Ragebot", "Anti-aim", "Extra", "Conditions")
local chk = gui.Checkbox(ref, "chk_disable_on_use", "Custom Disable On Use", false)

chk:SetDescription("Disable on use with desync.")

local USED = false
local values = {
pitchstyle = 0,
yawfakestyle = 0,
yawstyle = 0,
attargets = 0,
autodir = 0,
autodirinvert = false,
desync = 0,
}

callbacks.Register("CreateMove", function(cmd)
local pLocal = entities.GetLocalPlayer()

if not pLocal then return end
if not pLocal:IsAlive() then return end

local IN_USE = bit.lshift(1,5)

local IS_USING = bit.band(cmd.buttons, IN_USE) == IN_USE

local DEFUSING = pLocal:GetProp("m_bIsDefusing")



if chk:GetValue() then
gui.SetValue("rbot.antiaim.extra.condition.use", 0)

if (IS_USING) and DEFUSING == 0 then
if not USED then
USED = true

values.pitchstyle = gui.GetValue("rbot.antiaim.pitchstyle")
values.yawfakestyle = gui.GetValue("rbot.antiaim.fakeyawstyle")
values.yawstyle = gui.GetValue("rbot.antiaim.yawstyle")
values.autodir = gui.GetValue("rbot.antiaim.autodir")
values.autodirinvert = gui.GetValue("rbot.antiaim.autodir")
values.desync = gui.GetValue("rbot.antiaim.desync")
values.attargets = gui.GetValue("rbot.antiaim.attargets"
)
end
gui.SetValue("rbot.antiaim.fakeyawstyle", 1)
gui.SetValue("rbot.antiaim.pitchstyle", 0)
gui.SetValue("rbot.antiaim.yawstyle", 0)
gui.SetValue("rbot.antiaim.autodir", 0)
gui.SetValue("rbot.antiaim.attargets", 0)
gui.SetValue("rbot.antiaim.desync", 58)


end
end
local shall_aa = false
if DEFUSING ~= 0 then
shall_aa = true
elseif IS_USING then
shall_aa = false
else
shall_aa = true
end
if DEFUSING ~= 0 then
cmd.viewangles.pitch = 89
gui.SetValue("rbot.antiaim.desync", 0)
end
if USED and shall_aa then
USED = false

gui.SetValue("rbot.antiaim.pitchstyle", values.pitchstyle)
gui.SetValue("rbot.antiaim.yawstyle", values.yawstyle)
gui.SetValue("rbot.antiaim.fakeyawstyle", values.yawfakestyle)
gui.SetValue("rbot.antiaim.autodir", values.autodir)
gui.SetValue("rbot.antiaim.autodir", values.autodirinvert)
gui.SetValue("rbot.antiaim.desync", values.desync)
gui.SetValue("rbot.antiaim.attargets", values.attargets)
end

end)





