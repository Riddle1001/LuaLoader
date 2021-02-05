-- Scraped by chicken
-- Author: Enclusion
-- Title [Release] Baim Key + Customization
-- Forum link https://aimware.net/forum/thread/89662

-- Check if SenseUI was loaded.
if SenseUI == nil then
	RunScript( "senseui.lua" );
end

local window_moveable = true;
local show_gradient = false;
local button_toggler = false;
local ui_rate = 10;
local slider_showpm = true;
local funny_sliders = 0;
local draw_texture = false;
local bind_button = SenseUI.Keys.home;
local bind_active = false;
local bind_detect = SenseUI.KeyDetection.on_hotkey;

local window_bkey = ******;
local window_bact = false;
local window_bdet = SenseUI.KeyDetection.on_hotkey;

local ex_combo = 1;
local ex_mcombo = {};


-- new stuff --
local gui_set = gui.SetValue
local gui_get = gui.GetValue

local bodyaimToggle = false;
local bodyaimKey = SenseUI.Keys.nine;
local bodyaimDetect = SenseUI.KeyDetection.on_hotkey;

local bodyaimHitboxes = {};
local bodyaimWeapons = {};
local bodyaimPriority = 2;

-- store old values -- 
-- shared hitbox settings --
local hBox_shared_priority = gui_get("rbot_shared_hitbox")
local hBox_shared_head = gui_get("rbot_shared_hitbox_head")
local hBox_shared_neck = gui_get("rbot_shared_hitbox_neck")
local hBox_shared_chest = gui_get("rbot_shared_hitbox_chest")
local hBox_shared_stomach = gui_get("rbot_shared_hitbox_stomach")
local hBox_shared_pelvis = gui_get("rbot_shared_hitbox_pelvis")
local hBox_shared_arms = gui_get("rbot_shared_hitbox_arms")
local hBox_shared_legs = gui_get("rbot_shared_hitbox_legs")
local hBox_shared_walking = gui_get("rbot_shared_headifwalking")
local hBox_shared_adaptive = gui_get("rbot_shared_hitbox_adaptive")

-- pistol hitbox settings -- 
local hBox_pistol_priority = gui_get("rbot_pistol_hitbox")
local hBox_pistol_head = gui_get("rbot_pistol_hitbox_head")
local hBox_pistol_neck = gui_get("rbot_pistol_hitbox_neck")
local hBox_pistol_chest = gui_get("rbot_pistol_hitbox_chest")
local hBox_pistol_stomach = gui_get("rbot_pistol_hitbox_stomach")
local hBox_pistol_pelvis = gui_get("rbot_pistol_hitbox_pelvis")
local hBox_pistol_arms = gui_get("rbot_pistol_hitbox_arms")
local hBox_pistol_legs = gui_get("rbot_pistol_hitbox_legs")
local hBox_pistol_walking = gui_get("rbot_pistol_headifwalking")
local hBox_shared_adaptive = gui_get("rbot_pistol_hitbox_adaptive")

-- revolver hitbox settings --
local hBox_revolver_priority = gui_get("rbot_revolver_hitbox")
local hBox_revolver_head = gui_get("rbot_revolver_hitbox_head")
local hBox_revolver_neck = gui_get("rbot_revolver_hitbox_neck")
local hBox_revolver_chest = gui_get("rbot_revolver_hitbox_chest")
local hBox_revolver_stomach = gui_get("rbot_revolver_hitbox_stomach")
local hBox_revolver_pelvis = gui_get("rbot_revolver_hitbox_pelvis")
local hBox_revolver_arms = gui_get("rbot_revolver_hitbox_arms")
local hBox_revolver_legs = gui_get("rbot_revolver_hitbox_legs")
local hBox_revolver_walking = gui_get("rbot_revolver_headifwalking")
local hBox_revolver_adaptive = gui_get("rbot_revolver_hitbox_adaptive")

-- smg hitbox settings --
local hBox_smg_priority = gui_get("rbot_smg_hitbox")
local hBox_smg_head = gui_get("rbot_smg_hitbox_head")
local hBox_smg_neck = gui_get("rbot_smg_hitbox_neck")
local hBox_smg_chest = gui_get("rbot_smg_hitbox_chest")
local hBox_smg_stomach = gui_get("rbot_smg_hitbox_stomach")
local hBox_smg_pelvis = gui_get("rbot_smg_hitbox_pelvis")
local hBox_smg_arms = gui_get("rbot_smg_hitbox_arms")
local hBox_smg_legs = gui_get("rbot_smg_hitbox_legs")
local hBox_smg_walking = gui_get("rbot_smg_headifwalking")
local hBox_smg_adaptive = gui_get("rbot_smg_hitbox_adaptive")

