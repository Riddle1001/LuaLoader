-- Scraped by chicken
-- Author: ambien55
-- Title [Release] Long q  Invisible weapon
-- Forum link https://aimware.net/forum/thread/103021

local counter = 0
local function switch()
 client.Command('slot3', true)
 client.Command('lastinv', true)
 last = globals.RealTime()
end

callbacks.Register("Draw", function()
 local player = entities.GetLocalPlayer()
 if (player == nil) then
  return
 end

 local weapon = player:GetPropEntity('m_hActiveWeapon')
 if (weapon == nil) then
  return
 end

 if(input.IsButtonDown(81)) then
  counter = counter + 0.02
  if(counter > 2) then
   switch()
  end
 else
  counter = 0
 end
end)

