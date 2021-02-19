-- Scraped by chicken
-- Author: yu0r
-- Title [Release] Aimware Seizure
-- Forum link https://aimware.net/forum/thread/86012

-- gui.SetValue("esp.world.materials.walls",    math.random(0,1) )
-- gui.SetValue("esp.world.materials.walls.clr",    math.random(255) ,math.random(255),math.random(255),255)
-- gui.SetValue("esp.world.materials.staticprops",    math.random(0,1) )
-- gui.SetValue("esp.world.materials.staticprops.clr",math.random(255) ,math.random(255),math.random(255),255)
-- zero fps with above

local VISUALz = gui.Reference('VISUALS')
local visualtab = gui.Tab(VISUALz, "visualtab.tab", "YOU HAVE AIDS")
local AIDSBOX = gui.Groupbox(visualtab, 'YOU HAVE AIDS v2.0 (YOU`RE BLACK EDITION)', 16, 16,275, 100)
local lua_AidsF = gui.Checkbox( AIDSBOX, "lua_AidsF", "OVERLAY FRIEND AIDS", 0)
local lua_AidsE = gui.Checkbox( AIDSBOX, "lua_AidsE", "OVERLAY ENEMY AIDS", 0)
local lua_AidsW = gui.Checkbox( AIDSBOX, "lua_AidsW", "OVERLAY WEAPON AIDS", 0)
local lua_AidsWORLD = gui.Checkbox( AIDSBOX, "lua_AidsWORLD", "WORLD AIDS", 0)
local lua_AidsOCC = gui.Checkbox( AIDSBOX, "lua_AidsOCC", "CHAMS OCCLUDED AIDS", 0)
local lua_AidsVIS = gui.Checkbox( AIDSBOX, "lua_AidsVIS", "CHAMS VISIBLE AIDS", 0)
local lua_AidsWIRE = gui.Checkbox( AIDSBOX, "lua_AidsWIRE", "CHAMS WIREFRAME AIDS", 0)
local lua_AidsMISC = gui.Checkbox( AIDSBOX, "lua_AidsMISC", "OTHER AIDS", 0)
local lua_AidsCOLOR = gui.Checkbox( AIDSBOX, "lua_AidsMISC", "THE COLOR OF AIDS", 0)