-- rifle hitbox settings --
local hBox_rifle_priority = gui_get("rbot_rifle_hitbox")
local hBox_rifle_head = gui_get("rbot_rifle_hitbox_head")
local hBox_rifle_neck = gui_get("rbot_rifle_hitbox_neck")
local hBox_rifle_chest = gui_get("rbot_rifle_hitbox_chest")
local hBox_rifle_stomach = gui_get("rbot_rifle_hitbox_stomach")
local hBox_rifle_pelvis = gui_get("rbot_rifle_hitbox_pelvis")
local hBox_rifle_arms = gui_get("rbot_rifle_hitbox_arms")
local hBox_rifle_legs = gui_get("rbot_rifle_hitbox_legs")
local hBox_rifle_walking = gui_get("rbot_rifle_headifwalking")
local hBox_rifle_adaptive = gui_get("rbot_rifle_hitbox_adaptive")

-- shotgun hitbox settings --
local hBox_shotgun_priority = gui_get("rbot_shotgun_hitbox")
local hBox_shotgun_head = gui_get("rbot_shotgun_hitbox_head")
local hBox_shotgun_neck = gui_get("rbot_shotgun_hitbox_neck")
local hBox_shotgun_chest = gui_get("rbot_shotgun_hitbox_chest")
local hBox_shotgun_stomach = gui_get("rbot_shotgun_hitbox_stomach")
local hBox_shotgun_pelvis = gui_get("rbot_shotgun_hitbox_pelvis")
local hBox_shotgun_arms = gui_get("rbot_shotgun_hitbox_arms")
local hBox_shotgun_legs = gui_get("rbot_shotgun_hitbox_legs")
local hBox_shotgun_walking = gui_get("rbot_shotgun_headifwalking")
local hBox_shotgun_adaptive = gui_get("rbot_shotgun_hitbox_adaptive")

-- scout hitbox settings --
local hBox_scout_priority = gui_get("rbot_scout_hitbox")
local hBox_scout_head = gui_get("rbot_scout_hitbox_head")
local hBox_scout_neck = gui_get("rbot_scout_hitbox_neck")
local hBox_scout_chest = gui_get("rbot_scout_hitbox_chest")
local hBox_scout_stomach = gui_get("rbot_scout_hitbox_stomach")
local hBox_scout_pelvis = gui_get("rbot_scout_hitbox_pelvis")
local hBox_scout_arms = gui_get("rbot_scout_hitbox_arms")
local hBox_scout_legs = gui_get("rbot_scout_hitbox_legs")
local hBox_scout_walking = gui_get("rbot_scout_headifwalking")
local hBox_scout_adaptive = gui_get("rbot_scout_hitbox_adaptive")

-- auto hitbox settings --
local hBox_auto_priority = gui_get("rbot_autosniper_hitbox")
local hBox_auto_head = gui_get("rbot_autosniper_hitbox_head")
local hBox_auto_neck = gui_get("rbot_autosniper_hitbox_neck")
local hBox_auto_chest = gui_get("rbot_autosniper_hitbox_chest")
local hBox_auto_stomach = gui_get("rbot_autosniper_hitbox_stomach")
local hBox_auto_pelvis = gui_get("rbot_autosniper_hitbox_pelvis")
local hBox_auto_arms = gui_get("rbot_autosniper_hitbox_arms")
local hBox_auto_legs = gui_get("rbot_autosniper_hitbox_legs")
local hBox_auto_walking = gui_get("rbot_autosniper_headifwalking")
local hBox_auto_adaptive = gui_get("rbot_autosniper_hitbox_adaptive")

