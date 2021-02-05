-- Scraped by chicken
-- Author: gayware
-- Title [Release] Randomized slowwalk
-- Forum link https://aimware.net/forum/thread/102691

-- made by prost
miscRef = gui.Reference("MISC", "AUTOMATION", "Movement");
min = gui.Slider(miscRef, "Min", "Min", 0, 0, 100);
max = gui.Slider(miscRef, "Max", "Max", 0, 0, 100);


function randomSlowwalk()
local entity = entities.GetLocalPlayer();

if entity ~= nil then
  local alive = entity:IsAlive();
  local health = entity:GetHealth();
  local minSpeed = math.floor(min:GetValue());
  local maxSpeed = math.floor(max:GetValue());

  if (alive == true and health > 0 and minSpeed < maxSpeed) then
   gui.SetValue("msc_slowwalkspeed", (math.random(minSpeed, maxSpeed)/100), 1);

 elseif(minSpeed > maxSpeed) then
  gui.SetValue("Min", maxSpeed-1, 1);
  end
end
end
callbacks.Register('Draw', 'randomSlowwalk', randomSlowwalk)




