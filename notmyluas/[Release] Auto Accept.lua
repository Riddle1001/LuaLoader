-- Scraped by chicken
-- Author: OurmineOGTv
-- Title [Release] Auto Accept
-- Forum link https://aimware.net/forum/thread/128200

--Auto Accept by OurmineOGTv#6846
--I rewrite Clipper(superyu'#7167) Auto Accept LUA -> https://aimware.net/forum/thread-128126.html
--Update by AppleJeb -> https://aimware.net/forum/user-187190.html

localAutoAcceptLast
localAutoAccept=gui.Checkbox(gui.Reference("Misc","General","Extra"),"onyx.auto.accept","AutoAccept",false)
AutoAccept:SetDescription("Autoacceptmatchmakinggames")

localfunctionAutoAcceptFunction(val)
panorama.RunScript(string.format([[
$.AutoAcceptEnabled=%s
functionautoaccept(){
$.Schedule(1,autoaccept)

if(!LobbyAPI.IsSessionActive()||LobbyAPI.GetReadyTimeRemainingSeconds()==0)
return;

if($.AutoAcceptEnabled)LobbyAPI.SetLocalPlayerReady('accept');
}

autoaccept();
]],valand"true"or"false"))
AutoAcceptLast=valandtrueorfalse
end

callbacks.Register("Draw","AutoacceptToggle",function()
ifAutoAcceptLast~=(AutoAccept:GetValue()andtrueorfalse)then
AutoAcceptFunction(AutoAccept:GetValue())
end
end)