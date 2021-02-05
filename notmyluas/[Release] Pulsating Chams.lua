-- Scraped by chicken
-- Author: PUBG Expert
-- Title [Release] Pulsating Chams
-- Forum link https://aimware.net/forum/thread/97574

local GUI_REF = gui.Reference("VISUALS", "MISC", "Yourself Extra")
local OPEN_PULSATING_WINDOW = gui.Checkbox(GUI_REF, "cst_pulsatingmenu_show", "Pulsating Menu", false)
local PULSATING_WINDOW = gui.Window("PULSATING_WINDOW", "Pulsating Menu", 30, 400, 350, 452)
PULSATING_WINDOW:SetActive(0)

local GHOST_GROUPBOX = gui.Groupbox(PULSATING_WINDOW, "Ghost", 10, 15, 160, 192)
  local GHOST_ACTIVE = gui.Checkbox(GHOST_GROUPBOX, "cst_pulsatingchams_ghost", "Enable", false)
  local GHOST_MINOPACITY = gui.Slider(GHOST_GROUPBOX, "cst_pulsatingchams_ghost_minopacity", "Min Opacity", 50, 1, 255)
  local GHOST_MAXOPACITY = gui.Slider(GHOST_GROUPBOX, "cst_pulsatingchams_ghost_maxopacity", "Max Opacity", 160, 1, 255)
  local GHOST_SPEED = gui.Slider(GHOST_GROUPBOX, "cst_pulsatingchams_ghost_speed", "Speed", 2, 1, 10)

local HANDS_GROUPBOX = gui.Groupbox(PULSATING_WINDOW, "Hands", 180, 220, 160, 192)
  local HANDS_ACTIVE = gui.Checkbox(HANDS_GROUPBOX, "cst_pulsatingchams_hands", "Enable", false)
  local HANDS_MINOPACITY = gui.Slider(HANDS_GROUPBOX, "cst_pulsatingchams_hands_minopacity", "Min Opacity", 50, 1, 255)
  local HANDS_MAXOPACITY = gui.Slider(HANDS_GROUPBOX, "cst_pulsatingchams_hands_maxopacity", "Max Opacity", 160, 1, 255)
  local HANDS_SPEED = gui.Slider(HANDS_GROUPBOX, "cst_pulsatingchams_hands_speed", "Speed", 2, 1, 10)

local WEAPONS_GROUPBOX = gui.Groupbox(PULSATING_WINDOW, "Weapons", 10, 220, 160, 192)
  local WEAPONS_ACTIVE = gui.Checkbox(WEAPONS_GROUPBOX, "cst_pulsatingchams_weapons", "Enable", false)
  local WEAPONS_MINOPACITY = gui.Slider(WEAPONS_GROUPBOX, "cst_pulsatingchams_weapons_minopacity", "Min Opacity", 50, 1, 255)
  local WEAPONS_MAXOPACITY = gui.Slider(WEAPONS_GROUPBOX, "cst_pulsatingchams_weapons_maxopacity", "Max Opacity", 160, 1, 255)
  local WEAPONS_SPEED = gui.Slider(WEAPONS_GROUPBOX, "cst_pulsatingchams_weapons_speed", "Speed", 2, 1, 10)

local PMODEL_GROUPBOX = gui.Groupbox(PULSATING_WINDOW, "Player Model", 180, 15, 160, 192)
  local PMODEL_ACTIVE = gui.Checkbox(PMODEL_GROUPBOX, "cst_pulsatingchams_pmodel", "Enable", false)
  local PMODEL_XQZ_ACTIVE = gui.Checkbox(PMODEL_GROUPBOX, "cst_pulsatingchams_pmodel_xqz", "XQZ (invisible color)", false)
  local PMODEL_MINOPACITY = gui.Slider(PMODEL_GROUPBOX, "cst_pulsatingchams_pmodel_minopacity", "Min Opacity", 50, 1, 255)
  local PMODEL_MAXOPACITY = gui.Slider(PMODEL_GROUPBOX, "cst_pulsatingchams_pmodel_maxopacity", "Max Opacity", 160, 1, 255)
  local PMODEL_SPEED = gui.Slider(PMODEL_GROUPBOX, "cst_pulsatingchams_pmodel_speed", "Speed", 2, 1, 10)

