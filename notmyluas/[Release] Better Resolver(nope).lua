-- Scraped by chicken
-- Author: Loyisa
-- Title [Release] Better Resolver(nope)
-- Forum link https://aimware.net/forum/thread/144758

function betterResolver()
    if (resolver:GetValue() ~= true) then
        return
    end
    if (gui.GetValue("rbot.master") ~= true) then
        return
    end
    gui.SetValue("rbot.hitscan.maxprocessingtime", math.random(5,75) )
end

callbacks.Register( "Draw", "betterResolver", betterResolver );

function UI()
    resolver = gui.Checkbox(gui.Reference("Ragebot","Hitscan","Advanced"),"betteresolver","Better Resolver",0);
    resolver:SetDescription("Resolver enhancer");
end
UI();
