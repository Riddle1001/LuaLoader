-- Scraped by chicken
-- Author: ambien55
-- Title [Release] Random Skins, Auto Defuse, Door Spam
-- Forum link https://aimware.net/forum/thread/100738

local flip = false
local is_in_buyzone = false

client.AllowListener('enter_buyzone')
client.AllowListener('exit_buyzone')
client.AllowListener('client_disconnect')
callbacks.Register('FireGameEvent', function(event)
 if (event:GetName() == "enter_buyzone") then
  local player = entities.GetByUserID(event:GetInt("userid"))
  if (player == nil) then return end
  if (player:GetIndex() == entities.GetLocalPlayer():GetIndex()) then
   if (event:GetInt("canbuy") == 1) then
    is_in_buyzone = true
   end
  end
 elseif (event:GetName() == "exit_buyzone") then
  local player = entities.GetByUserID(event:GetInt("userid"))
  if (player == nil) then return end
  if (player:GetIndex() == entities.GetLocalPlayer():GetIndex()) then
   is_in_buyzone = false
  end
 elseif (event:GetName() == "client_disconnect") then
  is_in_buyzone = false
 end
end)

callbacks.Register("CreateMove", function(cmd)
 if (entities.GetLocalPlayer() == nil or engine.GetServerIP() == nil) then return end
 if (is_in_buyzone) then return end
 
 if (input.IsButtonDown(67)) then
  if (flip) then
   cmd:SetButtons(cmd:GetButtons() & ~(1 << 5))
  else
   cmd:SetButtons(cmd:GetButtons() | (1 << 5))
  end

  flip = not flip
 end
end)
