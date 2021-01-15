-- Scraped by chicken
-- Author: arpac
-- Title [Release] PugSetup/Get5 Chat Spam
-- Forum link https://aimware.net/forum/thread/88264


local last_spam  = globals.TickCount()

function Flooder()
   if globals.TickCount() - last_spam > 6 then
       client.Command("sm_pause")
       client.Command("sm_unpause")
       last_spam = globals.TickCount()
   end
end

callbacks.Register( "Draw", "Flooder", Flooder);
