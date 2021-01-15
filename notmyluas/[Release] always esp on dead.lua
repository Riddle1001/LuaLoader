-- Scraped by chicken
-- Author: zack
-- Title [Release] always esp on dead
-- Forum link https://aimware.net/forum/thread/86414


function ESP_Always_OnDead( ) 
local local_player = entities.GetLocalPlayer();
if local_player == NULL or local_player == nil then return;
elseif local_player:IsAlive() == true then
  gui.SetValue("esp_visibility_enemy", 1)
  gui.SetValue("esp_enemy_box", 0)
  gui.SetValue("esp_enemy_weapon", 0)
  gui.SetValue("esp_enemy_health", 0)
  gui.SetValue("esp_enemy_glow", 0)
  gui.SetValue("esp_enemy_skeleton", false)
  gui.SetValue("esp_enemy_name", false)
elseif local_player:IsAlive() == false then  
  draw.Text(930,160, "DEAD")
  gui.SetValue("esp_visibility_enemy", 0)
  gui.SetValue("esp_enemy_box", 3)
  gui.SetValue("esp_enemy_weapon", 1)
  gui.SetValue("esp_enemy_health", 2)
  gui.SetValue("esp_enemy_glow", 2)
  gui.SetValue("esp_enemy_skeleton", true)
  gui.SetValue("esp_enemy_name", true)
  end end
callbacks.Register("Draw", "ondead", ESP_Always_OnDead);