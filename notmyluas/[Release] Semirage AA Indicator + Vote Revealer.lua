-- Scraped by chicken
-- Author: tnmcmyte
-- Title [Release] Semirage AA Indicator + Vote Revealer
-- Forum link https://aimware.net/forum/thread/147209



local ref = gui.Tab(gui.Reference("Ragebot"), "SemiIndicators", "SemiIndicators");

--Anti-Aims
local guiAntiaimBlock = gui.Groupbox(ref, "Indicator", 16, 16, 250, 250);
local guiAntiaimSwitchKey = gui.Keybox(guiAntiaimBlock , "aaswitchkey", "Switch Key", 70);
local guiArrowsColor = gui.ColorPicker(guiAntiaimBlock, "arrowscolorpicker", "Arrows Color", 255, 0, 0, 255);

--Misc Func
local guiMiscBlock = gui.Groupbox(ref, "Misc", 280, 16, 250, 250);
local guiVoteRevealer = gui.Checkbox(guiMiscBlock, "voterevealerkey", "Vote Revealer", 1);

--Some Vars
local screenCenterX, screenCenterY = draw.GetScreenSize();
screenCenterX = screenCenterX * 0.5;
screenCenterY = screenCenterY * 0.5;


local aaInverted = 0;

--User Cfg
local aMinDmg = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; 
local aBAim = { "", "", "", "", "", "", "", "", "", "", "" };
local wTypes = { 'shared', 'zeus', 'pistol', 'hpistol', 'smg', 'rifle', 'shotgun', 'scout', 'asniper', 'sniper', 'lmg' }

--Vote vars
local voteType = -1;
local voteResult = -1;
local tTimer = 0;
local voteTarget = "";
local voteName = { "", "", "", "", "", "", "", ""};
local voteVal = { "", "", "", "", "", "", "", ""};
local vIndex = 1;
--

local function VoteEnd(um)
 if um:GetID() == 46 then
 voteType = um:GetInt(3);
 voteTarget = um:GetString(5);
 if (string.len(voteTarget) > 20) then
 voteTarget = string.sub(voteTarget, 0, 15) .. "..."
 end
 
 elseif um:GetID() == 47 then
 tTimer = math.floor(globals.RealTime());
 voteResult = 1
 elseif um:GetID() == 48 then
 tTimer = math.floor(globals.RealTime());
 voteResult = 2
 end
end

local function VoteStart(e)
  if (e:GetName() == "vote_cast") then
 local index = e:GetInt("entityid");
 local vote = e:GetInt("vote_option");
    local name = client.GetPlayerNameByIndex(index)
    if (string.len(name) > 20) then
      name = string.sub(name, 0, 15) .. "..."
    end
 
 voteName[vIndex] = name;
 
 if vote == 0 then
 voteVal[vIndex] = "YES";
 elseif vote == 1 then
 voteVal[vIndex] = "NO";
 else
 voteVal[vIndex] = "N/A";
 end
 vIndex = vIndex + 1;
 
 if vIndex + 1 > 9 then
 vIndex = 1;
 end
  end
end