-- awp hitbox settings --
local hBox_awp_priority = gui_get("rbot_sniper_hitbox")
local hBox_awp_head = gui_get("rbot_sniper_hitbox_head")
local hBox_awp_neck = gui_get("rbot_sniper_hitbox_neck")
local hBox_awp_chest = gui_get("rbot_sniper_hitbox_chest")
local hBox_awp_stomach = gui_get("rbot_sniper_hitbox_stomach")
local hBox_awp_pelvis = gui_get("rbot_sniper_hitbox_pelvis")
local hBox_awp_arms = gui_get("rbot_sniper_hitbox_arms")
local hBox_awp_legs = gui_get("rbot_sniper_hitbox_legs")
local hBox_awp_walking = gui_get("rbot_sniper_headifwalking")
local hBox_awp_adaptive = gui_get("rbot_sniper_hitbox_adaptive")

-- lmg hitbox settings --
local hBox_lmg_priority = gui_get("rbot_lmg_hitbox")
local hBox_lmg_head = gui_get("rbot_lmg_hitbox_head")
local hBox_lmg_neck = gui_get("rbot_lmg_hitbox_neck")
local hBox_lmg_chest = gui_get("rbot_lmg_hitbox_chest")
local hBox_lmg_stomach = gui_get("rbot_lmg_hitbox_stomach")
local hBox_lmg_pelvis = gui_get("rbot_lmg_hitbox_pelvis")
local hBox_lmg_arms = gui_get("rbot_lmg_hitbox_arms")
local hBox_lmg_legs = gui_get("rbot_lmg_hitbox_legs")
local hBox_lmg_walking = gui_get("rbot_lmg_headifwalking")
local hBox_lmg_adaptive = gui_get("rbot_lmg_hitbox_adaptive")

SenseUI.EnableLogs = true;

