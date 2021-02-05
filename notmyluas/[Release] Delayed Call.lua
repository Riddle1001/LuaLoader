-- Scraped by chicken
-- Author: stacky
-- Title [Release] Delayed Call
-- Forum link https://aimware.net/forum/thread/141807

localfunctionsome_func()
print("Thiswillbeprintedafter5.5seconds.")
end

DelayedCall(2.5,function()
print("Thiswillbeprintedafter2.5seconds.")
end)

DelayedCall(5.5,some_func)


