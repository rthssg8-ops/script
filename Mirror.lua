--[[
    ============================================================================
    AVATAR CLONE CONTROLLER & ZERO-DELAY LIVE MIRROR ENGINE (MOBILE OPTIMIZED V1.1)
    ============================================================================
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local Mouse = LocalPlayer:GetMouse()

-- // Clean up any previous instance safely
if _G.AvatarCloneControllerCleanup then
    pcall(_G.AvatarCloneControllerCleanup)
end

local State = {
    Running = true,
    SyncEnabled = true,
    MirrorAnimations = true,
    MirrorTools = true,
    MirrorJumpAndStates = true,
    LockPosition = false,
    ClickToMoveEnabled = true,
    DirectClickMode = false,

    Formation = "Line",
    Spacing = 4.5,
    OffsetX = 0,
    OffsetY = 0,
    OffsetZ = 4.5,
    YawOffset = 0,
    OrbitSpeed = 1.6,
    OrbitAngle = 0,

    ManualTargetPosition = nil,
    ManualMoveSpeed = 22,
    ManualFacingYaw = 0,

    MainPlayerAlive = false,
    MainRigType = "R15",
    ActiveTrackCount = 0,
}

local Clones = {}
local TrailBuffer = {}
local MAX_TRAIL_SAMPLES = 120 -- Reduced for mobile performance
local Connections = {}

local CloneFolder = Workspace:FindFirstChild("AvatarMirrorClones_" .. LocalPlayer.UserId)
if not CloneFolder then
    CloneFolder = Instance.new("Folder")
    CloneFolder.Name = "AvatarMirrorClones_" .. LocalPlayer.UserId
    CloneFolder.Parent = Workspace
end

local MainRef = {
    Character = nil,
    Humanoid = nil,
    RootPart = nil,
    Animator = nil,
    Motors = {},
    BaseC0 = {},
    BaseC1 = {},
}

local function GetMotorKey(motor)
    local parentName = motor.Parent and motor.Parent.Name or "Root"
    return parentName .. "." .. motor.Name
end

local function IndexCharacterMotors(character)
    local motors, baseC0, baseC1 = {}, {}, {}
    if not character then return motors, baseC0, baseC1 end
    for _, desc in ipairs(character:GetDescendants()) do
        if desc:IsA("Motor6D") then
            local key = GetMotorKey(desc)
            motors[key] = desc
            baseC0[key] = desc.C0
            baseC1[key] = desc.C1
        end
    end
    return motors, baseC0, baseC1
end

local function BindMainCharacter(character)
    if not character then
        MainRef.Character = nil
        MainRef.Humanoid = nil
        MainRef.RootPart = nil
        MainRef.Animator = nil
        MainRef.Motors = {}
        State.MainPlayerAlive = false
        return
    end

    local hum = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 3)
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 3)
    if not hum or not hrp then
        State.MainPlayerAlive = false
        return
    end

    MainRef.Character = character
    MainRef.Humanoid = hum
    MainRef.RootPart = hrp
    MainRef.Animator = hum:FindFirstChildOfClass("Animator")
    State.MainRigType = (hum.RigType == Enum.HumanoidRigType.R6) and "R6" or "R15"
    MainRef.Motors, MainRef.BaseC0, MainRef.BaseC1 = IndexCharacterMotors(character)
    State.MainPlayerAlive = (hum.Health > 0)
end

local function CheckMainPlayerContinuously()
    local char = LocalPlayer.Character
    if not char or not char.Parent then
        State.MainPlayerAlive = false
        return false
    end

    if MainRef.Character ~= char or not MainRef.RootPart or not MainRef.RootPart.Parent then
        BindMainCharacter(char)
    end

    if not MainRef.Humanoid or not MainRef.RootPart then
        State.MainPlayerAlive = false
        return false
    end

    State.MainPlayerAlive = (MainRef.Humanoid.Health > 0)
    if not MainRef.Animator or not MainRef.Animator.Parent then
        MainRef.Animator = MainRef.Humanoid:FindFirstChildOfClass("Animator")
    end

    if MainRef.Animator then
        local ok, tracks = pcall(function()
            return MainRef.Animator:GetPlayingAnimationTracks()
        end)
        State.ActiveTrackCount = (ok and tracks) and #tracks or 0
    else
        State.ActiveTrackCount = 0
    end

    return State.MainPlayerAlive
