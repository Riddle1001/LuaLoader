-- Scraped by chicken
-- Author: BQJ
-- Title [Release] Easy Crosshair Editor
-- Forum link https://aimware.net/forum/thread/145866

local wnd = gui.Reference("Visuals")
local editor_tab = gui.Tab(wnd, "crs", "Crosshair")
gui.Groupbox(editor_tab, "Crosshair Values", 10, 10, 600)
local wnd_editor = gui.Reference("Visuals", "Crosshair", "Crosshair Values")

local current_style = client.GetConVar("cl_crosshairstyle")
local current_style_t = client.GetConVar("cl_crosshair_t")
local current_color = client.GetConVar("cl_crosshaircolor")
local current_size = client.GetConVar("cl_crosshairsize")
local current_thickness = client.GetConVar("cl_crosshairthickness")
local current_gap = client.GetConVar("cl_crosshairgap")
local current_fixedgap = client.GetConVar("cl_fixedcrosshairgap")
local current_aplha = client.GetConVar("cl_crosshairusealpha")
local current_alphaV = client.GetConVar("cl_crosshairalpha")
local current_dot = client.GetConVar("cl_crosshairdot")
local current_outline = client.GetConVar("cl_crosshair_drawoutline")
local current_outline_thickness = client.GetConVar("cl_crosshair_outlinethickness")      
local style = gui.Slider(wnd_editor, "style", "Style", current_style, 0, 5)
local styleT = gui.Checkbox(wnd_editor, "styleT", "Style T", current_style_t)
local color = gui.Slider(wnd_editor, "color", "Color", current_color, 0, 4)
local size = gui.Slider(wnd_editor, "size", "Size", current_size, 0, 50)
local thick = gui.Slider(wnd_editor, "thick", "Thickness", current_thickness, 0.5, 50, 0.5)
local gap = gui.Slider(wnd_editor, "gap", "Gap", current_gap, -50, 50)
local gapF = gui.Slider(wnd_editor, "gapF", "Fixed Gap (only for crosshair style 1)", current_fixedgap, 0, 100)
local alpha = gui.Checkbox(wnd_editor, "alpha", "Alpha", current_aplha)
local alphaV = gui.Slider(wnd_editor, "alphaV", "Alpha Value", current_alphaV, 0, 255)
local dot = gui.Checkbox(wnd_editor, "dot", "Dot", current_dot)
local outline = gui.Checkbox(wnd_editor, "outline", "Outline", current_outline)
local outlineT = gui.Slider(wnd_editor, "outlineT", "Outline Thickness", current_outline_thickness, 0.5, 3, 0.5)  
 
local function OnDraw() 
client.SetConVar("cl_crosshairstyle", style:GetValue())
if styleT:GetValue() == true then
client.SetConVar("cl_crosshair_t", 1)
else
client.SetConVar("cl_crosshair_t", 0)
end
client.SetConVar("cl_crosshaircolor", color:GetValue())
client.SetConVar("cl_crosshairsize", size:GetValue())
client.SetConVar("cl_crosshairthickness", thick:GetValue())
client.SetConVar("cl_crosshairgap", gap:GetValue())
client.SetConVar("cl_fixedcrosshairgap", gapF:GetValue())
if alpha:GetValue() == true then
client.SetConVar("cl_crosshairusealpha", 1)
else
client.SetConVar("cl_crosshairusealpha", 0)
end
client.SetConVar("cl_crosshairalpha", alphaV:GetValue())
if dot:GetValue() == true then
client.SetConVar("cl_crosshairdot", 1)
else
client.SetConVar("cl_crosshairdot", 0)
end
if outline:GetValue() == true then
client.SetConVar("cl_crosshair_drawoutline", 1)
else
client.SetConVar("cl_crosshair_drawoutline", 0)
end
client.SetConVar("cl_crosshair_outlinethickness", outlineT:GetValue())
end
callbacks.Register("Draw", OnDraw)



