-- Scraped by chicken
-- Author: Tomeno
-- Title [Release] Extra ESP
-- Forum link https://aimware.net/forum/thread/102271

-- Extra ESP by Tomeno

local VisOthersOptions = gui.Reference("VISUALS", "OTHER", "Options");
local ExtraESPSection = gui.Text( VisOthersOptions, " " )
local ExtraESPSection = gui.Text( VisOthersOptions, "              Extra ESP" )
local TextStyle = gui.Combobox( VisOthersOptions, "lua_textstyle", "Text Style", "Shadowed", "Retro Shadow", "Plain" )
local PropESPO = gui.Combobox( VisOthersOptions, "lua_propesp", "Prop ESP", "Off", "2D", "3D" )
local FishESPO = gui.Checkbox( VisOthersOptions, "lua_fishesp", "Fish", 1 )
local BreakableESPO = gui.Checkbox( VisOthersOptions, "lua_breakableesp", "Breakables", 0 )
local WindowESPO = gui.Checkbox( VisOthersOptions, "lua_windowesp", "Windows", 0 )
local DoorESPO = gui.Checkbox( VisOthersOptions, "lua_dooresp", "Doors", 0 )
local RagdollESPO = gui.Checkbox( VisOthersOptions, "lua_ragdollesp", "Ragdolls", 1 )
local ChickenESPO = gui.Combobox( VisOthersOptions, "lua_chickenesp", "Chicken ESP", "Off", "2D", "3D" )
local ChickenBonesO = gui.Checkbox( VisOthersOptions, "lua_chickenchams", "Chicken BoneESP", 0 )
local ChickenChamsO = gui.Checkbox( VisOthersOptions, "lua_chickenchams", "Chicken Chams", 0 )
local ChickenR = gui.Slider( VisOthersOptions, "lua_chickenred", "Chicken Chams Red", 255, 0, 255 )
local ChickenG = gui.Slider( VisOthersOptions, "lua_chickengreen", "Chicken Chams Green", 255, 0, 255 )
local ChickenB = gui.Slider( VisOthersOptions, "lua_chickenblue", "Chicken Chams Blue", 255, 0, 255 )

function DrawText(X, Y, Text, Alignment) -- alignment: 1: x-centered 2: y-centered 4: x-inverted 8: y-inverted
 if X and Y then
 if not Alignment then Alignment = 0 end
 local Tw, Th = draw.GetTextSize(Text)
 local DX, DY = X, Y
 if Alignment & 1 == 1 then
 DX = X - (Tw/2)
 elseif Alignment & 4 == 4 then
 DX = X - Tw
 end
 if Alignment & 2 == 2 then
 DY = Y - (Th/2)
 elseif Alignment & 8 == 8 then
 DY = Y - Th
 end
 if TextStyle:GetValue() == 0 then
 draw.TextShadow(DX, DY, Text)
 elseif TextStyle:GetValue() == 1 then
 draw.Color(0, 0, 0, 255);
 draw.Text(DX+1, DY+1, Text)
 draw.Color(255, 255, 255, 255);
 draw.Text(DX, DY, Text)
 else
 draw.Text(DX, DY, Text)
 end
 end
end

function AddVector(V1, V2)
 return {V1[1]+V2[1], V1[2]+V2[2], V1[3]+V2[3]}
end

function D2R(ang)
 return ang / (180 / math.pi)
end

function RGB2clr(R, G, B)
 return 0xFFFFFF & ((R&0xFF)|((G&0xFF)<<8)|((B&0xFF)<<16))
end

