-- Scraped by chicken
-- Author: Squidoodle
-- Title [Release] Resizeable Menu
-- Forum link https://aimware.net/forum/thread/144771

local menu = gui.Reference("MENU");
local opt_pos = false;
local bounds = false;
local show_bounds = gui.Button( gui.Reference( "Settings", "Advanced", "Manage Advanced Settings" ), "Show Boundaries", function()
    bounds = true
end )

local hide_bounds = gui.Button( gui.Reference( "Settings", "Advanced", "Manage Advanced Settings" ), "Hide Boundaries", function()
    bounds = false
end )

local function handle_dpi(dpi)
    local value = dpi
    if value == 1 then
        return 1
    elseif value == 0 then
        return 0.75
    elseif value == 2 then
        return 1.25
    elseif value == 3 then
        return 1.5
    elseif value == 4 then
        return 1.75
    elseif value == 5 then
        return 2
    elseif value == 6 then
        return 2.25
    elseif value == 7 then
        return 2.5
    elseif value == 8 then
        return 2.75 
    elseif value == 9 then
        return 3
    end
end

local function gay()
    if menu:IsActive() then
        local x, y = menu:GetValue()
        local mx, my = input.GetMousePos()
        local x2 = x + 800 * handle_dpi(gui.GetValue("adv.dpi"))
        local y2 = y + 600 * handle_dpi(gui.GetValue("adv.dpi"))
        local a = (bounds == true) and 255 or 0
        draw.Color(25, 255, 255, a)
        draw.OutlinedRect(x, y, x2, y2)
        draw.OutlinedRect(x2 + 5, y2 + 5, x2 - 20, y2 - 20)
        if input.IsButtonDown("Mouse1") then    
            if mx > x2-20 and mx < x2+5 and my > y2-20 and my < y2+5 then
                opt_pos = true;
            end
            if opt_pos == true then 
                local ops = (gui.GetValue("adv.dpi") == 0) and 0 or 1
                draw.Line( x + 800 * handle_dpi(gui.GetValue("adv.dpi") - ops), y + 600 * handle_dpi(gui.GetValue("adv.dpi") - ops), x + 800 * handle_dpi(gui.GetValue("adv.dpi") + 1), y + 600 * handle_dpi(gui.GetValue("adv.dpi") + 1) )
                if mx > x + 800 * handle_dpi(gui.GetValue("adv.dpi") + 1) and my > y + 600 * handle_dpi(gui.GetValue("adv.dpi") + 1) then
                    gui.SetValue("adv.dpi", gui.GetValue("adv.dpi") + 1)
                end
                if mx < x + 800 * handle_dpi(gui.GetValue("adv.dpi") - ops) and my < y + 600 * handle_dpi(gui.GetValue("adv.dpi") - ops) and gui.GetValue("adv.dpi") ~= 0 then
                    gui.SetValue("adv.dpi", gui.GetValue("adv.dpi") - 1)
                end
            end 
        else
            opt_pos = false;
        end
    end
end

callbacks.Register("Draw", gay)
