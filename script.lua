local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PrivateServerFinder"
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
UIStroke.Color = Color3.fromRGB(60, 50, 90)
UIStroke.Thickness = 1.5

-- Header
local Title = Instance.new("TextLabel", MainFrame)
Title.Position = UDim2.new(0, 15, 0, 12)
Title.Size = UDim2.new(0, 180, 0, 18)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.FredokaOne
Title.Text = "PRIVATE SERVER FINDER"
Title.TextColor3 = Color3.fromRGB(0, 230, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel", MainFrame)
Subtitle.Position = UDim2.new(0, 15, 0, 30)
Subtitle.Size = UDim2.new(0, 180, 0, 14)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.Text = "Low Player Server Finder"
Subtitle.TextColor3 = Color3.fromRGB(120, 120, 150)
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
NowLabel.TextColor3 = Color3.fromRGB(0, 230, 255)
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
MaxBox.PlaceholderText = "Max Players Allowed"
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

-- Low Server Button
local JoinBtn = Instance.new("TextButton", MainFrame)
JoinBtn.Position = UDim2.new(0, 15, 0, 190)
JoinBtn.Size = UDim2.new(1, -30, 0, 34)
JoinBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
JoinBtn.BorderSizePixel = 0
JoinBtn.Font = Enum.Font.GothamBold
JoinBtn.Text = "FIND LOW SERVER"
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
AutoBtn.Text = "AUTO HOP: DISABLED"
AutoBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
AutoBtn.TextSize = 11
Instance.new("UICorner", AutoBtn).CornerRadius = UDim.new(0, 8)

-- Hover
local function addHover(btn, normalColor, hoverColor)
    btn.MouseEnter:Connect(function()
        TweenService:Create(
            btn,
            TweenInfo.new(0.2),
            {BackgroundColor3 = hoverColor}
        ):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(
            btn,
            TweenInfo.new(0.2),
            {BackgroundColor3 = normalColor}
        ):Play()
    end)
end

addHover(
    JoinBtn,
    Color3.fromRGB(0, 140, 255),
    Color3.fromRGB(30, 160, 255)
)

addHover(
    HopIdBtn,
    Color3.fromRGB(120, 80, 220),
    Color3.fromRGB(145, 105, 245)
)

addHover(
    CloseBtn,
    Color3.fromRGB(35, 30, 50),
    Color3.fromRGB(220, 50, 70)
)

-- ==============================
-- LOGIC
-- ==============================

local autoEnabled = false
local autoThread = nil

local randomGenerator = Random.new(
    math.floor(os.clock() * 1000000)
    + math.floor(os.time())
    + #tostring(LocalPlayer.UserId) * 7919
)

local maxServerPages = 5
local targetCandidateCount = 30
local failedServers = {}
local failedServerCooldown = 60
local teleportRetries = 2

-- Current server player count
task.spawn(function()
    while ScreenGui.Parent do
        local count = #Players:GetPlayers()
        NowLabel.Text = "Current Server: " .. count .. " player(s)"
        task.wait(1)
    end
end)

-- Get threshold
local function getThreshold()
    return math.max(
        1,
        math.floor(tonumber(MaxBox.Text) or 1)
    )
end

-- Find and weighted-randomly select a server
local function findLowPlayerServer(threshold)
    local currentId = tostring(game.JobId)
    local cursor = nil
    local candidates = {}
    local seenServers = {}
    local now = os.time()

    for page = 1, maxServerPages do
        local url =
            "https://games.roblox.com/v1/games/"
            .. PlaceId
            .. "/servers/Public?sortOrder=Asc&limit=100"

        if cursor then
            url = url .. "&cursor=" .. HttpService:UrlEncode(cursor)
        end

        local ok, raw = pcall(function()
            return game:HttpGet(url)
        end)

        if not ok or type(raw) ~= "string" or raw == "" then
            ok, raw = pcall(function()
                local response = HttpService:RequestAsync({
                    Url = url,
                    Method = "GET"
                })

                if not response.Success
                    or type(response.Body) ~= "string" then
                    error("Server API request failed")
                end

                return response.Body
            end)
        end

        if not ok or type(raw) ~= "string" or raw == "" then
            return nil, "request_failed"
        end

        local ok2, data = pcall(function()
            return HttpService:JSONDecode(raw)
        end)

        if not ok2
            or type(data) ~= "table"
            or type(data.data) ~= "table" then
            return nil, "invalid_response"
        end

        for _, server in ipairs(data.data) do
            if type(server) == "table" then
                local serverId =
                    type(server.id) == "string"
                    and server.id
                    or ""

                local playing = tonumber(server.playing)
                local maxPlayers = tonumber(server.maxPlayers)

                local hasCapacity =
                    not maxPlayers
                    or playing < maxPlayers

                local recentlyFailed =
                    failedServers[serverId]
                    and now - failedServers[serverId]
                        < failedServerCooldown

                if serverId ~= ""
                    and not seenServers[serverId]
                    and serverId ~= currentId
                    and not recentlyFailed
                    and playing
                    and playing >= 0
                    and playing <= threshold
                    and hasCapacity then

                    seenServers[serverId] = true

                    table.insert(candidates, {
                        id = serverId,
                        playing = playing,
                        maxPlayers = maxPlayers
                    })
                end
            end
        end

        cursor = data.nextPageCursor

        if not cursor
            or #candidates >= targetCandidateCount then
            break
        end
    end

    if #candidates == 0 then
        return nil, "no_candidates"
    end

    -- Weighted random:
    -- lower player count = higher chance
    local totalWeight = 0

    for _, candidate in ipairs(candidates) do
        local weight =
            math.max(
                1,
                threshold - candidate.playing + 1
            )

        candidate.weight = weight * weight
        totalWeight = totalWeight + candidate.weight
    end

    local roll =
        randomGenerator:NextNumber(
            0,
            totalWeight
        )

    local accumulated = 0

    for _, candidate in ipairs(candidates) do
        accumulated =
            accumulated + candidate.weight

        if roll <= accumulated then
            return candidate, #candidates
        end
    end

    return candidates[#candidates], #candidates
end

-- Join one low-player server
local function joinOnce()
    local threshold = getThreshold()
    local currentCount = #Players:GetPlayers()

    if currentCount <= threshold then
        StatusLabel.Text =
            "Already optimal (" ..
            currentCount ..
            " <= " ..
            threshold ..
            ")"

        StatusLabel.TextColor3 =
            Color3.fromRGB(0, 230, 150)

        return false
    end

    StatusLabel.Text = "Searching servers..."
    StatusLabel.TextColor3 =
        Color3.fromRGB(255, 180, 50)

    for attempt = 1, teleportRetries + 1 do

        local server, result =
            findLowPlayerServer(threshold)

        if not server then
            local message

            if result == "request_failed"
                or result == "invalid_response" then

                message = "Server API request failed."
            else
                message = "No suitable server found."
            end

            StatusLabel.Text = message
            StatusLabel.TextColor3 =
                Color3.fromRGB(255, 80, 80)

            return false
        end

        StatusLabel.Text =
            "Found " .. result .. " candidates"

        StatusLabel.TextColor3 =
            Color3.fromRGB(0, 230, 255)

        task.wait(0.1)

        StatusLabel.Text =
            "Selected: "
            .. server.playing
            .. " players"

        task.wait(0.1)

        StatusLabel.Text = "Teleporting..."

        local ok = pcall(function()
            TeleportService:TeleportToPlaceInstance(
                PlaceId,
                server.id,
                LocalPlayer
            )
        end)

        if ok then
            return true
        end

        failedServers[server.id] = os.time()

        if attempt <= teleportRetries then
            StatusLabel.Text =
                "Server unavailable. Retrying..."

            task.wait(0.5)
        end
    end

    StatusLabel.Text = "Teleport failed."
    StatusLabel.TextColor3 =
        Color3.fromRGB(255, 80, 80)

    return false
end

-- Manual low-player hop
JoinBtn.MouseButton1Click:Connect(function()
    JoinBtn.Active = false

    joinOnce()

    task.wait(2)

    JoinBtn.Active = true
end)

-- =================================
-- HOP TO SERVER ID
-- =================================

HopIdBtn.MouseButton1Click:Connect(function()

    local serverId =
        ServerIdBox.Text:gsub("%s+", "")

    if serverId == "" then
        StatusLabel.Text =
            "Enter a Server ID first."

        StatusLabel.TextColor3 =
            Color3.fromRGB(255, 180, 50)

        return
    end

    if serverId == tostring(game.JobId) then
        StatusLabel.Text =
            "Already in this server."

        StatusLabel.TextColor3 =
            Color3.fromRGB(255, 180, 50)

        return
    end

    HopIdBtn.Active = false

    StatusLabel.Text =
        "Joining Server ID..."

    StatusLabel.TextColor3 =
        Color3.fromRGB(0, 230, 255)

    local ok = pcall(function()
        TeleportService:TeleportToPlaceInstance(
            PlaceId,
            serverId,
            LocalPlayer
        )
    end)

    if not ok then
        StatusLabel.Text =
            "Failed to join Server ID."

        StatusLabel.TextColor3 =
            Color3.fromRGB(255, 80, 80)

        HopIdBtn.Active = true
    end
end)

-- Auto hop
AutoBtn.MouseButton1Click:Connect(function()

    autoEnabled = not autoEnabled

    if autoEnabled then

        AutoBtn.Text =
            "AUTO HOP: ENABLED"

        AutoBtn.BackgroundColor3 =
            Color3.fromRGB(0, 180, 120)

        AutoBtn.TextColor3 =
            Color3.fromRGB(255, 255, 255)

        autoThread = task.spawn(function()

            while autoEnabled
                and ScreenGui.Parent do

                local threshold =
                    getThreshold()

                local count =
                    #Players:GetPlayers()

                if count <= threshold then

                    StatusLabel.Text =
                        "Optimal server. Waiting..."

                    StatusLabel.TextColor3 =
                        Color3.fromRGB(0, 230, 150)

                    task.wait(5)

                else

                    joinOnce()

                    task.wait(7)
                end
            end
        end)

    else

        AutoBtn.Text =
            "AUTO HOP: DISABLED"

        AutoBtn.BackgroundColor3 =
            Color3.fromRGB(35, 30, 50)

        AutoBtn.TextColor3 =
            Color3.fromRGB(180, 180, 200)

        if autoThread then
            task.cancel(autoThread)
            autoThread = nil
        end

        StatusLabel.Text =
            "Auto hop stopped."

        StatusLabel.TextColor3 =
            Color3.fromRGB(160, 160, 180)
    end
end)

StatusLabel.Text =
    "Set max threshold & click Find."
