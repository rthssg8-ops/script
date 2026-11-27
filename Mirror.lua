-- COCA COMBAT | StarterPlayer/StarterPlayerScripts/CombatClient.client.lua
-- For your own Roblox Studio experience.
-- Client handles presentation/target selection; server validates every shot.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Remote = ReplicatedStorage:WaitForChild("CocaCombatRemote")

local CONFIG = {
    ESP = false,
    Boxes = true,
    Names = true,
    TeamCheck = true,
    Aim = false,
    AimFOV = 120,
    AimSmoothness = 0.18,
    AimPart = "Head",
    AutoFire = false,
    AutoFireFOV = 190, -- screen-pixel radius, not degrees
    AutoFireInterval = 0.20,
    HitboxDebug = false,
    HitboxMultiplier = 1,
    MaxESPDistance = 1500,
}

local tracked = {}
local gui, statusLabel, fovCircle
local lastAutoShot = 0

local function isEnemy(player)
    if player == LocalPlayer then return false end
    if CONFIG.TeamCheck and LocalPlayer.Team and player.Team and LocalPlayer.Team == player.Team then
        return false
    end
    return true
end

local function getCharacterData(player)
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or hum.Health <= 0 or not root then return end
    return char, hum, root
end

local function clearESP(player)
    local item = tracked[player]
    if not item then return end
    if item.highlight then item.highlight:Destroy() end
    if item.billboard then item.billboard:Destroy() end
    tracked[player] = nil
end

local function createESP(player)
    if player == LocalPlayer or tracked[player] then return end
    local char = player.Character
    if not char then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "CocaESPHighlight"
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = Color3.fromRGB(145, 85, 255)
    highlight.OutlineColor = Color3.fromRGB(220, 195, 255)
    highlight.FillTransparency = 0.82
    highlight.OutlineTransparency = 0.08
    highlight.Enabled = false
    highlight.Adornee = char
    highlight.Parent = char

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CocaESPInfo"
    billboard.Size = UDim2.fromOffset(180, 48)
    billboard.StudsOffset = Vector3.new(0, 3.2, 0)
    billboard.AlwaysOnTop = true
    billboard.Enabled = false
    billboard.Adornee = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
    billboard.Parent = char

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextColor3 = Color3.fromRGB(245, 238, 255)
    label.TextStrokeTransparency = 0.35
    label.TextWrapped = true
    label.Parent = billboard

    tracked[player] = {highlight = highlight, billboard = billboard, label = label}
end

local function refreshPlayer(player)
    clearESP(player)
    createESP(player)
end

local function setStatus(message)
    if statusLabel then statusLabel.Text = message end
end

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function makeButton(parent, text, callback)
    local b = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = Color3.fromRGB(42, 34, 58),
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = Color3.fromRGB(245, 240, 255),
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        AutoButtonColor = true,
    }, parent)
    make("UICorner", {CornerRadius = UDim.new(0, 8)}, b)
    b.MouseButton1Click:Connect(callback)
    return b
end

local function makeSection(parent, title)
    return make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 22),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Color3.fromRGB(190, 155, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, parent)
end

local function toggleButton(parent, title, key)
    local button
    local function update()
        button.Text = title .. ": " .. (CONFIG[key] and "ON" or "OFF")
        button.BackgroundColor3 = CONFIG[key] and Color3.fromRGB(72, 48, 105) or Color3.fromRGB(42, 34, 58)
    end
    button = makeButton(parent, title, function()
        CONFIG[key] = not CONFIG[key]
        update()
        setStatus(title .. (CONFIG[key] and " enabled" or " disabled"))
    end)
    update()
end

