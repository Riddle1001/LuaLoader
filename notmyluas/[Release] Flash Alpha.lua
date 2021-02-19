-- Scraped by chicken
-- Author: xChrizl
-- Title [Release] Flash Alpha
-- Forum link https://aimware.net/forum/thread/90117

local vis_misc_ref = gui.Reference("VISUALS", "MISC", "Removal");
local vis_flash_alpha = gui.Slider(vis_misc_ref, "vis_flash_alpha", "Flash-Alpha", 100, 0, 100)

function FlashAlpha()
    local value = vis_flash_alpha:GetValue() / 100 * 255
    for index, player in pairs(entities.FindByClass("CCSPlayer")) do
        player:SetProp("m_flFlashMaxAlpha", value)
    end
end

callbacks.Register("Draw", "FlashAlpha", FlashAlpha)