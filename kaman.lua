--[[═══════════════════════════════════════════════════════════════════════════════
  🔴 COCO POWDER — V34 "OMNIPRESENT SEEKER & VOID-SAFE" EDITION
  Tabs: WELD | TARGET | CHAT | ANTI | MOVE
  Toggle: RightShift (or floating CP launcher)
  Compatibility: Universal R6 & R15 Cross-Rig Architecture (Delta / Android / PC)
  Upgrades:
    • Omnipresent Hidden-Player Seeker: Finds & teleports to hiding players anywhere
      in the server (unstreamed chunks, secret rooms, houses, skyboxes, underground
      bunkers, vehicles, lockers, or custom Workspace character folders)
    • Continuous Teleport-Everywhere Pursuit: Automatically streams & follows target
      through teleporters, doors, interiors, and map transitions with full Noclip,
      Anti-Seat trap, and Kill-Brick immunity (CanTouch = false)
    • Complete Void-Stuck Fix: Multi-frame Anchored Snapback & Safe Ground Tracker
    • Upgraded Void Throw v2 (Sub-Floor Bury + Deep-Void Sinkhole + Horizon Catapult):
      Forces full physical collision & 100-density kinetic mass transfer across Stepped &
      Heartbeat, plus PhysicsRepRootPart void-sinkhole dragging so targets get stuck in
      the Void or die reliably
    • High-Precision 6s–10s Chrono-Rewind System: 60Hz frame-accurate circular buffer
      recording exact CFrame trajectory, velocity, camera angles, Humanoid states,
      playing AnimationTracks (scrubbed in reverse!), equipped tools, and actions
═══════════════════════════════════════════════════════════════════════════════]]

print("[COCO POWDER] V35 Omnipresent Seeker & Advanced Anti-Shield Edition bootstrapping...")

if not game:IsLoaded() then
    local ok = pcall(function() game.Loaded:Wait() end)
    if not ok then task.wait(1) end
end

local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")
local UIS               = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local Debris            = game:GetService("Debris")
local SoundService      = game:GetService("SoundService")
local StarterGui        = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService   = game:GetService("TextChatService")
local CoreGui           = nil
pcall(function() CoreGui = game:GetService("CoreGui") end)

-- Bounded player bootstrap: avoid hanging forever if Delta runs before the client is ready.
local LP = Players.LocalPlayer
local playerWaitStarted = tick()
while not LP and tick() - playerWaitStarted < 12 do
    task.wait(0.1)
    LP = Players.LocalPlayer
end
if not LP then
    warn("[COCO POWDER] Startup stopped: LocalPlayer was unavailable after 12 seconds. Execute after joining a game.")
    return
end

local gui = nil

-- Prefer PlayerGui: it is the most portable ScreenGui parent across executor environments.
-- gethui/CoreGui are fallbacks only, since some executor wrappers expose an unusable container.
local function getGuiContainer()
    local pgui = LP:FindFirstChildOfClass("PlayerGui") or LP:FindFirstChild("PlayerGui")
    if not pgui then
        pcall(function() pgui = LP:WaitForChild("PlayerGui", 6) end)
    end
    if pgui then return pgui end

    local success, hui = pcall(function()
        if typeof(gethui) == "function" then return gethui() end
        return nil
    end)
    if success and typeof(hui) == "Instance" then return hui end

    if CoreGui then
        local ok = pcall(function() return CoreGui:GetChildren() end)
        if ok then return CoreGui end
    end
    return LP:FindFirstChildOfClass("PlayerGui")
end

local GuiParent = getGuiContainer()
if not GuiParent then
    warn("[COCO POWDER] GUI container missing. Re-execute after joining a game.")
    return
end

local function cleanupOldGuis(container)
    if not container then return end
    pcall(function()
        for _, child in ipairs(container:GetChildren()) do
            if child.Name:match("^CocoPowder") then child:Destroy() end
        end
    end)
end
cleanupOldGuis(GuiParent)
cleanupOldGuis(LP:FindFirstChildOfClass("PlayerGui"))
if CoreGui then cleanupOldGuis(CoreGui) end

local sethiddenproperty = sethiddenproperty or set_hidden_property or set_hidden_prop
local InstanceHandleNew = nil
pcall(function()
    if InstanceHandle and typeof(InstanceHandle.new) == "function" then
        InstanceHandleNew = InstanceHandle.new
    end
end)

-- Non-blocking camera resolver: NEVER abort script startup if CurrentCamera is still initializing on Delta/Android!
local cam = workspace.CurrentCamera or workspace:FindFirstChildOfClass("Camera")
if not cam then
    local waitStart = tick()
    while not cam and tick() - waitStart < 2.0 do
        task.wait(0.1)
        cam = workspace.CurrentCamera or workspace:FindFirstChildOfClass("Camera")
    end
end
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    if workspace.CurrentCamera then
        cam = workspace.CurrentCamera
    end
end)

local T = {
    -- Sleek obsidian dark-glass palette with subtle violet & emerald accents
    BG      = Color3.fromRGB(13, 15, 20),
    BG2     = Color3.fromRGB(18, 21, 28),
    Panel   = Color3.fromRGB(24, 28, 37),
    PanelLt = Color3.fromRGB(34, 39, 52),
    Border  = Color3.fromRGB(62, 70, 92),
    Accent  = Color3.fromRGB(138, 92, 246),
    Accent2 = Color3.fromRGB(99, 60, 214),
    Neon    = Color3.fromRGB(216, 198, 255),
    Success = Color3.fromRGB(34, 197, 94),
    Danger  = Color3.fromRGB(239, 68, 68),
    Warning = Color3.fromRGB(245, 158, 11),
    Pink    = Color3.fromRGB(192, 132, 252),
    Purple  = Color3.fromRGB(147, 88, 242),
    Text    = Color3.fromRGB(243, 244, 246),
    Muted   = Color3.fromRGB(148, 156, 172),
    Dark    = Color3.fromRGB(9, 11, 15),
    Active  = Color3.fromRGB(45, 52, 68),
}

local function sfx(id, vol, pitch)
    pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://" .. tostring(id)
        s.Volume = vol or 0.4
        s.PlaybackSpeed = pitch or 1
        s.Parent = SoundService
        s:Play()
        Debris:AddItem(s, 4)
    end)
end
local sClick     = function() sfx(12221967, 0.35, 1.8) end
local sHover     = function() sfx(12221967, 0.12, 2.5) end
local sSuccess   = function() sfx(5696552322, 0.5, 1.2) end
local sError     = function() sfx(5766952670, 0.5, 0.9) end
local sToggleOn  = function() sfx(5696552322, 0.4, 1.6) end
local sToggleOff = function() sfx(5696552322, 0.4, 0.7) end
local sWhoosh    = function() sfx(6895079853, 0.5, 1.4) end
local sFling     = function() sfx(9069609267, 0.6, 1.2) end

local showDefenceToast = nil
local updateDefenceStatsUI = nil

local function notify(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "COCO POWDER",
            Text = text or "",
            Duration = 3,
            Icon = "rbxassetid://10850257404"
        })
    end)
end

local function getRig(player)
    if not player or not player.Character then return nil end
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if not hum then return nil end
    return hum.RigType
end

local function isR15(player)
    return getRig(player) == Enum.HumanoidRigType.R15
end

local V = { X = 0, Y = 0, Z = 1.3, RX = 0, RY = 0, RZ = 0, Speed = 1.0 }

local CurrentWeld         = nil
local CurrentTarget       = nil
local selectedPlayer      = nil
-- Assigned when the Chat tab is built; target selection only syncs this field.
local chatTargetInput     = nil
local PlayedAnims         = {}

local function syncChatTarget(player)
    -- Never start chat automation here; this only fills the target text field.
    if not chatTargetInput or not chatTargetInput.Parent then return end
    if player and player.Parent == Players then
        chatTargetInput.Text = player.Name
    else
        chatTargetInput.Text = ""
    end
end

local OriginalFPDH        = workspace.FallenPartsDestroyHeight
if OriginalFPDH ~= OriginalFPDH or OriginalFPDH < -10000 or OriginalFPDH > 500 then
    OriginalFPDH = -500
end

local OriginalCameraSubject = nil
local AutoReweldEnabled   = true
local LastWeldTargetUserId = nil
local LastPresetKey       = nil
local WeldIntent          = { active = false, presetKey = nil, target = nil }
local StopGeneration      = 0

local FlingActive         = false
local FlingConn           = nil
local FlingOriginCF       = nil
local FlingCamType        = nil
local FlingCamSubject     = nil
local FlingCamCF          = nil
local FlingSidePanel      = nil
local FlingCountdownLabel = nil
local LastKnownSafeCF     = nil
local LastVoidActionEnd   = 0
local SpectatingTarget    = false

local PlayerLocationCache = {} -- [userId] = { cf = CFrame, time = number }

-- Check whether a CFrame is inside safe playable map bounds for local recovery
local function isSafePlayableCF(cf)
    if not cf then return false end
    local pos = cf.Position
    if pos.X ~= pos.X or pos.Y ~= pos.Y or pos.Z ~= pos.Z then return false end
    local voidFloor = OriginalFPDH + 15
    if pos.Y <= voidFloor or pos.Y > 150000 then return false end
    if pos.Magnitude > 250000 then return false end
    return true
end

-- Distinguish true lethal void freefall from hidden underground rooms, house interiors, or skyboxes!
-- Many games place house interiors, bunkers, or secret rooms at Y = -300 or Y = 25000 or X = 40000.
-- A target is ONLY in the lethal void if they are at the FallenPartsDestroyHeight kill line AND falling fast.
local function isLethalVoidCF(cf, velocity)
    if not cf then return true end
    local pos = cf.Position
    if pos.X ~= pos.X or pos.Y ~= pos.Y or pos.Z ~= pos.Z then return true end
    if pos.Magnitude > 450000 then return true end
    local vy = velocity and velocity.Y or 0
    if pos.Y <= (OriginalFPDH + 8) then return true end
    if pos.Y <= (OriginalFPDH + 45) and vy < -95 then return true end
    return false
end

local function findFallbackSafeCF()
    if isSafePlayableCF(LastKnownSafeCF) then
        return LastKnownSafeCF
    end
    local spawnPart = workspace:FindFirstChildWhichIsA("SpawnLocation", true)
    if spawnPart and isSafePlayableCF(spawnPart.CFrame) then
        return spawnPart.CFrame + Vector3.new(0, 4, 0)
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and (not FlingActive or p ~= CurrentTarget) and p.Character then
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            if r and isSafePlayableCF(r.CFrame) then
                return r.CFrame * CFrame.new(0, 2, 4)
            end
        end
    end
    return CFrame.new(0, 35, 0)
end

local Anti
local recoverCharacterState
local safeReturnFromVoid
local syncAllActiveIndicators

local StateManager = {}

function StateManager:StopAllAnimations()
    for _, track in ipairs(PlayedAnims) do
        pcall(function() track:Stop(0) end)
        pcall(function() track:Destroy() end)
    end
    PlayedAnims = {}
end

function StateManager:ResetPhysics(character)
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    if root then
        if sethiddenproperty then
            pcall(function() sethiddenproperty(root, "PhysicsRepRootPart", nil) end)
            pcall(function() sethiddenproperty(root, "PhysicsRepRootRef", nil) end)
        end
        root.Anchored = false
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Massless = false
            if part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head" then
                part.CanCollide = true
            end
        end
    end
end

function StateManager:StopFling(skipReturn)
    local wasActive = FlingActive
    local savedOrigin = FlingOriginCF
    if FlingConn then FlingConn:Disconnect(); FlingConn = nil end
    if self.FlingStepConn then self.FlingStepConn:Disconnect(); self.FlingStepConn = nil end
    if LP.Character then
        for _, part in ipairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                pcall(function() part.CustomPhysicalProperties = nil end)
            end
        end
    end
    FlingActive = false
    FlingOriginCF = nil
    if FlingSidePanel then FlingSidePanel.Visible = false end
    local currentCam = workspace.CurrentCamera
    if currentCam and (FlingCamType or FlingCamSubject) then
        pcall(function()
            currentCam.CameraType = FlingCamType or Enum.CameraType.Custom
            local myHum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            currentCam.CameraSubject = myHum or FlingCamSubject
        end)
    end
    FlingCamType = nil
    FlingCamSubject = nil
    FlingCamCF = nil
    if wasActive and not skipReturn and LP.Character then
        LastVoidActionEnd = tick()
        safeReturnFromVoid(LP.Character, savedOrigin)
    end
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
end

function StateManager:Cleanup(keepTarget)
    if CurrentWeld then
        pcall(function() CurrentWeld:Destroy() end)
        CurrentWeld = nil
    end
    self:StopAllAnimations()
    self:StopFling()
    if OriginalCameraSubject then
        pcall(function()
            local currentCam = workspace.CurrentCamera
            if currentCam then
                currentCam.CameraSubject = OriginalCameraSubject
                currentCam.CameraType = Enum.CameraType.Custom
            end
        end)
        OriginalCameraSubject = nil
    end
    if LP.Character then
        self:ResetPhysics(LP.Character)
        local root = LP.Character:FindFirstChild("HumanoidRootPart")
        if root and not isSafePlayableCF(root.CFrame) then
            safeReturnFromVoid(LP.Character, LastKnownSafeCF)
        end
    end
    if not keepTarget then CurrentTarget = nil end
end

local ANIM_VERIFY_TIME = 0.15
local ANIM_MAX_ATTEMPTS = 2

local function forcePhysicsState(hum)
    if not hum then return end
    pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true) end)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Physics) end)
end

local function tryPlayOnce(Animator, animId, hum, priority)
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. tostring(animId)
    local okLoad, track = pcall(function() return Animator:LoadAnimation(anim) end)
    if not okLoad or not track then anim:Destroy(); return nil, nil, false end
    local pri = priority or Enum.AnimationPriority.Action4
    pcall(function() track.Priority = pri end)
    pcall(function() track.Looped = true end)
    pcall(function() track:AdjustSpeed(1) end)
    forcePhysicsState(hum)
    local okPlay = pcall(function() track:Play(0.1) end)
    if not okPlay then
        pcall(function() track:Stop(0) end); pcall(function() track:Destroy() end)
        return nil, nil, false
    end
    local started = tick()
    while tick() - started < ANIM_VERIFY_TIME do
        local playing = false
        pcall(function() playing = track.IsPlaying end)
        if playing then return track, anim, true end
        task.wait(0.02)
    end
    pcall(function() track:Stop(0) end); pcall(function() track:Destroy() end)
    return nil, nil, false
end

local function loadPlayableAnim(Animator, animId, fallbacks, hum, priority)
    if not Animator or not animId then return nil, nil end
    local cands = { animId }
    for _, f in ipairs(fallbacks or {}) do table.insert(cands, f) end
    for _, id in ipairs(cands) do
        for attempt = 1, ANIM_MAX_ATTEMPTS do
            local track, anim, ok = tryPlayOnce(Animator, id, hum, priority)
            if ok then return track, anim end
            if anim then pcall(function() anim:Destroy() end) end
            if attempt < ANIM_MAX_ATTEMPTS then task.wait(0.04) end
        end
    end
    return nil, nil
end

local AnimateWasDisabled = false

local function stopDefaultTracks(c)
    local hum = c and c:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if animator then
        local ok, tracks = pcall(function() return animator:GetPlayingAnimationTracks() end)
        if ok and tracks then
            for _, t in ipairs(tracks) do
                pcall(function() t:Stop(0) end); pcall(function() t:Destroy() end)
            end
        end
    end
end

local function killAnimate(c)
    if not c then return end
    local animate = c:FindFirstChild("Animate")
    if animate and not animate.Disabled then
        animate.Disabled = true
        AnimateWasDisabled = true
    end
    stopDefaultTracks(c)
end

local function restoreAnimate(c)
    if not AnimateWasDisabled then return end
    if c then
        local animate = c:FindFirstChild("Animate")
        if animate then animate.Disabled = false end
    end
    AnimateWasDisabled = false
end

recoverCharacterState = function(char, safeCF)
    char = char or (LP and LP.Character)
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum  = char:FindFirstChildOfClass("Humanoid")
    if root then
        if sethiddenproperty then
            pcall(function() sethiddenproperty(root, "PhysicsRepRootPart", nil) end)
            pcall(function() sethiddenproperty(root, "PhysicsRepRootRef", nil) end)
        end
        root.Anchored = false
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero

        local targetCF = nil
        if isSafePlayableCF(safeCF) then
            targetCF = safeCF
        elseif isSafePlayableCF(root.CFrame) then
            targetCF = root.CFrame + Vector3.new(0, 1.5, 0)
        else
            targetCF = findFallbackSafeCF()
        end

        if targetCF then
            local pos = targetCF.Position
            local _, yYaw, _ = targetCF:ToEulerAnglesYXZ()
            root.CFrame = CFrame.new(pos) * CFrame.Angles(0, yYaw, 0)
        end
    end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Massless = false
            if part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head" then
                part.CanCollide = true
            end
        end
    end
    restoreAnimate(char)
    stopDefaultTracks(char)
    if hum and hum.Health > 0 then
        pcall(function() hum.PlatformStand = false end)
        pcall(function() hum.Sit = false end)
        pcall(function() hum.AutoRotate = true end)
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
    end
end

-- Multi-frame anchored void rescue: guarantees the server & client physics engine
-- never rubberband or trap the local player in the void after throwing/flinging a target.
safeReturnFromVoid = function(char, preferredCF)
    char = char or (LP and LP.Character)
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum  = char:FindFirstChildOfClass("Humanoid")
    local resolvedCF = isSafePlayableCF(preferredCF) and preferredCF or findFallbackSafeCF()
    local pos = resolvedCF.Position
    local _, yYaw, _ = resolvedCF:ToEulerAnglesYXZ()
    local cleanCF = CFrame.new(pos + Vector3.new(0, 1.2, 0)) * CFrame.Angles(0, yYaw, 0)

    recoverCharacterState(char, cleanCF)
    if not root or not root.Parent then return end

    task.spawn(function()
        pcall(function()
            root.Anchored = true
            for _ = 1, 4 do
                if not root.Parent then break end
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = cleanCF
                RunService.Heartbeat:Wait()
            end
            if root.Parent then
                root.Anchored = false
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = cleanCF
            end
            if hum and hum.Parent and hum.Health > 0 then
                hum.PlatformStand = false
                hum.Sit = false
                hum.AutoRotate = true
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end
            local currentCam = workspace.CurrentCamera
            if currentCam and hum and not SpectatingTarget then
                currentCam.CameraType = Enum.CameraType.Custom
                currentCam.CameraSubject = hum
            end
        end)
        if not (Anti and Anti.Void and Anti.Void.enabled) and not (Anti and Anti.Kill and Anti.Kill.enabled) and not WeldIntent.active and not FlingActive then
            pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
        end
    end)
end

-- Continuously record LastKnownSafeCF when on safe ground & auto-rescue if stranded in void
RunService.Heartbeat:Connect(function()
    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    if not root or not hum or hum.Health <= 0 then return end

    if not FlingActive and not WeldIntent.active then
        local vel = root.AssemblyLinearVelocity.Magnitude
        if isSafePlayableCF(root.CFrame) and vel < 110 then
            local _, yYaw, _ = root.CFrame:ToEulerAnglesYXZ()
            LastKnownSafeCF = CFrame.new(root.Position) * CFrame.Angles(0, yYaw, 0)
        elseif root.Position.Y <= math.max(OriginalFPDH + 22, -260) or root.Position.Magnitude > 22000 then
            -- Auto-rescue if stuck in the void after an action or when Anti-Void is on
            if (Anti and Anti.Void and Anti.Void.enabled) or (tick() - LastVoidActionEnd < 6.0) then
                safeReturnFromVoid(char, LastKnownSafeCF)
            end
        end
    end
end)

local stopWeld -- forward declaration
local findPlayerCharacterAnywhere
local pickTargetRef
local getBestTargetCFrame
local streamAndTeleportToTarget
local markIntentionalTeleport

local function WeldTo(TargetPart, Offset, Speaker, AnimationId, Osc, AnimFallbacks, TargetPlayer, RefMode)
    local Character = Speaker.Character
    if not Character then return nil end
    local Root = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChildWhichIsA("BasePart")
    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
    if not Root or not Humanoid or Humanoid.Health <= 0 then return nil end

    local TargetChar = (TargetPart and TargetPart.Parent) or (TargetPlayer and findPlayerCharacterAnywhere(TargetPlayer))
    local TargetHum  = TargetChar and TargetChar:FindFirstChildOfClass("Humanoid")
    local lastSafeCF = isSafePlayableCF(Root.CFrame) and Root.CFrame or findFallbackSafeCF()

    pcall(function() Humanoid.Sit = false end)
    pcall(function() Humanoid.PlatformStand = true end)
    pcall(function() Humanoid.AutoRotate = false end)
    forcePhysicsState(Humanoid)
    killAnimate(Character)
    task.wait(0.02)

    local AnimTrack, AnimInstance = nil, nil
    local animAttempts = 0
    local function ensureAnim(force)
        if not AnimationId then return end
        if AnimTrack and not force then
            local ip = false; pcall(function() ip = AnimTrack.IsPlaying end)
            if ip then
                pcall(function() AnimTrack:AdjustSpeed(math.clamp(V.Speed or 1.0, 0.2, 6.0)) end)
                return
            end
        end
        animAttempts = animAttempts + 1
        if not force and animAttempts % 12 ~= 0 and AnimTrack then return end
        local Animator = Character:FindFirstChildWhichIsA("Animator", true)
        if not Animator and Humanoid then
            Animator = Instance.new("Animator"); Animator.Parent = Humanoid
        end
        if not Animator then return end
        local track, anim = loadPlayableAnim(Animator, AnimationId, AnimFallbacks, Humanoid)
        if track then
            pcall(function() track:AdjustSpeed(math.clamp(V.Speed or 1.0, 0.2, 6.0)) end)
            AnimTrack = track
            AnimInstance = anim
        end
    end
    ensureAnim(true)

    local function applyPhaseNoclip()
        if not Character or not Character.Parent then return end
        for _, v in ipairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
                v.CanTouch = false
                v.Massless = true
                v.Anchored = false
            elseif v:IsA("SeatWeld") or v.Name == "SeatWeld" then
                pcall(function() v:Destroy() end)
            end
        end
        if Humanoid and Humanoid.Sit then
            pcall(function() Humanoid.Sit = false end)
        end
    end
    applyPhaseNoclip()

    local Weld = { destroyed = false }
    local Conn = nil
    local StepConn = nil
    local clock = 0
    local missingFrames = 0

    function Weld:Destroy()
        if self.destroyed then return end
        self.destroyed = true
        if Conn then Conn:Disconnect(); Conn = nil end
        if StepConn then StepConn:Disconnect(); StepConn = nil end
        pcall(function() LP.ReplicationFocus = nil end)
        if AnimTrack then
            pcall(function() AnimTrack:Stop(0) end)
            pcall(function() AnimTrack:Destroy() end)
            AnimTrack = nil
        end
        if AnimInstance then
            pcall(function() AnimInstance:Destroy() end)
            AnimInstance = nil
        end
        if CurrentWeld == self then
            CurrentWeld = nil
        end
        LastVoidActionEnd = tick()
        safeReturnFromVoid(Character, lastSafeCF)
        if LP.Character and LP.Character ~= Character then
            safeReturnFromVoid(LP.Character, lastSafeCF)
        end
    end

    -- Stepped pass ensures we phase through walls, doors, roofs, and seats inside any hiding spot
    StepConn = RunService.Stepped:Connect(function()
        if Weld.destroyed then return end
        applyPhaseNoclip()
    end)

    Conn = RunService.Heartbeat:Connect(function(dt)
        -- 1. Check if our own character died or respawned
        if not Character.Parent or Character ~= LP.Character or not Root.Parent or not Humanoid.Parent or Humanoid.Health <= 0 then
            Weld:Destroy()
            return
        end

        -- 2. Check if target player left the server completely
        if TargetPlayer and TargetPlayer.Parent ~= Players then
            Weld:Destroy()
            if stopWeld then pcall(stopWeld) end
            if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
            notify("COCO POWDER", "Target left server — safely returned")
            return
        end

        -- 3. Check if target died
        if TargetHum and TargetHum.Parent and TargetHum.Health <= 0 then
            Weld:Destroy()
            return
        end

        -- 4. OMNIPRESENT RE-LOCK: If TargetPart streamed out because target teleported to a hiding spot,
        --    entered a house/locker/vehicle, or switched character model, dynamically re-acquire or follow!
        if not TargetPart or not TargetPart.Parent or (TargetPlayer and findPlayerCharacterAnywhere(TargetPlayer) ~= TargetChar) then
            if TargetPlayer then
                local newChar = findPlayerCharacterAnywhere(TargetPlayer)
                local newHum  = newChar and newChar:FindFirstChildOfClass("Humanoid")
                if newHum and newHum.Health <= 0 then
                    Weld:Destroy()
                    return
                end
                local newPart = newChar and pickTargetRef(newChar, RefMode or "torso")
                if newPart and newPart.Parent then
                    TargetChar = newChar
                    TargetHum  = newHum
                    TargetPart = newPart
                    missingFrames = 0
                else
                    -- Target is in an unstreamed hiding spot! Teleport right to their model pivot / cached location to stream them in!
                    missingFrames = missingFrames + 1
                    local hiddenCF = getBestTargetCFrame(TargetPlayer)
                    if hiddenCF and not isLethalVoidCF(hiddenCF) then
                        pcall(function() LP:RequestStreamAroundAsync(hiddenCF.Position, 1) end)
                        Root.CFrame = hiddenCF * Offset
                        Root.AssemblyLinearVelocity = Vector3.zero
                        Root.AssemblyAngularVelocity = Vector3.zero
                        markIntentionalTeleport(Root.CFrame)
                    end
                    if missingFrames > 90 then
                        Weld:Destroy()
                    end
                    return
                end
            else
                Weld:Destroy()
                return
            end
        else
            missingFrames = 0
        end

        -- 5. VOID PROTECTION: Only detach if the target is genuinely plummeting in the lethal void killzone,
        --    NOT when they are inside underground rooms, secret bunkers, houses, or skyboxes!
        local tVel = TargetPart.AssemblyLinearVelocity
        if isLethalVoidCF(TargetPart.CFrame, tVel) then
            Weld:Destroy()
            notify("COCO POWDER", "Target fell into lethal Void — detached safely!")
            return
        end

        -- Keep server streaming focused on the target so they can never outrun our client stream
        pcall(function() LP.ReplicationFocus = TargetPart end)

        -- Cache target location & update safe standing CFrame
        if TargetPlayer then
            PlayerLocationCache[TargetPlayer.UserId] = { cf = TargetPart.CFrame, time = tick() }
        end
        if not isLethalVoidCF(TargetPart.CFrame, tVel) then
            local _, yYaw, _ = TargetPart.CFrame:ToEulerAnglesYXZ()
            lastSafeCF = CFrame.new(TargetPart.Position + Vector3.new(0, 2.5, 0)) * CFrame.Angles(0, yYaw, 0)
            LastKnownSafeCF = lastSafeCF
        end

        local animate = Character:FindFirstChild("Animate")
        if animate and not animate.Disabled then
            animate.Disabled = true
            AnimateWasDisabled = true
        end

        local speedMult = math.clamp(V.Speed or 1.0, 0.2, 6.0)
        clock = clock + (dt * speedMult)
        local customAdjust = CFrame.new(V.X or 0, V.Y or 0, (V.Z or 1.3) - 1.3)
        local localOffset = Offset * customAdjust
        if Osc and Osc.period and Osc.period > 0 then
            local phase = (math.sin(clock * (2 * math.pi) / Osc.period) + 1) * 0.5
            localOffset = localOffset * CFrame.new(0, 0, -Osc.distance * phase)
        end
        Root.CFrame = TargetPart.CFrame * localOffset
        Root.AssemblyLinearVelocity = Vector3.zero
        Root.AssemblyAngularVelocity = Vector3.zero
        markIntentionalTeleport(Root.CFrame)
        if sethiddenproperty then pcall(function()
            sethiddenproperty(Root, "PhysicsRepRootPart", TargetPart)
            if InstanceHandleNew then
                sethiddenproperty(Root, "PhysicsRepRootRef", InstanceHandleNew(TargetPart))
            end
        end) end
        pcall(function() ensureAnim(false) end)
        pcall(function() if not Humanoid.PlatformStand then Humanoid.PlatformStand = true end end)
    end)

    return Weld
end

local function unweld()
    if CurrentWeld then pcall(function() CurrentWeld:Destroy() end); CurrentWeld = nil end
    if LP.Character then
        pcall(function() safeReturnFromVoid(LP.Character, LastKnownSafeCF) end)
    end
    if not (Anti and Anti.Void and Anti.Void.enabled) and not (Anti and Anti.Kill and Anti.Kill.enabled) then
        pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
    end
end

local WELD_PRESETS = {
    facebang  = { offset = CFrame.new(0, 2.5, -3.8) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 128342454196913, anim6 = 128342454196913,
                  animFallbacks = {4555808220, 109168916859109},
                  osc = {distance = 2.9, period = 0.22}, refMode = "head", label = "Face Bang" },
    backshots = { offset = CFrame.new(0, 0, 3.2),
                  anim15 = 128342454196913, anim6 = 128342454196913,
                  animFallbacks = {4555808220, 109168916859109},
                  osc = {distance = 2.9, period = 0.22}, refMode = "torso", label = "Backshots" },
    headsit   = { offset = CFrame.new(0, 1.2, 0),
                  anim15 = 2506281703, anim6 = 2506281703,
                  animFallbacks = {2510238627, 507768375, 180426354},
                  osc = nil, refMode = "head", label = "Headsit" },
    kiss      = { offset = CFrame.new(0, 0, -1.1) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 81124524945738, anim6 = 81124524945738,
                  animFallbacks = {3576686446, 3019619673, 15849372443},
                  osc = nil, refMode = "torso", label = "Kiss" },
    backpack  = { offset = CFrame.new(0, 0, 1.05) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 2506281703, anim6 = 2506281703,
                  animFallbacks = {2510238627, 507768375, 180426354},
                  osc = nil, refMode = "torso", label = "Backpack" },
    headpat   = { offset = CFrame.new(0,0,-1.9) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 114313599861536, anim6 = 114313599861536,
                  animFallbacks = {}, osc = nil, refMode = "torso", label = "Headpat" },
    propose   = { offset = CFrame.new(0, 0, -3.5) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 70639053125611, anim6 = 70639053125611,
                  animFallbacks = {}, osc = nil, refMode = "torso", label = "Propose" },
    hug       = { offset = CFrame.new(0, 0, -1.4) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 95247520541805, anim6 = 95247520541805,
                  animFallbacks = {}, osc = nil, refMode = "torso", label = "Hug" },
}

-- Add "chase" preset to WELD_PRESETS so users can also use pure Follow-Everywhere mode
WELD_PRESETS.chase = {
    offset = CFrame.new(0, 0, 2.2),
    anim15 = nil,
    anim6  = nil,
    animFallbacks = {},
    osc = nil,
    refMode = "torso",
    label = "Auto-Chase (Follow)"
}

