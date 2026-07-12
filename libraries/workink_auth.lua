-- Work.ink Key System Integration for Xyphrion
-- Configured with your work.ink link

local WorkInkAuth = {}

-- Configuration
WorkInkAuth.Config = {
    LINK_ID = "2JiA/d653afbe-06a3-4fc9-ba5f-674b59ebcbbd", -- Your work.ink link ID
    API_URL = "https://api.work.ink/api/", -- work.ink API endpoint
    KEY_STORAGE = "xyphrion/profiles/key.txt"
}

local httpService = game:GetService("HttpService")

-- Save key to file
function WorkInkAuth:SaveKey(key)
    writefile(self.Config.KEY_STORAGE, key)
end

-- Load key from file
function WorkInkAuth:LoadKey()
    if isfile(self.Config.KEY_STORAGE) then
        return readfile(self.Config.KEY_STORAGE)
    end
    return nil
end

-- Verify key with work.ink API
function WorkInkAuth:VerifyKey(key)
    if not key or key == "" then
        return false, "No key provided"
    end
    
    local success, response = pcall(function()
        return request({
            Url = self.Config.API_URL .. "check",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = httpService:JSONEncode({
                link_id = self.Config.LINK_ID,
                key = key
            })
        })
    end)
    
    if not success then
        return false, "Failed to connect to authentication server"
    end
    
    if response.StatusCode ~= 200 then
        return false, "Invalid response from server"
    end
    
    local data = httpService:JSONDecode(response.Body)
    
    if data.success then
        return true, data.message or "Key verified successfully"
    else
        return false, data.message or "Invalid key"
    end
end

-- Get link for user to obtain key
function WorkInkAuth:GetKeyLink()
    return "https://work.ink/" .. self.Config.LINK_ID
end

-- Main authentication function
function WorkInkAuth:Authenticate()
    -- Try to load saved key
    local savedKey = self:LoadKey()
    
    if savedKey then
        local verified, message = self:VerifyKey(savedKey)
        if verified then
            return true, "Authentication successful", savedKey
        else
            -- Remove invalid key
            if isfile(self.Config.KEY_STORAGE) then
                delfile(self.Config.KEY_STORAGE)
            end
        end
    end
    
    -- No valid key found, redirect to get key
    return false, "Please get a key from: " .. self:GetKeyLink(), nil
end

-- Optional: Whitelist check (if you want HWID whitelisting)
function WorkInkAuth:CheckWhitelist(key)
    local success, response = pcall(function()
        return request({
            Url = self.Config.API_URL .. "whitelist",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = httpService:JSONEncode({
                link_id = self.Config.LINK_ID,
                key = key,
                hwid = game:GetService("RbxAnalyticsService"):GetClientId()
            })
        })
    end)
    
    if success and response.StatusCode == 200 then
        local data = httpService:JSONDecode(response.Body)
        return data.whitelisted or false
    end
    
    return false
end

return WorkInkAuth
