-- Scraped by chicken
-- Author: owen
-- Title [Release] Better Sound ESP
-- Forum link https://aimware.net/forum/thread/104179

local m_rings = {}
local main_container = gui.Reference( 'VISUALS', 'MISC', 'Assistance' )
local team_container = gui.Reference( 'VISUALS', 'TEAMMATES', 'Filter' )
local enemy_container = gui.Reference( 'VISUALS', 'ENEMIES', 'Filter')
local main_checkbox = gui.Checkbox( main_container, 'bs_enable', 'Better Sound ESP', false )
local team_checkbox = gui.Checkbox( team_container, 'bs_team_enable', 'Better Sounds', false)
local enemy_checkbox = gui.Checkbox( enemy_container, 'bs_enemy_enable', 'Better Sounds', false)

local function Render3DCircle( posX, posY, posZ, rad, res, r, g, b, a )
    local vertices = {}
    local max_radias = math.pi * 2
    local step = max_radias / res

    for a = 0, max_radias, step do
        local ptX, ptY, ptZ, scrX, scrY
       
        ptX = ( rad * math.cos( a ) ) + posX
        ptY = ( rad * math.sin( a ) ) + posY
        ptZ = posZ 

        scrX, scrY = client.WorldToScreen( ptX, ptY, ptZ )
        
        if scrX ~= 0 and scrY ~= 0 then
            vertices[#vertices + 1] = { x = scrX, y = scrY }
        end
    end

    for i = #vertices, 1, -1 do
        local next = i - 1

        if i == 1 then
            next = #vertices
        end

        draw.Color( r, g, b, a )
        draw.Line( vertices[i].x, vertices[i].y, vertices[next].x, vertices[next].y )
    end
end

local function PushbackRing( e )
    local ent = entities.GetByUserID( e:GetInt( 'userid' ) )
    local localPlayer = entities.GetLocalPlayer( )
    
    if ent == nil or ent:IsAlive( ) ~= true then 
        return
    end

    if ent:GetIndex( ) == localPlayer:GetIndex( ) then 
        return 
    end

    if ent:GetTeamNumber( ) == localPlayer:GetTeamNumber( ) and team_checkbox:GetValue( ) == false then
        return
    end

    if ent:GetTeamNumber( ) ~= localPlayer:GetTeamNumber( ) and enemy_checkbox:GetValue( ) == false then
        return
    end

    local vX, vY, vZ = ent:GetAbsOrigin( )
    local fc = globals.FrameCount( )

    m_rings[#m_rings + 1] = {
        pos = { x = vX, y = vY, z = vZ },  
        framecount = iFrameCount,
        alpha = 255,
        framecount = fc,
        currentRadius = 0,
        endRadius = 100
    }
end

local function RenderRings( )
    for ind = #m_rings, 1, -1 do 
        if m_rings[ind] == nil then 
            return
        end

        local curRing = m_rings[ind]
        
        if curRing.currentRadius == curRing.endRadius then
            table.remove( m_rings, ind )
            return
        end

        local timeSince = globals.FrameCount( ) - curRing.framecount

        if timeSince % 5 == 0 then
            curRing.currentRadius = curRing.currentRadius + 2
            curRing.alpha = 255 - ( ( 255 / curRing.endRadius ) * curRing.currentRadius )
        end

        Render3DCircle( curRing.pos.x, curRing.pos.y, curRing.pos.z, curRing.currentRadius, 30, 255, 255, 255, curRing.alpha )
    end
end

callbacks.Register( 'FireGameEvent', function( e )
    if main_checkbox:GetValue( ) == false then
        return
    end

    local localPlayer = entities.GetLocalPlayer( )

    if ( e == nil or localPlayer == nil ) then
        return
    end

    if e:GetName( ) == 'player_hurt' or 'player_jump' or 'player_footstep' or 'player_falldamage' or 'weapon_fire' then
        PushbackRing( e )
    end
end )

callbacks.Register( 'Draw', function( )
    if main_checkbox:GetValue( ) == false then
        return
    end

    RenderRings( )
end )

client.AllowListener( 'player_hurt' )
client.AllowListener( 'player_jump' )
client.AllowListener( 'player_footstep' )
client.AllowListener( 'player_falldamage' )