function RotateVectorA(Vx, Vy, Vz, Ax, Ay, Az)
 local sp = math.sin(Ax)
 local cp = math.cos(Ax)
 
 local sy = math.sin(Ay)
 local cy = math.cos(Ay)
 
 local sr = math.sin(Az)
 local cr = math.cos(Az)
 
 local rot = {{0,0,0},{0,0,0},{0,0,0}}
 
 rot[1][1] = cp*cy;
 rot[2][1] = cp*sy;
 rot[3][1] = -sp;

 local crcy = cr*cy;
 local crsy = cr*sy;
 local srcy = sr*cy;
 local srsy = sr*sy;
 
 rot[1][2] = sp*srcy-crsy;
 rot[2][2] = sp*srsy+crcy;
 rot[3][2] = sr*cp;

 rot[1][3] = (sp*crcy+srsy);
 rot[2][3] = (sp*crsy-srcy);
 rot[3][3] = cr*cp;
 
 local vec1 = {rot[1][1]*Vx, rot[2][1]*Vx, rot[3][1]*Vx}
 local vec2 = {rot[1][2]*Vy, rot[2][2]*Vy, rot[3][2]*Vy}
 local vec3 = {rot[1][3]*Vz, rot[2][3]*Vz, rot[3][3]*Vz}
 
 local R = AddVector(vec1, AddVector(vec2, vec3))
 return table.unpack(R)
end

function RotateVector(V, Ax, Ay, Az)
 local Vx, Vy, Vz = table.unpack(V)
 return table.pack(RotateVectorA(Vx, Vy, Vz, Ax, Ay, Az))
end

function Get3DBox(Ox, Oy, Oz, mx, my, mz, Mx, My, Mz, Ax, Ay, Az)
 if Ox and Oy and Oz and mx and my and mz and Mx and My and Mz and Ax and Ay and Az then
 local Vectors = {{mx, my, mz},{Mx, my, mz},{Mx, My, mz},{mx, My, mz},{Mx, My, Mz},{mx, My, Mz},{mx, my, Mz},{Mx, my, Mz}}
 for i = 1, #Vectors do
 Vectors[i] = RotateVector(Vectors[i], D2R(Ax), D2R(Ay), D2R(Az))
 Vectors[i] = AddVector(Vectors[i], {Ox, Oy, Oz})
 end
 return Vectors
 else return nil end
end

function GetScreenBox(Vectors)
 local ScreenVectors = {}
 for i = 1, #Vectors do
 table.insert(ScreenVectors, table.pack(client.WorldToScreen(table.unpack(Vectors[i]))))
 end
 return ScreenVectors
end

function Draw3DBox(ScreenVectors)
 local CubeConnections = {{1,2},{2,3},{3,4},{4,1},{5,6},{6,7},{7,8},{8,5},{1,7},{2,8},{3,5},{4,6}}
 for i, cubeTuple in ipairs(CubeConnections) do
 local x1, y1 = table.unpack(ScreenVectors[cubeTuple[1]])
 local x2, y2 = table.unpack(ScreenVectors[cubeTuple[2]])
 if x1 and x2 then
 draw.Line(x1, y1, x2, y2)
 end
 end
end

function GetW2SMinMax(ScreenVectors)
 local minX, minY, maxX, maxY = 9999, 9999, -9999, -9999
 for i = 1, #ScreenVectors do
 local Vector = ScreenVectors[i]
 local X = Vector[1]
 if X then
 if X < minX then minX = X end
 if X > maxX then maxX = X end
 end
 local Y = Vector[2]
 if Y then
 if Y < minY then minY = Y end
 if Y > maxY then maxY = Y end
 end
 end
 return minX, minY, maxX, maxY
end

function GetHighestPoint(Vectors)
 local maxZ = -9999
 for i = 1, #Vectors do
 local Z = Vectors[i][3]
 if Z then
 if Z > maxZ then maxZ = Z end
 end
 end
 return maxZ
end