-- Locate a player's character even if the game parents characters to a custom folder in Workspace
findPlayerCharacterAnywhere = function(plr)
    if not plr then return nil end
    if plr.Character and plr.Character.Parent then
        return plr.Character
    end
    local byName = workspace:FindFirstChild(plr.Name, true)
    if byName and byName:IsA("Model") and (byName:FindFirstChildOfClass("Humanoid") or byName.PrimaryPart or byName:FindFirstChildWhichIsA("BasePart", true)) then
        return byName
    end
    return plr.Character
end

-- Deep fallback reference part resolver: works even when HumanoidRootPart or Head is missing/renamed/seated
pickTargetRef = function(char, mode)
    if not char then return nil end
    if mode == "head" then
        local h = char:FindFirstChild("Head") or char:FindFirstChild("head", true)
        if h and h:IsA("BasePart") then return h end
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
        or char.PrimaryPart
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("LowerTorso")
        or char:FindFirstChild("Torso")
        or char:FindFirstChild("Head")
    if hrp and hrp:IsA("BasePart") then return hrp end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.SeatPart and hum.SeatPart:IsA("BasePart") then
        return hum.SeatPart
    end
    return char:FindFirstChildWhichIsA("BasePart", true)
end

-- Resolve a player's CFrame even when their Character's BaseParts are 100% streamed out by StreamingEnabled!
getBestTargetCFrame = function(plr)
    if not plr then return nil end
    local char = findPlayerCharacterAnywhere(plr)
    if char then
        local part = pickTargetRef(char, "torso")
        if part and part.Parent then
            local cf = part.CFrame
            if not isLethalVoidCF(cf, part.AssemblyLinearVelocity) then
                PlayerLocationCache[plr.UserId] = { cf = cf, time = tick() }
                return cf
            end
        end
        -- Even when all BaseParts are streamed out in StreamingEnabled, Model:GetPivot() is replicated!
        local okPivot, pivotCF = pcall(function() return char:GetPivot() end)
        if okPivot and pivotCF and pivotCF.Position.Magnitude > 0.5 and not isLethalVoidCF(pivotCF) then
            PlayerLocationCache[plr.UserId] = { cf = pivotCF, time = tick() }
            return pivotCF
        end
        local okWP, wpCF = pcall(function() return char.WorldPivot end)
        if okWP and wpCF and wpCF.Position.Magnitude > 0.5 and not isLethalVoidCF(wpCF) then
            PlayerLocationCache[plr.UserId] = { cf = wpCF, time = tick() }
            return wpCF
        end
    end
    local cached = PlayerLocationCache[plr.UserId]
    if cached and cached.cf and not isLethalVoidCF(cached.cf) then
        return cached.cf
    end
    return nil
end

-- Continuous background scanner that caches every player's position & pivot across the server
RunService.Heartbeat:Connect(function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            pcall(function() getBestTargetCFrame(p) end)
        end
    end
end)

-- Active Stream-Piercer & Server Hiding-Spot Seeker:
-- Teleports local player to the target's coordinates (or sweeps server interiors/spawns/seats)
-- and forces Roblox StreamingEnabled to load the target's character and reference part.
streamAndTeleportToTarget = function(targetPlr, refMode, maxWaitSeconds)
    if not targetPlr or targetPlr.Parent ~= Players then return nil, nil end
    maxWaitSeconds = maxWaitSeconds or 2.2
    local myChar = LP.Character
    local myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
    local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")

    -- Prepare local character for phase-teleporting into any locked/hidden room
    if myChar then
        for _, v in ipairs(myChar:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
                v.CanTouch = false
                v.Anchored = false
            end
        end
        if myHum and myHum.Sit then pcall(function() myHum.Sit = false end) end
    end

    local tChar = findPlayerCharacterAnywhere(targetPlr)
    local tRef  = tChar and pickTargetRef(tChar, refMode or "torso")
    if tRef and tRef.Parent then
        if myRoot then
            local destCF = tRef.CFrame * CFrame.new(0, 1.5, 2)
            markIntentionalTeleport(destCF)
            myRoot.AssemblyLinearVelocity = Vector3.zero
            myRoot.AssemblyAngularVelocity = Vector3.zero
            myRoot.CFrame = destCF
        end
        return tChar, tRef
    end

    -- Target is hiding in an unstreamed chunk! Step 1: Teleport to their Model:GetPivot() or cached location
    local started = tick()
    while tick() - started < (maxWaitSeconds * 0.65) do
        if targetPlr.Parent ~= Players then return nil, nil end
        tChar = findPlayerCharacterAnywhere(targetPlr)
        tRef  = tChar and pickTargetRef(tChar, refMode or "torso")
        if tRef and tRef.Parent then
            return tChar, tRef
        end
        local targetCF = getBestTargetCFrame(targetPlr)
        if targetCF then
            task.spawn(function()
                pcall(function() LP:RequestStreamAroundAsync(targetCF.Position, 1.5) end)
            end)
            myChar = LP.Character
            myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
            if myRoot then
                markIntentionalTeleport(targetCF)
                myRoot.AssemblyLinearVelocity = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
                myRoot.CFrame = targetCF * CFrame.new(0, 2, 0)
            end
        else
            break
        end
        RunService.Heartbeat:Wait()
    end

    tChar = findPlayerCharacterAnywhere(targetPlr)
    tRef  = tChar and pickTargetRef(tChar, refMode or "torso")
    if tRef and tRef.Parent then return tChar, tRef end

    -- Step 2: If target was already hiding in an unknown unstreamed chunk before script started,
    -- rapidly sweep server seats, spawns, and distant structures to stream in their hiding spot!
    local probePoints = {}
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("SpawnLocation") or obj:IsA("Seat") or obj:IsA("VehicleSeat") then
                if not isLethalVoidCF(obj.CFrame) then
                    table.insert(probePoints, obj.CFrame)
                end
            end
        end
    end)
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Model") and child ~= LP.Character then
            local okP, pCF = pcall(function() return child:GetPivot() end)
            if okP and pCF and pCF.Position.Magnitude > 10 and not isLethalVoidCF(pCF) then
                table.insert(probePoints, pCF)
            end
        elseif child:IsA("BasePart") and child.Position.Magnitude > 50 and not isLethalVoidCF(child.CFrame) then
            table.insert(probePoints, child.CFrame)
        end
    end

    for idx, probeCF in ipairs(probePoints) do
        if tick() - started > maxWaitSeconds or idx > 28 then break end
        tChar = findPlayerCharacterAnywhere(targetPlr)
        tRef  = tChar and pickTargetRef(tChar, refMode or "torso")
        if tRef and tRef.Parent then return tChar, tRef end

        local knownCF = getBestTargetCFrame(targetPlr)
        local hopCF = knownCF or probeCF
        task.spawn(function()
            pcall(function() LP:RequestStreamAroundAsync(hopCF.Position, 1) end)
        end)
        myChar = LP.Character
        myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
        if myRoot then
            markIntentionalTeleport(hopCF)
            myRoot.CFrame = hopCF + Vector3.new(0, 3, 0)
            myRoot.AssemblyLinearVelocity = Vector3.zero
        end
        RunService.Heartbeat:Wait()
    end

    tChar = findPlayerCharacterAnywhere(targetPlr)
    tRef  = tChar and pickTargetRef(tChar, refMode or "torso")
    return tChar, tRef
end

local function getNearestPlayer(speaker)
    speaker = speaker or LP
    local myChar = speaker and speaker.Character
    local myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
    local myPos  = myRoot and myRoot.Position or Vector3.zero
    local bestPlr, bestDist = nil, math.huge

    -- 1. First pass: alive players with a known or streamed CFrame
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= speaker then
            local c = findPlayerCharacterAnywhere(p)
            local h = c and c:FindFirstChildOfClass("Humanoid")
            local cf = getBestTargetCFrame(p)
            if cf and (not h or h.Health > 0) then
                local d = (cf.Position - myPos).Magnitude
                if d < bestDist then
                    bestDist = d
                    bestPlr = p
                end
            end
        end
    end
    -- 2. Fallback: even if all players are hiding in unstreamed chunks, still return a valid server player!
    if not bestPlr then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= speaker then
                return p, math.huge
            end
        end
    end
    return bestPlr, bestDist
end

local function findPlayerByNameOrDisplay(query, speaker)
    speaker = speaker or LP
    if not query then return nil end
    local q = tostring(query):gsub("^%s*@+%s*", ""):gsub("^%s+", ""):gsub("%s+$", ""):lower()
    if q == "" then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= speaker and (p.Name:lower() == q or p.DisplayName:lower() == q) then
            return p
        end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= speaker and (p.Name:lower():sub(1, #q) == q or p.DisplayName:lower():sub(1, #q) == q) then
            return p
        end
    end
    return nil
end

local function resolvePlayer(target, speaker)
    speaker = speaker or LP
    -- Never reject a target just because their Character is currently unstreamed/hiding!
    if typeof(target) == "Instance" and target:IsA("Player") then
        if target.Parent == Players and target ~= speaker then return target end
        return getNearestPlayer(speaker)
    end
    if target ~= nil and tostring(target) ~= "" then
        local found = findPlayerByNameOrDisplay(target, speaker)
        if found and found.Parent == Players then return found end
    end
    if selectedPlayer and selectedPlayer.Parent == Players then
        return selectedPlayer
    end
    return getNearestPlayer(speaker)
end

local function resolveActiveTarget()
    if selectedPlayer and selectedPlayer.Parent == Players then
        return selectedPlayer, false
    end
    if chatTargetInput and chatTargetInput.Parent then
        local typed = (chatTargetInput.Text or ""):gsub("^%s*@+%s*", ""):gsub("^%s+", ""):gsub("%s+$", "")
        if typed ~= "" then
            local byName = findPlayerByNameOrDisplay(typed, LP)
            if byName and byName.Parent == Players then
                return byName, false
            end
        end
    end
    local nearest = getNearestPlayer(LP)
    return nearest, true
end

local function weldToTarget(target, speaker, offset, animId, osc, refMode, animFallbacks, callerGen)
    local TPlayer = resolvePlayer(target, speaker)
    if not TPlayer or TPlayer.Parent ~= Players then return false, nil end

    task.spawn(function()
        local myGen = callerGen or StopGeneration
        pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)

        -- Stream & teleport directly to the target even if they are hiding in an unstreamed area
        local char, TRoot = streamAndTeleportToTarget(TPlayer, refMode or "torso", 2.4)
        if myGen ~= StopGeneration then return end
        if not TRoot or not TRoot.Parent then
            -- Keep WeldIntent active so the continuous watchdog immediately locks on as soon as they stream/respawn
            return
        end

        local tHum = char and char:FindFirstChildOfClass("Humanoid")
        if tHum and tHum.Health <= 0 then return end

        local myChar = speaker and speaker.Character
        local myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
        if myRoot then
            if sethiddenproperty then
                pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", nil) end)
                pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootRef", nil) end)
            end
            myRoot.AssemblyLinearVelocity = Vector3.zero
            myRoot.AssemblyAngularVelocity = Vector3.zero
            local destCF = TRoot.CFrame * offset
            markIntentionalTeleport(destCF)
            myRoot.CFrame = destCF
        end

        local w = WeldTo(TRoot, offset, speaker, animId, osc, animFallbacks, TPlayer, refMode or "torso")
        if myGen ~= StopGeneration then
            if w then pcall(function() w:Destroy() end) end
            return
        end
        local old = CurrentWeld
        CurrentWeld = w
        if old and old ~= w then pcall(function() old:Destroy() end) end
    end)
    return true, TPlayer
end

local function applyWeldPreset(presetKey, target, callerGen)
    local preset = WELD_PRESETS[presetKey]; if not preset then return false end
    if callerGen and callerGen ~= StopGeneration then return false end
    local myGen = StopGeneration
    local TPlayer = resolvePlayer(target, LP)
    if not TPlayer or TPlayer.Parent ~= Players then return false end

    WeldIntent.active = true
    WeldIntent.presetKey = presetKey
    WeldIntent.target = TPlayer
    LastPresetKey = presetKey
    LastWeldTargetUserId = TPlayer.UserId

    local anim = isR15(LP) and preset.anim15 or preset.anim6
    local ok = weldToTarget(TPlayer, LP, preset.offset, anim, preset.osc, preset.refMode, preset.animFallbacks, myGen)
    return ok
end

stopWeld = function()
    StopGeneration = StopGeneration + 1
    WeldIntent.active = false
    WeldIntent.presetKey = nil
    WeldIntent.target = nil
    pcall(function() LP.ReplicationFocus = nil end)
    unweld()
    if not (Anti and Anti.Void and Anti.Void.enabled) and not (Anti and Anti.Kill and Anti.Kill.enabled) then
        pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
    end
    if LP.Character then
        pcall(function() recoverCharacterState(LP.Character, nil) end)
    end
end

local function hookTargetRespawn(targetPlr)
    if not targetPlr then return end
    if targetPlr:FindFirstChild("__CocoPowderHook") then return end
    local marker = Instance.new("BoolValue")
    marker.Name = "__CocoPowderHook"
    marker.Parent = targetPlr
    targetPlr.CharacterAdded:Connect(function()
        if not AutoReweldEnabled or not WeldIntent.active then return end
        if WeldIntent.target ~= targetPlr and LastWeldTargetUserId ~= targetPlr.UserId then return end
        task.wait(0.25)
        if not WeldIntent.active or targetPlr.Parent ~= Players then return end
        if CurrentWeld then
            pcall(function() CurrentWeld:Destroy() end)
            CurrentWeld = nil
        end
        local key = WeldIntent.presetKey or LastPresetKey
        if key and WELD_PRESETS[key] then
            applyWeldPreset(key, targetPlr)
            if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
        end
    end)
end

-- Relentless Omnipresent Watchdog:
-- Handles target hiding in unstreamed rooms, teleporting across the map, respawning, AND local player respawning!
local reweldWatchdogBusy = false
task.spawn(function()
    while true do
        task.wait(0.16)
        if AutoReweldEnabled and WeldIntent.active and WeldIntent.presetKey and not FlingActive and not reweldWatchdogBusy then
            local tgt = WeldIntent.target
            if not tgt or tgt.Parent ~= Players then
                stopWeld()
                if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
            elseif not CurrentWeld then
                local myChar = LP.Character
                local myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
                local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if myRoot and myHum and myHum.Health > 0 then
                    reweldWatchdogBusy = true
                    pcall(function()
                        local preset = WELD_PRESETS[WeldIntent.presetKey]
                        local refMode = preset and preset.refMode or "torso"
                        local tChar, tRef = streamAndTeleportToTarget(tgt, refMode, 1.5)
                        local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
                        if WeldIntent.active and not CurrentWeld and tRef and tRef.Parent and (not tHum or tHum.Health > 0) then
                            if not isLethalVoidCF(tRef.CFrame, tRef.AssemblyLinearVelocity) then
                                applyWeldPreset(WeldIntent.presetKey, tgt)
                                if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
                            end
                        end
                    end)
                    reweldWatchdogBusy = false
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- HIGH-PRECISION 6s–10s CHRONO-REWIND ENGINE (60Hz Frame-Exact State, Anim & Action Recorder)
-- ═══════════════════════════════════════════════════════════════════════════════
local RewindSys = {
    enabled = true,
    rewinding = false,
    duration = 8.0,          -- Configurable: 6s, 8s, or 10s (up to 10s precision buffer)
    maxBufferSeconds = 10.5, -- Keeps full 10+ seconds of 60Hz history at all times
    speedMultiplier = 1.0,   -- 1.0x exact real-time reverse scrub
    instantMode = false,     -- false = smooth reverse replay of everything done; true = instant snap
    rewindCamera = true,     -- Rewinds camera angles along the exact path looked
    buffer = {},             -- Circular/time-pruned array of frame snapshots
    hudFrame = nil,
    hudLabel = nil,
    hudBarFill = nil,
    activeTracks = {},
}

do -- Scoped block for RewindSys & Void Throw v2 internals (preserves top-level local register budget)
    local lastRecordTick = 0
    local RECORD_INTERVAL = 1 / 60 -- 60Hz high-precision sampling

    local function isFiniteCF(cf)
        if not cf then return false end
        local p = cf.Position
        return (p.X == p.X and p.Y == p.Y and p.Z == p.Z and p.Magnitude < 250000)
    end

    local function capturePlayingAnimations(hum)
        local list = {}
        if not hum then return list end
        local animator = hum:FindFirstChildOfClass("Animator")
        if not animator then return list end
        local ok, tracks = pcall(function() return animator:GetPlayingAnimationTracks() end)
        if not ok or not tracks then return list end
        for _, tr in ipairs(tracks) do
            pcall(function()
                if tr.IsPlaying and tr.Animation and tr.Animation.AnimationId ~= "" then
                    table.insert(list, {
                        id = tr.Animation.AnimationId,
                        timePos = tr.TimePosition,
                        speed = tr.Speed,
                        weight = tr.WeightCurrent,
                        pri = tr.Priority,
                    })
                end
            end)
        end
        return list
    end

    local function getEquippedToolName(char)
        if not char then return nil end
        local tool = char:FindFirstChildOfClass("Tool")
        return tool and tool.Name or nil
    end

    local function syncEquippedTool(char, desiredToolName)
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local currentTool = char:FindFirstChildOfClass("Tool")
        if desiredToolName then
            if not currentTool or currentTool.Name ~= desiredToolName then
                local bp = LP:FindFirstChildOfClass("Backpack")
                local found = bp and bp:FindFirstChild(desiredToolName)
                if found and found:IsA("Tool") then
                    pcall(function() hum:EquipTool(found) end)
                end
            end
        else
            if currentTool then
                pcall(function() hum:UnequipTools() end)
            end
        end
    end

    local function ensureRewindHUD()
        if RewindSys.hudFrame and RewindSys.hudFrame.Parent then
            return RewindSys.hudFrame
        end
        if not gui or not gui.Parent then return nil end
        local f = Instance.new("Frame")
        f.Name = "CocoRewindHUD"
        f.Size = UDim2.new(0, 276, 0, 44)
        f.Position = UDim2.new(0.5, -138, 0, 56)
        f.BackgroundColor3 = Color3.fromRGB(16, 19, 27)
        f.BackgroundTransparency = 0.08
        f.BorderSizePixel = 0
        f.Visible = false
        f.ZIndex = 950
        f.Parent = gui
        Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)

        local st = Instance.new("UIStroke")
        st.Color = T.Accent
        st.Thickness = 1.5
        st.Transparency = 0.15
        st.Parent = f

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -16, 0, 20)
        lbl.Position = UDim2.new(0, 8, 0, 4)
        lbl.BackgroundTransparency = 1
        lbl.Text = "⏪ REWINDING TIME (-0.0s / 8.0s)"
        lbl.TextColor3 = T.Neon
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 10
        lbl.ZIndex = 951
        lbl.Parent = f

        local barBg = Instance.new("Frame")
        barBg.Size = UDim2.new(1, -20, 0, 6)
        barBg.Position = UDim2.new(0, 10, 0, 29)
        barBg.BackgroundColor3 = T.PanelLt
        barBg.BorderSizePixel = 0
        barBg.ZIndex = 951
        barBg.Parent = f
        Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

        local barFill = Instance.new("Frame")
        barFill.Size = UDim2.new(1, 0, 1, 0)
        barFill.BackgroundColor3 = T.Accent
        barFill.BorderSizePixel = 0
        barFill.ZIndex = 952
        barFill.Parent = barBg
        Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

        RewindSys.hudFrame = f
        RewindSys.hudLabel = lbl
        RewindSys.hudBarFill = barFill
        return f
    end

    -- Continuous 60Hz High-Precision Recorder
    RunService.Heartbeat:Connect(function()
        if not RewindSys.enabled or RewindSys.rewinding or FlingActive or deflectBusy then
            return
        end
        local now = tick()
        if now - lastRecordTick < (RECORD_INTERVAL * 0.85) then return end
        lastRecordTick = now

        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if not root or not hum or hum.Health <= 0 then return end
        if not isFiniteCF(root.CFrame) then return end

        local currentCam = workspace.CurrentCamera
        local snap = {
            t = now,
            cf = root.CFrame,
            vel = root.AssemblyLinearVelocity,
            angVel = root.AssemblyAngularVelocity,
            camCF = currentCam and currentCam.CFrame or nil,
            camFov = currentCam and currentCam.FieldOfView or 70,
            humState = hum:GetState(),
            walkSpeed = hum.WalkSpeed,
            jumpPower = hum.JumpPower,
            sit = hum.Sit,
            platformStand = hum.PlatformStand,
            toolName = getEquippedToolName(char),
            weldActive = WeldIntent.active,
            weldPreset = WeldIntent.presetKey,
            weldTarget = WeldIntent.target,
            vX = V.X, vY = V.Y, vZ = V.Z, vSpeed = V.Speed,
            anims = capturePlayingAnimations(hum),
        }

        local buf = RewindSys.buffer
        buf[#buf + 1] = snap

        -- Prune snapshots older than maxBufferSeconds (10.5s)
        local cutoff = now - RewindSys.maxBufferSeconds
        while #buf > 2 and buf[1].t < cutoff do
            table.remove(buf, 1)
        end
    end)

    local function cleanupRewindAnimTracks()
        for _, tr in pairs(RewindSys.activeTracks) do
            pcall(function() tr:Stop(0) end)
            pcall(function() tr:Destroy() end)
        end
        RewindSys.activeTracks = {}
    end

    local function applySnapshotFrame(char, root, hum, snap, scrubAnims)
        if not char or not root or not snap then return end
        markIntentionalTeleport(snap.cf)
        root.CFrame = snap.cf
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero

        if snap.vX then V.X = snap.vX; V.Y = snap.vY; V.Z = snap.vZ; V.Speed = snap.vSpeed end

        if RewindSys.rewindCamera and snap.camCF then
            local currentCam = workspace.CurrentCamera
            if currentCam and not SpectatingTarget then
                pcall(function()
                    currentCam.CFrame = snap.camCF
                    if snap.camFov then currentCam.FieldOfView = snap.camFov end
                end)
            end
        end

        if snap.toolName ~= nil or char:FindFirstChildOfClass("Tool") then
            syncEquippedTool(char, snap.toolName)
        end

        if scrubAnims and hum and snap.anims then
            local animator = hum:FindFirstChildOfClass("Animator")
            if animator then
                for _, aInfo in ipairs(snap.anims) do
                    local tr = RewindSys.activeTracks[aInfo.id]
                    if not tr or not tr.IsPlaying then
                        pcall(function()
                            local animObj = Instance.new("Animation")
                            animObj.AnimationId = aInfo.id
                            tr = animator:LoadAnimation(animObj)
                            tr.Priority = aInfo.pri or Enum.AnimationPriority.Action
                            tr:Play(0.05)
                            RewindSys.activeTracks[aInfo.id] = tr
                        end)
                    end
                    if tr then
                        pcall(function()
                            tr:AdjustSpeed(0)
                            tr.TimePosition = aInfo.timePos
                            tr:AdjustWeight(math.clamp(aInfo.weight or 1, 0.05, 1))
                        end)
                    end
                end
            end
        end
    end

    function RewindSys:Stop(restoreSnap)
        if not self.rewinding then return end
        self.rewinding = false
        cleanupRewindAnimTracks()
        if self.hudFrame then self.hudFrame.Visible = false end

        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Massless = false
                    if part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head" then
                        part.CanCollide = true
                    end
                end
            end
            restoreAnimate(char)
        end
        if root and restoreSnap then
            markIntentionalTeleport(root.CFrame)
            if isSafePlayableCF(root.CFrame) then
                LastKnownSafeCF = root.CFrame
            end
            if restoreSnap.vel and restoreSnap.vel.Magnitude < 120 and restoreSnap.vel.Y > -65 then
                root.AssemblyLinearVelocity = restoreSnap.vel
            else
                root.AssemblyLinearVelocity = Vector3.zero
            end
            root.AssemblyAngularVelocity = Vector3.zero
        end
        if hum and hum.Health > 0 then
            pcall(function()
                hum.PlatformStand = false
                hum.Sit = restoreSnap and restoreSnap.sit or false
                hum.AutoRotate = true
                if restoreSnap and restoreSnap.walkSpeed and not (moveState and moveState.speed) then
                    hum.WalkSpeed = restoreSnap.walkSpeed
                end
                if restoreSnap and restoreSnap.humState and restoreSnap.humState ~= Enum.HumanoidStateType.Dead then
                    hum:ChangeState(restoreSnap.humState)
                else
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end
            end)
        end
        if not (Anti and Anti.Void and Anti.Void.enabled) and not (Anti and Anti.Kill and Anti.Kill.enabled) and not WeldIntent.active and not FlingActive then
            pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
        end
        if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    end

    function RewindSys:Start(customSeconds)
        if self.rewinding then
            -- Tapping Rewind while rewinding stops immediately at the exact current point in time!
            self:Stop(nil)
            notify("COCO POWDER", "⏹️ Rewind locked at current point!")
            sToggleOff()
            return
        end

        local targetSec = math.clamp(tonumber(customSeconds) or self.duration or 8.0, 1.0, 10.0)
        local buf = self.buffer
        if #buf < 2 then
            notify("COCO POWDER", "Rewind buffer warming up — move around for a moment!")
            sError()
            return
        end

        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if not char or not root or not hum or hum.Health <= 0 then
            notify("COCO POWDER", "Character not ready to rewind!")
            sError()
            return
        end

        -- Stop any active Fling or Weld cleanly before rewinding
        if FlingActive then StateManager:StopFling(true) end
        if WeldIntent.active then stopWeld() end
        pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)

        local newestTime = buf[#buf].t
        local oldestAllowedTime = newestTime - targetSec
        local startIdx = #buf
        local destIdx = 1
        for i = #buf, 1, -1 do
            if buf[i].t >= oldestAllowedTime then
                destIdx = i
            else
                break
            end
        end

        local actualSpan = math.max(0.1, newestTime - buf[destIdx].t)
        self.rewinding = true
        if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
        sWhoosh()

        -- Instant Snapback Mode (if selected)
        if self.instantMode then
            local targetSnap = buf[destIdx]
            for i = #buf, destIdx + 1, -1 do
                table.remove(buf, i)
            end
            applySnapshotFrame(char, root, hum, targetSnap, false)
            self:Stop(targetSnap)
            notify("COCO POWDER", string.format("⏪ Instant Rewind (-%.1fs) complete!", actualSpan))
            sSuccess()
            return
        end

        -- Smooth Frame-Accurate Reverse Replay Mode (60Hz interpolated reverse timeline)
        local hud = ensureRewindHUD()
        if hud then hud.Visible = true end
        killAnimate(char)

        notify("COCO POWDER", string.format("⏪ Rewinding %.1f seconds with exact precision...", actualSpan))

        task.spawn(function()
            local cursorTime = newestTime
            local lastSnap = buf[startIdx]

            while self.rewinding do
                local dt = RunService.Heartbeat:Wait()
                if not self.rewinding then break end
                if not char.Parent or LP.Character ~= char or not root.Parent or not hum.Parent or hum.Health <= 0 then
                    break
                end

                -- Phase noclip during rewind so doors/walls never block reverse movement
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = false
                    end
                end

                cursorTime = cursorTime - (dt * (self.speedMultiplier or 1.0))
                local rewoundSoFar = newestTime - cursorTime
                local frac = math.clamp(1 - (rewoundSoFar / actualSpan), 0, 1)

                if self.hudLabel then
                    self.hudLabel.Text = string.format("⏪ REWINDING: -%.1fs / %.1fs (Tap to Stop)", math.min(rewoundSoFar, actualSpan), actualSpan)
                end
                if self.hudBarFill then
                    self.hudBarFill.Size = UDim2.new(frac, 0, 1, 0)
                end

                -- Find bounding snapshots for cursorTime and interpolate CFrame + Camera with sub-frame precision
                while #buf > destIdx and buf[#buf].t > cursorTime do
                    lastSnap = table.remove(buf, #buf)
                end

                local currSnap = buf[#buf] or lastSnap
                if currSnap and lastSnap and currSnap ~= lastSnap and (lastSnap.t - currSnap.t) > 0.0001 then
                    local alpha = math.clamp((cursorTime - currSnap.t) / (lastSnap.t - currSnap.t), 0, 1)
                    local interpCF = currSnap.cf:Lerp(lastSnap.cf, alpha)
                    local interpCam = (currSnap.camCF and lastSnap.camCF) and currSnap.camCF:Lerp(lastSnap.camCF, alpha) or currSnap.camCF
                    local synthSnap = {
                        cf = interpCF,
                        camCF = interpCam,
                        camFov = currSnap.camFov,
                        toolName = currSnap.toolName,
                        anims = currSnap.anims,
                        vel = currSnap.vel,
                        sit = currSnap.sit,
                        walkSpeed = currSnap.walkSpeed,
                        humState = currSnap.humState,
                        vX = currSnap.vX, vY = currSnap.vY, vZ = currSnap.vZ, vSpeed = currSnap.vSpeed,
                    }
                    applySnapshotFrame(char, root, hum, synthSnap, true)
                elseif currSnap then
                    applySnapshotFrame(char, root, hum, currSnap, true)
                end

                if cursorTime <= buf[destIdx].t or #buf <= destIdx then
                    lastSnap = buf[destIdx] or currSnap
                    break
                end
            end

            if self.rewinding then
                self:Stop(lastSnap)
                notify("COCO POWDER", string.format("✨ Rewound -%.1fs with exact precision!", actualSpan))
                sSuccess()
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- UPGRADED VOID THROW V2 & NEBULA FLING ENGINE (SUB-FLOOR BURY + SINKHOLE + CATAPULT)
-- ═══════════════════════════════════════════════════════════════════════════════
-- Fixes why other players were not getting stuck in the void or dying:
-- 1) Restores CanCollide = true & Massless = false on BOTH our core parts (with 100-density
--    CustomPhysicalProperties) AND the target's parts during Stepped & Heartbeat so full
--    physical momentum transfers on every single frame!
-- 2) Runs a dual-stage Pre-Physics (RunService.Stepped) + Post-Physics (RunService.Heartbeat)
--    intersection loop so Roblox's physics solver receives maximum impulse before stepping.
-- 3) Cycles 3 lethal Void Throw stages:
--    • Stage 1 (Sub-Floor Void Bury): High-frequency top-down wedge through target's center
--      of mass with -175,000 Y velocity to shove them straight through floors into the void.
--    • Stage 2 (Horizon Void Catapult): Angled outward + downward 135,000-stud/s blast toward
--      the nearest map boundary so targets on thick baseplates are hurled off the map edge.
--    • Stage 3 (Deep-Void Sinkhole Drag): Binds PhysicsRepRootPart and pulses to Y = FPDH - 165
--      so welded, grabbed, seated, or network-owned targets are dragged straight below the
--      void kill-line and eliminated or permanently stuck in the void!
-- 4) Never stops prematurely from small horizontal bumps — continues until the target is
--    confirmed dead (Health <= 0) or deep in the Void killzone!

