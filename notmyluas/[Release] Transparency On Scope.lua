-- Scraped by chicken
-- Author: bighacker
-- Title [Release] Transparency On Scope
-- Forum link https://aimware.net/forum/thread/96601

--			red, green, blue, normal transparency, scope transparency
local ct = {255, 124, 208, 221, 100};
local t = {255, 124, 208, 221, 100};
local function lol()
local Player = entities.GetLocalPlayer();
if(Player:GetProp("m_bIsScoped") == 0) then
gui.SetValue("clr_chams_ct_vis", ct[1], ct[2], ct[3], ct[4]);
gui.SetValue("clr_chams_t_vis", t[1], t[2], t[3], t[4]);
else
gui.SetValue("clr_chams_ct_vis", ct[1], ct[2], ct[3], ct[5]);
gui.SetValue("clr_chams_t_vis", t[1], t[2], t[3], t[5]);
end
end
callbacks.Register("Draw", "lol", lol);