function FishESP()
 local flist = entities.FindByClass( "CFish" )
 for i = 1, #flist do
 local fish = flist[i]
 local angle = ((fish:GetProp("m_angle")/180)-1)*math.pi
 local Fx, Fy, Fz = fish:GetAbsOrigin()
 local Ax, Ay, Az = math.cos(angle), math.sin(angle), 0
 local FBx, FBy, FTx, FTy, BBx, BBy, BTx, BTy, Nx, Ny
 local alive = not fish:GetPropBool("m_lifeState")
 local name
 if alive then
 FBx, FBy = client.WorldToScreen(Fx-Ax*3, Fy-Ay*3, Fz-4)
 FTx, FTy = client.WorldToScreen(Fx-Ax*3, Fy-Ay*3, Fz+4)
 BBx, BBy = client.WorldToScreen(Fx+Ax*10, Fy+Ay*10, Fz-4)
 BTx, BTy = client.WorldToScreen(Fx+Ax*10, Fy+Ay*10, Fz+4)
 name = "Fish"
 else
 Rx, Ry, Rz = -Ay, Ax, Az
 FBx, FBy = client.WorldToScreen(Fx-Ax*3-Rx*4, Fy-Ay*3-Ry*4, Fz)
 FTx, FTy = client.WorldToScreen(Fx-Ax*3+Rx*4, Fy-Ay*3+Ry*4, Fz)
 BBx, BBy = client.WorldToScreen(Fx+Ax*10-Rx*4, Fy+Ay*10-Ry*4, Fz)
 BTx, BTy = client.WorldToScreen(Fx+Ax*10+Rx*4, Fy+Ay*10+Ry*4, Fz)
 name = "*DEAD* Fish"
 end
 if(FBx and FBy and FTx and FTy and BBx and BBy and BTx and BTy) then
 if alive then
 Nx, Ny = (BTx+FTx)/2, (BTy+FTy)/2
 else
 Nx, Ny = (BTx+FBx)/2, (BTy+FBy)/2
 end
 draw.Line(FBx, FBy, FTx, FTy)
 draw.Line(FTx, FTy, BTx, BTy)
 draw.Line(BTx, BTy, BBx, BBy)
 draw.Line(BBx, BBy, FBx, FBy)
 DrawText(Nx, Ny, name, 1|8)
 end
 end
end

function WindowESP(Entity)
 local Ax, Ay, Az = Entity:GetPropVector("m_angRotation")
 local mx, my, mz = Entity:GetMins()
 local Mx, My, Mz = Entity:GetMaxs()
 if mx and my and mz then 
 local Box3D = Get3DBox(WOx, WOy, WOz, mx, my, mz, Mx, My, Mz, Ax, Ay, Az)
 local Box2D = GetScreenBox(Box3D)
 Draw3DBox(Box2D)
 end
 DrawText(SOx, SOy, "Window", 3);
end

function PropESP(Entity)
 local WOx, WOy, WOz = Entity:GetAbsOrigin()
 local Ax, Ay, Az = Entity:GetPropVector("m_angRotation")
 local mx, my, mz
 local Mx, My, Mz
 if Entity:GetClass() == "CPhysicsPropMultiplayer" then
 mx, my, mz = Entity:GetPropVector("m_collisionMins")
 Mx, My, Mz = Entity:GetPropVector("m_collisionMaxs")
 else
 mx, my, mz = Entity:GetMins()
 Mx, My, Mz = Entity:GetMaxs()
 end
 if mx and my and mz then
 local Box3D = Get3DBox(WOx, WOy, WOz, mx, my, mz, Mx, My, Mz, Ax, Ay, Az)
 local Box2D = GetScreenBox(Box3D)
 if PropESPO:GetValue() == 2 then
 Draw3DBox(Box2D)
 local maxZ = GetHighestPoint(Box3D)
 local v1x, v1y, v1z = table.unpack(Box3D[1])
 local v2x, v2y, v2z = table.unpack(Box3D[5])
 local textPosX, textPosY = client.WorldToScreen((v1x+v2x)/2, (v1y+v2y)/2, maxZ)
 DrawText(textPosX, textPosY, "Prop", 9);
 else
 local minX, minY, maxX, maxY = GetW2SMinMax(Box2D)
 draw.RoundedRect( minX, minY, maxX, maxY )
 DrawText((minX+maxX)/2, minY, "Prop", 9);
 end
 end
end

