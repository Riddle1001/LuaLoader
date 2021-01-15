-- Scraped by chicken
-- Author: Kowbra
-- Title [Release] Rainbow text
-- Forum link https://aimware.net/forum/thread/86042

local Text_String = 'aimware.net';

local XPos_Mul = 0.05;
local YPos_Mul = 0.05;

local RB_Frequency = 1.5;

function DRAW_RBText()

  local SIN = math.sin;

  local ScrW, ScrH = draw.GetScreenSize();

  local RB_Time = globals.RealTime();

  local COL_Red = SIN( RB_Frequency * RB_Time ) * 127 + 128;
  local COL_Green = SIN( RB_Frequency * RB_Time + 2 ) * 127 + 128;
  local COL_Blue = SIN( RB_Frequency * RB_Time + 4 ) * 127 + 128;

  draw.Color( COL_Red, COL_Green, COL_Blue );
  draw.TextShadow( ScrW * tonumber( XPos_Mul ), ScrH * tonumber( YPos_Mul ), tostring( Text_String ) );

end

callbacks.Register( 'Draw', 'AWRBD', DRAW_RBText );