-- Scraped by chicken
-- Author: Z3R0.docx
-- Title [Release] AW Best Hake
-- Forum link https://aimware.net/forum/thread/109808

local font = draw.CreateFont("Verdana", 32, 300)
local x = -288

function main()
  if(x > 1920)then
    x = -288
  end
  x = x + 1
  draw.SetFont(font)
  draw.Color(255, 0, 0, 255)
  draw.Text(x , 0, "AIMWARE BEST HAKE")
end

callbacks.Register("Draw", "killme", main)
