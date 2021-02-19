-- Scraped by chicken
-- Author: Rickyy
-- Title [Release] ESP On Dead
-- Forum link https://aimware.net/forum/thread/129561

local t = {
    ["esp.overlay.enemy.name"] = {0, 1},
    ["esp.chams.enemy.occluded"] = {0, 2},
    ["esp.overlay.enemy.scoped"] = {0, 1},
    ["esp.overlay.enemy.reloading"] = {0,  1},
    ["esp.overlay.enemy.health.healthnum"] = {0, 1},
    ["esp.overlay.enemy.weapon"] = {0, 1},
    ["esp.overlay.enemy.box"] = {0, 2},
    ["esp.overlay.enemy.hasdefuser"] = {0, 1},
    ["esp.overlay.enemy.hasc4"] = {0, 1},
    ["esp.overlay.enemy.barrel"] = {0, 1}
}
local toggle = false
callbacks.Register( "Draw", function()
    if input.IsButtonReleased(78) then toggle = not toggle end
    local a = 1
    if entities.GetLocalPlayer() == nil then return end
    if not entities.GetLocalPlayer():IsAlive() or toggle then a = 2 end
    for k, v in pairs(t) do
        gui.SetValue( k, v[a] )
    end
  if a == 2 then
   local w, h = draw.GetScreenSize()
   draw.SetFont(draw.CreateFont("Tahoma", 25, 100))
   draw.Color(128, 0, 0, 255)
   draw.TextShadow(w * 0.174, h - 35, "Visuals")
  end
end)