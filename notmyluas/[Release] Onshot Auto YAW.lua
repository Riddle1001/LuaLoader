-- Scraped by chicken
-- Author: burccer
-- Title [Release] Onshot Auto YAW
-- Forum link https://aimware.net/forum/thread/150991

local base = 180
local function on_draw()
  gui.SetValue("rbot.antiaim.base", base)
end

--inspect weapon fire

local function weapon_fire(event)

  if event:GetName() and event:GetName() == "weapon_fire" then

    local lp_index = client.GetLocalPlayerIndex()
    local userid = client.GetPlayerIndexByUserID(event:GetInt("userid"))
    local attacker = client.GetPlayerIndexByUserID(event:GetInt("attacker"))

    if (userid == lp_index and attacker ~= lp_index) then
      base = base == 160 and -160 or 160
    end
  end
end

--callbacks

client.AllowListener("weapon_fire")
callbacks.Register("FireGameEvent", weapon_fire)
callbacks.Register("Draw", on_draw)