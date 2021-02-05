-- Scraped by chicken
-- Author: nazefx
-- Title [Release] Change GUI values on VAC server
-- Forum link https://aimware.net/forum/thread/122452


local serverIP = engine.GetServerIP();

local function applyServerID()
if string.find(serverIP, 'A:') then
gui.SetValue( "rab_autobuy_masterswitch", 0 ) gui.SetValue( "lua_fakelag_moving", 0 ) gui.SetValue( "lua_fakelag_inair", 0 ) 
else gui.SetValue( "rab_autobuy_masterswitch", 1 ) gui.SetValue( "lua_fakelag_moving", 1 ) gui.SetValue( "lua_fakelag_inair", 1 ) 
end 
end 

callbacks.Register( 'Draw', applyServerID )