function BreakableESP(Entity)
 local WOx, WOy, WOz = Entity:GetAbsOrigin()
 local Ax, Ay, Az = Entity:GetPropVector("m_angRotation")
 local mx, my, mz = Entity:GetMins()
 local Mx, My, Mz = Entity:GetMaxs()
 if mx and my and mz then
 local Box3D = Get3DBox(WOx, WOy, WOz, mx, my, mz, Mx, My, Mz, Ax, Ay, Az)
 local Box2D = GetScreenBox(Box3D)
 Draw3DBox(Box2D)
 local v1x, v1y, v1z = table.unpack(Box3D[1])
 local v2x, v2y, v2z = table.unpack(Box3D[5])
 local textPosX, textPosY = client.WorldToScreen((v1x+v2x)/2, (v1y+v2y)/2, (v1z+v2z)/2)
 DrawText(textPosX, textPosY, "Breakable", 3);
 end
end

function ChickenESP(Entity)
 local WOx, WOy, WOz = Entity:GetAbsOrigin()
 local Ax, Ay, Az = Entity:GetPropVector("m_angRotation")
 local mx, my, mz = Entity:GetMins()
 local Mx, My, Mz = Entity:GetMaxs()
 local factor = 0.8
 mx, my, mz = mx*factor, my*factor, mz*factor
 Mx, My, Mz = Mx*factor, My*factor, Mz*factor
 if mx and my and mz then
 local Box3D = Get3DBox(WOx, WOy, WOz, mx, my, mz, Mx, My, Mz, Ax, Ay, Az)
 local Box2D = GetScreenBox(Box3D)
 local Leader = Entity:GetPropEntity("m_leader")
 local Name = "Chicken"
 if (Leader) then
 Name = Leader:GetName() .. "'s " .. Name 
 if (Leader:GetIndex() == client.GetLocalPlayerIndex()) then
 draw.Color( 255, 255, 150, 255 );
 elseif (Leader:GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber()) then
 draw.Color( 200, 255, 200, 255 );
 else
 draw.Color( 255, 150, 150, 255 );
 end
 end
 if ChickenESPO:GetValue() == 2 then
 Draw3DBox(Box2D)
 local maxZ = GetHighestPoint(Box3D)
 local v1x, v1y, v1z = table.unpack(Box3D[1])
 local v2x, v2y, v2z = table.unpack(Box3D[5])
 local textPosX, textPosY = client.WorldToScreen((v1x+v2x)/2, (v1y+v2y)/2, maxZ)
 DrawText(textPosX, textPosY, Name, 9);
 else
 local minX, minY, maxX, maxY = GetW2SMinMax(Box2D)
 draw.RoundedRect( minX, minY, maxX, maxY )
 DrawText((minX+maxX)/2, minY, Name, 9);
 end
 end
end

function DoorESP(Entity)
 local WOx, WOy, WOz = Entity:GetAbsOrigin()
 local Ax, Ay, Az = Entity:GetPropVector("m_angRotation")
 local mx, my, mz = Entity:GetMins()
 local Mx, My, Mz = Entity:GetMaxs()
 if mx and my and mz then
 local Box3D = Get3DBox(WOx, WOy, WOz, mx, my, mz, Mx, My, Mz, Ax, Ay, Az)
 local Box2D = GetScreenBox(Box3D)
 Draw3DBox(Box2D)
 local v1x, v1y, v1z = table.unpack(Box3D[1])
 local v2x, v2y, v2z = table.unpack(Box3D[5])
 local textPosX, textPosY = client.WorldToScreen((v1x+v2x)/2, (v1y+v2y)/2, (v1z+v2z)/2)
 DrawText(textPosX, textPosY, "Door", 3);
 end
end

function WindowESP(Entity)
 local WOx, WOy, WOz = Entity:GetAbsOrigin()
 local Ax, Ay, Az = Entity:GetPropVector("m_angRotation")
 local mx, my, mz = Entity:GetMins()
 local Mx, My, Mz = Entity:GetMaxs()
 if mx and my and mz then
 local Box3D = Get3DBox(WOx, WOy, WOz, mx, my, mz, Mx, My, Mz, Ax, Ay, Az)
 local Box2D = GetScreenBox(Box3D)
 Draw3DBox(Box2D)
 local textPosX, textPosY = client.WorldToScreen(WOx, WOy, WOz)
 DrawText(textPosX, textPosY, "Window", 3);
 end
