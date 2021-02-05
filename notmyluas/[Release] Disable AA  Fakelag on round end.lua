-- Scraped by chicken
-- Author: massas
-- Title [Release] Disable AA  Fakelag on round end
-- Forum link https://aimware.net/forum/thread/86500


local gui_set = gui.SetValue;
local gui_get = gui.GetValue;


local function roundend(Event)
-- returns if the current event is not the item_equip event
if (Event:GetName() == 'round_end') then
print( "called round_end" )

gui_set( "msc_fakelag_enable", false )
gui_set( "rbot_antiaim_enable", false )
end
end

local function roundstart(Event)
-- returns if the current event is not the item_equip event
if (Event:GetName() == 'round_start') then
print( "called round_start" )

gui_set( "msc_fakelag_enable", true )
gui_set( "rbot_antiaim_enable", true )
end
end

client.AllowListener('round_start');
client.AllowListener('round_end');
callbacks.Register("FireGameEvent", "roundstart", roundstart);
callbacks.Register("FireGameEvent", "roundend", roundend);



