-- Scraped by chicken
-- Author: TooHypedUp
-- Title [Release] Manual aa improvement.lua
-- Forum link https://aimware.net/forum/thread/113912

--Edited by: 2HypedUp--

--Credits to: Ohri31 for original post--


--Changelog: Added Desync values to better aa--

--     Changed indicators (<,>,v)--

--     Changed Text for autodirection--

--     Changed Auto direction (manual)--

--     Changed Auto diretion (auto)--

--     Removed Auto direction for left/right--

--     Changed some auto direction types--

--     Added front AA--

--     Changed text of some AA--

--     Changed indicators v2 (draw.triangle)--

--     Added front indicator--

--     Triangles properly rotated instead of scaled--

--     Changed way colour is caled upon--

--     Added text whilst fixing draw.triangle--

--     Changed desync types--


--To do:--

--   Full test indicators--

--   Neaten code up--

--   Change the callsigns to shorten code--

--   Add anti aim inverter to code--

--   Fix bug reports(Updating indicator color fix (16/09/19)--

--   Message Arpac when finished--


leftkey = -1;

backkey = -1;

rightkey = -1;

frontkey = -1;

rageRef = gui.Reference("RAGE", "MAIN", "Anti-aim Main");

check_indicator = gui.Checkbox( rageRef, "Enable", "Manual AA", false);

antiAimLeft = gui.Keybox(rageRef, "antiAimLeft", "Left Balance", 0);

antiAimRight = gui.Keybox(rageRef, "antiAimRight", "Right stretch", 0);

antiAimBack = gui.Keybox(rageRef, "antiAimBack", "Back Jitter", 0);

antiAimFront = gui.Keybox(rageRef, "antiAimFront", "Front Jitter", 0);

local scaleslider = gui.Slider(rageRef, "S", "Triangle Size", 40, 0, 70);

local distance = gui.Slider(rageRef, distance, "Triangle Gap", 70, 15, 250)

local pclr = gui.ColorEntry( pclr, "Manual AA indicator direction", 255, 0, 255, 200)--pclr is pressed colour--

local upclr = gui.ColorEntry( upclr, "Manual AA indicator others", 0, 0, 0, 100)--upclr is unpressed colour--

S1 = gui.Slider(rageRef, "S1", "Font Size", 40, 0, 70);




--anti-aim settings--


local function main()

 if antiAimLeft:GetValue() ~= 0 then

   if input.IsButtonPressed(antiAimLeft:GetValue()) then

     leftkey = leftkey * -1; --toggle key--

     frontkey = -1;

     backkey = -1;

     rightkey = -1;

     gui.SetValue("rbot_antiaim_stand_real_add", -90);

     gui.SetValue("rbot_antiaim_move_real_add", -90);

     gui.SetValue("rbot_antiaim_at_targets", 0);

     gui.SetValue("rbot_antiaim_stand_desync", 2);

     gui.SetValue("rbot_antiaim_move_desync", 2);

     gui.SetValue("rbot_antiaim_autodir", 0);

   end

 end

 if antiAimBack:GetValue() ~= 0 then

   if input.IsButtonPressed(antiAimBack:GetValue()) then

     backkey = backkey * -1;--toggle key--

     leftkey = -1;

     frontkey = -1;

     rightkey = -1;

      gui.SetValue("rbot_antiaim_stand_real_add", 0);

      gui.SetValue("rbot_antiaim_move_real_add", 0);

      gui.SetValue("rbot_antiaim_at_targets", 0);

      gui.SetValue("rbot_antiaim_stand_desync", 2);

      gui.SetValue("rbot_antiaim_move_desync", 2);

      gui.SetValue("rbot_antiaim_autodir", 2)

   end

 end

 if antiAimRight:GetValue() ~= 0 then

   if input.IsButtonPressed(antiAimRight:GetValue()) then

     rightkey = rightkey * -1;--toggle key--

     leftkey = -1;

     frontkey = -1;

     backkey = -1;

     gui.SetValue("rbot_antiaim_stand_real_add", 90);

     gui.SetValue("rbot_antiaim_move_real_add", 90);

     gui.SetValue("rbot_antiaim_at_targets", 0);

     gui.SetValue("rbot_antiaim_stand_desync", 3);

     gui.SetValue("rbot_antiaim_move_desync", 3);

     gui.SetValue("rbot_antiaim_autodir", 0)

   end

 end

 if antiAimFront:GetValue() ~= 0 then

   if input.IsButtonPressed(antiAimFront:GetValue()) then

     frontkey = frontkey * -1; --toggle key--

     rightkey = -1;

     leftkey = -1;

     backkey = -1;

     gui.SetValue("rbot_antiaim_stand_real_add", 180);

     gui.SetValue("rbot_antiaim_move_real_add", -180);

     gui.SetValue("rbot_antiaim_at_targets", 0);

     gui.SetValue("rbot_antiaim_stand_desync", 4);

     gui.SetValue("rbot_antiaim_move_desync", 4);

     gui.SetValue("rbot_antiaim_autodir", 2)

    end

 end

end


function SetAuto()

 gui.SetValue("rbot_antiaim_stand_real_add", 0);

 gui.SetValue("rbot_antiaim_move_real_add", 0);

 gui.SetValue("rbot_antiaim_at_targets", 2);

 gui.SetValue("rbot_antiaim_move_desync", 1);

 gui.SetValue("rbot_antiaim_stand_desync", 1);

 gui.SetValue("rbot_antiaim_autodir", 2)

end


function draw_indicator()


 triangleSize = math.floor(gui.GetValue("S"));

 textSize = math.floor(gui.GetValue("S1"));


 local active = check_indicator:GetValue();


 if active then


 local w, h = draw.GetScreenSize();


 local scale = scaleslider:GetValue()


 local triangle = draw.Triangle(triangleSize, 30);


 local rounddist = 0


 rounddist = math.floor(distance:GetValue())


 distance:SetValue(rounddist)


    local textFont = draw.CreateFont("Verdena", textSize, 30);

 draw.Color(pclr:GetValue());


     if (leftkey == 1) then

       draw.SetFont(textFont);

       draw.Color(pclr:GetValue());

       draw.TextShadow(15, h/2, "Left")


     elseif (frontkey == 1) then

       draw.SetFont(textFont);

       draw.Color(pclr:GetValue());

       draw.TextShadow(15, h/2, "Forward")


     elseif (rightkey == 1) then 

       draw.SetFont(textFont);

       draw.Color(pclr:GetValue());

       draw.TextShadow(15, h/2, "Right")


     elseif (backkey == 1) then

       draw.SetFont(textFont);

       draw.Color(pclr:GetValue());

       draw.TextShadow(15, h/2, "Backwards")


     else

       draw.SetFont(textFont);

       draw.Color(pclr:GetValue());

       draw.TextShadow(15, h/2, "AW AutoD");

       SetAuto();

     end

    end

  end


callbacks.Register( "Draw", "main", main);

callbacks.Register( "Draw", "draw_indicator", draw_indicator);