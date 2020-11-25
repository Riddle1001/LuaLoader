-- Scraped by chicken
-- Author: stacky
-- Title [Release] Delayed Call
-- Forum link https://aimware.net/forum/thread/141807

local function some_func()
    print("This will be printed after 5.5 seconds.")
end

DelayedCall(2.5, function()
    print("This will be printed after 2.5 seconds.")
end )

DelayedCall(5.5, some_func)
