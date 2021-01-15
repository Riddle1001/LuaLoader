-- Scraped by chicken
-- Author: firthY
-- Title [Release] Rotate In Air
-- Forum link https://aimware.net/forum/thread/104869

local fFlags = LocalPlayerEntity:GetProp( "m_fFlags" );
local Standing = false;
local Moving = false;
local InAir = false;

local VelocityX = LocalPlayerEntity:GetPropFloat("localdata", "m_vecVelocity[0]");
local VelocityY = LocalPlayerEntity:GetPropFloat("localdata", "m_vecVelocity[1]");

local Velocity = math.sqrt(VelocityX ^ 2 + VelocityY ^ 2);

--standing
if ( Velocity == 0 and ( fFlags == 257 or fFlags == 261 or fFlags == 263 ) ) then
  Standing = true
else
  Standing = false
end

-- In Air
if fFlags == 256 or fFlags == 262 then
  InAir = true
else
  InAir = false
end

function rotateInAir()

 if InAir then
 gui.SetValue("rbot_antiaim_move_real", 2)
 gui.SetValue("rbot_antiaim_spinbot_speed", 20)
 else
 gui.SetValue("rbot_antiaim_move_real", 5)
 end


end

callbacks.Register( "Draw", "rotateInAir", rotateInAir )