local TRANSPARENT_SCOPE_ACTIVE = gui.Checkbox(GUI_REF, "vis_transparentscope", "Transparent Scope", false)
  local TRANSPARENT_SCOPE_OPACITY = gui.Slider(GUI_REF, "vis_transparentscope_opacity", "Model Opacity On Scope", 100, 1, 255)

local MENU_ACTIVE = false

local CT_CHAMS_VAR = "clr_chams_ct_vis"
  local T_CHAMS_VAR = "clr_chams_t_vis"

local CT_CHAMS_INVIS_VAR = "clr_chams_ct_invis"
  local T_CHAMS_INVIS_VAR = "clr_chams_t_invis"

local PRIMARY_WEAPON_VAR = "clr_chams_weapon_primary"
  local SECONDARY_WEAPON_VAR = "clr_chams_weapon_secondary"

local PRIMARY_HANDS_VAR = "clr_chams_hands_primary"
  local SECONDARY_HANDS_VAR = "clr_chams_hands_secondary"

local SERVER_GHOST_VAR = "clr_chams_ghost_server"
  local CLIENT_GHOST_VAR = "clr_chams_ghost_client"

local OLD_CT_R, OLD_CT_G, OLD_CT_B, OLD_CT_A = gui.GetValue(CT_CHAMS_VAR)
  local OLD_T_R, OLD_T_G, OLD_T_B, OLD_T_A = gui.GetValue(T_CHAMS_VAR)

local OLD_PW_R, OLD_PW_G, OLD_PW_B, OLD_PW_A = gui.GetValue(PRIMARY_WEAPON_VAR)
  local OLD_SW_R, OLD_SW_G, OLD_SW_B, OLD_SW_A = gui.GetValue(SECONDARY_WEAPON_VAR)

local OLD_PH_R, OLD_PH_G, OLD_PH_B, OLD_PH_A = gui.GetValue(PRIMARY_HANDS_VAR)
  local OLD_SH_R, OLD_SH_G, OLD_SH_B, OLD_SH_A = gui.GetValue(SECONDARY_HANDS_VAR)

local OLD_GS_R, OLD_GS_G, OLD_GS_B, OLD_GS_A = gui.GetValue(SERVER_GHOST_VAR)
  local OLD_GC_R, OLD_GC_G, OLD_GC_B, OLD_GC_A = gui.GetValue(CLIENT_GHOST_VAR)

local USE_OLD_WEAPON_ALPHA = false
  local USE_OLD_HANDS_ALPHA = false
  local USE_OLD_GHOST_ALPHA = false
  local USE_OLD_PMODEL_ALPHA = false
  local USE_OLD_SCOPEMODEL_ALPHA = false

local GHOST_TYPES = {
  [0] = nil,
  [1] = "client",
  [2] = "server",
  [3] = "both"
}

local function localPlayerExists()
  if (entities.GetLocalPlayer() ~= nil) then
    return true
  else
    return false
  end
end

local function isAlive()
  if (localPlayerExists()) then
    if (entities.GetLocalPlayer():IsAlive()) then
      return true
    else
      return false
    end
  else
    return false
  end
end

local function isScoped()
  if (localPlayerExists() and isAlive() and (entities.GetLocalPlayer():GetProp("m_bIsScoped") == 1 or entities.GetLocalPlayer():GetProp("m_bIsScoped") == 257)) then
    return true
  else
    return false
  end
end

local function getTeam()
  if (localPlayerExists()) then
    return entities.GetLocalPlayer():GetTeamNumber()
  else
    return 1
  end
end

local function getPulsateAlpha(speed, maxAlpha)
  return math.floor(math.abs(math.sin(globals.CurTime() * speed) * maxAlpha))
end

local function getChamsVar()
  if (getTeam() == 3) then
    return CT_CHAMS_VAR, CT_CHAMS_INVIS_VAR
  elseif (getTeam() == 2) then
    return T_CHAMS_VAR, T_CHAMS_INVIS_VAR
  else
    return CT_CHAMS_VAR, CT_CHAMS_INVIS_VAR
  end
end

