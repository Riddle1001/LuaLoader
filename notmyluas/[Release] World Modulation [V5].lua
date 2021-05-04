-- Scraped by chicken
-- Author: Dreammm
-- Title [Release] World Modulation [V5]
-- Forum link https://aimware.net/forum/thread/127547

--[[
--[[
Original = @Giperfast.tk; @YarinDayan12; @Cheeseot.
Shit Rewrite = @Dreammm.
]]
local menu = gui.Reference("Visuals", "World", "Materials");
local bloom = gui.Slider(menu, "Bloom", "Bloom", 20, 1, 100);
local bloom_value = gui.Slider(menu, "Value", "Value", 1, 1, 100);
local fogstart = gui.Slider(menu, "Fogstart", "FogStart", 100, 1, 1000);
local fogend = gui.Slider(menu, "FogEnd", "FogEnd", 1000, 1, 1000);
local maxdensity = gui.Slider(menu, "MaxDensity", "MaxDensity", 1, 1, 100);
local ZoomScale = gui.Slider(menu, "ZoomScale", "ZoomScale", 1, 1, 100);
local sli_exposure = gui.Slider(menu, "nex_bloom_exposure", "World Exposure", 100, 1, 100);
local anime = gui.Checkbox(menu,"anime", "For Color Picker.", false ); -- For ColorPicker
local Fogcolor = gui.ColorPicker(anime, "Fogcolor","FogColor", 255, 255, 255, 255 )
local controlR = gui.Slider(menu, "nex_visuals_modulation_red", "Modulation: Red", 255, 0, 255);
local controlG = gui.Slider(menu, "nex_visuals_modulation_green", "Modulation: Green", 0, 0, 255);
local controlB = gui.Slider(menu, "nex_visuals_modulation_blue", "Modulation: Blue", 0, 0, 255);
local exposure 
local varR 
local varG 
local varB 
local ambient 
callbacks.Register("Draw", "bloom", function()
    r,g,b = Fogcolor:GetValue()
    local CEnvTonemapController = entities.FindByClass("CEnvTonemapController")[1];
    local CFogController = entities.FindByClass("CFogController")[1];

    if(CFogController) then
      CFogController:SetProp("m_fog.enable", 1);
      CFogController:SetProp("m_fog.start", fogstart:GetValue()/1);
      CFogController:SetProp("m_fog.end", fogend:GetValue()/1);
      CFogController:SetProp("m_fog.maxdensity", maxdensity:GetValue()/100);
      CFogController:SetProp("m_fog.ZoomFogScale", ZoomScale:GetValue()/100);
    end
        if(CEnvTonemapController) then

      CEnvTonemapController:SetProp("m_flCustomBloomScale", bloom:GetValue()/50);
            client.SetConVar("r_modelAmbientMin", bloom_value:GetValue()/1, true);
      CEnvTonemapController:SetProp("m_bUseCustomAutoExposureMin", 1);
      CEnvTonemapController:SetProp("m_bUseCustomAutoExposureMax", 1);
      CEnvTonemapController:SetProp("m_flCustomAutoExposureMin", sli_exposure:GetValue()/100);
      CEnvTonemapController:SetProp("m_flCustomAutoExposureMax", sli_exposure:GetValue()/100);
      exposure = sli_exposure:GetValue()/100
      client.SetConVar("fog_override", 1, true);
      client.SetConVar("fog_enableskybox", 1, true);
      client.SetConVar("fog_startskybox", fogstart:GetValue()/1, true);
      client.SetConVar("fog_endskybox", fogend:GetValue()/1, true);
      client.SetConVar("fog_maxdensityskybox", maxdensity:GetValue()/100, true );
if(controlR:GetValue()/255 ~= varR) then
     client.SetConVar("mat_ambient_light_r", controlR:GetValue()/255, true);
varR = controlR:GetValue()/255
   end
   
   if(controlG:GetValue()/255 ~= varG) then
     client.SetConVar("mat_ambient_light_g", controlG:GetValue()/255, true);
varG = controlG:GetValue()/255
   end
   
   if(controlB:GetValue()/255 ~= varB) then
     client.SetConVar("mat_ambient_light_b", controlB:GetValue()/255, true);
varB = controlB:GetValue()/255
   end
      
      local temp = r.." "..g.." "..b
      client.SetConVar("fog_color",temp, true);
      client.SetConVar("fog_colorskybox",temp, true);
    end
end);