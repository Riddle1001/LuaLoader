-- Scraped by chicken
-- Author: zack
-- Title [Release] AutoBuy Bot
-- Forum link https://aimware.net/forum/thread/89239


-- Original Buy bot https://aimware.net/forum/thread-87473.html -- In Menu LUA
local msc_p2 = gui.Reference('MISC', "Part 2")
local GroupBox = gui.Groupbox( msc_p2, "AutoBuy Settings", 0, 888, 213, 240 );
local ActiveCheckBox = gui.Checkbox(GroupBox, "ActiveCheckBox", "Activate", false)
local PrimaryWeapons = gui.Combobox( GroupBox, 'PrimaryWeapons', "Primary Weapons", "Off", "AK-47 | M4", "Scout", "AWP","Auto")
local SecondaryWeapons = gui.Combobox( GroupBox, 'SecondaryWeapons', "Secondary Weapons", "Off", "Elite", "P250", "Tec-9 | Five-Seven ", "R8 | Deagle")
local Nades = gui.Checkbox( GroupBox, "Nades", "Grenades", false);
local Zeus = gui.Checkbox( GroupBox, "Zeus", "Zeus", false);
local Armor = gui.Checkbox( GroupBox, "Armor", "Armor", false);
local Defuser = gui.Checkbox( GroupBox, "Defuser", "Defuser", false);

local money = 0
local sleep = 0
local buy_act = false
function autobuy(Event)
 if (entities.GetLocalPlayer() ~= nil) then
   money = entities.GetLocalPlayer():GetProp("m_iAccount")
 end
 if ActiveCheckBox:GetValue() then
   if Event:GetName() == "round_start" then
     buy_act = true
     sleep = globals.TickCount()
end end end

function buy()
 if buy_act == true and globals.TickCount() - sleep > 32 then
   buy_act = false
   sleep = globals.TickCount()
 if (SecondaryWeapons:GetValue() == 0) then
   elseif (SecondaryWeapons:GetValue() == 1) then
     client.Command("buy elite", true)
   elseif (SecondaryWeapons:GetValue() == 2) then
     client.Command("buy p250", true)
   elseif (SecondaryWeapons:GetValue() == 3) then
     client.Command("buy tec9", true)
   elseif (SecondaryWeapons:GetValue() == 4) then
     client.Command("buy deagle", true)
end
   if (money > 199) then
     if Zeus:GetValue() then
       client.Command("buy Taser", true)
     end end

   if (money > 2200) then
 if (PrimaryWeapons:GetValue() == 0) then
     elseif (PrimaryWeapons:GetValue() == 1) then
 client.Command("buy ak47", true)
     elseif (PrimaryWeapons:GetValue() == 2) then
       client.Command("buy ssg08", true)
     elseif (PrimaryWeapons:GetValue() == 3) then
       client.Command("buy awp", true)
     elseif (PrimaryWeapons:GetValue() == 4) then
 client.Command("buy scar20", true)
     end

     if Armor:GetValue() then client.Command("buy vest; buy vesthelm"); end
 if Nades:GetValue() then client.Command("buy hegrenade; buy incgrenade; buy molotov; buy smokegrenade; buy flashbang", true); end
     if Defuser:GetValue() then client.Command("buy defuser");
     end end end end

client.AllowListener('round_start');
callbacks.Register("FireGameEvent", "autobuy", autobuy);
callbacks.Register("Draw", "buy", buy);




