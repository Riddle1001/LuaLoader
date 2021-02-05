-- Scraped by chicken
-- Author: zack
-- Title [Release] Hud Thing
-- Forum link https://aimware.net/forum/thread/90588


local E_GetLocalPlayer, draw_color, draw_text = entities.GetLocalPlayer, draw.Color, draw.Text
function hudthing()
if E_GetLocalPlayer() ~= nil then
local x, y = draw.GetScreenSize()
local local_player = E_GetLocalPlayer()
local fontf = draw.CreateFont("Calibri", 20); local fontz = draw.CreateFont("Calibri", 35); local fonta = draw.CreateFont("Calibri", 27); local ff = draw.CreateFont("Tahoma")
draw.SetFont(fontf)
local hp = local_player:GetProp("m_iHealth")
local armor = local_player:GetProp("m_ArmorValue")
local vx = local_player:GetPropFloat( "localdata", "m_vecVelocity[0]" );
local vy = local_player:GetPropFloat( "localdata", "m_vecVelocity[1]" );
local speed = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))
local Weapon = local_player:GetPropEntity("m_hActiveWeapon")
if Weapon == nil then return; end
local ammo = Weapon:GetProp("m_iClip1")
local cWep = Weapon:GetClass()
local WepName = string.gsub(cWep, "Weapon", "") and string.gsub(cWep, "C", "");

local money = E_GetLocalPlayer():GetProp("m_iAccount");
local inBuyZone = E_GetLocalPlayer():GetProp("m_bInBuyZone")
local haskit = E_GetLocalPlayer():GetProp("m_bHasDefuser")
local team = E_GetLocalPlayer():GetProp("m_iTeamNum")
client.SetConVar("hidehud", 8200, true)-- hides default hud

if hp == 0 then return end
draw_color(255, 255, 255, 235)
draw_text((x/2)-115, y-20, "HP")
draw_color(159, 202, 43, 255)
if hp == 100 then
draw_text((x/2)-119, y-35, hp)
elseif hp < 100 and hp > 10 then
draw_text((x/2)-114, y-35, hp); 
elseif hp < 10 then
draw_text((x/2)-110, y-35, hp); end

draw_color(255, 255, 255, 235)
draw_text((x/2)-67, y-20, "ARMOR")
draw_color(52, 152, 219, 255)
if armor == 0 then
draw_text((x/2)-46, y-35, armor);
elseif armor == 100 then
draw_text((x/2)-55, y-35, armor); 
else
draw_text((x/2)-50, y-35, armor); 
end

if vx ~= nil then
draw_color(255,255,255,235)
draw_text((x/2)+16,y-20, "SPEED")
draw_color(255,255,255,255) 
if speed == 0 then 
draw_text((x/2)+32,y-35, speed); 
else  
draw_text((x/2)+26,y-35, speed); end end
if ammo == -1 then draw.SetFont(fonta); ammo = WepName end 
if ammo ~= WepName and ammo > 9 then
draw_color(255,255,255,255) 
draw_text((x/2)+87, y-20, "AMMO"); draw_text((x/2)+102, y-35, ammo); 
elseif ammo ~= WepName and ammo <= 9 and ammo >= 0 then
draw_text((x/2)+87, y-20, "AMMO"); draw_text((x/2)+106, y-35, ammo); end
if ammo == "MolotovGrenade" then ammo = "Molotov"
	draw_text((x/2)+86, y-30, ammo);
elseif ammo == "Flashbang" then 
	draw_text((x/2)+87, y-30, ammo);
elseif ammo == "SmokeGrenade" then ammo = "Smoke"
	draw_text((x/2)+86, y-30, ammo);
elseif ammo == "HEGrenade" then ammo = "Grenade"
	draw_text((x/2)+86, y-30, ammo);
elseif ammo == "Knife" then
	draw_text((x/2)+86, y-30, ammo);
elseif ammo == "DecoyGrenade" then ammo = "Decoy"
	draw_text((x/2)+86, y-30, ammo);
elseif ammo == "4" then ammo = "C4"
	draw_text((x/2)+95, y-30, ammo);	end 
if team == 3 then 
if haskit == 0 then
draw_color(255,75,75,255); draw_text((x/2)+149, y-27, "Defuser");
else
draw_color(75,75,255,255); draw_text((x/2)+149, y-27, "Defuser"); end end
draw.SetFont(fontz)
if inBuyZone == 1 then
draw_color(255,255,255,255); draw_text(31, (y/2)-65, "$".. money); end
end 
draw.SetFont(ff); end

callbacks.Register("Draw", "aaa", hudthing); 
