-- Scraped by chicken
-- Author: zxcv768973361
-- Title [Release] Legit AA on Ragebot AutoWall(Lbot&Rbot)for V5
-- Forum link https://aimware.net/forum/thread/128702

--Part of LegitAA is Made By CN Odin
--QQ:768973361
local ref = gui.Reference("Misc");
local tab = gui.Tab(ref,"Odin_Extra","Odin")
local aagroup = gui.Groupbox(tab,"Odin_Legit AA",16,16,296,300)
local group = gui.Groupbox(tab,"Odin_Extra",296+32,16,296,300)
local sniperflip = gui.Checkbox(group, "Odin_SniperFlip", "SniperFlip", true)
local AWK = gui.Keybox(group, "Odin_AutoWallKey", "AutoWall", 0);
local leftbutton = gui.Keybox( aagroup, "Odin_LegitAA_Leftbutton", "Set Left", 0 )
local rightbutton = gui.Keybox( aagroup, "Odin_LegitAA_Rightbutton", "Set Right", 0 )
local offbutton = gui.Keybox(aagroup, "Odin_LegitAA_Offbutton", "No Fake", 0)
local indicators = gui.Checkbox(aagroup, "Odin_LegitAA_indicators", "Indicators", 0)
local set = gui.Combobox(aagroup, "Odin_LegitAA_setting", "Indicator Mode", "Real", "Fake")
local setMode = gui.Combobox(aagroup, "Odin_LegitAA_setting", "Indicator Type", "Triangle", "< >")
local distance = gui.Slider(aagroup, "Odin_LegitAA_distance", "Indicator Gap", 70, 15, 250)
local rounddist = 0
local scaleslider = gui.Slider(aagroup, "Odin_LegitAA_scaleslider", "Indicator Scale", 1, 0.5, 5)
local aclr = gui.ColorPicker( aagroup,"Odin_LegitAA_aclr", "Indicator Active", 200, 25, 25, 200 )
local iclr = gui.ColorPicker( aagroup,"Odin_LegitAA_iclr", "Indicator Inactive", 0, 0, 0, 100 )

local function changeleft()
  local lp = entities.GetLocalPlayer();
  -- print(lp:GetProp("m_flLowerBodyYawTarget"))
  -- print(lp:GetProp("m_angEyeAngles"))
  gui.SetValue("rbot.antiaim.advanced.pitch",0);
  gui.SetValue("rbot.antiaim.base",0);
  gui.SetValue("rbot.antiaim.base.rotation",-58);
  gui.SetValue("rbot.antiaim.base.lby",58);
end
local function changeright()
  local lp = entities.GetLocalPlayer();
  gui.SetValue("rbot.antiaim.advanced.pitch",0);
  gui.SetValue("rbot.antiaim.base",0);
  gui.SetValue("rbot.antiaim.base.rotation",58);
  gui.SetValue("rbot.antiaim.base.lby",-58);
end
local function nofake()
  local lp = entities.GetLocalPlayer();
  gui.SetValue("rbot.antiaim.advanced.pitch",0);
  gui.SetValue("rbot.antiaim.base",0);
  gui.SetValue("rbot.antiaim.base.rotation",0);
  gui.SetValue("rbot.antiaim.base.lby",0);
