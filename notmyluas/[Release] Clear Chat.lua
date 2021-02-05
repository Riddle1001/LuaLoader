-- Scraped by chicken
-- Author: zack
-- Title [Release] Clear Chat
-- Forum link https://aimware.net/forum/thread/89314


local SetMisc = gui.Reference('SETTINGS', "Miscellaneous"); 
local Clear_Chat = gui.Checkbox( SetMisc, "Clear_Chat", "Clear Chat", false);
local Clear_Chat_spd = gui.Slider(SetMisc, "Clear_Chat_spd", "Clear Chat Speed", 22, 1, 100)
local spammedlast = globals.TickCount()
function spammer()
if Clear_Chat:GetValue() then
 if globals.TickCount() - spammedlast > Clear_Chat_spd:GetValue() then
  client.ChatSay("﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽")
  spammedlast = globals.TickCount()
end end end
callbacks.Register( "Draw", "spams", spammer);



