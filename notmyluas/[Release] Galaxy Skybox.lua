-- Scraped by chicken
-- Author: anue
-- Title [Release] Galaxy Skybox
-- Forum link https://aimware.net/forum/thread/88382

function SkyBox()
 if (client.GetConVar("sv_skyname") ~= "******" and gui.GetValue("msc_restrict") ~= 1) then
 client.SetConVar("sv_skyname", "******") 
 end
end

callbacks.Register("Draw", "SkyBox", SkyBox)