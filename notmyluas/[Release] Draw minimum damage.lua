-- Scraped by chicken
-- Author: gayware
-- Title [Release] Draw minimum damage
-- Forum link https://aimware.net/forum/thread/97552

-- made by prost
function draw_mindmg()
local font = draw.CreateFont("Arial", 18);
draw.SetFont(font);
local x,y = draw.GetScreenSize();
local entity = entities.GetLocalPlayer();
if entity ~= nil then
  local alive = entity:IsAlive();
  local health = entity:GetHealth();

  if (alive == true and health > 0) then
  local gun = entity:GetWeaponID();
  local gun_type = entity:GetWeaponType();
  draw.Color(0, 255, 255);

   --if (gui.GetValue("rbot_shared_mode") > 0) then
   --local shared_min_dmg = gui.GetValue("rbot_shared_mindamage");
   --draw.Text(20, ((y/2)-(y/10)+80), "Shared: " .. math.floor(shared_min_dmg));
   --draw.TextShadow(20, ((y/2)-(y/10)+80), "Shared: " .. math.floor(shared_min_dmg));


   if(gui.GetValue("rbot_shared_hitbox_arms_ps") * 100 > 1) then --set arms scale in your shared config to something above 5 for it to detect it

   local shared_min_dmg = gui.GetValue("rbot_shared_mindamage");
   draw.Text(20, ((y/2)-(y/10)+80), "Shared: " .. math.floor(shared_min_dmg));
   draw.TextShadow(20, ((y/2)-(y/10)+80), "Shared: " .. math.floor(shared_min_dmg));

   else

     if (gun_type == 1) then
      if(gun == 64) then
       local r8_min_dmg = gui.GetValue("rbot_revolver_mindamage");
       draw.Text(20, ((y/2)-(y/10)+80), "R8: " .. math.floor(r8_min_dmg));
       draw.TextShadow(20, ((y/2)-(y/10)+80), "R8: " .. math.floor(r8_min_dmg));
       else
       local pistol_min_dmg = gui.GetValue("rbot_pistol_mindamage");
       draw.Text(20, ((y/2)-(y/10)+80), "Pistol: " .. math.floor(pistol_min_dmg));
       draw.TextShadow(20, ((y/2)-(y/10)+80), "Pistol: " .. math.floor(pistol_min_dmg));
      end
     end

     if (gun_type == 2) then
       local smg_min_dmg = gui.GetValue("rbot_smg_mindamage");
       draw.Text(20, ((y/2)-(y/10)+80), "SMG: " .. math.floor(smg_min_dmg));
       draw.TextShadow(20, ((y/2)-(y/10)+80), "SMG: " .. math.floor(smg_min_dmg));
     end

     if (gun_type == 3) then
       local rifle_min_dmg = gui.GetValue("rbot_rifle_mindamage");
       draw.Text(20, ((y/2)-(y/10)+80), "Rifle: " .. math.floor(rifle_min_dmg));
       draw.TextShadow(20, ((y/2)-(y/10)+80), "Rifle: " .. math.floor(rifle_min_dmg));
     end

     if (gun_type == 4) then
       local shotgun_min_dmg = gui.GetValue("rbot_shotgun_mindamage");
       draw.Text(20, ((y/2)-(y/10)+80), "Shotgun: " .. math.floor(shotgun_min_dmg));
       draw.TextShadow(20, ((y/2)-(y/10)+80), "Shotgun: " .. math.floor(shotgun_min_dmg));
     end

     if (gun_type == 5) then
      if(gun == 9) then
       local awp_min_dmg = gui.GetValue("rbot_sniper_mindamage");
       draw.Text(20, ((y/2)-(y/10)+80), "AWP: " .. math.floor(awp_min_dmg));
       draw.TextShadow(20, ((y/2)-(y/10)+80), "AWP: " .. math.floor(awp_min_dmg));
       elseif (gun == 11 or gun == 38) then
        local autosniper_min_dmg = gui.GetValue("rbot_autosniper_mindamage");
        draw.Text(20, ((y/2)-(y/10)+80), "Auto: " .. math.floor(autosniper_min_dmg));
        draw.TextShadow(20, ((y/2)-(y/10)+80), "Auto: " .. math.floor(autosniper_min_dmg));
       elseif (gun == 40) then
        local scout_min_dmg = gui.GetValue("rbot_scout_mindamage");
        draw.Text(20, ((y/2)-(y/10)+80), "Scout: " .. math.floor(scout_min_dmg));
        draw.TextShadow(20, ((y/2)-(y/10)+80), "Scout: " .. math.floor(scout_min_dmg));
      end
     end

     if (gun_type == 6) then
       local lmg_min_dmg = gui.GetValue("rbot_lmg_mindamage");
       draw.Text(20, ((y/2)-(y/10)+80), "LMG: " .. math.floor(lmg_min_dmg));
       draw.TextShadow(20, ((y/2)-(y/10)+80), "LMG: " .. math.floor(lmg_min_dmg));
     end
    end

    -- draw.Text(20, ((y/2)-(y/10)+40), "Weapon ID: " .. math.floor(gun));
    -- draw.Text(20, ((y/2)-(y/10)+60), "Weapon Type: " .. math.floor(gun_type));
    -- made by prost
  end
end
end
callbacks.Register('Draw', 'draw_mindmg', draw_mindmg)




