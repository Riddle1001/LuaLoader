-- Scraped by chicken
-- Author: 2878713023
-- Title [Release] Zeus Warning
-- Forum link https://aimware.net/forum/thread/150512

localzeus_svg=
draw.CreateTexture(
common.RasterizeSVG(
'<svgid="svg"version="1.1"width="500"height="500"xmlns="http://www.w3.org/2000/svg"xmlns:xlink="http://www.w3.org/1999/xlink"><gid="svgg"><pathid="path0"d="M185.80318.945C184.77919.092,182.02823.306,174.85135.722C169.58044.841,157.06466.513,147.03883.882C109.237149.365,100.864163.863,93.085177.303C88.686184.901,78.772202.072,71.053215.461C63.333228.849,53.959245.069,50.219251.505C46.480257.941,43.421263.491,43.421263.837C43.421264.234,69.566264.530,114.025264.635L184.628264.803181.217278.618C179.342286.217,174.952304.128,171.463318.421C167.974332.714,160.115364.836,153.999389.803C147.882414.770,142.934435.254,143.002435.324C143.127435.452,148.286428.934,199.343364.145C215.026344.243,230.900324.112,234.619319.408C238.337314.704,254.449294.276,270.423274.013C286.397253.750,303.090232.582,307.519226.974C340.870184.745,355.263166.399,355.263166.117C355.263165.937,323.554165.789,284.798165.789C223.368165.789,214.380165.667,214.701164.831C215.039163.949,222.249151.366,243.554114.474C280.60450.317,298.19219.768,298.26719.444C298.35519.064,188.38818.576,185.80318.945"stroke="none"fill="#fff200"fill-rule="evenodd"></path></g></svg>',
0.04
)
)
localfunctionzeus_warn(builder)
localent=builder:GetEntity()
locallp=entities.GetLocalPlayer()
if
ent:IsAlive()andent:IsPlayer()andent:GetTeamNumber()~=lp:GetTeamNumber()andent:GetPropEntity("m_hMyWeapons","003"):GetName()and
ent:GetPropEntity("m_hMyWeapons","003"):GetName()=="weapon_taser"
then
ifent:GetWeaponID()==31then
builder:Color(255,0,0,255)
else
builder:Color(255,242,0,255)
end
builder:AddIconLeft(zeus_svg)
end
end
callbacks.Register("DrawESP",zeus_warn)


