-- Scraped by chicken
-- Author: Mitch97
-- Title [Release] Draw Hitbox Hit
-- Forum link https://aimware.net/forum/thread/97236

local UI_REF = gui.Reference( "VISUALS", "ENEMIES", "Options" );

local DrawHitboxHitText = gui.Text( UI_REF, "Draw Hitbox Hit");
local DrawHitboxHit = gui.Checkbox( UI_REF, "lua_drawhitboxhit", "Draw", 0 );
local HitboxDrawTime = gui.Slider( UI_REF, "lua_drawhitboxhit_time", "Draw Time in Seconds", 2, 1, 10 );
local HitboxDrawSize= gui.Slider( UI_REF, "lua_drawhitboxhit_size", "Draw Size", 6, 1, 25 ); 

local text_font = draw.CreateFont("Verdana", 12, 400);

local hitboxes = {};
local hitbox_text = {};
local ticks = {};

local function HitGroup( INT_HITGROUP )
  if INT_HITGROUP == 0 then
    return "body";
  elseif INT_HITGROUP == 1 then
    return "head";
  elseif INT_HITGROUP == 2 then
    return "chest";
  elseif INT_HITGROUP == 3 then
    return "stomach";
  elseif INT_HITGROUP == 4 then 
    return "left arm";
  elseif INT_HITGROUP == 5 then 
    return "right arm";
  elseif INT_HITGROUP == 6 then 
    return "left leg";
  elseif INT_HITGROUP == 7 then 
    return "right leg";
  elseif INT_HITGROUP == 8 then 
     return "hitbox 8";
  elseif INT_HITGROUP == 9 then 
   return "hitbox 9";
  elseif INT_HITGROUP == 10 then 
    return "body";
  end
end

local function on_player_death(e)
  if (e:GetName() == "player_hurt" and DrawHitboxHit:GetValue()) then
   local ENTITY_LOCAL_PLAYER = client.GetLocalPlayerIndex();
  
   local ID_VICTIM, ID_ATTACKER, HITGROUP, BONE = e:GetInt("userid"), e:GetInt("attacker"), e:GetInt("hitgroup"), e:GetInt("boneIndex");
   local INDEX_VICTIM, INDEX_ATTACKER = client.GetPlayerIndexByUserID(ID_VICTIM), client.GetPlayerIndexByUserID(ID_ATTACKER);
  
   if (INDEX_ATTACKER == ENTITY_LOCAL_PLAYER and INDEX_VICTIM ~= ENTITY_LOCAL_PLAYER) then

     local ENEMY = entities.GetByUserID(ID_VICTIM);
     local HITBOX_POS = {ENEMY:GetHitboxPosition(HITGROUP)};
     local HIT_TEXT = HitGroup(HITGROUP);

     if(HITBOX_POS ~= nil) then
      table.insert(hitboxes, HITBOX_POS);
      table.insert(hitbox_text, HIT_TEXT);
      table.insert(ticks, common.Time());
     end
   end
  end
end

local function render_hitpos()
  local player = entities.GetLocalPlayer();

  if DrawHitboxHit:GetValue() and player ~= nil and player:IsAlive() then
   for index = 1, #hitboxes do
     if (hitboxes[index] ~= nil and
      ticks[index] ~= nil) then

      local HITBOX = hitboxes[index];
      local screen_x, screen_y = client.WorldToScreen(HITBOX[1], HITBOX[2], HITBOX[3]);

      if(screen_x ~= nil and screen_y ~= nil) then
        local drawSize = HitboxDrawSize:GetValue() / 2;
        draw.Color(255, 0, 0, 255);
        draw.FilledRect(screen_x - drawSize, screen_y - drawSize, screen_x + drawSize, screen_y + drawSize);
        draw.Color(0, 0, 0, 255);
        draw.OutlinedRect(screen_x - drawSize, screen_y - drawSize, screen_x + drawSize, screen_y + drawSize);
        draw.Color(255, 255, 255, 255);
        draw.SetFont(text_font);
        local text_size_x, text_size_y = draw.GetTextSize(hitbox_text[index]);
        draw.Text(screen_x - text_size_x/2, screen_y + drawSize*0.8, hitbox_text[index] );
        draw.TextShadow(screen_x - text_size_x/2, screen_y + drawSize*0.8, hitbox_text[index] );



        local tick_difference = common.Time() - ticks[index];

        if (tick_difference > HitboxDrawTime:GetValue()) then
         table.remove(hitboxes, index);
         table.remove(hitbox_text, index);
         table.remove(ticks, index);
        end
      else
        table.remove(hitboxes, index);
        table.remove(hitbox_text, index);
        table.remove(ticks, index);
      end
     end
   end
  end
end

callbacks.Register( "Draw", "render_hitpos", render_hitpos);

client.AllowListener("player_hurt");
callbacks.Register("FireGameEvent", "HS_SOUND", on_player_death);


