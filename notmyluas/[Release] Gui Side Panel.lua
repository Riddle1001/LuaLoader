-- Scraped by chicken
-- Author: RadicalMario
-- Title [Release] Gui Side Panel
-- Forum link https://aimware.net/forum/thread/92747

local Settings_Ref = gui.Reference("SETTINGS", "Miscellaneous")
local Checkbox_SideMenu = gui.Checkbox( Settings_Ref, "lua_wnd_extwnd_show", "Enable Side Panels", false )
local Slider_InSpeed = gui.Slider( Settings_Ref, "lua_wnd_extwnd_inspeed", "Roll-In Speed", 22,0,100 )
local Slider_OutSpeed = gui.Slider( Settings_Ref, "lua_wnd_extwnd_outspeed", "Roll-Out Speed", 22,0,100 )
local xpos, ypos = gui.GetValue( "wnd_menu" )
local ltop = 0
local rtop = 0
local rfreespace = 0
local lfreespace = 0
local dfreespace = 15
local SidePanelLeftSize = 245  --set value to resize left panel
local SidePanelRightSize = 245  --set value to resize right panel
local HideLeftMenu = false
local HideRightMenu = false
local fadeOpacityLeft = 220
local fadeOpacityBgLeft = 150
local fadeOpacityRight = 220
local fadeOpacityBgRight = 150
local xr_in = 0
local xl_in = 0
local xr_out = 0
local xl_out = 0
local RightBar_In = false
local LeftBar_In = false
local RightBar_Out = false
local LeftBar_Out = false
local InSpeed = 22
local OutSpeed = 22
local mouseX, mouseY = input.GetMousePos()
local MainGuiKey = gui.GetValue( "msc_menutoggle" )  --getting the Menu Key number. default "45" ( insert )
local isOpen
local KeyIsPressed
local scriptLoaded

function isGuiOpen()  --checking if aw menu is open
  if input.IsButtonPressed(MainGuiKey) then
    if isOpen == false then
      KeyIsPressed = true
      isOpen = true
    else
      KeyIsPressed = false
      isOpen = false
    end
  elseif KeyIsPressed ~= false and isOpen ~= true then
    isOpen = true
  end
  return isOpen
end

---------------------------------------
-- -- -- -- Drawing -- -- -- --
---------------------------------------
function draw.Block(left,top,height,width)
  draw.FilledRect( left, top, left+width, top+height )
end

function draw.RoundedBlock(left,top,height,width)
  draw.RoundedRectFill( left, top, left+width, top+height )
end

function draw.Encircle(left,top,height,width)
  draw.OutlinedRect( left, top, left+width, top+height )
end

function draw.RoundedEncircle(left,top,height,width)
  draw.RoundedRect( left, top, left+width, top+height )
end

--[[
  @draw.Triangle(left,top,height,arrow_direction))
]]
function draw.Triangle(peak_left,peak_top,height,position)
  height_t = height
  left_l = peak_left
  left_r = peak_left
  top_l = peak_top
  top_r = peak_top

 if position == 1 then --
   draw.Line( peak_left, peak_top, peak_left, peak_top-height )
 end
 if position == 2 then
   draw.Line( peak_left, peak_top, peak_left, peak_top+height )
 end
 if position == 3 then
   draw.Line( peak_left, peak_top, peak_left+height, peak_top )
 end
 if position == 4 then
   draw.Line( peak_left, peak_top, peak_left-height, peak_top )
 end

 for i = 1, 1000 do
 height_t = height_t - 1
 left_l = left_l - 1
 left_r = left_r + 1
 top_l = top_l - 1
 top_r = top_r + 1
   if height_t < 0 then
     break
   end
   if position == 1 then
     draw.Line( left_l, peak_top-height_t, left_l, peak_top )
     draw.Line( left_r, peak_top-height_t, left_r, peak_top )
   end   
   if position == 2 then
     draw.Line( left_l, peak_top, left_l, peak_top+height_t )
     draw.Line( left_r, peak_top, left_r, peak_top+height_t )
   end     
   if position == 3 then
     draw.Line( peak_left, top_l, peak_left+height_t, top_l )
     draw.Line( peak_left, top_r, peak_left+height_t, top_r )
   end 
   if position == 4 then
     draw.Line( peak_left-height_t, top_l, peak_left, top_l )
     draw.Line( peak_left-height_t, top_r, peak_left, top_r )
   end 
 end

