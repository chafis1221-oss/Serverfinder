local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AggressiveServerSniper"
ScreenGui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game.CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = game.CoreGui
end

-- Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -160)
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(255, 50, 50)
UIStroke.Thickness = 1.5

-- Header
local Title = Instance.new("TextLabel", MainFrame)
Title.Position = UDim2.new(0, 15, 0, 12)
Title.Size = UDim2.new(0, 200, 0, 18)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.FredokaOne
Title.Text = "AGGRESSIVE SNIPER"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel", MainFrame)
Subtitle.Position = UDim2.new(0, 15, 0, 30)
Subtitle.Size = UDim2.new(0, 200, 0, 14)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.Text = "Fast Refresh / No Delay Mode"
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 180)
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 30, 50)
CloseBtn.Position = UDim2.new(1, -32, 0, 12)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
CloseBtn.TextSize = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Status Card
local StatusCard = Instance.new("Frame", MainFrame)
StatusCard.Position = UDim2.new(0, 15, 0, 52)
StatusCard.Size = UDim2.new(1, -30, 0, 50)
StatusCard.BackgroundColor3 = Color3.fromRGB(24, 20, 40)
StatusCard.BorderSizePixel = 0
Instance.new("UICorner", StatusCard).CornerRadius = UDim.new(0, 8)

local NowLabel = Instance.new("TextLabel", StatusCard)
NowLabel.Position = UDim2.new(0, 10, 0, 6)
NowLabel.Size = UDim2.new(1, -20, 0, 18)
NowLabel.BackgroundTransparency = 1
NowLabel.Font = Enum.Font.GothamBold
NowLabel.TextXAlignment = Enum.TextXAlignment.Left
NowLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
NowLabel.TextSize = 12

local StatusLabel = Instance.new("TextLabel", StatusCard)
StatusLabel.Position = UDim2.new(0, 10, 0, 24)
StatusLabel.Size = UDim2.new(1, -20, 0, 22)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
StatusLabel.TextSize = 10
StatusLabel.TextWrapped = true

-- Max Players Input
local MaxBox = Instance.new("TextBox", MainFrame)
MaxBox.Position = UDim2.new(0, 15, 0, 110)
MaxBox.Size = UDim2.new(1, -30, 0, 32)
MaxBox.BackgroundColor3 = Color3.fromRGB(24, 20, 40)
MaxBox.BorderSizePixel = 0
MaxBox.Font = Enum.Font.GothamBold
MaxBox.Text = "1"
MaxBox.PlaceholderText = "Max Players"
MaxBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MaxBox.TextSize = 13
MaxBox.ClearTextOnFocus = false
Instance.new("UICorner", MaxBox).CornerRadius = UDim.new(0, 8)

-- Server ID Input
local ServerIdBox = Instance.new("TextBox", MainFrame)
ServerIdBox.Position = UDim2.new(0, 15, 0, 150)
ServerIdBox.Size = UDim2.new(1, -30, 0, 32)
ServerIdBox.BackgroundColor3 = Color3.fromRGB(24, 20, 40)
ServerIdBox.BorderSizePixel = 0
ServerIdBox.Font = Enum.Font.GothamMedium
ServerIdBox.Text = ""
ServerIdBox.PlaceholderText = "Server ID / Job ID"
ServerIdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerIdBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 150)
ServerIdBox.TextSize = 11
ServerIdBox.ClearTextOnFocus = false
Instance.new("UICorner", ServerIdBox).CornerRadius = UDim.new(0, 8)

-- Action Button: Sniper Jump
local JoinBtn = Instance.new("TextButton", MainFrame)
JoinBtn.Position = UDim2.new(0, 15, 0, 190)
JoinBtn.Size = UDim2.new(1, -30, 0, 34)
JoinBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
JoinBtn.BorderSizePixel = 0
JoinBtn.Font = Enum.Font.GothamBold
JoinBtn.Text = "SNIPE LOW SERVER"
JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinBtn.TextSize = 11
Instance.new("UICorner", JoinBtn).CornerRadius = UDim.new(0, 8)

-- Hop To ID Button
local HopIdBtn = Instance.new("TextButton", MainFrame)
HopIdBtn.Position = UDim2.new(0, 15, 0, 230)
HopIdBtn.Size = UDim2.new(1, -30, 0, 34)
HopIdBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 220)
HopIdBtn.BorderSizePixel = 0
HopIdBtn.Font = Enum.Font.GothamBold
HopIdBtn.Text = "HOP TO SERVER ID"
HopIdBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopIdBtn.TextSize = 11
Instance.new("UICorner", HopIdBtn).CornerRadius = UDim.new(0, 8)

-- Auto Button
local AutoBtn = Instance.new("TextButton", MainFrame)
AutoBtn.Position = UDim2.new(0, 15, 0, 270)
AutoBtn.Size = UDim2.new(1, -30, 0, 34)
AutoBtn.BackgroundColor3 = Color3.fromRGB(35, 30, 50)
AutoBtn.BorderSizePixel = 0
AutoBtn.Font = Enum.Font.GothamBold
AutoBtn.Text = "AUTO SNIPER: OFF"
AutoBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
AutoBtn.TextSize = 11
Instance.new("UICorner", AutoBtn).CornerRadius = UDim.new(0, 8)

