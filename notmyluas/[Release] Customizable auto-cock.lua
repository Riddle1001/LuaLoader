-- Scraped by chicken
-- Author: Ruppet
-- Title [Release] Customizable auto-cock
-- Forum link https://aimware.net/forum/thread/98702

local cb = gui.Checkbox(gui.Reference("RAGE", "WEAPON", "REVOLVER", "Accuracy"), "rbot_revolver_autocock_ex", "Fixed Auto-Revolver", false)
local cockspeed = gui.Slider(gui.Reference("RAGE", "WEAPON", "REVOLVER", "Accuracy"), "rbot_revolver_autocock_ex_speed", "Auto-Revolver speed", 5, 5, 50)
local delay = gui.Slider(gui.Reference("RAGE", "WEAPON", "REVOLVER", "Accuracy"), "rbot_revolver_autocock_ex_delay", "Auto-Revolver delay", 0, 0, 50)

local function on_create_move(cmd)
  local me = entities.GetLocalPlayer()
  if cb:GetValue() and me ~= nil and me:GetHealth() > 0 then
    if cmd:GetButtons() & (1 << 0) > 0 then
      return
    end

    local wep = me:GetPropEntity("m_hActiveWeapon")

    if wep:GetClass() == "CDEagle" and wep:GetWeaponID() == 64 then
      cmd:SetButtons(cmd:GetButtons() | (1 << 0))

      local m_flPostponeFireReadyTime = wep:GetPropFloat("m_flPostponeFireReadyTime")
      if m_flPostponeFireReadyTime > 0 and m_flPostponeFireReadyTime - (cockspeed:GetValue() / 100) < globals.CurTime() then
        cmd:SetButtons(cmd:GetButtons() & ~(1 << 0))

        if m_flPostponeFireReadyTime + globals.TickInterval() * 16 + (delay:GetValue() / 100) > globals.CurTime() then
          cmd:SetButtons(cmd:GetButtons() | (1 << 11))
        end
      end
    end
  end
end

callbacks.Register("CreateMove", on_create_move)



