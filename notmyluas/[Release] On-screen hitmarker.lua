-- Scraped by chicken
-- Author: bongoman
-- Title [Release] On-screen hitmarker
-- Forum link https://aimware.net/forum/thread/88910

--created by bongoman
alpha = 0


function hitmarker()
local screencenterX, screencenterY = draw.GetScreenSize() --getting the full screensize
screencenterX = screencenterX / 2; screencenterY = screencenterY / 2 --dividing the screensize by 2 will place it perfectly in the center no matter what resolution
draw.Color( 255, 255, 255, alpha)

draw.Line(screencenterX - 7, screencenterY + 7, screencenterX, screencenterY)
draw.Line(screencenterX - 7, screencenterY - 7, screencenterX, screencenterY)
draw.Line(screencenterX + 7, screencenterY + 7, screencenterX, screencenterY)
draw.Line(screencenterX + 7, screencenterY - 7, screencenterX, screencenterY)
if(alpha > 0) then
	alpha = alpha - 2.5
	end
end


function enemyhit(event)
	if(event:GetName() == "player_hurt") then --if the game event "player_hurt" gets called then
		local attacker = event:GetInt("attacker") --getting the attacker
		local attackerindex = client.GetPlayerIndexByUserID(attacker) --retrieves the attackers entity index by using the GetPlayerIndexByUserID function aimwares api provides us
		if(attackerindex == client.GetLocalPlayerIndex()) then --if the attackers index for the player who got hurt matches the localplayer index, it means we're the attacker
		alpha = 255
		end
	end
end

callbacks.Register( "FireGameEvent", "enemyhitfunction", enemyhit)
callbacks.Register( "Draw", "hitmarker", hitmarker)
