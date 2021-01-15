-- Scraped by chicken
-- Author: Bean07
-- Title [Release] Fakeduck fix for users with no fakelag
-- Forum link https://aimware.net/forum/thread/129301


local fl_enable,flpeek_enable;

callbacks.Register("Draw", function()
if gui.GetValue("rbot.antiaim.advanced.fakecrouchkey") ~= 0 then
if input.IsButtonDown(gui.GetValue("rbot.antiaim.advanced.fakecrouchkey")) then
gui.SetValue("misc.fakelag.enable", 1)
gui.SetValue("misc.fakelag.peek", 0)
else
gui.SetValue("misc.fakelag.enable", fl_enable)
gui.SetValue("misc.fakelag.peek", flpeek_enable)
fl_enable = gui.GetValue("misc.fakelag.enable")
flpeek_enable = gui.GetValue("misc.fakelag.peek")
end
end
end)

