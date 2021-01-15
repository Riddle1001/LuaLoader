-- Scraped by chicken
-- Author: Chicken4676
-- Title [Release] FD Fix (maybe)
-- Forum link https://aimware.net/forum/thread/145338

local aw_wep_names = {"shared", "pistol", "hpistol", "smg", "rifle", "shotgun", "asniper", "lmg"}
local cached_dt_state = {}

local fd_key = gui.GetValue("rbot.antiaim.extra.fakecrouchkey")
gui.SetValue("rbot.antiaim.extra.fakecrouchkey", 0)

gui.SetValue("misc.fakelag.enable", true)
gui.SetValue("misc.fakelag.factor", 14)

for k, v in pairs(aw_wep_names) do
	cached_dt_state[v] = gui.GetValue("rbot.accuracy.weapon." .. v .. ".doublefire")
end

local fd_time_logged = false
local fd_presed_time = 0
local should_fd = false
callbacks.Register("Draw", function()
	if input.IsButtonDown(fd_key) and not fd_time_logged then
		fd_presed = globals.CurTime()
		fd_time_logged = true
			for k, v in pairs(aw_wep_names) do
				gui.SetValue("rbot.accuracy.weapon." .. v .. ".doublefire", false)
			end
			gui.SetValue("rbot.antiaim.extra.fakecrouchkey", 0)
	elseif not input.IsButtonDown(fd_key) then
		for k, v in pairs(cached_dt_state) do
			gui.SetValue("rbot.accuracy.weapon." .. k .. ".doublefire", v)
		end
		
		should_fd = false
		fd_time_logged = false
	end
	
	if input.IsButtonDown(fd_key) then
		if globals.CurTime() - 0.05 > fd_presed then
			gui.SetValue("rbot.antiaim.extra.fakecrouchkey", fd_key)
		end
	end
end)


callbacks.Register("Unload", function()
	gui.SetValue("rbot.antiaim.extra.fakecrouchkey", fd_key)
end)