local function buildUI()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local old = playerGui:FindFirstChild("CocaCombatUI")
    if old then old:Destroy() end

    gui = make("ScreenGui", {
        Name = "CocaCombatUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, playerGui)

    local panel = make("Frame", {
        Size = UDim2.fromOffset(290, 520),
        Position = UDim2.new(0, 22, 0.5, -260),
        BackgroundColor3 = Color3.fromRGB(17, 16, 23),
        BorderSizePixel = 0,
    }, gui)
    make("UICorner", {CornerRadius = UDim.new(0, 14)}, panel)
    make("UIStroke", {Color = Color3.fromRGB(126, 78, 190), Thickness = 1.3, Transparency = 0.15}, panel)

    local header = make("Frame", {
        Size = UDim2.new(1, 0, 0, 54),
        BackgroundColor3 = Color3.fromRGB(31, 24, 43),
        BorderSizePixel = 0,
    }, panel)
    make("UICorner", {CornerRadius = UDim.new(0, 14)}, header)
    make("TextLabel", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.fromOffset(14, 0),
        BackgroundTransparency = 1,
        Text = "COCA  /  COMBAT",
        TextColor3 = Color3.fromRGB(238, 224, 255),
        Font = Enum.Font.GothamBlack,
        TextSize = 17,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, header)

    local scroll = make("ScrollingFrame", {
        Size = UDim2.new(1, -24, 1, -112),
        Position = UDim2.fromOffset(12, 64),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, panel)
    make("UIListLayout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, scroll)

    makeSection(scroll, "PLAYER ESP")
    toggleButton(scroll, "ESP", "ESP")
    toggleButton(scroll, "Team filter", "TeamCheck")
    toggleButton(scroll, "Boxes / outline", "Boxes")
    toggleButton(scroll, "Names + distance + health", "Names")

    makeSection(scroll, "AIM ASSIST")
    toggleButton(scroll, "Aim assist", "Aim")
    makeButton(scroll, "Aim FOV: 120 px (cycle)", function()
        local values = {80, 120, 160, 220}
        local index = table.find(values, CONFIG.AimFOV) or 1
        CONFIG.AimFOV = values[index % #values + 1]
        setStatus("Aim FOV: " .. CONFIG.AimFOV .. " px")
    end)
    makeButton(scroll, "Smoothness (cycle)", function()
        local values = {0.10, 0.18, 0.28, 0.4}
        local index = table.find(values, CONFIG.AimSmoothness) or 1
        CONFIG.AimSmoothness = values[index % #values + 1]
        setStatus("Aim smoothness: " .. CONFIG.AimSmoothness)
    end)
    makeButton(scroll, "Aim part: Head / Body", function()
        CONFIG.AimPart = CONFIG.AimPart == "Head" and "HumanoidRootPart" or "Head"
        setStatus("Aim part: " .. CONFIG.AimPart)
    end)

    makeSection(scroll, "AUTO FIRE")
    toggleButton(scroll, "Auto fire • continuous", "AutoFire")
    makeButton(scroll, "Auto-fire FOV: 190 px", function()
        CONFIG.AutoFireFOV = 190
        setStatus("Auto-fire FOV set to 190 px")
    end)
    makeButton(scroll, "Fire interval: 0.20 sec", function()
        CONFIG.AutoFireInterval = 0.20
        setStatus("Fire interval set to 0.20 sec; server cooldown still applies")
    end)

    makeSection(scroll, "HITBOX LAB  (STUDIO DEBUG)")
    toggleButton(scroll, "Hitbox debug profile", "HitboxDebug")
    makeButton(scroll, "Hitbox multiplier: " .. tostring(CONFIG.HitboxMultiplier), function()
        local values = {1, 1.25, 1.5, 2, 2.5}
        local index = table.find(values, CONFIG.HitboxMultiplier) or 1
        CONFIG.HitboxMultiplier = values[index % #values + 1]
        Remote:FireServer("SetDebugHitbox", {multiplier = CONFIG.HitboxMultiplier})
        setStatus("Requested Studio debug multiplier: " .. CONFIG.HitboxMultiplier)
    end)
    makeButton(scroll, "Reset hitbox profile", function()
        CONFIG.HitboxMultiplier = 1
        Remote:FireServer("SetDebugHitbox", {multiplier = 1})
        setStatus("Hitbox debug profile reset")
    end)

    statusLabel = make("TextLabel", {
        Size = UDim2.new(1, -24, 0, 28),
        Position = UDim2.new(0, 12, 1, -36),
        BackgroundColor3 = Color3.fromRGB(28, 25, 35),
        Text = "Ready  •  RightShift hides/shows panel",
        TextColor3 = Color3.fromRGB(185, 175, 200),
        Font = Enum.Font.Gotham,
        TextSize = 10,
    }, panel)
    make("UICorner", {CornerRadius = UDim.new(0, 7)}, statusLabel)

    local dragging, dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging, dragStart, startPos = true, input.Position, panel.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function createFOV()
    local overlay = make("ScreenGui", {Name = "CocaCombatFOV", ResetOnSpawn = false}, LocalPlayer:WaitForChild("PlayerGui"))
    fovCircle = make("Frame", {
        Name = "FOV",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(CONFIG.AimFOV * 2, CONFIG.AimFOV * 2),
        BackgroundTransparency = 1,
        Visible = false,
    }, overlay)
    make("UICorner", {CornerRadius = UDim.new(1, 0)}, fovCircle)
    make("UIStroke", {Color = Color3.fromRGB(177, 120, 255), Thickness = 1.2, Transparency = 0.2}, fovCircle)
end

local function hasLineOfSight(targetCharacter, targetPart)
    local origin = Camera.CFrame.Position
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {LocalPlayer.Character}
    local result = Workspace:Raycast(origin, targetPart.Position - origin, params)
    return result and result.Instance:IsDescendantOf(targetCharacter)
end

local function findVisibleTarget(maxRadius)
    local center = Camera.ViewportSize / 2
    local best, bestDistance = nil, maxRadius
    for _, player in ipairs(Players:GetPlayers()) do
        if isEnemy(player) then
            local char, hum = getCharacterData(player)
            if char then
                local part = char:FindFirstChild(CONFIG.AimPart) or char:FindFirstChild("Head")
                if part then
                    local point, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen and point.Z > 0 and hasLineOfSight(char, part) then
                        local distance = (Vector2.new(point.X, point.Y) - center).Magnitude
                        if distance < bestDistance then
                            bestDistance = distance
                            best = part
                        end
                    end
                end
            end
        end
    end
    return best
end

local function updateESP()
    for player, item in pairs(tracked) do
        local char, hum, root = getCharacterData(player)
        local show = CONFIG.ESP and char ~= nil and isEnemy(player)
        if show then
            show = (Camera.CFrame.Position - root.Position).Magnitude <= CONFIG.MaxESPDistance
        end
        item.highlight.Enabled = show and CONFIG.Boxes
        item.billboard.Enabled = show and CONFIG.Names
        if show then
            local distance = math.floor((Camera.CFrame.Position - root.Position).Magnitude)
            item.label.Text = string.format("%s\n%d studs  •  HP %d", player.DisplayName, distance, math.floor(hum.Health))
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    createESP(player)
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            refreshPlayer(player)
        end)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        refreshPlayer(player)
    end)
    createESP(player)
end)
Players.PlayerRemoving:Connect(clearESP)

buildUI()
createFOV()

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift and gui then
        gui.Enabled = not gui.Enabled
    end
end)

RunService.RenderStepped:Connect(function()
    Camera = Workspace.CurrentCamera
    updateESP()

    if fovCircle then
        fovCircle.Visible = CONFIG.Aim or CONFIG.AutoFire
        local radius = CONFIG.AutoFire and CONFIG.AutoFireFOV or CONFIG.AimFOV
        fovCircle.Size = UDim2.fromOffset(radius * 2, radius * 2)
    end

    if CONFIG.Aim then
        local target = findVisibleTarget(CONFIG.AimFOV)
        if target then
            local desired = CFrame.lookAt(Camera.CFrame.Position, target.Position)
            Camera.CFrame = Camera.CFrame:Lerp(desired, CONFIG.AimSmoothness)
        end
    end

    -- Continuous auto fire: only fires at an on-screen, visible, living enemy
    -- within the configured pixel-radius FOV. Server revalidates weapon, range,
    -- raycast, team, cooldown and damage.
    if CONFIG.AutoFire and os.clock() - lastAutoShot >= CONFIG.AutoFireInterval then
        local targetPart = findVisibleTarget(CONFIG.AutoFireFOV)
        if targetPart then
            local origin = Camera.CFrame.Position
            local direction = (targetPart.Position - origin).Unit
            Remote:FireServer("Fire", {
                origin = origin,
                direction = direction,
            })
            lastAutoShot = os.clock()
        end
    end
end)
