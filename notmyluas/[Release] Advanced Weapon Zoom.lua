-- Scraped by chicken
-- Author: 90D5p33D
-- Title [Release] Advanced Weapon Zoom
-- Forum link https://aimware.net/forum/thread/135341

-- Advanced Weapon Zoom -- made by burakd, updated by Nexxed
local aimactive = 0;
local use_allowed_weapon = 1;
local visualsreference = gui.Reference("Visuals", "Local", "Camera");
local x = "viewmodel_offset_x"
local y = "viewmodel_offset_y"
local z = "viewmodel_offset_z"
local view = "viewmodel_fov"
local msc_showaw = gui.Checkbox(visualsreference, "msc_showaw", "AWZ", true);
local AWPKey = gui.Keybox(visualsreference, "AWPKeybind", "AWZ Key", 0);
local mode_combo = gui.Combobox(visualsreference, 'idk', "Mode", "Of Hold", "On Hold")



local function itemcheck(Event)

  if (Event:GetName() ~= 'item_equip') then
    return;
  end

  local local_player, userid, item, weptype = client.GetLocalPlayerIndex(), Event:GetInt('userid'), Event:GetString('item'), Event:GetInt('weptype');

  if (local_player == client.GetPlayerIndexByUserID(userid)) then
    if (item == "ak47" or item == "m4a1" or item == "tec9" or item == "galilar" or item == "galilar" or item == "bizon" or item == "ump45" or item == "mp9") then
      use_allowed_weapon = 1;
    else
      use_allowed_weapon = 0;
      aimactive = 0;
    end
  end
end

local function main()
  local mode = mode_combo:GetValue()
  local down = false
  local pressed = false

  if (msc_showaw:GetValue() == false) then
    return;
  end

  if AWPKey:GetValue() ~= 0 then


    if mode == 0 then
      down = input.IsButtonPressed(AWPKey:GetValue())
    end
    if mode == 1 then
      pressed = input.IsButtonDown(AWPKey:GetValue())
    end

    if down then
      if (aimactive == 0) then
        aimactive = aimactive + 1;
      else
        aimactive = 0;
      end
    end
  end




  if ((aimactive == 1 or pressed) and use_allowed_weapon == 1) then


    if (client.GetConVar(x) + 0 >= -5.1) then
      client.SetConVar(x, client.GetConVar(x) - 0.12, true);
    end

    if (client.GetConVar(y) + 0 >= -6.8) then
      client.SetConVar(y, client.GetConVar(y) - 0.12, true);
    end

    if (client.GetConVar(z) + 0 <= 0.8) then
      client.SetConVar(z, client.GetConVar(z) + 0.12, true);
    end




  else

    if (client.GetConVar(x) + 0 <= 1) then
      client.SetConVar(x, client.GetConVar(x) + 0.1, true);
    end

    if (client.GetConVar(y) + 0 <= 1) then
      client.SetConVar(y, client.GetConVar(y) + 0.1, true);
    end

    if (client.GetConVar(z) + 0 >= -1) then
      client.SetConVar(z, client.GetConVar(z) - 0.1, true);
    end
  end
end


callbacks.Register("Draw", "main", main);
client.AllowListener('item_equip');
callbacks.Register("FireGameEvent", "itemcheck", itemcheck);