end
local function ChangeFake()
  local left = leftbutton:GetValue();
  local right = rightbutton:GetValue();
  local off = offbutton:GetValue();
  rounddist = math.floor(distance:GetValue());
  distance:SetValue(rounddist);

  if left ~= 0 then
    if input.IsButtonPressed(left) then
      changeleft()
    end
  end
  if right ~= 0 then
    if input.IsButtonPressed(right) then
      changeright()
    end
  end
  if off ~= 0 then
    if input.IsButtonPressed(off) then
      nofake()
    end
  end

  if indicators:GetValue() then
    local w,h = draw.GetScreenSize()
    local scale = scaleslider:GetValue()
   
     if set:GetValue() == 0 then
       if gui.GetValue("rbot.antiaim.base.rotation") == 0 then
         draw.Color(iclr:GetValue())
         draw.Triangle(w/2 - rounddist - (15 * scale), h/2, w/2 - rounddist, h/2 - (10 * scale), w/2 - rounddist, h/2 + (10 * scale))
         draw.Triangle(w/2 + rounddist + (15 * scale), h/2, w/2 + rounddist, h/2 + (10 * scale), w/2 + rounddist, h/2 - (10 * scale))
       elseif gui.GetValue("rbot.antiaim.base.rotation") == 58 then
         draw.Color(aclr:GetValue())
         draw.Triangle(w/2 - rounddist - (15 * scale), h/2, w/2 - rounddist, h/2 - (10 * scale), w/2 - rounddist, h/2 + (10 * scale))
         draw.Color(iclr:GetValue())
         draw.Triangle(w/2 + rounddist + (15 * scale), h/2, w/2 + rounddist, h/2 + (10 * scale), w/2 + rounddist, h/2 - (10 * scale))
       elseif gui.GetValue("rbot.antiaim.base.rotation") == -58 then
         draw.Color(iclr:GetValue())
         draw.Triangle(w/2 - rounddist - (15 * scale), h/2, w/2 - rounddist, h/2 - (10 * scale), w/2 - rounddist, h/2 + (10 * scale))
         draw.Color(aclr:GetValue())
         draw.Triangle(w/2 + rounddist + (15 * scale), h/2, w/2 + rounddist, h/2 + (10 * scale), w/2 + rounddist, h/2 - (10 * scale))
      end
       
     elseif set:GetValue() == 1 then
       if gui.GetValue("rbot.antiaim.base.rotation") == 0 then
         draw.Color(iclr:GetValue())
         draw.Triangle(w/2 - rounddist - (15 * scale), h/2, w/2 - rounddist, h/2 - (10 * scale), w/2 - rounddist, h/2 + (10 * scale))
         draw.Triangle(w/2 + rounddist + (15 * scale), h/2, w/2 + rounddist, h/2 + (10 * scale), w/2 + rounddist, h/2 - (10 * scale))
       elseif gui.GetValue("rbot.antiaim.base.rotation") == -58 then
         draw.Color(aclr:GetValue())
         draw.Triangle(w/2 - rounddist - (15 * scale), h/2, w/2 - rounddist, h/2 - (10 * scale), w/2 - rounddist, h/2 + (10 * scale))
         draw.Color(iclr:GetValue())
         draw.Triangle(w/2 + rounddist + (15 * scale), h/2, w/2 + rounddist, h/2 + (10 * scale), w/2 + rounddist, h/2 - (10 * scale))
       elseif gui.GetValue("rbot.antiaim.base.rotation") == 58 then
         draw.Color(iclr:GetValue())
         draw.Triangle(w/2 - rounddist - (15 * scale), h/2, w/2 - rounddist, h/2 - (10 * scale), w/2 - rounddist, h/2 + (10 * scale))
         draw.Color(aclr:GetValue())
         draw.Triangle(w/2 + rounddist + (15 * scale), h/2, w/2 + rounddist, h/2 + (10 * scale), w/2 + rounddist, h/2 - (10 * scale))
       end
     end
   end

end

callbacks.Register("Draw", ChangeFake)





local function AutoWall()

  local text_font = draw.CreateFont("Verdana", 20, 700);
  draw.SetFont(text_font);
  local x,y = draw.GetScreenSize();
  if AWK:GetValue() ~= 0 then
    if input.IsButtonDown(AWK:GetValue()) then
      gui.SetValue( "lbot.weapon.vis.scout.autowall", 1);
      gui.SetValue( "lbot.weapon.vis.sniper.autowall", 1);
      gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 1);
      gui.SetValue( "rbot.hitscan.mode.scout.autowall", 1);
      draw.Color(255, 168, 0 );
      draw.Text(10, ((y/2)-(y/50)), "穿墙开启");
      draw.TextShadow(10, ((y/2)-(y/50)), "穿墙开启");
    else
      gui.SetValue( "lbot.weapon.vis.scout.autowall", 0);
      gui.SetValue( "lbot.weapon.vis.sniper.autowall", 0);
      gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 0);
      gui.SetValue( "rbot.hitscan.mode.scout.autowall", 0);
      draw.Color(255, 168, 0 );
      draw.Text(10, ((y/2)-(y/50)), "穿墙关闭");
      draw.TextShadow(10, ((y/2)-(y/50)), "穿墙关闭");
    end
  end
  

end

callbacks.Register('Draw', 'AutoWall', AutoWall);



local uid_to_idx = client.GetPlayerIndexByUserID;
local get_local_player = client.GetLocalPlayerIndex;


--  global variables
local in_action;
local equipped;

--  weapon_fire event listener
local function on_weapon_fire( _event )
  if ( _event:GetName( ) ~= 'weapon_fire' ) then
    return;
  end


  local _local = get_local_player( );
  local _id = _event:GetInt('userid');
  
  if ( _local == uid_to_idx( _id ) ) then
    local _weapon = _event:GetString( 'weapon' );
    if sniperflip:GetValue() == true then
      if ( _weapon == 'weapon_awp' ) then
        client.Command( 'slot3', true )
        flip = true;
      end
      if ( _weapon == 'weapon_ssg08' ) then
        flip = true;
        client.Command( 'slot3', true )
      end
  

    end

  end
end

client.AllowListener( 'weapon_fire' );
callbacks.Register( 'FireGameEvent', 'on_weapon_fire', on_weapon_fire );

local function on_item_equip( _event )
  if ( _event:GetName( ) ~= 'item_equip' ) then
    return;
  end

  local _local = get_local_player( );
  local _id = _event:GetInt( 'userid' );
  local _item = _event:GetString( 'item' );

  if ( _local == uid_to_idx( _id ) ) then
    equipped = _item;
  end
end

client.AllowListener( 'item_equip' );
callbacks.Register( 'FireGameEvent', 'on_item_equip', on_item_equip );

local function reset_tick( _cmd )
 if ( flip ) then
    if ( equipped ~= 'awp' ) then
      if sniperflip:GetValue() == true then
        client.Command( "slot1", true )
       flip = false;
      end
    end

  end
end

callbacks.Register( 'CreateMove', 'reset_tick', reset_tick );










