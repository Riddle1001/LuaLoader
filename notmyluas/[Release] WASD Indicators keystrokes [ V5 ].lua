-- Scraped by chicken
-- Author: AnAnAn
-- Title [Release] WASD Indicators keystrokes [ V5 ]
-- Forum link https://aimware.net/forum/thread/128301

---------------------------------------------------键位指示器 作者 An
-------------If you don't have fonts, Download：https://drive.google.com/file/d/1fkkthC4NV8emx3IddyCS4AGNTEUVWEod/view?usp=sharing
-------------中国用户如果不能打开谷歌链接，请联系 QQ 2926669800 获取字体文件
function rainbowmenu() 

 local speed = 3
 local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
 local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
 local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
 local a = 255
   

end

callbacks.Register( "Draw", "AWSD", rainbowmenu);


--WASD Indicators

local VA_Pitch, VA_Yaw, VA_Roll;
local alpha = 0
local p_local = entities.GetLocalPlayer();

function UCMD_GetAngles( UCMD )
 VA_Pitch, VA_Yaw, VA_Roll = UCMD:GetViewAngles();
  if input.IsButtonDown( 32 ) then
    if alpha < 248 then
      alpha = alpha + 8
    end
  else
    if alpha > 7 then
      alpha = alpha - 8
    end
  end
  
end

callbacks.Register( 'CreateMove', 'GetAngles', UCMD_GetAngles );

function drawBox(x1, y1, x2, y2)
draw.Color(150, 150, 150, 100)
draw.FilledRect( x1, y1, x2, y2 )
end

function drawActiveBox(x1, y1, x2, y2)
draw.Color(150, 150, 150, 200)
draw.FilledRect( x1, y1, x2, y2 )
end

function draw_buttons()
if entities.GetLocalPlayer() == nil then
  return
end

local x, y = draw.GetScreenSize()

local font1 = draw.CreateFont('An', 35)
local font2 = draw.CreateFont('An', 27)
    
     draw.SetFont(font1)

     if input.IsButtonDown( 87 ) then
		 drawActiveBox(127, 568, 171, 611) -- - 3 for x1, -2 y1, +44 x2, +53 y2
     draw.Color(0,255,0, 255) ----颜色
     else
		 drawBox(127, 568, 171, 611)
     draw.Color(255, 255, 255, 255)
     end
     draw.Text(132.5, 578, "W") -- 946, 750
     

     if input.IsButtonDown( 83 ) then
		 drawActiveBox(127, 612, 171, 651)
     draw.Color(0,255,0, 255) ----颜色
     else
		 drawBox(127, 612, 171, 651)
     draw.Color(255, 255, 255, 255)
     end
     draw.Text(135, 618, "S") --952 790
     
     
     if input.IsButtonDown( 65 ) then
		 drawActiveBox(88, 612, 126, 651)
     draw.Color(0,255,0, 255) ----颜色
     else
		 drawBox(88, 612, 126, 651)
     draw.Color(255, 255, 255, 255)
     end
     draw.Text(91, 618, "A") --912 790
     
     
     if input.IsButtonDown( 68 ) then
		 drawActiveBox(172, 612, 214, 651)
     draw.Color(0,255,0, 255) ----颜色
     else
		 drawBox(172, 612, 214, 651)
     draw.Color(255, 255, 255, 255)
     end
     draw.Text(180, 618, "D") --990 790
		 
		 
		if input.IsButtonDown( 81 ) then
		 drawActiveBox(88, 568, 126, 611)
     draw.Color(0,255,0, 255) ----颜色
		 draw.Text( 92, 578, "Q") --912 790
     else
     end
		 
		 if input.IsButtonDown( 69 ) then
		 drawActiveBox(172, 568, 214, 611)
     draw.Color(0,255,0, 255) ----颜色
		 draw.Text( 180, 578, "E") --912 790
     else
     end
     
     
    if input.IsButtonDown( 32 ) then
		draw.Color(		0,255,0, 255)
		 draw.Text( 97, 650, "space") --910 800
     end
		 
		 draw.SetFont(font2)
		 if input.IsButtonDown( 1 ) then
		 drawActiveBox(240, 568, 290, 651) ----按下后 方框的位置
    draw.Color(0,255,0, 255) ----颜色
    else
		 drawBox(240, 568, 290, 651) ----不按 方框的位置
    draw.Color(255, 255, 255, 255) ----颜色
    end
    draw.Text(248, 600, "M1") --字体位置
		 

		 if input.IsButtonDown( 2 ) then
		 drawActiveBox(291, 568, 341, 651) ----按下后 方框的位置
    draw.Color(0,255,0, 255) ----颜色
    else
		 drawBox(291, 568, 341, 651) ----不按 方框的位置
    draw.Color(255, 255, 255, 255) ----颜色
    end
    draw.Text(297, 600, "M2") --字体位置
 
     
		 
		 draw.SetFont(font2)
     
     --Shift
     if input.IsButtonDown( 16 ) then
      draw.Color(	0,255,0, 255)
			draw.Text(15, 650, "shift") --830 824
     end
      

end 
callbacks.Register('Draw', 'draw_buttons', draw_buttons);