end

--[[
  @Timer:
  timer.Create("timer_name",    ---timer_name = unique name
    delay,            --1.0 = 1sec
    times,            --ammount of executing function (set 1 for only once)
    function()          --your function
    print("Timer")        --example function
  end)
]]
timer=timer or{} timers={}function timer.Create(a,b,c,d)table.insert(timers,{["name"]=a,["delay"]=b,["times"]=c,["func"]=d,["lastTime"]=globals.RealTime()})end function timer.Remove(a)for e,f in pairs(timers or{})do if a==f["name"]then table.remove(timers,e)end end end function timer.Tick()for e,f in pairs(timers or{})do if f["times"]<=0 then table.remove(timers,e)end if f["lastTime"]+f["delay"]<=globals.RealTime()then timers[e]["lastTime"]=globals.RealTime()timers[e]["times"]=timers[e]["times"]- 1 f["func"]()end end end callbacks.Register("Draw","timerTick",timer.Tick)

--begin of a realy messy script


local Window_pMenuRight = gui.Window("lua_wnd_spright", "", xpos, ypos, SidePanelRightSize, 580)
local Window_pMenuLeft = gui.Window("lua_wnd_spleft", "AIMWARE.NET | CS:GO", xpos, ypos, SidePanelLeftSize, 580)
local Groupbox_pMenuLeft = gui.Groupbox( Window_pMenuLeft, "", 0, 0, SidePanelLeftSize, 572 )
local Groupbox_pMenuRight = gui.Groupbox( Window_pMenuRight, "", 0, 0, SidePanelRightSize, 572 )

lsp = lsp or {}
rsp = rsp or {}

--[[
@Add Groupbox Example for Right Panel:
  local Groupbox_Example = rsp.Groupbox("Example",75)
  local Checkbox_Example = gui.Checkbox( Groupbox_Example, "lua_example_enable", "Enable", 0 )
@or
  local Reference_RightSidePanel = rsp.Reference()
  local Groupbox_Example = gui.Groupbox( Reference_RightSidePanel, "Example", -16, 0, 245, 75 )
  local Checkbox_Example = gui.Checkbox( Groupbox_Example, "lua_example", "Enable", 0 )
]]