local function addHover(btn, normalColor, hoverColor)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
    end)
end

addHover(JoinBtn, Color3.fromRGB(220, 50, 50), Color3.fromRGB(255, 70, 70))
addHover(HopIdBtn, Color3.fromRGB(120, 80, 220), Color3.fromRGB(145, 105, 245))
addHover(CloseBtn, Color3.fromRGB(35, 30, 50), Color3.fromRGB(220, 50, 70))

-- ==============================
-- AGGRESSIVE LOGIC
-- ==============================

local autoEnabled = false
local autoThread = nil

task.spawn(function()
    while ScreenGui.Parent do
        NowLabel.Text = "Current Players: " .. #Players:GetPlayers()
        task.wait(0.5)
    end
end)

local function getThreshold()
    return math.max(0, math.floor(tonumber(MaxBox.Text) or 1))
end

-- Fast fetching without arbitrary delays, pulling maximum pages aggressively
local function aggressiveFetch(threshold)
    local currentId = tostring(game.JobId)
    local cursor = nil
    local candidates = {}

    -- Tarik sampai 10 halaman sekaligus secara instan buat game gede
    for page = 1, 10 do
        local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        if cursor then
            url = url .. "&cursor=" .. HttpService:UrlEncode(cursor)
        end

        local success, raw = pcall(function()
            return game:HttpGet(url)
        end)

        if not success or not raw then
            success, raw = pcall(function()
                local res = HttpService:RequestAsync({Url = url, Method = "GET"})
                return res.Body
            end)
        end

        if success and raw then
            local decoded, data = pcall(function()
                return HttpService:JSONDecode(raw)
            end)

            if decoded and data and data.data then
                for _, server in ipairs(data.data) do
                    if type(server) == "table" and server.id and server.id ~= currentId then
                        local playing = tonumber(server.playing)
                        local maxPlayers = tonumber(server.maxPlayers)
                        
                        if playing and playing <= threshold and (not maxPlayers or playing < maxPlayers) then
                            table.insert(candidates, {
                                id = server.id,
                                playing = playing
                            })
                        end
                    end
                end
                cursor = data.nextPageCursor
                if not cursor then break end
            else
                break
            end
        else
            break
        end
    end

    return candidates
end

local function executeSnipe()
    local threshold = getThreshold()
    StatusLabel.Text = "Aggressive scanning..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 180, 50)

    local candidates = aggressiveFetch(threshold)

    if #candidates > 0 --[[matched]] then
        -- Urutkan dari yang pemainnya paling sedikit (0 atau 1)
        table.sort(candidates, function(a, b)
            return a.playing < b.playing
        end)

        local target = candidates[1]
        StatusLabel.Text = "Found [P:" .. target.playing .. "]. Teleporting!"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 230, 150)

        local success = pcall(function()
            TeleportService:TeleportToPlaceInstance(PlaceId, target.id, LocalPlayer)
        end)

        if success then
            return true
        end
    end

    StatusLabel.Text = "Server penuh/habis, re-scanning..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    return false
end

-- Button Triggers
JoinBtn.MouseButton1Click:Connect(function()
    JoinBtn.Active = false
    executeSnipe()
    task.wait(1)
    JoinBtn.Active = true
end)

HopIdBtn.MouseButton1Click:Connect(function()
    local serverId = ServerIdBox.Text:gsub("%s+", "")
    if serverId ~= "" and serverId ~= tostring(game.JobId) then
        HopIdBtn.Active = false
        StatusLabel.Text = "Joining ID..."
        pcall(function()
            TeleportService:TeleportToPlaceInstance(PlaceId, serverId, LocalPlayer)
        end)
        task.wait(2)
        HopIdBtn.Active = true
    end
end)

AutoBtn.MouseButton1Click:Connect(function()
    autoEnabled = not autoEnabled

    if autoEnabled then
        AutoBtn.Text = "AUTO SNIPER: ON"
        AutoBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        AutoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

        autoThread = task.spawn(function()
            while autoEnabled and ScreenGui.Parent do
                local count = #Players:GetPlayers()
                local threshold = getThreshold()

                if count > threshold then
                    executeSnipe()
                    -- Jeda super singkat (1 detik) biar gas terus tanpa kena limit sadis
                    task.wait(1)
                else
                    StatusLabel.Text = "Target reached. Standing by."
                    StatusLabel.TextColor3 = Color3.fromRGB(0, 230, 150)
                    task.wait(2)
                end
            end
        end)
    else
        AutoBtn.Text = "AUTO SNIPER: OFF"
        AutoBtn.BackgroundColor3 = Color3.fromRGB(35, 30, 50)
        AutoBtn.TextColor3 = Color3.fromRGB(180, 180, 200)

        if autoThread then
            task.cancel(autoThread)
            autoThread = nil
        end
        StatusLabel.Text = "Sniper stopped."
        StatusLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
    end
end)
