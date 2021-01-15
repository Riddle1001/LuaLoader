-- Scraped by chicken
-- Author: imacookie
-- Title [Release] GLua timer system
-- Forum link https://aimware.net/forum/thread/86687

local timer = timer or {}
local timers = {}

function timer.Create(name, delay, times, func)

	table.insert(timers, {["name"] = name, ["delay"] = delay, ["times"] = times, ["func"] = func, ["lastTime"] = globals.RealTime()})

end

function timer.Remove(name)

	for k,v in pairs(timers or {}) do
	
		if (name == v["name"]) then table.remove(timers, k) end
	
	end

end

function timer.Tick()

	for k,v in pairs(timers or {}) do
	
		if (v["times"] <= 0) then table.remove(timers, k) end
		
		if (v["lastTime"] + v["delay"] <= globals.RealTime()) then 
			timers[k]["lastTime"] = globals.RealTime()
			timers[k]["times"] = timers[k]["times"] - 1
			v["func"]() 
		end
	
	end

end

callbacks.Register( "Draw", "timerTick", timer.Tick);

timer.Create("test", 1, 2, function() print("hey") end)