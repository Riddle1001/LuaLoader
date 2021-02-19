-- Scraped by chicken
-- Author: Rickyy
-- Title [Release] In-game Radar Overlay & Aimware Radar
-- Forum link https://aimware.net/forum/thread/147716

callbacks.Register("CreateMove", function()
 if (gui.GetValue("esp.other.radar") == true) then
  client.Command("cl_drawhud_force_radar 0",true)
 end
end)