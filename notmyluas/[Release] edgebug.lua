-- Scraped by chicken
-- Author: FrEnziedWreCKer
-- Title [Release] edgebug
-- Forum link https://aimware.net/forum/thread/128101


local ui_keybox = gui.Keybox(gui.Reference("MISC","Movement"),"msc_movement_edge","Auto Edgebug Key",0)
callbacks.Register("CreateMove",function(userCmd)
  local onground = entities.GetLocalPlayer():GetPropInt("m_fFlags") bit.band(1,0);
  if ui_keybox:GetValue() == 0 then return end
  if onground and input.IsButtonDown(ui_keybox:GetValue()) then
    userCmd:SetButtons(4)
    return
  end
end)