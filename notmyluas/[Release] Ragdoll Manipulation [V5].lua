-- Scraped by chicken
-- Author: Mad?
-- Title [Release] Ragdoll Manipulation [V5]
-- Forum link https://aimware.net/forum/thread/128811

--Ragdoll Manipulation by Cheeseot
 -- Fixed for v5 by Mad?
local ragdollref = gui.Reference("MISC")
local ragdolltab = gui.Tab(ragdollref, "ragdoll.tab", "Ragdolls")

-- group box
local ragdollbox = gui.Groupbox(ragdolltab, "Ragdoll Manipulation", 15,15,600,500)
enable = gui.Checkbox(ragdollbox, "ragdollmanipEnable", "Enable", false)
gui.Text(ragdollbox, "Push Scale")
pushslider = gui.Slider(ragdollbox, "lua_pushscale", "Base value", 1, 0, 10)
pushmult = gui.Checkbox(ragdollbox, "lua_pushmult", "10x multiplier", 0)
pushneg = gui.Checkbox(ragdollbox, "lua_pushneg", "Negative", 0)
gui.Text(ragdollbox, "Headshot Scale")
hsslider = gui.Slider(ragdollbox, "lua_hsscale", "Base value", 1.3, 0, 10)
hsmult = gui.Checkbox(ragdollbox, "lua_hsmult", "10x multiplier", 0)
hsneg = gui.Checkbox(ragdollbox, "lua_hsneg", "Negative", 0)
gui.Text(ragdollbox, "Gravity")
gravslider = gui.Slider(ragdollbox, "lua_grav", "Base value", 600, 0, 1000)
gravmult = gui.Checkbox(ragdollbox, "lua_gravmult", "10x multiplier", 0)
gravneg = gui.Checkbox(ragdollbox, "lua_gravneg", "Negative", 0)
gui.Text(ragdollbox, "Info")
pushtext = gui.Text(ragdollbox,"Push scale: ERR")
hstext = gui.Text(ragdollbox,"Headshot scale: ERR")
gravtext = gui.Text(ragdollbox,"Gravity: ERR")
resetcheck = gui.Checkbox(ragdollbox, "lua_resetbutton", "Reset to default", 0)

local pushfinal = 0
local hsfinal = 0
local gravfinal = 0
local pushchange = 0
local hschange = 0
local gravchange = 0

--Ragdoll Manipulation by Cheeseot -- Fixed for v5 by Mad?

function ragdollmeme()

pushfinal = pushslider:GetValue();
pushfinal = round(pushfinal, 1);

  if pushmult:GetValue() then
    pushfinal = pushfinal * 10;
  end

  if pushneg:GetValue() then
    pushfinal = pushfinal * -1;
  end

  if pushfinal == -0.0 then pushfinal = 0.0 end

hsfinal = hsslider:GetValue();
hsfinal = round(hsfinal, 1);

  if hsmult:GetValue() then
    hsfinal = hsfinal * 10;
  end

  if hsneg:GetValue() then
    hsfinal = hsfinal * -1;
  end

  if hsfinal == -0.0 then hsfinal = 0.0 end

gravfinal = gravslider:GetValue();
gravfinal = round(gravfinal, 1);

  if gravmult:GetValue() then
    gravfinal = gravfinal * 10;
  end

  if gravneg:GetValue() then
    gravfinal = gravfinal * -1;
  end

  if gravfinal == -0.0 then gravfinal = 0.0 end

  if resetcheck:GetValue() then
    pushslider:SetValue(1);
    pushmult:SetValue(0);
    pushneg:SetValue(0);
    hsslider:SetValue(1.3);
    hsmult:SetValue(0);
    hsneg:SetValue(0);
    gravslider:SetValue(600);
    gravmult:SetValue(0);
    gravneg:SetValue(0);
    resetcheck:SetValue(0);
  end

if gui.GetValue("misc.ragdoll.tab.ragdollmanipEnable") then
--print("workin")
if pushchange ~= pushfinal then
  client.SetConVar("phys_pushscale", pushfinal, true );
  pushchange = pushfinal;
end

if hschange ~= hsfinal then
  client.SetConVar("phys_headshotscale", hsfinal, true );
  hschange = hsfinal;
end

if gravchange ~= gravfinal then
  client.Command("cl_ragdoll_gravity "..tostring(gravslider:GetValue()) )
;
  gravchange = gravfinal;
end
else
 --print("stopped")
 client.Command("cl_ragdoll_gravity ".."600" );
 client.SetConVar("phys_headshotscale", 1, true );
 client.SetConVar("phys_pushscale", 1, true );
end

local pushtextmeme = "Push scale: " .. pushfinal;
pushtext:SetText(pushtextmeme);
local hstextmeme = "Headshot scale: " .. hsfinal;
hstext:SetText(hstextmeme);
local gravtextmeme = "Gravity: " .. gravfinal;
gravtext:SetText(gravtextmeme);
end

function round(num, numDecimalPlaces)
 local mult = 10^(numDecimalPlaces or 0)
 return math.floor(num * mult + 0.5) / mult
end

callbacks.Register("Draw","ragdollmeme",ragdollmeme)
--Ragdoll Manipulation by Cheeseot



