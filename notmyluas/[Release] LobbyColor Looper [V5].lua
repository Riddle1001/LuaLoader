-- Scraped by chicken
-- Author: yu0r
-- Title [Release] LobbyColor Looper [V5]
-- Forum link https://aimware.net/forum/thread/113779


MENU_MISC = gui.Reference('MISC')
setttab = gui.Tab(MENU_MISC, "SETT_MISC.tab", "Misc Shit")
MYCRAPSET = gui.Groupbox(setttab, 'Misc Settings Shit', 16, 250,200, 100)
local list = {
  [1] = "cl_color 0",--yl
  [2] = "cl_color 1",--pr
  [3] = "cl_color 2",--gr
  [4] = "cl_color 3",--bl
  [5] = "cl_color 4",--oj 
  [6] = "cl_color 64 64 64 64",--g
}

local lua_LobbyColor = gui.Checkbox( MYCRAPSET, "lua_LobbyColor", "Lobby Color", 1 );
local last_spamL = globals.TickCount()

function LobbyColor()
if lua_LobbyColor:GetValue() then
if entities.GetLocalPlayer() == nil then
					if globals.TickCount() - last_spamL == 128 then
							local str1ng = tostring(list[1]);
							client.Command( ' ' .. str1ng );
					elseif globals.TickCount() - last_spamL == 256 then
							local str1ng = tostring(list[2]);
							client.Command( ' ' .. str1ng );
					elseif globals.TickCount() - last_spamL == 384 then
							local str1ng = tostring(list[3]);
							client.Command( ' ' .. str1ng );
					elseif globals.TickCount() - last_spamL == 512 then
							local str1ng = tostring(list[4]);
							client.Command( ' ' .. str1ng );
					elseif globals.TickCount() - last_spamL == 640 then
							local str1ng = tostring(list[5]);
							client.Command( ' ' .. str1ng );
					elseif globals.TickCount() - last_spamL == 768 then
							local str1ng = tostring(list[6]);
							client.Command( ' ' .. str1ng );
							last_spamL = globals.TickCount()
					end
		else
		end
else
end
end
callbacks.Register( "Draw", LobbyColor);