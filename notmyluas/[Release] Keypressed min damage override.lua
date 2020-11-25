-- Scraped by chicken
-- Author: gowork88
-- Title [Release] Keypressed min damage override
-- Forum link https://aimware.net/forum/thread/115375

-- Powered by El Credito

local guiSet = gui.SetValue;
local guiGet = gui.GetValue;
local b_toggle = input.IsButtonDown

local rage_ref_extra = gui.Reference("RAGE", "MAIN", "Extra");
local chengeDamageText = gui.Text(rage_ref_extra, "--- Changer Damage ---");
local newDamage = gui.Slider(rage_ref_extra, "NewDamage", "Min damage", 1, 0, 100);
local changeKey = gui.Keybox(rage_ref_extra, "ChangeDmgKey", "Change damage key", 0);
local firstTime = 1;

local auto = guiGet("rbot_autosniper_mindamage")
local sniper = guiGet("rbot_sniper_mindamage")
local pistol = guiGet("rbot_pistol_mindamage")
local revolver = guiGet("rbot_revolver_mindamage")
local smg = guiGet("rbot_smg_mindamage")
local rifle = guiGet("rbot_rifle_mindamage")
local shotgun = guiGet("rbot_shotgun_mindamage")
local scout = guiGet("rbot_scout_mindamage")
local lmg = guiGet("rbot_lmg_mindamage")

function changeDmgMain()
	if (changeKey:GetValue() == 0) then
		return -1;
	end
	if (input.IsButtonPressed(changeKey:GetValue())) then
		if (firstTime == 1) then
			auto = guiGet("rbot_autosniper_mindamage")
			sniper = guiGet("rbot_sniper_mindamage")
			pistol = guiGet("rbot_pistol_mindamage")
			revolver = guiGet("rbot_revolver_mindamage")
			smg = guiGet("rbot_smg_mindamage")
			rifle = guiGet("rbot_rifle_mindamage")
			shotgun = guiGet("rbot_shotgun_mindamage")
			scout = guiGet("rbot_scout_mindamage")
			lmg = guiGet("rbot_lmg_mindamage")
			
			guiSet("rbot_autosniper_mindamage", math.floor(newDamage:GetValue()))
			guiSet("rbot_sniper_mindamage", math.floor(newDamage:GetValue()))
			guiSet("rbot_pistol_mindamage", math.floor(newDamage:GetValue()))
			guiSet("rbot_revolver_mindamage", math.floor(newDamage:GetValue()))
			guiSet("rbot_smg_mindamage", math.floor(newDamage:GetValue()))
			guiSet("rbot_rifle_mindamage", math.floor(newDamage:GetValue()))
			guiSet("rbot_shotgun_mindamage", math.floor(newDamage:GetValue()))
			guiSet("rbot_scout_mindamage", math.floor(newDamage:GetValue()))
			guiSet("rbot_lmg_mindamage", math.floor(newDamage:GetValue()))
			firstTime = 0
		end
	elseif (b_toggle(changeKey:GetValue())) then
		-- do nothing ;)
	elseif (input.IsButtonReleased(changeKey:GetValue())) then
		guiSet("rbot_autosniper_mindamage", auto)
		guiSet("rbot_sniper_mindamage", sniper)
		guiSet("rbot_pistol_mindamage", pistol)
		guiSet("rbot_revolver_mindamage", revolver)
		guiSet("rbot_smg_mindamage", smg)
		guiSet("rbot_rifle_mindamage", rifle)
		guiSet("rbot_shotgun_mindamage", shotgun)
		guiSet("rbot_scout_mindamage", scout)
		guiSet("rbot_lmg_mindamage", lmg)
		firstTime = 1;
	end
end

callbacks.Register("Draw", "changeDmgMain", changeDmgMain);