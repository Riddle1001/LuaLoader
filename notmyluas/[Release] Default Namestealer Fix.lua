-- Scraped by chicken
-- Author: Bl1zzard
-- Title [Release] Default Namestealer Fix
-- Forum link https://aimware.net/forum/thread/110238

local NameStealerFix = function()
  if entities.GetLocalPlayer() ~= nil and (entities.GetLocalPlayer():GetTeamNumber() == 2 or entities.GetLocalPlayer():GetTeamNumber() == 3) then -- Disable if LocalPlayer offset is null (Main Menu) or if TeamNumber is spectator (0).
    gui.SetValue("msc_namestealer_enable", 1); -- 1 is for Team Only, 2 is for Enemy only and 3 is for All.
  else
    gui.SetValue("msc_namestealer_enable", 0);
  end
end

callbacks.Register("Draw", "NameStealerFix", NameStealerFix)