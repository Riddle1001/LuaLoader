-- Scraped by chicken
-- Author: Cheeseot
-- Title [Release] World Modulation (OPTIMIZED)
-- Forum link https://aimware.net/forum/thread/106392

local reference = gui.Reference("VISUALS", "MISC", "World");

local controlR = gui.Slider(reference, "nex_visuals_modulation_red", "Modulation: Red", 255, 0, 255);
local controlG = gui.Slider(reference, "nex_visuals_modulation_green", "Modulation: Green", 0, 0, 255);
local controlB = gui.Slider(reference, "nex_visuals_modulation_blue", "Modulation: Blue", 0, 0, 255);
local sli_exposure = gui.Slider(reference, "nex_bloom_exposure", "World Exposure", 100, 1, 100);
local sli_modelAmbient = gui.Slider(reference, "nex_bloom_model_ambient", "Model Ambient", 1, 1, 100);
local sli_bloom = gui.Slider(reference, "nex_bloom_scale", "Bloom Scale", 20, 1, 100);
local varR 
local varG 
local varB 
local ambient 
local props 
local exposure 
local bloom 

local function vars(start)
if start:GetName() == "round_start" then
  varR = 0
 varG = 0
 varB = 0
 ambient = 0
 props = 0
 exposure = 0
 bloom = 0
 end 
end

client.AllowListener("round_start")
callbacks.Register ("FireGameEvent", "vars", vars)

local function Modulation()
  if(entities.GetLocalPlayer()) then
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

    local controller = entities.FindByClass("CEnvTonemapController")[1];
  
    if(controller) then
 if props == 0 then
 controller:SetProp("m_bUseCustomAutoExposureMin", 1);
 controller:SetProp("m_bUseCustomAutoExposureMax", 1);
 controller:SetProp("m_bUseCustomBloomScale", 1);
 props = 1
 end

 if exposure ~= sli_exposure:GetValue()/100 and props == 1 then
 controller:SetProp("m_flCustomAutoExposureMin", sli_exposure:GetValue()/100);
 controller:SetProp("m_flCustomAutoExposureMax", sli_exposure:GetValue()/100);
 exposure = sli_exposure:GetValue()/100
 end
 
 if bloom ~= sli_bloom:GetValue()/100 and props == 1 then
 controller:SetProp("m_flCustomBloomScale", sli_bloom:GetValue()/100);
 bloom = sli_bloom:GetValue()/100
 end
 
 if (sli_modelAmbient:GetValue()/1 ~= ambient) then
 client.SetConVar("r_modelAmbientMin", sli_modelAmbient:GetValue()/1, true);
 ambient = sli_modelAmbient:GetValue()/1
 end
    end
  end
end;

callbacks.Register("Draw", "Modulation", Modulation)