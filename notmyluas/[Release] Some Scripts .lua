-- Scraped by chicken
-- Author: CloudFlare1337
-- Title [Release] Some Scripts 
-- Forum link https://aimware.net/forum/thread/89963

local ui_get, ui_set = gui.GetValue, gui.SetValue

local cache, Level = nil, 0
local g_ViewFov = ui_get("vis_view_fov")
local scope = { [1] = 80, [2] = 45 }

callbacks.Register("Draw", "ZoomFOV", function()
  local g_Local = entities.GetLocalPlayer()
  if not g_Local then return end

  local g_Weapon = g_Local:GetPropEntity("m_hActiveWeapon")
  local m_bIsScoped = g_Local:GetProp("m_bIsScoped")

  if g_Weapon then
  -- Disable anti-zoom
  local m_Scoped = (m_bIsScoped == 1 or m_bIsScoped == 257)
  if m_Scoped then
 local m_zoomLevel = g_Weapon:GetProp("m_zoomLevel")
 Level = scope[m_zoomLevel]
 else
 Level = g_ViewFov
 end

 ui_set("vis_view_fov", Level)

   -- Disable visuals while scoping
  if cache == nil then cache = ui_get("esp_filter_self") end
  if m_Scoped then ui_set("esp_filter_self", 0) else
    if cache ~= nil then
      ui_set("esp_filter_self", cache)
      cache = nil
    end
  end

  end
end)
