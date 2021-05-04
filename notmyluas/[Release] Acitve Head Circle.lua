-- Scraped by chicken
-- Author: 2878713023
-- Title [Release] Acitve Head Circle
-- Forum link https://aimware.net/forum/thread/151108

localfunctionrequire(name,url)
package=packageor{}

package.loaded=package.loadedor{}

package.loaded[name]=
package.loaded[name]orRunScript(name..".lua")or
http.Get(
url,
function(body)
file.Write(name..".lua",body)
end
)

returnpackage.loaded[name]orerror("unabletoloadmodule"..name.."(trytoreload)",2)
end
localdraw=require("libraries/draw","https://aimware28.coding.net/p/coding-code-guide/d/aim_lib/git/raw/master/draw/draw.lua?download=false")

localfunctionclamp(val,min,max)
ifval>maxthen
returnmax
elseifval<minthen
returnmin
end
returnval
end

localglobals_frametime,globals_CurTime,globals_TickInterval=globals.FrameTime,globals.CurTime,globals.TickInterval
localmath_floor,math_min,math_abs=math.floor,math.min,math.abs
localfunctiontime_to_ticks(a)
returnmath_floor(1+a/globals_TickInterval())
end

localalpha=0

localfunctionon_draw()
locallp=entities.GetLocalPlayer()

ifnot(lpandlp:IsAlive())then
return
end
localfade=((1.0/0.15)*globals_frametime())*100

locallp_head_Pos=lp:GetHitboxPosition(0)
localx,y=client.WorldToScreen(Vector3(lp_head_Pos.x,lp_head_Pos.y,lp_head_Pos.z+20))

localhealth=lp:GetHealth()or0

ifxandythen
draw.color(4,4,4,150)

alpha=health~=100andclamp(alpha-fade,health,100)orclamp(alpha+fade,0,health)
draw.color(4,4,4,150)
draw.circle_outline(x-80,y,24,0,1,18,10)
draw.color(49,199,50)
draw.circle_outline(x-80,y,23,0,alpha*0.01,16,10)

localdiff=engine.GetViewAngles().y-(lp:GetHitboxPosition(0)-lp:GetAbsOrigin()):Angles().y
localang=(diff*-1)/8
localang=ang<0and22.5+(22.5-math_abs(ang))orang

draw.color(4,4,4,150)
draw.circle_outline(x-80,y,32,0,1,7,10)
draw.color(49,199,50)
draw.circle_outline(x-80,y,31,0,math_min(ang*0.05,1),5,10)

localfl=time_to_ticks(globals_CurTime()-lp:GetPropFloat("m_flSimulationTime"))+2

draw.color(4,4,4,150)
draw.circle_outline(x-80,y,40,0,1,7,10)
draw.color(49,199,50)
draw.circle_outline(x-80,y,39,0,math_min(fl*0.05,1),5,10)
end
end
callbacks.Register("Draw",on_draw)


