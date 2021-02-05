-- Scraped by chicken
-- Author: PapaEcksdee
-- Title [Release] Nade Self
-- Forum link https://aimware.net/forum/thread/139659

local NadeRef = gui.Reference("MISC")
local NadeMenuTab = gui.Tab(NadeRef, "nademenu.tab", "Self Nade")
local wait = globals.CurTime()
local lPlayer = entities.GetLocalPlayer()
local lPlayerAlive = lPlayer:IsAlive()
local nadeval = -1

local NadeSelfGroupbox = gui.Groupbox(NadeMenuTab, "Nade Self", 15, 15, 200, 100)
NadeSelfKey = gui.Keybox(NadeSelfGroupbox, "nadeself.key", "Key", 0)

callbacks.Register( "Draw", function()
 if entities.GetLocalPlayer() then
  local lPlayerWeaponID = lPlayer:GetWeaponID();
  if lPlayerWeaponID == 44 then
    if NadeSelfKey:GetValue() ~= 0 then
     if input.IsButtonPressed(NadeSelfKey:GetValue()) then
       startang = engine.GetViewAngles(EulerAngles())
       nadeval = 1
       engine.SetViewAngles(EulerAngles(-89,0,0))
       wait = globals.CurTime()
      elseif globals.CurTime() - wait > 0.89 then
       nadeval = -1
      elseif globals.CurTime() - wait > 0.87 then
       nadeval = 3
       engine.SetViewAngles(startang)
      elseif globals.CurTime() - wait > 0.7 then
       nadeval = 0
      elseif globals.CurTime() - wait > 0.4 then
       nadeval = 2
      end

      if nadeval == 1 then
       client.Command("+attack", true)
       client.Command("+attack2", true)
      elseif nadeval == 2 then
       client.Command("-attack", true)
      elseif nadeval == 0 then
       client.Command("-attack2", true)
      elseif nadeval == -1 then return
      end
    end
   end
 end
end)




