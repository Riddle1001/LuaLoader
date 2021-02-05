-- Scraped by chicken
-- Author: BuffaloBillE
-- Title [Release] Fake Duck Hitchance
-- Forum link https://aimware.net/forum/thread/98033

weaponHitchance = {
  "rbot_autosniper_hitchance",
  "rbot_sniper_hitchance",
  "rbot_scout_hitchance",
  "rbot_revolver_hitchance",
  "rbot_pistol_hitchance",
  "rbot_smg_hitchance",
  "rbot_rifle_hitchance",
  "rbot_shotgun_hitchance",
  "rbot_lmg_hitchance",
  "rbot_shared_hitchance"
}
 
oldhitchancevalues = {}
for i = 1, #weaponHitchance do
  oldhitchancevalues[i] = gui.GetValue(weaponHitchance[i]);
end
 
callbacks.Register("Draw", function()
  local fakeDuckKey = gui.GetValue("rbot_antiaim_fakeduck");
  if (fakeDuckKey == nil or fakeDuckKey == 0) then return end
  local lPlayer = entities.GetLocalPlayer();
  if (lPlayer == nil) then return end
  local fakeDucking = input.IsButtonDown(fakeDuckKey);
  for i = 1, #weaponHitchance do
    if fakeDucking and lPlayer:IsAlive() then
      gui.SetValue(weaponHitchance[i], oldhitchancevalues[i] + 10);
    else
      gui.SetValue(weaponHitchance[i], oldhitchancevalues[i])
    end
  end
end)



