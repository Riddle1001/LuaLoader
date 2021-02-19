-- Scraped by chicken
-- Author: anue
-- Title [Release] Fullbright
-- Forum link https://aimware.net/forum/thread/88374

local c_reg = callbacks.Register
local c_var = client.SetConVar

function fBright()
 c_var("mat_fullbright", 1, true)
end


c_reg("Draw", "fBright", fBright)