-- Scraped by chicken
-- Author: DjGaming
-- Title [Release] Fakewalk Lua
-- Forum link https://aimware.net/forum/thread/130347

local guiRef = gui.Reference( "Ragebot", "Anti-Aim", "Advanced" )
gui.Checkbox( guiRef, "testaa", "Fakewalk", false )
gui.Checkbox( guiRef, "testinv", "AA Inverter", false )
local Inverter_Key = gui.Keybox(guiRef, "inverter_key", "AA Inverter Key", 0)

local toggled = false

local function keys()

    if Inverter_Key:GetValue() ~= 0 then
        if input.IsButtonPressed(Inverter_Key:GetValue()) then
            toggled = not toggled
        end
    end

end

local function drawHook()
    keys()
end

local function createMoveHook(cmd)

    if gui.GetValue("rbot.antiaim.advanced.testaa") then
        if input.IsButtonDown( "a" ) and input.IsButtonDown( "shift" ) and not input.IsButtonDown( "d" ) then
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.sidemove = 0
            cmd.sendpacket = true
            cmd.sidemove = 0
            cmd.sendpacket = false
            cmd.sidemove = -55
        end
        if input.IsButtonDown( "d" ) and input.IsButtonDown( "shift" ) and not input.IsButtonDown( "a" ) then
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.sidemove = 0
            cmd.sendpacket = true
            cmd.sidemove = 0
            cmd.sendpacket = false
            cmd.sidemove = 55
        end
        if input.IsButtonDown( "s" ) and input.IsButtonDown( "shift" ) and not input.IsButtonDown( "w" ) then
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.forwardmove = 0
            cmd.sendpacket = true
            cmd.forwardmove = 0
            cmd.sendpacket = false
            cmd.forwardmove = -55
        end
        if input.IsButtonDown( "w" ) and input.IsButtonDown( "shift" ) and not input.IsButtonDown( "s" ) then
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.forwardmove = 0
            cmd.sendpacket = true
            cmd.forwardmove = 0
            cmd.sendpacket = false
            cmd.forwardmove = 55
        end
    end

    if gui.GetValue("rbot.antiaim.advanced.testinv") then
        if toggled then
          gui.SetValue("rbot.antiaim.base.rotation", 58)
          gui.SetValue("rbot.antiaim.base.lby", -180)
          gui.SetValue("rbot.antiaim.right.rotation", 58)
          gui.SetValue("rbot.antiaim.right.lby", -180)
          gui.SetValue("rbot.antiaim.left.rotation", 58)
          gui.SetValue("rbot.antiaim.left.lby", -180)
        else
          gui.SetValue("rbot.antiaim.base.rotation", -58)
          gui.SetValue("rbot.antiaim.base.lby", 180)
          gui.SetValue("rbot.antiaim.right.rotation", -58)
          gui.SetValue("rbot.antiaim.right.lby", 180)
          gui.SetValue("rbot.antiaim.left.rotation", -58)
          gui.SetValue("rbot.antiaim.left.lby", 180)
        end
    end
end

callbacks.Register("CreateMove", createMoveHook)
callbacks.Register("Draw", drawHook);
