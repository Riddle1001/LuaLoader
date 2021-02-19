-- Scraped by chicken
-- Author: rraggerr
-- Title [Release] Advanced Legit
-- Forum link https://aimware.net/forum/thread/90655

local CHECK_SCOPE = gui.Checkbox( gui.Reference( "LEGIT", "Aimbot" ), "lua_AV_check_scope", "Check Scope", 0 )
local CHECK_JUMP = gui.Checkbox( gui.Reference( "LEGIT", "Aimbot" ), "lua_AV_check_jump", "Check Jump", 0 )
local CHECK_FLASH = gui.Checkbox( gui.Reference( "LEGIT", "Aimbot" ), "lua_AV_heck_flash", "Check Flash(WIP)", 0 )
local FIX_FOV_WITH_SNIPERS = gui.Checkbox( gui.Reference( "VISUALS", "Main" ), "lua_AV_fov_snipers_fix", "Fix Scope", 0 )

local original = {[0]=gui.GetValue("vis_view_fov"),[1]=gui.GetValue("vis_view_fov")}

function Draw( )
local me = entities.GetLocalPlayer()
if me ~= nil and me:IsAlive() then
local CurrentWeapon = me:GetPropEntity("m_hActiveWeapon")
local myflags = me:GetPropInt("m_fFlags")
local FlashDuration = me:GetProp("m_flFlashDuration")
local scoped = entities.GetLocalPlayer():GetProp("m_bIsScoped")

if FIX_FOV_WITH_SNIPERS:GetValue() then if scoped == 1 or scoped == 257 then gui.SetValue("vis_view_fov", 0) gui.SetValue("vis_view_model_fov", 0) else gui.SetValue("vis_view_fov", original[0]) gui.SetValue("vis_view_model_fov", original[1]) end end

if (CHECK_FLASH:GetValue() and CheckFlash(FlashDuration)) or
(CHECK_SCOPE:GetValue() and CheckScope(me, CurrentWeapon)) or
(CHECK_JUMP:GetValue() and CheckJump(myflags)) then gui.SetValue("lbot_enable", 0 ) else gui.SetValue("lbot_enable", 1 ) end
end
end

function CheckScope( me , weapon)if IsSniper(tostring(weapon)) then return not me:GetPropBool("m_bIsScoped") else return false end end
function CheckJump( flags )return flags == 256 end
function CheckFlash( duration )return duration ~= 0 --[[ so ghetto ]]end

function IsSniper( weapon )
if weapon:match("ssg08") or
weapon:match("awp") or
weapon:match("scar20") or
weapon:match("g3sg1") then return true end return false
end

callbacks.Register("Draw", "AL_Draw", Draw)
local credits = {"[AV] AimWare Advanced Legit Script by rraggerr", "[AV] Version [1.0]", "[AV] 3 Nov. 2018", "[AV] Sucessfuly loaded!"}
for a = 0, #credits do print(credits[a]) end