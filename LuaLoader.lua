local version = "VERSION 2.142"
local version_url = "https://raw.githubusercontent.com/Aimware0/LuaLoader/main/version.txt"

-- pasted functions
local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end
-- end of paste

function get_thread_id(thread_link)
	return split(thread_link, "/")[5]
end


local last_script_loaded = ''

local function pprint(...)
	print("[LuaLoader]", last_script_loaded, ...)
end

-- Update
http.Get(version_url, function(content)
	if version == string.gsub(content, "[\r\n]", "") then
		print("[LuaLoader] is up to date")
	else
        local new_version = http.Get("https://raw.githubusercontent.com/Aimware0/LuaLoader/main/LuaLoader.lua");
        local old = file.Open(GetScriptName(), "w")
        old:Write(new_version)
        old:Close()
		
		print("[LuaLoader] updated")
		UnloadScript(GetScriptName())
	end
end)

local function RemoveLineFromMultiLine(MultiLine, LineToRemove)
	return string.gsub(MultiLine, LineToRemove .. "\n", "")
end

oReference = oReference or gui.Reference -- For printing out references that other scripts use, makes it easier to find where the scripts are located in the aimware ui
function gui.Reference(...)
	pprint(...)
	return oReference(...)
end

local function lualoaderFolderExists()
	local exists = false
	file.Enumerate(function(fname)
		if string.match(fname, "/") then
			if string.sub(fname, 1, 9) == "lualoader" then
				exists = true
			end
		end
	end)
	return exists
end

local function ClearTempLuas()
	file.Enumerate(function(fname)
		if string.sub(fname, 1, 15) == "lualoader/temp/" then
			file.Delete(fname)
		end
	end)
end


local temp_path = "lualoader/temp"
local downloads_path = "lualoader/downloads"
local autorun_file = "lualoader/autorun.txt"

if not lualoaderFolderExists() then
	local path = temp_path .. "/temp.txt"
	file.Open(path, "w"):Close()
	file.Delete(path)
	
	path = downloads_path .. "/temp.txt"
	file.Open(path, "w"):Close()
	file.Delete(path)
	
	file.Open(autorun_file, "w"):Close()
end

ClearTempLuas()


local lualoader_tab = gui.Tab(gui.Reference("Settings"), "Chicken.lualoader.tab", "Lua loader")


local readme_gb = gui.Groupbox(lualoader_tab, "README | " .. version, 10, 10, 610, 0)
local redme_text = gui.Text(readme_gb, readme)
http.Get("https://raw.githubusercontent.com/Aimware0/LuaLoader/main/README.md", function(content)
	redme_text:SetText(content)
end)

local search_entry = gui.Editbox(lualoader_tab, "Chicken.lualoader.search", "Search")
search_entry:SetPosX(15)
search_entry:SetWidth(600)


local function GO_SetSize(GO, width, height)
	GO:SetWidth(width)
	GO:SetHeight(height)
end

local function GO_SetPos(GO, width, height)
	GO:SetPosX(width)
	GO:SetPosY(height)
end

local function add_temp_lua(script_url, id)
	local path = temp_path .. "/" .. id .. ".lua"
	http.Get(script_url, function(content)
		local f = file.Open(path, "w")
		f:Write(content)
		f:Close()
		LoadScript(path)
	end)
end

local function remove_temp_lua(id)
	local path = temp_path .. "/" .. id .. ".lua"
	UnloadScript(path)
	file.Delete(path)
end

local function add_downlaod_lua(script_url, id)
	http.Get(script_url, function(content)
		local f = file.Open(downloads_path .. "/" .. id .. ".lua" , "w")
		f:Write(content)
		f:Close()
		script_box.downloaded = true
	end)
end

local function remove_downloaded_lua(id)
	local path = downloads_path .. "/" .. id .. ".lua"
	file.Delete(path)
	UnloadScript(path)
end

local function add_to_autorun(lua)
	if not string.match(file.Read("lualoader/autorun.txt"), lua) then
		local f = file.Open("lualoader/autorun.txt", "a")
		f:Write(lua .. ".lua\n")
		f:Close()
	end
end

local function remove_from_autorun(lua)
	local new_autorun = RemoveLineFromMultiLine(file.Read("lualoader/autorun.txt"), lua .. ".lua")
	local f = file.Open("lualoader/autorun.txt", "w")
	f:Write(new_autorun)
	f:Close()
