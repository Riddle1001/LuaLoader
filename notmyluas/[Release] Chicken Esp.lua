-- Scraped by chicken
-- Author: Scape
-- Title [Release] Chicken Esp
-- Forum link https://aimware.net/forum/thread/133522

local lua_ChickenAnim = Combobox(lua_groupbox, 'lua_ChickenAnim', 'Chicken Animation','Default', 'Anti-Aim', 'Bhop', 'Come at me bro')

			if lua_ChickenAnim:GetValue() == 0 then
				elseif lua_ChickenAnim:GetValue() == 1 then
					if m_nSequence ~= -2 then
						chicken:SetProp('m_nSequence', -2)
					end
				elseif lua_ChickenAnim:GetValue() == 2 then
					if m_nSequence ~= 9 then
						chicken:SetProp('m_nSequence', 9)
					end
				elseif lua_ChickenAnim:GetValue() == 3 then
					if m_nSequence ~= 7 then
						chicken:SetProp('m_nSequence', 7)
					end
			end


