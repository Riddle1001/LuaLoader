-- Scraped by chicken
-- Author: __stacker
-- Title [Release] Deagle Flip
-- Forum link https://aimware.net/forum/thread/86833

--[[
	deagle flip
	purpose: to look like trailer-park cheat
]]

--	general script utilities
local uid_to_idx = client.GetPlayerIndexByUserID;
local get_local_player = client.GetLocalPlayerIndex;

--	global variables
local in_action;
local equipped;

--	weapon_fire event listener
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

		if ( _weapon == 'weapon_deagle' ) then
			client.Command( 'slot3', true )
			flip = true;
		end
	end
end

client.AllowListener( 'weapon_fire' );
callbacks.Register( 'FireGameEvent', 'on_weapon_fire', on_weapon_fire );

--	on_item_equip event listener
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

--	ghetto function for createmove because using client.Command twice in a listener is a no-no apparently
function reset_tick( _cmd )
  if ( flip ) then
		if ( equipped ~= 'deagle' ) then
			client.Command( "slot2", true )
			flip = false;
		end
	end
end

callbacks.Register( 'CreateMove', 'reset_tick', reset_tick );