function aids()
if lua_AidsMISC:GetValue() then
gui.SetValue("esp.other.crosshair",      math.random(0,1) )
gui.SetValue("esp.local.wallbangdmg",    math.random(0,1) )
gui.SetValue("esp.other.nosky",    math.random(0,1) )
gui.SetValue("esp.other.nopostprocess",    math.random(0,1) )
end
if lua_AidsCOLOR:GetValue() then
gui.SetValue("esp.chams.backtrack.occluded.clr", math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.backtrack.overlay.clr",  math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.backtrack.visible.clr",  math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.enemy.occluded.clr",   math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.enemy.overlay.clr",    math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.enemy.visible.clr",     math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.friendly.occluded.clr",  math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.friendly.overlay.clr",   math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.friendly.visible.clr",    math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.ghost.occluded.clr",    math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.ghost.overlay.clr",     math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.ghost.visible.clr",      math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.local.occluded.clr",     math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.local.overlay.clr",      math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.local.visible.clr",       math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.weapon.occluded.clr",  math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.weapon.overlay.clr",   math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.chams.weapon.visible.clr",    math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.other.crosshair.clr",          math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.overlay.enemy.box.clr",      math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.overlay.friendly.box.clr",     math.random(255) ,math.random(255),math.random(255) ,255)
gui.SetValue("esp.overlay.weapon.box.clr",     math.random(255) ,math.random(255),math.random(255) ,255)
end
if lua_AidsOCC:GetValue() then
gui.SetValue("esp.chams.weapon.occluded",math.random(0,5))
gui.SetValue("esp.chams.local.occluded",math.random(0,5))
gui.SetValue("esp.chams.enemy.occluded",math.random(0,5))
gui.SetValue("esp.chams.friendly.occluded",math.random(0,5))
gui.SetValue("esp.chams.ghost.occluded",math.random(0,5))
gui.SetValue("esp.chams.backtrack.occluded",math.random(0,5))
end
if lua_AidsWIRE:GetValue() then
gui.SetValue("esp.chams.backtrack.overlay",math.random(0,1))
gui.SetValue("esp.chams.enemy.overlay",math.random(0,1))
gui.SetValue("esp.chams.friendly.overlay",math.random(0,1))
gui.SetValue("esp.chams.ghost.overlay",math.random(0,1))
gui.SetValue("esp.chams.local.overlay",math.random(0,1))
gui.SetValue("esp.chams.weapon.overlay",math.random(0,1))
end
if lua_AidsVIS:GetValue() then
gui.SetValue("esp.chams.backtrack.visible",math.random(0,7))
gui.SetValue("esp.chams.enemy.visible",math.random(0,7))
gui.SetValue("esp.chams.friendly.visible",math.random(0,7))
gui.SetValue("esp.chams.ghost.visible",math.random(0,7))
gui.SetValue("esp.chams.local.visible",math.random(0,7))
gui.SetValue("esp.chams.weapon.visible",math.random(0,7))
end
if lua_AidsE:GetValue() then
gui.SetValue("esp.overlay.enemy.armorbar",math.random(0,1))
gui.SetValue("esp.overlay.enemy.armornum",math.random(0,1))
gui.SetValue("esp.overlay.enemy.box",math.random(0,1))
gui.SetValue("esp.overlay.enemy.defusing",math.random(0,1))
gui.SetValue("esp.overlay.enemy.flashed",math.random(0,1))
gui.SetValue("esp.overlay.enemy.health.healthbar",math.random(0,1))
gui.SetValue("esp.overlay.enemy.health.healthnum",math.random(0,1))
gui.SetValue("esp.overlay.enemy.money",math.random(0,1))
gui.SetValue("esp.overlay.enemy.name",math.random(0,1))
gui.SetValue("esp.overlay.enemy.planting",math.random(0,1))
gui.SetValue("esp.overlay.enemy.precision",math.random(0,1))
gui.SetValue("esp.overlay.enemy.reloading",math.random(0,1))
gui.SetValue("esp.overlay.enemy.scoped",math.random(0,1))
gui.SetValue("esp.overlay.enemy.weapon",math.random(0,3))
end
if lua_AidsF:GetValue() then
gui.SetValue("esp.overlay.friendly.armorbar",math.random(0,1))
gui.SetValue("esp.overlay.friendly.armornum",math.random(0,1))
gui.SetValue("esp.overlay.friendly.box",math.random(0,1))
gui.SetValue("esp.overlay.friendly.defusing",math.random(0,1))
gui.SetValue("esp.overlay.friendly.flashed",math.random(0,1))
gui.SetValue("esp.overlay.friendly.health.healthbar",math.random(0,1))
gui.SetValue("esp.overlay.friendly.health.healthnum",math.random(0,1))
gui.SetValue("esp.overlay.friendly.money",math.random(0,1))
gui.SetValue("esp.overlay.friendly.name",math.random(0,1))
gui.SetValue("esp.overlay.friendly.planting",math.random(0,1))
gui.SetValue("esp.overlay.friendly.precision",math.random(0,1))
gui.SetValue("esp.overlay.friendly.reloading",math.random(0,1))
gui.SetValue("esp.overlay.friendly.scoped",math.random(0,1))
gui.SetValue("esp.overlay.friendly.weapon",math.random(0,3))
end
if lua_AidsW:GetValue() then
gui.SetValue("esp.overlay.weapon.ammo",math.random(0,1))
gui.SetValue("esp.overlay.weapon.box",math.random(0,1))
gui.SetValue("esp.overlay.weapon.name",math.random(0,1))
end
if lua_AidsWORLD:GetValue() then
gui.SetValue("esp.world.inferno.enemy",math.random(0,1))
gui.SetValue("esp.world.inferno.friendly",math.random(0,1))
gui.SetValue("esp.world.inferno.local",math.random(0,1))
gui.SetValue("esp.world.nadetracer.enemy",math.random(0,1))
gui.SetValue("esp.world.nadetracer.friendly",math.random(0,1))
gui.SetValue("esp.world.nadetracer.local",math.random(0,1))
end
end
callbacks.Register( "Draw", aids);