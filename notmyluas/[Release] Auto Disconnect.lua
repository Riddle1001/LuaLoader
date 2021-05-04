-- Scraped by chicken
-- Author: Sestain
-- Title [Release] Auto Disconnect
-- Forum link https://aimware.net/forum/thread/151019

local function cs_win_panel_match(event)
  if event:GetName() and event:GetName() == "cs_win_panel_match" then
    client.Command("disconnect", true);
  end
end

client.AllowListener("cs_win_panel_match");
callbacks.Register("FireGameEvent", "autodisconnect", cs_win_panel_match);