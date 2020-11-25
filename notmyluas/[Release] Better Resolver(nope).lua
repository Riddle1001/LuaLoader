-- Scraped by chicken
-- Author: Loyisa
-- Title [Release] Better Resolver(nope)
-- Forum link https://aimware.net/forum/thread/144758

functionbetterResolver()
if(resolver:GetValue()~=true)then
return
end
if(gui.GetValue("rbot.master")~=true)then
return
end
gui.SetValue("rbot.hitscan.maxprocessingtime",math.random(5,75))
end

callbacks.Register("Draw","betterResolver",betterResolver);

functionUI()
resolver=gui.Checkbox(gui.Reference("Ragebot","Hitscan","Advanced"),"betteresolver","BetterResolver",0);
resolver:SetDescription("Resolverenhancer");
end
UI();
