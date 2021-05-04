-- Scraped by chicken
-- Author: GTX5700XT
-- Title [Release] Chat messages repeater
-- Forum link https://aimware.net/forum/thread/149533

local function UserMessageCallback( msg )

  -- CS_UM_SayText2
  if msg:GetID() == 6 then

    -- CCSUsrMsg_SayText2.ent_idx
    local index = msg:GetInt( 1 );

    -- CCSUsrMsg_SayText2.params
    local message = msg:GetString( 4, 1 );

    local name = client.GetPlayerNameByIndex( index );

    print( name .. " says: " .. message );

 local original = message

local words = {}
for v in original:gmatch("%w+") do
  words[#words + 1] = v
end
function changeCase(str)
  local u = ""
  for i = 1, #str do
    if i % 2 == 1 then
      u = u .. string.upper(str:sub(i, i))
    else
      u = u .. string.lower(str:sub(i, i))
    end
  end
  return u
end
for i,v in ipairs(words) do
  words[i] = changeCase(v)
end
local result = table.concat(words, " ")
client.ChatSay(result);

  end

end

callbacks.Register( "DispatchUserMessage", "UserMessageExample", UserMessageCallback );