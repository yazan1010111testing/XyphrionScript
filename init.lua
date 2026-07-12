--!nocheck
-- Xyphrion Loader
local license = ... or {}
license.Key = script_key or license.Key

local cloneref = cloneref or function(ref) return ref end
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end

local downloader = Instance.new('TextLabel')
downloader.Size = UDim2.new(1, 0, 0, 40)
downloader.BackgroundTransparency = 1
downloader.TextStrokeTransparency = 0
downloader.TextSize = 20
downloader.TextColor3 = Color3.new(1, 1, 1)
downloader.Font = Enum.Font.Arial
downloader.Text = 'Initializing Xyphrion...'
downloader.Parent = Instance.new('ScreenGui', gethui and gethui() or cloneref(game:GetService('CoreGui')))

-- Create folders
for _, folder in {'xyphrion', 'xyphrion/games', 'xyphrion/profiles', 'xyphrion/assets', 'xyphrion/libraries', 'xyphrion/guis'} do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

if not isfile('xyphrion/profiles/commit.txt') then
	writefile('xyphrion/profiles/commit.txt', 'main')
end

downloader.Text = 'Downloading main script...'

-- Try to download main.lua
local success, mainScript = pcall(function()
	return game:HttpGet('https://raw.githubusercontent.com/yazan1010111testing/XyphrionScript/main/main.lua', true)
end)

if not success or not mainScript or mainScript == '' or mainScript == '404: Not Found' then
	downloader.Text = 'ERROR: Could not download main.lua'
	downloader.TextColor3 = Color3.new(1, 0, 0)
	task.wait(10)
	error('Failed to download main.lua from GitHub')
	return
end

downloader.Text = 'Saving main script...'
writefile('xyphrion/main.lua', mainScript)

downloader.Text = 'Loading Xyphrion...'

-- Use getfenv to get the real loadstring function
local realLoadstring = getfenv().loadstring or loadstring

-- Load and run main.lua
local mainFunction, loadError = realLoadstring(mainScript, 'main')

if not mainFunction then
	downloader.Text = 'ERROR: Failed to compile main.lua'
	downloader.TextColor3 = Color3.new(1, 0, 0)
	warn('Compilation error:', loadError)
	task.wait(10)
	error('Failed to compile main.lua: '..tostring(loadError))
	return
end

downloader.Text = ''

-- Execute main function with license
local execSuccess, execError = pcall(mainFunction, license)

if not execSuccess then
	downloader.Text = 'ERROR: Runtime error'
	downloader.TextColor3 = Color3.new(1, 0, 0)
	warn('Runtime error:', execError)
	task.wait(10)
	error('Runtime error: '..tostring(execError))
end