function draw_callback()
	if SenseUI.BeginWindow( "wnd1", 50, 50, 565, 400) then
		SenseUI.DrawTabBar();

		if show_gradient then
			SenseUI.AddGradient();
		end

		SenseUI.SetWindowDrawTexture( draw_texture ); -- Makes huge fps drop. Not recommended to use yet
		SenseUI.SetWindowMoveable( window_moveable );
		SenseUI.SetWindowOpenKey( window_bkey );

		if SenseUI.BeginTab( "RageTab", SenseUI.Icons.rage ) then
		
			if SenseUI.BeginGroup( "BodyAimSettings", "Body Aim", 25, 25, 205, 215 ) then
			
				bodyaimToggle = SenseUI.Checkbox( "Enabled", bodyaimToggle );
				SenseUI.Label( "Body Aim Key:");
				bodyaimKey, bodyaimToggle, bodyaimDetect = SenseUI.Bind( "Body Aim key", true, bodyaimKey, bodyaimToggle, bodyaimDetect );
				bodyaimWeapons = SenseUI.MultiCombo( "Weapons", { "All", "Shared", "Pistol", "Revolver", "SMG", "Rifle", "Shotgun", "Scout", "Auto", "AWP", "LMG" }, bodyaimWeapons );
				bodyaimHitboxes = SenseUI.MultiCombo( "Hitboxes", { "Chest", "Stomach", "Pelvis" }, bodyaimHitboxes );
				SenseUI.Label( "Hitbox Priority");
				bodyaimPriority = SenseUI.Combo( "HitboxPriority", { "Chest", "Stomach", "Pelvis", "Center" }, bodyaimPriority );
				
				if bodyaimToggle then
					
					-- shared hitbox settings
					if bodyaimWeapons["All"] or bodyaimWeapons["Shared"] then
						gui_set("rbot_shared_hitbox", bodyaimPriority + 1)
						gui_set("rbot_shared_hitbox_head", 0)
						gui_set("rbot_shared_hitbox_neck", 0)
						if bodyaimHitboxes["Chest"] then
							gui_set("rbot_shared_hitbox_chest", 1)
						else
							gui_set("rbot_shared_hitbox_chest", 0)
						end
						
						if bodyaimHitboxes["Stomach"] then
							gui_set("rbot_shared_hitbox_stomach", 1)
						else
							gui_set("rbot_shared_hitbox_stomach", 0)
						end
						if bodyaimHitboxes["Pelvis"] then
							gui_set("rbot_shared_hitbox_pelvis", 1)
						else
							gui_set("rbot_shared_hitbox_pelvis", 0)
						end
						gui_set("rbot_shared_hitbox_arms", 0)
						gui_set("rbot_shared_hitbox_legs", 0)
						gui_set("rbot_shared_headifwalking", 0)
						gui_set("rbot_shared_hitbox_adaptive", 0)
					end
					
					-- pistol hitbox settings --
					if bodyaimWeapons["All"] or bodyaimWeapons["Pistol"] then
						gui_set("rbot_pistol_hitbox", bodyaimPriority + 1)
						gui_set("rbot_pistol_hitbox_head", 0)
						gui_set("rbot_pistol_hitbox_neck", 0)
						if bodyaimHitboxes["Chest"] then
							gui_set("rbot_pistol_hitbox_chest", 1)
						else
							gui_set("rbot_pistol_hitbox_chest", 0)
						end
						
						if bodyaimHitboxes["Stomach"] then
							gui_set("rbot_pistol_hitbox_stomach", 1)
						else
							gui_set("rbot_pistol_hitbox_stomach", 0)
						end
						if bodyaimHitboxes["Pelvis"] then
							gui_set("rbot_pistol_hitbox_pelvis", 1)
						else
							gui_set("rbot_pistol_hitbox_pelvis", 0)
						end
						gui_set("rbot_pistol_hitbox_arms", 0)
						gui_set("rbot_pistol_hitbox_legs", 0)
						gui_set("rbot_pistol_headifwalking", 0)
						gui_set("rbot_pistol_hitbox_adaptive", 0)
					end
					
					-- revolver hitbox settings --
					if bodyaimWeapons["All"] or bodyaimWeapons["Revolver"] then
						gui_set("rbot_revolver_hitbox", bodyaimPriority + 1)
						gui_set("rbot_revolver_hitbox_head", 0)
						gui_set("rbot_revolver_hitbox_neck", 0)
						if bodyaimHitboxes["Chest"] then
							gui_set("rbot_revolver_hitbox_chest", 1)
						else
							gui_set("rbot_revolver_hitbox_chest", 0)
						end
						
						if bodyaimHitboxes["Stomach"] then
							gui_set("rbot_revolver_hitbox_stomach", 1)
						else
							gui_set("rbot_revolver_hitbox_stomach", 0)
						end
						if bodyaimHitboxes["Pelvis"] then
							gui_set("rbot_revolver_hitbox_pelvis", 1)
						else
							gui_set("rbot_revolver_hitbox_pelvis", 0)
						end
						gui_set("rbot_revolver_hitbox_arms", 0)
						gui_set("rbot_revolver_hitbox_legs", 0)
						gui_set("rbot_revolver_headifwalking", 0)
						gui_set("rbot_revolver_hitbox_adaptive", 0)
					end
					
					-- smg hitbox settings --
					if bodyaimWeapons["All"] or bodyaimWeapons["SMG"] then
						gui_set("rbot_smg_hitbox", bodyaimPriority + 1)
						gui_set("rbot_smg_hitbox_head", 0)
						gui_set("rbot_smg_hitbox_neck", 0)
						if bodyaimHitboxes["Chest"] then
							gui_set("rbot_smg_hitbox_chest", 1)
						else
							gui_set("rbot_smg_hitbox_chest", 0)
						end
						
						if bodyaimHitboxes["Stomach"] then
							gui_set("rbot_smg_hitbox_stomach", 1)
						else
							gui_set("rbot_smg_hitbox_stomach", 0)
						end
						if bodyaimHitboxes["Pelvis"] then
							gui_set("rbot_smg_hitbox_pelvis", 1)
						else
							gui_set("rbot_smg_hitbox_pelvis", 0)
						end
						gui_set("rbot_smg_hitbox_arms", 0)
						gui_set("rbot_smg_hitbox_legs", 0)
						gui_set("rbot_smg_headifwalking", 0)
						gui_set("rbot_smg_hitbox_adaptive", 0)
					end
					
					-- rifle hitbox settings --
					if bodyaimWeapons["All"] or bodyaimWeapons["Rifle"] then
						gui_set("rbot_rifle_hitbox", bodyaimPriority + 1)
						gui_set("rbot_rifle_hitbox_head", 0)
						gui_set("rbot_rifle_hitbox_neck", 0)
						if bodyaimHitboxes["Chest"] then
							gui_set("rbot_rifle_hitbox_chest", 1)
						else
							gui_set("rbot_rifle_hitbox_chest", 0)
						end
						
						if bodyaimHitboxes["Stomach"] then
							gui_set("rbot_rifle_hitbox_stomach", 1)
						else
							gui_set("rbot_rifle_hitbox_stomach", 0)
						end
						if bodyaimHitboxes["Pelvis"] then
							gui_set("rbot_rifle_hitbox_pelvis", 1)
						else
							gui_set("rbot_rifle_hitbox_pelvis", 0)
						end
						gui_set("rbot_rifle_hitbox_arms", 0)
						gui_set("rbot_rifle_hitbox_legs", 0)
						gui_set("rbot_rifle_headifwalking", 0)
						gui_set("rbot_rifle_hitbox_adaptive", 0)
					end
					
					-- shotgun hitbox settings --
					if bodyaimWeapons["All"] or bodyaimWeapons["Shotgun"] then
						gui_set("rbot_shotgun_hitbox", bodyaimPriority + 1)
						gui_set("rbot_shotgun_hitbox_head", 0)
						gui_set("rbot_shotgun_hitbox_neck", 0)
						if bodyaimHitboxes["Chest"] then
							gui_set("rbot_shotgun_hitbox_chest", 1)
						else
							gui_set("rbot_shotgun_hitbox_chest", 0)
						end
						
						if bodyaimHitboxes["Stomach"] then
							gui_set("rbot_shotgun_hitbox_stomach", 1)
						else
							gui_set("rbot_shotgun_hitbox_stomach", 0)
						end
						if bodyaimHitboxes["Pelvis"] then
							gui_set("rbot_shotgun_hitbox_pelvis", 1)
						else
							gui_set("rbot_shotgun_hitbox_pelvis", 0)
						end
						gui_set("rbot_shotgun_hitbox_arms", 0)
						gui_set("rbot_shotgun_hitbox_legs", 0)
						gui_set("rbot_shotgun_headifwalking", 0)
						gui_set("rbot_shotgun_hitbox_adaptive", 0)
					end
					
					-- auto hitbox settings --
					if bodyaimWeapons["All"] or bodyaimWeapons["Auto"] then
						gui_set("rbot_autosniper_hitbox", bodyaimPriority + 1)
						gui_set("rbot_autosniper_hitbox_head", 0)
						gui_set("rbot_autosniper_hitbox_neck", 0)
						if bodyaimHitboxes["Chest"] then
							gui_set("rbot_autosniper_hitbox_chest", 1)
						else
							gui_set("rbot_autosniper_hitbox_chest", 0)
						end
						
						if bodyaimHitboxes["Stomach"] then
							gui_set("rbot_autosniper_hitbox_stomach", 1)
						else
							gui_set("rbot_autosniper_hitbox_stomach", 0)
						end
						if bodyaimHitboxes["Pelvis"] then
							gui_set("rbot_autosniper_hitbox_pelvis", 1)
						else
							gui_set("rbot_autosniper_hitbox_pelvis", 0)
						end
						gui_set("rbot_autosniper_hitbox_arms", 0)
						gui_set("rbot_autosniper_hitbox_legs", 0)
						gui_set("rbot_autosniper_headifwalking", 0)
						gui_set("rbot_autosniper_hitbox_adaptive", 0)
					end
					
					-- scout hitbox settings --
					if bodyaimWeapons["All"] or bodyaimWeapons["Scout"] then
						gui_set("rbot_scout_hitbox", bodyaimPriority + 1)
						gui_set("rbot_scout_hitbox_head", 0)
						gui_set("rbot_scout_hitbox_neck", 0)
						if bodyaimHitboxes["Chest"] then
							gui_set("rbot_scout_hitbox_chest", 1)
						else
							gui_set("rbot_scout_hitbox_chest", 0)
						end
						
						if bodyaimHitboxes["Stomach"] then
							gui_set("rbot_scout_hitbox_stomach", 1)
						else
							gui_set("rbot_scout_hitbox_stomach", 0)
						end
						if bodyaimHitboxes["Pelvis"] then
							gui_set("rbot_scout_hitbox_pelvis", 1)
						else
							gui_set("rbot_scout_hitbox_pelvis", 0)
						end
						gui_set("rbot_scout_hitbox_arms", 0)
						gui_set("rbot_scout_hitbox_legs", 0)
						gui_set("rbot_scout_headifwalking", 0)
						gui_set("rbot_scout_hitbox_adaptive", 0)
					end
					
					-- sniper hitbox settings --
					if bodyaimWeapons["All"] or bodyaimWeapons["AWP"] then
						gui_set("rbot_sniper_hitbox", bodyaimPriority + 1)
						gui_set("rbot_sniper_hitbox_head", 0)
						gui_set("rbot_sniper_hitbox_neck", 0)
						if bodyaimHitboxes["Chest"] then
							gui_set("rbot_sniper_hitbox_chest", 1)
						else
							gui_set("rbot_sniper_hitbox_chest", 0)
						end
						
						if bodyaimHitboxes["Stomach"] then
							gui_set("rbot_sniper_hitbox_stomach", 1)
						else
							gui_set("rbot_sniper_hitbox_stomach", 0)
						end
						if bodyaimHitboxes["Pelvis"] then
							gui_set("rbot_sniper_hitbox_pelvis", 1)
						else
							gui_set("rbot_sniper_hitbox_pelvis", 0)
						end
						gui_set("rbot_sniper_hitbox_arms", 0)
						gui_set("rbot_sniper_hitbox_legs", 0)
						gui_set("rbot_sniper_headifwalking", 0)
						gui_set("rbot_sniper_hitbox_adaptive", 0)
					end
					
					-- lmg hitbox settings --
					if bodyaimWeapons["All"] or bodyaimWeapons["LMG"] then
						gui_set("rbot_lmg_hitbox", bodyaimPriority + 1)
						gui_set("rbot_lmg_hitbox_head", 0)
						gui_set("rbot_lmg_hitbox_neck", 0)
						if bodyaimHitboxes["Chest"] then
							gui_set("rbot_lmg_hitbox_chest", 1)
						else
							gui_set("rbot_lmg_hitbox_chest", 0)
						end
						
						if bodyaimHitboxes["Stomach"] then
							gui_set("rbot_lmg_hitbox_stomach", 1)
						else
							gui_set("rbot_lmg_hitbox_stomach", 0)
						end
						if bodyaimHitboxes["Pelvis"] then
							gui_set("rbot_lmg_hitbox_pelvis", 1)
						else
							gui_set("rbot_lmg_hitbox_pelvis", 0)
						end
						gui_set("rbot_lmg_hitbox_arms", 0)
						gui_set("rbot_lmg_hitbox_legs", 0)
						gui_set("rbot_lmg_headifwalking", 0)
						gui_set("rbot_lmg_hitbox_adaptive", 0)
					end
				else
					-- shared hitbox settings --
					gui_set("rbot_shared_hitbox", hBox_shared_priority)
					gui_set("rbot_shared_hitbox_head", hBox_shared_head)
					gui_set("rbot_shared_hitbox_neck", hBox_shared_neck)
					gui_set("rbot_shared_hitbox_chest", hBox_shared_chest)
					gui_set("rbot_shared_hitbox_stomach", hBox_shared_stomach)
					gui_set("rbot_shared_hitbox_pelvis", hBox_shared_pelvis)
					gui_set("rbot_shared_hitbox_arms", hBox_shared_arms)
					gui_set("rbot_shared_hitbox_legs", hBox_shared_legs)
					gui_set("rbot_shared_headifwalking", hBox_shared_walking)
					gui_set("rbot_shared_hitbox_adaptive", hBox_shared_adaptive)
					
					-- pistol hitbox settings --
					gui_set("rbot_pistol_hitbox", hBox_pistol_priority)
					gui_set("rbot_pistol_hitbox_head", hBox_pistol_head)
					gui_set("rbot_pistol_hitbox_neck", hBox_pistol_neck)
					gui_set("rbot_pistol_hitbox_chest", hBox_pistol_chest)
					gui_set("rbot_pistol_hitbox_stomach", hBox_pistol_stomach)
					gui_set("rbot_pistol_hitbox_pelvis", hBox_pistol_pelvis)
					gui_set("rbot_pistol_hitbox_arms", hBox_pistol_arms)
					gui_set("rbot_pistol_hitbox_legs", hBox_pistol_legs)
					gui_set("rbot_pistol_headifwalking", hBox_pistol_walking)
					gui_set("rbot_pistol_hitbox_adaptive", hBox_pistol_adaptive)
					
					-- revolver hitbox settings --
					gui_set("rbot_revolver_hitbox", hBox_revolver_priority)
					gui_set("rbot_revolver_hitbox_head", hBox_revolver_head)
					gui_set("rbot_revolver_hitbox_neck", hBox_revolver_neck)
					gui_set("rbot_revolver_hitbox_chest", hBox_revolver_chest)
					gui_set("rbot_revolver_hitbox_stomach", hBox_revolver_stomach)
					gui_set("rbot_revolver_hitbox_pelvis", hBox_revolver_pelvis)
					gui_set("rbot_revolver_hitbox_arms", hBox_revolver_arms)
					gui_set("rbot_revolver_hitbox_legs", hBox_revolver_legs)
					gui_set("rbot_revolver_headifwalking", hBox_revolver_walking)
					gui_set("rbot_revolver_hitbox_adaptive", hBox_revolver_adaptive)
					
					-- smg hitbox settings --
					gui_set("rbot_smg_hitbox", hBox_smg_priority)
					gui_set("rbot_smg_hitbox_head", hBox_smg_head)
					gui_set("rbot_smg_hitbox_neck", hBox_smg_neck)
					gui_set("rbot_smg_hitbox_chest", hBox_smg_chest)
					gui_set("rbot_smg_hitbox_stomach", hBox_smg_stomach)
					gui_set("rbot_smg_hitbox_pelvis", hBox_smg_pelvis)
					gui_set("rbot_smg_hitbox_arms", hBox_smg_arms)
					gui_set("rbot_smg_hitbox_legs", hBox_smg_legs)
					gui_set("rbot_smg_headifwalking", hBox_smg_walking)
					gui_set("rbot_smg_hitbox_adaptive", hBox_smg_adaptive)
					
					-- rifle hitbox settings --
					gui_set("rbot_rifle_hitbox", hBox_rifle_priority)
					gui_set("rbot_rifle_hitbox_head", hBox_rifle_head)
					gui_set("rbot_rifle_hitbox_neck", hBox_rifle_neck)
					gui_set("rbot_rifle_hitbox_chest", hBox_rifle_chest)
					gui_set("rbot_rifle_hitbox_stomach", hBox_rifle_stomach)
					gui_set("rbot_rifle_hitbox_pelvis", hBox_rifle_pelvis)
					gui_set("rbot_rifle_hitbox_arms", hBox_rifle_arms)
					gui_set("rbot_rifle_hitbox_legs", hBox_rifle_legs)
					gui_set("rbot_rifle_headifwalking", hBox_rifle_walking)
					gui_set("rbot_rifle_hitbox_adaptive", hBox_rifle_adaptive)
					
					-- shotgun hitbox settings --
					gui_set("rbot_shotgun_hitbox", hBox_shotgun_priority)
					gui_set("rbot_shotgun_hitbox_head", hBox_shotgun_head)
					gui_set("rbot_shotgun_hitbox_neck", hBox_shotgun_neck)
					gui_set("rbot_shotgun_hitbox_chest", hBox_shotgun_chest)
					gui_set("rbot_shotgun_hitbox_stomach", hBox_shotgun_stomach)
					gui_set("rbot_shotgun_hitbox_pelvis", hBox_shotgun_pelvis)
					gui_set("rbot_shotgun_hitbox_arms", hBox_shotgun_arms)
					gui_set("rbot_shotgun_hitbox_legs", hBox_shotgun_legs)
					gui_set("rbot_shotgun_headifwalking", hBox_shotgun_walking)
					gui_set("rbot_shotgun_hitbox_adaptive", hBox_shotgun_adaptive)
					
					-- auto hitbox settings --
					gui_set("rbot_autosniper_hitbox", hBox_auto_priority)
					gui_set("rbot_autosniper_hitbox_head", hBox_auto_head)
					gui_set("rbot_autosniper_hitbox_neck", hBox_auto_neck)
					gui_set("rbot_autosniper_hitbox_chest", hBox_auto_chest)
					gui_set("rbot_autosniper_hitbox_stomach", hBox_auto_stomach)
					gui_set("rbot_autosniper_hitbox_pelvis", hBox_auto_pelvis)
					gui_set("rbot_autosniper_hitbox_arms", hBox_auto_arms)
					gui_set("rbot_autosniper_hitbox_legs", hBox_auto_legs)
					gui_set("rbot_autosniper_headifwalking", hBox_auto_walking)
					gui_set("rbot_autosniper_hitbox_adaptive", hBox_auto_adaptive)
					
					-- scout hitbox settings --
					gui_set("rbot_scout_hitbox", hBox_scout_priority)
					gui_set("rbot_scout_hitbox_head", hBox_scout_head)
					gui_set("rbot_scout_hitbox_neck", hBox_scout_neck)
					gui_set("rbot_scout_hitbox_chest", hBox_scout_chest)
					gui_set("rbot_scout_hitbox_stomach", hBox_scout_stomach)
					gui_set("rbot_scout_hitbox_pelvis", hBox_scout_pelvis)
					gui_set("rbot_scout_hitbox_arms", hBox_scout_arms)
					gui_set("rbot_scout_hitbox_legs", hBox_scout_legs)
					gui_set("rbot_scout_headifwalking", hBox_scout_walking)
					gui_set("rbot_scout_hitbox_adaptive", hBox_scout_adaptive)
					
					-- awp hitbox settings --
					gui_set("rbot_sniper_hitbox", hBox_awp_priority)
					gui_set("rbot_sniper_hitbox_head", hBox_awp_head)
					gui_set("rbot_sniper_hitbox_neck", hBox_awp_neck)
					gui_set("rbot_sniper_hitbox_chest", hBox_awp_chest)
					gui_set("rbot_sniper_hitbox_stomach", hBox_awp_stomach)
					gui_set("rbot_sniper_hitbox_pelvis", hBox_awp_pelvis)
					gui_set("rbot_sniper_hitbox_arms", hBox_awp_arms)
					gui_set("rbot_sniper_hitbox_legs", hBox_awp_legs)
					gui_set("rbot_sniper_headifwalking", hBox_awp_walking)
					gui_set("rbot_sniper_hitbox_adaptive", hBox_awp_adaptive)
					
					-- lmg hitbox settings --
					gui_set("rbot_lmg_hitbox", hBox_lmg_priority)
					gui_set("rbot_lmg_hitbox_head", hBox_lmg_head)
					gui_set("rbot_lmg_hitbox_neck", hBox_lmg_neck)
					gui_set("rbot_lmg_hitbox_chest", hBox_lmg_chest)
					gui_set("rbot_lmg_hitbox_stomach", hBox_lmg_stomach)
					gui_set("rbot_lmg_hitbox_pelvis", hBox_lmg_pelvis)
					gui_set("rbot_lmg_hitbox_arms", hBox_lmg_arms)
					gui_set("rbot_lmg_hitbox_legs", hBox_lmg_legs)
					gui_set("rbot_lmg_headifwalking", hBox_lmg_walking)
					gui_set("rbot_lmg_hitbox_adaptive", hBox_lmg_adaptive)
					
				end
				
				SenseUI.EndGroup();
			end
			
		end
		SenseUI.EndTab();

		if SenseUI.BeginTab( "LegitTab", SenseUI.Icons.legit ) then
			if SenseUI.BeginGroup( "TWOnewels1", "Aimbot", 25, 25, 205, 360 ) then
				

				SenseUI.EndGroup();
			end

			if SenseUI.BeginGroup( "TWOnewels2", "New elements", 255, 25, 205, 360 ) then
				

				SenseUI.EndGroup();
			end
		end
		SenseUI.EndTab();
		
		
		if SenseUI.BeginTab( "VisualsTab", SenseUI.Icons.visuals ) then
		end
		SenseUI.EndTab();
		
		if SenseUI.BeginTab( "SettingsTab", SenseUI.Icons.settings ) then
			if SenseUI.BeginGroup( "Settings", "Settings", 25, 25, 205, 215 ) then
				SenseUI.SetGroupSizeable( this_sizeable );
				show_gradient = SenseUI.Checkbox( "Show gradient", show_gradient );
				draw_texture = SenseUI.Checkbox( "Draw window texture", draw_texture );

				SenseUI.Label( "Menu key" );
				window_bkey, window_bact, window_bdet = SenseUI.Bind( "wndToggle", false, window_bkey, window_bact, window_bdet );

				SenseUI.EndGroup();
			end
			
			if SenseUI.BeginGroup( "About", "Information", 25, 265, 435, 110 ) then
				SenseUI.Label( "Credits", true );
				SenseUI.Label( "-SenseUI by Ruppet" );
				SenseUI.Label( "-Baim Key by Anue" );

				SenseUI.EndGroup();
			end
		end
		SenseUI.EndTab();

		SenseUI.EndWindow();
	end
end

callbacks.Register( "Draw", "suitest", draw_callback );