end

local function should_autorun(id)
	return string.match(file.Read("lualoader/autorun.txt"), id)
end

local function is_downloaded(id)
	local downloaded = false
	file.Enumerate(function(fname)
		if string.match(fname, "/") then
			if string.sub(fname, 1, 19) == "lualoader/downloads" then
				if string.match(fname, id) then
					downloaded = true
				end	
			end
		end
	end)
	return downloaded
end


local y_pos_counter = 230
local script_boxes = {}

local function CreateScriptBox(script_name, author, script_url, thread_url, display)
	local script_box = {GO_objects = {}}
	
	-- Script data
	script_box.script_name = script_name
	script_box.author = author
	script_box.script_url = script_url
	script_box.thread_url = thread_url
	
	script_box.GO_objects.header_gb = gui.Groupbox(lualoader_tab, "        " .. script_name, 10, y_pos_counter, 610, 0)

	script_box.GO_objects.autorun_cb = gui.Checkbox(script_box.GO_objects.header_gb, "Chicken.lualoader.checkbox", "", false)
	script_box.oautorun_cb_v = script_box.GO_objects.autorun_cb:GetValue()
	
	script_box.id = get_thread_id(thread_url)

	script_box.running = false
		
	script_box.autorun = should_autorun(script_box.id)
	
	script_box.GO_objects.autorun_cb:SetValue(script_box.autorun)

	script_box.downloaded = is_downloaded(script_box.id)
	
	
	GO_SetPos(script_box.GO_objects.autorun_cb, 0, -36)
	GO_SetSize(script_box.GO_objects.autorun_cb, 22, 22)
	
	
	local forum_link = gui.Button(script_box.GO_objects.header_gb, "Forum thread", function()
		 panorama.RunScript('SteamOverlayAPI.OpenExternalBrowserURL("' .. string.gsub(thread_url, "[\r\n]", "") .. '")')
	end)
	
	GO_SetPos(forum_link, 370,-42)
	GO_SetSize(forum_link, 100, 20)
	

	local script_link = gui.Button(script_box.GO_objects.header_gb, "Script link", function()
		 panorama.RunScript('SteamOverlayAPI.OpenExternalBrowserURL("' .. string.gsub(script_url, "[\r\n]", "") .. '")')
	end)
	
	GO_SetPos(script_link, 480,-42)
	GO_SetSize(script_link, 100, 20)

	local author_text = gui.Text(script_box.GO_objects.header_gb, "Author: " .. author)

	
	script_box.downloads_path = "lualoader/downloads/" .. script_box.id .. ".lua"
	script_box.temp_path = "lualoader/temp/" ..script_box.id .. ".lua"

	script_box.GO_objects.run_btn = gui.Button(script_box.GO_objects.header_gb, "Run", function()
		LoadScript(script_box.downloads_path)
		script_box.running = true
	end)
	
	
	script_box.GO_objects.temp_run_btn = gui.Button(script_box.GO_objects.header_gb, "Temp run", function() 
		add_temp_lua(script_url, script_box.id)
		
		last_script_loaded = script_name
		script_box.running = true
	end)
	

	script_box.GO_objects.unload_btn = gui.Button(script_box.GO_objects.header_gb, "Unload", function()
		UnloadScript(script_box.downloads_path)
		
		remove_temp_lua(script_box.id)
		script_box.running = false	
	end)
	
	---------------------------------------------------------------------------------------------------------
	
	script_box.GO_objects.download_btn = gui.Button(script_box.GO_objects.header_gb, "Download", function()
		add_downlaod_lua(script_url, script_box.id)
		script_box.downloaded = true
	end)
	
	script_box.GO_objects.uninstall_btn = gui.Button(script_box.GO_objects.header_gb, "Uninstall", function()
		remove_downloaded_lua(script_box.id)
		
		script_box.downloaded = false
		script_box.running = false
		if script_box.autorun then
			remove_from_autorun(script_box.id)
			script_box.GO_objects.autorun_cb:SetValue(false)
		end
	end)
	
	
	GO_SetSize(script_box.GO_objects.temp_run_btn, 220, 25); GO_SetSize(script_box.GO_objects.unload_btn, 220, 25); GO_SetSize(script_box.GO_objects.run_btn, 220, 25)
	GO_SetSize(script_box.GO_objects.download_btn, 220, 25); GO_SetSize(script_box.GO_objects.uninstall_btn, 220, 25)
	
	GO_SetPos(script_box.GO_objects.temp_run_btn, 130, -7); GO_SetPos(script_box.GO_objects.unload_btn, 130, -7); GO_SetPos(script_box.GO_objects.run_btn, 130, -7)
	GO_SetPos(script_box.GO_objects.download_btn, 360, -7); GO_SetPos(script_box.GO_objects.uninstall_btn, 360, -7)
		
	y_pos_counter = y_pos_counter + 90
	if script_box.autorun then
		LoadScript(script_box.downloads_path)
		script_box.running = true
	end

		
	
		
	table.insert(script_boxes, script_box)	
