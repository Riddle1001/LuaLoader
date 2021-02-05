-- Scraped by chicken
-- Author: dragon99z
-- Title [Release] Auto Weapon Fake Latency
-- Forum link https://aimware.net/forum/thread/89734

local SetValue = gui.SetValue;

local msc_ref = gui.Reference( "MISC", "Part 1" );
local lua_groupbox = gui.Groupbox( msc_ref, "Auto Weapon Latancey", -16, 585, 0, 5 );
local AWAutoLatanceyCheckbox = gui.Checkbox( msc_ref, "lua_autolatancey_enable", "Auto Weapon Latancy", 0 );
local AWAutoLatanceySliderSSG = gui.Slider( msc_ref, "lua_autolatancey_ssg08", "SSG08 Latancy", 0.2 , 0 , 1 );
local AWAutoLatanceySliderAWP = gui.Slider( msc_ref, "lua_autolatancey_awp", "AWP Latancy", 0.2 , 0 , 1 );
local AWAutoLatanceySliderG3 = gui.Slider( msc_ref, "lua_autolatancey_g3sg1", "G3SG1 Latancy", 0.2 , 0 , 1 );
local AWAutoLatanceySliderSCAR = gui.Slider( msc_ref, "lua_autolatancey_scar20", "SCAR-20 Latancy", 0.2 , 0 , 1 );

local function AutoLatancey( Event )

	if gui.GetValue( "lbot_positionadjustment" ) > 0 then
		
		if AWAutoLatanceyCheckbox:GetValue() then
		
			if ( Event:GetName() ~= "item_equip" ) then
				return;
			end

			local ME = client.GetLocalPlayerIndex();
			local INT_UID = Event:GetInt( "userid" );
			local PlayerIndex = client.GetPlayerIndexByUserID( INT_UID );

			local WepType = Event:GetInt( "weptype" );
			local Item = Event:GetString( "item" );

			if ( ME == PlayerIndex ) then
				if ( Item == "ssg08" ) then
					if (AWAutoLatanceySliderSSG:GetValue() > 0) then
						SetValue("msc_fakelatency_enable", 1);
						SetValue( "msc_fakelatency_amount", AWAutoLatanceySliderSSG:GetValue());	
					end
				elseif ( Item == "awp" ) then
					if (AWAutoLatanceySliderAWP:GetValue() > 0) then
						SetValue("msc_fakelatency_enable", 1);
						SetValue( "msc_fakelatency_amount", AWAutoLatanceySliderAWP:GetValue());
					end
				elseif ( Item == "g3sg1" ) then
					if (AWAutoLatanceySliderG3:GetValue() > 0) then
						SetValue("msc_fakelatency_enable", 1);
						SetValue( "msc_fakelatency_amount", AWAutoLatanceySliderG3:GetValue());
					end
				elseif ( Item == "scar20" ) then
					if (AWAutoLatanceySliderSCAR:GetValue() > 0) then
						SetValue("msc_fakelatency_enable", 1);
						SetValue( "msc_fakelatency_amount", AWAutoLatanceySliderSCAR:GetValue());
					end
				else
					SetValue("msc_fakelatency_enable", 0);
				end

			end

		end

	end

end

client.AllowListener( "item_equip" )
callbacks.Register( "FireGameEvent", "AutoLatancey", AutoLatancey )

