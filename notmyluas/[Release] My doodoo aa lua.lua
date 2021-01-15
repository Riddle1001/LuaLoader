-- Scraped by chicken
-- Author: TheSeekk1111
-- Title [Release] My doodoo aa lua
-- Forum link https://aimware.net/forum/thread/128975

local reffer = gui.Reference("Ragebot", "Anti-Aim")
local dahomies = gui.Groupbox(reffer, "seekk",17, 650, 296, 400)
local rotation = gui.Slider(dahomies, "limit", "Rotation", 1, -58, 58)
local freq = gui.Slider(dahomies, "frequency", "Rotation Speed", 1, -100, 100)
local offset = gui.Slider(dahomies, "Offset", "Rotation Offset", 1, -58, 58)
local lbyrot = gui.Slider(dahomies, "lbylimit", "LBY Rotation", 1, -180, 180)
local lbyfreq = gui.Slider(dahomies, "lbyfrequency", " LBY Speed", 1, -100, 100)
local lbycenter = gui.Slider(dahomies, "lbycenter", " LBY Offset", 1, -180, 180)
local slowlimit = gui.Slider(dahomies, "pitchlimit", "Pitch Jitter Height", 1, 0, 2)
local slowspeed = gui.Slider(dahomies, "pitchspeed", "Pitch Jitter Speed", 1, -100, 100)
local function mathstuff()
  maths1 = (gui.GetValue("rbot.antiaim.limit") * math.cos((globals.RealTime()) / (gui.GetValue("rbot.antiaim.frequency")*(0.01)))+ gui.GetValue("rbot.antiaim.Offset"))
  gui.SetValue("rbot.antiaim.base.rotation", maths1)
  maths2= (gui.GetValue("rbot.antiaim.lbylimit") * math.cos((globals.RealTime()) / (gui.GetValue("rbot.antiaim.lbyfrequency")*(0.01)))+ gui.GetValue("rbot.antiaim.lbycenter"))
  gui.SetValue("rbot.antiaim.base.lby", maths2)
  maths3 = (gui.GetValue("rbot.antiaim.pitchlimit") * math.cos((globals.RealTime()) / (gui.GetValue("rbot.antiaim.pitchspeed")*(0.01))))
end
local reffer2 = gui.Reference("Ragebot", "Anti-Aim","Advanced" )
local hahafunny = gui.Combobox(reffer2, "yes", "Pitch Options", "Default", "Legit AA", "Jitter" )
local function comb()
  local reee = (hahafunny:GetValue());
    if ( reee == 0 ) then
      gui.SetValue("rbot.antiaim.advanced.pitch", 1)  
      gui.SetValue( "rbot.antiaim.base", 180 ) 
    elseif (reee == 1 ) then
      gui.SetValue( "rbot.antiaim.advanced.pitch", 0 )
      gui.SetValue( "rbot.antiaim.base", 1 )  
    elseif (reee == 2 ) then
      gui.SetValue("rbot.antiaim.advanced.pitch", maths3)  
      gui.SetValue( "rbot.antiaim.base", 180 ) 
    end
end
callbacks.Register( "Draw",comb)
callbacks.Register("Draw",mathstuff)