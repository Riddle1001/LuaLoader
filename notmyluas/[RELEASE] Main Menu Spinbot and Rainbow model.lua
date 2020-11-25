-- Scraped by chicken
-- Author: ShadyRetard
-- Title [RELEASE] Main Menu Spinbot and Rainbow model
-- Forum link https://aimware.net/forum/thread/130789

-- Retarded menu spinbot by ShadyRetard

local last_spinbot_speed = 1
local rainbow_speed = 0
local extra_reference = gui.Reference("Misc", "General", "Extra")
local spinbot_speed_slider = gui.Slider(extra_reference, "menu_spinbot_speed_slider", "Menu spinbot speed", 0, -50, 50, 1)
local rainbow_speed_slider = gui.Slider(extra_reference, "menu_model_rainbow_speed_slider", "Menu model rainbow speed", 0, 0, 10, 1)

panorama.RunScript([[
    mainMenuSpinbot = undefined
    mainMenuRainbow = undefined
    vanityPanel.SetDirectionalLightAmount(0);
]])

panorama.RunScript([[
    var vanityPanel = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
    
    var menuSpinbotDegrees = 0;
    var menuSpinbotSpeed = 1
    
    function mainMenuSpinbot() {
        menuSpinbotDegrees += menuSpinbotSpeed / 10;
        
        if (menuSpinbotDegrees > 360) {
            menuSpinbotDegrees = menuSpinbotDegrees - 360;
        }

        vanityPanel.SetSceneAngles(0, menuSpinbotDegrees, 0, 0)

        $.Schedule(0.01, menuSpinbot)
    }

    var mainMenuRainbowEnabled = false;
    var rainbowSpeed = 0;
    var r = 0.0;
    var g = 0.0;
    var b = 0.0;
    var x = 0.0;
    var y = 0.0;

    function mainMenuRainbow() {
        if (rainbowSpeed > 0) {
            if( y >= 0 && y < 255 ) {
                r = 255;
                g = 0;
                b = x;
            } else if( y >= 255 && y < 510 ) {
                r = 255 - x;
                g = 0;
                b = 255;
            } else if( y >= 510 && y < 765 ) {
                r = 0;
                g = x;
                b = 255;
            } else if( y >= 765 && y < 1020 ) {
                r = 0;
                g = 255;
                b = 255 - x;
            } else if( y >= 1020 && y < 1275 ) {
                r = x;
                g = 255;
                b = 0;
            } else if( y >= 1275 && y < 1530 ) {
                r = 255;
                g = 255 - x;
                b = 0;
            }
    
            x+=rainbowSpeed;
            if( x >= 255 )
                x = 0;
         
            y+=rainbowSpeed;
            if( y > 1530 ) {
                y = 0;
            }

            vanityPanel.SetAmbientLightColor(r, g, b);
        }
        $.Schedule(0.01, mainMenuRainbow)
    }

    mainMenuRainbow();
    mainMenuSpinbot();
]])

callbacks.Register("Draw", function()
    local spinbot_speed_value = spinbot_speed_slider:GetValue()
    if (spinbot_speed_value ~= last_spinbot_speed) then
        panorama.RunScript([[menuSpinbotSpeed = ]] .. spinbot_speed_value .. [[;]])
        last_spinbot_speed = spinbot_speed_value
    end

    local rainbow_speed_value = rainbow_speed_slider:GetValue()
    if (rainbow_speed_value ~= rainbow_speed) then
        panorama.RunScript([[rainbowSpeed = ]] .. rainbow_speed_value .. [[;]])
        rainbow_speed = rainbow_speed_value
    end
end)