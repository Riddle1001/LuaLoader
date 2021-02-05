-- Scraped by chicken
-- Author: cheatingcuzbad
-- Title [Release] 8 rainbow RGB LUAs
-- Forum link https://aimware.net/forum/thread/127158

function rainbowesp()

 local speed = 2
 local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
 local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
 local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
 local a = 255
 
 for k,v in pairs({ "insert color commands in between quotes.",
           "",
           "",
           "",
           "",
           "",
           ""}) do
           
   gui.SetValue(v, r,g,b,a)
   
 end
end

callbacks.Register( "Draw", "uwu", rainbowesp);
