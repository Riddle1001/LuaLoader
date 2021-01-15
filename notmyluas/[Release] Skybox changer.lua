-- Scraped by chicken
-- Author: ChemicalLabrat
-- Title [Release] Skybox changer
-- Forum link https://aimware.net/forum/thread/89798

local msc_ref = gui.Reference( "MISC", "Part 1" );
local lua_combobox = gui.Combobox( msc_ref, "lua_skyboxppicker", "Skybox picker",
      "Galaxy", "Bartuc Canyon", "Bartuc Grey", 
      "Blue One", "Blue Two", "Blue Three", "Blue Four", "Blue Five", "Blue Six", 
      "Css Default", 
      "Dark One", "Dark Two", "Dark Three", "Dark Four", "Dark Five", 
      "Extreme Glaciation", 
      "Green One", "Green Two", "Green Three", "Green Four", "Green Five", "Green Screen",
      "Grey Sky", 
      "Night One", "Night Two", "Night Three", "Night Four", "Night Five",
      "Orange One", "Orange Two", "Orange Three", "Orange Four", "Orange Five", "Orange Six", 
      "Persistent Fog", 
      "Pink One", "Pink Two", "Pink Three", "Pink Four", "Pink Five",
      "Polluted", "Toxic", "Water Sunset" );



function SkyBox()
 draw.SetFont( debugFont );
 local skybox_old = client.GetConVar("sv_skyname"); 
 local skybox_new = (lua_combobox:GetValue());
 
  if ( skybox_new == 0 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "******")
   
  elseif (skybox_new == 1 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "bartuc_canyon_")
   
  elseif (skybox_new == 2 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "bartuc_grey_sky_")  
   
  elseif (skybox_new == 3 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "blue1")
        
  elseif (skybox_new == 4 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "blue2")
         
  elseif (skybox_new == 5 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "blue3")
       
  elseif (skybox_new == 6 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "blue4")
        
  elseif (skybox_new == 7 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "blue5")
        
  elseif (skybox_new == 8 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "blue6")
        
  elseif (skybox_new == 9 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "cssdefault")
        
  elseif (skybox_new == 10 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "dark1")
        
  elseif (skybox_new == 11 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "dark2")
        
  elseif (skybox_new == 12 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "dark3")
        
  elseif (skybox_new == 13 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "dark4")
        
  elseif (skybox_new == 14 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "dark5")
        
  elseif (skybox_new == 15 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "extreme_glaciation_")
        
  elseif (skybox_new == 16 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "green1")
        
  elseif (skybox_new == 17 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "green2")
        
  elseif (skybox_new == 18 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "green3")
        
  elseif (skybox_new == 19 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "green4")
        
  elseif (skybox_new == 20 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "green5")
        
  elseif (skybox_new == 21 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "greenscreen")
        
  elseif (skybox_new == 22 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "greysky")
        
  elseif (skybox_new == 23 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "night1")
        
  elseif (skybox_new == 24 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "night2")
        
  elseif (skybox_new == 25 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "night3")
        
  elseif (skybox_new == 26 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "night4")
        
  elseif (skybox_new == 27 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "night5")
        
  elseif (skybox_new == 28 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "orange1")
        
  elseif (skybox_new == 29 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "orange2")
        
  elseif (skybox_new == 30 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "orange3")
        
  elseif (skybox_new == 31 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "orange4")
        
  elseif (skybox_new == 32 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "orange5")
         
  elseif (skybox_new == 33 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "orange6")
        
  elseif (skybox_new == 34 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "persistent_fog_")
        
  elseif (skybox_new == 35 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "pink1")
        
  elseif (skybox_new == 36 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "pink2")
        
  elseif (skybox_new == 37 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "pink3")
        
  elseif (skybox_new == 38 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "pink4")
        
  elseif (skybox_new == 39 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "pink5")
   
  elseif (skybox_new == 40 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "polluted_atm_") 
        
  elseif (skybox_new == 41 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "toxic_atm_")
        
  elseif (skybox_new == 42 and gui.GetValue("msc_restrict") ~= 1) then
   client.SetConVar("sv_skyname" , "water_sunset_")
    
     
  end

end

callbacks.Register("Draw", "SkyBox", SkyBox)
callbacks.Register( "Draw", "LuaGuiTest", OnDraw );




