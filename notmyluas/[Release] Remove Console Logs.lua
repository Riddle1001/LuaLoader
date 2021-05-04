-- Scraped by chicken
-- Author: leexx
-- Title [Release] Remove Console Logs
-- Forum link https://aimware.net/forum/thread/151088

localfunctionfilterconsole()
client.SetConVar("developer",0,1)
client.SetConVar("con_filter_enable",1,0)
client.SetConVar("con_filter_text","IrWL5106TZZKNFPz4P4Gl3pSN?J370f5hi373ZjPg%VOVh6lN",0)
end


localfunctionrestoreconsole()
client.SetConVar("con_filter_enable",0,0)
client.SetConVar("con_filter_text","",0)
end


localfilterconsolebutton=gui.Button(gui.Reference("Misc","General","Bypass"),"Filterconsole",filterconsole)


localrestoreconsolebutton=gui.Button(gui.Reference("Misc","General","Bypass"),"Restoreconsole",restoreconsole)

