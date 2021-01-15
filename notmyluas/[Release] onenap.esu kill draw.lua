-- Scraped by chicken
-- Author: BigTrap
-- Title [Release] onenap.esu kill draw
-- Forum link https://aimware.net/forum/thread/109384

local kills = 0
local ktime = 0
local alpha = 0
function KillEvent(Event)
 if (Event:GetName() == 'player_death') then
   local lp = client.GetLocalPlayerIndex()
   local uid = Event:GetInt('userid')
   local attacker = Event:GetInt('attacker')
   local vicname = client.GetPlayerNameByUserID(uid)
   local vicindex = client.GetPlayerIndexByUserID(uid)
   local attname = client.GetPlayerNameByUserID(attacker)
   local attindex = client.GetPlayerIndexByUserID(attacker)
   if ( attindex == lp and vicindex ~= lp ) then
  ktime = globals.RealTime()
  kills = kills + 1
   end
 end
end
function RoundStart(Event)
if (Event:GetName() == 'round_start') then
kills = 0
end
end
local VerdanaCustom = draw.CreateFont("Verdana", 35, 700)
function Textx(x, y, text, r, g, b, a)
draw.SetFont(VerdanaCustom)
draw.Color(r, g, b, a)
draw.Text(x, y, text)
end
local animationAlpha = 0
function KillDraw()
local screen_sizex, screen_sizey = draw.GetScreenSize()
local animation_speed_value = 0.6
local step = 255 / 0.6 * globals.FrameTime()
if ktime + 0.4 > globals.RealTime() then
 alpha = 255
else
 alpha = alpha - step
end
local animationStep = 255 / animation_speed_value * globals.FrameTime()
if ktime + 0.1 > globals.RealTime() then
 animationAlpha = - 80
else
 animationAlpha = animationAlpha - animationStep
end
    if (alpha > 0) then
 if(kills == 1) then
      Textx(screen_sizex / 2 + 1 - 150, screen_sizey / 2 + animationAlpha + 2, "FIRST BLOOD", 0, 0, 0, math.floor(alpha))
      Textx(screen_sizex / 2 - 150, screen_sizey / 2 + animationAlpha, "FIRST BLOOD", 255, 50, 0, math.floor(alpha))
 end
 if(kills == 2) then
      Textx(screen_sizex / 2 + animationAlpha + 1, screen_sizey / 2 + animationAlpha + 2, "DOUBLEKILL", 0, 0, 0, math.floor(alpha))
      Textx(screen_sizex / 2 + animationAlpha, screen_sizey / 2 + animationAlpha, "DOUBLEKILL", 0, 0, 255, math.floor(alpha))
 end
 if( kills == 4) then
      Textx(screen_sizex / 2 - animationAlpha + 1, screen_sizey / 2 + animationAlpha + 2, "MULTIKILL", 0, 0, 0, math.floor(alpha))
      Textx(screen_sizex / 2 - animationAlpha, screen_sizey / 2 + animationAlpha, "MULTIKILL", 0, 255, 0, math.floor(alpha))
 end
 if( kills == 6) then
      Textx(screen_sizex / 2 + animationAlpha + 1, screen_sizey / 2 - animationAlpha + 2, "GODLIKE", 0, 0, 0, math.floor(alpha))
      Textx(screen_sizex / 2 + animationAlpha, screen_sizey / 2 - animationAlpha, "GODLIKE", 255, 0, 0, math.floor(alpha))
 end
 if( kills == 8) then
      Textx(screen_sizex / 2 - animationAlpha + 1, screen_sizey / 2 - animationAlpha + 2, "MONSTERKILL", 0, 0, 0, math.floor(alpha))
      Textx(screen_sizex / 2 - animationAlpha, screen_sizey / 2 - animationAlpha, "MONSTERKILL", 255, 0, 255, math.floor(alpha))
 end
 if( kills == 10) then
      Textx(screen_sizex / 2 + animationAlpha + 1, screen_sizey / 2 + animationAlpha + 2, "UNSTOPPABLE", 0, 0, 0, math.floor(alpha))
      Textx(screen_sizex / 2 + animationAlpha, screen_sizey / 2 + animationAlpha, "UNSTOPPABLE", 0, 255, 255, math.floor(alpha))
 end
 if( kills == 12) then
      Textx(screen_sizex / 2 - animationAlpha + 1, screen_sizey / 2 + animationAlpha + 2, "WHICKEDSICK", 0, 0, 0, math.floor(alpha))
      Textx(screen_sizex / 2 - animationAlpha, screen_sizey / 2 + animationAlpha, "WHICKEDSICK", 255, 255, 0, math.floor(alpha))
 kills = 0
 end
end
end
client.AllowListener('player_death')
client.AllowListener('round_start')
callbacks.Register('FireGameEvent', 'KillEvent', KillEvent)
callbacks.Register('FireGameEvent', 'RoundStart', RoundStart)
callbacks.Register('Draw', 'KillDraw', KillDraw)
