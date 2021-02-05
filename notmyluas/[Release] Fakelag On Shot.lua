-- Scraped by chicken
-- Author: nazefx
-- Title [Release] Fakelag On Shot
-- Forum link https://aimware.net/forum/thread/135378

local cb = gui.Checkbox( gui.Reference( "Ragebot", "Anti-Aim", "Condition" ), "rbot.antiaim.flonshot", "Fakelag on Shot", 0 )
local flslid = gui.Slider(gui.Reference( "Ragebot", "Anti-Aim", "Condition" ), "rbot.antiaim.flticks", "Amount of Ticks", 0, 1, 64 )
local mb = gui.Multibox( gui.Reference( "Ragebot", "Anti-Aim", "Condition" ), "Exclude weapons from onshot" )
local onshotmelee = gui.Checkbox( mb, "rbot.antiaim.onshotmelee", "Melee", 0 )
local onshotgrenades = gui.Checkbox( mb, "rbot.antiaim.onshotnades", "Grenades", 0 )
local onshotrevolver = gui.Checkbox( mb, "rbot.antiaim.onshotr8", "Revolver", 0 )
local onshotauto = gui.Checkbox( mb, "rbot.antiaim.onshotauto", "Auto", 0 )
local onshotawp = gui.Checkbox( mb, "rbot.antiaim.onshotawp", "AWP", 0 )
local onshotscout = gui.Checkbox( mb, "rbot.antiaim.onshotscout", "Scout", 0 )
local onshotpistols = gui.Checkbox( mb, "rbot.antiaim.onshotpistols", "Pistols", 0 )
local lp = entities.GetLocalPlayer()
local aftershot = {}

callbacks.Register( 'CreateMove', function(cmd)
  if lp == nil or not cb:GetValue() then return 
  else
  if lp:GetWeaponType() == 0 and onshotmelee:GetValue() or lp:GetWeaponType() == 9 and onshotgrenades:GetValue() or lp:GetWeaponID() == 64 and onshotrevolver:GetValue() or lp:GetWeaponID() == 38 and onshotauto:GetValue() or lp:GetWeaponID() == 11 and onshotauto:GetValue() or lp:GetWeaponID() == 9 and onshotawp:GetValue() or lp:GetWeaponID() == 40 and onshotscout:GetValue() or lp:GetWeaponType() == 1 and onshotpistols:GetValue() then return end

  local IN_ATTACK = bit.lshift(1, 0)
  local IN_ATTACK2 = bit.lshift(1, 11)
  if bit.band(cmd.buttons, IN_ATTACK) == IN_ATTACK then
    table.insert(aftershot, globals.CurTime())
    ticks = globals.TickCount()
    if aftershot <= globals.CurTime() then
    cmd:SetSendPacket(false)
    table.remove(aftershot, 1)
  end
end
end

  if ticks + flslid:GetValue() > globals.TickCount() - 5 then
    cmd:SetSendPacket(false)
  end
end)-- Scraped by chicken
-- Author: Clipper
-- Title [Release] Fakelag on shot
-- Forum link https://aimware.net/forum/thread/119167

local isActive = gui.Checkbox(gui.Reference("MISC", "ENHANCEMENT", "Fakelag"), "msc_fakelag_onshot", "Fakelag On Shot", 0)
local fakelagValue = gui.Slider(gui.Reference("MISC", "ENHANCEMENT", "FAKELAG"), "msc_fakelag_onshot_value", "On shot Value", 16, 0, 16)
local fakelagTime = gui.Slider(gui.Reference("MISC", "ENHANCEMENT", "FAKELAG"), "msc_fakelag_onshot_time", "On Shot Time (in ms)", 250, 1, 1000)
local shotTime = globals.CurTime();
local shooting = false;
local configRecover = true;
local oldBool = 0;
local oldMode = 0;
local oldValue = 1;
client.AllowListener("weapon_fire")

callbacks.Register( "Draw", function()

  if isActive:GetValue() then

    -- Save Original Values if we aren't on the shooting fakelag.
    if not shooting then

      -- Actually save the values.
      oldBool = gui.GetValue("msc_fakelag_enable")
      oldMode = gui.GetValue("msc_fakelag_mode")
      oldValue = gui.GetValue("msc_fakelag_value")
    end

    -- Set Original values after the user defined time after the shot.
    if shotTime + fakelagTime:GetValue() / 1000 < globals.CurTime() then
      gui.SetValue("msc_fakelag_enable", oldBool)
      gui.SetValue("msc_fakelag_mode", oldMode)
      gui.SetValue("msc_fakelag_value", oldValue)
      shooting = false
    end
  end
end)

callbacks.Register("FireGameEvent", function(event)

  if isActive:GetValue() then

    if event:GetName() == "weapon_fire" then -- Check if the event is the weapon_fire event.
      
      EventUserId = event:GetInt("userid") -- Get the event userId (userId of the person that triggered the event/that shot)
      pLocalInfo = client.GetPlayerInfo(client.GetLocalPlayerIndex()) -- Get a table of information about our localplayer

      if pLocalInfo["UserID"] == EventUserId then -- Compare the eventUserId and the table entry with the local userId.
      
        shooting = true --- Set bool to true to make the settings recovering work.

        -- Set our wanted values.
        gui.SetValue("msc_fakelag_enable", 1)
        gui.SetValue("msc_fakelag_mode", 0)
        gui.SetValue("msc_fakelag_value", fakelagValue:GetValue())
        configRecover = true

        -- Set our shot time so the settings recover can use it.
        shotTime = globals.CurTime()
      end
    end
  end
end)



