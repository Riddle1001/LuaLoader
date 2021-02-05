-- Scraped by chicken
-- Author: oWoShovo
-- Title [Release] OnShot FakeDuck
-- Forum link https://aimware.net/forum/thread/106036

local keys = {}
function Insert(n,m) for i=n,m do table.insert(keys, i) end end
Insert(112,135)Insert(65,90)Insert(48,57)Insert(16,18)
local activated = false
function player(event) return (client.GetPlayerIndexByUserID(event:GetInt("userid")) == client.GetLocalPlayerIndex()) end
function keydown() local key = 0; for i=1,#keys do key = key + 1 if input.IsButtonDown(keys[key]) then return keys[key] end end end
function FakeDuck(event) if (player(event)) then if (event:GetName() == "weapon_fire" ) then if activated then gui.SetValue("rbot_antiaim_fakeduck", keydown() ) gui.SetValue("msc_fastduck", true) else gui.SetValue("rbot_antiaim_fakeduck", 0 ) end   end end end


callbacks.Register( "Draw", function()
 if input.IsButtonPressed(20) then activated = not activated if activated == false then gui.SetValue("rbot_antiaim_fakeduck", 0 )end end
   local text = "[Mode]: " .. (activated == true and "ON" or "OFF")
      local textW, textH = draw.GetTextSize(text);
      draw.Color(150, 185, 1, 255);
      draw.FilledRect(0, 580, textW + 30, 580 + textH + 20);
      draw.Color(16, 0, 0, 255);
      draw.FilledRect(0, 580, textW + 20, 580 + textH + 20);
      draw.Color(255, 255, 255, 255);
      draw.Text(10, 580 + 10, text);
end)

client.AllowListener( 'weapon_fire' );
callbacks.Register("FireGameEvent", FakeDuck)

