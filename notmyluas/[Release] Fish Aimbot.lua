-- Scraped by chicken
-- Author: _^^
-- Title [Release] Fish Aimbot
-- Forum link https://aimware.net/forum/thread/147606

callbacks.Register("CreateMove",function(cmd)
  for k,v in pairs(entities.FindByClass("CFish")) do
    v:SetProp('m_angle',math.random(-180,180))
 end
end)


fish antiaim :)



