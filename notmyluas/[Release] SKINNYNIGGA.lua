-- Scraped by chicken
-- Author: Dankkk
-- Title [Release] SKINNYNIGGA
-- Forum link https://aimware.net/forum/thread/113280

local function Draw()
  if entities.GetLocalPlayer() == nil then
    return
  end
  local player = entities.GetLocalPlayer()
  if player:IsAlive() then
    player:SetProp("m_flModelScale", 0.5, 12)
  end
end
callbacks.Register("Draw", "Draw", Draw)


