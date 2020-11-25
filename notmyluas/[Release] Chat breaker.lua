-- Scraped by chicken
-- Author: zuli
-- Title [Release] Chat breaker
-- Forum link https://aimware.net/forum/thread/132953

local discord = "LoNE WoLvES#0001";

local Chat_Breaker_Spam = {
 "﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽",
};
local ref = gui.Tab(gui.Reference("Misc"), "extra.settings", "Extra")
local Chat_Breaker_Group = gui.Groupbox(ref, "Spam Message", 16, 20, 297);
local Chat_Breaker_Act = gui.Combobox( Chat_Breaker_Group, "lua_combobox", "Enable", "off", "ChatBreaker", "custom" );
local Chat_Breaker_Edit = gui.Editbox( Chat_Breaker_Group, "lua_editbox", "custom message:");
local Chat_Breaker_Speed = gui.Slider( Chat_Breaker_Group, "lua_slider","Delay in Seconds" , 10,0.1,60)
local last_message = globals.TickCount();
function ChatSpam()
 if ( globals.TickCount() - last_message < 0 ) then
        last_message = 0;
    end;
 local spammer_speed = Chat_Breaker_Speed:GetValue() *60;
    if ( Chat_Breaker_Act:GetValue()==1 and globals.TickCount() - last_message > (math.max(22, spammer_speed)) ) then
        client.ChatSay( ' ' .. tostring( Chat_Breaker_Spam[math.random(1,table.getn(Chat_Breaker_Spam))] ));
        last_message = globals.TickCount();
 elseif ( Chat_Breaker_Act:GetValue()==2 and globals.TickCount() - last_message > (math.max(22, spammer_speed)) ) then
        client.ChatSay(Chat_Breaker_Edit:GetValue());
        last_message = globals.TickCount();
    end
end
callbacks.Register( "Draw", "ChatSpam", ChatSpam );