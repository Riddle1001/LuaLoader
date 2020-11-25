-- Scraped by chicken
-- Author: gooksmasher
-- Title [RELEASE] Ammo bar
-- Forum link https://aimware.net/forum/thread/128592

local max_ammos = { 7, 30, 20, 20, -1, -1, 30, 30, 10, 25, 20, -1, 35, 100, -1, 30, 30, -1, 50, -1, -1, -1, 
30, 25, 7, 64, 5, 150, 7, 18, 1, 13, 30, 30, 8, 13, -1, 20, 30, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
-1, 25, 12, 12, 8}

local function Ammobar(E)
    local team_weapon = gui.GetValue("esp.overlay.friendly.weapon" );
    local enemy_weapon = gui.GetValue("esp.overlay.enemy.weapon" );
    local current_entity = E:GetEntity();
    local local_player = entities.GetLocalPlayer();
    if current_entity:IsPlayer() then
        if current_entity:GetTeamNumber() == local_player:GetTeamNumber() and team_weapon == 0 then
            return
        end

        if current_entity:GetTeamNumber() ~= local_player:GetTeamNumber() and enemy_weapon == 0 then
            return
        end

        local weapon = current_entity:GetPropEntity("m_hActiveWeapon");
        if weapon == nil then
            return
        end
        if weapon:GetWeaponID() > 64 or max_ammos[weapon:GetWeaponID()] == -1 then
            return
        end

        local percent = weapon:GetPropInt("m_iClip1") / max_ammos[weapon:GetWeaponID()];
            E:Color( 102, 173, 255, 200 );
            E:AddBarBottom( percent );
    end
end

callbacks.Register("DrawESP", "Ammobar", Ammobar);