-- Scraped by chicken
-- Author: mshkreli
-- Title [Release] Smoke timer ESP
-- Forum link https://aimware.net/forum/thread/113874

local function ESPCallback(EspBuilder)
	local espEntity = EspBuilder:GetEntity();

	if espEntity:GetClass() == "CSmokeGrenadeProjectile" then
		local diff = globals.TickCount() - espEntity:GetPropInt("m_nSmokeEffectTickBegin");
		local time = math.max(18 - (diff * globals.TickInterval()), 0);
		EspBuilder:AddTextBottom(math.floor((espEntity:GetPropInt("m_nSmokeEffectTickBegin") == 0 and 18 or time) * 10) / 10 .. "s");
	end
end

callbacks.Register("DrawESP", "SmokeESP", ESPCallback);