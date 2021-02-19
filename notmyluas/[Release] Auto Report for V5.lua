-- Scraped by chicken
-- Author: Zinn
-- Title [Release] Auto Report for V5
-- Forum link https://aimware.net/forum/thread/138638

localGUI_TAB=gui.Tab(gui.Reference("Misc"),"autoreport","AutoReport")
localGUI_OPT=gui.Groupbox(GUI_TAB,"Options",4,4,200,400)
localGUI_OPT_ENABLE
do
local_with_0=gui.Checkbox(GUI_OPT,"enable","EnableAutoreport",false)
_with_0:SetDescription("Automaticallyreporttheplayerwhokillsyou.")
GUI_OPT_ENABLE=_with_0
end
localGUI_OPT_REASONS=gui.Multibox(GUI_OPT,"Reasons")
localGUI_OPT_REASONS_ABUSIVECOMMUNICATION=gui.Checkbox(GUI_OPT_REASONS,"reasons.abusive_communication","AbusiveCommunication",true)
localGUI_OPT_REASONS_GRIEFING=gui.Checkbox(GUI_OPT_REASONS,"reasons.griefing","Griefing",true)
localGUI_OPT_REASONS_AIM=gui.Checkbox(GUI_OPT_REASONS,"reasons.aim","Aimhacking",true)
localGUI_OPT_REASONS_WALL=gui.Checkbox(GUI_OPT_REASONS,"reasons.wall","Wallhacking",true)
localGUI_OPT_REASONS_EXTERNAL=gui.Checkbox(GUI_OPT_REASONS,"reasons.external","Externalassistance",true)
client.AllowListener("player_death")
callbacks.Register("FireGameEvent",function(event)
ifevent:GetName()~="player_death"then
return
end
ifclient.GetPlayerIndexByUserID(event:GetInt("userid"))~=client.GetLocalPlayerIndex()then
return
end
ifnotGUI_OPT_ENABLE:GetValue()then
return
end
localreasons={}
ifGUI_OPT_REASONS_ABUSIVECOMMUNICATION:GetValue()then
table.insert(reasons,"textabuse")
end
ifGUI_OPT_REASONS_GRIEFING:GetValue()then
table.insert(reasons,"grief")
end
ifGUI_OPT_REASONS_AIM:GetValue()then
table.insert(reasons,"aimbot")
end
ifGUI_OPT_REASONS_WALL:GetValue()then
table.insert(reasons,"wallhack")
end
ifGUI_OPT_REASONS_EXTERNAL:GetValue()then
table.insert(reasons,"speedhack")
end
localsteam3_32bit=event:GetInt("attacker")
localsteam3_64bit="7656"..(0x116ebff0000+steam3_32bit)
print("reporting",steam3_64bit,"for",table.concat(reasons,','))
returnpanorama.RunScript("GameStateAPI.SubmitPlayerReport('"..tostring(steam3_64bit).."','"..tostring(table.concat(reasons,',')).."')")
end)



