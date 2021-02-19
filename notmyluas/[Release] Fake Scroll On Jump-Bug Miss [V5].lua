-- Scraped by chicken
-- Author: uvxxvu
-- Title [Release] Fake Scroll On Jump-Bug Miss [V5]
-- Forum link https://aimware.net/forum/thread/128377

local ui_checkbox = gui.Checkbox( gui.Reference("MISC","Movement", "Jump"),"misc.autojumpbug.scroll", "Fake Scroll On Jump-bug Miss", 1 )
ui_checkbox:SetDescription( "Fakes scroll input if Auto Jump-Bug fails." )

local function get_local_player( )

  local player = entities.GetLocalPlayer( )
  
  if player == nil then return end
  
  if ( not player:IsAlive( ) ) then
    
    player = player:GetPropEntity( "m_hObserverTarget" )
    
  end
  
  return player
  
end

local function JUMPBUG_SCROLL( UserCmd )

  local flags = get_local_player():GetPropInt( "m_fFlags" )
  
  if flags == nil then return end

  local onground = bit.band( flags, 1 ) ~= 0
  
  if onground and input.IsButtonDown( gui.GetValue("misc.autojumpbug" ) )then

    UserCmd:SetButtons( 4 )
    return  

  end
end


callbacks.Register( "CreateMove", JUMPBUG_SCROLL )
