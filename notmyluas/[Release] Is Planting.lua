-- Scraped by chicken
-- Author: JohnK.
-- Title [Release] Is Planting
-- Forum link https://aimware.net/forum/thread/103761

localis_planting=false
localuid=nil
localis_planting_active=gui.Checkbox(gui.Reference('VISUALS',"ENEMIES","Options","Flags"),"is_planting_active","IsPlanting",false)
localcolor_entry=gui.ColorEntry("is_planting__color","IsPlanting",255,255,0,255)

localfont=draw.CreateFont("Arial",25,500)
localsite=""
localsitename=""


localplant_side={
["A"]={268,425,317,423,79,93,152,278,288,210,134,508,517},
["B"]={150,426,318,334,507,538,403,279,209,313,520,529},
[""]={},
}

localfunctiontable_contains(table,item)
fori=1,#tabledo
iftable[i]==itemthen
returntrue
end
end
returnfalse
end

localfunctionfind_key(value)
fork,vinpairs(plant_side)do
iftable_contains(v,value)then
returnk
end
end
end

localfunctionlerp_pos(x1,y1,z1,x2,y2,z2,percentage)
localx=(x2-x1)*percentage+x1
localy=(y2-y1)*percentage+y1
localz=(z2-z1)*percentage+z1
returnx,y,z
end

localfunctionget_site_name(site)
locala_x,a_y,a_z=entities.GetPlayerResources():GetProp("m_bombsiteCenterA")
localb_x,b_y,b_z=entities.GetPlayerResources():GetProp("m_bombsiteCenterB")

localsite_x1,site_y1,site_z1=site:GetMins()
localsite_x2,site_y2,site_z2=site:GetMaxs()

localsite_x,site_y,site_z=lerp_pos(site_x1,site_y1,site_z1,site_x2,site_y2,site_z2,0.5)
localdistance_a,distance_b=vector.Distance(site_x,site_y,site_z,a_x,a_y,a_z),vector.Distance(site_x,site_y,site_z,b_x,b_y,b_z)

returndistance_b>distance_aand"A"or"B"
end

localfunctionget_event(Event)

ifEvent~=nilthen

ifEvent:GetName()=="bomb_beginplant"then
uid=Event:GetInt("userid")
is_planting=true
localPlantSite=Event:GetInt('site');
--site=find_key(PlantSite)
sitename=get_site_name(entities.GetByIndex(Event:GetInt("site")))
end

ifEvent:GetName()=="bomb_abortplant"orEvent:GetName()=="bomb_planted"orEvent:GetName()=="round_prestart"then
is_planting=false
uid=nil
entity=nil
end

ifuid==nilthen
return
end

localentity=entities.GetByUserID(uid)

ifentity==nilthen
return
end

ifnotentity:IsAlive()then
is_planting=false
uid=nil
entity=nil
end
end
end

localfunctiondraw_planting(Builder)

localentity=nil

ifnotis_planting_active:GetValue()then
return
end

localindex=nil



ifuid~=nilthen
entity=entities.GetByUserID(uid)
ifentity~=nilthen
index=entity:GetIndex()
end
else
entity=nil
index=nil
end

ifindex==nilthen
return
end

ifentity:GetTeamNumber()~=entities.GetLocalPlayer():GetTeamNumber()then
localbuilder_entity=Builder:GetEntity()
localbuilder_index=builder_entity:GetIndex()
ifbuilder_entity~=nilandis_plantingthen
ifindex==builder_indexthen
Builder:Color(color_entry:GetValue())
Builder:AddTextBottom("IsPlanting")
end
end
end
end

localfunctiondraw_text()
ifnotis_planting_active:GetValue()then
return
end

ifis_plantingthen
draw.SetFont(font)
draw.Color(color_entry:GetValue())
draw.TextShadow(20,10,"IsPlanting"..sitename)
end
end

client.AllowListener("bomb_beginplant")
client.AllowListener("bomb_abortplant")
client.AllowListener("bomb_planted")
client.AllowListener("round_prestart")
callbacks.Register("FireGameEvent","get_event",get_event)
callbacks.Register("DrawESP","draw_planting",draw_planting)
callbacks.Register("Draw","draw_text",draw_text)



