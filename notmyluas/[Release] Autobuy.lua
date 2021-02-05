-- Scraped by chicken
-- Author: ticzz
-- Title [Release] Autobuy
-- Forum link https://aimware.net/forum/thread/127452

local misc_automation_main_ref = gui.Reference("MISC", "Enhancement")

local autobuy_group = gui.Groupbox(misc_automation_main_ref, "Autobuy", 327, 315, 297)
local buybot_enable = gui.Checkbox( autobuy_group, "BB_enable", "BuyBot Active", false)
local buybot_primary = gui.Combobox( autobuy_group, "global_buybot_primary", "BuyBot Primary", "Off", "SCAR\\G3SG1","AK47\\M4A1", "SCOUT", "AWP", "SG553\\AUG")
local buybot_secondary = gui.Combobox( autobuy_group, "global_buybot_secondary", "BuyBot Secondary", "Off", "Duals", "Deagle\\Revolver" )
local buybot_armor = gui.Checkbox( autobuy_group, "global_buybot_armor", "BuyBot Armor", false)
local buybot_nades = gui.Checkbox( autobuy_group, "global_buybot_nades", "BuyBot Nades", false)
local buybot_zeus = gui.Checkbox( autobuy_group, "global_buybot_zeus", "BuyBot Zeus", false)
local buybot_defuser = gui.Checkbox( autobuy_group, "global_buybot_defuse", "BuyBot Defuser", false)


local weapons_ = {"pistol", "revolver", "smg", "rifle", "shotgun", "scout", "autosniper", "sniper", "lmg"}
local hitboxes_ = {"head", "neck", "chest", "stomach", "pelvis", "arms", "legs"}

local primary_w = {"buy scar20", "buy m4a1", "buy ssg08", "buy awp","buy aug"}
local secondary_w = {"buy elite", "buy deagle"}

 

local function Hooked_Events( event )
  if event:GetName() == "round_start" and buybot_enable:GetValue() then
    local tobuy = ""
    local primary = buybot_primary:GetValue()
    local secondary = buybot_secondary:GetValue()
   
    if buybot_armor:GetValue() then  tobuy = "buy vesthelm;"  end
    if primary > 0 then  tobuy = tobuy..primary_w[primary]..";"  end   
    if secondary > 0 then tobuy = tobuy..secondary_w[secondary]..";" end
    if buybot_nades:GetValue() then  tobuy = tobuy.."buy hegrenade;buy molotov;buy smokegrenade;" end
    if buybot_zeus:GetValue() then tobuy = tobuy.."buy taser;" end
    if buybot_defuser:GetValue() then tobuy = tobuy.."buy defuser;" end
    client.Command(tobuy, false)
 end
     end



callbacks.Register( "FireGameEvent", Hooked_Events)
