local version = "version 2.0"
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

oReference = oReference or gui.Reference 

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
				return
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


if not lualoaderFolderExists() then
	file.Open("lualoader/temp/temp.txt", "w"):Close()
	file.Delete("lualoader/temp/temp.txt")
	
	file.Open("lualoader/downloads/temp.txt", "w"):Close()
	file.Delete("lualoader/downloads/temp.txt")
end

ClearTempLuas()

local lualoader_tab = gui.Tab(gui.Reference("Settings"), "chicken.lualoader.tab", "Lua loader")
local readme_gb = gui.Groupbox(lualoader_tab, "README", 10, 10, 610, 0)



local redme_text = gui.Text(readme_gb, readme)
http.Get("https://raw.githubusercontent.com/Aimware0/LuaLoader/main/README.md", function(content)
	redme_text:SetText(content)
end)


local function GO_SetSize(GO, width, height)
	GO:SetWidth(width)
	GO:SetHeight(height)
end

local function GO_SetPos(GO, width, height)
	GO:SetPosX(width)
	GO:SetPosY(height)
end


local y_pos_counter = 145
local script_boxes = {}


local function CreateScriptBox(script_name, author, script_url, thread_url)
	local script_box = {}
		
	local script_box_gb = gui.Groupbox(lualoader_tab, "        " .. script_name, 10, y_pos_counter, 610, 0)
	
	script_box.autorun_cb = gui.Checkbox(script_box_gb, "chicken.lualoader.checkbox", "", false)
	
	GO_SetPos(script_box.autorun_cb, 0, -36)
	GO_SetSize(script_box.autorun_cb, 22, 22)
	
	local forum_link = gui.Button(script_box_gb, "Forum thread", function()
		 panorama.RunScript('SteamOverlayAPI.OpenExternalBrowserURL("' .. string.gsub(thread_url, "[\r\n]", "") .. '")')
	end)
	
	local script_link = gui.Button(script_box_gb, "Script link", function()
		 panorama.RunScript('SteamOverlayAPI.OpenExternalBrowserURL("' .. string.gsub(script_url, "[\r\n]", "") .. '")')
	end)
	
	GO_SetPos(forum_link, 370,-42)
	GO_SetSize(forum_link, 100, 20)
	
	GO_SetPos(script_link, 480,-42)
	GO_SetSize(script_link, 100, 20)

	
	local author_text = gui.Text(script_box_gb, "Author: " .. author)
	
	
	script_box.downloads_path = "lualoader/downloads/" .. get_thread_id(thread_url) .. ".lua"
	script_box.temp_path = "lualoader/temp/temp" .. get_thread_id(thread_url) .. ".lua"
	---------------------

	script_box.run_btn = gui.Button(script_box_gb, "Run", function()
		print("RUN CALLED!")
		http.Get(script_url, function(content)
			last_script_loaded = script_name
			LoadScript(script_box.downloads_path)
			script_box.running = true
		end)
	end)	

	script_box.temp_run_btn = gui.Button(script_box_gb, "Temp run", function() 
		http.Get(script_url, function(content)
			last_script_loaded = script_name
			print("TEMP CALLED!")
			local f = file.Open(script_box.temp_path, "w")
			f:Write(content)
			f:Close()
			LoadScript(script_box.temp_path)
			script_box.running = true
		end)
	end)
	
	
	
	script_box.unload_btn = gui.Button(script_box_gb, "Unload", function()
		UnloadScript(script_box.temp_path)
		file.Delete(script_box.temp_path)
		script_box.running = false	
	end)
	
	
	---------------------
	
	
	---------------------
	
	script_box.download_btn = gui.Button(script_box_gb, "Download", function()
		http.Get(script_url, function(content)
			local f = file.Open(script_box.downloads_path, "w")
			f:Write(content)
			f:Close()
			script_box.downloaded = true
		end)
	end)
	
	script_box.uninstall_btn = gui.Button(script_box_gb, "Uninstall", function()
		script_box.downloads_path = "lualoader/downloads/" .. get_thread_id(thread_url) .. ".lua"
		file.Delete(script_box.downloads_path)
		script_box.downloaded = false
	end)
	---------------------
	
	GO_SetSize(script_box.temp_run_btn, 220, 25); GO_SetSize(script_box.unload_btn, 220, 25); GO_SetSize(script_box.run_btn, 220, 25)
	GO_SetSize(script_box.download_btn, 220, 25); GO_SetSize(script_box.uninstall_btn, 220, 25)
	
	GO_SetPos(script_box.temp_run_btn, 130, -7); GO_SetPos(script_box.unload_btn, 130, -7); GO_SetPos(script_box.run_btn, 130, -7)
	GO_SetPos(script_box.download_btn, 360, -7); GO_SetPos(script_box.uninstall_btn, 360, -7)
	
	
	
	y_pos_counter = y_pos_counter + 90
	
	script_box.downloaded = false
	script_box.running = false
	
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

callbacks.Register("Draw", "Chicken.lualoader.UI", function()
	for k, script_box in pairs(script_boxes) do
		script_box.run_btn:SetInvisible(script_box.running and not script_box.downloaded)
		script_box.temp_run_btn:SetInvisible(script_box.running or script_box.downloaded)
		script_box.unload_btn:SetInvisible(not script_box.running)
		
		script_box.download_btn:SetInvisible(script_box.downloaded)
		script_box.uninstall_btn:SetInvisible(not script_box.downloaded)
		
		
		script_box.autorun_cb:SetDisabled(not script_box.downloaded)
		
	end
end)


local UNLOAD_ALL = gui.Button(lualoader_tab, "Unload all", function()
	for k, script_box in pairs(script_boxes) do
		if script_box.running then
			UnloadScript(script_box.temp_path)
			UnloadScript(script_box.download_path)
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
			UnloadScript(script_box.path)
		end
	end
	ClearTempLuas()
end)