end

function ChickenBoneESP(Entity)
 local boneConnections = {{37, 35}, {35, 32}, {32, 20}, {20, 0}, {0, 18}, {18, 19}, {32, 28}, {28, 29}, {29, 31}, {32, 23}, {23, 24}, {24, 26}, {0, 1}, {1, 4}, {4, 6}, {6, 8}, {0, 9}, {9, 12}, {12, 16}, {16, 15}} 
 for i = 1, #boneConnections do
 local boneTuple = boneConnections[i]
 local x1, y1, z1 = Entity:GetBonePosition(boneTuple[1])
 local x2, y2, z2 = Entity:GetBonePosition(boneTuple[2])
 local sx1, sy1 = client.WorldToScreen(x1,y1,z1)
 local sx2, sy2 = client.WorldToScreen(x2,y2,z2)
 if sx1 and sx2 then
 draw.Line(sx1, sy1, sx2, sy2)
 end
 end
end

function EntityESP()
 local EntList = entities.FindByClass( "CBaseEntity" )
 for i = 1, #EntList do
 local Entity = EntList[i]
 local Class = Entity:GetClass()
 local Name = Entity:GetPropString("m_iName")
 local WOx, WOy, WOz = Entity:GetAbsOrigin()
 if (WOx and WOy and WOz) then
 draw.Color( 255, 255, 255, 255 );
 local SOx, SOy = client.WorldToScreen(WOx, WOy, WOz)
 if (SOx and SOy) then
 if (PropESPO:GetValue() ~= 0) and (Class == "CPhysicsPropMultiplayer" or Class == "CPhysicsProp") then
 PropESP(Entity)
 elseif BreakableESPO:GetValue() and Class == "CDynamicProp" then
 if (Entity:GetProp("m_flPlaybackRate") == 0) and (not Entity:GetPropEntity("moveparent")) then
 BreakableESP(Entity)
 end
 elseif DoorESPO:GetValue() and Class == "CPropDoorRotating" then
 DoorESP(Entity)
 elseif Class == "CChicken" then
 if ChickenESPO:GetValue() ~= 0 then
 ChickenESP(Entity)
 end
 if ChickenChamsO:GetValue() then
 local clr = RGB2clr(math.floor(ChickenR:GetValue()), math.floor(ChickenG:GetValue()), math.floor(ChickenB:GetValue()))
 Entity:SetProp("m_nSkin", 0)
 Entity:SetProp("m_clrRender", clr)
 end
 if ChickenBonesO:GetValue() then
 ChickenBoneESP(Entity)
 end
 elseif WindowESPO:GetValue() and (Class == "CBaseEntity") then
 if Name == "" and (Entity:GetPropInt("m_nRenderMode") ~= 0) then
 WindowESP(Entity)
 end
 -- else
 -- print(Class)
 -- DrawText(SOx, SOy, Class, 3); -- in case you want to add more objects, you can easily see all CBaseEntities this way
 end 
 end
 end
 end
end

function RagdollESP()
 local Players = entities.FindByClass( "CCSPlayer" );
 for i = 1, #Players do
 local Player = Players[i];
 if not Player:IsAlive() then
 local ragdoll = Player:GetPropEntity("m_hRagdoll");
 if (ragdoll) then
 local rOx, rOy, rOz = ragdoll:GetBonePosition( 8 );
 local Rx, Ry = client.WorldToScreen(rOx, rOy, rOz);
 if (Rx and Ry) then
 local name = "*DEAD* " .. client.GetPlayerNameByIndex(Player:GetIndex());
 DrawText(Rx, Ry, name, 9);
 end
 end
 end
 end
end

function DrawCallback()
 draw.Color( 255, 255, 255, 255 );
 if FishESPO:GetValue() then FishESP() end
 if RagdollESPO:GetValue() then RagdollESP() end
 EntityESP()
end

callbacks.Register( "Draw", "DrawCallback", DrawCallback );