local function restorePartCollisionAndDensity(char, isLocalRam)
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            local isCore = (part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head")
            if isLocalRam then
                part.CanCollide = isCore
                part.CanTouch = false
                part.Massless = false
                if isCore then
                    pcall(function()
                        part.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5, 100, 100)
                    end)
                end
            else
                if isCore then
                    part.CanCollide = true
                end
                part.Massless = false
            end
        end
    end
end

local function launchNebulaFling(durationSeconds, modeTitle, isVoidThrow, explicitTarget)
    local targetPlr, usedNearest
    if explicitTarget and explicitTarget.Parent == Players then
        targetPlr, usedNearest = explicitTarget, false
    else
        targetPlr, usedNearest = resolveActiveTarget()
    end
    if not targetPlr or targetPlr.Parent ~= Players then
        notify("COCO POWDER", "No target player found in server!")
        sError()
        return
    end
    local myChar = LP.Character
    local myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
    local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not myRoot then
        notify("COCO POWDER", "Local character not ready!")
        sError()
        return
    end

    -- Save origin BEFORE streaming/teleporting to a hidden target so we always return to our original spot!
    local preSeekOriginCF = isSafePlayableCF(myRoot.CFrame) and myRoot.CFrame or findFallbackSafeCF()
    local tChar, targetRoot = streamAndTeleportToTarget(targetPlr, "torso", 2.2)
    local targetHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
    if not targetRoot or not targetRoot.Parent then
        notify("COCO POWDER", "Could not stream target — try again!")
        sError()
        return
    end

    local origCF = preSeekOriginCF
    LastKnownSafeCF = origCF

    StateManager:Cleanup(true)
    CurrentTarget = targetPlr
    FlingActive = true
    FlingOriginCF = origCF

    -- Lock camera on target so our screen stays stable while slamming them into the void
    local currentCam = workspace.CurrentCamera
    if currentCam then
        FlingCamType = currentCam.CameraType
        FlingCamSubject = currentCam.CameraSubject
        FlingCamCF = currentCam.CFrame
        pcall(function()
            if targetHum then
                currentCam.CameraSubject = targetHum
            end
        end)
    end

    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
    LastWeldTargetUserId = targetPlr.UserId
    hookTargetRespawn(targetPlr)
    killAnimate(myChar)

    if FlingSidePanel then
        FlingSidePanel.Visible = true
        if FlingCountdownLabel then
            FlingCountdownLabel.Text = (durationSeconds > 0)
                and (tostring(math.ceil(durationSeconds)) .. "s remaining")
                or "VOID LOCK (Active)"
        end
    end

    sFling()
    local prefix = isVoidThrow and "Void Throw v2 (" or (usedNearest and "Auto-Nearest Fling (" or "Nebula Fling (")
    notify("COCO POWDER", prefix .. tostring(modeTitle) .. ") -> " .. targetPlr.Name)

    local startTime = tick()
    local phaseCounter = 0
    local nextTargetCFrame = targetRoot.CFrame
    local nextLinearVel = Vector3.new(0, -150000, 0)
    local nextAngularVel = Vector3.new(120000, 120000, 120000)

    local function finishVoidThrow(msg, playSuccess)
        StateManager:StopFling(false)
        if msg then notify("COCO POWDER", msg) end
        if playSuccess then sSuccess() end
    end

    -- Pre-Simulation (RunService.Stepped): Enforce collision & 100-density mass on our torso/root
    -- AND target's character right before Roblox's internal physics step!
    StateManager.FlingStepConn = RunService.Stepped:Connect(function()
        if not FlingActive or not myChar.Parent or not myRoot.Parent then
            if StateManager.FlingStepConn then StateManager.FlingStepConn:Disconnect(); StateManager.FlingStepConn = nil end
            return
        end
        pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
        restorePartCollisionAndDensity(myChar, true)
        if tChar and tChar.Parent then
            restorePartCollisionAndDensity(tChar, false)
        end
        if myHum then
            pcall(function()
                myHum.Sit = false
                myHum.PlatformStand = true
                myHum:ChangeState(Enum.HumanoidStateType.Physics)
            end)
        end
        if nextTargetCFrame then
            myRoot.CFrame = nextTargetCFrame
            myRoot.AssemblyLinearVelocity = nextLinearVel
            myRoot.AssemblyAngularVelocity = nextAngularVel
            pcall(function()
                myRoot.Velocity = nextLinearVel
                myRoot.RotVelocity = nextAngularVel
            end)
        end
    end)

    FlingConn = RunService.Heartbeat:Connect(function()
        if not FlingActive
            or not myChar.Parent
            or LP.Character ~= myChar
            or not myRoot.Parent
            or not targetPlr.Parent
            or targetPlr.Parent ~= Players
        then
            finishVoidThrow("✨ Target eliminated / left — safely returned!", true)
            return
        end

        -- Dynamically re-acquire target character/root if they streamed or unseated
        if not targetRoot or not targetRoot.Parent or findPlayerCharacterAnywhere(targetPlr) ~= tChar then
            tChar = findPlayerCharacterAnywhere(targetPlr)
            targetHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
            targetRoot = tChar and pickTargetRef(tChar, "torso")
            if not targetRoot or not targetRoot.Parent then
                local hiddenCF = getBestTargetCFrame(targetPlr)
                if hiddenCF and isLethalVoidCF(hiddenCF) then
                    finishVoidThrow("🎯 " .. targetPlr.Name .. " destroyed in the Void! Safely returned.", true)
                    return
                end
                return
            end
        end

        -- Check if target died!
        if targetHum and targetHum.Parent and targetHum.Health <= 0 then
            finishVoidThrow("💀 " .. targetPlr.Name .. " died in the Void! Safely returned.", true)
            return
        end

        -- Check if target is genuinely trapped deep in the lethal void killzone or far null-zone!
        local tPos = targetRoot.Position
        local tVel = targetRoot.AssemblyLinearVelocity
        local lethalVoidFloor = math.min(OriginalFPDH + 14, -245)
        local targetConfirmedInVoid = (tPos.Y <= lethalVoidFloor)
            or (tPos.Y <= -190 and tVel.Y < -85)
            or (tPos.Magnitude > 28000)

        if targetConfirmedInVoid then
            -- Deliver final downward lock pulse in the void so they can never recover
            local sinkCF = CFrame.new(tPos.X, math.clamp(OriginalFPDH - 180, -850, -380), tPos.Z)
            myRoot.CFrame = sinkCF
            myRoot.AssemblyLinearVelocity = Vector3.new(0, -180000, 0)
            finishVoidThrow("🎯 " .. targetPlr.Name .. " trapped in Void & eliminated! Safely returned.", true)
            return
        end

        local elapsed = tick() - startTime
        if durationSeconds > 0 then
            local remaining = math.max(0, durationSeconds - elapsed)
            if FlingCountdownLabel then
                FlingCountdownLabel.Text = "⏳ " .. string.format("%.1f", remaining) .. "s left"
            end
            if remaining <= 0 then
                finishVoidThrow("✨ " .. tostring(modeTitle) .. " finished & safely returned!", true)
                return
            end
        end

        -- Focus stream on target and bind PhysicsRepRootPart for network-sync drag
        pcall(function() LP.ReplicationFocus = targetRoot end)
        if sethiddenproperty then
            pcall(function()
                sethiddenproperty(myRoot, "PhysicsRepRootPart", targetRoot)
                if InstanceHandleNew then
                    sethiddenproperty(myRoot, "PhysicsRepRootRef", InstanceHandleNew(targetRoot))
                end
            end)
        end

        phaseCounter = phaseCounter + 1
        local t = tick() * 45

        -- Predictive walk/movement lead (matches Skylines / IY predictive intersection)
        local moveDir = (targetHum and targetHum.MoveDirection) or Vector3.zero
        local horizVel = Vector3.new(tVel.X, 0, tVel.Z)
        if horizVel.Magnitude > 140 then
            horizVel = horizVel.Unit * 140
        end
        local leadOffset = (horizVel * 0.065) + (moveDir * 1.35)
        local predictedPos = tPos + leadOffset

        -- Outward direction vector away from map center toward the void horizon
        local outwardXZ = Vector3.new(predictedPos.X, 0, predictedPos.Z)
        if outwardXZ.Magnitude < 1 then
            outwardXZ = Vector3.new(math.cos(t), 0, math.sin(t))
        else
            outwardXZ = outwardXZ.Unit
        end

        if isVoidThrow then
            local subStage = phaseCounter % 12
            if subStage <= 6 then
                -- STAGE 1: SUB-FLOOR VOID BURY & TOP-DOWN SLAM
                -- Sweeps vertically from +1.5 studs above target's head/torso to -1.2 studs below their feet
                -- while injecting massive downward (-175,000) + outward impulse to drive them into the floor/void!
                local verticalWedge = 1.5 - ((subStage / 6) * 2.7)
                local tightJitter = Vector3.new(math.cos(t * 1.9) * 0.55, verticalWedge, math.sin(t * 1.9) * 0.55)
                local safeY = math.max(predictedPos.Y + tightJitter.Y, OriginalFPDH + 22)
                nextTargetCFrame = CFrame.new(predictedPos.X + tightJitter.X, safeY, predictedPos.Z + tightJitter.Z)
                    * CFrame.Angles(math.rad((phaseCounter * 73) % 360), t, math.rad((phaseCounter * 137) % 360))
                nextLinearVel = Vector3.new(
                    outwardXZ.X * 75000 + math.random(-25000, 25000),
                    -175000,
                    outwardXZ.Z * 75000 + math.random(-25000, 25000)
                )
                nextAngularVel = Vector3.new(145000, 145000, 145000)
            elseif subStage <= 9 then
                -- STAGE 2: HORIZON VOID CATAPULT (Blasts target off solid baseplates into the Void!)
                local behindOffset = -outwardXZ * ((subStage % 2 == 0) and 0.85 or -0.45)
                local safeY = math.max(predictedPos.Y - 0.35, OriginalFPDH + 22)
                nextTargetCFrame = CFrame.new(predictedPos.X + behindOffset.X, safeY, predictedPos.Z + behindOffset.Z)
                    * CFrame.Angles(t, t * 1.7, -t)
                nextLinearVel = Vector3.new(
                    outwardXZ.X * 135000,
                    -115000,
                    outwardXZ.Z * 135000
                )
                nextAngularVel = Vector3.new(160000, -160000, 160000)
            else
                -- STAGE 3: DEEP-VOID SINKHOLE DRAG (Instantly kills/traps welded, attached, or PhysicsRep targets!)
                local voidSinkY = math.clamp(OriginalFPDH - 165, -820, -350)
                nextTargetCFrame = CFrame.new(predictedPos.X, voidSinkY, predictedPos.Z)
                    * CFrame.Angles(math.rad(180), t, 0)
                nextLinearVel = Vector3.new(outwardXZ.X * 95000, -195000, outwardXZ.Z * 95000)
                nextAngularVel = Vector3.new(150000, 150000, 150000)
            end
        else
            -- Nebula Fling: High-density 3D vortex intersection through target RootPart & limbs
            local radius = (phaseCounter % 3 == 0) and 0.15 or ((phaseCounter % 2 == 0) and 0.75 or 1.85)
            local yOsc = math.sin(phaseCounter * 0.85) * 1.1
            local safeY = math.max(predictedPos.Y + yOsc, OriginalFPDH + 22)
            local sweepOffset = Vector3.new(math.cos(t) * radius, 0, math.sin(t) * radius)
            nextTargetCFrame = CFrame.new(Vector3.new(predictedPos.X, safeY, predictedPos.Z) + sweepOffset)
                * CFrame.Angles(math.rad((phaseCounter * 65) % 360), t, math.rad((phaseCounter * 115) % 360))
            nextLinearVel = Vector3.new(
                outwardXZ.X * 90000 + math.random(-45000, 45000),
                (phaseCounter % 2 == 0) and -130000 or 110000,
                outwardXZ.Z * 90000 + math.random(-45000, 45000)
            )
            nextAngularVel = Vector3.new(135000, 135000, 135000)
        end

        markIntentionalTeleport(nextTargetCFrame)
        myRoot.CFrame = nextTargetCFrame
        myRoot.AssemblyLinearVelocity = nextLinearVel
        myRoot.AssemblyAngularVelocity = nextAngularVel
        pcall(function()
            myRoot.Velocity = nextLinearVel
            myRoot.RotVelocity = nextAngularVel
        end)
    end)
end

local function launchVoidThrow(explicitTarget, customDuration)
    launchNebulaFling(customDuration or 5.5, "Void Throw v2", true, explicitTarget)
end

local function promptNebulaFling()
    local targetPlr, usedNearest = resolveActiveTarget()
    if not targetPlr then
        notify("COCO POWDER", "No target or nearby player found!")
        sError()
        return
    end
    if not gui then return end
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 0.5
    overlay.ZIndex = 120
    overlay.Parent = gui

    local modal = Instance.new("Frame")
    modal.Size = UDim2.new(0, 306, 0, 284)
    modal.Position = UDim2.new(0.5, -153, 0.5, -142)
    modal.BackgroundColor3 = T.Panel
    modal.BorderSizePixel = 0
    modal.ZIndex = 121
    modal.Parent = overlay
    Instance.new("UICorner", modal).CornerRadius = UDim.new(0, 12)

    local mStroke = Instance.new("UIStroke")
    mStroke.Color = T.Purple
    mStroke.Thickness = 1.5
    mStroke.Transparency = 0.3
    mStroke.Parent = modal

    local mTitle = Instance.new("TextLabel")
    mTitle.Size = UDim2.new(1, -20, 0, 24)
    mTitle.Position = UDim2.new(0, 10, 0, 10)
    mTitle.BackgroundTransparency = 1
    mTitle.Text = "VOID THROW V2 & NEBULA FLING"
    mTitle.TextColor3 = T.Purple
    mTitle.Font = Enum.Font.GothamBold
    mTitle.TextSize = 12
    mTitle.ZIndex = 122
    mTitle.Parent = modal

    local mSub = Instance.new("TextLabel")
    mSub.Size = UDim2.new(1, -20, 0, 18)
    mSub.Position = UDim2.new(0, 10, 0, 32)
    mSub.BackgroundTransparency = 1
    mSub.Text = (usedNearest and "auto-nearest: " or "target: ") .. targetPlr.Name .. " (100-density void trap)"
    mSub.TextColor3 = T.Muted
    mSub.Font = Enum.Font.Gotham
    mSub.TextSize = 10
    mSub.ZIndex = 122
    mSub.Parent = modal

    local function makeOptBtn(y, text, color, cb)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, -24, 0, 32)
        b.Position = UDim2.new(0, 12, 0, y)
        b.BackgroundColor3 = color
        b.Text = text
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 10
        b.ZIndex = 123
        b.Parent = modal
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        b.MouseEnter:Connect(function()
            sHover()
            TweenService:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = color:Lerp(Color3.new(1, 1, 1), 0.12)}):Play()
        end)
        b.MouseLeave:Connect(function()
            TweenService:Create(b, TweenInfo.new(0.18), {BackgroundColor3 = color}):Play()
        end)
        b.MouseButton1Click:Connect(function()
            sClick()
            overlay:Destroy()
            cb()
        end)
    end

    makeOptBtn(58, "⚡ Void Throw v2 (5.5s Bury + Catapult + Sinkhole)", T.Accent2, function()
        launchVoidThrow(targetPlr, 5.5)
    end)
    makeOptBtn(96, "🕳️ Void Lock (Relentless Trap Until Dead/Voided)", Color3.fromRGB(185, 45, 95), function()
        launchNebulaFling(-1, "Void Lock Until Dead", true, targetPlr)
    end)
    makeOptBtn(134, "🌪️ 4 Seconds (High-Density Vortex Blast)", Color3.fromRGB(76, 79, 87), function()
        launchNebulaFling(4.0, "4 Seconds", false, targetPlr)
    end)
    makeOptBtn(172, "☄️ 8 Seconds (Extreme Omni-Vortex)", Color3.fromRGB(104, 108, 117), function()
        launchNebulaFling(8.0, "8 Seconds", false, targetPlr)
    end)
    makeOptBtn(210, "♾️ Unlimited Fling (Auto-Stops On Void Kill)", Color3.fromRGB(139, 143, 152), function()
        launchNebulaFling(-1, "Unlimited", false, targetPlr)
    end)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -30, 0, 8)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = T.Muted
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 12
    closeBtn.ZIndex = 124
    closeBtn.Parent = modal
    closeBtn.MouseButton1Click:Connect(function()
        sClick()
        overlay:Destroy()
    end)
end

local CS_D = 5
local CS_M = 200
local CS_R = " TMKX MAI "
local CS_HDR = "SCRIPT BY COCACOLA"
local CS_W = {"NOOB","ROOKIE","AMATEUR","TRAINEE","BEGINNER","SLOWPOKE","SLEEPY","CLUMSY","DORK","NERD","GEEK","DWEEB","SQUISHY","WOBBLY","FUZZY","SPARKLY","GIGGLY","WIGGLY","SNAIL","TURTLE","PANDA","SLOTH","MOOSE","HAMSTER","PUPPY","KITTEN","DUCKLING","PENGUIN","NARWHAL","PLATYPUS","CAPYBARA","ALPACA","RACCOON","SQUIRREL","OTTER","BEAVER","HEDGEHOG","MEERKAT","FERRET","BUNNY","CHIPMUNK","PUFFIN","TOUCAN","FLAMINGO","MANATEE","WALRUS","PELICAN","SEAGULL","PIGEON","SPARROW","ROBIN","FINCH","WREN","MAGPIE","CROW","RAVEN","STARLING","SWALLOW","MARTIN","SWIFT","DOVE","QUAIL","PHEASANT","TURKEY","DUCK","CHICKEN","ROOSTER","PARROT","MACAW","COCKATOO","BUDGIE","CANARY"}
local CS_E = {"🔥","😂","💀","🗿","😭","😎","🤡","👻","👀","💯","🚨","🎯","⚡","🌊","🎪","🧠","🤖","🥶","😈","🤣","💥","✨","🙏","👑"}
local CS_SYM = "@"
local CS_REPEAT = 120

local csOn = false
local csMode = "roast"
local csTgt = ""
local csMsg = ""
local csCnt = 0
local csMtd = "-"
local csCh = nil
local csLg = nil
local csGen = 0

local function gC()
    if TextChatService.ChatVersion ~= Enum.ChatVersion.TextChatService then return nil end
    local ok, res = pcall(function()
        local c = TextChatService:FindFirstChild("TextChannels")
        if not c then return nil end
        return c:FindFirstChild("RBXGeneral") or c:GetChildren()[1]
    end)
    return ok and res or nil
end
local function gL()
    local ok, res = pcall(function()
        local d = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if d and d:FindFirstChild("SayMessageRequest") then return d.SayMessageRequest end
    end)
    return ok and res or nil
end
local function snd2(tx)
    if #tx > CS_M then tx = tx:sub(1, CS_M) end
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        if not csCh or not csCh.Parent then csCh = gC() end
        if csCh then local ok = pcall(function() csCh:SendAsync(tx) end); if ok then csMtd = "TextChat"; return true end end
    end
    if not csLg then csLg = gL() end
    if csLg then local ok = pcall(function() csLg:FireServer(tx, "All") end); if ok then csMtd = "Legacy"; return true end end
    return false
