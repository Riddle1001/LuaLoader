-- Scraped by chicken
-- Author: Nevvy
-- Title [Release] Masturbation ESP [v1.0.0  24.10.19]
-- Forum link https://aimware.net/forum/thread/116916

local active = 0;
local whitelist = 1;
local visualsreference = gui.Reference("MISC", "GENERAL", "EXTRA");
local x = "viewmodel_offset_x"
local y = "viewmodel_offset_y"
local z = "viewmodel_offset_z"
local view = "viewmodel_fov"
local hbox = gui.Groupbox(visualsreference, "Masturbation ESP");
local henable = gui.Checkbox(hbox, "lua_fap_enable", "Enable", true);
local mkeybind = gui.Keybox(hbox, "lua_fap_keybind", "Keybind", 0);

local function itemcheck(Event)
  if (Event:GetName() ~= 'item_equip') then
    return;
  end
  local local_player, userid, item, weptype = client.GetLocalPlayerIndex(), Event:GetInt('userid'), Event:GetString('item'), Event:GetInt('weptype');
  if (local_player == client.GetPlayerIndexByUserID(userid)) then
    if (item == "flashbang" or item == "decoy" or item == "incgrenade" or item == "smokegrenade") then
      whitelist = 1;
 gui.SetValue("vis_chams_weapon", 5)
 client.SetConVar(view, 54);
    else
      whitelist = 0;
      active = 0;
 gui.SetValue("vis_chams_weapon", 0)
 client.SetConVar(view, 68);
    end
  end
end

local function main()
  if (henable:GetValue() == false) then
    return;
  end
  if mkeybind:GetValue() ~= 0 then
 pressed = input.IsButtonDown(mkeybind:GetValue())
 end
  if ((active == 1 or pressed) and whitelist == 1) then
    if (client.GetConVar(z) + 0 <= 1) then
      client.SetConVar(z, client.GetConVar(z) + 0.1, true);
    end
  else
    if (client.GetConVar(z) + 0 >= -5) then
      client.SetConVar(z, client.GetConVar(z) - 0.1, true);
    end
  end
end

callbacks.Register("Draw", "main", main);
client.AllowListener('item_equip');
callbacks.Register("FireGameEvent", "itemcheck", itemcheck);
