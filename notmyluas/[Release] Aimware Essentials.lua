-- Scraped by chicken
-- Author: The_Belch
-- Title [Release] Aimware Essentials
-- Forum link https://aimware.net/forum/thread/115981

local MSC_PART_REF = gui.Reference( "MISC", "ENHANCEMENT", "Hitmarkers" );
local AWMetallicHitsound = gui.Checkbox( MSC_PART_REF, "lua_hitsound", "Metallic", 0 );
local function MetallicHitsound( Event )

	if AWMetallicHitsound:GetValue() then
		if gui.GetValue( "msc_hitmarker_enable" ) then
			gui.SetValue( "msc_hitmarker_enable", 0 );
		end
		if ( Event:GetName() == "player_hurt" ) then
			local ME = client.GetLocalPlayerIndex();
			local INT_UID = Event:GetInt( "userid" );
			local INT_ATTACKER = Event:GetInt( "attacker" );
			local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
			local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
			local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
			local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
			if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
				volume = gui.GetValue("msc_hitmarker_volume"); 
				client.Command("playvol buttons\\arena_switch_press_02.wav "..volume, true);
			end
		end
	end
end
client.AllowListener( "player_hurt" );
callbacks.Register( "FireGameEvent", "Metallic Hitsound", MetallicHitsound );