end
local function pickEmojis()
    if math.random() > 0.75 then return "" end
    local count = math.random(1, 3)
    local out = ""
    for _ = 1, count do
        out = out .. CS_E[math.random(1, #CS_E)]
    end
    return out
end
local function resolveTargetDisplay()
    if csTgt and csTgt ~= "" then
        local cleaned = tostring(csTgt):gsub("^%s*@+%s*", "")
        local matched = findPlayerByNameOrDisplay(cleaned, LP)
        if matched then
            return (matched.DisplayName ~= "" and matched.DisplayName) or matched.Name
        end
    end
    local targetPlr = resolveActiveTarget()
    if targetPlr then
        local ok, dn = pcall(function() return targetPlr.DisplayName end)
        if ok and dn and dn ~= "" then return dn end
        local ok2, nm = pcall(function() return targetPlr.Name end)
        if ok2 and nm and nm ~= "" then return nm end
    end
    if csTgt and csTgt ~= "" then return (tostring(csTgt):gsub("^%s*@+%s*", "")) end
    return nil
end
local function genSymbols()
    local out = ""
    for _ = 1, CS_REPEAT do
        out = out .. CS_SYM
    end
    return out
end
local function bld()
    if csMode == "message" then
        return (CS_HDR .. " " .. csMsg:upper() .. genSymbols() .. pickEmojis()):sub(1, CS_M)
    end
    local raw = resolveTargetDisplay()
    if not raw or raw == "" then raw = csTgt end
    if not raw or raw == "" then raw = "everyone" end
    raw = tostring(raw):gsub("^%s*@+%s*", "")
    local tail = "@" .. raw .. CS_R .. CS_W[math.random(1, #CS_W)]
    return (CS_HDR .. " " .. genSymbols() .. " " .. tail:upper() .. pickEmojis()):sub(1, CS_M)
end

-- Shared movement state (hoisted to top-level so Anti-Ragdoll, Anti-Bring, Anti-Anchor, and Move Tab cooperate seamlessly)
local moveState = {
    speed = false,
    jump = false,
    infiniteJump = false,
    noclip = false,
    fly = false,
    flyConn = nil,
    jumpConn = nil,
    noclipConn = nil,
    speedLoopConn = nil,
    lastTeleportTick = 0,
}

local syncAllAntiButtons = nil

Anti = {
    Void        = { enabled = false, charAdded = nil, healthConns = {}, charConns = {}, loopConn = nil, steppedConn = nil, safetyFloor = nil, rescues = 0 },
    Kill        = { enabled = false, charAdded = nil, descConn = nil, loopConn = nil, wsDescConn = nil, blockedTouches = 0 },
    GamePaused  = { enabled = false, childAdded = nil, propConn = nil, loopConn = nil },
    AFK         = { enabled = false, conn = nil, loopConn = nil },
    VC          = { enabled = false, loaded = false, loopConn = nil },
    Redirect    = { enabled = false },
    PauseTrap   = { enabled = false },
    FlingShield = { enabled = false, steppedConn = nil, heartbeatConn = nil, preStepCF = nil, blockedFlings = 0 },
    -- ADVANCED MULTI-LAYER ANTI-SYSTEMS V2:
    Ragdoll     = { enabled = false, steppedConn = nil, stateConn = nil, descConn = nil, charAdded = nil, recoveries = 0 },
    Anchor      = { enabled = false, steppedConn = nil, descConn = nil, charAdded = nil, purgedMovers = 0 },
    Attach      = { enabled = false, steppedConn = nil, descConn = nil, severedCount = 0 },
    Blind       = { enabled = false, loopConn = nil, lightChildConn = nil, camChildConn = nil, guiChildConn = nil },
    Bring       = { enabled = false, steppedConn = nil, heartbeatConn = nil, lastCF = nil, lastSafeTime = 0, blockedBrings = 0 },
}

local DefenceTroll = {
    enabled = false,
    mode = "GodMatrix",
    range = 7.5,
    deflectCount = 0,
    lastAttackerName = "None",
    lastThreatReason = "Standby",
    modes = { "GodMatrix", "ReverseFling", "VoidPause", "Redirect", "Blackhole", "SkyOrbit" },
    modeLabels = {
        GodMatrix    = "GOD MATRIX ⚡",
        ReverseFling = "REVERSE FLING 🌪️",
        VoidPause    = "VOID-PAUSE ❄️",
        Redirect     = "REDIRECT 🎯",
        Blackhole    = "BLACKHOLE 🌀",
        SkyOrbit     = "SKY ORBIT 🚀",
    },
    ranges = { 5.0, 7.5, 11.0, 16.0, 22.0 },
    rangeIdx = 2,
    lastDeflect = 0,
}

local deflectBusy = false
local contactTimers = {}
local deflectCooldowns = {}
local attackerLastPos = {}

-- Helper: Mark an intentional local teleport so Anti-Bring never fights our own teleports
markIntentionalTeleport = function(cf)
    moveState.lastTeleportTick = tick()
    if cf then
        Anti.Bring.lastCF = cf
        LastKnownSafeCF = cf
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
local avStart, avStop, akStart, akStop, agpStart, agpStop, afkStart, afkStop, vcStart, vcStop
local ragdollStart, ragdollStop, anchorStart, anchorStop, attachStart, attachStop, blindStart, blindStop
local bringStart, bringStop, flingShieldStart, flingShieldStop, redirectStart, redirectStop, pauseTrapStart, pauseTrapStop
local defenceTrollStart, defenceTrollStop, enableAllAntiSystems, disableAllAntiSystems
do -- Scoped block for internal Anti helper functions (frees 35+ top-level local registers)
-- 1. ADVANCED ANTI-VOID V2 (Predictive Velocity Catch + Safety Platform + Death Block)
-- ═══════════════════════════════════════════════════════════════════════════════
local function avEnsureSafetyFloor(pos)
    local floor = Anti.Void.safetyFloor
    if not floor or not floor.Parent then
        floor = Instance.new("Part")
        floor.Name = "CocoVoidSafetyFloor"
        floor.Anchored = true
        floor.CanCollide = true
        floor.CanTouch = false
        floor.CanQuery = false
        floor.Size = Vector3.new(64, 2, 64)
        floor.Transparency = 0.65
        floor.Material = Enum.Material.ForceField
        floor.Color = Color3.fromRGB(138, 92, 246)
        floor.Parent = workspace
        Anti.Void.safetyFloor = floor
    end
    floor.CFrame = CFrame.new(pos.X, pos.Y - 3.5, pos.Z)
end

local function avRemoveSafetyFloor()
    if Anti.Void.safetyFloor then
        pcall(function() Anti.Void.safetyFloor:Destroy() end)
        Anti.Void.safetyFloor = nil
    end
end

local function avForceAlive(h)
    if not h or not h.Parent then return end
    pcall(function()
        h:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        h:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        if h.MaxHealth <= 0 then h.MaxHealth = 100 end
        if h.Health <= 0 or h.Health < h.MaxHealth then h.Health = h.MaxHealth end
        if h.PlatformStand and not (moveState and moveState.fly) and not WeldIntent.active then
            h.PlatformStand = false
        end
        if h.Sit then h.Sit = false end
        if h:GetState() == Enum.HumanoidStateType.Dead then
            h:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end

local function avHookHumanoid(h)
    if not h or not h.Parent then return end
    avForceAlive(h)
    table.insert(Anti.Void.healthConns, h.HealthChanged:Connect(function(hp)
        if Anti.Void.enabled and hp < h.MaxHealth then
            task.defer(function() avForceAlive(h) end)
        end
    end))
    table.insert(Anti.Void.healthConns, h.StateChanged:Connect(function(_, newState)
        if Anti.Void.enabled and newState == Enum.HumanoidStateType.Dead then
            avForceAlive(h)
        end
    end))
end

local function avHookChar(c)
    if not c then return end
    for _, x in ipairs(Anti.Void.charConns) do pcall(function() x:Disconnect() end) end
    Anti.Void.charConns = {}
    for _, x in ipairs(Anti.Void.healthConns) do pcall(function() x:Disconnect() end) end
    Anti.Void.healthConns = {}
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then avHookHumanoid(hum) end
    table.insert(Anti.Void.charConns, c.ChildAdded:Connect(function(ch)
        if ch:IsA("Humanoid") then avHookHumanoid(ch) end
    end))
end

avStart = function()
    if Anti.Void.enabled then return end
    Anti.Void.enabled = true
    pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
    avHookChar(LP.Character)
    if Anti.Void.charAdded then Anti.Void.charAdded:Disconnect() end
    Anti.Void.charAdded = LP.CharacterAdded:Connect(function(c)
        if not Anti.Void.enabled then return end
        task.wait(0.15)
        avHookChar(c)
        pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
    end)
    if Anti.Void.steppedConn then Anti.Void.steppedConn:Disconnect() end
    Anti.Void.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.Void.enabled then return end
        pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
        local c = LP.Character
        local r = c and c:FindFirstChild("HumanoidRootPart")
        if not r or FlingActive or deflectBusy then return end
        local pos = r.Position
        local vel = r.AssemblyLinearVelocity
        local dangerFloor = math.max(OriginalFPDH + 55, -180)
        -- Predictive catch: if plummeting fast toward the void or below safe map floor
        if pos.Y <= dangerFloor or (pos.Y <= -45 and vel.Y < -140) or pos.Magnitude > 20000 then
            r.AssemblyLinearVelocity = Vector3.new(vel.X * 0.1, math.max(0, vel.Y), vel.Z * 0.1)
            r.AssemblyAngularVelocity = Vector3.zero
            avEnsureSafetyFloor(Vector3.new(pos.X, math.max(pos.Y, dangerFloor + 10), pos.Z))
            Anti.Void.rescues = Anti.Void.rescues + 1
            markIntentionalTeleport(LastKnownSafeCF)
            safeReturnFromVoid(c, LastKnownSafeCF)
        elseif Anti.Void.safetyFloor and pos.Y > -15 and math.abs(vel.Y) < 25 then
            avRemoveSafetyFloor()
        end
    end)
    if Anti.Void.loopConn then Anti.Void.loopConn:Disconnect() end
    Anti.Void.loopConn = RunService.Heartbeat:Connect(function()
        if not Anti.Void.enabled then return end
        local c = LP.Character
        if not c then return end
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then avForceAlive(h) end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Void v2 (Predictive Catch + Safety Floor) ON")
    sToggleOn()
end

avStop = function()
    if not Anti.Void.enabled then return end
    Anti.Void.enabled = false
    if Anti.Void.charAdded then Anti.Void.charAdded:Disconnect(); Anti.Void.charAdded = nil end
    if Anti.Void.steppedConn then Anti.Void.steppedConn:Disconnect(); Anti.Void.steppedConn = nil end
    if Anti.Void.loopConn then Anti.Void.loopConn:Disconnect(); Anti.Void.loopConn = nil end
    for _, x in ipairs(Anti.Void.charConns) do pcall(function() x:Disconnect() end) end
    Anti.Void.charConns = {}
    for _, x in ipairs(Anti.Void.healthConns) do pcall(function() x:Disconnect() end) end
    Anti.Void.healthConns = {}
    avRemoveSafetyFloor()
    if not (Anti.Kill and Anti.Kill.enabled) and not WeldIntent.active and not FlingActive then
        pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
    end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Void disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 2. ADVANCED ANTI-KILL / GOD-TOUCH SHIELD V2 (Zero KillBrick Touch + Explosion Immunity)
-- ═══════════════════════════════════════════════════════════════════════════════
local function akSanitizePart(p)
    if p and p:IsA("BasePart") then
        if p.CanTouch then p.CanTouch = false end
        if p.CanQuery then p.CanQuery = false end
    end
end

local function akApply(char)
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        akSanitizePart(p)
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function()
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            if hum.Health > 0 and hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
        end)
    end
end

akStart = function()
    if Anti.Kill.enabled then return end
    Anti.Kill.enabled = true
    pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
    akApply(LP.Character)
    if Anti.Kill.charAdded then Anti.Kill.charAdded:Disconnect() end
    Anti.Kill.charAdded = LP.CharacterAdded:Connect(function(c)
        if not Anti.Kill.enabled then return end
        task.wait(0.15)
        akApply(c)
    end)
    -- Neutralize any Explosions spawned in Workspace so BlastPressure never kills or ragdolls joints
    if Anti.Kill.wsDescConn then Anti.Kill.wsDescConn:Disconnect() end
    Anti.Kill.wsDescConn = workspace.DescendantAdded:Connect(function(obj)
        if not Anti.Kill.enabled then return end
        if obj:IsA("Explosion") then
            pcall(function()
                obj.BlastPressure = 0
                obj.BlastRadius = 0
                obj.DestroyJointRadiusPercent = 0
            end)
        end
    end)
    if Anti.Kill.loopConn then Anti.Kill.loopConn:Disconnect() end
    Anti.Kill.loopConn = RunService.Stepped:Connect(function()
        if not Anti.Kill.enabled then return end
        local c = LP.Character
        if not c then return end
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") then
                if p.CanTouch then p.CanTouch = false end
                if p.CanQuery then p.CanQuery = false end
            end
        end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function()
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                if hum.Health > 0 and hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
            end)
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Kill v2 (Touch/Query Shield + Blast Immunity) ON")
    sToggleOn()
end

akStop = function()
    if not Anti.Kill.enabled then return end
    Anti.Kill.enabled = false
    if Anti.Kill.charAdded then Anti.Kill.charAdded:Disconnect(); Anti.Kill.charAdded = nil end
    if Anti.Kill.wsDescConn then Anti.Kill.wsDescConn:Disconnect(); Anti.Kill.wsDescConn = nil end
    if Anti.Kill.loopConn then Anti.Kill.loopConn:Disconnect(); Anti.Kill.loopConn = nil end
    local c = LP.Character
    if c then
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") then
                pcall(function() p.CanTouch = true; p.CanQuery = true end)
            end
        end
    end
    if not (Anti.Void and Anti.Void.enabled) and not WeldIntent.active and not FlingActive then
        pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
    end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Kill disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 3. ADVANCED ANTI-GAMEPLAYPAUSED V2 (GuiService + CoreGui + Property Unfreeze)
-- ═══════════════════════════════════════════════════════════════════════════════
local function agpCleanse()
    pcall(function()
        game:GetService("GuiService"):SetGameplayPausedNotificationEnabled(false)
    end)
    pcall(function()
        if LP.GameplayPaused then LP.GameplayPaused = false end
    end)
    pcall(function()
        local rg = CoreGui and CoreGui:FindFirstChild("RobloxGui")
        if rg then
            local np = rg:FindFirstChild("CoreScripts/NetworkPause")
            if np then np:Destroy() end
        end
    end)
end

agpStart = function()
    if Anti.GamePaused.enabled then return end
    Anti.GamePaused.enabled = true
    agpCleanse()
    pcall(function()
        local rg = CoreGui and CoreGui:FindFirstChild("RobloxGui")
        if rg then
            if Anti.GamePaused.childAdded then Anti.GamePaused.childAdded:Disconnect() end
            Anti.GamePaused.childAdded = rg.ChildAdded:Connect(function(obj)
                if Anti.GamePaused.enabled and obj.Name:find("NetworkPause") then
                    pcall(function() obj:Destroy() end)
                end
            end)
        end
    end)
    if Anti.GamePaused.propConn then Anti.GamePaused.propConn:Disconnect() end
    pcall(function()
        Anti.GamePaused.propConn = LP:GetPropertyChangedSignal("GameplayPaused"):Connect(function()
            if Anti.GamePaused.enabled then
                pcall(function() LP.GameplayPaused = false end)
                agpCleanse()
            end
        end)
    end)
    if Anti.GamePaused.loopConn then Anti.GamePaused.loopConn:Disconnect() end
    Anti.GamePaused.loopConn = RunService.Heartbeat:Connect(function()
        if not Anti.GamePaused.enabled then return end
        if LP.GameplayPaused then
            pcall(function() LP.GameplayPaused = false end)
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-GameplayPaused v2 ON")
    sToggleOn()
end

agpStop = function()
    if not Anti.GamePaused.enabled then return end
    Anti.GamePaused.enabled = false
    if Anti.GamePaused.childAdded then Anti.GamePaused.childAdded:Disconnect(); Anti.GamePaused.childAdded = nil end
    if Anti.GamePaused.propConn then Anti.GamePaused.propConn:Disconnect(); Anti.GamePaused.propConn = nil end
    if Anti.GamePaused.loopConn then Anti.GamePaused.loopConn:Disconnect(); Anti.GamePaused.loopConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-GameplayPaused disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 4. ADVANCED ANTI-AFK V2 (Idled Signal + VirtualUser + VirtualInputManager)
-- ═══════════════════════════════════════════════════════════════════════════════
local function afkPulse()
    pcall(function()
        local vu = game:GetService("VirtualUser")
        vu:CaptureController()
        vu:ClickButton2(Vector2.zero, workspace.CurrentCamera and workspace.CurrentCamera.CFrame or CFrame.new())
    end)
    pcall(function()
        local vim = game:GetService("VirtualInputManager")
        vim:SendMouseMoveEvent(1, 1, game)
    end)
end

afkStart = function()
    if Anti.AFK.enabled then return end
    Anti.AFK.enabled = true
    pcall(function()
        if getconnections then
            for _, c in ipairs(getconnections(LP.Idled)) do
                pcall(function() c:Disable() end)
                pcall(function() c:Disconnect() end)
            end
        end
    end)
    if Anti.AFK.conn then Anti.AFK.conn:Disconnect() end
    Anti.AFK.conn = LP.Idled:Connect(function()
        if not Anti.AFK.enabled then return end
        afkPulse()
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-AFK v2 (Multi-Hook) ON")
    sToggleOn()
end

afkStop = function()
    if not Anti.AFK.enabled then return end
    Anti.AFK.enabled = false
    if Anti.AFK.conn then Anti.AFK.conn:Disconnect(); Anti.AFK.conn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-AFK disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 5. ADVANCED ANTI-VC BAN & SUSPENSION BYPASS V2 (Native Rejoin + External Hook)
-- ═══════════════════════════════════════════════════════════════════════════════
local function vcAttemptReconnect()
    pcall(function()
        local vcs = game:GetService("VoiceChatService")
        if vcs and typeof(vcs.joinVoice) == "function" then
            vcs:joinVoice()
        end
    end)
    pcall(function()
        local vci = game:GetService("VoiceChatInternal")
        if vci and typeof(vci.Leave) == "function" and typeof(vci.JoinByGroupIdToken) == "function" then
            -- Clear local suspension modal if shown in CoreGui
            if CoreGui then
                for _, d in ipairs(CoreGui:GetDescendants()) do
                    if d:IsA("TextLabel") and (d.Text:lower():find("voice chat") and d.Text:lower():find("suspended")) then
                        local screen = d:FindFirstAncestorOfClass("ScreenGui") or d.Parent
                        if screen then screen:Destroy() end
                    end
                end
            end
        end
    end)
end

vcStart = function()
    if Anti.VC.enabled then return end
    Anti.VC.enabled = true
    vcAttemptReconnect()
    if not Anti.VC.loaded then
        Anti.VC.loaded = true
        task.spawn(function()
            pcall(function()
                loadstring(game:HttpGet("https://gist.githubusercontent.com/akashbhondu/157416db937268169e8a4a1b42547540/raw/3ba28974476051db60898a6bdff670a3271c140d/anti%2520vc"))()
            end)
        end)
    end
    if Anti.VC.loopConn then Anti.VC.loopConn:Disconnect() end
    Anti.VC.loopConn = RunService.Heartbeat:Connect(function()
        if not Anti.VC.enabled then return end
        vcAttemptReconnect()
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-VC v2 (Native Rejoin + Suspension Bypass) ON")
    sToggleOn()
end

vcStop = function()
    if not Anti.VC.enabled then return end
    Anti.VC.enabled = false
    if Anti.VC.loopConn then Anti.VC.loopConn:Disconnect(); Anti.VC.loopConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-VC disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 6. ADVANCED ANTI-RAGDOLL / ANTI-SIT / ANTI-STUN / ANTI-TRIP V2
--    • Disables Ragdoll, FallingDown, Seated, PlatformStand states
--    • Destroys SeatWelds and Ragdoll BallSocketConstraints / NoCollisionConstraints
--    • Automatically re-enables disabled Motor6D joints
--    • Cures stun/freeze walkspeed locks (when WalkSpeed is forced to 0)
-- ═══════════════════════════════════════════════════════════════════════════════
local function ragdollCleanseCharacter(c)
    if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function()
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
            if not WeldIntent.active and not FlingActive and not (moveState and moveState.fly) then
                hum:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                if hum.PlatformStand then hum.PlatformStand = false end
                if hum.Sit then hum.Sit = false end
                if not hum.AutoRotate then hum.AutoRotate = true end
                local st = hum:GetState()
                if st == Enum.HumanoidStateType.Ragdoll
                    or st == Enum.HumanoidStateType.FallingDown
                    or st == Enum.HumanoidStateType.PlatformStanding
                    or st == Enum.HumanoidStateType.Seated
                    or st == Enum.HumanoidStateType.Physics then
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                    Anti.Ragdoll.recoveries = Anti.Ragdoll.recoveries + 1
                end
                -- Cure stun scripts that lock WalkSpeed to 0
                if hum.WalkSpeed < 8 and not (moveState and moveState.speed) then
                    hum.WalkSpeed = 16
                end
            end
        end)
    end
    for _, obj in ipairs(c:GetDescendants()) do
        if obj:IsA("Motor6D") and not obj.Enabled then
            pcall(function() obj.Enabled = true end)
        elseif obj:IsA("SeatWeld") or obj.Name == "SeatWeld" or obj.Name:lower():find("ragdoll") then
            if not obj:IsA("BasePart") and not obj:IsA("Humanoid") then
                pcall(function() obj:Destroy() end)
            end
        elseif obj:IsA("BallSocketConstraint") or obj:IsA("HingeConstraint") then
            pcall(function() obj:Destroy() end)
        end
    end
end

ragdollStart = function()
    if Anti.Ragdoll.enabled then return end
    Anti.Ragdoll.enabled = true
    ragdollCleanseCharacter(LP.Character)
    if Anti.Ragdoll.charAdded then Anti.Ragdoll.charAdded:Disconnect() end
    Anti.Ragdoll.charAdded = LP.CharacterAdded:Connect(function(c)
        task.wait(0.15)
        if Anti.Ragdoll.enabled then ragdollCleanseCharacter(c) end
    end)
    if Anti.Ragdoll.steppedConn then Anti.Ragdoll.steppedConn:Disconnect() end
    Anti.Ragdoll.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.Ragdoll.enabled then return end
        ragdollCleanseCharacter(LP.Character)
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Ragdoll / Anti-Stun / Anti-Sit v2 ON")
    sToggleOn()
end

ragdollStop = function()
    if not Anti.Ragdoll.enabled then return end
    Anti.Ragdoll.enabled = false
    if Anti.Ragdoll.steppedConn then Anti.Ragdoll.steppedConn:Disconnect(); Anti.Ragdoll.steppedConn = nil end
    if Anti.Ragdoll.charAdded then Anti.Ragdoll.charAdded:Disconnect(); Anti.Ragdoll.charAdded = nil end
    local c = LP.Character
    local hum = c and c:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function()
            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        end)
    end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Ragdoll disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 7. ADVANCED ANTI-ANCHOR / ANTI-FREEZE / ANTI-MOVER V2
--    • Unanchors all character parts on Stepped
--    • Purges hostile BodyPosition, BodyVelocity, BodyGyro, AlignPosition,
--      AlignOrientation, LinearVelocity, AngularVelocity, VectorForce injected by enemies
-- ═══════════════════════════════════════════════════════════════════════════════
local HOSTILE_MOVER_CLASSES = {
    BodyVelocity = true,
    BodyPosition = true,
    BodyGyro = true,
    BodyAngularVelocity = true,
    BodyForce = true,
    BodyThrust = true,
    RocketPropulsion = true,
    LinearVelocity = true,
    AngularVelocity = true,
    VectorForce = true,
    LineForce = true,
    AlignPosition = true,
    AlignOrientation = true,
}

local function anchorCleanse(c)
    if not c then return end
    for _, obj in ipairs(c:GetDescendants()) do
        if obj:IsA("BasePart") then
            if obj.Anchored and not deflectBusy then
                obj.Anchored = false
                Anti.Anchor.purgedMovers = Anti.Anchor.purgedMovers + 1
            end
        elseif HOSTILE_MOVER_CLASSES[obj.ClassName] and not obj.Name:match("^Coco") then
            pcall(function()
                obj:Destroy()
                Anti.Anchor.purgedMovers = Anti.Anchor.purgedMovers + 1
            end)
        end
    end
end

anchorStart = function()
    if Anti.Anchor.enabled then return end
    Anti.Anchor.enabled = true
    anchorCleanse(LP.Character)
    if Anti.Anchor.steppedConn then Anti.Anchor.steppedConn:Disconnect() end
    Anti.Anchor.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.Anchor.enabled then return end
        anchorCleanse(LP.Character)
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Anchor / Anti-Freeze / Anti-Mover v2 ON")
    sToggleOn()
end

anchorStop = function()
    if not Anti.Anchor.enabled then return end
    Anti.Anchor.enabled = false
    if Anti.Anchor.steppedConn then Anti.Anchor.steppedConn:Disconnect(); Anti.Anchor.steppedConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Anchor disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 8. ADVANCED ANTI-ATTACH / HOSTILE WELD & GRAB SEVER V2
--    • Scans BOTH LP.Character AND external characters/workspace for any Joint/Constraint
--      (Weld, WeldConstraint, RigidConstraint, Motor6D, AlignPosition, Rope, etc.)
--      that links any part of our character to an external object or player!
-- ═══════════════════════════════════════════════════════════════════════════════
local function isJointHostileToCharacter(obj, myChar)
    if not obj or not myChar then return false end
    if obj:IsA("JointInstance") or obj:IsA("WeldConstraint") then
        local p0, p1 = obj.Part0, obj.Part1
        local p0Mine = p0 and p0:IsDescendantOf(myChar)
        local p1Mine = p1 and p1:IsDescendantOf(myChar)
        if (p0Mine and p1 and not p1Mine) or (p1Mine and p0 and not p0Mine) then
            return true
        end
    elseif obj:IsA("Constraint") then
        local a0, a1 = obj.Attachment0, obj.Attachment1
        local a0Mine = a0 and a0:IsDescendantOf(myChar)
        local a1Mine = a1 and a1:IsDescendantOf(myChar)
        if (a0Mine and a1 and not a1Mine) or (a1Mine and a0 and not a0Mine) then
            return true
        end
    end
    return false
end

local function severAllHostileAttachments()
    local myChar = LP.Character
    if not myChar then return 0 end
    local severed = 0
    -- 1. Check joints/constraints inside our own character
    for _, obj in ipairs(myChar:GetDescendants()) do
        if isJointHostileToCharacter(obj, myChar) then
            pcall(function() obj:Destroy() end)
            severed = severed + 1
        elseif obj:IsA("BasePart") then
            local okJ, joints = pcall(function() return obj:GetJoints() end)
            if okJ and joints then
                for _, j in ipairs(joints) do
                    if isJointHostileToCharacter(j, myChar) then
                        pcall(function() j:Destroy() end)
                        severed = severed + 1
                    end
                end
            end
        end
    end
    -- 2. Check joints/constraints inside other players' characters & tools (catches external grab welds!)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, obj in ipairs(p.Character:GetDescendants()) do
                if isJointHostileToCharacter(obj, myChar) then
                    pcall(function() obj:Destroy() end)
                    severed = severed + 1
                end
            end
        end
    end
    Anti.Attach.severedCount = Anti.Attach.severedCount + severed
    return severed
end

attachStart = function()
    if Anti.Attach.enabled then return end
    Anti.Attach.enabled = true
    severAllHostileAttachments()
    if Anti.Attach.steppedConn then Anti.Attach.steppedConn:Disconnect() end
    Anti.Attach.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.Attach.enabled then return end
        severAllHostileAttachments()
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Attach / Omni-Weld & Grab Sever v2 ON")
    sToggleOn()
end

attachStop = function()
    if not Anti.Attach.enabled then return end
    Anti.Attach.enabled = false
    if Anti.Attach.steppedConn then Anti.Attach.steppedConn:Disconnect(); Anti.Attach.steppedConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Attach disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 9. ADVANCED ANTI-BLIND / ANTI-FLASH & VISION CLEAR V2
--    • Cleanses Lighting & Camera post-effects (Blur, ColorCorrection, Bloom, DepthOfField, Fog)
--    • Neutralizes full-screen blinding flashbang overlays in PlayerGui
-- ═══════════════════════════════════════════════════════════════════════════════
local function blindCleanse()
    local Lighting = game:GetService("Lighting")
    pcall(function()
        if Lighting.FogEnd < 250 then Lighting.FogEnd = 100000 end
        for _, eff in ipairs(Lighting:GetChildren()) do
            if eff:IsA("BlurEffect") and eff.Size > 4 then
                eff.Enabled = false; eff.Size = 0
            elseif eff:IsA("ColorCorrectionEffect") and (eff.Brightness < -0.25 or eff.Brightness > 0.6 or eff.Contrast > 1.5 or eff.TintColor ~= Color3.new(1, 1, 1)) then
                eff.Enabled = false
            elseif eff:IsA("DepthOfFieldEffect") and eff.FarIntensity > 0.5 then
                eff.Enabled = false
            elseif eff:IsA("BloomEffect") and eff.Intensity > 2.5 then
                eff.Enabled = false
            elseif eff:IsA("Atmosphere") and eff.Density > 0.65 then
                eff.Density = 0.25
            end
        end
        local currentCam = workspace.CurrentCamera
        if currentCam then
            if currentCam.FieldOfView < 40 or currentCam.FieldOfView > 115 then
                currentCam.FieldOfView = 70
            end
            for _, eff in ipairs(currentCam:GetChildren()) do
                if eff:IsA("PostEffect") and not eff.Name:match("^Coco") then
                    eff.Enabled = false
                end
            end
        end
        -- Check PlayerGui for hostile full-screen blind/flashbang ScreenGuis
        local pgui = LP:FindFirstChildOfClass("PlayerGui")
        if pgui then
            for _, sg in ipairs(pgui:GetChildren()) do
                if sg:IsA("ScreenGui") and not sg.Name:match("^Coco") and sg.Name:lower():match("blind|flash|blackout|jumpscare|fade") then
                    sg.Enabled = false
                end
            end
        end
    end)
end

blindStart = function()
    if Anti.Blind.enabled then return end
    Anti.Blind.enabled = true
    blindCleanse()
    if Anti.Blind.loopConn then Anti.Blind.loopConn:Disconnect() end
    Anti.Blind.loopConn = RunService.Heartbeat:Connect(function()
        if not Anti.Blind.enabled then return end
        blindCleanse()
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Blind / Anti-Flashbang & Fog Clear v2 ON")
    sToggleOn()
end

blindStop = function()
    if not Anti.Blind.enabled then return end
    Anti.Blind.enabled = false
    if Anti.Blind.loopConn then Anti.Blind.loopConn:Disconnect(); Anti.Blind.loopConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Blind disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 10. ADVANCED ANTI-BRING / ANTI-TELEPORT / ANTI-TOOL-GRAB GUARD V2
--     • Detects involuntary CFrame snaps (>38 studs) AND FE Tool-Bring grips
--     • Destroys hostile tool welds and restores verified safe trajectory
-- ═══════════════════════════════════════════════════════════════════════════════
bringStart = function()
    if Anti.Bring.enabled then return end
    Anti.Bring.enabled = true
    local c = LP.Character
    local root = c and c:FindFirstChild("HumanoidRootPart")
    if root and isSafePlayableCF(root.CFrame) then
        Anti.Bring.lastCF = root.CFrame
        Anti.Bring.lastSafeTime = tick()
    end
    if Anti.Bring.steppedConn then Anti.Bring.steppedConn:Disconnect() end
    Anti.Bring.steppedConn = RunService.Stepped:Connect(function( _, dt )
        if not Anti.Bring.enabled then return end
        if WeldIntent.active or FlingActive or deflectBusy or (moveState and moveState.fly) then
            local ch = LP.Character
            local r = ch and ch:FindFirstChild("HumanoidRootPart")
            if r and isSafePlayableCF(r.CFrame) then Anti.Bring.lastCF = r.CFrame end
            return
        end
        if tick() - (moveState.lastTeleportTick or 0) < 0.75 then return end

        local ch = LP.Character
        local r = ch and ch:FindFirstChild("HumanoidRootPart")
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        if not r or not hum or hum.Health <= 0 then return end

        -- Strip any foreign Tool attached to our character that belongs to another player (FE Tool-Bring defense)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                for _, tool in ipairs(p.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        local handle = tool:FindFirstChild("Handle")
                        if handle and (handle.Position - r.Position).Magnitude < 6.5 then
                            for _, j in ipairs(handle:GetDescendants()) do
                                if j:IsA("JointInstance") or j:IsA("WeldConstraint") then
                                    if (j.Part0 and j.Part0:IsDescendantOf(ch)) or (j.Part1 and j.Part1:IsDescendantOf(ch)) then
                                        pcall(function() j:Destroy() end)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if Anti.Bring.lastCF then
            local dist = (r.Position - Anti.Bring.lastCF.Position).Magnitude
            local maxAllowedStep = math.max(38, (hum.WalkSpeed or 16) * math.max(dt or 0.016, 0.016) * 4.5 + 22)
            if dist > maxAllowedStep then
                -- Hostile teleport / bring detected!
                severAllHostileAttachments()
                r.AssemblyLinearVelocity = Vector3.zero
                r.AssemblyAngularVelocity = Vector3.zero
                r.CFrame = Anti.Bring.lastCF
                Anti.Bring.blockedBrings = Anti.Bring.blockedBrings + 1
                notify("COCO POWDER", "Anti-Bring v2: Blocked hostile teleport/grab!")
            elseif isSafePlayableCF(r.CFrame) then
                Anti.Bring.lastCF = r.CFrame
            end
        elseif isSafePlayableCF(r.CFrame) then
            Anti.Bring.lastCF = r.CFrame
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Bring / Tool-Grab & Snap Guard v2 ON")
    sToggleOn()
end

bringStop = function()
    if not Anti.Bring.enabled then return end
    Anti.Bring.enabled = false
    if Anti.Bring.steppedConn then Anti.Bring.steppedConn:Disconnect(); Anti.Bring.steppedConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Bring disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 11. ADVANCED ANTI-FLING & NO-CONTACT SHIELD V2
--     • Pre-Simulation (RunService.Stepped): Strips CanCollide, CanTouch & Massless on
--       ALL other players' characters, tools & accessories across the server so a
--       25,000-stud/s spinner can NEVER physically collide with you even in 1 frame!
--     • Post-Simulation (RunService.Heartbeat): Clamps any residual velocity/angular
--       impulse and snaps back to pre-step CFrame if an exploit spike occurs.
-- ═══════════════════════════════════════════════════════════════════════════════
local function neutralizeOtherPlayersCollision()
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
            local isHighVel = tRoot and (tRoot.AssemblyLinearVelocity.Magnitude > 55 or tRoot.AssemblyAngularVelocity.Magnitude > 30)
            local isNearby = tRoot and ((tRoot.Position - myRoot.Position).Magnitude < 45)
            if isHighVel or isNearby then
                for _, part in ipairs(p.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if part.CanCollide then part.CanCollide = false end
                        if part.CanTouch then part.CanTouch = false end
                        if not part.Massless then part.Massless = true end
                        if isHighVel then
                            pcall(function()
                                part.AssemblyLinearVelocity = Vector3.zero
                                part.AssemblyAngularVelocity = Vector3.zero
                            end)
                        end
                    end
                end
            end
        end
    end
end

flingShieldStart = function()
    if Anti.FlingShield.enabled then return end
    Anti.FlingShield.enabled = true
    if Anti.FlingShield.steppedConn then Anti.FlingShield.steppedConn:Disconnect() end
    Anti.FlingShield.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.FlingShield.enabled and not DefenceTroll.enabled then return end
        if WeldIntent.active or FlingActive or deflectBusy then return end
        neutralizeOtherPlayersCollision()
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if myRoot and isSafePlayableCF(myRoot.CFrame) then
            if myRoot.AssemblyLinearVelocity.Magnitude < 90 and myRoot.AssemblyAngularVelocity.Magnitude < 35 then
                Anti.FlingShield.preStepCF = myRoot.CFrame
            else
                myRoot.AssemblyLinearVelocity = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
                if Anti.FlingShield.preStepCF then
                    myRoot.CFrame = Anti.FlingShield.preStepCF
                end
                Anti.FlingShield.blockedFlings = Anti.FlingShield.blockedFlings + 1
            end
        end
    end)
    if Anti.FlingShield.heartbeatConn then Anti.FlingShield.heartbeatConn:Disconnect() end
    Anti.FlingShield.heartbeatConn = RunService.Heartbeat:Connect(function()
        if not Anti.FlingShield.enabled and not DefenceTroll.enabled then return end
        if WeldIntent.active or FlingActive or deflectBusy then return end
        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return end
        if myRoot.AssemblyLinearVelocity.Magnitude > 90 or myRoot.AssemblyAngularVelocity.Magnitude > 35 then
            myRoot.AssemblyLinearVelocity = Vector3.zero
            myRoot.AssemblyAngularVelocity = Vector3.zero
            if Anti.FlingShield.preStepCF and isSafePlayableCF(Anti.FlingShield.preStepCF) then
                myRoot.CFrame = Anti.FlingShield.preStepCF
            end
            Anti.FlingShield.blockedFlings = Anti.FlingShield.blockedFlings + 1
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Fling Shield v2 (Pre/Post-Physics Zero-Impulse) ON")
    sToggleOn()
end

flingShieldStop = function()
    if not Anti.FlingShield.enabled then return end
    Anti.FlingShield.enabled = false
    if not DefenceTroll.enabled then
        if Anti.FlingShield.steppedConn then
            Anti.FlingShield.steppedConn:Disconnect()
            Anti.FlingShield.steppedConn = nil
        end
        if Anti.FlingShield.heartbeatConn then
            Anti.FlingShield.heartbeatConn:Disconnect()
            Anti.FlingShield.heartbeatConn = nil
        end
    end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Anti-Fling Shield disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 12. ADVANCED DEFENCE TROLL MATRIX V2 (6 COUNTER-MODES + OMNI-THREAT RADAR)
-- ═══════════════════════════════════════════════════════════════════════════════
local function findBestRedirectVictim(attacker)
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local bestPlr, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p ~= attacker and p.Character then
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            if r and (not h or h.Health > 0) and r.Position.Y > (OriginalFPDH + 25) then
                local d = (r.Position - myRoot.Position).Magnitude
                if d < bestDist then
                    bestDist = d
                    bestPlr = p
                end
            end
        end
    end
    return bestPlr
end

local function executeDeflectAction(attacker, threatReason)
    if deflectBusy then return end
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not myRoot or not myHum or myHum.Health <= 0 then return end
    if not attacker or not attacker.Character then return end
    local attRoot = pickTargetRef(attacker.Character, "torso")
    if not attRoot then return end

    deflectBusy = true
    DefenceTroll.deflectCount = DefenceTroll.deflectCount + 1
    DefenceTroll.lastAttackerName = attacker.Name
    DefenceTroll.lastThreatReason = threatReason or "Proximity/Troll"

    -- Determine active counter mode (respects dedicated PauseTrap / Redirect toggles too)
    local mode = DefenceTroll.mode or "GodMatrix"
    if not DefenceTroll.enabled then
        if Anti.Redirect.enabled then mode = "Redirect"
        elseif Anti.PauseTrap.enabled then mode = "VoidPause" end
    end

    local savedCF = isSafePlayableCF(myRoot.CFrame) and myRoot.CFrame or findFallbackSafeCF()
    markIntentionalTeleport(savedCF)
    local currentCam = workspace.CurrentCamera
    local savedCamCF = currentCam and currentCam.CFrame
    local savedCamType = currentCam and currentCam.CameraType

    pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
    if currentCam and savedCamCF then
        pcall(function()
            currentCam.CameraType = Enum.CameraType.Scriptable
            currentCam.CFrame = savedCamCF
        end)
    end

    -- 1. Instant Disarm: Sever any hostile welds/constraints & make local parts non-colliding with world walls
    severAllHostileAttachments()
    for _, part in ipairs(myChar:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.CanTouch = false
            part.Massless = true
        end
    end

    local alertMsg = "🛡️ " .. (DefenceTroll.modeLabels[mode] or mode) .. " -> " .. attacker.Name .. " (" .. tostring(DefenceTroll.lastThreatReason) .. ")"
    notify("COCO POWDER", alertMsg)
    if showDefenceToast then showDefenceToast(alertMsg) end
    sFling()

    local voidDropY = math.clamp(OriginalFPDH - 155, -780, -340)
    local voidDropCF = CFrame.new(savedCF.Position.X, voidDropY, savedCF.Position.Z)

    if mode == "GodMatrix" then
        -- Phase 1: High-RPM Kinetic Vortex Intersection through Attacker Center of Mass
        for i = 1, 6 do
            if not myRoot.Parent or not attRoot.Parent then break end
            local angle = i * 1.15
            myRoot.CFrame = attRoot.CFrame * CFrame.new(math.cos(angle) * 0.65, 0, math.sin(angle) * 0.65)
                * CFrame.Angles(math.rad(math.random(-180, 180)), angle, math.rad(math.random(-180, 180)))
            myRoot.AssemblyAngularVelocity = Vector3.new(95000, 95000, 95000)
            myRoot.AssemblyLinearVelocity = Vector3.new(math.random(-28000, 28000), -60000, math.random(-28000, 28000))
            RunService.Heartbeat:Wait()
        end
        -- Phase 2: Streamed-Chunk Void Drop (kills welded attackers instantly)
        for _ = 1, 5 do
            if not myRoot.Parent then break end
            myRoot.CFrame = voidDropCF
            myRoot.AssemblyLinearVelocity = Vector3.new(0, -75000, 0)
            myRoot.AssemblyAngularVelocity = Vector3.zero
            RunService.Heartbeat:Wait()
        end
        -- Phase 3: Bystander Slingshot Redirect
        local victim = findBestRedirectVictim(attacker)
        if victim and victim.Character then
            local vRoot = pickTargetRef(victim.Character, "torso")
            if vRoot and isSafePlayableCF(vRoot.CFrame) then
                for _ = 1, 4 do
                    if not myRoot.Parent or not vRoot.Parent then break end
                    myRoot.CFrame = vRoot.CFrame * CFrame.new(0, 0, 0.35)
                    myRoot.AssemblyLinearVelocity = Vector3.zero
                    RunService.Heartbeat:Wait()
                end
            end
        end
    elseif mode == "ReverseFling" then
        local startT = tick()
        while tick() - startT < 0.26 do
            if not myRoot.Parent or not attRoot.Parent then break end
            local t = (tick() - startT) * 48
            local vel = attRoot.AssemblyLinearVelocity
            local lead = Vector3.new(vel.X, 0, vel.Z) * 0.06
            myRoot.CFrame = CFrame.new(attRoot.Position + lead + Vector3.new(math.cos(t) * 1.1, 0.3, math.sin(t) * 1.1))
                * CFrame.Angles(t, t * 1.5, 0)
            myRoot.AssemblyAngularVelocity = Vector3.new(95000, 95000, 95000)
            myRoot.AssemblyLinearVelocity = Vector3.new(math.random(-22000, 22000), 48000, math.random(-22000, 22000))
            RunService.Heartbeat:Wait()
        end
    elseif mode == "VoidPause" then
        for _ = 1, 7 do
            if not myRoot.Parent then break end
            myRoot.CFrame = voidDropCF
            myRoot.AssemblyLinearVelocity = Vector3.new(0, -78000, 0)
            myRoot.AssemblyAngularVelocity = Vector3.new(45000, 0, 45000)
            RunService.Heartbeat:Wait()
        end
    elseif mode == "Redirect" then
        local victim = findBestRedirectVictim(attacker)
        local vRoot = victim and victim.Character and pickTargetRef(victim.Character, "torso")
        if vRoot and isSafePlayableCF(vRoot.CFrame) then
            local startT = tick()
            while tick() - startT < 0.30 do
                if not myRoot.Parent or not vRoot.Parent then break end
                myRoot.AssemblyLinearVelocity = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
                myRoot.CFrame = vRoot.CFrame * CFrame.new(0, 0, 0.32)
                RunService.Heartbeat:Wait()
            end
        else
            for _ = 1, 6 do
                if not myRoot.Parent then break end
                myRoot.CFrame = voidDropCF
                myRoot.AssemblyLinearVelocity = Vector3.new(0, -70000, 0)
                RunService.Heartbeat:Wait()
            end
        end
    elseif mode == "Blackhole" then
        local startT = tick()
        while tick() - startT < 0.26 do
            if not myRoot.Parent or not attRoot.Parent then break end
            local elapsed = tick() - startT
            local radius = 0.8 + (elapsed * 18)
            local angle = elapsed * 58
            local offset = Vector3.new(math.cos(angle) * radius, 0.6, math.sin(angle) * radius)
            myRoot.CFrame = CFrame.lookAt(attRoot.Position + offset, attRoot.Position)
            myRoot.AssemblyLinearVelocity = offset.Unit * 58000
            myRoot.AssemblyAngularVelocity = Vector3.new(0, 95000, 0)
            RunService.Heartbeat:Wait()
        end
    elseif mode == "SkyOrbit" then
        -- SKY ORBIT: Launches welded/attacking troll vertically into upper-atmosphere orbit (+18,000 Y)
        local skyCF = CFrame.new(savedCF.Position.X, math.min(savedCF.Position.Y + 18000, 45000), savedCF.Position.Z)
        for _ = 1, 5 do
            if not myRoot.Parent or not attRoot.Parent then break end
            myRoot.CFrame = attRoot.CFrame
            myRoot.AssemblyLinearVelocity = Vector3.new(0, 85000, 0)
            myRoot.AssemblyAngularVelocity = Vector3.new(85000, 85000, 85000)
            RunService.Heartbeat:Wait()
        end
        for _ = 1, 4 do
            if not myRoot.Parent then break end
            myRoot.CFrame = skyCF
            myRoot.AssemblyLinearVelocity = Vector3.new(0, 90000, 0)
            RunService.Heartbeat:Wait()
        end
    end

    -- Multi-frame anchored snapback to exact savedCF so local player NEVER stays stuck in the void
    LastVoidActionEnd = tick()
    markIntentionalTeleport(savedCF)
    safeReturnFromVoid(myChar, savedCF)
    task.wait(0.06)
    if currentCam then
        pcall(function()
            currentCam.CameraType = savedCamType or Enum.CameraType.Custom
            if myHum then currentCam.CameraSubject = myHum end
        end)
    end
    deflectBusy = false
    if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
end

-- Omni-Threat Radar: Detects Spinners, Weld/Backshot/Facebang Trolls, High-Speed Rams & Hostile Joints
RunService.Heartbeat:Connect(function(dt)
    if not DefenceTroll.enabled and not Anti.Redirect.enabled and not Anti.PauseTrap.enabled then
        return
    end
    if WeldIntent.active or FlingActive or deflectBusy then return end

    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not myRoot or not myHum or myHum.Health <= 0 then return end

    local baseRange = DefenceTroll.enabled and (DefenceTroll.range or 7.5) or 6.5
    local now = tick()

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local tRoot = pickTargetRef(p.Character, "torso")
            local tHum  = p.Character:FindFirstChildOfClass("Humanoid")
            if tRoot and (not tHum or tHum.Health > 0) then
                local dist = (tRoot.Position - myRoot.Position).Magnitude
                local vel = tRoot.AssemblyLinearVelocity
                local velMag = vel.Magnitude
                local angMag = tRoot.AssemblyAngularVelocity.Magnitude

                -- Calculate closing speed toward our character
                local toMe = (myRoot.Position - tRoot.Position)
                local closingSpeed = (toMe.Magnitude > 0.01) and vel:Dot(toMe.Unit) or 0

                -- Detect oscillation / weld-troll pattern (Facebang / Backshots / Headsit)
                local prevPos = attackerLastPos[p.UserId]
                attackerLastPos[p.UserId] = tRoot.Position
                local stepDelta = prevPos and (tRoot.Position - prevPos).Magnitude or 0

                local isSpinnerThreat = (velMag > 85 or angMag > 45) and dist <= (baseRange * 2.4)
                local isWeldTrollState = dist <= (baseRange + 1.5) and (
                    (tHum and (tHum.PlatformStand or tHum.Sit or tHum:GetState() == Enum.HumanoidStateType.Physics))
                    or (dist < 4.2 and stepDelta > 1.1)
                    or closingSpeed > 42
                )

                if isSpinnerThreat or isWeldTrollState or dist <= baseRange then
                    local weight = 1.0
                    local reason = "Aura Contact"
                    if isSpinnerThreat then
                        weight = 5.0
                        reason = "Fling Spinner"
                    elseif isWeldTrollState then
                        weight = 3.8
                        reason = "Weld/Troll Lock"
                    end
                    contactTimers[p.UserId] = (contactTimers[p.UserId] or 0) + dt * weight
                    local lastCd = deflectCooldowns[p.UserId] or 0
                    if (contactTimers[p.UserId] >= 0.12 or isSpinnerThreat or isWeldTrollState) and (now - lastCd) > 0.65 then
                        deflectCooldowns[p.UserId] = now
                        contactTimers[p.UserId] = 0
                        task.spawn(function() executeDeflectAction(p, reason) end)
                        break
                    end
                else
                    contactTimers[p.UserId] = math.max(0, (contactTimers[p.UserId] or 0) - dt * 2)
                end
            end
        end
    end
end)

redirectStart = function()
    Anti.Redirect.enabled = true
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Troll Redirect ON (transfers attackers to another player)")
    sToggleOn()
end
redirectStop = function()
    Anti.Redirect.enabled = false
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Troll Redirect disabled")
    sToggleOff()
end

pauseTrapStart = function()
    Anti.PauseTrap.enabled = true
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Void-Pause Trap ON (banishes welded attackers)")
    sToggleOn()
end
pauseTrapStop = function()
    Anti.PauseTrap.enabled = false
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Void-Pause Trap disabled")
    sToggleOff()
end

defenceTrollStart = function()
    DefenceTroll.enabled = true
    flingShieldStart()
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Defence Troll Matrix v2 ON: " .. (DefenceTroll.modeLabels[DefenceTroll.mode] or DefenceTroll.mode))
    sToggleOn()
end
defenceTrollStop = function()
    DefenceTroll.enabled = false
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("COCO POWDER", "Defence Troll Matrix OFF")
    sToggleOff()
end

enableAllAntiSystems = function()
    defenceTrollStart()
    avStart()
    akStart()
    flingShieldStart()
    ragdollStart()
    anchorStart()
    attachStart()
    blindStart()
    bringStart()
    agpStart()
    afkStart()
    if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    notify("COCO POWDER", "🛡️ ALL ADVANCED ANTI SHIELDS ACTIVATED!")
    sSuccess()
end

disableAllAntiSystems = function()
    defenceTrollStop()
    redirectStop()
    pauseTrapStop()
    avStop()
    akStop()
    flingShieldStop()
    ragdollStop()
    anchorStop()
    attachStop()
    blindStop()
    bringStop()
    agpStop()
    afkStop()
    vcStop()
    if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    notify("COCO POWDER", "All Anti shields disabled")
    sToggleOff()
end
end -- end Anti internal scope

local function buildMainUI()
    local currentCamInit = workspace.CurrentCamera or cam
    local vp = currentCamInit and currentCamInit.ViewportSize or Vector2.new(1280, 720)
    local screenW = (vp and vp.X > 300) and vp.X or 1280
    local screenH = (vp and vp.Y > 300) and vp.Y or 720

    -- Sleek, compact window dimensions that never overwhelm mobile or desktop screens
    local function computeWindowSize(sw, sh)
        local w = math.clamp(sw - 32, 300, sw >= 900 and 430 or 360)
        local h = math.clamp(math.floor(sh * 0.48), 320, 390)
        return w, h
    end

    local W, H = computeWindowSize(screenW, screenH)
    local uiState = { minimized = false, open = true }
    local dragging, dragStart, startPos
    local panelShadow

    gui = Instance.new("ScreenGui")
    gui.Name = "CocoPowderV35"
    gui.ResetOnSpawn = false
    gui.Enabled = true
    gui.DisplayOrder = 999999
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.IgnoreGuiInset = true
    local mountOk = pcall(function() gui.Parent = GuiParent end)
    if not mountOk or not gui.Parent then
        local playerGui = LP:FindFirstChildOfClass("PlayerGui") or LP:WaitForChild("PlayerGui", 8)
        if not playerGui then error("No usable PlayerGui found while mounting COCO POWDER ScreenGui") end
        gui.Parent = playerGui
    end

    -- Compact floating CP launcher (only shown when the main panel is minimized/hidden)
    local mobToggle = Instance.new("TextButton")
    mobToggle.Name = "CocoPowderLauncher"
    mobToggle.Size = UDim2.new(0, 42, 0, 42)
    mobToggle.Position = UDim2.new(0, 14, 0.5, -21)
    mobToggle.BackgroundColor3 = Color3.fromRGB(18, 22, 28)
    mobToggle.BackgroundTransparency = 0.08
    mobToggle.Text = "CP"
    mobToggle.TextColor3 = T.Neon
    mobToggle.Font = Enum.Font.GothamBlack
    mobToggle.TextSize = 13
    mobToggle.AutoButtonColor = false
    mobToggle.Active = true
    mobToggle.ZIndex = 999
    mobToggle.Visible = false -- stays hidden while panel is open so it never overlaps the UI
    mobToggle.Parent = gui
    Instance.new("UICorner", mobToggle).CornerRadius = UDim.new(1, 0)

    local mobStroke = Instance.new("UIStroke")
    mobStroke.Color = T.Accent
    mobStroke.Thickness = 1.6
    mobStroke.Transparency = 0.15
    mobStroke.Parent = mobToggle

    local launcherDot = Instance.new("Frame")
    launcherDot.Size = UDim2.new(0, 8, 0, 8)
    launcherDot.Position = UDim2.new(1, -10, 1, -10)
    launcherDot.BackgroundColor3 = T.Success
    launcherDot.BorderSizePixel = 0
    launcherDot.ZIndex = 1000
    launcherDot.Parent = mobToggle
    Instance.new("UICorner", launcherDot).CornerRadius = UDim.new(1, 0)

    -- Main sleek window container
    local main = Instance.new("Frame")
    main.Name = "NebulaDashboard"
    main.Size = UDim2.new(0, W, 0, H)
    main.Position = UDim2.new(0.5, -W/2, 0.57, -H/2)
    main.BackgroundColor3 = T.BG
    main.BackgroundTransparency = 0.03
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Active = true
    main.ZIndex = 5
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

    panelShadow = Instance.new("Frame")
    panelShadow.Name = "PanelShadow"
    panelShadow.Position = UDim2.new(0.5, -W/2 - 4, 0.57, -H/2 + 4)
    panelShadow.Size = UDim2.new(0, W + 8, 0, H + 8)
    panelShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    panelShadow.BackgroundTransparency = 0.52
    panelShadow.BorderSizePixel = 0
    panelShadow.ZIndex = 4
    panelShadow.Parent = gui
    Instance.new("UICorner", panelShadow).CornerRadius = UDim.new(0, 16)

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = T.Border
    mainStroke.Thickness = 1.2
    mainStroke.Transparency = 0.25
    mainStroke.Parent = main

    local function refreshViewportLayout()
        local currentCamera = workspace.CurrentCamera
        if not currentCamera or not main.Parent then return end
        local size = currentCamera.ViewportSize
        local newW, newH = computeWindowSize(size.X, size.Y)
        W, H = newW, newH
        main.Size = UDim2.new(0, newW, 0, newH)
        panelShadow.Size = UDim2.new(0, newW + 8, 0, newH + 8)
        if not dragging then
            main.Position = UDim2.new(0.5, -newW / 2, 0.57, -newH / 2)
            panelShadow.Position = UDim2.new(0.5, -newW / 2 - 4, 0.57, -newH / 2 + 4)
        end
    end
    local currentCamera = workspace.CurrentCamera
    if currentCamera then
        currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(refreshViewportLayout)
    end

    local setPanelOpen
    local mobDrag, mobStart, mobPos, mobMoved = false, nil, nil, false
    local lastLauncherToggle = 0
    local function triggerLauncherToggle()
        if tick() - lastLauncherToggle < 0.18 then return end
        lastLauncherToggle = tick()
        sClick()
        if setPanelOpen then setPanelOpen(true) end
    end
    mobToggle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            mobDrag = true; mobStart = inp.Position; mobPos = mobToggle.Position; mobMoved = false
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if mobDrag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local delta = inp.Position - mobStart
            if math.abs(delta.X) > 8 or math.abs(delta.Y) > 8 then mobMoved = true end
            if mobMoved then
                mobToggle.Position = UDim2.new(mobPos.X.Scale, mobPos.X.Offset + delta.X, mobPos.Y.Scale, mobPos.Y.Offset + delta.Y)
            end
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if mobDrag and not mobMoved then triggerLauncherToggle() end
            mobDrag = false
        end
    end)
    mobToggle.MouseButton1Click:Connect(function()
        if not mobMoved then triggerLauncherToggle() end
    end)

    local BtnColors = setmetatable({}, {__mode = "k"})
    local function styleBtn(b, initialColor)
        BtnColors[b] = initialColor
        b.BackgroundColor3 = initialColor
        b.AutoButtonColor = false
        b.MouseEnter:Connect(function()
            sHover()
            if BtnColors[b] then
                TweenService:Create(b, TweenInfo.new(0.12), {BackgroundColor3 = BtnColors[b]:Lerp(Color3.new(1, 1, 1), 0.08)}):Play()
            end
        end)
        b.MouseLeave:Connect(function()
            if BtnColors[b] then
                TweenService:Create(b, TweenInfo.new(0.16), {BackgroundColor3 = BtnColors[b]}):Play()
            end
        end)
    end

    -- ═══════════════════════════════════════════════════════════════════════════
    -- COMPACT HEADER BAR (42px)
    -- ═══════════════════════════════════════════════════════════════════════════
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 42)
    header.BackgroundColor3 = T.BG2
    header.BorderSizePixel = 0
    header.ZIndex = 6
    header.Parent = main

    local headerLine = Instance.new("Frame")
    headerLine.Size = UDim2.new(1, 0, 0, 1)
    headerLine.Position = UDim2.new(0, 0, 1, -1)
    headerLine.BackgroundColor3 = T.Border
    headerLine.BackgroundTransparency = 0.4
    headerLine.BorderSizePixel = 0
    headerLine.ZIndex = 7
    headerLine.Parent = header

    local brandMark = Instance.new("Frame")
    brandMark.Size = UDim2.new(0, 24, 0, 24)
    brandMark.Position = UDim2.new(0, 12, 0.5, -12)
    brandMark.BackgroundColor3 = T.Accent2
    brandMark.BorderSizePixel = 0
    brandMark.ZIndex = 8
    brandMark.Parent = header
    Instance.new("UICorner", brandMark).CornerRadius = UDim.new(0, 6)

    local brandGlyph = Instance.new("TextLabel")
    brandGlyph.Size = UDim2.new(1, 0, 1, 0)
    brandGlyph.BackgroundTransparency = 1
    brandGlyph.Text = "C"
    brandGlyph.TextColor3 = Color3.new(1, 1, 1)
    brandGlyph.Font = Enum.Font.GothamBlack
    brandGlyph.TextSize = 13
    brandGlyph.ZIndex = 9
    brandGlyph.Parent = brandMark

    showDefenceToast = function(msg)
        pcall(function()
            if not gui or not gui.Parent then return end
            local old = gui:FindFirstChild("CocoDefenceToast")
            if old then old:Destroy() end
            local tFrame = Instance.new("Frame")
            tFrame.Name = "CocoDefenceToast"
            tFrame.Size = UDim2.new(0, 280, 0, 34)
            tFrame.Position = UDim2.new(0.5, -140, 0, -42)
            tFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
            tFrame.BorderSizePixel = 0
            tFrame.ZIndex = 500
            tFrame.Parent = gui
            Instance.new("UICorner", tFrame).CornerRadius = UDim.new(0, 9)
            local tStroke = Instance.new("UIStroke")
            tStroke.Color = Color3.fromRGB(138, 92, 246)
            tStroke.Thickness = 1.3
            tStroke.Transparency = 0.2
            tStroke.Parent = tFrame
            local tLbl = Instance.new("TextLabel")
            tLbl.Size = UDim2.new(1, -12, 1, 0)
            tLbl.Position = UDim2.new(0, 6, 0, 0)
            tLbl.BackgroundTransparency = 1
            tLbl.Text = msg
            tLbl.TextColor3 = Color3.fromRGB(245, 245, 255)
            tLbl.Font = Enum.Font.GothamBold
            tLbl.TextSize = 10
            tLbl.ZIndex = 501
            tLbl.Parent = tFrame
            TweenService:Create(tFrame, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, -140, 0, 16)
            }):Play()
            task.delay(2.6, function()
                if tFrame and tFrame.Parent then
                    local tw = TweenService:Create(tFrame, TweenInfo.new(0.25), {
                        Position = UDim2.new(0.5, -140, 0, -42),
                        BackgroundTransparency = 1
                    })
                    tw:Play()
                    tw.Completed:Connect(function() tFrame:Destroy() end)
                end
            end)
        end)
    end

    local isMobileDevice = (UIS.TouchEnabled and not UIS.KeyboardEnabled) or UIS.TouchEnabled
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -210, 0, 16)
    title.Position = UDim2.new(0, 44, 0.5, -12)
    title.BackgroundTransparency = 1
    title.Text = "COCO POWDER"
    title.TextColor3 = T.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 8
    title.Parent = header

    local subTitle = Instance.new("TextLabel")
    subTitle.Size = UDim2.new(1, -210, 0, 12)
    subTitle.Position = UDim2.new(0, 44, 0.5, 4)
    subTitle.BackgroundTransparency = 1
    subTitle.Text = "OMNIPRESENT V34 SEEKER  ·  " .. (isMobileDevice and "📱 ANDROID" or "💻 PC")
    subTitle.TextColor3 = T.Neon
    subTitle.Font = Enum.Font.GothamMedium
    subTitle.TextSize = 8
    subTitle.TextXAlignment = Enum.TextXAlignment.Left
    subTitle.ZIndex = 8
    subTitle.Parent = header

    -- Live HUD Badge (FPS / Ping / Protections)
    local hudBadge = Instance.new("Frame")
    hudBadge.Size = UDim2.new(0, 96, 0, 22)
    hudBadge.Position = UDim2.new(1, -172, 0.5, -11)
    hudBadge.BackgroundColor3 = T.Panel
    hudBadge.BorderSizePixel = 0
    hudBadge.ZIndex = 8
    hudBadge.Parent = header
    Instance.new("UICorner", hudBadge).CornerRadius = UDim.new(0, 6)
    local hudStroke = Instance.new("UIStroke")
    hudStroke.Color = T.Border
    hudStroke.Thickness = 1
    hudStroke.Transparency = 0.5
    hudStroke.Parent = hudBadge

    local hudText = Instance.new("TextLabel")
    hudText.Size = UDim2.new(1, 0, 1, 0)
    hudText.BackgroundTransparency = 1
    hudText.Text = "60 FPS · 🛡️ 0"
    hudText.TextColor3 = T.Text
    hudText.Font = Enum.Font.GothamBold
    hudText.TextSize = 9
    hudText.ZIndex = 9
    hudText.Parent = hudBadge

    task.spawn(function()
        local lastTime = tick()
        local frameCount = 0
        RunService.RenderStepped:Connect(function()
            frameCount = frameCount + (1)
            local now = tick()
            if now - lastTime >= 0.8 then
                local fps = math.clamp(math.floor(frameCount / (now - lastTime)), 1, 240)
                frameCount = 0
                lastTime = now
                local activeProtCount = 0
                for _, sub in pairs(Anti) do
                    if typeof(sub) == "table" and sub.enabled then activeProtCount = activeProtCount + (1) end
                end
                if DefenceTroll.enabled then activeProtCount = activeProtCount + (1) end
                if hudText and hudText.Parent then
                    hudText.Text = tostring(fps) .. " FPS · 🛡️ " .. tostring(activeProtCount)
                end
            end
        end)
    end)

    local function makeWinBtn(xOffset, labelText, bgCol)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 26, 0, 26)
        b.Position = UDim2.new(1, xOffset, 0.5, -13)
        b.BackgroundColor3 = bgCol
        b.Text = labelText
        b.TextColor3 = T.Text
        b.Font = Enum.Font.GothamBold
        b.TextSize = 12
        b.AutoButtonColor = false
        b.ZIndex = 8
        b.Parent = header
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        styleBtn(b, bgCol)
        return b
    end

    local btnMin   = makeWinBtn(-68, "—", T.PanelLt)
    local btnClose = makeWinBtn(-36, "X", T.Accent2)

    header.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = inp.Position; startPos = main.Position
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            panelShadow.Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset - 4, main.Position.Y.Scale, main.Position.Y.Offset + 4)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- ═══════════════════════════════════════════════════════════════════════════
    -- SLEEK HORIZONTAL SEGMENTED TAB BAR (36px) - Replaces cramped left sidebar
    -- ═══════════════════════════════════════════════════════════════════════════
    local tabsBar = Instance.new("Frame")
    tabsBar.Name = "TabsBar"
    tabsBar.Size = UDim2.new(1, -20, 0, 32)
    tabsBar.Position = UDim2.new(0, 10, 0, 48)
    tabsBar.BackgroundColor3 = T.BG2
    tabsBar.BorderSizePixel = 0
    tabsBar.ZIndex = 6
    tabsBar.Parent = main
    Instance.new("UICorner", tabsBar).CornerRadius = UDim.new(0, 8)

    local tabsStroke = Instance.new("UIStroke")
    tabsStroke.Color = T.Border
    tabsStroke.Thickness = 1
    tabsStroke.Transparency = 0.45
    tabsStroke.Parent = tabsBar

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, 0, 1, -124)
    content.Position = UDim2.new(0, 0, 0, 84)
    content.BackgroundTransparency = 1
    content.ZIndex = 6
    content.Parent = main

    -- ═══════════════════════════════════════════════════════════════════════════
    -- SLIM FOOTER BAR (40px)
    -- ═══════════════════════════════════════════════════════════════════════════
    local footer = Instance.new("Frame")
    footer.Name = "Footer"
    footer.Size = UDim2.new(1, 0, 0, 40)
    footer.Position = UDim2.new(0, 0, 1, -40)
    footer.BackgroundColor3 = T.BG2
    footer.BorderSizePixel = 0
    footer.ZIndex = 6
    footer.Parent = main

    local fTop = Instance.new("Frame")
    fTop.Size = UDim2.new(1, 0, 0, 1)
    fTop.BackgroundColor3 = T.Border
    fTop.BackgroundTransparency = 0.4
    fTop.BorderSizePixel = 0
    fTop.ZIndex = 7
    fTop.Parent = footer

    local footerDot = Instance.new("Frame")
    footerDot.Size = UDim2.new(0, 7, 0, 7)
    footerDot.Position = UDim2.new(0, 12, 0.5, -3.5)
    footerDot.BackgroundColor3 = T.Success
    footerDot.BorderSizePixel = 0
    footerDot.ZIndex = 8
    footerDot.Parent = footer
    Instance.new("UICorner", footerDot).CornerRadius = UDim.new(1, 0)

    local footerLabel = Instance.new("TextLabel")
    footerLabel.Size = UDim2.new(1, -148, 0, 16)
    footerLabel.Position = UDim2.new(0, 25, 0, 5)
    footerLabel.BackgroundTransparency = 1
    footerLabel.Text = "Auto: Nearest Player"
    footerLabel.TextColor3 = T.Text
    footerLabel.Font = Enum.Font.GothamBold
    footerLabel.TextSize = 11
    footerLabel.TextXAlignment = Enum.TextXAlignment.Left
    footerLabel.TextTruncate = Enum.TextTruncate.AtEnd
    footerLabel.ZIndex = 8
    footerLabel.Parent = footer

    local footerSub = Instance.new("TextLabel")
    footerSub.Size = UDim2.new(1, -148, 0, 13)
    footerSub.Position = UDim2.new(0, 25, 0, 21)
    footerSub.BackgroundTransparency = 1
    footerSub.Text = "ready · auto-nearest active"
    footerSub.TextColor3 = T.Muted
    footerSub.Font = Enum.Font.Gotham
    footerSub.TextSize = 9
    footerSub.TextXAlignment = Enum.TextXAlignment.Left
    footerSub.TextTruncate = Enum.TextTruncate.AtEnd
    footerSub.ZIndex = 8
    footerSub.Parent = footer

    local btnUnweld = Instance.new("TextButton")
    btnUnweld.Size = UDim2.new(0, 114, 0, 26)
    btnUnweld.Position = UDim2.new(1, -124, 0.5, -13)
    btnUnweld.Text = "STOP / UNWELD"
    btnUnweld.TextColor3 = Color3.new(1, 1, 1)
    btnUnweld.Font = Enum.Font.GothamBold
    btnUnweld.TextSize = 10
    btnUnweld.ZIndex = 8
    btnUnweld.Parent = footer
    Instance.new("UICorner", btnUnweld).CornerRadius = UDim.new(0, 6)
    styleBtn(btnUnweld, T.Accent2)

    local TabPages, TabButtons = {}, {}
    local tabOrderNames = {}

    local function showTab(name)
        for n, p in pairs(TabPages) do
            p.Visible = (n == name)
        end
        for n, b in pairs(TabButtons) do
            local act = (n == name)
            BtnColors[b] = act and T.Accent2 or T.BG2
            TweenService:Create(b, TweenInfo.new(0.16), {
                BackgroundColor3 = act and T.Accent2 or T.BG2,
                TextColor3 = act and Color3.new(1, 1, 1) or T.Muted,
            }):Play()
        end
    end

    local function createTab(name)
        table.insert(tabOrderNames, name)
        local btn = Instance.new("TextButton")
        btn.Name = name .. "TabBtn"
        btn.BackgroundColor3 = T.BG2
        btn.BorderSizePixel = 0
        btn.Text = name
        btn.TextColor3 = T.Muted
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.AutoButtonColor = false
        btn.ZIndex = 7
        btn.Parent = tabsBar
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        styleBtn(btn, T.BG2)
        btn.MouseButton1Click:Connect(function() sClick(); showTab(name) end)
        TabButtons[name] = btn

        local total = #tabOrderNames
        for i, tabName in ipairs(tabOrderNames) do
            local tb = TabButtons[tabName]
            local wScale = 1 / total
            tb.Size = UDim2.new(wScale, -4, 1, -4)
            tb.Position = UDim2.new((i - 1) * wScale, 2, 0, 2)
        end

        local page = Instance.new("ScrollingFrame")
        page.Name = name .. "Page"
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 2
        page.ScrollBarImageColor3 = T.Accent
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        page.Visible = false
        page.ZIndex = 6
        page.Parent = content

        local pad = Instance.new("UIPadding")
        pad.PaddingTop = UDim.new(0, 6)
        pad.PaddingBottom = UDim.new(0, 8)
        pad.PaddingLeft = UDim.new(0, 10)
        pad.PaddingRight = UDim.new(0, 10)
        pad.Parent = page

        local lst = Instance.new("UIListLayout")
        lst.Padding = UDim.new(0, 6)
        lst.SortOrder = Enum.SortOrder.LayoutOrder
        lst.Parent = page

        TabPages[name] = page
        return page
    end

    local function sectionLbl(parent, order, txt, color)
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1, 0, 0, 14)
        l.BackgroundTransparency = 1
        l.Text = txt
        l.TextColor3 = color or T.Muted
        l.Font = Enum.Font.GothamBold
        l.TextSize = 9
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.LayoutOrder = order
        l.ZIndex = 7
        l.Parent = parent
        return l
    end

    -- ═══════════════════════════════════════════════════════════════════════════
    -- TAB 1: WELD (Sleek 2-column grid with built-in Pin button & Compact Target Bar)
    -- ═══════════════════════════════════════════════════════════════════════════
    local weldTab   = createTab("Weld")
    local targetTab = createTab("Target")
    local chatTab   = createTab("Chat")
    local antiTab   = createTab("Anti")
    local moveTab   = createTab("Move")

    -- Compact Target Status Bar inside Weld Tab (52px tall instead of bulky 96px)
    local card = Instance.new("Frame")
    card.Name = "TargetPreview"
    card.Size = UDim2.new(1, 0, 0, 52)
    card.BackgroundColor3 = T.Panel
    card.BorderSizePixel = 0
    card.LayoutOrder = 1
    card.ZIndex = 7
    card.Parent = weldTab
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 9)

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = T.Border
    cardStroke.Thickness = 1
    cardStroke.Transparency = 0.35
    cardStroke.Parent = card

    local avatarFrame = Instance.new("Frame")
    avatarFrame.Size = UDim2.new(0, 38, 0, 38)
    avatarFrame.Position = UDim2.new(0, 8, 0.5, -19)
    avatarFrame.BackgroundColor3 = T.PanelLt
    avatarFrame.BorderSizePixel = 0
    avatarFrame.ZIndex = 8
    avatarFrame.Parent = card
    Instance.new("UICorner", avatarFrame).CornerRadius = UDim.new(1, 0)

    local avatarImg = Instance.new("ImageLabel")
    avatarImg.Size = UDim2.new(1, 0, 1, 0)
    avatarImg.BackgroundTransparency = 1
    avatarImg.Image = ""
    avatarImg.ZIndex = 9
    avatarImg.Parent = avatarFrame
    Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1, 0)

    local avatarPlaceholder = Instance.new("TextLabel")
    avatarPlaceholder.Size = UDim2.new(1, 0, 1, 0)
    avatarPlaceholder.BackgroundTransparency = 1
    avatarPlaceholder.Text = "?"
    avatarPlaceholder.TextColor3 = T.Muted
    avatarPlaceholder.Font = Enum.Font.GothamBold
    avatarPlaceholder.TextSize = 15
    avatarPlaceholder.ZIndex = 8
    avatarPlaceholder.Parent = avatarFrame

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -124, 0, 18)
    nameLbl.Position = UDim2.new(0, 54, 0, 8)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = "Auto: Nearest Player"
    nameLbl.TextColor3 = T.Text
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 12
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
    nameLbl.ZIndex = 9
    nameLbl.Parent = card

    local statusDot = Instance.new("Frame")
    statusDot.Size = UDim2.new(0, 6, 0, 6)
    statusDot.Position = UDim2.new(0, 54, 0, 33)
    statusDot.BackgroundColor3 = T.Success
    statusDot.BorderSizePixel = 0
    statusDot.ZIndex = 9
    statusDot.Parent = card
    Instance.new("UICorner", statusDot).CornerRadius = UDim.new(1, 0)

    local statusTxt = Instance.new("TextLabel")
    statusTxt.Size = UDim2.new(1, -136, 0, 14)
    statusTxt.Position = UDim2.new(0, 65, 0, 29)
    statusTxt.BackgroundTransparency = 1
    statusTxt.Text = "scanning nearest player"
    statusTxt.TextColor3 = T.Muted
    statusTxt.Font = Enum.Font.GothamMedium
    statusTxt.TextSize = 10
    statusTxt.TextXAlignment = Enum.TextXAlignment.Left
    statusTxt.TextTruncate = Enum.TextTruncate.AtEnd
    statusTxt.ZIndex = 9
    statusTxt.Parent = card

    local autoModeBtn = Instance.new("TextButton")
    autoModeBtn.Size = UDim2.new(0, 56, 0, 26)
    autoModeBtn.Position = UDim2.new(1, -64, 0.5, -13)
    autoModeBtn.Text = "AUTO"
    autoModeBtn.TextColor3 = Color3.new(1, 1, 1)
    autoModeBtn.Font = Enum.Font.GothamBold
    autoModeBtn.TextSize = 10
    autoModeBtn.ZIndex = 9
    autoModeBtn.Parent = card
    Instance.new("UICorner", autoModeBtn).CornerRadius = UDim.new(0, 6)
    styleBtn(autoModeBtn, T.PanelLt)

    local lastAvatarId = nil
    local refreshList -- forward declaration

    local function refreshCard()
        local tgt, isAutoNearest = resolveActiveTarget()
        BtnColors[autoModeBtn] = isAutoNearest and T.Success or T.PanelLt
        autoModeBtn.BackgroundColor3 = isAutoNearest and T.Success or T.PanelLt
        if not tgt then
            nameLbl.Text = "Auto: Nearest Player"
            statusTxt.Text = "waiting for nearby players..."
            statusDot.BackgroundColor3 = T.Accent
            avatarImg.Image = ""
            avatarPlaceholder.Visible = true
            cardStroke.Color = T.Border
            lastAvatarId = nil
            return
        end
        avatarPlaceholder.Visible = false
        local uid = tgt.UserId
        local inServer = (tgt.Parent == Players)
        nameLbl.Text = (isAutoNearest and "Nearest: " or "Target: ") .. (tgt.DisplayName or tgt.Name or "?")
        if lastAvatarId ~= uid then
            lastAvatarId = uid
            pcall(function()
                avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. uid .. "&w=150&h=150"
            end)
        end
        if not inServer then
            statusTxt.Text = "@" .. tgt.Name .. " · left server"
            statusDot.BackgroundColor3 = T.Danger
            cardStroke.Color = T.Danger
        else
            local char = findPlayerCharacterAnywhere(tgt)
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local ref = char and pickTargetRef(char, "torso")
            if hum and hum.Health <= 0 then
                statusTxt.Text = "@" .. tgt.Name .. " · respawning"
                statusDot.BackgroundColor3 = T.Warning
                cardStroke.Color = T.Warning
            elseif not ref then
                statusTxt.Text = "@" .. tgt.Name .. " · hidden/far (auto-seek ready)"
                statusDot.BackgroundColor3 = T.Accent
                cardStroke.Color = T.Accent
            else
                local distTxt = ""
                pcall(function()
                    local myR = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                    if myR then distTxt = " · " .. tostring(math.floor((ref.Position - myR.Position).Magnitude)) .. "s" end
                end)
                statusTxt.Text = "@" .. tgt.Name .. distTxt .. " · locked"
                statusDot.BackgroundColor3 = T.Success
                cardStroke.Color = isAutoNearest and T.Border or T.Success
            end
        end
    end

    autoModeBtn.MouseButton1Click:Connect(function()
        sClick()
        selectedPlayer = nil
        syncChatTarget(nil)
        footerLabel.Text = "Auto: Nearest Player"
        footerSub.Text = "auto-connects to nearest player"
        if refreshList then pcall(refreshList) end
        pcall(refreshCard)
        notify("COCO POWDER", "Auto-Nearest Player mode active")
    end)

    refreshCard()
    task.spawn(function()
        while card and card.Parent do
            task.wait(0.5)
            pcall(refreshCard)
        end
    end)

    -- ═══════════════════════════════════════════════════════════════════════════
    -- FLOATING PILL ICONS + SLEEK 2-COLUMN PRESET GRID
    -- Tap preset button -> toggles action ON (turns green) / OFF
    -- Tap right-side [+] / [✓] badge -> adds or removes floating pill icon on screen
    -- ═══════════════════════════════════════════════════════════════════════════
    sectionLbl(weldTab, 2, "TROLL & WELD ACTIONS  (TAP [+] TO PIN FLOATING ICON)", T.Muted)

    local PILL_CATALOG = {
        { key = "headpat",   pillLabel = "Pat",       width = 82  },
        { key = "headsit",   pillLabel = "Headsit",   width = 104 },
        { key = "facebang",  pillLabel = "Facebang",  width = 112 },
        { key = "backshots", pillLabel = "Backshots", width = 114 },
        { key = "kiss",      pillLabel = "Kiss",      width = 82  },
        { key = "backpack",  pillLabel = "Backpack",  width = 110 },
        { key = "propose",   pillLabel = "Propose",   width = 104 },
        { key = "hug",       pillLabel = "Hug",       width = 82  },
        { key = "chase",     pillLabel = "ChaseTP",   width = 104 },
        { key = "fling",     pillLabel = "Fling",     width = 86  },
        { key = "voidthrow", pillLabel = "VoidThrow", width = 112 },
        { key = "deflect",   pillLabel = "Deflect",   width = 100 },
        { key = "rewind",    pillLabel = "Rewind",    width = 96  },
    }
    local PILL_META = {}
    for _, item in ipairs(PILL_CATALOG) do PILL_META[item.key] = item end

    local PILL_BG_OFF       = Color3.fromRGB(20, 24, 29)
    local PILL_STROKE_OFF   = Color3.fromRGB(54, 62, 74)
    local PILL_DOT_OFF      = Color3.fromRGB(88, 96, 110)
    local PILL_DOT_RING_OFF = Color3.fromRGB(122, 132, 146)
    local PILL_TXT_OFF      = Color3.fromRGB(228, 232, 240)

    local PILL_BG_ON        = Color3.fromRGB(22, 138, 72)
    local PILL_STROKE_ON    = Color3.fromRGB(72, 245, 138)
    local PILL_DOT_ON       = Color3.fromRGB(95, 255, 155)
    local PILL_DOT_RING_ON  = Color3.fromRGB(215, 255, 230)
    local PILL_TXT_ON       = Color3.fromRGB(255, 255, 255)

    local presetCards = {} -- key -> { btn, dot, label }
    local pinBadgeButtons = {}
    local ActivePills = {}
    local PillOrderList = {}

    local function isActionKeyActive(key)
        if key == "rewind" then return RewindSys.rewinding == true end
        if key == "fling" or key == "voidthrow" then return FlingActive == true end
        if key == "deflect" then return (DefenceTroll.enabled or Anti.Redirect.enabled or Anti.PauseTrap.enabled) end
        return (WeldIntent.active == true and WeldIntent.presetKey == key)
    end

    -- Dock unmoved floating pills neatly near the top-right edge so they don't cover the center window
    local function layoutUnmovedPills()
        local idx = 0
        for _, key in ipairs(PillOrderList) do
            local entry = ActivePills[key]
            if entry and entry.btn and entry.btn.Parent then
                idx = idx + 1
                if not entry.customMoved then
                    local yPos = 58 + (idx - 1) * 35
                    entry.btn.Position = UDim2.new(1, -(entry.width + 12), 0, yPos)
                end
            end
        end
    end

    local function updatePinBadgeVisual(key)
        local isAdded = ActivePills[key] ~= nil
        local badge = pinBadgeButtons[key]
        if badge and badge.Parent then
            badge.Text = isAdded and "✓" or "+"
            badge.BackgroundColor3 = isAdded and PILL_BG_ON or T.BG2
            badge.TextColor3 = isAdded and Color3.new(1, 1, 1) or T.Muted
        end
    end

    syncAllActiveIndicators = function()
        for key, item in pairs(presetCards) do
            if item and item.btn and item.btn.Parent then
                local act = isActionKeyActive(key)
                local col = act and PILL_BG_ON or T.Panel
                BtnColors[item.btn] = col
                TweenService:Create(item.btn, TweenInfo.new(0.15), {BackgroundColor3 = col}):Play()
                if item.dot then
                    item.dot.BackgroundColor3 = act and PILL_DOT_ON or PILL_DOT_OFF
                end
                if item.stroke then
                    item.stroke.Color = act and PILL_STROKE_ON or T.Border
                    item.stroke.Transparency = act and 0.1 or 0.45
                end
            end
        end
        for key, entry in pairs(ActivePills) do
            if entry and entry.btn and entry.btn.Parent then
                local act = isActionKeyActive(key)
                TweenService:Create(entry.btn, TweenInfo.new(0.15), {
                    BackgroundColor3 = act and PILL_BG_ON or PILL_BG_OFF,
                    BackgroundTransparency = act and 0.04 or 0.12,
                }):Play()
                TweenService:Create(entry.stroke, TweenInfo.new(0.15), {
                    Color = act and PILL_STROKE_ON or PILL_STROKE_OFF,
                    Transparency = act and 0.05 or 0.25,
                }):Play()
                TweenService:Create(entry.dot, TweenInfo.new(0.15), {
                    BackgroundColor3 = act and PILL_DOT_ON or PILL_DOT_OFF,
                }):Play()
                TweenService:Create(entry.dotStroke, TweenInfo.new(0.15), {
                    Color = act and PILL_DOT_RING_ON or PILL_DOT_RING_OFF,
                }):Play()
                entry.label.TextColor3 = act and PILL_TXT_ON or PILL_TXT_OFF
            end
        end
    end

    local function togglePresetOrAction(key)
        if key == "rewind" then
            RewindSys:Start(RewindSys.duration)
            syncAllActiveIndicators()
            return
        end
        if key == "deflect" then
            local turningOn = not (DefenceTroll.enabled or Anti.Redirect.enabled or Anti.PauseTrap.enabled)
            DefenceTroll.enabled = turningOn
            Anti.Redirect.enabled = turningOn
            Anti.PauseTrap.enabled = turningOn
            Anti.FlingShield.enabled = turningOn
            if turningOn then
                flingShieldStart()
                notify("COCO POWDER", "Defence Troll ON (" .. (DefenceTroll.modeLabels[DefenceTroll.mode] or DefenceTroll.mode) .. ")")
            else
                flingShieldStop()
                notify("COCO POWDER", "Defence Troll OFF")
            end
            syncAllActiveIndicators()
            if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
            return
        end
        if key == "voidthrow" then
            if FlingActive then
                StateManager:StopFling(false)
                notify("COCO POWDER", "Void Throw stopped & safely returned")
                sToggleOff()
            else
                launchVoidThrow()
            end
            syncAllActiveIndicators()
            return
        end
        if key == "fling" then
            if FlingActive then
                StateManager:StopFling(false)
                notify("COCO POWDER", "Fling stopped & safely returned")
                sToggleOff()
            else
                launchNebulaFling(-1, "Unlimited", false)
            end
            syncAllActiveIndicators()
            return
        end

        if WeldIntent.active and WeldIntent.presetKey == key then
            stopWeld()
            StateManager:Cleanup(true)
            LastPresetKey = nil
            footerSub.Text = "stopped"
            syncAllActiveIndicators()
            sToggleOff()
            notify("COCO POWDER", (WELD_PRESETS[key] and WELD_PRESETS[key].label or key) .. " stopped")
            return
        end

        local targetPlr, usedNearest = resolveActiveTarget()
        if not targetPlr or targetPlr.Parent ~= Players then
            notify("COCO POWDER", "No target player found in server!")
            sError()
            syncAllActiveIndicators()
            return
        end

        StateManager:Cleanup(true)
        CurrentTarget = targetPlr
        LastWeldTargetUserId = targetPlr.UserId
        hookTargetRespawn(targetPlr)
        local ok = applyWeldPreset(key, targetPlr)
        if ok then
            footerLabel.Text = (usedNearest and "Nearest: " or "Target: ") .. targetPlr.Name
            footerSub.Text = "active · " .. (WELD_PRESETS[key].label or key)
            syncAllActiveIndicators()
            sSuccess()
            local prefix = usedNearest and "Auto-Nearest (" .. (WELD_PRESETS[key].label or key) .. ") -> " or ((WELD_PRESETS[key].label or key) .. " -> ")
            notify("COCO POWDER", prefix .. targetPlr.Name)
        else
            syncAllActiveIndicators()
            sError()
            notify("COCO POWDER", "Failed — reference part missing")
        end
    end

    local function removeFloatingPill(key)
        local entry = ActivePills[key]
        if not entry then return end
        if entry.btn then pcall(function() entry.btn:Destroy() end) end
        ActivePills[key] = nil
        for i = #PillOrderList, 1, -1 do
            if PillOrderList[i] == key then table.remove(PillOrderList, i) end
        end
        layoutUnmovedPills()
        updatePinBadgeVisual(key)
    end

    local function addFloatingPill(key)
        if ActivePills[key] then return end
        local meta = PILL_META[key]
        if not meta then return end

        local pillW = meta.width or 100
        local pill = Instance.new("TextButton")
        pill.Name = "QuickPill_" .. key
        pill.Size = UDim2.new(0, pillW, 0, 32)
        pill.BackgroundColor3 = PILL_BG_OFF
        pill.BackgroundTransparency = 0.12
        pill.BorderSizePixel = 0
        pill.Text = ""
        pill.AutoButtonColor = false
        pill.Active = true
        pill.ZIndex = 995
        pill.Parent = gui
        Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

        local pStroke = Instance.new("UIStroke")
        pStroke.Color = PILL_STROKE_OFF
        pStroke.Thickness = 1.4
        pStroke.Transparency = 0.25
        pStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        pStroke.Parent = pill

        local dot = Instance.new("Frame")
        dot.Name = "StatusCircle"
        dot.Size = UDim2.new(0, 10, 0, 10)
        dot.Position = UDim2.new(0, 11, 0.5, -5)
        dot.BackgroundColor3 = PILL_DOT_OFF
        dot.BorderSizePixel = 0
        dot.ZIndex = 996
        dot.Parent = pill
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

        local dotStroke = Instance.new("UIStroke")
        dotStroke.Color = PILL_DOT_RING_OFF
        dotStroke.Thickness = 1.2
        dotStroke.Transparency = 0.2
        dotStroke.Parent = dot

        local lbl = Instance.new("TextLabel")
        lbl.Name = "PillTitle"
        lbl.Size = UDim2.new(1, -28, 1, 0)
        lbl.Position = UDim2.new(0, 26, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = meta.pillLabel
        lbl.TextColor3 = PILL_TXT_OFF
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 996
        lbl.Parent = pill

        local entry = {
            btn = pill,
            stroke = pStroke,
            dot = dot,
            dotStroke = dotStroke,
            label = lbl,
            width = pillW,
            customMoved = false,
        }
        ActivePills[key] = entry
        table.insert(PillOrderList, key)
        layoutUnmovedPills()

        local pDrag, pStart, pPos, pMoved = false, nil, nil, false
        local lastPillActivate = 0
        local function onPillActivate()
            if tick() - lastPillActivate < 0.18 then return end
            lastPillActivate = tick()
            sClick()
            togglePresetOrAction(key)
        end

        pill.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                pDrag = true; pStart = inp.Position; pPos = pill.Position; pMoved = false
            elseif inp.UserInputType == Enum.UserInputType.MouseButton2 then
                sClick()
                removeFloatingPill(key)
            end
        end)
        UIS.InputChanged:Connect(function(inp)
            if pDrag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                local delta = inp.Position - pStart
                if math.abs(delta.X) > 8 or math.abs(delta.Y) > 8 then
                    pMoved = true
                    entry.customMoved = true
                end
                if pMoved then
                    pill.Position = UDim2.new(pPos.X.Scale, pPos.X.Offset + delta.X, pPos.Y.Scale, pPos.Y.Offset + delta.Y)
                end
            end
        end)
        UIS.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                if pDrag and not pMoved then onPillActivate() end
                pDrag = false
            end
        end)
        pill.MouseButton1Click:Connect(function()
            if not pMoved then onPillActivate() end
        end)

        updatePinBadgeVisual(key)
        syncAllActiveIndicators()
    end

    local function toggleFloatingPill(key)
        if ActivePills[key] then
            removeFloatingPill(key)
        else
            addFloatingPill(key)
        end
    end

    -- 2-Column sleek preset row builder with dedicated right-hand Pin button (never overlaps text!)
    local function presetPairRow(order, entries)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 34)
        row.BackgroundTransparency = 1
        row.LayoutOrder = order
        row.ZIndex = 7
        row.Parent = weldTab
        local count = #entries
        for i, cfg in ipairs(entries) do
            local bw = 1 / count
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(bw, -4, 1, 0)
            b.Position = UDim2.new((i - 1) * bw, (i == 1) and 0 or 4, 0, 0)
            b.Text = ""
            b.AutoButtonColor = false
            b.ZIndex = 8
            b.Parent = row
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
            styleBtn(b, T.Panel)

            local st = Instance.new("UIStroke")
            st.Color = T.Border
            st.Thickness = 1
            st.Transparency = 0.45
            st.Parent = b

            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0, 8, 0, 8)
            dot.Position = UDim2.new(0, 10, 0.5, -4)
            dot.BackgroundColor3 = PILL_DOT_OFF
            dot.BorderSizePixel = 0
            dot.ZIndex = 9
            dot.Parent = b
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

            local hasPin = cfg.key and PILL_META[cfg.key] ~= nil
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, hasPin and -54 or -24, 1, 0)
            lbl.Position = UDim2.new(0, 24, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = cfg.text
            lbl.TextColor3 = T.Text
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 11
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.TextTruncate = Enum.TextTruncate.AtEnd
            lbl.ZIndex = 9
            lbl.Parent = b

            if cfg.key then
                presetCards[cfg.key] = { btn = b, dot = dot, label = lbl, stroke = st }
                b.MouseButton1Click:Connect(function()
                    sClick()
                    if cfg.cb then cfg.cb() else togglePresetOrAction(cfg.key) end
                end)
                if hasPin then
                    local pinBtn = Instance.new("TextButton")
                    pinBtn.Size = UDim2.new(0, 22, 0, 22)
                    pinBtn.Position = UDim2.new(1, -27, 0.5, -11)
                    pinBtn.BackgroundColor3 = T.BG2
                    pinBtn.Text = "+"
                    pinBtn.TextColor3 = T.Muted
                    pinBtn.Font = Enum.Font.GothamBold
                    pinBtn.TextSize = 11
                    pinBtn.AutoButtonColor = false
                    pinBtn.ZIndex = 10
                    pinBtn.Parent = b
                    Instance.new("UICorner", pinBtn).CornerRadius = UDim.new(0, 6)
                    pinBadgeButtons[cfg.key] = pinBtn
                    pinBtn.MouseButton1Click:Connect(function()
                        sClick()
                        toggleFloatingPill(cfg.key)
                    end)
                end
            elseif cfg.cb then
                b.MouseButton1Click:Connect(function() sClick(); cfg.cb() end)
            end
        end
    end

    presetPairRow(3, {
        { text = "Facebang",  key = "facebang"  },
        { text = "Headsit",   key = "headsit"   },
    })
    presetPairRow(4, {
        { text = "Backshots", key = "backshots" },
        { text = "Pat",       key = "headpat"   },
    })
    presetPairRow(5, {
        { text = "Kiss",      key = "kiss"      },
        { text = "Backpack",  key = "backpack"  },
    })
    presetPairRow(6, {
        { text = "Propose",   key = "propose"   },
        { text = "Hug",       key = "hug"       },
    })
    presetPairRow(7, {
        { text = "Auto-Chase (Everywhere)", key = "chase" },
        { text = "Void Throw v2 ⚡", key = "voidthrow" },
    })
    presetPairRow(8, {
        { text = "Nebula Fling / Void Lock", key = "fling", cb = function() promptNebulaFling() end },
        { text = "⏪ Rewind (6-10s)", key = "rewind" },
    })
    presetPairRow(9, {
        { text = "Anti-Troll Deflect", key = "deflect" },
        { text = "Void Lock (Until Dead)", cb = function() launchNebulaFling(-1, "Void Lock Until Dead", true) end },
    })

    -- Advanced Live Weld & Target Utility Bar (Speed, Distance, TP, Spectate)
    sectionLbl(weldTab, 10, "ADVANCED WELD TUNER & QUICK TARGET ACTIONS", T.Accent)
    local tunerRow = Instance.new("Frame")
    tunerRow.Size = UDim2.new(1, 0, 0, 28)
    tunerRow.BackgroundTransparency = 1
    tunerRow.LayoutOrder = 11
    tunerRow.ZIndex = 7
    tunerRow.Parent = weldTab

    local speedCycle = { 0.5, 1.0, 1.8, 3.0, 4.5 }
    local speedIdx = 2
    local function makeTunerBtn(xScale, wScale, label, onClick)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(wScale, -4, 1, 0)
        b.Position = UDim2.new(xScale, 2, 0, 0)
        b.BackgroundColor3 = T.PanelLt
        b.Text = label
        b.TextColor3 = T.Text
        b.Font = Enum.Font.GothamBold
        b.TextSize = 9
        b.AutoButtonColor = false
        b.ZIndex = 8
        b.Parent = tunerRow
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        styleBtn(b, T.PanelLt)
        b.MouseButton1Click:Connect(function()
            sClick()
            onClick(b)
        end)
        return b
    end

    makeTunerBtn(0.00, 0.26, "SPEED: 1.0x", function(btn)
        speedIdx = (speedIdx % #speedCycle) + 1
        V.Speed = speedCycle[speedIdx]
        btn.Text = string.format("SPEED: %.1fx", V.Speed)
    end)
    makeTunerBtn(0.26, 0.18, "DIST -", function()
        V.Z = math.clamp((V.Z or 1.3) - 0.35, -3.0, 6.0)
    end)
    makeTunerBtn(0.44, 0.18, "DIST +", function()
        V.Z = math.clamp((V.Z or 1.3) + 0.35, -3.0, 6.0)
    end)
    makeTunerBtn(0.62, 0.19, "SEEK & TP", function()
        local tgt = resolveActiveTarget()
        if not tgt or tgt.Parent ~= Players then
            notify("COCO POWDER", "No target player in server!")
            sError()
            return
        end
        task.spawn(function()
            notify("COCO POWDER", "Seeking " .. tgt.Name .. " across server...")
            local _, tRef = streamAndTeleportToTarget(tgt, "torso", 2.4)
            if tRef and tRef.Parent then
                local destCF = tRef.CFrame * CFrame.new(0, 1.5, 2.5)
                markIntentionalTeleport(destCF)
                safeReturnFromVoid(LP.Character, destCF)
                notify("COCO POWDER", "Found & teleported to " .. tgt.Name .. "!")
                sSuccess()
            else
                local fallbackCF = getBestTargetCFrame(tgt)
                if fallbackCF then
                    markIntentionalTeleport(fallbackCF)
                    safeReturnFromVoid(LP.Character, fallbackCF * CFrame.new(0, 2, 0))
                    notify("COCO POWDER", "Teleported to " .. tgt.Name .. "'s hidden zone!")
                    sSuccess()
                else
                    notify("COCO POWDER", "Target is respawning — enable Auto-Chase to lock on!")
                    sError()
                end
            end
        end)
    end)
    makeTunerBtn(0.81, 0.19, "VIEW: OFF", function(btn)
        SpectatingTarget = not SpectatingTarget
        local currentCam = workspace.CurrentCamera
        if SpectatingTarget then
            local tgt = resolveActiveTarget()
            local tHum = tgt and tgt.Character and tgt.Character:FindFirstChildOfClass("Humanoid")
            if currentCam and tHum then
                currentCam.CameraSubject = tHum
                btn.Text = "VIEW: ON"
                BtnColors[btn] = PILL_BG_ON
                btn.BackgroundColor3 = PILL_BG_ON
                return
            end
            SpectatingTarget = false
        end
        if currentCam and LP.Character then
            local myHum = LP.Character:FindFirstChildOfClass("Humanoid")
            if myHum then currentCam.CameraSubject = myHum end
        end
        btn.Text = "VIEW: OFF"
        BtnColors[btn] = T.PanelLt
        btn.BackgroundColor3 = T.PanelLt
    end)

    -- Spawn the 3 default floating icons matching the reference screenshot (Pat, Headsit, Facebang)
    addFloatingPill("headpat")
    addFloatingPill("headsit")
    addFloatingPill("facebang")
    addFloatingPill("voidthrow")
    addFloatingPill("rewind")

    -- ═══════════════════════════════════════════════════════════════════════════
    -- TAB 2: TARGET (Clean Player Search + Auto-Nearest Toggle)
    -- ═══════════════════════════════════════════════════════════════════════════
    do
    local searchRow = Instance.new("Frame")
    searchRow.Size = UDim2.new(1, 0, 0, 32)
    searchRow.BackgroundTransparency = 1
    searchRow.LayoutOrder = 1
    searchRow.ZIndex = 7
    searchRow.Parent = targetTab

    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, -92, 1, 0)
    searchBox.BackgroundColor3 = T.Panel
    searchBox.PlaceholderText = "Search player..."
    searchBox.Text = ""
    searchBox.TextColor3 = T.Text
    searchBox.PlaceholderColor3 = T.Muted
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 11
    searchBox.ClearTextOnFocus = false
    searchBox.ZIndex = 8
    searchBox.Parent = searchRow
    Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 7)
    local searchPad = Instance.new("UIPadding")
    searchPad.PaddingLeft = UDim.new(0, 10)
    searchPad.PaddingRight = UDim.new(0, 10)
    searchPad.Parent = searchBox

    local clearTgtBtn = Instance.new("TextButton")
    clearTgtBtn.Size = UDim2.new(0, 86, 1, 0)
    clearTgtBtn.Position = UDim2.new(1, -86, 0, 0)
    clearTgtBtn.Text = "AUTO-NEAR"
    clearTgtBtn.TextColor3 = Color3.new(1, 1, 1)
    clearTgtBtn.Font = Enum.Font.GothamBold
    clearTgtBtn.TextSize = 10
    clearTgtBtn.ZIndex = 8
    clearTgtBtn.Parent = searchRow
    Instance.new("UICorner", clearTgtBtn).CornerRadius = UDim.new(0, 7)
    styleBtn(clearTgtBtn, T.Accent2)

    local listFrame = Instance.new("Frame")
    listFrame.Size = UDim2.new(1, 0, 0, 195)
    listFrame.BackgroundColor3 = T.Panel
    listFrame.BorderSizePixel = 0
    listFrame.LayoutOrder = 2
    listFrame.ClipsDescendants = true
    listFrame.ZIndex = 7
    listFrame.Parent = targetTab
    Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0, 8)

    local listScroll = Instance.new("ScrollingFrame")
    listScroll.Size = UDim2.new(1, -8, 1, -8)
    listScroll.Position = UDim2.new(0, 4, 0, 4)
    listScroll.BackgroundTransparency = 1
    listScroll.BorderSizePixel = 0
    listScroll.ScrollBarThickness = 2
    listScroll.ScrollBarImageColor3 = T.Accent
    listScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    listScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    listScroll.ZIndex = 8
    listScroll.Parent = listFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 4)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = listScroll

    local function findPlayers(q)
        q = (q or ""):lower()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP then
                if q == "" or p.Name:lower():sub(1, #q) == q or p.DisplayName:lower():sub(1, #q) == q then
                    table.insert(list, p)
                end
            end
        end
        return list
    end

    refreshList = function()
        for _, c in ipairs(listScroll:GetChildren()) do
            if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end
        end
        local plrs = findPlayers(searchBox.Text)
        if #plrs == 0 then
            local e = Instance.new("TextLabel")
            e.Size = UDim2.new(1, 0, 0, 32)
            e.BackgroundTransparency = 1
            e.Text = "No matching players — Auto-Nearest will be used"
            e.TextColor3 = T.Muted
            e.Font = Enum.Font.Gotham
            e.TextSize = 10
            e.ZIndex = 9
            e.Parent = listScroll
            return
        end
        for i, p in ipairs(plrs) do
            local isSel = (selectedPlayer == p)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -4, 0, 34)
            btn.BackgroundColor3 = isSel and PILL_BG_ON or T.PanelLt
            btn.Text = ""
            btn.AutoButtonColor = false
            btn.LayoutOrder = i
            btn.ZIndex = 9
            btn.Parent = listScroll
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            styleBtn(btn, isSel and PILL_BG_ON or T.PanelLt)

            local av = Instance.new("ImageLabel")
            av.Size = UDim2.new(0, 24, 0, 24)
            av.Position = UDim2.new(0, 6, 0.5, -12)
            av.BackgroundColor3 = T.BG2
            av.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p.UserId .. "&w=48&h=48"
            av.ZIndex = 10
            av.Parent = btn
            Instance.new("UICorner", av).CornerRadius = UDim.new(1, 0)

            local distStr = ""
            pcall(function()
                local myR = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                local tCF = getBestTargetCFrame(p)
                if myR and tCF then
                    distStr = string.format(" · %ds", math.floor((tCF.Position - myR.Position).Magnitude))
                else
                    distStr = " · hidden"
                end
            end)

            local nm = Instance.new("TextLabel")
            nm.Size = UDim2.new(1, -124, 1, 0)
            nm.Position = UDim2.new(0, 36, 0, 0)
            nm.BackgroundTransparency = 1
            nm.Text = p.DisplayName .. " (@" .. p.Name .. ")" .. distStr
            nm.TextColor3 = T.Text
            nm.Font = Enum.Font.GothamMedium
            nm.TextSize = 10
            nm.TextXAlignment = Enum.TextXAlignment.Left
            nm.TextTruncate = Enum.TextTruncate.AtEnd
            nm.ZIndex = 10
            nm.Parent = btn

            local tpQuick = Instance.new("TextButton")
            tpQuick.Size = UDim2.new(0, 34, 0, 22)
            tpQuick.Position = UDim2.new(1, -80, 0.5, -11)
            tpQuick.BackgroundColor3 = T.BG2
            tpQuick.Text = "TP"
            tpQuick.TextColor3 = T.Neon
            tpQuick.Font = Enum.Font.GothamBold
            tpQuick.TextSize = 9
            tpQuick.AutoButtonColor = false
            tpQuick.ZIndex = 11
            tpQuick.Parent = btn
            Instance.new("UICorner", tpQuick).CornerRadius = UDim.new(0, 5)
            tpQuick.MouseButton1Click:Connect(function()
                sClick()
                selectedPlayer = p
                syncChatTarget(p)
                task.spawn(function()
                    local _, tRef = streamAndTeleportToTarget(p, "torso", 2.4)
                    if tRef and tRef.Parent then
                        local destCF = tRef.CFrame * CFrame.new(0, 1.5, 2.5)
                        markIntentionalTeleport(destCF)
                        safeReturnFromVoid(LP.Character, destCF)
                        notify("COCO POWDER", "Found & teleported to " .. p.Name .. "!")
                        sSuccess()
                    else
                        local fallbackCF = getBestTargetCFrame(p)
                        if fallbackCF then
                            markIntentionalTeleport(fallbackCF)
                            safeReturnFromVoid(LP.Character, fallbackCF * CFrame.new(0, 2, 0))
                            notify("COCO POWDER", "Teleported to " .. p.Name .. "'s hidden location!")
                            sSuccess()
                        else
                            notify("COCO POWDER", "Seeking " .. p.Name .. " — turned on Auto-Chase!")
                            applyWeldPreset("chase", p)
                            syncAllActiveIndicators()
                        end
                    end
                end)
            end)

            local voidQuick = Instance.new("TextButton")
            voidQuick.Size = UDim2.new(0, 40, 0, 22)
            voidQuick.Position = UDim2.new(1, -43, 0.5, -11)
            voidQuick.BackgroundColor3 = T.Accent2
            voidQuick.Text = "VOID"
            voidQuick.TextColor3 = Color3.new(1, 1, 1)
            voidQuick.Font = Enum.Font.GothamBold
            voidQuick.TextSize = 9
            voidQuick.AutoButtonColor = false
            voidQuick.ZIndex = 11
            voidQuick.Parent = btn
            Instance.new("UICorner", voidQuick).CornerRadius = UDim.new(0, 5)
            voidQuick.MouseButton1Click:Connect(function()
                sClick()
                selectedPlayer = p
                syncChatTarget(p)
                launchVoidThrow(p)
            end)

            btn.MouseButton1Click:Connect(function()
                if selectedPlayer == p then
                    selectedPlayer = nil
                    footerLabel.Text = "Auto: Nearest Player"
                    footerSub.Text = "auto-connects to nearest player"
                    syncChatTarget(nil)
                else
                    selectedPlayer = p
                    footerLabel.Text = "Target: " .. p.Name
                    footerSub.Text = "locked (tap again for auto-nearest)"
                    syncChatTarget(p)
                end
                sClick()
                refreshList()
                pcall(refreshCard)
            end)
        end
    end

    clearTgtBtn.MouseButton1Click:Connect(function()
        sClick()
        selectedPlayer = nil
        searchBox.Text = ""
        syncChatTarget(nil)
        footerLabel.Text = "Auto: Nearest Player"
        footerSub.Text = "auto-connects to nearest player"
        pcall(refreshList)
        pcall(refreshCard)
    end)

    searchBox:GetPropertyChangedSignal("Text"):Connect(function() pcall(refreshList) end)
    pcall(refreshList)

    Players.PlayerAdded:Connect(function(p)
        task.wait(0.5)
        pcall(refreshList)
        if AutoReweldEnabled and LastWeldTargetUserId and p.UserId == LastWeldTargetUserId then
            task.wait(1.5)
            if not p.Character then return end
            selectedPlayer = p
            footerLabel.Text = "Target: " .. p.Name
            footerSub.Text = "rejoined — auto re-welding"
            syncChatTarget(p)
            if LastPresetKey and WELD_PRESETS[LastPresetKey] then
                applyWeldPreset(LastPresetKey, p)
                syncAllActiveIndicators()
            end
            hookTargetRespawn(p)
        end
    end)

    Players.PlayerRemoving:Connect(function(p)
        if WeldIntent.target == p or CurrentTarget == p or selectedPlayer == p then
            stopWeld()
            StateManager:Cleanup(false)
            if selectedPlayer == p then
                selectedPlayer = nil
                syncChatTarget(nil)
            end
            footerLabel.Text = "Auto: Nearest Player"
            footerSub.Text = "target left — stopped & reset"
            pcall(syncAllActiveIndicators)
        end
        task.wait(0.1)
        pcall(refreshList)
        pcall(refreshCard)
    end)

    -- ═══════════════════════════════════════════════════════════════════════════
    end -- end Target Tab scope
    -- ═══════════════════════════════════════════════════════════════════════════
    -- TAB 3: CHAT
    -- ═══════════════════════════════════════════════════════════════════════════
    local chatStopFn
    do
    sectionLbl(chatTab, 1, "CHAT SPAMMER (AUTO-NEAREST WHEN BLANK)", T.Muted)

    chatTargetInput = Instance.new("TextBox")
    chatTargetInput.Size = UDim2.new(1, 0, 0, 32)
    chatTargetInput.BackgroundColor3 = T.Panel
    chatTargetInput.PlaceholderText = "Target name (leave blank for nearest player)"
    chatTargetInput.Text = ""
    chatTargetInput.TextColor3 = T.Text
    chatTargetInput.PlaceholderColor3 = T.Muted
    chatTargetInput.Font = Enum.Font.Gotham
    chatTargetInput.TextSize = 11
    chatTargetInput.LayoutOrder = 2
    chatTargetInput.ClearTextOnFocus = false
    chatTargetInput.ZIndex = 7
    chatTargetInput.Parent = chatTab
    Instance.new("UICorner", chatTargetInput).CornerRadius = UDim.new(0, 7)
    local ctiPad = Instance.new("UIPadding")
    ctiPad.PaddingLeft = UDim.new(0, 10)
    ctiPad.PaddingRight = UDim.new(0, 10)
    ctiPad.Parent = chatTargetInput
    syncChatTarget(selectedPlayer)

    local modeRow = Instance.new("Frame")
    modeRow.Size = UDim2.new(1, 0, 0, 30)
    modeRow.BackgroundTransparency = 1
    modeRow.LayoutOrder = 3
    modeRow.ZIndex = 7
    modeRow.Parent = chatTab

    local roastBtn = Instance.new("TextButton")
    roastBtn.Size = UDim2.new(0.5, -3, 1, 0)
    roastBtn.Text = "ROAST"
    roastBtn.TextColor3 = T.Text
    roastBtn.Font = Enum.Font.GothamBold
    roastBtn.TextSize = 10
    roastBtn.ZIndex = 8
    roastBtn.Parent = modeRow
    Instance.new("UICorner", roastBtn).CornerRadius = UDim.new(0, 6)
    styleBtn(roastBtn, T.Accent2)

    local messageBtn = Instance.new("TextButton")
    messageBtn.Size = UDim2.new(0.5, -3, 1, 0)
    messageBtn.Position = UDim2.new(0.5, 3, 0, 0)
    messageBtn.Text = "MESSAGE"
    messageBtn.TextColor3 = T.Text
    messageBtn.Font = Enum.Font.GothamBold
    messageBtn.TextSize = 10
    messageBtn.ZIndex = 8
    messageBtn.Parent = modeRow
    Instance.new("UICorner", messageBtn).CornerRadius = UDim.new(0, 6)
    styleBtn(messageBtn, T.PanelLt)

    local chatMsgInput = Instance.new("TextBox")
    chatMsgInput.Size = UDim2.new(1, 0, 0, 32)
    chatMsgInput.BackgroundColor3 = T.Panel
    chatMsgInput.PlaceholderText = "Custom message to spam..."
    chatMsgInput.Text = ""
    chatMsgInput.TextColor3 = T.Text
    chatMsgInput.PlaceholderColor3 = T.Muted
    chatMsgInput.Font = Enum.Font.Gotham
    chatMsgInput.TextSize = 11
    chatMsgInput.LayoutOrder = 4
    chatMsgInput.ClearTextOnFocus = false
    chatMsgInput.Visible = false
    chatMsgInput.ZIndex = 7
    chatMsgInput.Parent = chatTab
    Instance.new("UICorner", chatMsgInput).CornerRadius = UDim.new(0, 7)
    local cmiPad = Instance.new("UIPadding")
    cmiPad.PaddingLeft = UDim.new(0, 10)
    cmiPad.PaddingRight = UDim.new(0, 10)
    cmiPad.Parent = chatMsgInput

    local function setChatMode(m)
        csMode = m
        BtnColors[roastBtn] = (m == "roast") and T.Accent2 or T.PanelLt
        BtnColors[messageBtn] = (m == "message") and T.Accent2 or T.PanelLt
        roastBtn.BackgroundColor3 = BtnColors[roastBtn]
        messageBtn.BackgroundColor3 = BtnColors[messageBtn]
        chatMsgInput.Visible = (m == "message")
    end
    roastBtn.MouseButton1Click:Connect(function() sClick(); setChatMode("roast") end)
    messageBtn.MouseButton1Click:Connect(function() sClick(); setChatMode("message") end)

    local chatStatusLbl = Instance.new("TextLabel")
    chatStatusLbl.Size = UDim2.new(1, 0, 0, 16)
    chatStatusLbl.BackgroundTransparency = 1
    chatStatusLbl.LayoutOrder = 5
    chatStatusLbl.Text = "status: idle"
    chatStatusLbl.TextColor3 = T.Muted
    chatStatusLbl.Font = Enum.Font.Gotham
    chatStatusLbl.TextSize = 10
    chatStatusLbl.TextXAlignment = Enum.TextXAlignment.Left
    chatStatusLbl.ZIndex = 7
    chatStatusLbl.Parent = chatTab

    local chatBtnRow = Instance.new("Frame")
    chatBtnRow.Size = UDim2.new(1, 0, 0, 32)
    chatBtnRow.BackgroundTransparency = 1
    chatBtnRow.LayoutOrder = 6
    chatBtnRow.ZIndex = 7
    chatBtnRow.Parent = chatTab

    local chatStartBtn = Instance.new("TextButton")
    chatStartBtn.Size = UDim2.new(0.5, -3, 1, 0)
    chatStartBtn.Text = "START"
    chatStartBtn.TextColor3 = Color3.new(1, 1, 1)
    chatStartBtn.Font = Enum.Font.GothamBold
    chatStartBtn.TextSize = 11
    chatStartBtn.ZIndex = 8
    chatStartBtn.Parent = chatBtnRow
    Instance.new("UICorner", chatStartBtn).CornerRadius = UDim.new(0, 6)
    styleBtn(chatStartBtn, PILL_BG_ON)

    local chatStopBtn = Instance.new("TextButton")
    chatStopBtn.Size = UDim2.new(0.5, -3, 1, 0)
    chatStopBtn.Position = UDim2.new(0.5, 3, 0, 0)
    chatStopBtn.Text = "STOP"
    chatStopBtn.TextColor3 = Color3.new(1, 1, 1)
    chatStopBtn.Font = Enum.Font.GothamBold
    chatStopBtn.TextSize = 11
    chatStopBtn.ZIndex = 8
    chatStopBtn.Parent = chatBtnRow
    Instance.new("UICorner", chatStopBtn).CornerRadius = UDim.new(0, 6)
    styleBtn(chatStopBtn, T.Danger)

    local function chatStartFn()
        if csOn then return end
        csTgt = (chatTargetInput.Text or ""):gsub("^%s*@+%s*", "")
        csMsg = chatMsgInput.Text
        if csMode == "roast" then
            local matched = (csTgt ~= "" and csTgt ~= nil) and findPlayerByNameOrDisplay(csTgt, LP) or nil
            if not matched then
                local fallbackPlr = resolveActiveTarget()
                if fallbackPlr then csTgt = fallbackPlr.Name end
            end
            if csTgt == "" or csTgt == nil then
                notify("COCO POWDER", "No target or nearby player found")
                sError()
                return
            end
            chatTargetInput.Text = csTgt
        end
        if csMode == "message" and csMsg == "" then
            notify("COCO POWDER", "Enter a message")
            sError()
            return
        end
        csOn = true
        csGen = csGen + 1
        csCnt = 0
        chatStatusLbl.Text = "running · " .. csMode
        chatStatusLbl.TextColor3 = T.Success
        local g = csGen
        task.spawn(function()
            while csOn and csGen == g do
                local m = bld()
                if m ~= "" then
                    if snd2(m) then
                        csCnt = csCnt + 1
                        chatStatusLbl.Text = "running · " .. csMtd .. " · " .. csCnt
                    else
                        chatStatusLbl.Text = "failed to send"
                        chatStatusLbl.TextColor3 = T.Danger
                    end
                end
                task.wait(CS_D)
            end
        end)
        sToggleOn()
        notify("COCO POWDER", "Chat spammer started")
    end

    chatStopFn = function()
        csOn = false
        csGen = csGen + 1
        chatStatusLbl.Text = "stopped · " .. csCnt .. " sent"
        chatStatusLbl.TextColor3 = T.Muted
        sToggleOff()
        notify("COCO POWDER", "Chat spammer stopped")
    end

    chatStartBtn.MouseButton1Click:Connect(function() sClick(); chatStartFn() end)
    chatStopBtn.MouseButton1Click:Connect(function() sClick(); chatStopFn() end)
    setChatMode("roast")
    end -- end Chat Tab scope

    -- ═══════════════════════════════════════════════════════════════════════════
    -- TAB 4: ANTI (ADVANCED DEFENCE TROLL MATRIX V2 + MULTI-LAYER SHIELD SUITE)
    -- ═══════════════════════════════════════════════════════════════════════════
    local antiToggleRegistry = {} -- list of { btn = TextButton, getState = fn }
    syncAllAntiButtons = function()
        for _, entry in ipairs(antiToggleRegistry) do
            if entry.btn and entry.btn.Parent then
                local st = entry.getState()
                BtnColors[entry.btn] = st and PILL_BG_ON or T.PanelLt
                entry.btn.BackgroundColor3 = BtnColors[entry.btn]
                entry.btn.Text = st and "ON" or "OFF"
            end
        end
        if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
    end

    -- One-Tap Master Shield Bar (Enable All / Disable All)
    local masterRow = Instance.new("Frame")
    masterRow.Size = UDim2.new(1, 0, 0, 30)
    masterRow.BackgroundTransparency = 1
    masterRow.LayoutOrder = 0
    masterRow.ZIndex = 7
    masterRow.Parent = antiTab

    local btnEnableAll = Instance.new("TextButton")
    btnEnableAll.Size = UDim2.new(0.64, -3, 1, 0)
    btnEnableAll.Text = "🛡️ ENABLE ALL ADVANCED ANTI"
    btnEnableAll.TextColor3 = Color3.new(1, 1, 1)
    btnEnableAll.Font = Enum.Font.GothamBold
    btnEnableAll.TextSize = 10
    btnEnableAll.ZIndex = 8
    btnEnableAll.Parent = masterRow
    Instance.new("UICorner", btnEnableAll).CornerRadius = UDim.new(0, 7)
    styleBtn(btnEnableAll, PILL_BG_ON)
    btnEnableAll.MouseButton1Click:Connect(function()
        sClick()
        enableAllAntiSystems()
    end)

    local btnDisableAll = Instance.new("TextButton")
    btnDisableAll.Size = UDim2.new(0.36, -3, 1, 0)
    btnDisableAll.Position = UDim2.new(0.64, 6, 0, 0)
    btnDisableAll.Text = "DISABLE ALL"
    btnDisableAll.TextColor3 = Color3.new(1, 1, 1)
    btnDisableAll.Font = Enum.Font.GothamBold
    btnDisableAll.TextSize = 10
    btnDisableAll.ZIndex = 8
    btnDisableAll.Parent = masterRow
    Instance.new("UICorner", btnDisableAll).CornerRadius = UDim.new(0, 7)
    styleBtn(btnDisableAll, T.Danger)
    btnDisableAll.MouseButton1Click:Connect(function()
        sClick()
        disableAllAntiSystems()
    end)

    sectionLbl(antiTab, 1, "DEFENCE TROLL MATRIX V2  (6 COUNTER-MODES + OMNI-RADAR)", T.Accent)

    -- Dedicated Defence Troll Matrix Control Card
    local defCard = Instance.new("Frame")
    defCard.Size = UDim2.new(1, 0, 0, 122)
    defCard.BackgroundColor3 = T.Panel
    defCard.BorderSizePixel = 0
    defCard.LayoutOrder = 2
    defCard.ZIndex = 7
    defCard.Parent = antiTab
    Instance.new("UICorner", defCard).CornerRadius = UDim.new(0, 8)
    local defStroke = Instance.new("UIStroke")
    defStroke.Color = T.Accent
    defStroke.Thickness = 1.2
    defStroke.Transparency = 0.35
    defStroke.Parent = defCard

    -- Master Toggle Row
    local defTop = Instance.new("Frame")
    defTop.Size = UDim2.new(1, 0, 0, 36)
    defTop.BackgroundTransparency = 1
    defTop.ZIndex = 8
    defTop.Parent = defCard

    local defTitle = Instance.new("TextLabel")
    defTitle.Size = UDim2.new(1, -94, 1, 0)
    defTitle.Position = UDim2.new(0, 12, 0, 0)
    defTitle.BackgroundTransparency = 1
    defTitle.Text = "DEFENCE TROLL MATRIX V2"
    defTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    defTitle.Font = Enum.Font.GothamBold
    defTitle.TextSize = 11
    defTitle.TextXAlignment = Enum.TextXAlignment.Left
    defTitle.ZIndex = 9
    defTitle.Parent = defTop

    local defToggleBtn = Instance.new("TextButton")
    defToggleBtn.Size = UDim2.new(0, 72, 0, 24)
    defToggleBtn.Position = UDim2.new(1, -82, 0.5, -12)
    defToggleBtn.Text = DefenceTroll.enabled and "ON" or "OFF"
    defToggleBtn.TextColor3 = Color3.new(1, 1, 1)
    defToggleBtn.Font = Enum.Font.GothamBold
    defToggleBtn.TextSize = 10
    defToggleBtn.ZIndex = 9
    defToggleBtn.Parent = defTop
    Instance.new("UICorner", defToggleBtn).CornerRadius = UDim.new(1, 0)
    styleBtn(defToggleBtn, DefenceTroll.enabled and PILL_BG_ON or T.PanelLt)

    -- Mode & Range Row
    local defRow2 = Instance.new("Frame")
    defRow2.Size = UDim2.new(1, -20, 0, 28)
    defRow2.Position = UDim2.new(0, 10, 0, 40)
    defRow2.BackgroundTransparency = 1
    defRow2.ZIndex = 8
    defRow2.Parent = defCard

    local modeBtn = Instance.new("TextButton")
    modeBtn.Size = UDim2.new(0.62, -4, 1, 0)
    modeBtn.BackgroundColor3 = T.PanelLt
    modeBtn.Text = "MODE: " .. (DefenceTroll.modeLabels[DefenceTroll.mode] or DefenceTroll.mode)
    modeBtn.TextColor3 = T.Neon
    modeBtn.Font = Enum.Font.GothamBold
    modeBtn.TextSize = 9
    modeBtn.ZIndex = 9
    modeBtn.Parent = defRow2
    Instance.new("UICorner", modeBtn).CornerRadius = UDim.new(0, 6)
    styleBtn(modeBtn, T.PanelLt)

    local rangeBtn = Instance.new("TextButton")
    rangeBtn.Size = UDim2.new(0.38, 0, 1, 0)
    rangeBtn.Position = UDim2.new(0.62, 2, 0, 0)
    rangeBtn.BackgroundColor3 = T.PanelLt
    rangeBtn.Text = "RADAR: " .. tostring(DefenceTroll.range) .. "s"
    rangeBtn.TextColor3 = T.Text
    rangeBtn.Font = Enum.Font.GothamBold
    rangeBtn.TextSize = 9
    rangeBtn.ZIndex = 9
    rangeBtn.Parent = defRow2
    Instance.new("UICorner", rangeBtn).CornerRadius = UDim.new(0, 6)
    styleBtn(rangeBtn, T.PanelLt)

    -- Live Telemetry Stats Row
    local defStatsLbl = Instance.new("TextLabel")
    defStatsLbl.Size = UDim2.new(1, -24, 0, 40)
    defStatsLbl.Position = UDim2.new(0, 12, 0, 74)
    defStatsLbl.BackgroundTransparency = 1
    defStatsLbl.Text = "⚡ COUNTERED: 0  ·  FLINGS BLOCKED: 0  ·  WELDS SEVERED: 0\nLAST THREAT: Standby (Pre-Physics Radar Ready)"
    defStatsLbl.TextColor3 = T.Muted
    defStatsLbl.Font = Enum.Font.GothamMedium
    defStatsLbl.TextSize = 8
    defStatsLbl.TextWrapped = true
    defStatsLbl.TextXAlignment = Enum.TextXAlignment.Left
    defStatsLbl.ZIndex = 9
    defStatsLbl.Parent = defCard

    updateDefenceStatsUI = function()
        pcall(function()
            if defStatsLbl and defStatsLbl.Parent then
                defStatsLbl.Text = string.format(
                    "⚡ COUNTERED: %d  ·  FLINGS: %d  ·  WELDS: %d  ·  BRINGS: %d\nLAST: %s (%s)",
                    DefenceTroll.deflectCount or 0,
                    Anti.FlingShield.blockedFlings or 0,
                    Anti.Attach.severedCount or 0,
                    Anti.Bring.blockedBrings or 0,
                    tostring(DefenceTroll.lastAttackerName or "None"),
                    tostring(DefenceTroll.lastThreatReason or "Standby")
                )
            end
            if defToggleBtn and defToggleBtn.Parent then
                defToggleBtn.Text = DefenceTroll.enabled and "ON" or "OFF"
                BtnColors[defToggleBtn] = DefenceTroll.enabled and PILL_BG_ON or T.PanelLt
                defToggleBtn.BackgroundColor3 = BtnColors[defToggleBtn]
            end
        end)
    end

    defToggleBtn.MouseButton1Click:Connect(function()
        sClick()
        if DefenceTroll.enabled then
            defenceTrollStop()
        else
            defenceTrollStart()
        end
        updateDefenceStatsUI()
    end)

    modeBtn.MouseButton1Click:Connect(function()
        sClick()
        local idx = 1
        for i, m in ipairs(DefenceTroll.modes) do
            if m == DefenceTroll.mode then idx = i; break end
        end
        idx = (idx % #DefenceTroll.modes) + 1
        DefenceTroll.mode = DefenceTroll.modes[idx]
        modeBtn.Text = "MODE: " .. (DefenceTroll.modeLabels[DefenceTroll.mode] or DefenceTroll.mode)
        notify("COCO POWDER", "Defence Mode set: " .. (DefenceTroll.modeLabels[DefenceTroll.mode] or DefenceTroll.mode))
        updateDefenceStatsUI()
    end)

    rangeBtn.MouseButton1Click:Connect(function()
        sClick()
        DefenceTroll.rangeIdx = (DefenceTroll.rangeIdx % #DefenceTroll.ranges) + 1
        DefenceTroll.range = DefenceTroll.ranges[DefenceTroll.rangeIdx]
        rangeBtn.Text = "RADAR: " .. tostring(DefenceTroll.range) .. "s"
        notify("COCO POWDER", "Deflect Radar Range: " .. tostring(DefenceTroll.range) .. " studs")
    end)

    sectionLbl(antiTab, 3, "ADVANCED CHARACTER & PHYSICS SHIELDS (V2)", T.Muted)

    local function makeAntiToggle(order, label, getState, onEnable, onDisable)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 34)
        row.BackgroundColor3 = T.Panel
        row.BorderSizePixel = 0
        row.LayoutOrder = order
        row.ZIndex = 7
        row.Parent = antiTab
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -94, 1, 0)
        lbl.Position = UDim2.new(0, 12, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = label
        lbl.TextColor3 = T.Text
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextSize = 10
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 8
        lbl.Parent = row

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 72, 0, 24)
        btn.Position = UDim2.new(1, -80, 0.5, -12)
        btn.Text = getState() and "ON" or "OFF"
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 10
        btn.ZIndex = 8
        btn.Parent = row
        Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
        styleBtn(btn, getState() and PILL_BG_ON or T.PanelLt)

        table.insert(antiToggleRegistry, { btn = btn, getState = getState })

        btn.MouseButton1Click:Connect(function()
            sClick()
            if getState() then
                onDisable()
            else
                onEnable()
            end
            syncAllAntiButtons()
        end)
        return btn
    end

    makeAntiToggle(4, "Anti-Fling v2 (Pre/Post-Physics Zero-Impulse)", function() return Anti.FlingShield.enabled end, flingShieldStart, flingShieldStop)
    makeAntiToggle(5, "Anti-Void v2 (Velocity Catch + Safety Floor)", function() return Anti.Void.enabled end, avStart, avStop)
    makeAntiToggle(6, "Anti-Kill v2 (God-Touch + Explosion Immunity)", function() return Anti.Kill.enabled end, akStart, akStop)
    makeAntiToggle(7, "Anti-Ragdoll / Anti-Sit / Anti-Stun / Motor6D", function() return Anti.Ragdoll.enabled end, ragdollStart, ragdollStop)
    makeAntiToggle(8, "Anti-Anchor / Anti-Freeze / Purge BodyMovers", function() return Anti.Anchor.enabled end, anchorStart, anchorStop)
    makeAntiToggle(9, "Anti-Attach / Omni-Weld & Grab Sever", function() return Anti.Attach.enabled end, attachStart, attachStop)
    makeAntiToggle(10, "Anti-Bring / Tool-Grab & Teleport Guard", function() return Anti.Bring.enabled end, bringStart, bringStop)
    makeAntiToggle(11, "Anti-Blind / Anti-Flashbang & Fog Clear", function() return Anti.Blind.enabled end, blindStart, blindStop)

    sectionLbl(antiTab, 12, "COUNTER-TRAPS & CLIENT BYPASSES", T.Muted)
    makeAntiToggle(13, "Void-Pause Attacker (Banish Welded Trolls)", function() return Anti.PauseTrap.enabled end, pauseTrapStart, pauseTrapStop)
    makeAntiToggle(14, "Redirect Attacker -> Nearest Bystander", function() return Anti.Redirect.enabled end, redirectStart, redirectStop)
    makeAntiToggle(15, "Anti-GameplayPaused / Anti-NetworkPause", function() return Anti.GamePaused.enabled end, agpStart, agpStop)
    makeAntiToggle(16, "Anti-AFK v2 (Idled + VirtualUser Pulse)", function() return Anti.AFK.enabled end, afkStart, afkStop)
    makeAntiToggle(17, "Anti-VC Ban (Native Voice Rejoin + Bypass)", function() return Anti.VC.enabled end, vcStart, vcStop)

    -- ═══════════════════════════════════════════════════════════════════════════
    -- TAB 5: MOVE (SPEED UP TO 500 & UNIVERSAL ANDROID / PC FLIGHT)
    -- ═══════════════════════════════════════════════════════════════════════════
    do -- Scoped block for Move Tab to keep buildMainUI local registers lean
    sectionLbl(moveTab, -4, "CHRONO-REWIND SYSTEM  (6s – 10s EXACT PRECISION)", T.Neon)

    local rewindMainBtn = Instance.new("TextButton")
    rewindMainBtn.Size = UDim2.new(1, 0, 0, 34)
    rewindMainBtn.BackgroundColor3 = T.Accent2
    rewindMainBtn.BorderSizePixel = 0
    rewindMainBtn.Text = "⏪ REWIND TIME NOW  (" .. tostring(RewindSys.duration) .. "s PRECISION)  [KEY: R]"
    rewindMainBtn.TextColor3 = Color3.new(1, 1, 1)
    rewindMainBtn.Font = Enum.Font.GothamBold
    rewindMainBtn.TextSize = 10
    rewindMainBtn.LayoutOrder = -3
    rewindMainBtn.ZIndex = 7
    rewindMainBtn.Parent = moveTab
    Instance.new("UICorner", rewindMainBtn).CornerRadius = UDim.new(0, 7)
    styleBtn(rewindMainBtn, T.Accent2)
    rewindMainBtn.MouseButton1Click:Connect(function()
        sClick()
        RewindSys:Start(RewindSys.duration)
    end)

    local rewindDurRow = Instance.new("Frame")
    rewindDurRow.Size = UDim2.new(1, 0, 0, 28)
    rewindDurRow.BackgroundTransparency = 1
    rewindDurRow.LayoutOrder = -2
    rewindDurRow.ZIndex = 7
    rewindDurRow.Parent = moveTab

    local durOptions = {
        { label = "6 SEC", val = 6.0 },
        { label = "8 SEC", val = 8.0 },
        { label = "10 SEC (MAX)", val = 10.0 },
    }
    local durBtns = {}
    local function refreshRewindDurUI()
        for _, item in ipairs(durBtns) do
            local active = math.abs(RewindSys.duration - item.val) < 0.1
            BtnColors[item.btn] = active and PILL_BG_ON or T.PanelLt
            item.btn.BackgroundColor3 = BtnColors[item.btn]
            item.btn.TextColor3 = active and Color3.new(1, 1, 1) or T.Text
        end
        rewindMainBtn.Text = "⏪ REWIND TIME NOW  (" .. tostring(RewindSys.duration) .. "s PRECISION)  [KEY: R]"
    end

    for i, opt in ipairs(durOptions) do
        local db = Instance.new("TextButton")
        db.Size = UDim2.new(1 / 3, -3, 1, 0)
        db.Position = UDim2.new((i - 1) / 3, (i == 1) and 0 or 3, 0, 0)
        db.Text = opt.label
        db.Font = Enum.Font.GothamBold
        db.TextSize = 9
        db.ZIndex = 8
        db.Parent = rewindDurRow
        Instance.new("UICorner", db).CornerRadius = UDim.new(0, 6)
        styleBtn(db, T.PanelLt)
        table.insert(durBtns, { btn = db, val = opt.val })
        db.MouseButton1Click:Connect(function()
            sClick()
            RewindSys.duration = opt.val
            refreshRewindDurUI()
            notify("COCO POWDER", "Rewind window set to " .. tostring(opt.val) .. " seconds (60Hz exact)")
        end)
    end
    refreshRewindDurUI()

    local rewindOptRow = Instance.new("Frame")
    rewindOptRow.Size = UDim2.new(1, 0, 0, 26)
    rewindOptRow.BackgroundTransparency = 1
    rewindOptRow.LayoutOrder = -1
    rewindOptRow.ZIndex = 7
    rewindOptRow.Parent = moveTab

    local modeToggleBtn = Instance.new("TextButton")
    modeToggleBtn.Size = UDim2.new(0.55, -2, 1, 0)
    modeToggleBtn.Text = "MODE: SMOOTH REVERSE REPLAY"
    modeToggleBtn.TextColor3 = T.Neon
    modeToggleBtn.Font = Enum.Font.GothamBold
    modeToggleBtn.TextSize = 8
    modeToggleBtn.ZIndex = 8
    modeToggleBtn.Parent = rewindOptRow
    Instance.new("UICorner", modeToggleBtn).CornerRadius = UDim.new(0, 6)
    styleBtn(modeToggleBtn, T.Panel)
    modeToggleBtn.MouseButton1Click:Connect(function()
        sClick()
        RewindSys.instantMode = not RewindSys.instantMode
        modeToggleBtn.Text = RewindSys.instantMode and "MODE: INSTANT SNAPBACK" or "MODE: SMOOTH REVERSE REPLAY"
    end)

    local camRewindBtn = Instance.new("TextButton")
    camRewindBtn.Size = UDim2.new(0.45, -2, 1, 0)
    camRewindBtn.Position = UDim2.new(0.55, 4, 0, 0)
    camRewindBtn.Text = "CAM REWIND: ON"
    camRewindBtn.TextColor3 = Color3.new(1, 1, 1)
    camRewindBtn.Font = Enum.Font.GothamBold
    camRewindBtn.TextSize = 8
    camRewindBtn.ZIndex = 8
    camRewindBtn.Parent = rewindOptRow
    Instance.new("UICorner", camRewindBtn).CornerRadius = UDim.new(0, 6)
    styleBtn(camRewindBtn, PILL_BG_ON)
    camRewindBtn.MouseButton1Click:Connect(function()
        sClick()
        RewindSys.rewindCamera = not RewindSys.rewindCamera
        camRewindBtn.Text = RewindSys.rewindCamera and "CAM REWIND: ON" or "CAM REWIND: OFF"
        BtnColors[camRewindBtn] = RewindSys.rewindCamera and PILL_BG_ON or T.Panel
        camRewindBtn.BackgroundColor3 = BtnColors[camRewindBtn]
    end)

    sectionLbl(moveTab, 1, "WALK SPEED  (UP TO 500)", T.Accent)
    local defaultWalkSpeed, defaultJumpPower = 16, 50
    local currentSpeed, currentJump = 32, 75
    local MIN_SPEED, MAX_SPEED = 16, 500
    local MAX_JUMP, JUMP_STEP = 350, 25

    local function getMoveCharacter()
        local ch = LP.Character
        if not ch then return nil, nil, nil end
        return ch, ch:FindFirstChildOfClass("Humanoid"), ch:FindFirstChild("HumanoidRootPart")
    end

    local function makeMoveButton(parent, order, text, callback, color)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, 0, 0, 32)
        b.BackgroundColor3 = color or T.Panel
        b.BorderSizePixel = 0
        b.Text = text
        b.TextColor3 = T.Text
        b.Font = Enum.Font.GothamBold
        b.TextSize = 10
        b.LayoutOrder = order
        b.ZIndex = 7
        b.Parent = parent
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
        styleBtn(b, color or T.Panel)
        b.MouseButton1Click:Connect(callback)
        return b
    end

    local speedStatus
    speedStatus = makeMoveButton(moveTab, 2, "WALK SPEED  ·  OFF  (32)", function()
        local _, hum = getMoveCharacter()
        if not hum then notify("Movement", "Character not ready."); return end
        moveState.speed = not moveState.speed
        hum.WalkSpeed = moveState.speed and currentSpeed or defaultWalkSpeed
        speedStatus.Text = "WALK SPEED  ·  " .. (moveState.speed and "ON" or "OFF") .. "  (" .. tostring(currentSpeed) .. ")"
        BtnColors[speedStatus] = moveState.speed and PILL_BG_ON or T.Panel
        speedStatus.BackgroundColor3 = BtnColors[speedStatus]

        -- Active loop to prevent game scripts from resetting WalkSpeed
        if moveState.speed then
            if moveState.speedLoopConn then moveState.speedLoopConn:Disconnect() end
            moveState.speedLoopConn = RunService.Heartbeat:Connect(function()
                if not moveState.speed then return end
                local _, h = getMoveCharacter()
                if h and h.WalkSpeed ~= currentSpeed then
                    h.WalkSpeed = currentSpeed
                end
            end)
        else
            if moveState.speedLoopConn then
                moveState.speedLoopConn:Disconnect()
                moveState.speedLoopConn = nil
            end
        end
    end)

    local function applySpeedValue(val)
        currentSpeed = math.clamp(math.floor(val), MIN_SPEED, MAX_SPEED)
        local _, hum = getMoveCharacter()
        if hum and moveState.speed then hum.WalkSpeed = currentSpeed end
        if speedStatus then
            speedStatus.Text = "WALK SPEED  ·  " .. (moveState.speed and "ON" or "OFF") .. "  (" .. tostring(currentSpeed) .. ")"
        end
    end

    -- Fine Stepper Row (-50, -10, +10, +50)
    local speedAdjustRow = Instance.new("Frame")
    speedAdjustRow.Size = UDim2.new(1, 0, 0, 28)
    speedAdjustRow.BackgroundTransparency = 1
    speedAdjustRow.LayoutOrder = 3
    speedAdjustRow.ZIndex = 7
    speedAdjustRow.Parent = moveTab

    local function makeStepBtn(parent, xPos, width, txt, step)
        local b = Instance.new("TextButton")
        b.Size = width
        b.Position = xPos
        b.Text = txt
        b.TextColor3 = T.Text
        b.Font = Enum.Font.GothamBold
        b.TextSize = 9
        b.ZIndex = 8
        b.Parent = parent
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        styleBtn(b, T.PanelLt)
        b.MouseButton1Click:Connect(function() applySpeedValue(currentSpeed + step) end)
        return b
    end

    makeStepBtn(speedAdjustRow, UDim2.new(0, 0, 0, 0), UDim2.new(0.24, -2, 1, 0), "-50", -50)
    makeStepBtn(speedAdjustRow, UDim2.new(0.25, 0, 0, 0), UDim2.new(0.24, -2, 1, 0), "-10", -10)
    makeStepBtn(speedAdjustRow, UDim2.new(0.50, 2, 0, 0), UDim2.new(0.24, -2, 1, 0), "+10", 10)
    makeStepBtn(speedAdjustRow, UDim2.new(0.75, 2, 0, 0), UDim2.new(0.25, -2, 1, 0), "+50", 50)

    -- Rapid Presets Row (16, 60, 120, 250, 500 MAX)
    local presetRow = Instance.new("Frame")
    presetRow.Size = UDim2.new(1, 0, 0, 26)
    presetRow.BackgroundTransparency = 1
    presetRow.LayoutOrder = 4
    presetRow.ZIndex = 7
    presetRow.Parent = moveTab

    local presets = { {t="16", v=16}, {t="60", v=60}, {t="120", v=120}, {t="250", v=250}, {t="500 MAX", v=500} }
    local pw = 1 / #presets
    for i, p in ipairs(presets) do
        local pb = Instance.new("TextButton")
        pb.Size = UDim2.new(pw, -3, 1, 0)
        pb.Position = UDim2.new((i - 1) * pw, 2, 0, 0)
        pb.Text = p.t
        pb.TextColor3 = p.v == 500 and T.Neon or T.Muted
        pb.Font = Enum.Font.GothamBold
        pb.TextSize = 8
        pb.ZIndex = 8
        pb.Parent = presetRow
        Instance.new("UICorner", pb).CornerRadius = UDim.new(0, 5)
        styleBtn(pb, p.v == 500 and T.Accent2 or T.Panel)
        pb.MouseButton1Click:Connect(function()
            applySpeedValue(p.v)
            notify("Speed", "WalkSpeed set to " .. tostring(p.v))
        end)
    end

    -- Direct Numeric Input Box (16 to 500)
    local inputRow = Instance.new("Frame")
    inputRow.Size = UDim2.new(1, 0, 0, 30)
    inputRow.BackgroundColor3 = T.Panel
    inputRow.BorderSizePixel = 0
    inputRow.LayoutOrder = 5
    inputRow.ZIndex = 7
    inputRow.Parent = moveTab
    Instance.new("UICorner", inputRow).CornerRadius = UDim.new(0, 6)

    local inputLbl = Instance.new("TextLabel")
    inputLbl.Size = UDim2.new(0.55, 0, 1, 0)
    inputLbl.Position = UDim2.new(0, 10, 0, 0)
    inputLbl.BackgroundTransparency = 1
    inputLbl.Text = "CUSTOM SPEED (16-500):"
    inputLbl.TextColor3 = T.Muted
    inputLbl.Font = Enum.Font.GothamMedium
    inputLbl.TextSize = 9
    inputLbl.TextXAlignment = Enum.TextXAlignment.Left
    inputLbl.ZIndex = 8
    inputLbl.Parent = inputRow

    local speedBox = Instance.new("TextBox")
    speedBox.Size = UDim2.new(0.4, -10, 1, -6)
    speedBox.Position = UDim2.new(0.6, 0, 0, 3)
    speedBox.BackgroundColor3 = T.PanelLt
    speedBox.Text = tostring(currentSpeed)
    speedBox.TextColor3 = T.Neon
    speedBox.Font = Enum.Font.GothamBold
    speedBox.TextSize = 11
    speedBox.ClearTextOnFocus = false
    speedBox.ZIndex = 8
    speedBox.Parent = inputRow
    Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 5)
    speedBox.FocusLost:Connect(function()
        local n = tonumber(speedBox.Text)
        if n then
            applySpeedValue(n)
            speedBox.Text = tostring(currentSpeed)
        else
            speedBox.Text = tostring(currentSpeed)
        end
    end)

    sectionLbl(moveTab, 6, "JUMP & PHYSICS", T.Muted)

    local jumpStatus
    jumpStatus = makeMoveButton(moveTab, 7, "JUMP POWER  ·  OFF  (75)", function()
        local _, hum = getMoveCharacter()
        if not hum then notify("Movement", "Character not ready."); return end
        moveState.jump = not moveState.jump
        hum.UseJumpPower = true
        hum.JumpPower = moveState.jump and currentJump or defaultJumpPower
        jumpStatus.Text = "JUMP POWER  ·  " .. (moveState.jump and "ON" or "OFF") .. "  (" .. tostring(currentJump) .. ")"
        BtnColors[jumpStatus] = moveState.jump and PILL_BG_ON or T.Panel
        jumpStatus.BackgroundColor3 = BtnColors[jumpStatus]
    end)

    makeMoveButton(moveTab, 8, "JUMP +25  (MAX 350)", function()
        currentJump = math.min(MAX_JUMP, currentJump + JUMP_STEP)
        local _, hum = getMoveCharacter()
        if hum then hum.UseJumpPower = true; if moveState.jump then hum.JumpPower = currentJump end end
        jumpStatus.Text = "JUMP POWER  ·  " .. (moveState.jump and "ON" or "OFF") .. "  (" .. tostring(currentJump) .. ")"
    end, T.PanelLt)

    local infJumpStatus
    infJumpStatus = makeMoveButton(moveTab, 9, "INFINITE JUMP  ·  OFF", function()
        moveState.infiniteJump = not moveState.infiniteJump
        if moveState.infiniteJump then
            moveState.jumpConn = UIS.JumpRequest:Connect(function()
                if not moveState.infiniteJump then return end
                local _, hum = getMoveCharacter()
                if hum and hum.Health > 0 then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end)
        elseif moveState.jumpConn then
            moveState.jumpConn:Disconnect(); moveState.jumpConn = nil
        end
        infJumpStatus.Text = "INFINITE JUMP  ·  " .. (moveState.infiniteJump and "ON" or "OFF")
        BtnColors[infJumpStatus] = moveState.infiniteJump and PILL_BG_ON or T.Panel
        infJumpStatus.BackgroundColor3 = BtnColors[infJumpStatus]
    end)

    -- Noclip toggle
    local noclipStatus
    noclipStatus = makeMoveButton(moveTab, 10, "NOCLIP (WALK THROUGH WALLS)  ·  OFF", function()
        moveState.noclip = not moveState.noclip
        if moveState.noclip then
            if moveState.noclipConn then moveState.noclipConn:Disconnect() end
            moveState.noclipConn = RunService.Stepped:Connect(function()
                if not moveState.noclip then return end
                local ch = LP.Character
                if ch then
                    for _, p in ipairs(ch:GetDescendants()) do
                        if p:IsA("BasePart") and p.CanCollide then
                            p.CanCollide = false
                        end
                    end
                end
            end)
        elseif moveState.noclipConn then
            moveState.noclipConn:Disconnect()
            moveState.noclipConn = nil
        end
        noclipStatus.Text = "NOCLIP (WALK THROUGH WALLS)  ·  " .. (moveState.noclip and "ON" or "OFF")
        BtnColors[noclipStatus] = moveState.noclip and PILL_BG_ON or T.Panel
        noclipStatus.BackgroundColor3 = BtnColors[noclipStatus]
    end)

    sectionLbl(moveTab, 11, "UNIVERSAL FLIGHT (PC & ANDROID)", T.Accent)

    -- Floating On-Screen Altitude Controls for Mobile / Touch
    local mobileFlyUp, mobileFlyDown = false, false
    local mobileFlyHUD = nil

    local function createMobileFlyHUD()
        if mobileFlyHUD and mobileFlyHUD.Parent then return end
        mobileFlyHUD = Instance.new("Frame")
        mobileFlyHUD.Name = "CocoMobileFlyHUD"
        mobileFlyHUD.Size = UDim2.new(0, 72, 0, 144)
        mobileFlyHUD.Position = UDim2.new(1, -86, 0.5, -72)
        mobileFlyHUD.BackgroundColor3 = T.BG2
        mobileFlyHUD.BackgroundTransparency = 0.2
        mobileFlyHUD.BorderSizePixel = 0
        mobileFlyHUD.ZIndex = 200
        mobileFlyHUD.Parent = gui
        Instance.new("UICorner", mobileFlyHUD).CornerRadius = UDim.new(0, 12)

        local mStroke = Instance.new("UIStroke")
        mStroke.Color = T.Accent
        mStroke.Thickness = 1.4
        mStroke.Transparency = 0.2
        mStroke.Parent = mobileFlyHUD

        local hudTitle = Instance.new("TextLabel")
        hudTitle.Size = UDim2.new(1, 0, 0, 22)
        hudTitle.BackgroundTransparency = 1
        hudTitle.Text = "ALTITUDE"
        hudTitle.TextColor3 = T.Neon
        hudTitle.Font = Enum.Font.GothamBold
        hudTitle.TextSize = 8
        hudTitle.ZIndex = 201
        hudTitle.Parent = mobileFlyHUD

        local btnUp = Instance.new("TextButton")
        btnUp.Size = UDim2.new(1, -12, 0, 50)
        btnUp.Position = UDim2.new(0, 6, 0, 24)
        btnUp.BackgroundColor3 = T.Panel
        btnUp.Text = "▲\nUP"
        btnUp.TextColor3 = Color3.new(1, 1, 1)
        btnUp.Font = Enum.Font.GothamBold
        btnUp.TextSize = 11
        btnUp.ZIndex = 201
        btnUp.AutoButtonColor = false
        btnUp.Parent = mobileFlyHUD
        Instance.new("UICorner", btnUp).CornerRadius = UDim.new(0, 8)

        local btnDown = Instance.new("TextButton")
        btnDown.Size = UDim2.new(1, -12, 0, 50)
        btnDown.Position = UDim2.new(0, 6, 0, 82)
        btnDown.BackgroundColor3 = T.Panel
        btnDown.Text = "▼\nDOWN"
        btnDown.TextColor3 = Color3.new(1, 1, 1)
        btnDown.Font = Enum.Font.GothamBold
        btnDown.TextSize = 11
        btnDown.ZIndex = 201
        btnDown.AutoButtonColor = false
        btnDown.Parent = mobileFlyHUD
        Instance.new("UICorner", btnDown).CornerRadius = UDim.new(0, 8)

        local function setupHold(btn, setFlag)
            btn.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    setFlag(true)
                    btn.BackgroundColor3 = T.Accent2
                end
            end)
            btn.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    setFlag(false)
                    btn.BackgroundColor3 = T.Panel
                end
            end)
        end
        setupHold(btnUp, function(s) mobileFlyUp = s end)
        setupHold(btnDown, function(s) mobileFlyDown = s end)
    end

    local function removeMobileFlyHUD()
        if mobileFlyHUD then
            mobileFlyHUD:Destroy()
            mobileFlyHUD = nil
        end
        mobileFlyUp = false
        mobileFlyDown = false
    end

    local flyStatus
    flyStatus = makeMoveButton(moveTab, 12, "FLY  ·  OFF  (WASD / JOYSTICK + ALT)", function()
        local _, hum, root = getMoveCharacter()
        if not hum or not root then notify("Movement", "Character not ready."); return end
        moveState.fly = not moveState.fly
        if moveState.fly then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "CocoFlyVelocity"
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.P = 2e4
            bv.Velocity = Vector3.zero
            bv.Parent = root
            local bg = Instance.new("BodyGyro")
            bg.Name = "CocoFlyGyro"
            bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            bg.P = 1e4
            bg.D = 650
            bg.CFrame = root.CFrame
            bg.Parent = root
            hum.PlatformStand = true
            flyStatus.Text = "FLY  ·  ON  (WASD / JOYSTICK + ALT)"
            BtnColors[flyStatus] = PILL_BG_ON
            flyStatus.BackgroundColor3 = PILL_BG_ON

            createMobileFlyHUD()

            moveState.flyConn = RunService.RenderStepped:Connect(function(dt)
                if not moveState.fly or not root.Parent then return end
                local c = workspace.CurrentCamera
                if not c then return end
                local dir = Vector3.zero

                -- PC Keyboard controls
                if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + (c.CFrame.LookVector) end
                if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - (c.CFrame.LookVector) end
                if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + (c.CFrame.RightVector) end
                if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - (c.CFrame.RightVector) end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + (Vector3.yAxis) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.C) then dir = dir - (Vector3.yAxis) end

                -- Android / Mobile Virtual Thumbstick (hum.MoveDirection)
                if hum and hum.MoveDirection.Magnitude > 0.05 then
                    local camLook = c.CFrame.LookVector
                    local camRight = c.CFrame.RightVector
                    local flatLook = Vector3.new(camLook.X, 0, camLook.Z).Unit
                    local flatRight = Vector3.new(camRight.X, 0, camRight.Z).Unit
                    local fDot = hum.MoveDirection:Dot(flatLook)
                    local rDot = hum.MoveDirection:Dot(flatRight)
                    -- Camera-directed 3D flight: looking up/down while moving flies in 3D!
                    dir = dir + ((camLook * fDot) + (camRight * rDot))
                end

                -- Mobile Touch Buttons & Jump
                if mobileFlyUp or (hum and hum.Jump) then dir = dir + (Vector3.yAxis) end
                if mobileFlyDown then dir = dir - (Vector3.yAxis) end

                local moving = dir.Magnitude > 0.05
                local flySpeed = math.max(24, currentSpeed)
                bv.Velocity = moving and (dir.Unit * flySpeed) or Vector3.zero
                local target = CFrame.lookAt(root.Position, root.Position + c.CFrame.LookVector, Vector3.yAxis)
                bg.CFrame = bg.CFrame:Lerp(target, math.clamp((dt or 1/60) * 8, 0, 1))
            end)
        else
            if moveState.flyConn then moveState.flyConn:Disconnect(); moveState.flyConn = nil end
            removeMobileFlyHUD()
            if root then
                local bv = root:FindFirstChild("CocoFlyVelocity"); if bv then bv:Destroy() end
                local bg = root:FindFirstChild("CocoFlyGyro"); if bg then bg:Destroy() end
            end
            if hum then hum.PlatformStand = false end
            flyStatus.Text = "FLY  ·  OFF  (WASD / JOYSTICK + ALT)"
            BtnColors[flyStatus] = T.Panel
            flyStatus.BackgroundColor3 = T.Panel
        end
    end)

    makeMoveButton(moveTab, 13, "RESET ALL MOVEMENT", function()
        moveState.speed, moveState.jump, moveState.noclip = false, false, false
        if moveState.speedLoopConn then moveState.speedLoopConn:Disconnect(); moveState.speedLoopConn = nil end
        if moveState.noclipConn then moveState.noclipConn:Disconnect(); moveState.noclipConn = nil end
        local _, hum, root = getMoveCharacter()
        if hum then hum.WalkSpeed = defaultWalkSpeed; hum.UseJumpPower = true; hum.JumpPower = defaultJumpPower; hum.PlatformStand = false end
        if moveState.fly then
            moveState.fly = false
            if moveState.flyConn then moveState.flyConn:Disconnect(); moveState.flyConn = nil end
            removeMobileFlyHUD()
            if root then
                local bv = root:FindFirstChild("CocoFlyVelocity"); if bv then bv:Destroy() end
                local bg = root:FindFirstChild("CocoFlyGyro"); if bg then bg:Destroy() end
            end
        end
        speedStatus.Text = "WALK SPEED  ·  OFF  (" .. tostring(currentSpeed) .. ")"; BtnColors[speedStatus] = T.Panel; speedStatus.BackgroundColor3 = T.Panel
        jumpStatus.Text = "JUMP POWER  ·  OFF  (" .. tostring(currentJump) .. ")"; BtnColors[jumpStatus] = T.Panel; jumpStatus.BackgroundColor3 = T.Panel
        if noclipStatus then noclipStatus.Text = "NOCLIP (WALK THROUGH WALLS)  ·  OFF"; BtnColors[noclipStatus] = T.Panel; noclipStatus.BackgroundColor3 = T.Panel end
        flyStatus.Text = "FLY  ·  OFF  (WASD / JOYSTICK + ALT)"; BtnColors[flyStatus] = T.Panel; flyStatus.BackgroundColor3 = T.Panel
        notify("Movement", "All movement values reset.")
    end, T.Danger)

    LP.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            if moveState.speed then hum.WalkSpeed = currentSpeed end
            if moveState.jump then hum.UseJumpPower = true; hum.JumpPower = currentJump end
        end
        moveState.fly = false
        if moveState.flyConn then moveState.flyConn:Disconnect(); moveState.flyConn = nil end
        flyStatus.Text = "FLY  ·  OFF  (WASD + SPACE/CTRL)"; BtnColors[flyStatus] = T.Panel; flyStatus.BackgroundColor3 = T.Panel
    end)
    end -- end Move Tab scope block

    btnUnweld.MouseButton1Click:Connect(function()
        sClick()
        stopWeld()
        StateManager:Cleanup(false)
        LastWeldTargetUserId = nil
        LastPresetKey = nil
        footerSub.Text = "stopped"
        syncAllActiveIndicators()
        pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
        notify("COCO POWDER", "Unwelded & state cleared")
        sSuccess()
    end)

    -- ═══════════════════════════════════════════════════════════════════════════
    -- MINIMIZE, CLOSE & KEYBIND (Floating CP icon only shows when panel is hidden!)
    -- ═══════════════════════════════════════════════════════════════════════════
    setPanelOpen = function(isOpen)
        gui.Enabled = true
        uiState.open = isOpen
        uiState.minimized = not isOpen
        main.Visible = isOpen
        panelShadow.Visible = isOpen
        mobToggle.Visible = not isOpen
    end

    btnMin.MouseButton1Click:Connect(function()
        sClick()
        setPanelOpen(false)
    end)

    local function shutdown()
        stopWeld()
        StateManager:Cleanup(false)
        chatStopFn()
        pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
        gui:Destroy()
        print("[COCO POWDER] Terminated.")
    end

    local function showCloseConfirm()
        local overlay = Instance.new("Frame")
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.BackgroundColor3 = Color3.new(0, 0, 0)
        overlay.BackgroundTransparency = 0.45
        overlay.ZIndex = 100
        overlay.Parent = gui

        local dlg = Instance.new("Frame")
        dlg.Size = UDim2.new(0, 250, 0, 154)
        dlg.Position = UDim2.new(0.5, -125, 0.5, -77)
        dlg.BackgroundColor3 = T.BG2
        dlg.BorderSizePixel = 0
        dlg.ZIndex = 101
        dlg.Parent = gui
        Instance.new("UICorner", dlg).CornerRadius = UDim.new(0, 12)
        local ds = Instance.new("UIStroke")
        ds.Color = T.Border
        ds.Thickness = 1.2
        ds.Parent = dlg

        local dt = Instance.new("TextLabel")
        dt.Size = UDim2.new(1, -24, 0, 22)
        dt.Position = UDim2.new(0, 12, 0, 12)
        dt.BackgroundTransparency = 1
        dt.Text = "Close COCO POWDER?"
        dt.TextColor3 = T.Text
        dt.Font = Enum.Font.GothamBold
        dt.TextSize = 13
        dt.ZIndex = 102
        dt.Parent = dlg

        local dm = Instance.new("TextLabel")
        dm.Size = UDim2.new(1, -24, 0, 28)
        dm.Position = UDim2.new(0, 12, 0, 34)
        dm.BackgroundTransparency = 1
        dm.Text = "Hide to the CP icon or unload completely?"
        dm.TextColor3 = T.Muted
        dm.TextWrapped = true
        dm.Font = Enum.Font.Gotham
        dm.TextSize = 10
        dm.ZIndex = 102
        dm.Parent = dlg

        local hideBtn = Instance.new("TextButton")
        hideBtn.Size = UDim2.new(1, -24, 0, 30)
        hideBtn.Position = UDim2.new(0, 12, 0, 70)
        hideBtn.Text = "HIDE PANEL (KEEP ICONS)"
        hideBtn.TextColor3 = Color3.new(1, 1, 1)
        hideBtn.Font = Enum.Font.GothamBold
        hideBtn.TextSize = 10
        hideBtn.ZIndex = 102
        hideBtn.Parent = dlg
        Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0, 6)
        styleBtn(hideBtn, T.Accent2)

        local yb = Instance.new("TextButton")
        yb.Size = UDim2.new(0.5, -15, 0, 30)
        yb.Position = UDim2.new(0, 12, 1, -40)
        yb.Text = "UNLOAD"
        yb.TextColor3 = Color3.new(1, 1, 1)
        yb.Font = Enum.Font.GothamBold
        yb.TextSize = 10
        yb.ZIndex = 102
        yb.Parent = dlg
        Instance.new("UICorner", yb).CornerRadius = UDim.new(0, 6)
        styleBtn(yb, T.Danger)

        local nb = Instance.new("TextButton")
        nb.Size = UDim2.new(0.5, -15, 0, 30)
        nb.Position = UDim2.new(0.5, 3, 1, -40)
        nb.Text = "CANCEL"
        nb.TextColor3 = T.Text
        nb.Font = Enum.Font.GothamBold
        nb.TextSize = 10
        nb.ZIndex = 102
        nb.Parent = dlg
        Instance.new("UICorner", nb).CornerRadius = UDim.new(0, 6)
        styleBtn(nb, T.PanelLt)

        local function dismiss()
            overlay:Destroy()
            dlg:Destroy()
        end

        hideBtn.MouseButton1Click:Connect(function()
            sToggleOff()
            setPanelOpen(false)
            dismiss()
        end)
        yb.MouseButton1Click:Connect(function() sToggleOff(); shutdown() end)
        nb.MouseButton1Click:Connect(function() sClick(); dismiss() end)
    end

    btnClose.MouseButton1Click:Connect(function() sClick(); showCloseConfirm() end)

    UIS.InputBegan:Connect(function(inp, gp)
        if gp or UIS:GetFocusedTextBox() then return end
        if inp.KeyCode == Enum.KeyCode.RightShift then
            setPanelOpen(not uiState.open)
            if uiState.open then sWhoosh() else sToggleOff() end
        elseif inp.KeyCode == Enum.KeyCode.R then
            RewindSys:Start(RewindSys.duration)
        end
    end)

    showTab("Weld")
