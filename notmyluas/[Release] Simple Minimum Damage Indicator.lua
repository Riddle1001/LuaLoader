-- Scraped by chicken
-- Author: Squidoodle
-- Title [Release] Simple Minimum Damage Indicator
-- Forum link https://aimware.net/forum/thread/146520

local TAB = gui.Tab(gui.Reference("Visuals"), ".tab", "Minimum Damage Indicator")
local INDC_GROUP = gui.Groupbox( TAB, "Indicators", 15, 15, 295, 300 )

local pLocal = entities.GetLocalPlayer()

local INDC_MIN = gui.Checkbox(INDC_GROUP, "rbot..indc.min", "Damage Indicator", true)
local INDC_MIN_BOX = gui.ColorPicker(INDC_MIN, "rbot..indc.min.box", "Box Color", 0, 0, 0, 110)
local INDC_MIN_OUTLINE = gui.ColorPicker(INDC_MIN, "rbot..indc.min.outline", "Outline Color", 0, 0, 0, 125)
local INDC_MIN_TEXT = gui.ColorPicker(INDC_MIN, "rbot..indc.min.text", "Text Color", 255, 255, 255, 255)
local INDC_MIN_BAR = gui.ColorPicker(INDC_MIN, "rbot..indc.min.bar", "Bar Color", 25, 125, 200, 255)
local INDC_MIN_TEXT1 = gui.ColorPicker(INDC_MIN, "rbot..indc.min.text1", "Ticks Color", 25, 255, 255, 255)

local INDC_OFFSET = gui.Slider(INDC_GROUP, "rbot..indc.offset", "Y Offset", 75, 61, 150)

INDC_MIN:SetDescription("Displays a Minimum Damage Indicator")

local font = draw.CreateFont("Verdana", 14, 2000)

local function handle_weapon(wid)
    if wid == 1 or wid == 64 then 
        return "hpistol"
    elseif wid == 2 or wid == 3 or wid == 4 or wid == 30 or wid == 32 or wid == 36 or wid == 61 or wid == 63 then
        return "pistol"
    elseif wid == 7 or wid == 8 or wid == 10 or wid == 13 or wid == 16 or wid == 39 or wid == 60 then
        return "rifle"
    elseif wid == 11 or wid == 38 then
        return "asniper"
    elseif wid == 17 or wid == 19 or wid == 23 or wid == 24 or wid == 26 or wid == 33 or wid == 34 then
        return "smg"
    elseif wid == 14 or wid == 28 then
        return "lmg"
    elseif wid == 25 or wid == 27 or wid == 29 or wid == 35 then
        return "shotgun"
    elseif wid == 9 then
        return "sniper"
    elseif wid == 40 then
        return "scout"
    else
        return "scout"
    end
end

local function on_draw()
    if pLocal:IsAlive() == false or pLocal == nil then return end

    draw.SetFont( font )
    
    local weapon_id = pLocal:GetWeaponID()

    local ScreenX2, screenY2 = draw.GetScreenSize();

    if INDC_MIN:GetValue() then
        local off_int = INDC_OFFSET:GetValue()
        --BOX + OUTLINE
        draw.Color(INDC_MIN_BOX:GetValue())
        draw.FilledRect( 5, screenY2 - 110 - off_int, 16 * 10 + 10, screenY2 - 50 - off_int)
        draw.Color(INDC_MIN_OUTLINE:GetValue())
        draw.OutlinedRect( 9, screenY2 - 76 - off_int, 11 + 13 * 10 , screenY2 - 64 - off_int)

        --TEXT
        draw.Color(INDC_MIN_TEXT:GetValue())
        draw.Text( 9, screenY2 - 100 - off_int, "Minimum Damage:" )

        --LINE
        draw.Color(gui.GetValue("theme.header.line"))
        draw.Line(5, screenY2 - 110 - off_int, 16 * 10 + 10, screenY2 - 110 - off_int)

        --CHOKE + TEXT
        draw.Color(INDC_MIN_BAR:GetValue())
        draw.FilledRect(10, screenY2 - 75 - off_int, 10 + gui.GetValue("rbot.accuracy.weapon.".. handle_weapon(weapon_id) ..".mindmg"), screenY2 - 65 - off_int)
        draw.Color(INDC_MIN_TEXT1:GetValue())
        draw.Text(10 + gui.GetValue("rbot.accuracy.weapon.".. handle_weapon(weapon_id) ..".mindmg"), screenY2 - 75 - off_int, gui.GetValue("rbot.accuracy.weapon.".. handle_weapon(weapon_id) ..".mindmg") )
    end
end

callbacks.Register("Draw", on_draw)