-- Scraped by chicken
-- Author: Trollface7272
-- Title [Release] Music Kit Changer
-- Forum link https://aimware.net/forum/thread/142838


local slider = gui.Slider(gui.Reference("Visuals", "Other", "Extra"), "", "Music Kit Changer", 1, 1, 50)
slider:SetDescription("Changes the music kit used in game.")
function onDraw()
 entities.GetPlayerResources():SetPropInt(slider:GetValue(), "m_nMusicID", client.GetLocalPlayerIndex());
end
callbacks.Register("Draw", onDraw)


