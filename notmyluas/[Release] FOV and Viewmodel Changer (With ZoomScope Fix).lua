-- Scraped by chicken
-- Author: atk3001
-- Title [Release] FOV and Viewmodel Changer (With ZoomScope Fix)
-- Forum link https://aimware.net/forum/thread/132424

localREF=gui.Reference("Settings")

localTAB=gui.Tab(REF,"lua_fov_tab","FovChanger")

localFOVBOX=gui.Groupbox(TAB,"FOV",15,15,605,500)
localSLIDER=gui.Slider(FOVBOX,"lua_fov_slider","FieldofView",90,0,180)
localSLIDER_ONE=gui.Slider(FOVBOX,"lua_fov_slider_one","FieldofViewfor1stZoom",40,0,180)
localSLIDER_TWO=gui.Slider(FOVBOX,"lua_fov_slider_two","FieldofViewfor2ndZoom",15,0,180)
localFOVBETWEENCHECK=gui.Checkbox(FOVBOX,"lua_fov_between__shot_checkbox","ResetFOVbetweenscopedshots",0)

localVIEWBOX=gui.Groupbox(TAB,"Viewmodel",15,260,605,500)
localSLIDER_VIEW=gui.Slider(VIEWBOX,"lua_fov_slider_view","ViewmodelFieldofView",60,0,180)
localSLIDER_VIEWX=gui.Slider(VIEWBOX,"lua_fov_slider_viewX","ViewmodelOffsetX",1,-40,40)
localSLIDER_VIEWY=gui.Slider(VIEWBOX,"lua_fov_slider_viewY","ViewmodelOffsetY",1,-40,40)
localSLIDER_VIEWZ=gui.Slider(VIEWBOX,"lua_fov_slider_viewZ","ViewmodelOffsetZ",-1,-40,40)

localbetweenshot

callbacks.Register("Draw",function()
if(entities.GetLocalPlayer()~=nilandengine.GetServerIP()~=nilandengine.GetMapName()~=nil)then
locala=0
localplayer_local=entities.GetLocalPlayer();
localscoped=player_local:GetProp("m_bIsScoped")

ifscoped~=0andscoped~=256and(FOVBETWEENCHECK:GetValue()andtostring(scoped)=="65536")~=truethen
localgWeapon=player_local:GetPropEntity("m_hActiveWeapon")
localzoomLevel=gWeapon:GetProp("m_zoomLevel")
ifzoomLevel==1then
ifSLIDER_ONE:GetValue()==90then
a=-40
end
client.SetConVar("fov_cs_debug",SLIDER_ONE:GetValue(),true)
elseifzoomLevel==2then
ifSLIDER_TWO:GetValue()==90then
a=-40
end
client.SetConVar("fov_cs_debug",SLIDER_TWO:GetValue(),true)
end
else
client.SetConVar("fov_cs_debug",SLIDER:GetValue(),true)
end
client.SetConVar("viewmodel_fov",SLIDER_VIEW:GetValue(),true)
client.SetConVar("viewmodel_offset_x",SLIDER_VIEWX:GetValue(),true);
client.SetConVar("viewmodel_offset_y",SLIDER_VIEWY:GetValue(),true);
client.SetConVar("viewmodel_offset_z",SLIDER_VIEWZ:GetValue()+a,true);
end
end)