end


http.Get("https://raw.githubusercontent.com/Aimware0/LuaLoader/main/luas.txt", function(content)
	local luas = split(content, "\n")
	for k, lua in pairs(luas) do
		local lua_data = split(lua, ",")
		local lua_thread_link = lua_data[1]
		local lua_author = lua_data[2]
		local lua_name = lua_data[3]
		local lua_url = lua_data[4]
		
		CreateScriptBox(lua_author, lua_name, lua_url, lua_thread_link)
	end
end)


local match = string.match
local lower = string.lower

function FilterScriptBoxes(filter)
	y_pos_counter = 230
	for k, script_box in pairs(script_boxes) do
		if filter(script_box.script_name, script_box.author, script_box.script_url, script_box.thread_url) then
			script_box.GO_objects.header_gb:SetInvisible(false)
			GO_SetPos(script_box.GO_objects.header_gb, 10, y_pos_counter)
			y_pos_counter = y_pos_counter + 90
		else
			script_box.GO_objects.header_gb:SetInvisible(true)
		end
	end
end

local oSearchValue = ""
callbacks.Register("Draw", "Chicken.lualoader.UI", function()
	local search_value = string.lower(search_entry:GetValue())
	if search_value ~= oSearchValue then
		FilterScriptBoxes(function(script_name, script_author, script_url, script_thread_url)
			return match(lower(script_name), search_value) or match(lower(script_author), search_value)
		end)
		oSearchValue = search_value
	end
	
	for k, script_box in pairs(script_boxes) do
		script_box.GO_objects.run_btn:SetInvisible(script_box.running or not script_box.downloaded)
		
		script_box.GO_objects.temp_run_btn:SetInvisible(script_box.running or script_box.downloaded)
		script_box.GO_objects.unload_btn:SetInvisible(not script_box.running)
		
		script_box.GO_objects.download_btn:SetInvisible(script_box.downloaded)
		script_box.GO_objects.uninstall_btn:SetInvisible(not script_box.downloaded)
		
		
		script_box.GO_objects.autorun_cb:SetDisabled(not script_box.downloaded)
		
		-- if script_box.id == match(script_box.id, "144909") then
			-- print(script_box.downloaded)
		-- end
		
		if script_box.GO_objects.autorun_cb:GetValue() ~= script_box.oautorun_cb_v then
			
			if script_box.GO_objects.autorun_cb:GetValue() then
				add_to_autorun(script_box.id)
				script_box.autorun = true
			else
				remove_from_autorun(script_box.id)
				script_box.autorun = false
			end

			script_box.oautorun_cb_v = script_box.GO_objects.autorun_cb:GetValue()
		end
	end
end)


local UNLOAD_ALL = gui.Button(lualoader_tab, "Unload all", function()
	for k, script_box in pairs(script_boxes) do
		if script_box.running then
			UnloadScript(script_box.temp_path)
			UnloadScript(script_box.downloads_path)
			script_box.running = false
		end
	end
	ClearTempLuas()
end)

GO_SetPos(UNLOAD_ALL, 545, 21)
GO_SetSize(UNLOAD_ALL, 65, 15)

callbacks.Register("Unload", "Chicken.lualoader.unloadluas", function()
	for k, script_box in pairs(script_boxes) do
		if script_box.running then
			UnloadScript(script_box.temp_path)
			UnloadScript(script_box.downloads_path)
		end
	end
	ClearTempLuas()
end)
