-- Scraped by chicken
-- Author: uvxxvu
-- Title [Release] Null in air KZ bind [V5]
-- Forum link https://aimware.net/forum/thread/128386

local last_a, last_d = 0
local font = draw.CreateFont( "Verdana", 25 );
local ui_checkbox = gui.Checkbox( gui.Reference( "MISC","Movement", "Strafe" ),"kz.null.strafe", "Null Strafe", 1 )
local ui_checkbox1 = gui.Checkbox( gui.Reference( "Visuals","Other", "Extra" ),"kz.null.strafe.indicator", "Null Strafe Indicator", 1 )
ui_checkbox:SetDescription( "Prevents you from pressing two strafe keys together in air." )
local ui_colourpicker = gui.ColorPicker( ui_checkbox1, "nullbindcolour", "null_bind_colour", 252, 61, 3, 180 )

local function get_local_player( )

  local player = entities.GetLocalPlayer( )
  
  if player == nil then return end
  
  if ( not player:IsAlive( ) ) then
    
    player = player:GetPropEntity( "m_hObserverTarget" )
    
  end
  
  return player
  
end

callbacks.Register( "CreateMove", function( cmd )

  local ui_null_strafe = gui.GetValue( "misc.strafe.kz.null.strafe" )
  if ( ui_null_strafe == 0 ) then
    return
  end

  local flags = get_local_player():GetPropInt( "m_fFlags" )
  
  if flags == nil then 
    return
  end
  
  local onground = bit.band(flags, 1) ~= 0

  if ( onground ) then
    return 
  end
 

  if ( input.IsButtonDown( 65 ) and input.IsButtonDown( 68) ) then
    if( last_a ~= nil and last_d ~= nil ) then
      if( last_d < last_a ) then
        cmd.sidemove = 450
      elseif( last_d > last_a ) then
        cmd.sidemove = -450
      end
    end
  return
  end
 
  if ( input.IsButtonDown( 65 ) ) then
    last_a = globals.CurTime( )
  end

  if ( input.IsButtonDown( 68 ) ) then
    last_d = globals.CurTime( )
  end
end)

callbacks.Register( "Draw", function( )
  local ui_null_strafe_indicator = gui.GetValue( "esp.other.kz.null.strafe.indicator" )
  if ( ui_null_strafe_indicator == 0 ) then
    return
  end
  local lp = entities.GetLocalPlayer( );

  if (lp == nil) then
    return
  end


  local flags = get_local_player():GetPropInt( "m_fFlags" )
  


  if flags == nil then 
    return
  end
  
  local onground = bit.band(flags, 1) ~= 0

  if ( onground ) then
    return 
  end

  draw.SetFont( font )

  r, g, b, a = ui_colourpicker:GetValue( )
  local x, y = draw.GetScreenSize( )
  local centerX = x / 2

  if ( ui_null_strafe_indicator ~= 0 and not onground and input.IsButtonDown( 65 ) and input.IsButtonDown( 68 ) ) then

  draw.Color( r, g, b, a )
  draw.Text( centerX , y - 200, "nulling" )

 end
end)



