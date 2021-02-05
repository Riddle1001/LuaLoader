-- Scraped by chicken
-- Author: Squiddler
-- Title [Release] DoubleFire On Key
-- Forum link https://aimware.net/forum/thread/109108

local rage_ref = gui.Reference("RAGE", "MAIN","EXTRA")

local Doubletap = gui.Keybox( rage_ref, "DoubleTapKey", "Double Fire Key", 0 )

  function DoubleTapActive()
 if Doubletap:GetValue() ~= 0 then
 if input.IsButtonDown(Doubletap:GetValue()) then
 return true
 else 
 return false
 end
 end
 end
  local function Main()
 w, h = draw.GetScreenSize()
 draw.SetFont(RenderFont)
  draw.Color(0, 230, 0, 230)

 if DoubleTapActive() == true then
 draw.SetFont(RenderFontHB)
 draw.Text(w/2 - 30, h/2 + 30, "DOUBLETAP")
 
 gui.SetValue('msc_fakelag_enable', 0)
 gui.SetValue('rbot_doublefire', 1)
 else
 gui.SetValue('msc_fakelag_enable', 1)
 gui.SetValue('rbot_doublefire', 0)
 end
 end

callbacks.Register( "Draw", "DoubleFireKey", Main);



