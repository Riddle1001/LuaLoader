-- Scraped by chicken
-- Author: 90D5p33D
-- Title [Release] Enemy Ping Indicator
-- Forum link https://aimware.net/forum/thread/145314

localpositionvec3=Vector3(0,0,0)
localposx,posy=0
localuserID=0
localusername=""
localurgent=0
localref=gui.Reference("Visuals","World","Extra")
localtext=gui.ColorPicker(ref,"text.colour","TextColour",255,255,255,255)
localfill=gui.ColorPicker(ref,"fill.colour","FillColour",255,255,255,255)
localfill2=gui.ColorPicker(ref,"fill2.colour","Fill2Colour",0,0,0,255)
localpingtable={}
localzerovar=0

client.AllowListener("player_ping")
callbacks.Register("FireGameEvent",function(e)
ife:GetName()=="player_ping"then
positionvec3=Vector3(e:GetFloat("x"),e:GetFloat("y"),e:GetFloat("z"))
userID=e:GetInt("userid")
username=entities.GetByUserID(e:GetInt("userid")):GetName()
urgent=e:GetString("urgent")
table.insert(pingtable,{positionvec3,userID,urgent,0,username})
end
end)

callbacks.Register("Draw",function()

ifentities.GetByUserID(userID):GetTeamNumber()==entities.GetLocalPlayer():GetTeamNumber()thenreturnend
fori=1,#pingtabledo
fori2=1,#pingtable-1do
lasti2=entities.GetByUserID(pingtable[#pingtable-i2][2])
currenti=entities.GetByUserID(pingtable[2])
iflasti2:GetIndex()==currenti:GetIndex()then
table.remove(pingtable,i2)
end
end
posx,posy=client.WorldToScreen(pingtable[1])
pingtable[4]=pingtable[4]+1
ifpingtable[4]>=1000thentable.remove(pingtable,1)returnend
ifpingtable[3]=="0"orpingtable[3]==0then
draw.Color(text:GetValue())
draw.TextShadow(posx-56,posy+40,pingtable[5])
draw.Color(fill:GetValue())
draw.FilledCircle(posx,posy,30)
draw.Color(fill2:GetValue())
draw.FilledRect(posx-3,posy-12,posx+3,posy-18)
draw.FilledRect(posx-3,posy-6,posx+3,posy+16)
elseifpingtable[3]=="1"orpingtable[3]==1then
draw.Color(text:GetValue())
draw.TextShadow(posx-58,posy+16,pingtable[5])
draw.Color(fill:GetValue())
draw.Triangle(posx-50,posy,posx+50,posy,posx,posy-75)
draw.Color(fill2:GetValue())
draw.FilledRect(posx-3,posy-12,posx+3,posy-18)
draw.FilledRect(posx-3,posy-24,posx+3,posy-44)
end
end
end)



