--!nocheck
local license = ... or {}
license.Key = script_key or license.Key

local cloneref = cloneref or function(ref) return ref end
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end
local delfile = delfile or function(file)
	writefile(file, '')
end

local downloader = Instance.new('TextLabel')
downloader.Size = UDim2.new(1, 0, 0, 40)
downloader.BackgroundTransparency = 1
downloader.TextStrokeTransparency = 0
downloader.TextSize = 20
downloader.TextColor3 = Color3.new(1, 1, 1)
downloader.Font = Enum.Font.Arial
downloader.Text = ''
downloader.Parent = Instance.new('ScreenGui', gethui and gethui() or cloneref(game:GetService('CoreGui')))

local function downloadFile(path, func)
	if not isfile(path) then
		if not license.Closet then
			downloader.Text = 'Downloading '.. path
		end
		local suc, res = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/Xyphrion/XyphrionScript/'..readfile('xyphrion/profiles/commit.txt')..'/'..select(1, path:gsub('xyphrion/', '')), true)
		end)
		if not suc or res == '404: Not Found' then
			error(res)
		end
		if path:find('.lua') then
			res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after updates.\n'..res
		end
		writefile(path, res)
		downloader.Text = ''
	end
	return (func or readfile)(path)
end

local function wipeFolder(path)
	if not isfolder(path) then return end
	for _, file in listfiles(path) do
		if file:find('init') then continue end
		if file:find('profile') then continue end
		if isfile(file) then
			delfile(file)
		elseif isfolder(file) then
			wipeFolder(file)
		end
	end
end


for _, folder in {'xyphrion', 'xyphrion/games', 'xyphrion/profiles', 'xyphrion/assets', 'xyphrion/libraries', 'xyphrion/guis'} do
	if not isfolder(folder) then
		downloader.Text = 'Downloading '.. folder
		makefolder(folder)
	end
end

if not shared.XyphrionDeveloper then
	local commit = license.Commit or nil
	if not commit then
		local _, subbed = pcall(function() 
			return game:HttpGet('https://github.com/Xyphrion/XyphrionScript') 
		end)
		commit = subbed:find('currentOid')
		commit = commit and subbed:sub(commit + 13, commit + 52) or nil
		commit = commit and #commit == 40 and commit or 'main'
	end
	if commit == 'main' or (isfile('xyphrion/profiles/commit.txt') and readfile('xyphrion/profiles/commit.txt') or '') ~= commit then
		if commit ~= 'main' and isfile('xyphrion/profiles/commit.txt') then
			shared.updated = readfile('xyphrion/profiles/commit.txt')
		end
		wipeFolder('xyphrion')
		wipeFolder('xyphrion/games')
		wipeFolder('xyphrion/guis')
		wipeFolder('xyphrion/libraries')
	end
	writefile('xyphrion/profiles/commit.txt', commit)
	if #listfiles('xyphrion/profiles') < 4 then
		local req = request({
			Url = 'https://api.github.com/repos/xyphrion/xyphrionscript/contents/profiles',
			Method = 'GET'
		})
		if req.StatusCode == 200 then
			local body = cloneref(game:GetService('HttpService')):JSONDecode(req.Body)
			if body and typeof(body) == 'table' then
				for _, v in body do
					if v.type == 'file' then
						pcall(downloadFile, 'xyphrion/'.. ({v.path:gsub(' ', '%%20')})[1])
					end
				end
			end
		end
	end
end

downloader.Text = ''
return loadstring(downloadFile('xyphrion/main.lua'), 'main')(license)