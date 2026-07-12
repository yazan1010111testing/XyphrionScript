local license = ... or {}
license.Key = script_key or license.Key or nil
repeat task.wait() until game:IsLoaded()
if shared.xyphrion then shared.xyphrion:Uninject() end

local xyphrion
-- Store the real loadstring before we override it
local realLoadstring = getfenv().loadstring or loadstring
local customLoadstring = function(...)
	local res, err = realLoadstring(...)
	if err and xyphrion then
		xyphrion:CreateNotification('Xyphrion', 'Failed to load : '..err, 30, 'alert')
	end
	return res, err
end
local queue_on_teleport = queue_on_teleport or function() end
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end
local cloneref = cloneref or function(obj)
	return obj
end
local playersService = cloneref(game:GetService('Players'))
local httpService = cloneref(game:GetService('HttpService'))

local redirect = function()
	local body = httpService:JSONEncode({
		nonce = httpService:GenerateGUID(false),
		args = {
			invite = {code = 'xyphrion'},
			code = 'xyphrion'
		},
		cmd = 'INVITE_BROWSER'
	})

	for i = 1, 2 do
		task.spawn(request, {
			Method = 'POST',
			Url = 'http://127.0.0.1:6463/rpc?v=1',
			Headers = {
				['Content-Type'] = 'application/json',
				Origin = 'https://discord.com'
			},
			Body = body
		})
	end
end

local function downloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/yazan1010111testing/XyphrionScript/main/'..select(1, path:gsub('xyphrion/', '')), true)
		end)
		if not suc or res == '404: Not Found' then
			task.spawn(error, res)
		end
		if suc then
			if path:find('.lua') then
				res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after Xyphrion updates.\n'..res
			end
			writefile(path, res)
		end
	end
	return (func or readfile)(path)
end

local function finishLoading()
	xyphrion.Init = nil
	xyphrion:Load()
	task.spawn(function()
		repeat
			xyphrion:Save()
			task.wait(10)
		until not xyphrion.Loaded
	end)

	local teleportedServers
	xyphrion:Clean(playersService.LocalPlayer.OnTeleport:Connect(function(state)
		if (not teleportedServers) and (not shared.XyphrionIndependent) then
			teleportedServers = true
			local teleportScript = [[
				shared.xyphrionreload = true
				if shared.XyphrionDeveloper then
					loadstring(readfile('xyphrion/main.lua'), 'main')(_scriptconfig)
				else
					loadstring(game:HttpGet('https://raw.githubusercontent.com/yazan1010111testing/XyphrionScript/main/init.lua'), 'init')(_scriptconfig)
				end
			]]
			local teleportConfig = httpService:JSONEncode(license)
			teleportConfig = teleportConfig:gsub('":true', "=true"):gsub('{"', '{')
			teleportConfig = teleportConfig:gsub(',"', ','):gsub('":', '=')
			teleportConfig = teleportConfig:gsub('%[', '{'):gsub('%]', '}')
			teleportScript = teleportScript:gsub('_key', tostring(license.Key or '_key'))
			teleportScript = teleportScript:gsub('_scriptconfig', teleportConfig)
			if identifyexecutor() == 'Potassium' then
				teleportScript = 'task.wait(12)\n'.. teleportScript
			end
			if shared.XyphrionDeveloper then
				teleportScript = 'shared.XyphrionDeveloper = true\n'..teleportScript
			end
			if shared.XyphrionCustomProfile then
				teleportScript = 'shared.XyphrionCustomProfile = "'..shared.XyphrionCustomProfile..'"\n'..teleportScript
			end
			queue_on_teleport(teleportScript)
		end
	end))

	if not xyphrion.Categories then return end
	if xyphrion.Categories.Main.Options['GUI bind indicator'].Enabled then
		if not shared.xyphrionreload then
			xyphrion:CreateNotification('Finished Loading', 'Welcome '..getgenv().xyphrionname..', Press '..table.concat(xyphrion.Keybind, ' + '):upper()..' to open GUI', 5)
			task.delay(0.05 + cloneref(game:GetService('RunService')).PostSimulation:Wait(), function()
				if shared.updated then
					xyphrion:CreateNotification('Xyphrion', `Script has updated from {shared.updated} to {readfile('xyphrion/profiles/commit.txt')}`, 10, 'info')
				end
			end)
		end
	end
end

if not isfile('xyphrion/profiles/gui.txt') then
	writefile('xyphrion/profiles/gui.txt', 'new')
end
local gui = 'new'--readfile('xyphrion/profiles/gui.txt')

if not isfolder('xyphrion/assets/'..gui) then
	makefolder('xyphrion/assets/'..gui)
end
if not isfile('xyphrion/profiles/commit.txt') then
	writefile('xyphrion/profiles/commit.txt', 'main')
end

getgenv().used_init = true
xyphrion = realLoadstring(downloadFile('xyphrion/guis/'..gui..'.lua'), 'gui')(license)
_G.xyphrion = xyphrion
shared.xyphrion = xyphrion

if shared.mainxyphrion then
	redirect()
	playersService.LocalPlayer:Kick('Your script is outdated, Get new one at discord.gg/xyphrion')
	return
end

if not shared.XyphrionIndependent then
	-- Work.ink Authentication
	local WorkInkAuth = realLoadstring(downloadFile('xyphrion/libraries/workink_auth.lua'), 'workink_auth')()
	local authenticated, message, key = WorkInkAuth:Authenticate()
	
	if not authenticated then
		if xyphrion then
			xyphrion:CreateNotification('Xyphrion', message, 30, 'alert')
		end
		playersService.LocalPlayer:Kick('Authentication required: '..message)
		return
	end
	
	-- Store authenticated user info
	getgenv().xyphrionkey = key
	getgenv().xyphrionname = playersService.LocalPlayer.Name
	getgenv().xyphrionrole = 'Premium'
	
	realLoadstring(downloadFile('xyphrion/games/universal.lua'), 'universal')(license)
	if isfile('xyphrion/games/'..game.PlaceId..'.lua') then
		realLoadstring(readfile('xyphrion/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))(license)
	else
		if not shared.XyphrionDeveloper then
			local suc, res = pcall(function()
				return game:HttpGet('https://raw.githubusercontent.com/yazan1010111testing/XyphrionScript/main/games/'..game.PlaceId..'.lua', true)
			end)
			if suc and res ~= '404: Not Found' then
				realLoadstring(downloadFile('xyphrion/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))(license)
			end
		end
	end
	finishLoading()
else
	xyphrion.Init = finishLoading
	return xyphrion
end