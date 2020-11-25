-- Scraped by chicken
-- Author: AppleJeb
-- Title [RELEASE] Coronavirus reminder
-- Forum link https://aimware.net/forum/thread/129686

local api_link = "https://corona.lmao.ninja/all"
local function getField(str, field)
	return str:match("\"" .. field .. "\"%:(%d+)")
end

local function updateStats(callback)
	http.Get(api_link, function(b)
		if not b then print("Corona stats updating failed") return end
		local cases = getField(b, "cases")
		local deaths = getField(b, "deaths")
		local recovered = getField(b, "recovered")

		if callback then callback{ cases = cases, deaths = deaths, recovered = recovered} end
	end)
end

local function getStoredData()
	local handle = file.Open("corona_stats.dat", "r")
	if not handle then return end
	local data = handle:Read()
	handle:Close()

	return {
		cases = getField(data, "cases"),
		deaths = getField(data, "deaths"),
		recovered = getField(data, "recovered"),
	}
end

local function storeData(data)
	local str = ""
	for k, v in pairs(data) do
		str = str .. string.format("\"%s\":%d\n", k, v)
	end

	local f = file.Open("corona_stats.dat", "w")
	f:Write(str)
	f:Close()
end

local prefix = "Corona Reminder"

client.AllowListener("round_start")
client.AllowListener("cs_win_panel_match")

local function sayStats(ended)
	updateStats(function(coronaData)
		local data = getStoredData()
		local shouldCompare = data ~= nil
		local sayText

		if shouldCompare then
			local cases_diff, recover_diff, deaths_diff
				= coronaData.cases - data.cases,
				coronaData.recovered - data.recovered,
				coronaData.deaths - data.deaths

			sayText = string.format(
				prefix .. " Cases %d (%s last round) / Recovered %d (%s) / Deaths %d (%s)%s", 
				coronaData.cases, cases_diff > 0 and "+" .. cases_diff or cases_diff, 
				coronaData.recovered, recover_diff > 0 and "+" .. recover_diff or recover_diff, 
				coronaData.deaths, deaths_diff > 0 and "+" .. deaths_diff or deaths_diff, 
				ended and " Thanks for playing! Be safe" or "")
		else
			sayText = string.format(prefix .. " Cases %d / Recovered %d / Deaths %d", coronaData.cases, coronaData.recovered, coronaData.deaths)
		end

		storeData(coronaData)
		client.ChatSay(sayText)
	end)
end

callbacks.Register("FireGameEvent", function(ev)
	if ev:GetName() == "round_start" then
		sayStats()
	end

	if ev:GetName() == "cs_win_panel_match" then
		sayStats(true)
	end
end)