local function pMenuRight(xpos,ypos)
	if Checkbox_SideMenu:GetValue() and isGuiOpen() then
		mouseX, mouseY = input.GetMousePos()
		Window_pMenuRight:SetValue((xpos + 800), ypos)
		if HideRightMenu then
     if xr_in < SidePanelRightSize and RightBar_In == false then
       timer.Create("rightbar_scroll_in", 0.05, 1, function()
         xr_in = xr_in + InSpeed
       end)
       xr, yr = Window_pMenuRight:GetValue()
       xr_pos = xr
       yr_pos = yr+290
       draw.Color(232, 232, 232, fadeOpacityRight)
       draw.RoundedBlock(xr_pos, yr,600,10)
       Window_pMenuRight:SetValue((xpos + 800)-(xr_in+5), ypos)
     elseif xr_in >= SidePanelRightSize then
       Window_pMenuRight:SetActive(0)
       xr, yr = Window_pMenuRight:GetValue()
       xr_pos = xr
       yr_pos = yr+290
       RightBar_In = true
     end
     if not (mouseX > xr_pos and xr_pos+20 > mouseX and mouseY > yr_pos-300 and yr_pos+300 > mouseY) then
       if fadeOpacityRight >= 20 and stopfader ~= true then
         fadingR = true
         timer.Create("SidePanel_fade1", 0.1, 1, function()
           fadeOpacityRight = fadeOpacityRight - 1
           fadeOpacityBgRight = fadeOpacityRight
         end)
       elseif fadingR and fadeOpacityRight <= 20 then
         fadingR = false
         stopfader = true
       end

       draw.Color(232, 232, 232, fadeOpacityRight)
       draw.RoundedBlock(xr_pos, yr,600,10)

     else
       if (input.IsButtonPressed("mouse1")) then
         draw.Color(232, 232, 232, fadeOpacityRight)
         draw.RoundedBlock(xr_pos, yr,600,10)
         HideRightMenu = false
         RightBar_In = false
         xr_in = 0
       end
       draw.Color(232, 232, 232, fadeOpacityRight)
       draw.RoundedBlock(xr_pos, yr,600,10)

       fadingR = false
       fadeOpacityRight = 220
       fadeOpacityBgRight = 150
       stopfader = false
     end
   else
     if xr_out < SidePanelRightSize and RightBar_Out == false then
       timer.Create("rightbar_scroll_out", 0.05, 1, function()
         xr_out = xr_out + OutSpeed
       end)
       xr, yr = Window_pMenuRight:GetValue()
       xr_pos = ((xr+xr_out-5))
       yr_pos = yr+290
       draw.Color(232, 232, 232, fadeOpacityRight)
       draw.RoundedBlock(xr_pos, yr,600,10)
       Window_pMenuRight:SetValue(((xpos + 800)+(xr_out-5))-SidePanelRightSize, ypos)

       RightBar_Out = false
     else
       xr, yr = Window_pMenuRight:GetValue()
       xr_out = 0
       xr_pos = (xr-xr_out)+SidePanelRightSize
       yr_pos = yr+290
       draw.Color(232, 232, 232, fadeOpacityRight)
       draw.RoundedBlock(xr_pos, yr,600,10)
       RightBar_Out = true
     end
     Window_pMenuRight:SetActive(1)


     if not (mouseX > xr_pos and xr_pos+20 > mouseX and mouseY > yr_pos-300 and yr_pos+300 > mouseY) then
       if fadeOpacityRight >= 20 and stopfadel ~= true then
         fadingR = true
         timer.Create("SidePanel_fade2", 0.1, 1, function()
           fadeOpacityRight = fadeOpacityRight - 1
           fadeOpacityBgRight = fadeOpacityRight
         end)
       elseif fadingR and fadeOpacityRight <= 20 then
         fadingR = false
         stopfadel = true
       end

       draw.Color(232, 232, 232, fadeOpacityRight)
       draw.RoundedBlock(xr_pos, yr,600,10)
     else
       if (input.IsButtonPressed("mouse1")) then
         fadingR = false
         draw.Color(232, 232, 232, fadeOpacityRight)
         draw.RoundedBlock(xr_pos, yr,600,10)
         xr_in = 0
         HideRightMenu = true
         RightBar_Out = false
       end
       fadingR = false
       fadeOpacityRight = 220
       fadeOpacityBgRight = 150
       stopfadel = false
     end
   end
 else
   Window_pMenuRight:SetActive(0)
 end
end

