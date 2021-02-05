-- Scraped by chicken
-- Author: adrianobessa5682
-- Title [Release] AWP Quick Switch
-- Forum link https://aimware.net/forum/thread/128131

print("Loaded Quick Switch AWP By Starlordaiden")local a=client.GetPlayerIndexByUserID;local b=client.GetLocalPlayerIndex;local c;local d;local e=gui.Reference("MISC","Movement","Other")local f=gui.Checkbox(e,'lua_quick_switch','Quick Switch AWP',0)local function g(h)if f:GetValue()then if h:GetName()~='weapon_fire'then return end;if gui.GetValue("misc.fakelatency.enable")then return end;local i=b()local j=h:GetInt('userid')if i==a(j)then local k=h:GetString('weapon')if k=='weapon_awp'then client.Command('slot3',true)flip=true end end end end;client.AllowListener('weapon_fire')callbacks.Register('FireGameEvent','on_weapon_fire',g)local function l(h)if h:GetName()~='item_equip'then return end;local i=b()local j=h:GetInt('userid')local m=h:GetString('item')if i==a(j)then d=m end end;client.AllowListener('item_equip')callbacks.Register('FireGameEvent','on_item_equip',l)function reset_tick(n)if flip then if d~='awp'then client.Command("slot1",true)flip=false end end end;callbacks.Register('CreateMove','reset_tick',reset_tick)-- Scraped by chicken
-- Author: nishanbrar
-- Title [Release] AWP Quick Switch
-- Forum link https://aimware.net/forum/thread/110191

--[[
  awp flip
]]

--  general script utilities
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

  if (gui.GetValue("msc_fakelatency_enable")) then
    return;
  end

  local _local = get_local_player( );
  local _id = _event:GetInt('userid');
  
  if ( _local == uid_to_idx( _id ) ) then
    local _weapon = _event:GetString( 'weapon' );

    if ( _weapon == 'weapon_awp' ) then
      client.Command( 'slot3', true )
      flip = true;
    end
  end
end

client.AllowListener( 'weapon_fire' );
callbacks.Register( 'FireGameEvent', 'on_weapon_fire', on_weapon_fire );

--  on_item_equip event listener
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

--  ghetto function for createmove because using client.Command twice in a listener is a no-no apparently
function reset_tick( _cmd )
 if ( flip ) then
    if ( equipped ~= 'awp' ) then
      client.Command( "slot1", true )
      flip = false;
    end
  end
end

callbacks.Register( 'CreateMove', 'reset_tick', reset_tick );

