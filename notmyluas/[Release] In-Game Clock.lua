-- Scraped by chicken
-- Author: JohnK.
-- Title [Release] In-Game Clock
-- Forum link https://aimware.net/forum/thread/102977

localref=gui.Reference("VISUALS","MISC","Assistance")
localbox=gui.Groupbox(ref,"Clock")


localscale_s=gui.Slider(box,"scale_s","Clocksize",0.75,0.3,2.5);
localpos_x=gui.Slider(box,"pos_x_clock","Clockxposition",1000,0,4500);
localpos_y=gui.Slider(box,"pos_y_clock","Clockyposition",1000,0,3300);
localcolor_clock=gui.Checkbox(box,"color_clock","ClockGUIcolor",false)
localsound=gui.Checkbox(box,"sound","Clocksound",false)
localvolume=gui.Slider(box,"volume","Volume",100,0,100);
localalarm=gui.Editbox(box,"AlarmTime","00:00:00Example")
localcombobox=gui.Combobox(box,"combobox","TimerIn","Minuts","Seconds")
localtimer=gui.Slider(box,"timer","Timer",0,0,60);
localcolor_entry_primary=gui.ColorEntry("clock_color_primary","ClockPrimary",255,255,255,255)
localcolor_entry_secondary=gui.ColorEntry("clock_color_secondary","ClockSecondary",0,0,0,255)
localcolor_entry_tertiary=gui.ColorEntry("clock_color_tertiary","ClockTertiary",0,0,0,2555)
localalarm_active=false
localcount=0
localalarm_count=0



localfunctionCALCSEC(x)
return(x*math.pi/30)
end

localfunctionCALCMIN(x,y)
return(y*math.pi/30)+(x*math.pi/(30*60))
end

localfunctionCALCHOUR(x,y,z)
return(x*math.pi/6)+(y*math.pi/(6*60))+(z*math.pi/(360*60))
end

localfunctionline_thickness(x,y,xx,yy,thickness)
fori=0,thicknessdo
draw.Line(x+i,y,xx+i,yy)
end
end

localdrag=false
localpressed=false
localfunctiondrag_function(x,y,r)
localxm,ym=input.GetMousePos()
ifx==nilandy==nilthen
return
end
ifinput.IsButtonPressed(1)then
if(xm>(x-r))and(xm<(x+r))and(ym>(y-r))and(ym<(y+r))then
drag=true
else
drag=false
end
end
ifinput.IsButtonDown(1)then
ifdragthen
x,y=xm,ym
end
end
returnx,y
end


locallast=globals.RealTime()
functionon_second_change()

if((globals.RealTime())>last+1)then
ifsound:GetValue()then
client.Command("playvol/buttons/button22.wav"..volume:GetValue()/100,true)
end

ifcombobox:GetValue()==0then
min_to_sec=60
else
min_to_sec=1
end

ifmath.floor(timer:GetValue()*min_to_sec+0.5)>countandtimer:GetValue()~=0then
count=count+1
elseifmath.floor(timer:GetValue()*min_to_sec+0.5)==countandtimer:GetValue()~=0then
client.Command("playvol/weapons/taser/taser_shoot_birthday.wav1",true)
count=0
timer:SetValue(0)
end

ifalarm_activethen
alarm_count=alarm_count+1
ifalarm_count<=4then
client.Command("playvol/common/beep.wav1",true)
alarm:SetValue("00:00:00Example")
else
alarm_active=false
alarm_count=0
end
end

last=globals.RealTime()
end
end


localx1,y1=pos_x:GetValue(),pos_y:GetValue()

callbacks.Register("Draw",function()

if(os.date("%S")~=nil)then
on_second_change()
end

localr,g,b,a
localr_s,g_s,b_s,a_s
localr_o,g_o,b_o,a_o


ifcolor_clock:GetValue()then
r,g,b,a=gui.GetValue("clr_gui_window_background")
r_s,g_s,b_s,a_s=gui.GetValue("clr_gui_slider_bar2")
r_o,g_o,b_o,a_o=gui.GetValue("clr_gui_slider_bar3")
else
r,g,b,a=color_entry_primary:GetValue()
r_s,g_s,b_s,a_s=color_entry_secondary:GetValue()
r_o,g_o,b_o,a_o=color_entry_tertiary:GetValue()
end

localhours,minutes,seconds=os.date("%H"),os.date("%M"),os.date("%S")
localtime_alarm=os.date("%H:%M:%S")
localdate_os=os.date("%d.%m.%Y")
localscale=scale_s:GetValue()
ifalarm:GetValue()==time_alarmandalarm:GetValue()~=""then
alarm_active=true
end

ifinput.IsButtonDown(1)then
x1,y1=drag_function(pos_x:GetValue(),pos_y:GetValue(),61*scale)
pos_x:SetValue(x1)
pos_y:SetValue(y1)
end

draw.Color(r_o,g_o,b_o,a_o)
draw.OutlinedCircle(x1,y1,61*scale)
draw.Color(r,g,b,a)
draw.FilledCircle(x1,y1,60*scale)
draw.SetFont(draw.CreateFont("Arial",math.floor(12*scale+0.5)))

ifx1==nilthen
return
end

--secondshand
draw.Color(r_s,g_s,b_s,a_s)
line_thickness(x1,y1,x1+math.sin(CALCSEC(seconds))*50*scale,y1-math.cos(CALCSEC(seconds))*50*scale,0)

--minuteshand
line_thickness(x1,y1,x1+math.sin(CALCMIN(seconds,minutes))*40*scale,y1-math.cos(CALCMIN(seconds,minutes))*40*scale,2*scale,1)

--hourhand
line_thickness(x1,y1,x1+math.sin(CALCHOUR(hours,minutes,seconds))*30*scale,y1-math.cos(CALCHOUR(hours,minutes,seconds))*30*scale,3*scale,1)

fori=0,12do
localang=i*math.pi/6
ifi~=0then
localw_1,h_1=draw.GetTextSize(i)
draw.Text((x1+math.sin(ang)*50*scale)-w_1/2,(y1-math.cos(ang)*50*scale)-h_1/2,i)
end
end

fori=0,60do
localang=i*math.pi/30
ifi~=0then
ifi/5==math.floor(i/5)then
draw.Line((x1+math.sin(ang)*60*scale),(y1-math.cos(ang)*60*scale),(x1+math.sin(ang)*53*scale),(y1-math.cos(ang)*53*scale))
else
draw.Line((x1+math.sin(ang)*60*scale),(y1-math.cos(ang)*60*scale),(x1+math.sin(ang)*57*scale),(y1-math.cos(ang)*57*scale))
end
end
end
draw.SetFont(draw.CreateFont("Arial",math.floor(15*scale+0.5)))
localw,h=draw.GetTextSize(date_os)
draw.Color(r,g,b,a)
draw.RoundedRectFill(x1-w/2,y1+h*4,x1+w/2,y1+h*5)
draw.Color(r_s,g_s,b_s,a_s)
draw.Text(x1-w/2,y1+h*4,date_os)
end)



