-- Scraped by chicken
-- Author: GTX5700XT
-- Title [Release] Maxusrcmd limits on dtfdnone
-- Forum link https://aimware.net/forum/thread/149971

local misc_ref = gui.Reference("Misc")
local extra_Fakelags_tab = gui.Tab(misc_ref, "hitfl_tab", "Maxusrcmd limits")
local extra_Fakelags_gb = gui.Groupbox(extra_Fakelags_tab, "Extra Fakelags", 10, 15, 600, 0 )
local processticks = gui.Reference('Misc', 'General', 'Server', 'sv_maxusrcmdprocessticks')

local fl_normal_limit = gui.Slider(extra_Fakelags_gb, "fl_normal_limit", "Maxusrcmd normal limit", 18, 3, 61)
local fl_dt_limit = gui.Slider(extra_Fakelags_gb, "fl_dt_limit", "Maxusrcmd dt limit", 18, 3, 61)
local fl_fd_limit = gui.Slider(extra_Fakelags_gb, "fl_fd_limit", "Maxusrcmd fd limit", 18, 3, 61)


local function maxusrcmdchanger()

local fakeduck = gui.Reference('Ragebot', 'Anti-Aim', 'Extra', 'Fake Duck')
local getfd = fakeduck:GetValue()

if input.IsButtonDown(getfd) then
  processticks:SetValue(fl_fd_limit:GetValue())
 return
   elseif gui.GetValue("rbot.accuracy.weapon.pistol.doublefire") == 2 or
    gui.GetValue("rbot.accuracy.weapon.hpistol.doublefire") == 2 or
    gui.GetValue("rbot.accuracy.weapon.smg.doublefire") == 2 or
    gui.GetValue("rbot.accuracy.weapon.rifle.doublefire") == 2 or
    gui.GetValue("rbot.accuracy.weapon.shotgun.doublefire") == 2 or
    gui.GetValue("rbot.accuracy.weapon.asniper.doublefire") == 2 or
    gui.GetValue("rbot.accuracy.weapon.lmg.doublefire") == 2 then
    processticks:SetValue(fl_dt_limit:GetValue())
  else
processticks:SetValue(fl_normal_limit:GetValue())
end
end

callbacks.Register('CreateMove', maxusrcmdchanger)