local function pMenuLeft(xpos,ypos)
	if Checkbox_SideMenu:GetValue() and isGuiOpen() then
		Window_pMenuLeft:SetValue((xpos - SidePanelLeftSize), ypos)
		mouseX, mouseY = input.GetMousePos()
		if HideLeftMenu then
     if xl_in < SidePanelLeftSize and LeftBar_In == false then
       timer.Create("leftbar_scroll_in", 0.05, 1, function()
         xl_in = xl_in + InSpeed
       end)
       xl, yl = Window_pMenuLeft:GetValue()
       Window_pMenuLeft:SetValue((xpos-SidePanelLeftSize)+(xl_in-5), ypos)

     elseif xl_in >= SidePanelLeftSize then
       Window_pMenuLeft:SetActive(0)
       xl_in = 0
       LeftBar_In = true
     end
     xl, yl = Window_pMenuLeft:GetValue()
     xl_pos = xl+SidePanelLeftSize-10
     yl_pos = yl+290
     draw.Color(232, 232, 232, fadeOpacityLeft)
     draw.RoundedBlock(xl_pos, yl,600,10)
     if not (mouseX > xl_pos-10 and xl_pos+10 > mouseX and mouseY > yl_pos-300 and yl_pos+300 > mouseY) then
       if fadeOpacityLeft >= 20 and stopfadel ~= true then
         fadingL = true
         timer.Create("SidePanel_fade3", 0.1, 1, function()
           fadeOpacityLeft = fadeOpacityLeft - 1
           fadeOpacityBgLeft = fadeOpacityLeft
         end)
       elseif fadingL and fadeOpacityLeft <= 20 then
         fadingL = false
         stopfadel = true
       end
       draw.Color(232, 232, 232, fadeOpacityLeft)
       draw.RoundedBlock(xl_pos, yl,600,10)
     else
       if (input.IsButtonPressed("mouse1")) then
         draw.Color(232, 232, 232, fadeOpacityLeft)
         draw.RoundedBlock(xl_pos, yl,600,10)
         HideLeftMenu = false
         LeftBar_In = false
       end
       fadingL = false
       fadeOpacityLeft = 220
       fadeOpacityBgLeft = 150
       stopfadel = false
     end
   else
     if xl_out < SidePanelLeftSize and LeftBar_Out == false then
       timer.Create("leftbar_scroll_out", 0.05, 1, function()
         xl_out = xl_out + OutSpeed
       end)

       xl, yl = Window_pMenuLeft:GetValue()
       xl_pos = (xl)+SidePanelLeftSize
       yl_pos = yl+290
       draw.Color(232, 232, 232, fadeOpacityLeft)
       draw.RoundedBlock(xl_pos, yl,600,10)
       Window_pMenuLeft:SetValue(((xpos)-(xl_out+5)), ypos)
       LeftBar_Out = false
     else
       xl, yl = Window_pMenuLeft:GetValue()

       xl_pos = ((xl-10))
       yl_pos = yl+290
       draw.Color(232, 232, 232, fadeOpacityLeft)
       draw.RoundedBlock(xl_pos, yl,600,10)
       LeftBar_Out = true
     end
     Window_pMenuLeft:SetActive(1)

     if not (mouseX > xl_pos-10 and xl_pos+10 > mouseX and mouseY > yl_pos-300 and yl_pos+300 > mouseY) then
       if fadeOpacityLeft >= 20 and stopfadel ~= true then
         fadingL = true
         timer.Create("SidePanel_fade4", 0.1, 1, function()
           fadeOpacityLeft = fadeOpacityLeft - 1
           fadeOpacityBgLeft = fadeOpacityLeft
         end)
       elseif fadingL and fadeOpacityLeft <= 20 then
         fadingL = false
         stopfadel = true
       end

       draw.Color(232, 232, 232, fadeOpacityLeft)
       draw.RoundedBlock(xl_pos, yl,600,10)

     else
       if (input.IsButtonPressed("mouse1")) then
         draw.Color(232, 232, 232, fadeOpacityLeft)
         draw.RoundedBlock(xl_pos, yl,600,10)
         HideLeftMenu = true
         LeftBar_Out = false
         xl_out = 0

       end
       fadingL = false
       fadeOpacityLeft = 220
       fadeOpacityBgLeft = 150
       stopfadel = false
     end
   end
 else
   Window_pMenuLeft:SetActive(0)
 end
end

function pMenu()
	InSpeed = math.floor(Slider_InSpeed:GetValue())
	OutSpeed = math.floor(Slider_OutSpeed:GetValue())

	if Checkbox_SideMenu:GetValue() then
		if Window_pMenuLeft ~= nil then
			xpos, ypos = gui.GetValue( "wnd_menu" )
			pMenuRight(xpos, ypos)
			pMenuLeft(xpos, ypos)
			
			if isGuiOpen() then
			return end
			
			xpos, ypos = gui.GetValue( "wnd_menu" )
			pMenuRight(xpos, ypos)
			pMenuLeft(xpos, ypos)
			Window_pMenuLeft:SetActive(0)
			Window_pMenuRight:SetActive(0)
		else
		end
	else
		Window_pMenuLeft:SetActive(0)
		Window_pMenuRight:SetActive(0)
		
	end
end
callbacks.Register( "Draw", "Side Panel", pMenu )

if Checkbox_SideMenu:GetValue() ~= nil then

	function lsp.Reference() return Groupbox_pMenuLeft end
	function rsp.Reference() return Groupbox_pMenuRight end

	function lsp.Groupbox(title,hight)
		if title ~= nil and hight ~= nil then
			temp_top = ltop + lfreespace
			ltop = ltop + hight + lfreespace
			lfreespace = dfreespace
		else
			title = "nil"
			hight = 0
		end
	return gui.Groupbox( Groupbox_pMenuLeft, title, -16, temp_top, 245, hight )
	end
			
	function rsp.Groupbox(title,hight)
		if title ~= nil and hight ~= nil then
			temp_top = rtop + rfreespace
			rtop = rtop + hight + rfreespace
			rfreespace = dfreespace
		else
			title = "nil"
			hight = 0
		end
	return gui.Groupbox( Groupbox_pMenuRight, title, -16, temp_top, 245, hight )
	end
end