end

local function StripCloneScriptsAndPhysics(cloneModel, cloneNumber)
    pcall(function()
        for _, inst in ipairs(cloneModel:GetDescendants()) do
            if inst:IsA("BaseScript") or inst:IsA("LocalScript") or inst:IsA("ModuleScript") or inst:IsA("Sound") or inst:IsA("BodyMover") or inst:IsA("Constraint") or inst:IsA("ForceField") or inst:IsA("BillboardGui") or inst:IsA("Tool") then
                inst:Destroy()
            elseif inst:IsA("BasePart") then
                inst.CanCollide = false
                inst.CanTouch = false
                inst.CanQuery = false
                inst.Massless = true
                inst.CastShadow = false -- Disabled for better mobile performance
            end
        end

        local hum = cloneModel:FindFirstChildOfClass("Humanoid")
        local hrp = cloneModel:FindFirstChild("HumanoidRootPart")

        if hum then
            hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
            hum.AutoRotate = false
            pcall(function()
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end)
        end

        if hrp then
            hrp.Anchored = true
            hrp.CanCollide = false
        end
    end)
end

local function CalculateFormationCFrame(index, totalClones, mainCFrame)
    local mode = State.Formation
    local spacing = State.Spacing
    local manualOffset = Vector3.new(State.OffsetX, State.OffsetY, State.OffsetZ)
    local extraYaw = CFrame.Angles(0, math.rad(State.YawOffset), 0)

    if mode == "Line" then
        local side = (index % 2 == 1) and 1 or -1
        local rank = math.ceil(index / 2)
        return mainCFrame * CFrame.new(Vector3.new(side * rank * spacing, 0, 0) + manualOffset) * extraYaw
    elseif mode == "V-Wedge" then
        local side = (index % 2 == 1) and 1 or -1
        local rank = math.ceil(index / 2)
        return mainCFrame * CFrame.new(Vector3.new(side * rank * (spacing * 0.85), 0, rank * (spacing * 0.85)) + manualOffset) * extraYaw
    elseif mode == "Circle" then
        local radius = math.max(spacing * 1.35, (totalClones * spacing) / (2 * math.pi))
        local angle = ((index - 1) / math.max(totalClones, 1)) * (math.pi * 2)
        return mainCFrame * CFrame.new(Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius) + Vector3.new(State.OffsetX, State.OffsetY, 0)) * extraYaw
    elseif mode == "Orbit" then
        local radius = math.max(spacing * 1.4, (totalClones * spacing) / (2 * math.pi))
        local angle = State.OrbitAngle + ((index - 1) / math.max(totalClones, 1)) * (math.pi * 2)
        return mainCFrame * CFrame.new(Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius) + Vector3.new(State.OffsetX, State.OffsetY, 0)) * extraYaw
    elseif mode == "Mirror" then
        local side = (index == 1) and 0 or (((index % 2 == 0) and 1 or -1) * math.ceil((index - 1) / 2))
        return mainCFrame * CFrame.new(Vector3.new(side * spacing, State.OffsetY, -math.max(spacing * 1.5, math.abs(State.OffsetZ)))) * CFrame.Angles(0, math.pi + math.rad(State.YawOffset), 0)
    elseif mode == "Trail" then
        local targetSampleIdx = math.min(index * 4, #TrailBuffer)
        if targetSampleIdx >= 1 and TrailBuffer[targetSampleIdx] then
            return TrailBuffer[targetSampleIdx] * CFrame.new(State.OffsetX, State.OffsetY, 0) * extraYaw
        end
    end

    local side = (index == 1) and 0 or (((index % 2 == 0) and 1 or -1) * math.ceil((index - 1) / 2))
    if State.ManualTargetPosition then
        local baseCF = CFrame.new(State.ManualTargetPosition) * CFrame.Angles(0, State.ManualFacingYaw + math.rad(State.YawOffset), 0)
        return baseCF * CFrame.new(side * spacing, State.OffsetY, 0)
    end
    return mainCFrame * CFrame.new(Vector3.new(side * spacing + State.OffsetX, State.OffsetY, State.OffsetZ)) * extraYaw
end

local function SpawnAvatarClone()
    if not CheckMainPlayerContinuously() then return nil end

    local char = MainRef.Character
    local cloneModel
    pcall(function()
        char.Archivable = true
        cloneModel = char:Clone()
        char.Archivable = false
    end)

    if not cloneModel then return nil end

    local cloneIndex = #Clones + 1
    cloneModel.Name = string.format("%s_Clone_%d", LocalPlayer.Name, cloneIndex)
    StripCloneScriptsAndPhysics(cloneModel, cloneIndex)

    local cloneHum = cloneModel:FindFirstChildOfClass("Humanoid")
    local cloneHRP = cloneModel:FindFirstChild("HumanoidRootPart")
    if not cloneHum or not cloneHRP then
        cloneModel:Destroy()
        return nil
    end

    local motors, baseC0, baseC1 = IndexCharacterMotors(cloneModel)
    local initialCF = CalculateFormationCFrame(cloneIndex, cloneIndex, MainRef.RootPart.CFrame)
    cloneHRP.CFrame = initialCF
    cloneModel.Parent = CloneFolder

    local entry = {
        Index = cloneIndex,
        Model = cloneModel,
        Humanoid = cloneHum,
        RootPart = cloneHRP,
        Motors = motors,
        BaseC0 = baseC0,
        BaseC1 = baseC1,
        CurrentCFrame = initialCF,
        EquippedToolName = nil,
        VisualTool = nil,
    }

    table.insert(Clones, entry)
    return entry
end

local function RemoveLastClone()
    local entry = table.remove(Clones)
    if entry and entry.Model then entry.Model:Destroy() end
end

local function ClearAllClones()
    for i = #Clones, 1, -1 do
        if Clones[i].Model then Clones[i].Model:Destroy() end
        Clones[i] = nil
    end
    pcall(function() CloneFolder:ClearAllChildren() end)
end

-- Optimized single RenderStepped connection for mobile performance
table.insert(Connections, RunService.RenderStepped:Connect(function(dt)
    local isAlive = CheckMainPlayerContinuously()
    if not isAlive or not State.SyncEnabled or #Clones == 0 then return end

    local mainHRP = MainRef.RootPart
    local mainHum = MainRef.Humanoid
    local mainChar = MainRef.Character
    local mainCF = mainHRP.CFrame

    if #TrailBuffer == 0 or (TrailBuffer[1].Position - mainCF.Position).Magnitude > 0.2 then
        table.insert(TrailBuffer, 1, mainCF)
        if #TrailBuffer > MAX_TRAIL_SAMPLES then table.remove(TrailBuffer) end
    end

    if State.Formation == "Orbit" then
        State.OrbitAngle = (State.OrbitAngle + dt * State.OrbitSpeed) % (math.pi * 2)
    end

    local mainState = mainHum:GetState()
    local totalClones = #Clones

    local mainTransforms = {}
    if State.MirrorAnimations then
        for key, motor in pairs(MainRef.Motors) do
            if motor and motor.Parent then
                mainTransforms[key] = motor.Transform
            end
        end
    end

    for i = totalClones, 1, -1 do
        local clone = Clones[i]
        if not clone.Model or not clone.Model.Parent or not clone.RootPart or not clone.RootPart.Parent then
            table.remove(Clones, i)
        else
            if not State.LockPosition then
                local targetCF = CalculateFormationCFrame(i, totalClones, mainCF)
                clone.CurrentCFrame = targetCF
                clone.RootPart.CFrame = clone.CurrentCFrame
            end

            if State.MirrorAnimations then
                for key, cloneMotor in pairs(clone.Motors) do
                    local tr = mainTransforms[key]
                    if tr and cloneMotor and cloneMotor.Parent then
                        cloneMotor.Transform = tr
                    end
                end
            end

            if State.MirrorJumpAndStates and clone.Humanoid then
                clone.Humanoid.Jump = mainHum.Jump
                pcall(function() clone.Humanoid:ChangeState(mainState) end)
            end
        end
    end
end))

-- Mobile Safe UI Parent
local GuiParent = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AvatarCloneControllerUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = GuiParent

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 400)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Built-in mobile friendly dragging for Delta
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(48, 56, 74)
MainStroke.Thickness = 1.5

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 36)
Header.BackgroundColor3 = Color3.fromRGB(22, 25, 34)
Header.BorderSizePixel = 0
Header.Parent = MainFrame
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -40, 1, 0)
HeaderTitle.Position = UDim2.new(0, 12, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "AVATAR CLONE CONTROLLER (MOBILE)"
HeaderTitle.TextColor3 = Color3.fromRGB(235, 242, 255)
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextSize = 11
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local Body = Instance.new("ScrollingFrame")
Body.Size = UDim2.new(1, -20, 1, -46)
Body.Position = UDim2.new(0, 10, 0, 42)
Body.BackgroundTransparency = 1
Body.CanvasSize = UDim2.new(0, 0, 0, 350)
Body.ScrollBarThickness = 4
Body.Parent = MainFrame

local function CreateButton(parent, text, pos, size, bgColor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = size
    btn.Position = pos
    btn.BackgroundColor3 = bgColor or Color3.fromRGB(30, 36, 48)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(235, 240, 250)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 10
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

-- UI Controls Layout inside Body
CreateButton(Body, "+1 Spawn Clone", UDim2.new(0, 0, 0, 10), UDim2.new(0.48, 0, 0, 32), Color3.fromRGB(32, 95, 165), function()
    SpawnAvatarClone()
end)

CreateButton(Body, "Clear All Clones", UDim2.new(0.52, 0, 0, 10), UDim2.new(0.48, 0, 0, 32), Color3.fromRGB(135, 42, 52), function()
    ClearAllClones()
end)

-- Formation Buttons
local FormationsList = { "Line", "V-Wedge", "Circle", "Trail", "Mirror", "Orbit" }
for idx, formName in ipairs(FormationsList) do
    local col = (idx - 1) % 3
    local row = math.floor((idx - 1) / 3)
    CreateButton(Body, formName, UDim2.new(col * 0.34, 0, 0, 55 + (row * 38)), UDim2.new(0.32, 0, 0, 32), Color3.fromRGB(28, 33, 44), function()
        State.Formation = formName
        State.ManualTargetPosition = nil
    end)
end

CreateButton(Body, "Toggle Pose Mirror: ON", UDim2.new(0, 0, 0, 140), UDim2.new(1, 0, 0, 32), Color3.fromRGB(32, 110, 78), function(btn)
    State.MirrorAnimations = not State.MirrorAnimations
    btn.Text = "Toggle Pose Mirror: " .. (State.MirrorAnimations and "ON" or "OFF")
    btn.BackgroundColor3 = State.MirrorAnimations and Color3.fromRGB(32, 110, 78) or Color3.fromRGB(40, 44, 56)
end)

CreateButton(Body, "Spacing -", UDim2.new(0, 0, 0, 185), UDim2.new(0.48, 0, 0, 32), nil, function()
    State.Spacing = math.max(1.5, State.Spacing - 1)
end)

CreateButton(Body, "Spacing +", UDim2.new(0.52, 0, 0, 185), UDim2.new(0.48, 0, 0, 32), nil, function()
    State.Spacing = math.min(15, State.Spacing + 1)
end)

-- Initial spawn
SpawnAvatarClone()
