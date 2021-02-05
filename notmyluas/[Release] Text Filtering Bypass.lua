-- Scraped by chicken
-- Author: 90D5p33D
-- Title [Release] Text Filtering Bypass
-- Forum link https://aimware.net/forum/thread/139091

callbacks.Register("SendStringCmd",function(cmd)ifstring.find(cmd:Get(),"say")==1thenpreby1=cmd:Get():gsub("say","")preby2=preby1:gsub('"',"")bypassed=preby2:gsub(".","%1　")cmd:Set("say"..bypassed)endend)

