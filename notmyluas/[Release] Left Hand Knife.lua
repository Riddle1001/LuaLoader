-- Scraped by chicken
-- Author: Akkov1337
-- Title [Release] Left Hand Knife
-- Forum link https://aimware.net/forum/thread/145320

local enable = gui.Checkbox( gui.Reference( 'Misc', 'General', 'Extra' ), 'knife_on_left_hand', 'Knife on Left Hand', 0 )
  enable:SetDescription( 'Changes your hand to left when knife out.' )

local set
callbacks.Register( 'CreateMove', function()
  if not enable:GetValue() then
    return
  end

  local lp = entities.GetLocalPlayer()
  local weapon = lp:GetPropEntity( 'm_hActiveWeapon' )
  local knife = weapon:GetClass() == 'CKnife'

  if knife then
    if not set then
      client.SetConVar( 'cl_righthand', 0, true )
      set = true
    end
  else
    if set then
      client.SetConVar( 'cl_righthand', 1, true )
      set = false
    end
  end
end)
