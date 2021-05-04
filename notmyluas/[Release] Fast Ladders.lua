-- Scraped by chicken
-- Author: - Luiz
-- Title [Release] Fast Ladders
-- Forum link https://aimware.net/forum/thread/148933


-- AIMWARE lua script for climbing ladders faster
-- By Nyanpasu!
-- Version 1.0

-- GUI
local enabledCB = gui.Checkbox(gui.Reference("Misc", "Movement", "Other"), "fastladder", "Fast Ladders", 0)
enabledCB:SetDescription("Climb and descend ladders faster.")

-- Movement manipulation
local function onCreateMove(cmd)
 if not gui.GetValue("misc.master") then return end
 if not enabledCB:GetValue() then return end
 
 local localPlayer = entities.GetLocalPlayer()
 if bit.band(localPlayer:GetPropInt("m_nRenderMode"), bit.lshift(1, 8)) == 0 then return end -- in ladder check
 local ladderNormal = localPlayer:GetPropVector("m_vecLadderNormal")

 if cmd.forwardmove ~= 0 then
 if cmd.forwardmove > 0 then
 cmd.buttons = bit.band(bit.bor(cmd.buttons, bit.lshift(1, 9)), bit.bnot(bit.lshift(1, 10))) -- set IN_MOVELEFT and reset IN_MOVERIGHT
 else
 cmd.buttons = bit.band(bit.bor(cmd.buttons, bit.lshift(1, 10)), bit.bnot(bit.lshift(1, 9))) -- set IN_MOVERIGHT and reset IN_MOVELEFT
 end
 
 local ladderAngles = EulerAngles(-89, math.deg(math.acos(ladderNormal.x)) + (ladderNormal.y < 0 and 180 or 0) + 90, 0) -- stay perpendicular to the ladder, looking up
 ladderAngles:Normalize()
 cmd.viewangles = ladderAngles
 end
 
end
callbacks.Register("CreateMove", onCreateMove)