end

local bootOk, bootErr = xpcall(buildMainUI, function(err)
    local trace = ""
    -- Some executor environments expose a reduced debug library; never let the
    -- error handler itself fail and suppress the startup diagnostic.
    pcall(function()
        if debug and typeof(debug.traceback) == "function" then
            trace = "\n" .. tostring(debug.traceback())
        end
    end)
    return tostring(err) .. trace
end)
if not bootOk then
    warn("[COCO POWDER] GUI startup failed:\n" .. tostring(bootErr))
    -- Show a simple diagnostic in PlayerGui so a failed mount/build is visible.
    pcall(function()
        local playerGui = LP:FindFirstChildOfClass("PlayerGui") or LP:WaitForChild("PlayerGui", 8)
        if not playerGui then return end
        local old = playerGui:FindFirstChild("CocoPowderStartupError")
        if old then old:Destroy() end
        local diagnostic = Instance.new("ScreenGui")
        diagnostic.Name = "CocoPowderStartupError"
        diagnostic.ResetOnSpawn = false
        diagnostic.DisplayOrder = 100000
        diagnostic.Parent = playerGui
        local panel = Instance.new("Frame")
        panel.Size = UDim2.new(0.9, 0, 0, 150)
        panel.Position = UDim2.new(0.05, 0, 0.08, 0)
        panel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        panel.BorderSizePixel = 0
        panel.Parent = diagnostic
        Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 10)
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -20, 0, 32)
        title.Position = UDim2.new(0, 10, 0, 8)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextSize = 16
        title.TextColor3 = Color3.fromRGB(255, 115, 115)
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Text = "COCO POWDER failed to start"
        title.Parent = panel
        local details = Instance.new("TextLabel")
        details.Size = UDim2.new(1, -20, 1, -48)
        details.Position = UDim2.new(0, 10, 0, 40)
        details.BackgroundTransparency = 1
        details.Font = Enum.Font.Code
        details.TextSize = 11
        details.TextColor3 = Color3.fromRGB(235, 235, 240)
        details.TextWrapped = true
        details.TextXAlignment = Enum.TextXAlignment.Left
        details.TextYAlignment = Enum.TextYAlignment.Top
        details.Text = tostring(bootErr):sub(1, 1800)
        details.Parent = panel
    end)
    return
end
notify("COCO POWDER V35", "Omnipresent Seeker & Void-Safe ready. Finds & TPs to hidden players anywhere!")
print("[COCO POWDER V35] Ready.")