local function getOldPModelAlpha()
  if (getTeam() == 3) then
    return OLD_CT_A
  elseif (getTeam() == 2) then
    return OLD_T_A
  end
end

local function menuHandler()
  local showMenu = OPEN_PULSATING_WINDOW:GetValue()

  if (showMenu and not MENU_ACTIVE) then
    PULSATING_WINDOW:SetActive(1)
    MENU_ACTIVE = true
  elseif (not showMenu and MENU_ACTIVE) then
    PULSATING_WINDOW:SetActive(0)
    MENU_ACTIVE = false
  end
end

local function pulsateWeapons()
  local pR, pG, pB = gui.GetValue(PRIMARY_WEAPON_VAR)
  local sR, sG, sB = gui.GetValue(SECONDARY_WEAPON_VAR)

  if (WEAPONS_ACTIVE:GetValue() and isAlive()) then
    local alpha = getPulsateAlpha(WEAPONS_SPEED:GetValue(), WEAPONS_MAXOPACITY:GetValue())

    if (alpha > WEAPONS_MINOPACITY:GetValue()) then
      gui.SetValue(PRIMARY_WEAPON_VAR, pR, pG, pB, alpha)
      gui.SetValue(SECONDARY_WEAPON_VAR, sR, sG, sB, alpha)
      if (not USE_OLD_WEAPON_ALPHA) then USE_OLD_WEAPON_ALPHA = true end
    end
  elseif (not WEAPONS_ACTIVE:GetValue() and USE_OLD_WEAPON_ALPHA) then
    USE_OLD_WEAPON_ALPHA = false
    gui.SetValue(PRIMARY_WEAPON_VAR, pR, pG, pB, OLD_PW_A)
    gui.SetValue(SECONDARY_WEAPON_VAR, sR, sG, sB, OLD_SW_A)
  end
end

local function pulsateHands()
  local pR, pG, pB = gui.GetValue(PRIMARY_HANDS_VAR)
  local sR, sG, sB = gui.GetValue(SECONDARY_HANDS_VAR)

  if (HANDS_ACTIVE:GetValue() and isAlive()) then
    local alpha = getPulsateAlpha(HANDS_SPEED:GetValue(), HANDS_MAXOPACITY:GetValue())

    if (alpha > HANDS_MINOPACITY:GetValue()) then
      gui.SetValue(PRIMARY_HANDS_VAR, pR, pG, pB, alpha)
      gui.SetValue(SECONDARY_HANDS_VAR, sR, sG, sB, alpha)
      if (not USE_OLD_HANDS_ALPHA) then USE_OLD_HANDS_ALPHA = true end
    end
  elseif (not HANDS_ACTIVE:GetValue() and USE_OLD_HANDS_ALPHA) then
    USE_OLD_HANDS_ALPHA = false
    gui.SetValue(PRIMARY_HANDS_VAR, pR, pG, pB, OLD_PH_A)
    gui.SetValue(SECONDARY_HANDS_VAR, sR, sG, sB, OLD_SH_A)
  end
end

local function pulsateGhost()
  if (GHOST_ACTIVE:GetValue() and isAlive()) then
    local ghostType = gui.GetValue("vis_fakeghost")
    local ghostVar = "clr_chams_ghost_" .. GHOST_TYPES[ghostType]
    local r, g, b = gui.GetValue(ghostVar)

    if (ghostType == 1 or ghostType == 2) then
      local alpha = getPulsateAlpha(GHOST_SPEED:GetValue(), GHOST_MAXOPACITY:GetValue())

      if (alpha > GHOST_MINOPACITY:GetValue()) then
        gui.SetValue(ghostVar, r, g, b, alpha)
        if (not USE_OLD_GHOST_ALPHA) then USE_OLD_GHOST_ALPHA = true end
      end
    end
  elseif (not GHOST_ACTIVE:GetValue() and USE_OLD_GHOST_ALPHA) then
    USE_OLD_GHOST_ALPHA = false
    gui.SetValue(SERVER_GHOST_VAR, OLD_GS_R, OLD_GS_G, OLD_GS_B, OLD_GS_A)
    gui.SetValue(CLIENT_GHOST_VAR, OLD_GC_R, OLD_GC_G, OLD_GC_B, OLD_GC_A)
  end
