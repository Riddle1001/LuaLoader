-- Scraped by chicken
-- Author: XITERE
-- Title [Release] Randomize Lby Angles
-- Forum link https://aimware.net/forum/thread/88112

function randlby() 
gui.SetValue( "rbot_antiaim_stand_lby_delta", math.random(-120,120))
gui.SetValue( "rbot_antiaim_stand_lby", math.random(1,2))
end

callbacks.Register( "Draw", "randlby", randlby);