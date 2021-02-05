-- Scraped by chicken
-- Author: adrianobessa5682
-- Title [Release] FullBright [V5]
-- Forum link https://aimware.net/forum/thread/127877

print("Loaded Aimware FullBright Lua by Starlordaiden")
local client_SetConVar = client.SetConVar
local ref = gui.Reference("Visuals", "World", "Extra");
local fullbright = gui.Checkbox(ref, "fulbright", "Full Bright", false)
function full_bright()
  if fullbright:GetValue() then client_SetConVar("mat_fullbright", 1, true);
    else 
  client_SetConVar("mat_fullbright", 0, true);
  end 
  end
callbacks.Register('Draw', "FullBright" ,full_bright);