end

local function pulsatePlayerModel()
  local visVar, invisVar = getChamsVar()
  local visR, visG, visB = gui.GetValue(visVar)
  local invisR, invisG, invisB = gui.GetValue(invisVar)

  if (PMODEL_ACTIVE:GetValue() and isAlive()) then
    local alpha = getPulsateAlpha(PMODEL_SPEED:GetValue(), PMODEL_MAXOPACITY:GetValue())

    if (alpha > PMODEL_MINOPACITY:GetValue()) then
      gui.SetValue(visVar, visR, visG, visB, alpha)
      if (PMODEL_XQZ_ACTIVE:GetValue()) then gui.SetValue(invisVar, invisR, invisG, invisB, alpha) end      
      if (not USE_OLD_PMODEL_ALPHA) then USE_OLD_PMODEL_ALPHA = true end
    end
  elseif (not isAlive() and USE_OLD_PMODEL_ALPHA) then
    USE_OLD_PMODEL_ALPHA = false
    gui.SetValue(visVar, visR, visG, visB, getOldPModelAlpha())
    if (PMODEL_XQZ_ACTIVE:GetValue()) then gui.SetValue(invisVar, invisR, invisG, invisB, getOldPModelAlpha()) end
  elseif (not PMODEL_ACTIVE:GetValue() and USE_OLD_PMODEL_ALPHA) then
    USE_OLD_PMODEL_ALPHA = false
    gui.SetValue(visVar, visR, visG, visB, getOldPModelAlpha())
    if (PMODEL_XQZ_ACTIVE:GetValue()) then gui.SetValue(invisVar, invisR, invisG, invisB, getOldPModelAlpha()) end
  end
end

local function transparentScope()
  local visVar, invisVar = getChamsVar()
  local visR, visG, visB = gui.GetValue(visVar)
  local invisR, invisG, invisB = gui.GetValue(invisVar)

  if (TRANSPARENT_SCOPE_ACTIVE:GetValue() and isAlive()) then
    local alpha = math.floor(TRANSPARENT_SCOPE_OPACITY:GetValue())
    if (not USE_OLD_SCOPEMODEL_ALPHA) then USE_OLD_SCOPEMODEL_ALPHA = true end

    if (isScoped()) then
      gui.SetValue(visVar, visR, visG, visB, alpha)
      gui.SetValue(invisVar, invisR, invisG, invisB, alpha)
      if (PMODEL_XQZ_ACTIVE:GetValue()) then gui.SetValue(invisVar, invisR, invisG, invisB, alpha) end
    elseif (not isScoped() and not PMODEL_ACTIVE:GetValue()) then
      gui.SetValue(visVar, visR, visG, visB, getOldPModelAlpha())
      if (PMODEL_XQZ_ACTIVE:GetValue()) then gui.SetValue(invisVar, invisR, invisG, invisB, getOldPModelAlpha()) end
    end
  elseif (not isAlive() and USE_OLD_SCOPEMODEL_ALPHA) then
    USE_OLD_SCOPEMODEL_ALPHA = false
    gui.SetValue(visVar, visR, visG, visB, getOldPModelAlpha())
    if (PMODEL_XQZ_ACTIVE:GetValue()) then gui.SetValue(invisVar, invisR, invisG, invisB, getOldPModelAlpha()) end
  elseif (not TRANSPARENT_SCOPE_ACTIVE:GetValue() and USE_OLD_SCOPEMODEL_ALPHA) then
    USE_OLD_SCOPEMODEL_ALPHA = false
    gui.SetValue(visVar, visR, visG, visB, getOldPModelAlpha())
    if (PMODEL_XQZ_ACTIVE:GetValue()) then gui.SetValue(invisVar, invisR, invisG, invisB, getOldPModelAlpha()) end
  end
end

callbacks.Register("Draw", menuHandler)
callbacks.Register("Draw", pulsateWeapons)
callbacks.Register("Draw", pulsateHands)
callbacks.Register("Draw", pulsateGhost)
callbacks.Register("Draw", pulsatePlayerModel)
callbacks.Register("Draw", transparentScope)