local function DrawVoteLogs()
 
 if string.len(voteVal[1]) < 1 or string.len(voteName[1]) < 1 or voteType == -1 then
 return;
 end
 
 if entities.GetLocalPlayer() == nil then
 voteResult = -1;
 voteType = -1;
 vIndex = 1;
 for i=1, #voteVal do
 voteVal[i] = "";
 voteName[i] = "";
 end
 end
 
 if not guiVoteRevealer:GetValue() then
 return;
 end
 
 local VotescreenCenterX, VotescreenCenterY = draw.GetScreenSize();
 VotescreenCenterY = VotescreenCenterY * 0.62;
 
 local voteFooterText = "";
 
 if voteType == 0 then
 voteFooterText = "Vote - Kick player: "..voteTarget;
 elseif voteType == 6 then
 voteFooterText = "Vote - Surrender";
 elseif voteType == 13 then
 voteFooterText = "Vote - Timeout";
 else
 voteFooterText = "Vote - Some shit :)";
 end
 
 draw.Color(255, 255, 255, 255);
 draw.TextShadow(35, VotescreenCenterY, voteFooterText);
 draw.FilledRect(35, VotescreenCenterY + 14, draw.GetTextSize(voteFooterText) + 35, VotescreenCenterY + 16);
 
 for i=1, #voteVal do
 
 if string.len(voteVal[i]) < 1 and string.len(voteName[i]) < 1 then
 break;
 end
 
 VotescreenCenterY = VotescreenCenterY + 25;
 draw.Color(255, 255, 255, 255);
 draw.TextShadow(35, VotescreenCenterY, "["..voteVal[i].."] "..voteName[i]);
 
 if voteVal[i] == "YES" then
 draw.Color(78, 217, 28, 255);
 elseif voteVal[i] == "NO" then
 draw.Color(217, 28, 28, 255);
 else
 draw.Color(191, 191, 191, 255);
 end
 
 draw.FilledRect(35, VotescreenCenterY + 14, draw.GetTextSize("["..voteVal[i].."] "..voteName[i]) + 35, VotescreenCenterY + 16);
 end 
 
 if voteResult == 1 or voteResult == 2 then
 if voteResult == 1 then
 draw.Color(78, 217, 28, 255);
 draw.TextShadow(35, VotescreenCenterY + 25, "Vote Result - Succesfull");
 elseif voteResult == 2 then
 draw.Color(217, 28, 28, 255);
 draw.TextShadow(35, VotescreenCenterY + 25, "Vote Result - Failed");
 end
 
 if math.floor(globals.RealTime()) > tTimer + 1.8 then
 voteResult = -1;
 voteType = -1;
 vIndex = 1;
 for i=1, #voteVal do
 voteVal[i] = "";
 voteName[i] = "";
 end
 end
 end
 
end

local function CustomDesync()
 local aaRMode = 0;
 local aaSide = 0;
 
 
 if guiAntiaimSwitchKey:GetValue() then
 if input.IsButtonPressed(guiAntiaimSwitchKey:GetValue()) then
 if aaInverted == 1 then
 aaInverted = 0;
 else
 aaInverted = 1;
 end
 end
 end
 
 if aaRMode == 1 then
 aaSide = 1 - aaInverted;
 else
 aaSide = aaInverted;
 end
end

local function DrawInfo()
 --Draw AA Arows
 draw.Color(46, 46, 46, 200);
 draw.Triangle(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8, screenCenterX + 50, screenCenterY - 7 + 15);
 draw.Triangle(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8, screenCenterX - 50, screenCenterY - 7 + 15);
 local r, g, b, a = guiArrowsColor:GetValue();
 draw.Color(r, g, b, a);
 
 if aaInverted == 1 then
 draw.Line(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8);
 draw.Line(screenCenterX + 50, screenCenterY - 7 + 15, screenCenterX + 65, screenCenterY - 7 + 8);
 else
 draw.Line(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8);
 draw.Line(screenCenterX - 50, screenCenterY - 7 + 15, screenCenterX - 65, screenCenterY - 7 + 8);
 end 
 --
 
 
end

local function BackupCfg()
 for i=1, #wTypes do
 aMinDmg[i] = gui.GetValue("rbot.accuracy.weapon."..wTypes[i]..".mindmg");
 aBAim[i] = gui.GetValue("rbot.hitscan.points."..wTypes[i]..".scale");
 end
end

BackupCfg(); --Store user cfg

client.AllowListener("vote_cast");
callbacks.Register("Draw", CustomDesync);
callbacks.Register("Draw", MiscFunctions);
callbacks.Register("Draw", DrawInfo);
--Vote rev
callbacks.Register("Draw", DrawVoteLogs);
callbacks.Register('FireGameEvent', VoteStart)
callbacks.Register("DispatchUserMessage", VoteEnd)

