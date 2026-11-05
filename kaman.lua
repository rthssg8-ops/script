--[[═══════════════════════════════════════════════════════════════════════════════
  🟨 KHAMAN DHOKLA — V39 "ANTI-FREEZE TROLL FIX, TRUE UNLIMITED FLING & ULTRA VC V4"
  Upgrades & Fixes:
    • Zero-Freeze Troll & Weld Engine: Preserves all Troll & Weld presets/offsets while
      fixing post-weld character freeze, Animate track corruption, and mid-respawn noclip drops
    • True Unlimited Nebula Fling & Void Lock: Runs non-stop across target deaths & respawns
      (and chains targets in Auto-Nearest mode) until manually stopped by the user
    • 24/7 Always-On Core Shields: Anti-Sit, Anti-Void, Anti-Lag & Anti-Freeze enabled at boot
      with zero-overhead Stepped/event architecture (0 GetDescendants/SetStateEnabled lag)
    • Ultra Khaman Anti-VC V4: Auto & 0-Wait Force Bypass + PublishPause Hook + Watchdog
  Tabs: WELD | TARGET | CHAT | ANTI | MOVE
  Toggle: RightShift (or floating KD Dhokla Cube launcher)
  Theme: Authentic Khaman Dhokla (Steamed Golden Besan Sponge, Roasted Rai Mustard
         Seeds, Crisp Curry Leaf & Green Chili Chutney Accents, Grated Coconut Text)
  Compatibility: Universal R6 & R15 Cross-Rig Architecture (Delta / Android / PC)
  V37 Upgrades & Optimizations:
    • 0.00s True Zero-Delay Troll & Weld Engine: Synchronous Frame-0 CFrame lock &
      instant 0-fade animation playback across RenderStepped, Stepped, and Heartbeat
    • Calibrated Face Bang & Backshots for rbxassetid://116235062592344: Exact
      head/face height alignment + live Height (Y), Distance (Z), and Speed tuner
    • Ultra-Smooth Page & Panel Transitions: Directional Quint slide + fade page
      switching, animated sliding tab indicator pill, and smooth spring panel toggle
    • Cached Character Part Optimizer: Event-driven BasePart caching eliminates
      redundant GetDescendants() scans for locked high FPS on Android & PC
═══════════════════════════════════════════════════════════════════════════════]]

print("[KHAMAN DHOKLA] V37 Golden Tadka Zero-Delay & Refined UI Edition bootstrapping...")

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
    warn("[KHAMAN DHOKLA] Startup stopped: LocalPlayer was unavailable after 12 seconds. Execute after joining a game.")
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
    warn("[KHAMAN DHOKLA] GUI container missing. Re-execute after joining a game.")
    return
end

local function cleanupOldGuis(container)
    if not container then return end
    pcall(function()
        for _, child in ipairs(container:GetChildren()) do
            if child.Name:match("^KhamanDhokla") or child.Name:match("^CocoPowder") then
                child:Destroy()
            end
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
    -- Refined Khaman Dhokla Palette: Rich Golden Besan Sponge, Roasted Rai Tadka & Green Chutney
    BG      = Color3.fromRGB(28, 21, 6),     -- Deep Roasted Tadka & Besan Base
    BG2     = Color3.fromRGB(42, 31, 9),     -- Warm Golden-Brown Dhokla Crust
    Panel   = Color3.fromRGB(58, 44, 12),    -- Spongy Khaman Interior Card
    PanelLt = Color3.fromRGB(82, 62, 17),    -- Fluffy Steamed Besan Highlight
    Border  = Color3.fromRGB(218, 165, 32),  -- Bright Turmeric Gold Rim
    Accent  = Color3.fromRGB(250, 204, 21),  -- Signature Khaman Dhokla Golden Yellow
    Accent2 = Color3.fromRGB(217, 138, 10),  -- Tangy Kesari Tadka Amber (Buttons/Active)
    Neon    = Color3.fromRGB(254, 243, 148), -- Fresh Lemon-Turmeric Sponge Glow
    Success = Color3.fromRGB(38, 198, 90),   -- Fresh Coriander & Green Chili Chutney
    Danger  = Color3.fromRGB(239, 68, 68),   -- Spicy Red Chili Tadka
    Warning = Color3.fromRGB(245, 168, 18),  -- Sweet Tamarind Chutney
    Pink    = Color3.fromRGB(252, 211, 77),  -- Soft Besan Cream
    Purple  = Color3.fromRGB(234, 179, 8),   -- Golden Mustard Glow
    Text    = Color3.fromRGB(255, 252, 238), -- Fresh Grated Coconut White
    Muted   = Color3.fromRGB(224, 201, 142), -- Toasted Sesame & Soft Besan Text
    Dark    = Color3.fromRGB(18, 13, 4),     -- Black Mustard Seed (Rai)
    Active  = Color3.fromRGB(108, 82, 20),   -- Warm Active Sponge Cell
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
            Title = title or "KHAMAN DHOKLA",
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
local WeldIntent          = { active = false, presetKey = nil, target = nil, waitingForSpawn = false, autoNearest = false }
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
local markIntentionalTeleport
local RewindSys
local VoidRescueActive = false
local deflectBusy = false
local contactTimers = {}
local deflectCooldowns = {}
local attackerLastPos = {}

-- Helper: Returns true ONLY when local character is actively attached in a Troll Weld or Fling
local function isActivelyWeldedOrFlinging()
    return (CurrentWeld ~= nil and not CurrentWeld.destroyed) or FlingActive
end

-- Hoisted shared movement & defence state so RewindSys, WeldTo, and Anti modules share exact upvalues
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
    desiredWalkSpeed = 32,
}
local RescueGeneration = 0

-- Event-Driven Character BasePart Cache: avoids redundant GetDescendants() scans on every Stepped frame!
local CharPartCache = setmetatable({}, { __mode = "k" })
local function getCachedCharParts(char)
    if not char then return {} end
    local entry = CharPartCache[char]
    if entry then return entry.parts end
    local parts = {}
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            parts[#parts + 1] = d
        end
    end
    entry = { parts = parts }
    CharPartCache[char] = entry
    char.DescendantAdded:Connect(function(d)
        if d:IsA("BasePart") then
            parts[#parts + 1] = d
        end
    end)
    char.DescendantRemoving:Connect(function(d)
        if d:IsA("BasePart") then
            for i = #parts, 1, -1 do
                if parts[i] == d then
                    table.remove(parts, i)
                    break
                end
            end
        end
    end)
    return parts
end

-- Universal RootPart resolver: handles games that rename HumanoidRootPart or use custom rigs
local function getRootPart(char)
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp and hrp:IsA("BasePart") then return hrp end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.RootPart and hum.RootPart:IsA("BasePart") then return hum.RootPart end
    if char.PrimaryPart and char.PrimaryPart:IsA("BasePart") then return char.PrimaryPart end
    local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("Head")
    if torso and torso:IsA("BasePart") then return torso end
    return char:FindFirstChildWhichIsA("BasePart")
end

-- Break any active SeatWeld, VehicleSeat weld, or external grab joint on local character before teleporting/welding
local function breakLocalSeatAndTrapWelds(char)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function()
            local seatPart = hum.SeatPart
            if seatPart then
                pcall(function() seatPart.CanTouch = false end)
                for _, w in ipairs(seatPart:GetDescendants()) do
                    if w:IsA("Weld") or w:IsA("WeldConstraint") or w:IsA("Motor6D") or w.Name == "SeatWeld" then
                        w:Destroy()
                    end
                end
            end
            hum.Sit = false
        end)
    end
    for _, desc in ipairs(char:GetDescendants()) do
        if desc:IsA("SeatWeld") or desc.Name == "SeatWeld" then
            pcall(function() desc:Destroy() end)
        elseif desc:IsA("BasePart") then
            local okJ, joints = pcall(function() return desc:GetJoints() end)
            if okJ and joints then
                for _, j in ipairs(joints) do
                    if j:IsA("JointInstance") or j:IsA("WeldConstraint") then
                        local p0, p1 = j.Part0, j.Part1
                        local p0Mine = p0 and p0:IsDescendantOf(char)
                        local p1Mine = p1 and p1:IsDescendantOf(char)
                        if (p0Mine and p1 and not p1Mine) or (p1Mine and p0 and not p0Mine) then
                            pcall(function() j:Destroy() end)
                        end
                    end
                end
            end
        end
    end
end

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
    local root = getRootPart(character)
    if root then
        if sethiddenproperty then
            pcall(function() sethiddenproperty(root, "PhysicsRepRootPart", nil) end)
            pcall(function() sethiddenproperty(root, "PhysicsRepRootRef", nil) end)
        end
        root.Anchored = false
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end
    for _, part in ipairs(getCachedCharParts(character)) do
        if part.Parent then
            part.Massless = false
            pcall(function() part.CustomPhysicalProperties = nil end)
            if not (moveState and moveState.noclip) and (part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head") then
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
        local myRoot = getRootPart(LP.Character)
        if myRoot and sethiddenproperty then
            pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", nil) end)
            pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootRef", nil) end)
        end
        for _, part in ipairs(getCachedCharParts(LP.Character)) do
            if part.Parent then
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

function StateManager:Cleanup(keepTarget, skipReturn)
    if CurrentWeld then
        pcall(function() CurrentWeld:Destroy(skipReturn) end)
        CurrentWeld = nil
    end
    self:StopAllAnimations()
    self:StopFling(skipReturn)
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
    if LP.Character and not skipReturn then
        self:ResetPhysics(LP.Character)
        local root = getRootPart(LP.Character)
        if root and not isSafePlayableCF(root.CFrame) then
            safeReturnFromVoid(LP.Character, LastKnownSafeCF)
        end
    end
    if not keepTarget then CurrentTarget = nil end
end

local ANIM_VERIFY_TIME = 0.12
local ANIM_MAX_ATTEMPTS = 2

local function forcePhysicsState(hum)
    if not hum then return end
    pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true) end)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Physics) end)
end

local function normalizeAnimAssetId(animId)
    local raw = tostring(animId or ""):gsub("%s+", "")
    local digits = raw:match("(%d+)$")
    return digits or raw
end

-- Instant 0.00s Zero-Delay Animation Starter:
-- Starts primary animation track immediately with 0 fade time on the calling frame!
local function startInstantAnimTrack(Animator, animId, fallbacks, hum, priority)
    if not Animator or not animId then return nil, nil end
    local cleanId = normalizeAnimAssetId(animId)
    if cleanId == "" then return nil, nil end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. cleanId
    local okLoad, track = pcall(function() return Animator:LoadAnimation(anim) end)
    if (not okLoad or not track) and hum then
        okLoad, track = pcall(function() return hum:LoadAnimation(anim) end)
    end
    if okLoad and track then
        pcall(function() track.Priority = priority or Enum.AnimationPriority.Action4 end)
        pcall(function() if not track.Priority then track.Priority = Enum.AnimationPriority.Action end end)
        pcall(function() track.Looped = true end)
        forcePhysicsState(hum)
        local spd = math.clamp(V.Speed or 1.0, 0.2, 6.0)
        local okPlay = pcall(function() track:Play(0, 1, spd) end)
        if okPlay then
            pcall(function() track:AdjustSpeed(spd) end)
            table.insert(PlayedAnims, track)
            return track, anim
        end
    end
    pcall(function() anim:Destroy() end)
    -- If primary failed synchronously, try fallbacks immediately
    for _, fb in ipairs(fallbacks or {}) do
        local fbId = normalizeAnimAssetId(fb)
        if fbId ~= "" then
            local fbAnim = Instance.new("Animation")
            fbAnim.AnimationId = "rbxassetid://" .. fbId
            local ok2, tr2 = pcall(function() return Animator:LoadAnimation(fbAnim) end)
            if ok2 and tr2 then
                pcall(function() tr2.Priority = priority or Enum.AnimationPriority.Action4 end)
                pcall(function() tr2.Looped = true end)
                forcePhysicsState(hum)
                local spd = math.clamp(V.Speed or 1.0, 0.2, 6.0)
                if pcall(function() tr2:Play(0, 1, spd) end) then
                    pcall(function() tr2:AdjustSpeed(spd) end)
                    table.insert(PlayedAnims, tr2)
                    return tr2, fbAnim
                end
            end
            pcall(function() fbAnim:Destroy() end)
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
    if c then
        local animate = c:FindFirstChild("Animate")
        if animate and animate.Disabled then
            animate.Disabled = false
        end
    end
    AnimateWasDisabled = false
end

recoverCharacterState = function(char, safeCF)
    char = char or (LP and LP.Character)
    if not char then return end
    local root = getRootPart(char)
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
            targetCF = root.CFrame
        else
            targetCF = findFallbackSafeCF()
        end

        if targetCF then
            local pos = targetCF.Position
            local _, yYaw, _ = targetCF:ToEulerAnglesYXZ()
            root.CFrame = CFrame.new(pos) * CFrame.Angles(0, yYaw, 0)
        end
    end
    for _, part in ipairs(getCachedCharParts(char)) do
        if part.Parent then
            part.Anchored = false
            part.Massless = false
            pcall(function() part.CustomPhysicalProperties = nil end)
            if not (moveState and moveState.noclip) and (part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head") then
                part.CanCollide = true
            end
            if not (Anti and Anti.Kill and Anti.Kill.enabled) then
                part.CanTouch = true
                part.CanQuery = true
            end
        end
    end
    -- Stop custom/troll tracks FIRST, then re-enable Animate so default idle/walk tracks are never destroyed!
    stopDefaultTracks(char)
    restoreAnimate(char)
    if hum and hum.Health > 0 then
        pcall(function()
            if not hum.EvaluateStateMachine then hum.EvaluateStateMachine = true end
            hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
            hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
            hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
            hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
            hum:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
            hum.PlatformStand = false
            hum.Sit = false
            hum.AutoRotate = true
            if hum.WalkSpeed < 8 then
                hum.WalkSpeed = (moveState and moveState.speed and moveState.desiredWalkSpeed) or 16
            end
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end)
    end
    local currentCam = workspace.CurrentCamera
    if currentCam and hum and not SpectatingTarget then
        pcall(function()
            currentCam.CameraType = Enum.CameraType.Custom
            currentCam.CameraSubject = hum
        end)
    end
end

-- Instant zero-freeze return: only anchors for 2 frames if actually rescuing from deep void / high-speed fling!
safeReturnFromVoid = function(char, preferredCF)
    char = char or (LP and LP.Character)
    if not char then return end
    if (CurrentWeld ~= nil and not CurrentWeld.destroyed) or FlingActive then return end
    local root = getRootPart(char)
    local hum  = char:FindFirstChildOfClass("Humanoid")
    local wasInDeepVoid = false
    if root then
        local p = root.Position
        local v = root.AssemblyLinearVelocity
        if p.Y <= math.max(OriginalFPDH + 45, -160) or p.Magnitude > 18000 or v.Magnitude > 160 then
            wasInDeepVoid = true
        end
    end
    local resolvedCF = isSafePlayableCF(preferredCF) and preferredCF
        or (root and isSafePlayableCF(root.CFrame) and root.CFrame)
        or findFallbackSafeCF()
    local pos = resolvedCF.Position
    local _, yYaw, _ = resolvedCF:ToEulerAnglesYXZ()
    local cleanCF = CFrame.new(pos + Vector3.new(0, 1.2, 0)) * CFrame.Angles(0, yYaw, 0)

    markIntentionalTeleport(cleanCF)
    recoverCharacterState(char, cleanCF)
    if not root or not root.Parent then return end

    RescueGeneration = RescueGeneration + 1
    local myRescueGen = RescueGeneration

    -- If already on safe ground (e.g. stopping a normal Troll weld), do NOT anchor the character at all!
    if not wasInDeepVoid then
        VoidRescueActive = false
        return
    end

    task.spawn(function()
        VoidRescueActive = true
        pcall(function()
            root.Anchored = true
            for _ = 1, 2 do
                if not root.Parent or myRescueGen ~= RescueGeneration or (CurrentWeld ~= nil and not CurrentWeld.destroyed) or FlingActive then
                    break
                end
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = cleanCF
                RunService.Heartbeat:Wait()
            end
            if root.Parent then
                root.Anchored = false
                if myRescueGen == RescueGeneration and (CurrentWeld == nil or CurrentWeld.destroyed) and not FlingActive then
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                    root.CFrame = cleanCF
                end
            end
            if myRescueGen == RescueGeneration and (CurrentWeld == nil or CurrentWeld.destroyed) and not FlingActive then
                if hum and hum.Parent and hum.Health > 0 then
                    hum.PlatformStand = false
                    hum.Sit = false
                    hum.AutoRotate = true
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end
            end
        end)
        if myRescueGen == RescueGeneration then
            VoidRescueActive = false
        end
        if not (Anti and (Anti.AlwaysOnCore or (Anti.Void and Anti.Void.enabled) or (Anti.InfFallVoid and Anti.InfFallVoid.enabled) or (Anti.Kill and Anti.Kill.enabled))) and not WeldIntent.active and not FlingActive then
            pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
        end
    end)
end

-- Continuously record LastKnownSafeCF when on safe ground & auto-rescue if stranded in void
RunService.Heartbeat:Connect(function()
    local char = LP.Character
    local root = getRootPart(char)
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    if not root or not hum or hum.Health <= 0 then return end

    if not isActivelyWeldedOrFlinging() and not (RewindSys and RewindSys.rewinding) then
        local vel = root.AssemblyLinearVelocity.Magnitude
        if isSafePlayableCF(root.CFrame) and vel < 110 and hum.FloorMaterial ~= Enum.Material.Air then
            local _, yYaw, _ = root.CFrame:ToEulerAnglesYXZ()
            LastKnownSafeCF = CFrame.new(root.Position) * CFrame.Angles(0, yYaw, 0)
        elseif root.Position.Y <= math.max(OriginalFPDH + 22, -260) or root.Position.Magnitude > 22000 then
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
local WELD_PRESETS
local getNearestPlayer, findPlayerByNameOrDisplay, resolvePlayer, resolveActiveTarget, applyWeldPreset, hookTargetRespawn

do -- Scoped block for Zero-Delay WeldTo, Seeker & Watchdog (preserves top-level local register budget)

local function WeldTo(TargetPart, Offset, Speaker, AnimationId, Osc, AnimFallbacks, TargetPlayer, RefMode)
    local Character = Speaker.Character
    if not Character then return nil end
    local Root = getRootPart(Character)
    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
    if not Root or not Humanoid or Humanoid.Health <= 0 then return nil end

    -- Cancel any pending void-return loop so it never fights our new weld connection
    RescueGeneration = RescueGeneration + 1
    Root.Anchored = false
    breakLocalSeatAndTrapWelds(Character)

    local TargetChar = (TargetPart and TargetPart.Parent) or (TargetPlayer and findPlayerCharacterAnywhere(TargetPlayer))
    local TargetHum  = TargetChar and TargetChar:FindFirstChildOfClass("Humanoid")

    -- Initialize lastSafeCF right at the target's safe position (never at a stale pre-teleport origin across the map!)
    local lastSafeCF = nil
    if TargetPart and TargetPart.Parent and not isLethalVoidCF(TargetPart.CFrame, TargetPart.AssemblyLinearVelocity) then
        local _, yYaw, _ = TargetPart.CFrame:ToEulerAnglesYXZ()
        lastSafeCF = CFrame.new(TargetPart.Position + Vector3.new(0, 2.5, 0)) * CFrame.Angles(0, yYaw, 0)
        LastKnownSafeCF = lastSafeCF
    else
        lastSafeCF = (isSafePlayableCF(Root.CFrame) and Root.CFrame)
            or (isSafePlayableCF(LastKnownSafeCF) and LastKnownSafeCF)
            or findFallbackSafeCF()
    end

    pcall(function() Humanoid.Sit = false end)
    pcall(function() Humanoid.PlatformStand = true end)
    pcall(function() Humanoid.AutoRotate = false end)
    forcePhysicsState(Humanoid)
    killAnimate(Character)

    local function applyPhaseNoclip()
        if not Character or not Character.Parent then return end
        for _, v in ipairs(getCachedCharParts(Character)) do
            if v.Parent then
                if v.CanCollide then v.CanCollide = false end
                if v.CanTouch then v.CanTouch = false end
                if v.CanQuery then v.CanQuery = false end
                if not v.Massless then v.Massless = true end
                if v.Anchored then v.Anchored = false end
            end
        end
        if Humanoid and Humanoid.Sit then
            pcall(function() Humanoid.Sit = false end)
        end
    end
    applyPhaseNoclip()

    -- ZERO-DELAY FRAME-0 LOCK: Snap to TargetPart immediately on the exact calling line!
    local clock = 0
    local function computeCurrentTargetLockCF()
        local customAdjust = CFrame.new(V.X or 0, V.Y or 0, (V.Z or 1.3) - 1.3)
        local localOffset = Offset * customAdjust
        if Osc and Osc.period and Osc.period > 0 then
            local phase = (math.sin(clock * (2 * math.pi) / Osc.period) + 1) * 0.5
            localOffset = localOffset * CFrame.new(0, 0, -Osc.distance * phase)
        end
        return TargetPart.CFrame * localOffset
    end

    local function bindZeroDelayPhysicsRep(part)
        if not sethiddenproperty or not Root or not Root.Parent then return end
        pcall(function()
            sethiddenproperty(Root, "PhysicsRepRootPart", part)
            if InstanceHandleNew then
                sethiddenproperty(Root, "PhysicsRepRootRef", part and InstanceHandleNew(part) or nil)
            end
        end)
    end

    local currentLockCF = nil
    if TargetPart and TargetPart.Parent then
        currentLockCF = computeCurrentTargetLockCF()
        markIntentionalTeleport(currentLockCF)
        Root.CFrame = currentLockCF
        Root.AssemblyLinearVelocity = Vector3.zero
        Root.AssemblyAngularVelocity = Vector3.zero
        bindZeroDelayPhysicsRep(TargetPart)
    end

    -- ZERO-DELAY FRAME-0 ANIMATION: Start animation immediately without any task.wait!
    local AnimTrack, AnimInstance = nil, nil
    local animAttempts = 0
    local Weld = { destroyed = false }

    local function ensureAnim(force)
        if not AnimationId or Weld.destroyed then return end
        if AnimTrack and not force then
            local ip = false
            pcall(function()
                ip = AnimTrack.IsPlaying
                if ip and AnimTrack.Length > 0 and AnimTrack.TimePosition >= (AnimTrack.Length - 0.04) then
                    AnimTrack.TimePosition = 0
                end
            end)
            if ip then
                pcall(function() AnimTrack:AdjustSpeed(math.clamp(V.Speed or 1.0, 0.2, 6.0)) end)
                return
            end
        end
        animAttempts = animAttempts + 1
        if not force and animAttempts % 10 ~= 0 and AnimTrack then return end
        local Animator = Character:FindFirstChildWhichIsA("Animator", true)
        if not Animator and Humanoid then
            Animator = Instance.new("Animator")
            Animator.Parent = Humanoid
        end
        if not Animator then return end
        local track, anim = startInstantAnimTrack(Animator, AnimationId, AnimFallbacks, Humanoid)
        if track then
            if AnimTrack and AnimTrack ~= track then
                pcall(function() AnimTrack:Stop(0); AnimTrack:Destroy() end)
            end
            if AnimInstance and AnimInstance ~= anim then
                pcall(function() AnimInstance:Destroy() end)
            end
            AnimTrack = track
            AnimInstance = anim
        end
    end
    ensureAnim(true)

    local Conn = nil
    local RenderConn = nil
    local StepConn = nil
    local missingFrames = 0

    function Weld:Destroy(skipReturn)
        if self.destroyed then return end
        self.destroyed = true
        if Conn then Conn:Disconnect(); Conn = nil end
        if RenderConn then RenderConn:Disconnect(); RenderConn = nil end
        if StepConn then StepConn:Disconnect(); StepConn = nil end
        pcall(function() LP.ReplicationFocus = nil end)
        if Root and sethiddenproperty then
            pcall(function() sethiddenproperty(Root, "PhysicsRepRootPart", nil) end)
            pcall(function() sethiddenproperty(Root, "PhysicsRepRootRef", nil) end)
        end
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
        if not skipReturn then
            LastVoidActionEnd = tick()
            safeReturnFromVoid(Character, lastSafeCF)
            if LP.Character and LP.Character ~= Character then
                safeReturnFromVoid(LP.Character, lastSafeCF)
            end
        end
    end

    -- Stepped pass ensures we phase through walls, doors, roofs, and seats inside any hiding spot + zero-delay PhysicsRepRootPart lock
    StepConn = RunService.Stepped:Connect(function()
        if Weld.destroyed then return end
        applyPhaseNoclip()
        if TargetPart and TargetPart.Parent and Root and Root.Parent and not isLethalVoidCF(TargetPart.CFrame, TargetPart.AssemblyLinearVelocity) then
            currentLockCF = computeCurrentTargetLockCF()
            markIntentionalTeleport(currentLockCF)
            Root.CFrame = currentLockCF
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
            bindZeroDelayPhysicsRep(TargetPart)
        end
    end)

    -- RenderStepped pass guarantees zero-jitter visual lock when the target sprints or turns camera
    RenderConn = RunService.RenderStepped:Connect(function()
        if Weld.destroyed then return end
        if TargetPart and TargetPart.Parent and Root and Root.Parent and not isLethalVoidCF(TargetPart.CFrame, TargetPart.AssemblyLinearVelocity) then
            currentLockCF = computeCurrentTargetLockCF()
            markIntentionalTeleport(currentLockCF)
            Root.CFrame = currentLockCF
            bindZeroDelayPhysicsRep(TargetPart)
        end
    end)

    Conn = RunService.Heartbeat:Connect(function(dt)
        -- 1. Check if our own character died or respawned
        if not Character.Parent or Character ~= LP.Character or not Root.Parent or not Humanoid.Parent or Humanoid.Health <= 0 then
            Weld:Destroy(true)
            return
        end

        -- 2. Check if target player left the server completely
        if TargetPlayer and TargetPlayer.Parent ~= Players then
            Weld:Destroy(false)
            if stopWeld then pcall(stopWeld) end
            if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
            notify("KHAMAN DHOKLA", "Target left server — safely returned")
            return
        end

        -- 3. Check if target died
        if TargetHum and TargetHum.Parent and TargetHum.Health <= 0 then
            Weld:Destroy(false)
            return
        end

        -- 4. OMNIPRESENT RE-LOCK: If TargetPart streamed out because target teleported to a hiding spot,
        --    entered a house/locker/vehicle, or switched character model, dynamically re-acquire or follow!
        if not TargetPart or not TargetPart.Parent or (TargetPlayer and findPlayerCharacterAnywhere(TargetPlayer) ~= TargetChar) then
            if TargetPlayer then
                local newChar = findPlayerCharacterAnywhere(TargetPlayer)
                local newHum  = newChar and newChar:FindFirstChildOfClass("Humanoid")
                if newHum and newHum.Health <= 0 then
                    Weld:Destroy(false)
                    return
                end
                local newPart = newChar and pickTargetRef(newChar, RefMode or "torso")
                if newPart and newPart.Parent then
                    TargetChar = newChar
                    TargetHum  = newHum
                    TargetPart = newPart
                    missingFrames = 0
                else
                    missingFrames = missingFrames + 1
                    local hiddenCF = getBestTargetCFrame(TargetPlayer)
                    if hiddenCF and not isLethalVoidCF(hiddenCF) then
                        pcall(function() LP:RequestStreamAroundAsync(hiddenCF.Position, 1) end)
                        Root.CFrame = hiddenCF * Offset
                        Root.AssemblyLinearVelocity = Vector3.zero
                        Root.AssemblyAngularVelocity = Vector3.zero
                        markIntentionalTeleport(Root.CFrame)
                    end
                    if missingFrames > 100 then
                        Weld:Destroy(false)
                    end
                    return
                end
            else
                Weld:Destroy(false)
                return
            end
        else
            missingFrames = 0
        end

        -- 5. VOID PROTECTION: Only detach if the target is genuinely plummeting in the lethal void killzone
        local tVel = TargetPart.AssemblyLinearVelocity
        if isLethalVoidCF(TargetPart.CFrame, tVel) then
            Weld:Destroy(false)
            notify("KHAMAN DHOKLA", "Target fell into lethal Void — detached safely!")
            return
        end

        -- Keep server streaming focused on the target so they can never outrun our client stream
        pcall(function() LP.ReplicationFocus = TargetPart end)

        -- Cache target location & update safe standing CFrame right at the target's position
        if TargetPlayer then
            PlayerLocationCache[TargetPlayer.UserId] = { cf = TargetPart.CFrame, time = tick(), fromPart = true }
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
        currentLockCF = computeCurrentTargetLockCF()
        Root.CFrame = currentLockCF
        Root.AssemblyLinearVelocity = Vector3.zero
        Root.AssemblyAngularVelocity = Vector3.zero
        markIntentionalTeleport(Root.CFrame)
        bindZeroDelayPhysicsRep(TargetPart)
        pcall(function() ensureAnim(false) end)
        pcall(function()
            if not Humanoid.PlatformStand then Humanoid.PlatformStand = true end
            if Humanoid.Sit then Humanoid.Sit = false end
        end)
    end)

    return Weld
end

local function unweld(skipReturn)
    if CurrentWeld then
        pcall(function() CurrentWeld:Destroy(skipReturn) end)
        CurrentWeld = nil
    elseif not skipReturn and LP.Character then
        pcall(function() safeReturnFromVoid(LP.Character, LastKnownSafeCF) end)
    end
    if not (Anti and Anti.Void and Anti.Void.enabled) and not (Anti and Anti.InfFallVoid and Anti.InfFallVoid.enabled) and not (Anti and Anti.Kill and Anti.Kill.enabled) then
        pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
    end
end

local BANG_ANIM_ID = 116235062592344

-- Exact Tesla File (root.70.60, root.70.61, root.70.62) Height & Distance Adjustments for All Features:
WELD_PRESETS = {
    facebang  = { offset = CFrame.new(0, 1.2, -3.0) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = BANG_ANIM_ID, anim6 = BANG_ANIM_ID,
                  animFallbacks = {128342454196913, 5918726674, 148840371, 4555808220, 109168916859109},
                  osc = {distance = 2.5, period = 0.20}, refMode = "head", label = "Face Bang" },
    backshots = { offset = CFrame.new(0, 0, 2.5),
                  anim15 = BANG_ANIM_ID, anim6 = BANG_ANIM_ID,
                  animFallbacks = {128342454196913, 5918726674, 148840371, 4555808220, 109168916859109},
                  osc = {distance = 2.0, period = 0.20}, refMode = "torso", label = "Backshots" },
    headsit   = { offset = CFrame.new(0, 1.5, 0),
                  anim15 = 2506281703, anim6 = 2506281703,
                  animFallbacks = {2510238627, 507768375, 180426354},
                  osc = nil, refMode = "head", label = "Headsit" },
    kiss      = { offset = CFrame.new(0, 0, -1.2) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 81124524945738, anim6 = 81124524945738,
                  animFallbacks = {3576686446, 3019619673, 15849372443},
                  osc = nil, refMode = "torso", label = "Kiss" },
    backpack  = { offset = CFrame.new(0, 0.5, 1.1) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 2506281703, anim6 = 2506281703,
                  animFallbacks = {2510238627, 507768375, 180426354},
                  osc = nil, refMode = "torso", label = "Backpack" },
    headpat   = { offset = CFrame.new(0, 0, -2.5) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 114313599861536, anim6 = 114313599861536,
                  animFallbacks = {}, osc = nil, refMode = "torso", label = "Headpat" },
    propose   = { offset = CFrame.new(0, -1.0, -2.5) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 70639053125611, anim6 = 70639053125611,
                  animFallbacks = {}, osc = nil, refMode = "torso", label = "Propose" },
    hug       = { offset = CFrame.new(0, 0, -1.2) * CFrame.Angles(0, math.rad(180), 0),
                  anim15 = 95247520541805, anim6 = 95247520541805,
                  animFallbacks = {}, osc = nil, refMode = "torso", label = "Hug" },
}

WELD_PRESETS.bang = WELD_PRESETS.backshots

WELD_PRESETS.chase = {
    offset = CFrame.new(0, 0, 1.5),
    anim15 = nil,
    anim6  = nil,
    animFallbacks = {},
    osc = nil,
    refMode = "torso",
    label = "Auto-Chase (Follow)"
}

-- Fast cached character resolver: zero-delay O(1) lookup for active characters
local CustomCharCache = {}
local CommonCharContainers = { "Characters", "Players", "Entities", "Live", "Units", "Ingame", "Chars" }

findPlayerCharacterAnywhere = function(plr)
    if not plr then return nil end
    if plr.Character and plr.Character.Parent then
        CustomCharCache[plr.UserId] = { model = plr.Character, lastScan = tick() }
        return plr.Character
    end
    local cached = CustomCharCache[plr.UserId]
    if cached and cached.model and cached.model.Parent then
        return cached.model
    end
    local direct = workspace:FindFirstChild(plr.Name)
    if direct and direct:IsA("Model") and (direct:FindFirstChildOfClass("Humanoid") or direct:FindFirstChild("HumanoidRootPart") or direct.PrimaryPart) then
        CustomCharCache[plr.UserId] = { model = direct, lastScan = tick() }
        return direct
    end
    for _, folderName in ipairs(CommonCharContainers) do
        local folder = workspace:FindFirstChild(folderName)
        local found = folder and folder:FindFirstChild(plr.Name)
        if found and found:IsA("Model") and (found:FindFirstChildOfClass("Humanoid") or found:FindFirstChild("HumanoidRootPart") or found.PrimaryPart or found:FindFirstChildWhichIsA("BasePart", true)) then
            CustomCharCache[plr.UserId] = { model = found, lastScan = tick() }
            return found
        end
    end
    local now = tick()
    if not cached or (now - (cached.lastScan or 0)) > 1.5 then
        CustomCharCache[plr.UserId] = { model = nil, lastScan = now }
        local byName = workspace:FindFirstChild(plr.Name, true)
        if byName and byName:IsA("Model") and byName:FindFirstChildOfClass("Humanoid") then
            CustomCharCache[plr.UserId] = { model = byName, lastScan = now }
            return byName
        end
    end
    return plr.Character
end

-- Deep fallback reference part resolver: works even when HumanoidRootPart or Head is missing/renamed/seated
pickTargetRef = function(char, mode)
    if not char then return nil end
    if mode == "head" then
        local h = char:FindFirstChild("Head") or char:FindFirstChild("head", true)
        if h and h:IsA("BasePart") then return h end
        for _, desc in ipairs(getCachedCharParts(char)) do
            if desc.Name:lower():find("head", 1, true) then
                return desc
            end
        end
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
        or (hum and hum.RootPart)
        or char.PrimaryPart
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("LowerTorso")
        or char:FindFirstChild("Torso")
        or char:FindFirstChild("Head")
    if hrp and hrp:IsA("BasePart") then return hrp end
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
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health > 0 then
            local part = pickTargetRef(char, "torso")
            if part and part.Parent then
                local cf = part.CFrame
                if not isLethalVoidCF(cf, part.AssemblyLinearVelocity) then
                    PlayerLocationCache[plr.UserId] = { cf = cf, time = tick(), fromPart = true }
                    return cf
                end
            end
            local cached = PlayerLocationCache[plr.UserId]
            local okPivot, pivotCF = pcall(function() return char:GetPivot() end)
            if okPivot and pivotCF and pivotCF.Position.Magnitude > 5 and not isLethalVoidCF(pivotCF) then
                if not cached or not cached.fromPart or (tick() - (cached.time or 0)) > 2.0 then
                    PlayerLocationCache[plr.UserId] = { cf = pivotCF, time = tick(), fromPart = false }
                    return pivotCF
                end
            end
            local okWP, wpCF = pcall(function() return char.WorldPivot end)
            if okWP and wpCF and wpCF.Position.Magnitude > 5 and not isLethalVoidCF(wpCF) then
                if not cached or not cached.fromPart or (tick() - (cached.time or 0)) > 2.0 then
                    PlayerLocationCache[plr.UserId] = { cf = wpCF, time = tick(), fromPart = false }
                    return wpCF
                end
            end
        end
    end
    local cached = PlayerLocationCache[plr.UserId]
    if cached and cached.cf and not isLethalVoidCF(cached.cf) then
        return cached.cf
    end
    return nil
end

-- Throttled 0.15s position & pivot tracker (zero frame-drop on large 50-player servers)
do
    local lastTrackTick = 0
    RunService.Heartbeat:Connect(function()
        local now = tick()
        if now - lastTrackTick < 0.15 then return end
        lastTrackTick = now
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP then
                pcall(function() getBestTargetCFrame(p) end)
            end
        end
    end)
end

-- Active Stream-Piercer & Server Hiding-Spot Seeker:
-- Returns synchronously in 0.00s when target is already streamed (without stripping local collision if target is dead)!
streamAndTeleportToTarget = function(targetPlr, refMode, maxWaitSeconds, allowSweep)
    if not targetPlr or targetPlr.Parent ~= Players then return nil, nil end
    maxWaitSeconds = maxWaitSeconds or 2.2

    -- 0.00s Zero-Delay Fast Path FIRST (before touching local character collision!):
    local tChar = findPlayerCharacterAnywhere(targetPlr)
    local tHum  = tChar and tChar:FindFirstChildOfClass("Humanoid")
    if tHum and tHum.Health <= 0 then
        return tChar, nil
    end
    local tRef = tChar and pickTargetRef(tChar, refMode or "torso")
    if tRef and tRef.Parent then
        if LP.Character then breakLocalSeatAndTrapWelds(LP.Character) end
        return tChar, tRef
    end

    local myChar = LP.Character
    local myRoot = getRootPart(myChar)
    local originSafeCF = (myRoot and isSafePlayableCF(myRoot.CFrame) and myRoot.CFrame) or LastKnownSafeCF

    if myChar then
        breakLocalSeatAndTrapWelds(myChar)
        for _, v in ipairs(getCachedCharParts(myChar)) do
            if v.Parent then
                v.CanCollide = false
                v.CanTouch = false
                v.Anchored = false
            end
        end
    end

    -- Target is in an unstreamed chunk: stream around their replicated Model:GetPivot() or cached location
    local started = tick()
    while tick() - started < (maxWaitSeconds * 0.70) do
        if targetPlr.Parent ~= Players then return nil, nil end
        tChar = findPlayerCharacterAnywhere(targetPlr)
        tHum  = tChar and tChar:FindFirstChildOfClass("Humanoid")
        if tHum and tHum.Health <= 0 then return tChar, nil end
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
            myRoot = getRootPart(myChar)
            if myRoot then
                local hopCF = targetCF * CFrame.new(0, 2, 0)
                markIntentionalTeleport(hopCF)
                myRoot.AssemblyLinearVelocity = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
                myRoot.CFrame = hopCF
            end
        else
            break
        end
        RunService.Heartbeat:Wait()
    end

    tChar = findPlayerCharacterAnywhere(targetPlr)
    tRef  = tChar and pickTargetRef(tChar, refMode or "torso")
    if tRef and tRef.Parent then return tChar, tRef end

    if not allowSweep then
        if (not tRef or not tRef.Parent) and LP.Character then
            recoverCharacterState(LP.Character, originSafeCF)
        end
        return tChar, tRef
    end

    -- Step 2: Stream probe points via RequestStreamAroundAsync first, and only move myRoot if targetCF is found
    -- (or restore originSafeCF if target is still unstreamed/respawning so player is never stranded somewhere random!)
    local probePoints = {}
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("SpawnLocation") or child:IsA("Seat") or child:IsA("VehicleSeat") then
            if not isLethalVoidCF(child.CFrame) then
                table.insert(probePoints, child.CFrame)
            end
        elseif child:IsA("Model") and child ~= LP.Character then
            local okP, pCF = pcall(function() return child:GetPivot() end)
            if okP and pCF and pCF.Position.Magnitude > 10 and not isLethalVoidCF(pCF) then
                table.insert(probePoints, pCF)
            end
        end
    end

    for idx, probeCF in ipairs(probePoints) do
        if tick() - started > maxWaitSeconds or idx > 20 then break end
        tChar = findPlayerCharacterAnywhere(targetPlr)
        tHum  = tChar and tChar:FindFirstChildOfClass("Humanoid")
        if tHum and tHum.Health <= 0 then break end
        tRef  = tChar and pickTargetRef(tChar, refMode or "torso")
        if tRef and tRef.Parent then return tChar, tRef end

        local knownCF = getBestTargetCFrame(targetPlr)
        local hopCF = knownCF or probeCF
        task.spawn(function()
            pcall(function() LP:RequestStreamAroundAsync(hopCF.Position, 1) end)
        end)
        if knownCF then
            myChar = LP.Character
            myRoot = getRootPart(myChar)
            if myRoot then
                local dest = knownCF + Vector3.new(0, 3, 0)
                markIntentionalTeleport(dest)
                myRoot.CFrame = dest
                myRoot.AssemblyLinearVelocity = Vector3.zero
            end
        end
        RunService.Heartbeat:Wait()
    end

    tChar = findPlayerCharacterAnywhere(targetPlr)
    tRef  = tChar and pickTargetRef(tChar, refMode or "torso")
    if not tRef or not tRef.Parent then
        myChar = LP.Character
        if myChar then
            recoverCharacterState(myChar, originSafeCF)
        end
    end
    return tChar, tRef
end

getNearestPlayer = function(speaker)
    speaker = speaker or LP
    local myChar = speaker and speaker.Character
    local myRoot = getRootPart(myChar)
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

findPlayerByNameOrDisplay = function(query, speaker)
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

resolvePlayer = function(target, speaker)
    speaker = speaker or LP
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

resolveActiveTarget = function()
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
    local myGen = callerGen or StopGeneration
    pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)

    local myChar = speaker and speaker.Character
    local myRoot = getRootPart(myChar)

    -- 0.00s ZERO-DELAY FAST PATH: If target is already streamed in, attach synchronously on this exact frame!
    local tCharFast = findPlayerCharacterAnywhere(TPlayer)
    local tHumFast  = tCharFast and tCharFast:FindFirstChildOfClass("Humanoid")
    local tRootFast = tCharFast and pickTargetRef(tCharFast, refMode or "torso")
    if myChar and myRoot and tRootFast and tRootFast.Parent and (not tHumFast or tHumFast.Health > 0) then
        local old = CurrentWeld
        if old then
            CurrentWeld = nil
            pcall(function() old:Destroy(true) end)
        end
        if sethiddenproperty then
            pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", nil) end)
            pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootRef", nil) end)
        end
        local w = WeldTo(tRootFast, offset, speaker, animId, osc, animFallbacks, TPlayer, refMode or "torso")
        CurrentWeld = w
        if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
        return true, TPlayer
    end

    -- Fallback async path only when target is currently unstreamed or mid-respawn
    task.spawn(function()
        local waitStart = tick()
        while (not myChar or not myRoot) and tick() - waitStart < 2.5 do
            if myGen ~= StopGeneration then return end
            RunService.Heartbeat:Wait()
            myChar = speaker and speaker.Character
            myRoot = getRootPart(myChar)
        end
        if not myChar or not myRoot or myGen ~= StopGeneration then return end

        local char, TRoot = streamAndTeleportToTarget(TPlayer, refMode or "torso", 2.4, true)
        if myGen ~= StopGeneration then return end
        if not TRoot or not TRoot.Parent then
            -- Keep WeldIntent active so the continuous watchdog immediately locks on as soon as they stream/respawn
            return
        end

        local tHum = char and char:FindFirstChildOfClass("Humanoid")
        if tHum and tHum.Health <= 0 then return end

        myChar = speaker and speaker.Character
        myRoot = getRootPart(myChar)
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

        local old = CurrentWeld
        if old then
            CurrentWeld = nil
            pcall(function() old:Destroy(true) end)
        end

        local w = WeldTo(TRoot, offset, speaker, animId, osc, animFallbacks, TPlayer, refMode or "torso")
        if myGen ~= StopGeneration then
            if w then pcall(function() w:Destroy(false) end) end
            return
        end
        CurrentWeld = w
        if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    end)
    return true, TPlayer
end

applyWeldPreset = function(presetKey, target, callerGen)
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
    unweld(false)
    if not (Anti and Anti.Void and Anti.Void.enabled) and not (Anti and Anti.InfFallVoid and Anti.InfFallVoid.enabled) and not (Anti and Anti.Kill and Anti.Kill.enabled) then
        pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
    end
    if LP.Character then
        pcall(function() recoverCharacterState(LP.Character, nil) end)
    end
end

hookTargetRespawn = function(targetPlr)
    if not targetPlr then return end
    if targetPlr:FindFirstChild("__KhamanDhoklaHook") then return end
    local marker = Instance.new("BoolValue")
    marker.Name = "__KhamanDhoklaHook"
    marker.Parent = targetPlr
    targetPlr.CharacterAdded:Connect(function(newChar)
        if not AutoReweldEnabled or not WeldIntent.active then return end
        if WeldIntent.target ~= targetPlr and LastWeldTargetUserId ~= targetPlr.UserId then return end
        -- Zero-delay respawn lock: wait only until a root/base part exists on the new character!
        local t0 = tick()
        while tick() - t0 < 2.0 and newChar.Parent and not pickTargetRef(newChar, "torso") do
            RunService.Heartbeat:Wait()
        end
        if not WeldIntent.active or targetPlr.Parent ~= Players then return end
        if CurrentWeld then
            pcall(function() CurrentWeld:Destroy(true) end)
            CurrentWeld = nil
        end
        local key = WeldIntent.presetKey or LastPresetKey
        if key and WELD_PRESETS[key] then
            applyWeldPreset(key, targetPlr)
            if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
        end
    end)
end

-- Local Character Respawn Hook: automatically re-attaches if local player respawns while WeldIntent is active
LP.CharacterAdded:Connect(function(newMyChar)
    if not AutoReweldEnabled or not WeldIntent.active then return end
    local t0 = tick()
    while tick() - t0 < 2.5 and newMyChar.Parent and not getRootPart(newMyChar) do
        RunService.Heartbeat:Wait()
    end
    if not WeldIntent.active then return end
    local tgt = WeldIntent.target
    local key = WeldIntent.presetKey or LastPresetKey
    if tgt and tgt.Parent == Players and key and WELD_PRESETS[key] then
        if CurrentWeld then
            pcall(function() CurrentWeld:Destroy(true) end)
            CurrentWeld = nil
        end
        applyWeldPreset(key, tgt)
        if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    end
end)

-- Zero-Delay Heartbeat Omnipresent Watchdog:
-- Instantly re-locks as soon as a target streams in or finishes respawning (never freezes local player while target is dead)!
local reweldWatchdogBusy = false
local lastWatchdogAttempt = 0
RunService.Heartbeat:Connect(function()
    if not AutoReweldEnabled or not WeldIntent.active or not WeldIntent.presetKey or FlingActive or reweldWatchdogBusy then
        return
    end
    local tgt = WeldIntent.target
    if not tgt or tgt.Parent ~= Players then
        stopWeld()
        if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
        return
    end
    if not CurrentWeld or CurrentWeld.destroyed then
        local now = tick()
        if now - lastWatchdogAttempt < 0.20 then return end
        local tCharCheck = findPlayerCharacterAnywhere(tgt)
        local tHumCheck  = tCharCheck and tCharCheck:FindFirstChildOfClass("Humanoid")
        -- If target is currently dead and waiting to respawn, keep local player completely free & unfrozen!
        if tHumCheck and tHumCheck.Health <= 0 then
            return
        end
        local myChar = LP.Character
        local myRoot = getRootPart(myChar)
        local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
        if myRoot and myHum and myHum.Health > 0 then
            lastWatchdogAttempt = now
            reweldWatchdogBusy = true
            task.spawn(function()
                pcall(function()
                    local preset = WELD_PRESETS[WeldIntent.presetKey]
                    local refMode = preset and preset.refMode or "torso"
                    local tChar, tRef = streamAndTeleportToTarget(tgt, refMode, 1.0, false)
                    local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
                    if WeldIntent.active and (not CurrentWeld or CurrentWeld.destroyed) and tRef and tRef.Parent and (not tHum or tHum.Health > 0) then
                        if not isLethalVoidCF(tRef.CFrame, tRef.AssemblyLinearVelocity) then
                            applyWeldPreset(WeldIntent.presetKey, tgt)
                            if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
                        end
                    end
                end)
                reweldWatchdogBusy = false
            end)
        end
    end
end)
end -- end Zero-Delay WeldTo, Seeker & Watchdog scope

-- ═══════════════════════════════════════════════════════════════════════════════
-- HIGH-PRECISION 6s–10s CHRONO-REWIND ENGINE (60Hz Frame-Exact State, Anim & Action Recorder)
-- ═══════════════════════════════════════════════════════════════════════════════
RewindSys = {
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
        f.Name = "KhamanRewindHUD"
        f.Size = UDim2.new(0, 276, 0, 44)
        f.Position = UDim2.new(0.5, -138, 0, 56)
        f.BackgroundColor3 = T.BG2
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
            for _, part in ipairs(getCachedCharParts(char)) do
                if part.Parent then
                    part.Massless = false
                    if not (moveState and moveState.noclip) and (part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head") then
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
        if not (Anti and (Anti.AlwaysOnCore or (Anti.Void and Anti.Void.enabled) or (Anti.InfFallVoid and Anti.InfFallVoid.enabled) or (Anti.Kill and Anti.Kill.enabled))) and not WeldIntent.active and not FlingActive then
            pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
        end
        if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    end

    function RewindSys:Start(customSeconds)
        if self.rewinding then
            -- Tapping Rewind while rewinding stops immediately at the exact current point in time!
            self:Stop(nil)
            notify("KHAMAN DHOKLA", "⏹️ Rewind locked at current point!")
            sToggleOff()
            return
        end

        local targetSec = math.clamp(tonumber(customSeconds) or self.duration or 8.0, 1.0, 10.0)
        local buf = self.buffer
        if #buf < 2 then
            notify("KHAMAN DHOKLA", "Rewind buffer warming up — move around for a moment!")
            sError()
            return
        end

        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if not char or not root or not hum or hum.Health <= 0 then
            notify("KHAMAN DHOKLA", "Character not ready to rewind!")
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
            notify("KHAMAN DHOKLA", string.format("⏪ Instant Rewind (-%.1fs) complete!", actualSpan))
            sSuccess()
            return
        end

        -- Smooth Frame-Accurate Reverse Replay Mode (60Hz interpolated reverse timeline)
        local hud = ensureRewindHUD()
        if hud then hud.Visible = true end
        killAnimate(char)

        notify("KHAMAN DHOKLA", string.format("⏪ Rewinding %.1f seconds with exact precision...", actualSpan))

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
                for _, p in ipairs(getCachedCharParts(char)) do
                    if p.Parent and p.CanCollide then
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
                notify("KHAMAN DHOKLA", string.format("✨ Rewound -%.1fs with exact precision!", actualSpan))
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
    for _, part in ipairs(getCachedCharParts(char)) do
        if part.Parent then
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
    local isUnlimited = (durationSeconds == nil or durationSeconds <= 0)
    local targetPlr, usedNearest
    if explicitTarget and explicitTarget.Parent == Players then
        targetPlr, usedNearest = explicitTarget, false
    else
        targetPlr, usedNearest = resolveActiveTarget()
    end
    if not targetPlr or targetPlr.Parent ~= Players then
        notify("KHAMAN DHOKLA", "No target player found in server!")
        sError()
        return
    end
    local myChar = LP.Character
    local myRoot = getRootPart(myChar)
    local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not myRoot then
        notify("KHAMAN DHOKLA", "Local character not ready!")
        sError()
        return
    end

    -- Save origin BEFORE streaming/teleporting to a hidden target so we always return to our original spot!
    local preSeekOriginCF = isSafePlayableCF(myRoot.CFrame) and myRoot.CFrame or findFallbackSafeCF()
    -- 0.00s ZERO-DELAY FAST PATH: If target is already streamed in, lock on Frame 0 without yielding!
    local tChar = findPlayerCharacterAnywhere(targetPlr)
    local targetHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
    local targetRoot = tChar and pickTargetRef(tChar, "torso")
    if not targetRoot or not targetRoot.Parent then
        tChar, targetRoot = streamAndTeleportToTarget(targetPlr, "torso", 2.2)
        targetHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
    else
        breakLocalSeatAndTrapWelds(myChar)
    end
    if not isUnlimited and (not targetRoot or not targetRoot.Parent) then
        notify("KHAMAN DHOKLA", "Could not stream target — try again!")
        sError()
        return
    end

    local origCF = preSeekOriginCF
    LastKnownSafeCF = origCF

    StateManager:Cleanup(true, true)
    CurrentTarget = targetPlr
    FlingActive = true
    FlingOriginCF = origCF

    -- Lock camera on target when available so our screen stays stable while slamming them
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
    if myChar then killAnimate(myChar) end

    if FlingSidePanel then
        FlingSidePanel.Visible = true
        if FlingCountdownLabel then
            FlingCountdownLabel.Text = isUnlimited
                and "♾️ UNLIMITED FLING (Tap STOP to end)"
                or (tostring(math.ceil(durationSeconds)) .. "s remaining")
        end
    end

    sFling()
    local prefix = isVoidThrow and "Void Throw v2 (" or (usedNearest and "Auto-Nearest Fling (" or "Nebula Fling (")
    notify("KHAMAN DHOKLA", prefix .. tostring(modeTitle) .. ") -> " .. targetPlr.Name)

    local startTime = tick()
    local phaseCounter = 0
    local nextTargetCFrame = (targetRoot and targetRoot.Parent and targetRoot.CFrame) or origCF
    local nextLinearVel = Vector3.new(0, -150000, 0)
    local nextAngularVel = Vector3.new(120000, 120000, 120000)
    local waitingForRespawn = false
    local lastStreamSeekTick = 0

    -- ZERO-DELAY FRAME-0 WELD & LOCK FOR NEBULA FLING / VOID THROW:
    if targetRoot and targetRoot.Parent and myRoot and myRoot.Parent then
        pcall(function() LP.ReplicationFocus = targetRoot end)
        if sethiddenproperty then
            pcall(function()
                sethiddenproperty(myRoot, "PhysicsRepRootPart", targetRoot)
                if InstanceHandleNew then
                    sethiddenproperty(myRoot, "PhysicsRepRootRef", InstanceHandleNew(targetRoot))
                end
            end)
        end
        restorePartCollisionAndDensity(myChar, true)
        if tChar and tChar.Parent then
            restorePartCollisionAndDensity(tChar, false)
        end
        markIntentionalTeleport(nextTargetCFrame)
        myRoot.CFrame = nextTargetCFrame
        myRoot.AssemblyLinearVelocity = nextLinearVel
        myRoot.AssemblyAngularVelocity = nextAngularVel
    end

    local function finishVoidThrow(msg, playSuccess)
        StateManager:StopFling(false)
        if msg then notify("KHAMAN DHOKLA", msg) end
        if playSuccess then sSuccess() end
    end

    -- Pre-Simulation (RunService.Stepped): Enforce collision & 100-density mass on our torso/root
    -- AND target's character + zero-delay PhysicsRepRootPart weld right before Roblox's internal physics step!
    StateManager.FlingStepConn = RunService.Stepped:Connect(function()
        if not FlingActive then
            if StateManager.FlingStepConn then StateManager.FlingStepConn:Disconnect(); StateManager.FlingStepConn = nil end
            return
        end
        myChar = LP.Character
        myRoot = getRootPart(myChar)
        myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
        if not myChar or not myRoot then return end

        pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
        if waitingForRespawn then
            -- While waiting for target respawn in Unlimited mode, clear PhysicsRepRootPart and hold safely at origCF with 0 velocity
            if sethiddenproperty then
                pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", nil) end)
                pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootRef", nil) end)
            end
            myRoot.CFrame = origCF
            myRoot.AssemblyLinearVelocity = Vector3.zero
            myRoot.AssemblyAngularVelocity = Vector3.zero
            return
        end

        if targetRoot and targetRoot.Parent and sethiddenproperty then
            pcall(function()
                sethiddenproperty(myRoot, "PhysicsRepRootPart", targetRoot)
                if InstanceHandleNew then
                    sethiddenproperty(myRoot, "PhysicsRepRootRef", InstanceHandleNew(targetRoot))
                end
            end)
        end

        restorePartCollisionAndDensity(myChar, true)
        if tChar and tChar.Parent then
            restorePartCollisionAndDensity(tChar, false)
        end
        if myHum then
            pcall(function()
                if myHum.Sit then myHum.Sit = false end
                if not myHum.PlatformStand then myHum.PlatformStand = true end
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
        if not FlingActive then
            finishVoidThrow(nil, false)
            return
        end

        -- Keep local character references fresh across local respawns in Unlimited mode!
        myChar = LP.Character
        myRoot = getRootPart(myChar)
        myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
        if not myChar or not myRoot or (myHum and myHum.Health <= 0) then
            if isUnlimited then
                return -- Wait for local respawn and continue Unlimited Fling automatically!
            else
                finishVoidThrow("Local character reset — fling stopped.", false)
                return
            end
        end

        -- Check if target left the server
        if not targetPlr or targetPlr.Parent ~= Players then
            if isUnlimited and usedNearest then
                local nextNearest = getNearestPlayer(LP)
                if nextNearest and nextNearest.Parent == Players then
                    targetPlr = nextNearest
                    CurrentTarget = targetPlr
                    tChar = nil
                    targetRoot = nil
                else
                    waitingForRespawn = true
                    if FlingCountdownLabel then FlingCountdownLabel.Text = "♾️ UNLIMITED (Waiting for players...)" end
                    return
                end
            else
                finishVoidThrow("✨ Target left server — safely returned!", true)
                return
            end
        end

        -- Dynamically re-acquire target character/root
        local latestChar = findPlayerCharacterAnywhere(targetPlr)
        if latestChar ~= tChar or not targetRoot or not targetRoot.Parent then
            tChar = latestChar
            targetHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
            targetRoot = tChar and pickTargetRef(tChar, "torso")
        end

        local targetDead = (targetHum and targetHum.Parent and targetHum.Health <= 0)
        local targetConfirmedInVoid = false
        if targetRoot and targetRoot.Parent then
            local tPos = targetRoot.Position
            local tVel = targetRoot.AssemblyLinearVelocity
            local lethalVoidFloor = math.min(OriginalFPDH + 14, -245)
            targetConfirmedInVoid = (tPos.Y <= lethalVoidFloor)
                or (tPos.Y <= -190 and tVel.Y < -85)
                or (tPos.Magnitude > 28000)
        end

        -- Handle target eliminated / unstreamed / respawning:
        if not targetRoot or not targetRoot.Parent or targetDead or targetConfirmedInVoid then
            if not isUnlimited then
                -- Timed modes (4s, 8s, 5.5s Void Throw): finish once target is confirmed dead or deep in void
                if targetDead then
                    finishVoidThrow("💀 " .. targetPlr.Name .. " died in the Void! Safely returned.", true)
                    return
                elseif targetConfirmedInVoid and targetRoot then
                    local tPos = targetRoot.Position
                    local sinkCF = CFrame.new(tPos.X, math.clamp(OriginalFPDH - 180, -850, -380), tPos.Z)
                    myRoot.CFrame = sinkCF
                    myRoot.AssemblyLinearVelocity = Vector3.new(0, -180000, 0)
                    finishVoidThrow("🎯 " .. targetPlr.Name .. " trapped in Void & eliminated! Safely returned.", true)
                    return
                else
                    local hiddenCF = getBestTargetCFrame(targetPlr)
                    if hiddenCF and isLethalVoidCF(hiddenCF) then
                        finishVoidThrow("🎯 " .. targetPlr.Name .. " destroyed in the Void! Safely returned.", true)
                        return
                    end
                    return
                end
            else
                -- TRUE UNLIMITED MODE: NEVER stop!
                -- If in Auto-Nearest mode, check if another alive player is nearby to chain-fling while this one respawns
                if usedNearest then
                    local altPlr = getNearestPlayer(LP)
                    if altPlr and altPlr ~= targetPlr and altPlr.Parent == Players then
                        local altChar = findPlayerCharacterAnywhere(altPlr)
                        local altHum  = altChar and altChar:FindFirstChildOfClass("Humanoid")
                        local altRoot = altChar and pickTargetRef(altChar, "torso")
                        if altRoot and (not altHum or altHum.Health > 0) and not isLethalVoidCF(altRoot.CFrame, altRoot.AssemblyLinearVelocity) then
                            targetPlr = altPlr
                            CurrentTarget = altPlr
                            tChar = altChar
                            targetHum = altHum
                            targetRoot = altRoot
                            waitingForRespawn = false
                        end
                    end
                end

                -- If target is still dead/in-void/unstreamed, park safely at origCF and wait for their respawn!
                if not targetRoot or not targetRoot.Parent or targetDead or targetConfirmedInVoid then
                    waitingForRespawn = true
                    if sethiddenproperty then
                        pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", nil) end)
                        pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootRef", nil) end)
                    end
                    markIntentionalTeleport(origCF)
                    myRoot.CFrame = origCF
                    myRoot.AssemblyLinearVelocity = Vector3.zero
                    myRoot.AssemblyAngularVelocity = Vector3.zero
                    if FlingCountdownLabel then
                        FlingCountdownLabel.Text = "♾️ UNLIMITED (Waiting " .. targetPlr.Name .. " respawn)"
                    end
                    -- Try streaming around target's known CFrame every 0.6s in case they respawned far away
                    local now = tick()
                    if not targetDead and (now - lastStreamSeekTick) > 0.6 then
                        lastStreamSeekTick = now
                        local knownCF = getBestTargetCFrame(targetPlr)
                        if knownCF and not isLethalVoidCF(knownCF) then
                            task.spawn(function()
                                pcall(function() LP:RequestStreamAroundAsync(knownCF.Position, 1) end)
                            end)
                        end
                    end
                    return
                end
            end
        end

        -- Target is alive and ready: resume full-power fling!
        if waitingForRespawn then
            waitingForRespawn = false
            killAnimate(myChar)
            if currentCam and targetHum and not SpectatingTarget then
                pcall(function() currentCam.CameraSubject = targetHum end)
            end
        end

        local elapsed = tick() - startTime
        if not isUnlimited then
            local remaining = math.max(0, durationSeconds - elapsed)
            if FlingCountdownLabel then
                FlingCountdownLabel.Text = "⏳ " .. string.format("%.1f", remaining) .. "s left"
            end
            if remaining <= 0 then
                finishVoidThrow("✨ " .. tostring(modeTitle) .. " finished & safely returned!", true)
                return
            end
        else
            if FlingCountdownLabel then
                FlingCountdownLabel.Text = string.format("♾️ UNLIMITED · %.0fs (%s)", elapsed, targetPlr.Name:sub(1, 10))
            end
        end

        -- Focus stream on target and bind PhysicsRepRootPart for zero-delay network-sync weld & drag (from oyee hoye.lua)
        pcall(function() LP.ReplicationFocus = targetRoot end)
        if sethiddenproperty then
            pcall(function()
                sethiddenproperty(myRoot, "PhysicsRepRootPart", targetRoot)
                if InstanceHandleNew then
                    sethiddenproperty(myRoot, "PhysicsRepRootRef", InstanceHandleNew(targetRoot))
                end
            end)
        end

        local tPos = targetRoot.Position
        local tVel = targetRoot.AssemblyLinearVelocity
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
                -- STAGE 3: DEEP-VOID SINKHOLE DRAG
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
        notify("KHAMAN DHOKLA", "No target or nearby player found!")
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

    makeOptBtn(58, "♾️ Unlimited Nebula Fling (Non-Stop Till Stopped)", T.Accent2, function()
        launchNebulaFling(-1, "Unlimited Non-Stop", false, targetPlr)
    end)
    makeOptBtn(96, "🕳️ Unlimited Void Lock (Trap & Re-Fling Non-Stop)", Color3.fromRGB(185, 45, 95), function()
        launchNebulaFling(-1, "Unlimited Void Lock", true, targetPlr)
    end)
    makeOptBtn(134, "⚡ Void Throw v2 (5.5s Bury + Catapult + Sinkhole)", Color3.fromRGB(145, 95, 18), function()
        launchVoidThrow(targetPlr, 5.5)
    end)
    makeOptBtn(172, "🌪️ 4 Seconds (High-Density Vortex Blast)", Color3.fromRGB(76, 79, 87), function()
        launchNebulaFling(4.0, "4 Seconds", false, targetPlr)
    end)
    makeOptBtn(210, "☄️ 8 Seconds (Extreme Omni-Vortex)", Color3.fromRGB(104, 108, 117), function()
        launchNebulaFling(8.0, "8 Seconds", false, targetPlr)
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

local csOn, csMode, csTgt, csMsg, csCnt, csMtd, csGen, bld, snd2 = false, "roast", "", "", 0, "-", 0, nil, nil
do
local CS_D = 5
local CS_M = 200
local CS_R = " TMKX MAI "
local CS_HDR = "KHAMAN DHOKLA ON TOP"
local CS_W = {"NOOB","ROOKIE","AMATEUR","TRAINEE","BEGINNER","SLOWPOKE","SLEEPY","CLUMSY","DORK","NERD","GEEK","DWEEB","SQUISHY","WOBBLY","FUZZY","SPARKLY","GIGGLY","WIGGLY","SNAIL","TURTLE","PANDA","SLOTH","MOOSE","HAMSTER","PUPPY","KITTEN","DUCKLING","PENGUIN","NARWHAL","PLATYPUS","CAPYBARA","ALPACA","RACCOON","SQUIRREL","OTTER","BEAVER","HEDGEHOG","MEERKAT","FERRET","BUNNY","CHIPMUNK","PUFFIN","TOUCAN","FLAMINGO","MANATEE","WALRUS","PELICAN","SEAGULL","PIGEON","SPARROW","ROBIN","FINCH","WREN","MAGPIE","CROW","RAVEN","STARLING","SWALLOW","MARTIN","SWIFT","DOVE","QUAIL","PHEASANT","TURKEY","DUCK","CHICKEN","ROOSTER","PARROT","MACAW","COCKATOO","BUDGIE","CANARY"}
local CS_E = {"🔥","😂","💀","🗿","😭","😎","🤡","👻","👀","💯","🚨","🎯","⚡","🌊","🎪","🧠","🤖","🥶","😈","🤣","💥","✨","🙏","👑"}
local CS_SYM = "@"
local CS_REPEAT = 120

local csCh = nil
local csLg = nil

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
snd2 = function(tx)
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
bld = function()
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
end -- end Chat Spammer internal scope

-- Shared movement state hoisted above RewindSys & WeldTo

local syncAllAntiButtons = nil

Anti = {
    AlwaysOnCore = true, -- Keeps Anti-Sit, Anti-Void, Anti-Lag, and Anti-Freeze enabled 24/7 at all times!
    Void         = { enabled = false, alwaysOn = true, charAdded = nil, healthConns = {}, charConns = {}, loopConn = nil, steppedConn = nil, safetyFloor = nil, rescues = 0, startFn = nil, stopFn = nil },
    InfFallVoid  = { enabled = false, alwaysOn = true, steppedConn = nil, startFn = nil, stopFn = nil },
    Lag          = { enabled = false, alwaysOn = true, wsDescConn = nil, loopConn = nil, purgedItems = 0, throttledEmitters = setmetatable({}, {__mode = "k"}), startFn = nil, stopFn = nil },
    Kill         = { enabled = false, charAdded = nil, descConn = nil, loopConn = nil, wsDescConn = nil, blockedTouches = 0, originalPartFlags = setmetatable({}, {__mode = "k"}), startFn = nil, stopFn = nil },
    GamePaused   = { enabled = false, alwaysOn = true, childAdded = nil, propConn = nil, loopConn = nil, startFn = nil, stopFn = nil },
    AFK          = { enabled = false, conn = nil, loopConn = nil, startFn = nil, stopFn = nil },
    VC           = {
        enabled = false,
        running = false,
        userMuted = false,
        hookInstalled = false,
        blockedMutes = 0,
        rejoins = 0,
        watchdogConn = nil,
        stateConn = nil,
        statusText = "Status: Idle",
        statusLbl = nil,
        activateBtn = nil,
        forceBtn = nil,
        micToggleBtn = nil,
        rejoinBtn = nil,
        rowSubLbl = nil,
        inlineMicBtn = nil,
        openPanelFn = nil,
        startFn = nil,
        stopFn = nil,
        forceBypassFn = nil,
        toggleMicFn = nil,
        rejoinFn = nil,
    },
    Redirect     = { enabled = false, startFn = nil, stopFn = nil },
    PauseTrap    = { enabled = false, startFn = nil, stopFn = nil },
    FlingShield  = { enabled = false, steppedConn = nil, heartbeatConn = nil, plrAddedConn = nil, preStepCF = nil, blockedFlings = 0, startFn = nil, stopFn = nil },
    -- FULL LIBRARY MULTI-LAYER ANTI-SYSTEMS V4:
    Ragdoll      = { enabled = false, alwaysOn = true, steppedConn = nil, stateConn = nil, descConn = nil, charAdded = nil, recoveries = 0, lastDeepCleanse = 0, startFn = nil, stopFn = nil },
    Anchor       = { enabled = false, alwaysOn = true, steppedConn = nil, descConn = nil, charAdded = nil, partConns = setmetatable({}, {__mode = "k"}), purgedMovers = 0, lastMoverSweep = 0, startFn = nil, stopFn = nil },
    Attach       = { enabled = false, steppedConn = nil, descConn = nil, severedCount = 0, startFn = nil, stopFn = nil },
    Blind        = { enabled = false, loopConn = nil, lightChildConn = nil, camChildConn = nil, guiChildConn = nil, startFn = nil, stopFn = nil },
    Bring        = { enabled = false, steppedConn = nil, heartbeatConn = nil, lastCF = nil, lastSafeTime = 0, blockedBrings = 0, startFn = nil, stopFn = nil },
    SeatTrap     = { enabled = false, alwaysOn = true, wsDescConn = nil, loopConn = nil, savedSeats = setmetatable({}, {__mode = "k"}), neutralizedSeats = 0, startFn = nil, stopFn = nil },
    ToolGuard    = { enabled = false, loopConn = nil, disarmedTools = 0, startFn = nil, stopFn = nil },
    AntiHeadsit  = { enabled = false, steppedConn = nil, evadedCount = 0, lastEvade = 0, startFn = nil, stopFn = nil },
    GlitchDesync = { enabled = false, mode = "Normal", steppedConn = nil, heartbeatConn = nil, realCF = nil, realVel = Vector3.zero, realRot = Vector3.zero, startFn = nil, stopFn = nil },
    Kick         = { enabled = false, hooked = false, originalKick = nil, blockedKicks = 0, startFn = nil, stopFn = nil },
    enableAll    = nil,
    disableAll   = nil,
    enforceAlwaysOn = nil,
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
    startFn = nil,
    stopFn = nil,
}

-- Helper: Mark an intentional local teleport so Anti-Bring, Anti-FlingShield, and DefenceTroll never fight our own teleports/welds
markIntentionalTeleport = function(cf)
    moveState.lastTeleportTick = tick()
    if cf then
        Anti.Bring.lastCF = cf
        Anti.Bring.lastSafeTime = tick()
        Anti.FlingShield.preStepCF = cf
        if Anti.GlitchDesync and Anti.GlitchDesync.enabled then
            Anti.GlitchDesync.realCF = cf
        end
        LastKnownSafeCF = cf
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════
;(function() -- Isolated function frame for internal Anti helper functions (preserves top-level local register budget)
local avStart, avStop, akStart, akStop, agpStart, agpStop, afkStart, afkStop, vcStart, vcStop
local ragdollStart, ragdollStop, anchorStart, anchorStop, attachStart, attachStop, blindStart, blindStop
local bringStart, bringStop, flingShieldStart, flingShieldStop, redirectStart, redirectStop, pauseTrapStart, pauseTrapStop
local defenceTrollStart, defenceTrollStop, lagStart, lagStop, enableAllAntiSystems, disableAllAntiSystems

-- 1. ALWAYS-ON ANTI-VOID V4 + INFINITE FALL VOID (2048x2048 ForceField Floor + Predictive Catch + Death Block)
-- ═══════════════════════════════════════════════════════════════════════════════
local function avEnsureSafetyFloor(pos, customY)
    local floor = Anti.Void.safetyFloor
    if not floor or not floor.Parent then
        floor = Instance.new("Part")
        floor.Name = "KhamanVoidSafetyFloor"
        floor.Anchored = true
        floor.CanCollide = true
        floor.CanTouch = false
        floor.CanQuery = false
        floor.Locked = true
        floor.Size = Vector3.new(2048, 2, 2048)
        floor.Transparency = 0.72
        floor.Material = Enum.Material.ForceField
        floor.Color = Color3.fromRGB(250, 204, 21)
        floor.Parent = workspace
        Anti.Void.safetyFloor = floor
    end
    floor.CFrame = CFrame.new(pos.X, customY or (pos.Y - 3.5), pos.Z)
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
        h:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        if h.MaxHealth <= 0 then h.MaxHealth = 100 end
        if h.Health <= 0 or h.Health < h.MaxHealth then h.Health = h.MaxHealth end
        if not isActivelyWeldedOrFlinging() and not (moveState and moveState.fly) then
            if h.PlatformStand then h.PlatformStand = false end
            if h.Sit then h.Sit = false end
        end
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

avStart = function(silent)
    if Anti.Void.enabled and Anti.Void.steppedConn and Anti.Void.loopConn then return end
    Anti.Void.enabled = true
    pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
    avHookChar(LP.Character)
    if Anti.Void.charAdded then Anti.Void.charAdded:Disconnect() end
    Anti.Void.charAdded = LP.CharacterAdded:Connect(function(c)
        if not Anti.Void.enabled then return end
        task.wait(0.1)
        avHookChar(c)
        pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
    end)
    if Anti.Void.steppedConn then Anti.Void.steppedConn:Disconnect() end
    Anti.Void.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.Void.enabled then return end
        if workspace.FallenPartsDestroyHeight == workspace.FallenPartsDestroyHeight then
            pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
        end
        local c = LP.Character
        local r = getRootPart(c)
        if not r or isActivelyWeldedOrFlinging() or deflectBusy or (RewindSys and RewindSys.rewinding) then
            return
        end
        local pos = r.Position
        local vel = r.AssemblyLinearVelocity
        local dangerFloor = math.max(OriginalFPDH + 55, -180)
        local predictedY = pos.Y + (vel.Y * 0.055)
        if pos.Y <= dangerFloor or predictedY <= dangerFloor or (pos.Y <= (dangerFloor + 45) and vel.Y < -95) or pos.Magnitude > 45000 then
            r.AssemblyLinearVelocity = Vector3.new(vel.X * 0.05, math.max(0, vel.Y), vel.Z * 0.05)
            r.AssemblyAngularVelocity = Vector3.zero
            avEnsureSafetyFloor(pos, math.max(pos.Y - 3.5, dangerFloor + 12))
            Anti.Void.rescues = Anti.Void.rescues + 1
            markIntentionalTeleport(LastKnownSafeCF)
            safeReturnFromVoid(c, LastKnownSafeCF)
        elseif Anti.Void.safetyFloor and pos.Y > -15 and math.abs(vel.Y) < 25 then
            avRemoveSafetyFloor()
        end
    end)
    if Anti.Void.loopConn then Anti.Void.loopConn:Disconnect() end
    local lastHealthGuard = 0
    Anti.Void.loopConn = RunService.Heartbeat:Connect(function()
        if not Anti.Void.enabled then return end
        local now = tick()
        if now - lastHealthGuard < 0.35 then return end
        lastHealthGuard = now
        local c = LP.Character
        if not c then return end
        local h = c:FindFirstChildOfClass("Humanoid")
        if h and h.Health < h.MaxHealth then avForceAlive(h) end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if not silent then
        notify("KHAMAN DHOKLA", "Anti-Void v4 (Always-On 2048x2048 Floor + Catch) ACTIVE")
        sToggleOn()
    end
end

avStop = function()
    if Anti.AlwaysOnCore or Anti.Void.alwaysOn then
        avStart(true)
        if syncAllAntiButtons then pcall(syncAllAntiButtons) end
        notify("KHAMAN DHOKLA", "🔒 Anti-Void is locked ALWAYS-ON for permanent protection!")
        return
    end
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
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
end
Anti.Void.startFn = avStart
Anti.Void.stopFn  = avStop

-- Infinite Fall Void (Always-On FallenPartsDestroyHeight = NaN lock)
Anti.InfFallVoid.startFn = function(silent)
    if Anti.InfFallVoid.enabled then return end
    Anti.InfFallVoid.enabled = true
    pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if not silent then
        notify("KHAMAN DHOKLA", "Infinite Fall Void ON (FallenPartsDestroyHeight = NaN)")
        sToggleOn()
    end
end

Anti.InfFallVoid.stopFn = function()
    if Anti.AlwaysOnCore or Anti.InfFallVoid.alwaysOn then
        Anti.InfFallVoid.startFn(true)
        if syncAllAntiButtons then pcall(syncAllAntiButtons) end
        notify("KHAMAN DHOKLA", "🔒 Infinite Fall Void is locked ALWAYS-ON!")
        return
    end
    Anti.InfFallVoid.enabled = false
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 1B. ALWAYS-ON ANTI-LAG & ANTI-CRASH ENGINE V4 (Zero-Overhead Event + Throttled Purger)
-- ═══════════════════════════════════════════════════════════════════════════════
local LAG_EFFECT_CLASSES = {
    ParticleEmitter = true,
    Trail = true,
    Beam = true,
    Smoke = true,
    Fire = true,
    Sparkles = true,
}

local function sanitizeLagInstance(obj)
    if not obj or not obj.Parent then return end
    if gui and obj:IsDescendantOf(gui) then return end
    local cls = obj.ClassName
    if LAG_EFFECT_CLASSES[cls] then
        local myChar = LP.Character
        if not (myChar and obj:IsDescendantOf(myChar)) then
            pcall(function()
                if obj.Enabled then
                    obj.Enabled = false
                    Anti.Lag.throttledEmitters[obj] = true
                    Anti.Lag.purgedItems = (Anti.Lag.purgedItems or 0) + 1
                end
                if cls == "ParticleEmitter" and obj.Rate > 12 then
                    obj.Rate = 0
                end
            end)
        end
    elseif cls == "Explosion" then
        pcall(function()
            obj.BlastPressure = 0
            obj.BlastRadius = 0
            obj.DestroyJointRadiusPercent = 0
            obj.Visible = false
            Anti.Lag.purgedItems = (Anti.Lag.purgedItems or 0) + 1
        end)
    elseif cls == "PointLight" or cls == "SurfaceLight" or cls == "SpotLight" then
        pcall(function()
            if obj.Shadows then obj.Shadows = false end
        end)
    elseif obj:IsA("BasePart") then
        local p = obj.Parent
        if p and (p:IsA("Tool") or p:IsA("Accessory") or p:IsA("Hat")) and p.Parent == workspace then
            pcall(function()
                if obj.CanTouch then obj.CanTouch = false end
                if obj.CanCollide then obj.CanCollide = false end
                obj.Massless = true
                Anti.Lag.purgedItems = (Anti.Lag.purgedItems or 0) + 1
            end)
        end
    end
end

lagStart = function(silent)
    if Anti.Lag.enabled and Anti.Lag.wsDescConn and Anti.Lag.loopConn then return end
    Anti.Lag.enabled = true
    pcall(function()
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = false
    end)
    if Anti.Lag.wsDescConn then Anti.Lag.wsDescConn:Disconnect() end
    Anti.Lag.wsDescConn = workspace.DescendantAdded:Connect(function(obj)
        if not Anti.Lag.enabled then return end
        sanitizeLagInstance(obj)
    end)
    if Anti.Lag.loopConn then Anti.Lag.loopConn:Disconnect() end
    local lastLagSweep = 0
    Anti.Lag.loopConn = RunService.Heartbeat:Connect(function()
        if not Anti.Lag.enabled then return end
        local now = tick()
        if now - lastLagSweep < 2.5 then return end
        lastLagSweep = now
        local rootSoundCount = 0
        for _, child in ipairs(workspace:GetChildren()) do
            if child:IsA("Tool") or child:IsA("Accessory") or child:IsA("Hat") then
                for _, d in ipairs(child:GetDescendants()) do
                    if d:IsA("BasePart") then
                        if d.CanTouch then d.CanTouch = false end
                        if d.CanCollide then d.CanCollide = false end
                    elseif LAG_EFFECT_CLASSES[d.ClassName] and d.Enabled then
                        d.Enabled = false
                    end
                end
            elseif child:IsA("Sound") and child.IsPlaying then
                rootSoundCount = rootSoundCount + 1
                if rootSoundCount > 16 then
                    pcall(function() child:Stop() end)
                    Anti.Lag.purgedItems = (Anti.Lag.purgedItems or 0) + 1
                end
            end
        end
        for uid, _ in pairs(PlayerLocationCache) do
            if not Players:GetPlayerByUserId(uid) then
                PlayerLocationCache[uid] = nil
            end
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if not silent then
        notify("KHAMAN DHOKLA", "Anti-Lag v4 (Always-On Particle/Clone-Bomb Purger) ACTIVE")
        sToggleOn()
    end
end

lagStop = function()
    if Anti.AlwaysOnCore or Anti.Lag.alwaysOn then
        lagStart(true)
        if syncAllAntiButtons then pcall(syncAllAntiButtons) end
        notify("KHAMAN DHOKLA", "🔒 Anti-Lag is locked ALWAYS-ON for max FPS & crash protection!")
        return
    end
    if not Anti.Lag.enabled then return end
    Anti.Lag.enabled = false
    if Anti.Lag.wsDescConn then Anti.Lag.wsDescConn:Disconnect(); Anti.Lag.wsDescConn = nil end
    if Anti.Lag.loopConn then Anti.Lag.loopConn:Disconnect(); Anti.Lag.loopConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
end
Anti.Lag.startFn = lagStart
Anti.Lag.stopFn  = lagStop

-- ═══════════════════════════════════════════════════════════════════════════════
-- 2. ADVANCED ANTI-KILL / FULL GOD-MODE SHIELD V3 (Touch/Query Shield + ForceField + Explosion Immunity)
-- ═══════════════════════════════════════════════════════════════════════════════
local function akSanitizePart(p)
    if not (p and p:IsA("BasePart")) then return end
    local saved = Anti.Kill.originalPartFlags[p]
    if not saved then
        saved = { CanTouch = p.CanTouch, CanQuery = p.CanQuery }
        Anti.Kill.originalPartFlags[p] = saved
    end
    pcall(function()
        if p.CanTouch then p.CanTouch = false end
        if p.CanQuery then p.CanQuery = false end
    end)
end

local function akApply(char)
    if not char then return end
    for _, p in ipairs(getCachedCharParts(char)) do
        akSanitizePart(p)
    end
    pcall(function()
        if not char:FindFirstChild("__KhamanGodForceField") then
            local ff = Instance.new("ForceField")
            ff.Name = "__KhamanGodForceField"
            ff.Visible = false
            ff.Parent = char
        end
    end)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function()
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            if hum.MaxHealth <= 0 then hum.MaxHealth = 100 end
            if hum.Health <= 0 or hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
        end)
    end
end

local function akHookCharacter(char)
    if Anti.Kill.descConn then Anti.Kill.descConn:Disconnect(); Anti.Kill.descConn = nil end
    if not char then return end
    akApply(char)
    Anti.Kill.descConn = char.DescendantAdded:Connect(function(obj)
        if Anti.Kill.enabled and obj:IsA("BasePart") then akSanitizePart(obj) end
    end)
end

akStart = function()
    if Anti.Kill.enabled then return end
    Anti.Kill.enabled = true
    pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
    akHookCharacter(LP.Character)
    if Anti.Kill.charAdded then Anti.Kill.charAdded:Disconnect() end
    Anti.Kill.charAdded = LP.CharacterAdded:Connect(function(c)
        if not Anti.Kill.enabled then return end
        task.wait(0.15)
        akHookCharacter(c)
    end)
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
        for _, p in ipairs(getCachedCharParts(c)) do
            if p.Parent then
                if p.CanTouch then p.CanTouch = false end
                if p.CanQuery then p.CanQuery = false end
            end
        end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 and hum.Health < hum.MaxHealth then
            pcall(function() hum.Health = hum.MaxHealth end)
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Kill / God-Mode v3 (Touch Shield + ForceField + Blast Immunity) ON")
    sToggleOn()
end

akStop = function()
    if not Anti.Kill.enabled then return end
    Anti.Kill.enabled = false
    if Anti.Kill.charAdded then Anti.Kill.charAdded:Disconnect(); Anti.Kill.charAdded = nil end
    if Anti.Kill.descConn then Anti.Kill.descConn:Disconnect(); Anti.Kill.descConn = nil end
    if Anti.Kill.wsDescConn then Anti.Kill.wsDescConn:Disconnect(); Anti.Kill.wsDescConn = nil end
    if Anti.Kill.loopConn then Anti.Kill.loopConn:Disconnect(); Anti.Kill.loopConn = nil end
    for part, saved in pairs(Anti.Kill.originalPartFlags) do
        if part and part.Parent then
            pcall(function()
                part.CanTouch = saved.CanTouch
                part.CanQuery = saved.CanQuery
            end)
        end
        Anti.Kill.originalPartFlags[part] = nil
    end
    local c = LP.Character
    if c then
        local ff = c:FindFirstChild("__KhamanGodForceField")
        if ff then pcall(function() ff:Destroy() end) end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum and not (Anti.Void and Anti.Void.enabled) then
            pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end)
        end
    end
    if not (Anti.AlwaysOnCore or (Anti.Void and Anti.Void.enabled) or (Anti.InfFallVoid and Anti.InfFallVoid.enabled)) and not WeldIntent.active and not FlingActive then
        pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
    end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Kill disabled & part flags restored")
    sToggleOff()
end
Anti.Kill.startFn = akStart
Anti.Kill.stopFn  = akStop

-- ═══════════════════════════════════════════════════════════════════════════════
-- 3. ALWAYS-ON ANTI-GAMEPLAYPAUSED / ANTI-NETWORKPAUSE FREEZE V4
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

agpStart = function(silent)
    if Anti.GamePaused.enabled and Anti.GamePaused.loopConn then return end
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
    if not silent then
        notify("KHAMAN DHOKLA", "Anti-GameplayPaused / Anti-Freeze v4 ACTIVE")
        sToggleOn()
    end
end

agpStop = function()
    if Anti.AlwaysOnCore or Anti.GamePaused.alwaysOn then
        agpStart(true)
        if syncAllAntiButtons then pcall(syncAllAntiButtons) end
        notify("KHAMAN DHOKLA", "🔒 Anti-GameplayPaused is locked ALWAYS-ON!")
        return
    end
    if not Anti.GamePaused.enabled then return end
    Anti.GamePaused.enabled = false
    if Anti.GamePaused.childAdded then Anti.GamePaused.childAdded:Disconnect(); Anti.GamePaused.childAdded = nil end
    if Anti.GamePaused.propConn then Anti.GamePaused.propConn:Disconnect(); Anti.GamePaused.propConn = nil end
    if Anti.GamePaused.loopConn then Anti.GamePaused.loopConn:Disconnect(); Anti.GamePaused.loopConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
end
Anti.GamePaused.startFn = agpStart
Anti.GamePaused.stopFn  = agpStop

-- ═══════════════════════════════════════════════════════════════════════════════
-- 4. ADVANCED ANTI-AFK V3 (Idled Signal + VirtualUser + VirtualInputManager)
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
    notify("KHAMAN DHOKLA", "Anti-AFK v3 (Multi-Hook) ON")
    sToggleOn()
end

afkStop = function()
    if not Anti.AFK.enabled then return end
    Anti.AFK.enabled = false
    if Anti.AFK.conn then Anti.AFK.conn:Disconnect(); Anti.AFK.conn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-AFK disabled")
    sToggleOff()
end
Anti.AFK.startFn = afkStart
Anti.AFK.stopFn  = afkStop

-- ═══════════════════════════════════════════════════════════════════════════════
-- 5. KHAMAN ANTI-VC V4 ULTRA MULTI-VECTOR VOICECHAT BYPASS
-- ═══════════════════════════════════════════════════════════════════════════════
local MUTED_MIC_IMG   = "rbxasset://textures/ui/VoiceChat/MicLight/Muted.png"
local UNMUTED_MIC_IMG = "rbxasset://textures/ui/VoiceChat/MicLight/Unmuted.png"
local vcRawPublishPause = nil

local function findMicIcon(btn)
    if not btn then return nil end
    local ok, res = pcall(function()
        local f = btn:FindFirstChild("IntegrationIconFrame", true) or btn:WaitForChild("IntegrationIconFrame", 1.5)
        local ii = f and (f:FindFirstChild("IntegrationIcon", true) or f:WaitForChild("IntegrationIcon", 1.5))
        return ii and (ii:FindFirstChild("1") or ii:FindFirstChildWhichIsA("ImageLabel"))
    end)
    if ok and res then return res end
    for _, d in ipairs(btn:GetDescendants()) do
        if d:IsA("ImageLabel") and (d.Name == "1" or d.Name:lower():find("icon", 1, true) or d.Image:lower():find("voicechat", 1, true) or d.Image:lower():find("mic", 1, true)) then
            return d
        end
    end
    return nil
end

local function locateTopBarMicButton(coreGui)
    if not coreGui then return nil, nil end
    local foundBtn = nil
    pcall(function()
        for _, v in ipairs(coreGui:GetDescendants()) do
            if v.Name == "toggle_mic_mute" then
                foundBtn = v
                break
            end
        end
        if not foundBtn then
            for _, v in ipairs(coreGui:GetDescendants()) do
                if v.Name == "IconHitArea_toggle_mic_mute" and v.Parent then
                    foundBtn = v.Parent
                    break
                end
            end
        end
    end)
    return foundBtn, (foundBtn and foundBtn.Parent or nil)
end

local function updateKhamanAntiVCVisuals(statusStr, statusCol, btnStr)
    Anti.VC.statusText = statusStr or Anti.VC.statusText
    local micLabel = Anti.VC.userMuted and "🔇 MIC: MUTED (TAP TO UNMUTE)" or "🎙️ MIC: LIVE / UNMUTED (TAP TO MUTE)"
    local micCol   = Anti.VC.userMuted and T.Danger or T.Success
    if Anti.VC.statusLbl and Anti.VC.statusLbl.Parent then
        Anti.VC.statusLbl.Text = string.format("%s  ·  Blocked Mutes: %d", statusStr or "Status: Idle", Anti.VC.blockedMutes or 0)
        if statusCol then Anti.VC.statusLbl.TextColor3 = statusCol end
    end
    if Anti.VC.activateBtn and Anti.VC.activateBtn.Parent and btnStr then
        Anti.VC.activateBtn.Text = btnStr
    end
    if Anti.VC.micToggleBtn and Anti.VC.micToggleBtn.Parent then
        Anti.VC.micToggleBtn.Text = micLabel
        Anti.VC.micToggleBtn.BackgroundColor3 = micCol
    end
    if Anti.VC.inlineMicBtn and Anti.VC.inlineMicBtn.Parent then
        Anti.VC.inlineMicBtn.Text = Anti.VC.userMuted and "🔇 MUTED" or "🎙️ LIVE"
        Anti.VC.inlineMicBtn.BackgroundColor3 = micCol
    end
    if Anti.VC.rowSubLbl and Anti.VC.rowSubLbl.Parent then
        Anti.VC.rowSubLbl.Text = string.format("%s · Guard:%d", statusStr or "Status: Idle", Anti.VC.blockedMutes or 0)
    end
end

local function getVCServices()
    local safeCloneref = (type(cloneref) == "function" and cloneref) or function(...) return ... end
    local vcs, vci = nil, nil
    pcall(function() vcs = safeCloneref(game:GetService("VoiceChatService")) end)
    pcall(function() vci = safeCloneref(game:GetService("VoiceChatInternal")) end)
    return vcs, vci
end

local function setVCPublishPaused(vci, pauseState)
    if not vci then
        local _, resolved = getVCServices()
        vci = resolved
    end
    if not vci then return false end
    local ok = pcall(function()
        if vcRawPublishPause then
            vcRawPublishPause(vci, pauseState)
        else
            vci:PublishPause(pauseState)
        end
    end)
    return ok
end

local function isVCPublishPaused(vci)
    if not vci then
        local _, resolved = getVCServices()
        vci = resolved
    end
    if not vci then return false end
    local ok, res = pcall(function() return vci:IsPublishPaused() end)
    return ok and res == true
end

local function stripVCModerationConnections(vci, vcs)
    local safeClonefunc = (type(clonefunction) == "function" and clonefunction) or function(...) return ... end
    if type(getconnections) ~= "function" then return 0 end
    local getConns = safeClonefunc(getconnections)
    local disabledCount = 0

    pcall(function()
        if vci and vci.StateChanged then
            local conns = getConns(vci.StateChanged)
            for i = 1, #conns do
                local c = conns[i]
                local shouldDisable = (i >= 7)
                if not shouldDisable and c and c.Function and debug and type(debug.getconstants) == "function" then
                    local okC, consts = pcall(debug.getconstants, c.Function)
                    if okC and type(consts) == "table" then
                        for _, val in pairs(consts) do
                            local s = tostring(val):lower()
                            if s:find("suspend", 1, true) or s:find("moderated", 1, true) or s:find("banned", 1, true) or s:find("publishpause", 1, true) then
                                shouldDisable = true
                                break
                            end
                        end
                    end
                end
                if shouldDisable and c then
                    pcall(function() c:Disable() end)
                    disabledCount = disabledCount + 1
                end
            end
        end
    end)

    for _, sigName in ipairs({ "LocalPlayerModerated", "PlayerMicActivitySignalChange", "ParticipantsStateChanged" }) do
        pcall(function()
            local sig = vci and vci[sigName]
            if sig and sigName == "LocalPlayerModerated" then
                for _, c in ipairs(getConns(sig)) do
                    pcall(function() c:Disable() end)
                    pcall(function() c:Disconnect() end)
                    disabledCount = disabledCount + 1
                end
            end
        end)
        pcall(function()
            local sig = vcs and vcs[sigName]
            if sig and sigName == "LocalPlayerModerated" then
                for _, c in ipairs(getConns(sig)) do
                    pcall(function() c:Disable() end)
                    pcall(function() c:Disconnect() end)
                    disabledCount = disabledCount + 1
                end
            end
        end)
    end
    return disabledCount
end

local function installVCPublishHook(vci)
    if Anti.VC.hookInstalled or not vci then return end
    pcall(function()
        if type(hookfunction) == "function" and type(vci.PublishPause) == "function" then
            Anti.VC.hookInstalled = true
            local origFn
            origFn = hookfunction(vci.PublishPause, function(selfArg, pauseArg, ...)
                if Anti.VC.enabled and selfArg == vci and pauseArg == true and not Anti.VC.userMuted then
                    Anti.VC.blockedMutes = (Anti.VC.blockedMutes or 0) + 1
                    return origFn(selfArg, false, ...)
                end
                return origFn(selfArg, pauseArg, ...)
            end)
            vcRawPublishPause = origFn
        end
    end)
end

local function bindCustomTopBarMicClone(coreGui, vci)
    local micBtn, micParent = locateTopBarMicButton(coreGui)
    if not micBtn or not micParent then return false end

    for _, storeName in ipairs({ "KhamanVCBypassStore", "AngoorVCBypassStore" }) do
        local oldStore = coreGui:FindFirstChild(storeName)
        if oldStore then pcall(function() oldStore:Destroy() end) end
    end
    local oldCustom = micParent:FindFirstChild("toggle_mic_mute_new")
    if oldCustom then pcall(function() oldCustom:Destroy() end) end

    local storeFolder = Instance.new("Folder")
    storeFolder.Name = "KhamanVCBypassStore"
    storeFolder.Parent = coreGui

    local newBtn = micBtn:Clone()
    micBtn.Parent = storeFolder

    newBtn.Name = "toggle_mic_mute_new"
    newBtn.Parent = micParent

    local newIcon = findMicIcon(newBtn)
    local origIcon = findMicIcon(micBtn)

    local function syncCloneIcon()
        if not newIcon then return end
        if Anti.VC.userMuted then
            newIcon.Image = MUTED_MIC_IMG
        elseif origIcon and origIcon.Image ~= "" and origIcon.Image ~= MUTED_MIC_IMG then
            newIcon.Image = origIcon.Image
        else
            newIcon.Image = UNMUTED_MIC_IMG
        end
    end
    syncCloneIcon()

    local hitArea = newBtn:FindFirstChild("IconHitArea_toggle_mic_mute", true) or newBtn:FindFirstChildWhichIsA("GuiButton", true) or newBtn
    if hitArea and hitArea:IsA("GuiButton") then
        hitArea.Activated:Connect(function()
            if Anti.VC.toggleMicFn then
                Anti.VC.toggleMicFn()
            end
            syncCloneIcon()
        end)
    end
    return true
end

local function startVCWatchdog()
    if Anti.VC.watchdogConn then Anti.VC.watchdogConn:Disconnect(); Anti.VC.watchdogConn = nil end
    local lastCheck = 0
    Anti.VC.watchdogConn = RunService.Heartbeat:Connect(function()
        if not Anti.VC.enabled then return end
        local now = tick()
        if now - lastCheck < 0.25 then return end
        lastCheck = now

        local vcs, vci = getVCServices()
        if not vci then return end

        local currentlyPaused = isVCPublishPaused(vci)
        if not Anti.VC.userMuted and currentlyPaused then
            setVCPublishPaused(vci, false)
            Anti.VC.blockedMutes = (Anti.VC.blockedMutes or 0) + 1
            updateKhamanAntiVCVisuals("Status: Active (Live)", T.Success, "KHAMAN ANTI-VC ACTIVE")
        elseif Anti.VC.userMuted and not currentlyPaused then
            setVCPublishPaused(vci, true)
        end

        local coreGui = CoreGui or game:GetService("CoreGui")
        if coreGui then
            for _, v in ipairs(coreGui:GetChildren()) do
                if v.Name == "KhamanVCBypassStore" then
                    local origBtn = v:FindFirstChild("toggle_mic_mute")
                    local origIcon = findMicIcon(origBtn)
                    local customBtn = coreGui:FindFirstChild("toggle_mic_mute_new", true)
                    local customIcon = findMicIcon(customBtn)
                    if customIcon then
                        if Anti.VC.userMuted then
                            customIcon.Image = MUTED_MIC_IMG
                        elseif origIcon and origIcon.Image ~= "" and origIcon.Image ~= MUTED_MIC_IMG then
                            customIcon.Image = origIcon.Image
                        else
                            customIcon.Image = UNMUTED_MIC_IMG
                        end
                    end
                    break
                end
            end
        end
    end)
end

Anti.VC.toggleMicFn = function()
    local vcs, vci = getVCServices()
    if not Anti.VC.enabled and not Anti.VC.running then
        if Anti.VC.forceBypassFn then
            Anti.VC.forceBypassFn()
        end
        return
    end
    Anti.VC.userMuted = not Anti.VC.userMuted
    setVCPublishPaused(vci, Anti.VC.userMuted)
    if Anti.VC.userMuted then
        updateKhamanAntiVCVisuals("Status: Active (Mic Muted)", T.Warning, "KHAMAN ANTI-VC ACTIVE")
        notify("Khaman Anti-VC", "🔇 Mic Muted (Protected)")
        sToggleOff()
    else
        stripVCModerationConnections(vci, vcs)
        setVCPublishPaused(vci, false)
        updateKhamanAntiVCVisuals("Status: Active (Mic LIVE)", T.Success, "KHAMAN ANTI-VC ACTIVE")
        notify("Khaman Anti-VC", "🎙️ Mic LIVE / Unmuted (Anti-Force-Mute Active)")
        sToggleOn()
    end
end

Anti.VC.rejoinFn = function()
    if Anti.VC.running then return end
    Anti.VC.running = true
    updateKhamanAntiVCVisuals("Status: Rejoining Voice...", T.Warning, "REJOINING...")
    task.spawn(function()
        local vcs, vci = getVCServices()
        pcall(function() if vcs then vcs:leaveVoice() end end)
        task.wait(0.85)
        stripVCModerationConnections(vci, vcs)
        task.wait(0.45)
        pcall(function() if vcs then vcs:joinVoice() end end)
        task.wait(0.75)
        stripVCModerationConnections(vci, vcs)
        installVCPublishHook(vci)
        Anti.VC.userMuted = false
        setVCPublishPaused(vci, false)
        local coreGui = CoreGui or game:GetService("CoreGui")
        if coreGui then pcall(function() bindCustomTopBarMicClone(coreGui, vci) end) end
        Anti.VC.rejoins = (Anti.VC.rejoins or 0) + 1
        Anti.VC.running = false
        Anti.VC.enabled = true
        startVCWatchdog()
        updateKhamanAntiVCVisuals("Status: Active (Mic LIVE)", T.Success, "KHAMAN ANTI-VC ACTIVE")
        if syncAllAntiButtons then pcall(syncAllAntiButtons) end
        notify("Khaman Anti-VC", "🔄 Voice Rejoined & Unban Pulse Complete!")
        sSuccess()
    end)
end

Anti.VC.forceBypassFn = function()
    if Anti.VC.running then
        notify("Khaman Anti-VC", "Bypass sequence already running...")
        return
    end
    Anti.VC.running = true
    updateKhamanAntiVCVisuals("Status: Force-Bypassing...", T.Warning, "BYPASSING...")
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    sToggleOn()

    task.spawn(function()
        local ok, err = pcall(function()
            local vcs, vci = getVCServices()
            local coreGui = CoreGui or game:GetService("CoreGui")

            local micBtn = locateTopBarMicButton(coreGui)
            if not micBtn and vcs then
                pcall(function() vcs:joinVoice() end)
                task.wait(0.7)
                micBtn = locateTopBarMicButton(coreGui)
            end
            if micBtn then
                local icon = findMicIcon(micBtn)
                if icon and icon.Image == MUTED_MIC_IMG and type(firesignal) == "function" then
                    local hit = micBtn:FindFirstChild("IconHitArea_toggle_mic_mute", true) or micBtn
                    pcall(function() firesignal(hit.Activated) end)
                    pcall(function() firesignal(hit.MouseButton1Click) end)
                    task.wait(0.25)
                end
            end

            if vcs then pcall(function() vcs:leaveVoice() end) end
            task.wait(1.1)

            stripVCModerationConnections(vci, vcs)
            task.wait(0.8)

            if vcs then pcall(function() vcs:joinVoice() end) end
            task.wait(0.9)

            stripVCModerationConnections(vci, vcs)
            installVCPublishHook(vci)

            if coreGui then
                pcall(function() bindCustomTopBarMicClone(coreGui, vci) end)
            end

            Anti.VC.userMuted = false
            setVCPublishPaused(vci, false)

            Anti.VC.running = false
            Anti.VC.enabled = true
            startVCWatchdog()
            updateKhamanAntiVCVisuals("Status: Active (Mic LIVE)", T.Success, "KHAMAN ANTI-VC ACTIVE")
            if syncAllAntiButtons then pcall(syncAllAntiButtons) end
            notify("Khaman Anti-VC", "⚡ Instant VC Bypass V4 Active! Mic is LIVE.")
            sSuccess()
        end)
        if not ok then
            Anti.VC.running = false
            updateKhamanAntiVCVisuals("Status: Error (" .. tostring(err):sub(1, 22) .. ")", T.Danger, "RETRY BYPASS")
            if syncAllAntiButtons then pcall(syncAllAntiButtons) end
            notify("Khaman Anti-VC", "Bypass Error: " .. tostring(err))
        end
    end)
end

vcStart = function()
    if Anti.VC.enabled then
        notify("Khaman Anti-VC", "Already active — use Mic Toggle or Rejoin!")
        return
    end
    if Anti.VC.running then
        notify("Khaman Anti-VC", "Bypass in progress — unmute mic or tap Instant Force Bypass!")
        return
    end

    Anti.VC.running = true
    updateKhamanAntiVCVisuals("Status: Waiting for unmute...", T.Warning, "WAITING...")
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    sToggleOn()

    task.spawn(function()
        local ok, err = pcall(function()
            local vcs, vci = getVCServices()
            local coreGui = CoreGui or game:GetService("CoreGui")

            local micBtn, micParent = locateTopBarMicButton(coreGui)
            if not micBtn then
                pcall(function() if vcs then vcs:joinVoice() end end)
                task.wait(0.9)
                micBtn, micParent = locateTopBarMicButton(coreGui)
            end

            if micBtn then
                local icon = findMicIcon(micBtn)
                if icon and icon.Image == MUTED_MIC_IMG and type(firesignal) == "function" then
                    local hit = micBtn:FindFirstChild("IconHitArea_toggle_mic_mute", true) or micBtn
                    pcall(function() firesignal(hit.Activated) end)
                    pcall(function() firesignal(hit.MouseButton1Click) end)
                    task.wait(0.25)
                    icon = findMicIcon(micBtn) or icon
                end

                if icon and icon.Image == MUTED_MIC_IMG then
                    notify("Khaman Anti-VC", "Unmute your mic (or wait 12s for Auto Force-Bypass)")
                    local startTick = tick()
                    while icon and icon.Image == MUTED_MIC_IMG and (tick() - startTick) < 12 do
                        if not Anti.VC.running then
                            error("Cancelled")
                        end
                        task.wait(0.35)
                        icon = findMicIcon(micBtn) or icon
                    end
                end
            else
                notify("Khaman Anti-VC", "TopBar hidden — running Direct Engine VC Bypass V4...")
            end

            pcall(function() if vcs then vcs:leaveVoice() end end)
            task.wait(1.5)

            stripVCModerationConnections(vci, vcs)
            task.wait(1.2)

            pcall(function() if vcs then vcs:joinVoice() end end)
            task.wait(1.0)

            stripVCModerationConnections(vci, vcs)
            installVCPublishHook(vci)

            if coreGui then
                pcall(function() bindCustomTopBarMicClone(coreGui, vci) end)
            end

            Anti.VC.userMuted = false
            setVCPublishPaused(vci, false)

            Anti.VC.running = false
            Anti.VC.enabled = true
            startVCWatchdog()
            updateKhamanAntiVCVisuals("Status: Active (Mic LIVE)", T.Success, "KHAMAN ANTI-VC ACTIVE")
            if syncAllAntiButtons then pcall(syncAllAntiButtons) end
            notify("Khaman Anti-VC", "Activated V4 Bypass! Mic is LIVE (Press [V] or use UI to mute/unmute)")
            sSuccess()
        end)

        if not ok then
            Anti.VC.running = false
            Anti.VC.enabled = false
            updateKhamanAntiVCVisuals("Status: Failed", T.Danger, "RETRY")
            if syncAllAntiButtons then pcall(syncAllAntiButtons) end
            notify("Khaman Anti-VC", "Error: " .. tostring(err))
            warn("[KHAMAN ANTI-VC] Error:", err)
        end
    end)
end

vcStop = function()
    if not Anti.VC.enabled and not Anti.VC.running then return end
    Anti.VC.running = false
    Anti.VC.enabled = false
    if Anti.VC.watchdogConn then Anti.VC.watchdogConn:Disconnect(); Anti.VC.watchdogConn = nil end
    pcall(function()
        local coreGui = CoreGui or game:GetService("CoreGui")
        local store = coreGui and (coreGui:FindFirstChild("KhamanVCBypassStore") or coreGui:FindFirstChild("AngoorVCBypassStore"))
        if store then
            local origBtn = store:FindFirstChild("toggle_mic_mute")
            for _, v in ipairs(coreGui:GetDescendants()) do
                if v.Name == "toggle_mic_mute_new" and v.Parent then
                    if origBtn then
                        origBtn.Parent = v.Parent
                    end
                    v:Destroy()
                    break
                end
            end
            store:Destroy()
        end
    end)
    updateKhamanAntiVCVisuals("Status: Idle", T.Muted, "ACTIVATE KHAMAN ANTI VC")
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("Khaman Anti-VC", "Khaman Anti-VC reset to Idle")
    sToggleOff()
end

Anti.VC.startFn = vcStart
Anti.VC.stopFn  = vcStop
_G.ActivateKhamanAntiVC = vcStart
_G.ForceKhamanAntiVC    = Anti.VC.forceBypassFn
_G.ToggleKhamanVCMic    = Anti.VC.toggleMicFn
_G.ActivateTeslaAntiVC  = vcStart

Anti.VC.openPanelFn = function()
    local coreGui = CoreGui or game:GetService("CoreGui")
    local pgui = LP and LP:FindFirstChildOfClass("PlayerGui")
    for _, panelName in ipairs({ "KhamanAntiVCPanel", "TeslaAntiVCPanel" }) do
        local existing = (coreGui and coreGui:FindFirstChild(panelName))
            or (pgui and pgui:FindFirstChild(panelName))
        if existing then
            existing:Destroy()
            return
        end
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KhamanAntiVCPanel"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 1000002

    local parentOk = pcall(function()
        screenGui.Parent = coreGui
    end)
    if not parentOk or not screenGui.Parent then
        screenGui.Parent = pgui or LP:WaitForChild("PlayerGui")
    end

    local mainCard = Instance.new("Frame", screenGui)
    mainCard.Name = "KhamanAntiVCCard"
    mainCard.Size = UDim2.new(0, 304, 0, 296)
    mainCard.Position = UDim2.new(0.5, -152, 0.5, -148)
    mainCard.BackgroundColor3 = T.BG2
    mainCard.BorderSizePixel = 0
    mainCard.Active = true
    pcall(function() mainCard.Draggable = true end)

    local cardCorner = Instance.new("UICorner", mainCard)
    cardCorner.CornerRadius = UDim.new(0, 12)

    local cardStroke = Instance.new("UIStroke", mainCard)
    cardStroke.Color = T.Accent
    cardStroke.Thickness = 1.6

    local closeBtn = Instance.new("TextButton", mainCard)
    closeBtn.Size = UDim2.new(0, 24, 0, 22)
    closeBtn.Position = UDim2.new(1, -24, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 12
    closeBtn.TextColor3 = T.Muted
    closeBtn.ZIndex = 5
    closeBtn.MouseButton1Click:Connect(function()
        sClick()
        screenGui:Destroy()
    end)

    local cardPadding = Instance.new("UIPadding", mainCard)
    cardPadding.PaddingTop = UDim.new(0, 10)
    cardPadding.PaddingBottom = UDim.new(0, 10)
    cardPadding.PaddingLeft = UDim.new(0, 12)
    cardPadding.PaddingRight = UDim.new(0, 12)

    local listLayout = Instance.new("UIListLayout", mainCard)
    listLayout.FillDirection = Enum.FillDirection.Vertical
    listLayout.Padding = UDim.new(0, 6)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local headerLbl = Instance.new("TextLabel", mainCard)
    headerLbl.LayoutOrder = 1
    headerLbl.Size = UDim2.new(1, -24, 0, 18)
    headerLbl.BackgroundTransparency = 1
    headerLbl.Text = "🟨 KHAMAN ANTI-VC V4 ULTRA BYPASS"
    headerLbl.Font = Enum.Font.GothamBlack
    headerLbl.TextSize = 11
    headerLbl.TextColor3 = T.Accent
    headerLbl.TextXAlignment = Enum.TextXAlignment.Left

    local stLbl = Instance.new("TextLabel", mainCard)
    stLbl.LayoutOrder = 2
    stLbl.Size = UDim2.new(1, 0, 0, 18)
    stLbl.BackgroundTransparency = 1
    stLbl.Text = (Anti.VC.statusText or "Status: Idle") .. "  ·  Blocked Mutes: " .. tostring(Anti.VC.blockedMutes or 0)
    stLbl.Font = Enum.Font.GothamBold
    stLbl.TextSize = 10
    stLbl.TextColor3 = Anti.VC.enabled and T.Success
        or (Anti.VC.running and T.Warning or T.Muted)
    stLbl.TextXAlignment = Enum.TextXAlignment.Left
    Anti.VC.statusLbl = stLbl

    local infoLbl = Instance.new("TextLabel", mainCard)
    infoLbl.LayoutOrder = 3
    infoLbl.Size = UDim2.new(1, 0, 0, 68)
    infoLbl.BackgroundColor3 = T.Panel
    infoLbl.BorderSizePixel = 0
    infoLbl.Text = "• Auto Bypass: Unmutes + strips StateChanged & Moderation\n• Instant Force Bypass: 0-wait direct VoiceChatInternal unlock\n• Anti-Force-Mute Watchdog: Keeps mic LIVE 24/7 (Key: [V])"
    infoLbl.Font = Enum.Font.Gotham
    infoLbl.TextSize = 9
    infoLbl.TextColor3 = T.Text
    infoLbl.TextXAlignment = Enum.TextXAlignment.Left
    infoLbl.TextYAlignment = Enum.TextYAlignment.Top
    infoLbl.TextWrapped = true
    Instance.new("UICorner", infoLbl).CornerRadius = UDim.new(0, 8)
    local infoPad = Instance.new("UIPadding", infoLbl)
    infoPad.PaddingTop = UDim.new(0, 6)
    infoPad.PaddingLeft = UDim.new(0, 8)
    infoPad.PaddingRight = UDim.new(0, 8)

    local actBtn = Instance.new("TextButton", mainCard)
    actBtn.LayoutOrder = 4
    actBtn.Size = UDim2.new(1, 0, 0, 34)
    actBtn.BackgroundColor3 = T.Accent2
    actBtn.BorderSizePixel = 0
    actBtn.Text = Anti.VC.enabled and "KHAMAN ANTI-VC ACTIVE" or (Anti.VC.running and "WAITING..." or "ACTIVATE AUTO VC BYPASS")
    actBtn.Font = Enum.Font.GothamBold
    actBtn.TextSize = 11
    actBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", actBtn).CornerRadius = UDim.new(0, 7)
    Anti.VC.activateBtn = actBtn
    actBtn.MouseButton1Click:Connect(function()
        sClick()
        vcStart()
    end)

    local forceBtn = Instance.new("TextButton", mainCard)
    forceBtn.LayoutOrder = 5
    forceBtn.Size = UDim2.new(1, 0, 0, 32)
    forceBtn.BackgroundColor3 = Color3.fromRGB(185, 115, 12)
    forceBtn.BorderSizePixel = 0
    forceBtn.Text = "⚡ INSTANT FORCE BYPASS (0-WAIT)"
    forceBtn.Font = Enum.Font.GothamBold
    forceBtn.TextSize = 10
    forceBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", forceBtn).CornerRadius = UDim.new(0, 7)
    Anti.VC.forceBtn = forceBtn
    forceBtn.MouseButton1Click:Connect(function()
        sClick()
        Anti.VC.forceBypassFn()
    end)

    local micBtn = Instance.new("TextButton", mainCard)
    micBtn.LayoutOrder = 6
    micBtn.Size = UDim2.new(1, 0, 0, 32)
    micBtn.BackgroundColor3 = Anti.VC.userMuted and T.Danger or T.Success
    micBtn.BorderSizePixel = 0
    micBtn.Text = Anti.VC.userMuted and "🔇 MIC: MUTED (TAP TO UNMUTE)" or "🎙️ MIC: LIVE / UNMUTED (TAP TO MUTE)"
    micBtn.Font = Enum.Font.GothamBold
    micBtn.TextSize = 10
    micBtn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", micBtn).CornerRadius = UDim.new(0, 7)
    Anti.VC.micToggleBtn = micBtn
    micBtn.MouseButton1Click:Connect(function()
        sClick()
        Anti.VC.toggleMicFn()
    end)

    local rejoinBtn = Instance.new("TextButton", mainCard)
    rejoinBtn.LayoutOrder = 7
    rejoinBtn.Size = UDim2.new(1, 0, 0, 30)
    rejoinBtn.BackgroundColor3 = T.PanelLt
    rejoinBtn.BorderSizePixel = 0
    rejoinBtn.Text = "🔄 FORCE REJOIN VOICE & UNBAN PULSE"
    rejoinBtn.Font = Enum.Font.GothamBold
    rejoinBtn.TextSize = 10
    rejoinBtn.TextColor3 = T.Neon
    Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0, 7)
    Anti.VC.rejoinBtn = rejoinBtn
    rejoinBtn.MouseButton1Click:Connect(function()
        sClick()
        Anti.VC.rejoinFn()
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 6. ALWAYS-ON ANTI-RAGDOLL / ANTI-SIT / ANTI-KIDNAP / ANTI-STUN V4 (Zero-Lag Event + Stepped)
--    NEVER calls SetStateEnabled(Physics, false) on every frame (which froze Troll welds!)
-- ═══════════════════════════════════════════════════════════════════════════════
local function breakCharacterSeatWeldsFast(c, hum)
    if hum then
        local sp = hum.SeatPart
        if sp then
            pcall(function()
                sp.Disabled = true
                sp.CanTouch = false
                for _, w in ipairs(sp:GetChildren()) do
                    if w:IsA("Weld") or w:IsA("WeldConstraint") or w:IsA("Motor6D") or w.Name == "SeatWeld" then
                        w:Destroy()
                    end
                end
            end)
        end
    end
    local root = getRootPart(c)
    if root then
        local okJ, joints = pcall(function() return root:GetJoints() end)
        if okJ and joints then
            for _, j in ipairs(joints) do
                if j.Name == "SeatWeld" or j:IsA("SeatWeld") then
                    pcall(function() j:Destroy() end)
                end
            end
        end
    end
end

local function ragdollDeepCleanseDescendants(c)
    if not c or isActivelyWeldedOrFlinging() then return end
    for _, obj in ipairs(c:GetDescendants()) do
        if obj:IsA("Motor6D") and not obj.Enabled then
            pcall(function() obj.Enabled = true end)
        elseif obj:IsA("SeatWeld") or obj.Name == "SeatWeld" or obj.Name:lower():find("ragdoll", 1, true) then
            if not obj:IsA("BasePart") and not obj:IsA("Humanoid") then
                pcall(function() obj:Destroy() end)
            end
        elseif obj:IsA("BallSocketConstraint") or obj:IsA("HingeConstraint") then
            pcall(function() obj:Destroy() end)
        end
    end
end

local function ragdollApplyHumanoidStateLocks(hum)
    if not hum then return end
    pcall(function()
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
    end)
end

local function ragdollCleanseCharacter(c, forceDeep)
    if not c then return end
    if isActivelyWeldedOrFlinging() or (RewindSys and RewindSys.rewinding) then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum.Sit or hum.SeatPart ~= nil then
            breakCharacterSeatWeldsFast(c, hum)
            pcall(function() hum.Sit = false end)
        end
        if not (moveState and moveState.fly) then
            if hum.PlatformStand then
                pcall(function() hum.PlatformStand = false end)
            end
            if not hum.AutoRotate then
                pcall(function() hum.AutoRotate = true end)
            end
            if not hum.EvaluateStateMachine then
                pcall(function() hum.EvaluateStateMachine = true end)
            end
            local st = hum:GetState()
            if st == Enum.HumanoidStateType.Ragdoll
                or st == Enum.HumanoidStateType.FallingDown
                or st == Enum.HumanoidStateType.PlatformStanding
                or st == Enum.HumanoidStateType.Seated then
                pcall(function()
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end)
                Anti.Ragdoll.recoveries = Anti.Ragdoll.recoveries + 1
            end
            if hum.WalkSpeed < 8 and not (moveState and moveState.speed) then
                pcall(function() hum.WalkSpeed = 16 end)
            end
        end
    end
    if forceDeep then
        ragdollDeepCleanseDescendants(c)
    end
end

ragdollStart = function(silent)
    if Anti.Ragdoll.enabled and Anti.Ragdoll.steppedConn then return end
    Anti.Ragdoll.enabled = true
    local function hookRagdollChar(char)
        if Anti.Ragdoll.descConn then Anti.Ragdoll.descConn:Disconnect(); Anti.Ragdoll.descConn = nil end
        if Anti.Ragdoll.stateConn then Anti.Ragdoll.stateConn:Disconnect(); Anti.Ragdoll.stateConn = nil end
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then ragdollApplyHumanoidStateLocks(hum) end
        ragdollCleanseCharacter(char, true)
        Anti.Ragdoll.descConn = char.DescendantAdded:Connect(function(obj)
            if not Anti.Ragdoll.enabled or isActivelyWeldedOrFlinging() then return end
            if obj:IsA("Humanoid") then
                ragdollApplyHumanoidStateLocks(obj)
            elseif obj:IsA("Motor6D") and not obj.Enabled then
                pcall(function() obj.Enabled = true end)
            elseif obj:IsA("SeatWeld") or obj.Name == "SeatWeld" or obj.Name:lower():find("ragdoll", 1, true)
                or obj:IsA("BallSocketConstraint") or obj:IsA("HingeConstraint") then
                pcall(function() obj:Destroy() end)
            end
        end)
        if hum then
            Anti.Ragdoll.stateConn = hum.StateChanged:Connect(function(_, state)
                if not Anti.Ragdoll.enabled or isActivelyWeldedOrFlinging() then return end
                if state == Enum.HumanoidStateType.Ragdoll
                    or state == Enum.HumanoidStateType.FallingDown
                    or state == Enum.HumanoidStateType.Seated then
                    task.defer(function()
                        if Anti.Ragdoll.enabled and char.Parent and not isActivelyWeldedOrFlinging() then
                            ragdollCleanseCharacter(char, true)
                        end
                    end)
                end
            end)
        end
    end
    hookRagdollChar(LP.Character)
    if Anti.Ragdoll.charAdded then Anti.Ragdoll.charAdded:Disconnect() end
    Anti.Ragdoll.charAdded = LP.CharacterAdded:Connect(function(c)
        task.wait(0.1)
        if Anti.Ragdoll.enabled then hookRagdollChar(c) end
    end)
    if Anti.Ragdoll.steppedConn then Anti.Ragdoll.steppedConn:Disconnect() end
    Anti.Ragdoll.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.Ragdoll.enabled or isActivelyWeldedOrFlinging() then return end
        ragdollCleanseCharacter(LP.Character, false)
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if not silent then
        notify("KHAMAN DHOKLA", "Anti-Ragdoll / Anti-Sit / Anti-Stun v4 (Always-On) ACTIVE")
        sToggleOn()
    end
end

ragdollStop = function()
    if Anti.AlwaysOnCore or Anti.Ragdoll.alwaysOn then
        ragdollStart(true)
        if syncAllAntiButtons then pcall(syncAllAntiButtons) end
        notify("KHAMAN DHOKLA", "🔒 Anti-Sit / Anti-Ragdoll is locked ALWAYS-ON!")
        return
    end
    if not Anti.Ragdoll.enabled then return end
    Anti.Ragdoll.enabled = false
    if Anti.Ragdoll.steppedConn then Anti.Ragdoll.steppedConn:Disconnect(); Anti.Ragdoll.steppedConn = nil end
    if Anti.Ragdoll.descConn then Anti.Ragdoll.descConn:Disconnect(); Anti.Ragdoll.descConn = nil end
    if Anti.Ragdoll.stateConn then Anti.Ragdoll.stateConn:Disconnect(); Anti.Ragdoll.stateConn = nil end
    if Anti.Ragdoll.charAdded then Anti.Ragdoll.charAdded:Disconnect(); Anti.Ragdoll.charAdded = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
end
Anti.Ragdoll.startFn = ragdollStart
Anti.Ragdoll.stopFn  = ragdollStop

-- ═══════════════════════════════════════════════════════════════════════════════
-- 7. ALWAYS-ON ANTI-ANCHOR / ANTI-FREEZE / BODYMOVER PURGER V4 (Zero-Lag Cached Parts + Event)
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

local function anchorWatchPart(part)
    if not (part and part:IsA("BasePart")) or Anti.Anchor.partConns[part] then return end
    Anti.Anchor.partConns[part] = part:GetPropertyChangedSignal("Anchored"):Connect(function()
        if Anti.Anchor.enabled and part.Parent and part.Anchored and not deflectBusy and not VoidRescueActive then
            pcall(function() part.Anchored = false end)
            Anti.Anchor.purgedMovers = Anti.Anchor.purgedMovers + 1
        end
    end)
end

local function anchorCleanse(c, forceMoverSweep)
    if not c then return end
    for _, part in ipairs(getCachedCharParts(c)) do
        if part.Parent and part.Anchored and not deflectBusy and not VoidRescueActive then
            part.Anchored = false
            Anti.Anchor.purgedMovers = Anti.Anchor.purgedMovers + 1
        end
    end
    if not isActivelyWeldedOrFlinging() and not (moveState and moveState.fly) then
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then
            if not hum.EvaluateStateMachine then
                pcall(function() hum.EvaluateStateMachine = true end)
            end
            if hum.WalkSpeed <= 1 then
                pcall(function() hum.WalkSpeed = (moveState and moveState.speed and moveState.desiredWalkSpeed) or 16 end)
            end
        end
    end
    if forceMoverSweep then
        for _, obj in ipairs(c:GetDescendants()) do
            if obj:IsA("BasePart") then
                anchorWatchPart(obj)
            elseif HOSTILE_MOVER_CLASSES[obj.ClassName] and not obj.Name:match("^Coco") and not obj.Name:match("^Khaman") then
                pcall(function()
                    obj:Destroy()
                    Anti.Anchor.purgedMovers = Anti.Anchor.purgedMovers + 1
                end)
            end
        end
    end
end

local function anchorHookChar(char)
    if Anti.Anchor.descConn then Anti.Anchor.descConn:Disconnect(); Anti.Anchor.descConn = nil end
    for part, conn in pairs(Anti.Anchor.partConns) do
        if conn then pcall(function() conn:Disconnect() end) end
        Anti.Anchor.partConns[part] = nil
    end
    if not char then return end
    anchorCleanse(char, true)
    Anti.Anchor.descConn = char.DescendantAdded:Connect(function(obj)
        if not Anti.Anchor.enabled then return end
        if obj:IsA("BasePart") then
            anchorWatchPart(obj)
            if obj.Anchored and not deflectBusy and not VoidRescueActive then
                pcall(function() obj.Anchored = false end)
            end
        elseif HOSTILE_MOVER_CLASSES[obj.ClassName] and not obj.Name:match("^Coco") and not obj.Name:match("^Khaman") then
            pcall(function() obj:Destroy(); Anti.Anchor.purgedMovers = Anti.Anchor.purgedMovers + 1 end)
        end
    end)
end

anchorStart = function(silent)
    if Anti.Anchor.enabled and Anti.Anchor.steppedConn then return end
    Anti.Anchor.enabled = true
    anchorHookChar(LP.Character)
    if Anti.Anchor.charAdded then Anti.Anchor.charAdded:Disconnect() end
    Anti.Anchor.charAdded = LP.CharacterAdded:Connect(function(char)
        task.wait(0.1)
        if Anti.Anchor.enabled then anchorHookChar(char) end
    end)
    if Anti.Anchor.steppedConn then Anti.Anchor.steppedConn:Disconnect() end
    Anti.Anchor.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.Anchor.enabled then return end
        anchorCleanse(LP.Character, false)
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if not silent then
        notify("KHAMAN DHOKLA", "Anti-Freeze / Anti-Anchor v4 (Always-On) ACTIVE")
        sToggleOn()
    end
end

anchorStop = function()
    if Anti.AlwaysOnCore or Anti.Anchor.alwaysOn then
        anchorStart(true)
        if syncAllAntiButtons then pcall(syncAllAntiButtons) end
        notify("KHAMAN DHOKLA", "🔒 Anti-Freeze / Anti-Anchor is locked ALWAYS-ON!")
        return
    end
    if not Anti.Anchor.enabled then return end
    Anti.Anchor.enabled = false
    if Anti.Anchor.steppedConn then Anti.Anchor.steppedConn:Disconnect(); Anti.Anchor.steppedConn = nil end
    if Anti.Anchor.descConn then Anti.Anchor.descConn:Disconnect(); Anti.Anchor.descConn = nil end
    if Anti.Anchor.charAdded then Anti.Anchor.charAdded:Disconnect(); Anti.Anchor.charAdded = nil end
    for part, conn in pairs(Anti.Anchor.partConns) do
        if conn then pcall(function() conn:Disconnect() end) end
        Anti.Anchor.partConns[part] = nil
    end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
end
Anti.Anchor.startFn = anchorStart
Anti.Anchor.stopFn  = anchorStop

-- ═══════════════════════════════════════════════════════════════════════════════
-- 8. ADVANCED ANTI-ATTACH / HOSTILE WELD & GRAB SEVER V3
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
    for _, part in ipairs(getCachedCharParts(myChar)) do
        if part.Parent then
            local okJ, joints = pcall(function() return part:GetJoints() end)
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
    Anti.Attach.severedCount = Anti.Attach.severedCount + severed
    return severed
end

attachStart = function()
    if Anti.Attach.enabled then return end
    Anti.Attach.enabled = true
    severAllHostileAttachments()
    if Anti.Attach.steppedConn then Anti.Attach.steppedConn:Disconnect() end
    Anti.Attach.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.Attach.enabled or isActivelyWeldedOrFlinging() then return end
        severAllHostileAttachments()
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Attach / Omni-Weld & Grab Sever v3 ON")
    sToggleOn()
end

attachStop = function()
    if not Anti.Attach.enabled then return end
    Anti.Attach.enabled = false
    if Anti.Attach.steppedConn then Anti.Attach.steppedConn:Disconnect(); Anti.Attach.steppedConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Attach disabled")
    sToggleOff()
end
Anti.Attach.startFn = attachStart
Anti.Attach.stopFn  = attachStop

-- ═══════════════════════════════════════════════════════════════════════════════
-- 9. ADVANCED ANTI-BLIND / ANTI-FLASH & VISION CLEAR V3
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
                if eff:IsA("PostEffect") and not eff.Name:match("^Coco") and not eff.Name:match("^Khaman") then
                    eff.Enabled = false
                end
            end
        end
        local pgui = LP:FindFirstChildOfClass("PlayerGui")
        if pgui then
            for _, sg in ipairs(pgui:GetChildren()) do
                if sg:IsA("ScreenGui") and not sg.Name:match("^Khaman") and not sg.Name:match("^Coco") then
                    local sname = sg.Name:lower()
                    if sname:find("blind", 1, true)
                        or sname:find("flash", 1, true)
                        or sname:find("blackout", 1, true)
                        or sname:find("jumpscare", 1, true)
                        or sname:find("fade", 1, true) then
                        sg.Enabled = false
                    end
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
    notify("KHAMAN DHOKLA", "Anti-Blind / Anti-Flashbang & Fog Clear v3 ON")
    sToggleOn()
end

blindStop = function()
    if not Anti.Blind.enabled then return end
    Anti.Blind.enabled = false
    if Anti.Blind.loopConn then Anti.Blind.loopConn:Disconnect(); Anti.Blind.loopConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Blind disabled")
    sToggleOff()
end
Anti.Blind.startFn = blindStart
Anti.Blind.stopFn  = blindStop

-- ═══════════════════════════════════════════════════════════════════════════════
-- 10. ADVANCED ANTI-BRING / ANTI-TELEPORT / ANTI-TOOL-GRAB GUARD V3
-- ═══════════════════════════════════════════════════════════════════════════════
bringStart = function()
    if Anti.Bring.enabled then return end
    Anti.Bring.enabled = true
    local c = LP.Character
    local root = getRootPart(c)
    if root and isSafePlayableCF(root.CFrame) then
        Anti.Bring.lastCF = root.CFrame
        Anti.Bring.lastSafeTime = tick()
    end
    if Anti.Bring.steppedConn then Anti.Bring.steppedConn:Disconnect() end
    Anti.Bring.steppedConn = RunService.Stepped:Connect(function(_, dt)
        if not Anti.Bring.enabled then return end
        if isActivelyWeldedOrFlinging() or deflectBusy or (moveState and moveState.fly) or (RewindSys and RewindSys.rewinding) then
            local ch = LP.Character
            local r = getRootPart(ch)
            if r and isSafePlayableCF(r.CFrame) then Anti.Bring.lastCF = r.CFrame end
            return
        end
        if tick() - (moveState.lastTeleportTick or 0) < 0.85 then return end

        local ch = LP.Character
        local r = getRootPart(ch)
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        if not r or not hum or hum.Health <= 0 then return end

        if Anti.Bring.lastCF then
            local dist = (r.Position - Anti.Bring.lastCF.Position).Magnitude
            local maxAllowedStep = math.max(38, (hum.WalkSpeed or 16) * math.max(dt or 0.016, 0.016) * 4.5 + 22)
            if dist > maxAllowedStep then
                severAllHostileAttachments()
                r.AssemblyLinearVelocity = Vector3.zero
                r.AssemblyAngularVelocity = Vector3.zero
                r.CFrame = Anti.Bring.lastCF
                Anti.Bring.blockedBrings = Anti.Bring.blockedBrings + 1
                notify("KHAMAN DHOKLA", "Anti-Bring v3: Blocked hostile teleport/grab!")
            elseif isSafePlayableCF(r.CFrame) then
                Anti.Bring.lastCF = r.CFrame
            end
        elseif isSafePlayableCF(r.CFrame) then
            Anti.Bring.lastCF = r.CFrame
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Bring / Tool-Grab & Snap Guard v3 ON")
    sToggleOn()
end

bringStop = function()
    if not Anti.Bring.enabled then return end
    Anti.Bring.enabled = false
    if Anti.Bring.steppedConn then Anti.Bring.steppedConn:Disconnect(); Anti.Bring.steppedConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Bring disabled")
    sToggleOff()
end
Anti.Bring.startFn = bringStart
Anti.Bring.stopFn  = bringStop

-- ═══════════════════════════════════════════════════════════════════════════════
-- 11. ADVANCED ANTI-FLING & SERVER-WIDE NO-COLLIDE SHIELD V3
-- ═══════════════════════════════════════════════════════════════════════════════
local function neutralizeOtherPlayersCollision()
    local myChar = LP.Character
    local myRoot = getRootPart(myChar)
    if not myRoot then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local tRoot = getRootPart(p.Character)
            local isHighVel = tRoot and (tRoot.AssemblyLinearVelocity.Magnitude > 50 or tRoot.AssemblyAngularVelocity.Magnitude > 25)
            for _, part in ipairs(getCachedCharParts(p.Character)) do
                if part.Parent then
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

flingShieldStart = function()
    if Anti.FlingShield.enabled then return end
    Anti.FlingShield.enabled = true
    pcall(function()
        local ps = game:GetService("PhysicsService")
        ps:RegisterCollisionGroup("KhamanNoCollide")
        ps:CollisionGroupSetCollidable("KhamanNoCollide", "Default", false)
    end)
    if Anti.FlingShield.steppedConn then Anti.FlingShield.steppedConn:Disconnect() end
    Anti.FlingShield.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.FlingShield.enabled and not DefenceTroll.enabled then return end
        if isActivelyWeldedOrFlinging() or deflectBusy or (RewindSys and RewindSys.rewinding) then return end
        neutralizeOtherPlayersCollision()
        local myChar = LP.Character
        local myRoot = getRootPart(myChar)
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
        if isActivelyWeldedOrFlinging() or deflectBusy or (RewindSys and RewindSys.rewinding) then return end
        local myChar = LP.Character
        local myRoot = getRootPart(myChar)
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
    notify("KHAMAN DHOKLA", "Anti-Fling Shield v3 (Server-Wide No-Collide + Zero-Impulse) ON")
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
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, part in ipairs(getCachedCharParts(p.Character)) do
                if part.Parent and (part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head") then
                    pcall(function() part.CanCollide = true; part.Massless = false end)
                end
            end
        end
    end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Fling Shield disabled")
    sToggleOff()
end
Anti.FlingShield.startFn = flingShieldStart
Anti.FlingShield.stopFn  = flingShieldStop

-- ═══════════════════════════════════════════════════════════════════════════════
-- 12. ALWAYS-ON ANTI-SEAT / COUCH-KIDNAP DESTROYER V4 + ANTI-TOOL-GRAB DISARMER V3
-- ═══════════════════════════════════════════════════════════════════════════════
local function neutralizeSeatInstance(seat)
    if not seat or not (seat:IsA("Seat") or seat:IsA("VehicleSeat")) then return end
    if not Anti.SeatTrap.savedSeats[seat] then
        Anti.SeatTrap.savedSeats[seat] = { Disabled = seat.Disabled, CanTouch = seat.CanTouch }
    end
    pcall(function()
        seat.Disabled = true
        seat.CanTouch = false
        for _, ch in ipairs(seat:GetChildren()) do
            if ch:IsA("Weld") or ch:IsA("WeldConstraint") or ch.Name == "SeatWeld" then
                ch:Destroy()
            end
        end
    end)
    Anti.SeatTrap.neutralizedSeats = (Anti.SeatTrap.neutralizedSeats or 0) + 1
end

Anti.SeatTrap.startFn = function(silent)
    if Anti.SeatTrap.enabled and Anti.SeatTrap.wsDescConn then return end
    Anti.SeatTrap.enabled = true
    task.spawn(function()
        local desc = workspace:GetDescendants()
        for i = 1, #desc do
            if not Anti.SeatTrap.enabled then break end
            local obj = desc[i]
            if obj and (obj:IsA("Seat") or obj:IsA("VehicleSeat")) then
                neutralizeSeatInstance(obj)
            end
            if i % 250 == 0 then
                task.wait(0.03)
            end
        end
    end)
    if Anti.SeatTrap.wsDescConn then Anti.SeatTrap.wsDescConn:Disconnect() end
    Anti.SeatTrap.wsDescConn = workspace.DescendantAdded:Connect(function(obj)
        if not Anti.SeatTrap.enabled then return end
        if obj:IsA("Seat") or obj:IsA("VehicleSeat") then
            neutralizeSeatInstance(obj)
        elseif (obj:IsA("SeatWeld") or obj.Name == "SeatWeld") and LP.Character then
            local p0, p1 = obj.Part0, obj.Part1
            if (p0 and p0:IsDescendantOf(LP.Character)) or (p1 and p1:IsDescendantOf(LP.Character)) then
                pcall(function() obj:Destroy() end)
            end
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
    if not silent then
        notify("KHAMAN DHOKLA", "Anti-Seat / Couch-Kidnap Destroyer v4 (Always-On) ACTIVE")
        sToggleOn()
    end
end

Anti.SeatTrap.stopFn = function()
    if Anti.AlwaysOnCore or Anti.SeatTrap.alwaysOn then
        Anti.SeatTrap.startFn(true)
        if syncAllAntiButtons then pcall(syncAllAntiButtons) end
        notify("KHAMAN DHOKLA", "🔒 Anti-Sit / Anti-Seat is locked ALWAYS-ON!")
        return
    end
    if not Anti.SeatTrap.enabled then return end
    Anti.SeatTrap.enabled = false
    if Anti.SeatTrap.wsDescConn then Anti.SeatTrap.wsDescConn:Disconnect(); Anti.SeatTrap.wsDescConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
end

Anti.ToolGuard.startFn = function()
    if Anti.ToolGuard.enabled then return end
    Anti.ToolGuard.enabled = true
    if Anti.ToolGuard.loopConn then Anti.ToolGuard.loopConn:Disconnect() end
    local lastToolScan = 0
    Anti.ToolGuard.loopConn = RunService.Heartbeat:Connect(function()
        if not Anti.ToolGuard.enabled then return end
        local now = tick()
        if now - lastToolScan < 0.20 then return end
        lastToolScan = now
        local myChar = LP.Character
        local myRoot = getRootPart(myChar)
        if not myRoot then return end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local oRoot = getRootPart(p.Character)
                if not oRoot or (oRoot.Position - myRoot.Position).Magnitude < 45 then
                    for _, child in ipairs(p.Character:GetChildren()) do
                        if child:IsA("Tool") or child:IsA("HopperBin") then
                            for _, part in ipairs(child:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    if part.CanTouch or part.CanCollide then
                                        part.CanTouch = false
                                        part.CanCollide = false
                                        part.Massless = true
                                        Anti.ToolGuard.disarmedTools = (Anti.ToolGuard.disarmedTools or 0) + 1
                                    end
                                elseif part:IsA("Seat") or part:IsA("VehicleSeat") then
                                    neutralizeSeatInstance(part)
                                elseif myChar and isJointHostileToCharacter(part, myChar) then
                                    pcall(function() part:Destroy() end)
                                    Anti.Attach.severedCount = (Anti.Attach.severedCount or 0) + 1
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
    notify("KHAMAN DHOKLA", "Anti-Tool / Couch / Carry Disarmer v3 ON")
    sToggleOn()
end

Anti.ToolGuard.stopFn = function()
    if not Anti.ToolGuard.enabled then return end
    Anti.ToolGuard.enabled = false
    if Anti.ToolGuard.loopConn then Anti.ToolGuard.loopConn:Disconnect(); Anti.ToolGuard.loopConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
    notify("KHAMAN DHOKLA", "Anti-Tool Disarmer disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 13. FULL LIBRARY ANTI-HEADSIT & ANTI-FACEBANG EVADER + GLITCH DESYNC + ANTI-KICK
-- ═══════════════════════════════════════════════════════════════════════════════
Anti.AntiHeadsit.startFn = function()
    if Anti.AntiHeadsit.enabled then return end
    Anti.AntiHeadsit.enabled = true
    if Anti.AntiHeadsit.steppedConn then Anti.AntiHeadsit.steppedConn:Disconnect() end
    Anti.AntiHeadsit.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.AntiHeadsit.enabled then return end
        if isActivelyWeldedOrFlinging() or deflectBusy or (RewindSys and RewindSys.rewinding) then return end
        local now = tick()
        if now - (Anti.AntiHeadsit.lastEvade or 0) < 0.35 then return end
        local myChar = LP.Character
        local myRoot = getRootPart(myChar)
        if not myRoot then return end
        local savedCF = myRoot.CFrame
        local faceZone = savedCF * CFrame.new(0, 0, -1.75)
        local backZone = savedCF * CFrame.new(0, 0, 1.75)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local tRoot = getRootPart(p.Character)
                if tRoot then
                    local tp = tRoot.Position
                    local dy = tp.Y - savedCF.Position.Y
                    local tHum = p.Character:FindFirstChildOfClass("Humanoid")
                    local isHostilePose = tHum and (tHum.Sit or tHum.PlatformStand or tHum:GetState() == Enum.HumanoidStateType.Physics or tRoot.AssemblyLinearVelocity.Magnitude > 30)
                    local isHeadsitting = isHostilePose and (math.abs(tp.X - savedCF.Position.X) <= 2.2 and math.abs(tp.Z - savedCF.Position.Z) <= 2.2 and dy >= 1.15 and dy <= 4.8)
                    local isFacebanging = isHostilePose and (((tp - faceZone.Position).Magnitude <= 1.65) or ((tp - backZone.Position).Magnitude <= 1.55))
                    if (isHeadsitting or isFacebanging) and (now - LastVoidActionEnd > 2.0) then
                        Anti.AntiHeadsit.lastEvade = now
                        Anti.AntiHeadsit.evadedCount = (Anti.AntiHeadsit.evadedCount or 0) + 1
                        pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
                        task.spawn(function()
                            pcall(function()
                                markIntentionalTeleport(savedCF)
                                myRoot.CFrame = CFrame.new(savedCF.Position.X, math.clamp(OriginalFPDH - 180, -950, -350), savedCF.Position.Z)
                                task.wait(0.18)
                                if myRoot and myRoot.Parent and not isActivelyWeldedOrFlinging() then
                                    markIntentionalTeleport(savedCF)
                                    myRoot.AssemblyLinearVelocity = Vector3.zero
                                    myRoot.AssemblyAngularVelocity = Vector3.zero
                                    myRoot.CFrame = savedCF
                                end
                            end)
                        end)
                        break
                    end
                end
            end
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Headsit & Anti-Facebang Evader (Full Library) ON")
    sToggleOn()
end

Anti.AntiHeadsit.stopFn = function()
    if not Anti.AntiHeadsit.enabled then return end
    Anti.AntiHeadsit.enabled = false
    if Anti.AntiHeadsit.steppedConn then Anti.AntiHeadsit.steppedConn:Disconnect(); Anti.AntiHeadsit.steppedConn = nil end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Headsit & Anti-Facebang disabled")
    sToggleOff()
end

Anti.GlitchDesync.startFn = function()
    if Anti.GlitchDesync.enabled then return end
    Anti.GlitchDesync.enabled = true
    pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
    local myChar = LP.Character
    local myRoot = getRootPart(myChar)
    if myRoot then
        Anti.GlitchDesync.realCF = myRoot.CFrame
        Anti.GlitchDesync.realVel = myRoot.AssemblyLinearVelocity
        Anti.GlitchDesync.realRot = myRoot.AssemblyAngularVelocity
    end
    if Anti.GlitchDesync.steppedConn then Anti.GlitchDesync.steppedConn:Disconnect() end
    Anti.GlitchDesync.steppedConn = RunService.Stepped:Connect(function()
        if not Anti.GlitchDesync.enabled then return end
        if isActivelyWeldedOrFlinging() or deflectBusy or (RewindSys and RewindSys.rewinding) then return end
        local r = getRootPart(LP.Character)
        if r and Anti.GlitchDesync.realCF then
            r.CFrame = Anti.GlitchDesync.realCF
            local rv = Anti.GlitchDesync.realVel
            if rv and rv.Magnitude < 1 then rv = Vector3.new(0, 0.05, 0) end
            r.AssemblyLinearVelocity = rv or Vector3.zero
            r.AssemblyAngularVelocity = Anti.GlitchDesync.realRot or Vector3.zero
        end
    end)
    pcall(function() RunService:UnbindFromRenderStep("KhamanGlitchRestore") end)
    pcall(function()
        RunService:BindToRenderStep("KhamanGlitchRestore", 1, function()
            if not Anti.GlitchDesync.enabled then return end
            if isActivelyWeldedOrFlinging() or deflectBusy or (RewindSys and RewindSys.rewinding) then return end
            local r = getRootPart(LP.Character)
            if r and Anti.GlitchDesync.realCF then
                r.CFrame = Anti.GlitchDesync.realCF
                local rv = Anti.GlitchDesync.realVel
                if rv and rv.Magnitude < 1 then rv = Vector3.new(0, 0.05, 0) end
                r.AssemblyLinearVelocity = rv or Vector3.zero
                r.AssemblyAngularVelocity = Anti.GlitchDesync.realRot or Vector3.zero
            end
        end)
    end)
    if Anti.GlitchDesync.heartbeatConn then Anti.GlitchDesync.heartbeatConn:Disconnect() end
    Anti.GlitchDesync.heartbeatConn = RunService.Heartbeat:Connect(function()
        if not Anti.GlitchDesync.enabled then return end
        if isActivelyWeldedOrFlinging() or deflectBusy or (RewindSys and RewindSys.rewinding) then return end
        local r = getRootPart(LP.Character)
        if not r then return end
        Anti.GlitchDesync.realCF = r.CFrame
        Anti.GlitchDesync.realVel = r.AssemblyLinearVelocity
        Anti.GlitchDesync.realRot = r.AssemblyAngularVelocity
        local rx = math.random(-50000, 50000)
        local ry = math.random(50, 1000)
        local rz = math.random(-50000, 50000)
        local ox = math.random(-100, 100)
        local oy = math.random(12, 145)
        local oz = math.random(-100, 100)
        local spoofCF = CFrame.new(r.Position) * CFrame.Angles(0, math.random(0, 314) / 100, 0) + Vector3.new(ox, oy, oz)
        markIntentionalTeleport(Anti.GlitchDesync.realCF)
        r.AssemblyLinearVelocity = Vector3.new(rx, ry, rz)
        r.AssemblyAngularVelocity = Vector3.new(rx, ry, rz)
        r.CFrame = spoofCF
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Bang Glitch Desync (Evade Bangs) ON")
    sToggleOn()
end

Anti.GlitchDesync.stopFn = function()
    if not Anti.GlitchDesync.enabled then return end
    Anti.GlitchDesync.enabled = false
    pcall(function() RunService:UnbindFromRenderStep("KhamanGlitchRestore") end)
    if Anti.GlitchDesync.steppedConn then Anti.GlitchDesync.steppedConn:Disconnect(); Anti.GlitchDesync.steppedConn = nil end
    if Anti.GlitchDesync.heartbeatConn then Anti.GlitchDesync.heartbeatConn:Disconnect(); Anti.GlitchDesync.heartbeatConn = nil end
    local r = getRootPart(LP.Character)
    if r and Anti.GlitchDesync.realCF then
        markIntentionalTeleport(Anti.GlitchDesync.realCF)
        r.CFrame = Anti.GlitchDesync.realCF
        r.AssemblyLinearVelocity = Anti.GlitchDesync.realVel or Vector3.zero
        r.AssemblyAngularVelocity = Anti.GlitchDesync.realRot or Vector3.zero
    end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Bang Glitch Desync disabled")
    sToggleOff()
end

Anti.Kick.startFn = function()
    if Anti.Kick.enabled then return end
    Anti.Kick.enabled = true
    pcall(function()
        if type(hookfunction) == "function" and LP and LP.Kick and not Anti.Kick.hooked then
            Anti.Kick.hooked = true
            local origKick
            origKick = hookfunction(LP.Kick, function(selfArg, ...)
                if Anti.Kick.enabled and selfArg == LP then
                    Anti.Kick.blockedKicks = (Anti.Kick.blockedKicks or 0) + 1
                    local reason = tostring(... or "Client Kick")
                    notify("KHAMAN DHOKLA", "🛡️ Anti-Kick blocked: " .. reason:sub(1, 36))
                    return nil
                end
                return origKick(selfArg, ...)
            end)
            Anti.Kick.originalKick = origKick
        end
    end)
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Kick (Client Kick Interceptor) ON")
    sToggleOn()
end

Anti.Kick.stopFn = function()
    if not Anti.Kick.enabled then return end
    Anti.Kick.enabled = false
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Anti-Kick disabled")
    sToggleOff()
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 14. ADVANCED DEFENCE TROLL MATRIX V3 (6 COUNTER-MODES + OMNI-THREAT RADAR)
-- ═══════════════════════════════════════════════════════════════════════════════
local function findBestRedirectVictim(attacker)
    local myChar = LP.Character
    local myRoot = getRootPart(myChar)
    if not myRoot then return nil end
    local bestPlr, bestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p ~= attacker and p.Character then
            local r = getRootPart(p.Character)
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
    if deflectBusy or isActivelyWeldedOrFlinging() then return end
    local myChar = LP.Character
    local myRoot = getRootPart(myChar)
    local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
    if not myRoot or not myHum or myHum.Health <= 0 then return end
    if not attacker or not attacker.Character then return end
    local attRoot = pickTargetRef(attacker.Character, "torso")
    if not attRoot then return end

    deflectBusy = true
    DefenceTroll.deflectCount = DefenceTroll.deflectCount + 1
    DefenceTroll.lastAttackerName = attacker.Name
    DefenceTroll.lastThreatReason = threatReason or "Proximity/Troll"

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

    severAllHostileAttachments()
    for _, part in ipairs(getCachedCharParts(myChar)) do
        if part.Parent then
            part.CanCollide = false
            part.CanTouch = false
            part.Massless = true
        end
    end

    local alertMsg = "🛡️ " .. (DefenceTroll.modeLabels[mode] or mode) .. " -> " .. attacker.Name .. " (" .. tostring(DefenceTroll.lastThreatReason) .. ")"
    notify("KHAMAN DHOKLA", alertMsg)
    if showDefenceToast then showDefenceToast(alertMsg) end
    sFling()

    local voidDropY = math.clamp(OriginalFPDH - 155, -780, -340)
    local voidDropCF = CFrame.new(savedCF.Position.X, voidDropY, savedCF.Position.Z)

    if mode == "GodMatrix" then
        for i = 1, 6 do
            if not myRoot.Parent or not attRoot.Parent then break end
            local angle = i * 1.15
            myRoot.CFrame = attRoot.CFrame * CFrame.new(math.cos(angle) * 0.65, 0, math.sin(angle) * 0.65)
                * CFrame.Angles(math.rad(math.random(-180, 180)), angle, math.rad(math.random(-180, 180)))
            myRoot.AssemblyAngularVelocity = Vector3.new(95000, 95000, 95000)
            myRoot.AssemblyLinearVelocity = Vector3.new(math.random(-28000, 28000), -60000, math.random(-28000, 28000))
            RunService.Heartbeat:Wait()
        end
        for _ = 1, 5 do
            if not myRoot.Parent then break end
            myRoot.CFrame = voidDropCF
            myRoot.AssemblyLinearVelocity = Vector3.new(0, -75000, 0)
            myRoot.AssemblyAngularVelocity = Vector3.zero
            RunService.Heartbeat:Wait()
        end
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

RunService.Heartbeat:Connect(function(dt)
    if not DefenceTroll.enabled and not Anti.Redirect.enabled and not Anti.PauseTrap.enabled then
        return
    end
    if isActivelyWeldedOrFlinging() or deflectBusy or (RewindSys and RewindSys.rewinding) then return end

    local myChar = LP.Character
    local myRoot = getRootPart(myChar)
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

                local toMe = (myRoot.Position - tRoot.Position)
                local closingSpeed = (toMe.Magnitude > 0.01) and vel:Dot(toMe.Unit) or 0

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
    notify("KHAMAN DHOKLA", "Troll Redirect ON (transfers attackers to another player)")
    sToggleOn()
end
redirectStop = function()
    Anti.Redirect.enabled = false
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Troll Redirect disabled")
    sToggleOff()
end
Anti.Redirect.startFn = redirectStart
Anti.Redirect.stopFn  = redirectStop

pauseTrapStart = function()
    Anti.PauseTrap.enabled = true
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Void-Pause Trap ON (banishes welded attackers)")
    sToggleOn()
end
pauseTrapStop = function()
    Anti.PauseTrap.enabled = false
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Void-Pause Trap disabled")
    sToggleOff()
end
Anti.PauseTrap.startFn = pauseTrapStart
Anti.PauseTrap.stopFn  = pauseTrapStop

defenceTrollStart = function()
    DefenceTroll.enabled = true
    flingShieldStart()
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Defence Troll Matrix v3 ON: " .. (DefenceTroll.modeLabels[DefenceTroll.mode] or DefenceTroll.mode))
    sToggleOn()
end
defenceTrollStop = function()
    DefenceTroll.enabled = false
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    notify("KHAMAN DHOKLA", "Defence Troll Matrix OFF")
    sToggleOff()
end
DefenceTroll.startFn = defenceTrollStart
DefenceTroll.stopFn  = defenceTrollStop

-- Permanent Always-On Core Enforcer: guarantees Anti-Sit, Anti-Void, Anti-Lag, and Anti-Freeze are enabled 100% of the time!
Anti.enforceAlwaysOn = function(silent)
    avStart(silent ~= false)
    Anti.InfFallVoid.startFn(silent ~= false)
    ragdollStart(silent ~= false)
    Anti.SeatTrap.startFn(silent ~= false)
    lagStart(silent ~= false)
    anchorStart(silent ~= false)
    agpStart(silent ~= false)
end

enableAllAntiSystems = function()
    Anti.enforceAlwaysOn(true)
    defenceTrollStart()
    akStart()
    flingShieldStart()
    attachStart()
    blindStart()
    bringStart()
    if Anti.ToolGuard.startFn then Anti.ToolGuard.startFn() end
    if Anti.Kick.startFn then Anti.Kick.startFn() end
    afkStart()
    if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    notify("KHAMAN DHOKLA", "🛡️ ALL FULL-LIBRARY V4 ANTI SHIELDS ACTIVATED!")
    sSuccess()
end

disableAllAntiSystems = function()
    defenceTrollStop()
    redirectStop()
    pauseTrapStop()
    akStop()
    flingShieldStop()
    attachStop()
    blindStop()
    bringStop()
    if Anti.ToolGuard.stopFn then Anti.ToolGuard.stopFn() end
    if Anti.AntiHeadsit.stopFn then Anti.AntiHeadsit.stopFn() end
    if Anti.GlitchDesync.stopFn then Anti.GlitchDesync.stopFn() end
    if Anti.Kick.stopFn then Anti.Kick.stopFn() end
    afkStop()
    vcStop()
    -- Re-enforce Always-On Core Shields (Anti-Sit, Anti-Void, Anti-Lag, Anti-Freeze stay enabled 24/7!)
    Anti.enforceAlwaysOn(true)
    if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
    if syncAllAntiButtons then pcall(syncAllAntiButtons) end
    if syncAllActiveIndicators then pcall(syncAllActiveIndicators) end
    notify("KHAMAN DHOKLA", "Optional shields off · Core Anti-Sit/Void/Lag/Freeze remain ALWAYS-ON!")
    sToggleOff()
end

Anti.enableAll  = enableAllAntiSystems
Anti.disableAll = disableAllAntiSystems

-- Immediately boot Always-On Core Shields (Anti-Sit, Anti-Void, Anti-Lag, Anti-Freeze) and run 0.75s Self-Healing Watchdog
Anti.enforceAlwaysOn(true)
do
    local lastCoreCheck = 0
    RunService.Heartbeat:Connect(function()
        local now = tick()
        if now - lastCoreCheck < 0.75 then return end
        lastCoreCheck = now
        if Anti.AlwaysOnCore then
            if not Anti.Void.enabled or not Anti.Void.steppedConn then avStart(true) end
            if not Anti.InfFallVoid.enabled then Anti.InfFallVoid.startFn(true) end
            if not Anti.Ragdoll.enabled or not Anti.Ragdoll.steppedConn then ragdollStart(true) end
            if not Anti.SeatTrap.enabled or not Anti.SeatTrap.wsDescConn then Anti.SeatTrap.startFn(true) end
            if not Anti.Lag.enabled or not Anti.Lag.loopConn then lagStart(true) end
            if not Anti.Anchor.enabled or not Anti.Anchor.steppedConn then anchorStart(true) end
            if not Anti.GamePaused.enabled or not Anti.GamePaused.loopConn then agpStart(true) end
        end
    end)
end
end)() -- end Anti internal scope

local function buildMainUI()
    local currentCamInit = workspace.CurrentCamera or cam
    local vp = currentCamInit and currentCamInit.ViewportSize or Vector2.new(1280, 720)
    local screenW = (vp and vp.X > 300) and vp.X or 1280
    local screenH = (vp and vp.Y > 300) and vp.Y or 720

    -- Refined, balanced window dimensions with generous breathing room on both Android & PC
    local function computeWindowSize(sw, sh)
        local w = math.clamp(sw - 28, 316, sw >= 900 and 444 or 376)
        local h = math.clamp(math.floor(sh * 0.52), 336, 412)
        return w, h
    end

    local W, H = computeWindowSize(screenW, screenH)
    local uiState = { minimized = false, open = true }
    local dragging, dragStart, startPos
    local panelShadow

    gui = Instance.new("ScreenGui")
    gui.Name = "KhamanDhoklaV37"
    gui.ResetOnSpawn = false
    gui.Enabled = true
    gui.DisplayOrder = 999999
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.IgnoreGuiInset = true
    local mountOk = pcall(function() gui.Parent = GuiParent end)
    if not mountOk or not gui.Parent then
        local playerGui = LP:FindFirstChildOfClass("PlayerGui") or LP:WaitForChild("PlayerGui", 8)
        if not playerGui then error("No usable PlayerGui found while mounting KHAMAN DHOKLA ScreenGui") end
        gui.Parent = playerGui
    end

    -- Floating Void Throw / Fling Status & Quick-Stop Side Panel
    FlingSidePanel = Instance.new("Frame")
    FlingSidePanel.Name = "KhamanFlingHUD"
    FlingSidePanel.Size = UDim2.new(0, 216, 0, 54)
    FlingSidePanel.Position = UDim2.new(0.5, -108, 0, 14)
    FlingSidePanel.BackgroundColor3 = T.BG2
    FlingSidePanel.BackgroundTransparency = 0.04
    FlingSidePanel.BorderSizePixel = 0
    FlingSidePanel.Visible = false
    FlingSidePanel.ZIndex = 960
    FlingSidePanel.Parent = gui
    Instance.new("UICorner", FlingSidePanel).CornerRadius = UDim.new(0, 10)
    do
        local fSt = Instance.new("UIStroke")
        fSt.Color = T.Accent
        fSt.Thickness = 1.6
        fSt.Parent = FlingSidePanel

        FlingCountdownLabel = Instance.new("TextLabel")
        FlingCountdownLabel.Size = UDim2.new(1, -78, 1, -8)
        FlingCountdownLabel.Position = UDim2.new(0, 10, 0, 4)
        FlingCountdownLabel.BackgroundTransparency = 1
        FlingCountdownLabel.Text = "VOID LOCK ACTIVE"
        FlingCountdownLabel.TextColor3 = T.Neon
        FlingCountdownLabel.Font = Enum.Font.GothamBold
        FlingCountdownLabel.TextSize = 11
        FlingCountdownLabel.TextXAlignment = Enum.TextXAlignment.Left
        FlingCountdownLabel.ZIndex = 961
        FlingCountdownLabel.Parent = FlingSidePanel

        local fStopBtn = Instance.new("TextButton")
        fStopBtn.Size = UDim2.new(0, 58, 0, 34)
        fStopBtn.Position = UDim2.new(1, -66, 0.5, -17)
        fStopBtn.BackgroundColor3 = T.Danger
        fStopBtn.Text = "STOP"
        fStopBtn.TextColor3 = Color3.new(1, 1, 1)
        fStopBtn.Font = Enum.Font.GothamBold
        fStopBtn.TextSize = 10
        fStopBtn.ZIndex = 962
        fStopBtn.Parent = FlingSidePanel
        Instance.new("UICorner", fStopBtn).CornerRadius = UDim.new(0, 7)
        fStopBtn.MouseButton1Click:Connect(function()
            sClick()
            StateManager:StopFling(false)
            notify("KHAMAN DHOKLA", "Stopped fling & returned to safe spot!")
        end)
    end

    -- Floating KD Dhokla Cube Launcher (shown when panel is minimized)
    local mobToggle = Instance.new("TextButton")
    mobToggle.Name = "KhamanDhoklaLauncher"
    mobToggle.Size = UDim2.new(0, 46, 0, 46)
    mobToggle.Position = UDim2.new(0, 14, 0.5, -23)
    mobToggle.BackgroundColor3 = Color3.fromRGB(242, 188, 18)
    mobToggle.BackgroundTransparency = 0.02
    mobToggle.Text = "KD"
    mobToggle.TextColor3 = Color3.fromRGB(24, 16, 4)
    mobToggle.Font = Enum.Font.GothamBlack
    mobToggle.TextSize = 14
    mobToggle.AutoButtonColor = false
    mobToggle.Active = true
    mobToggle.ZIndex = 999
    mobToggle.Visible = false
    mobToggle.Parent = gui
    Instance.new("UICorner", mobToggle).CornerRadius = UDim.new(0, 12)

    local mobStroke = Instance.new("UIStroke")
    mobStroke.Color = T.Neon
    mobStroke.Thickness = 1.8
    mobStroke.Transparency = 0.08
    mobStroke.Parent = mobToggle

    local launcherDot = Instance.new("Frame")
    launcherDot.Size = UDim2.new(0, 9, 0, 9)
    launcherDot.Position = UDim2.new(1, -10, 1, -10)
    launcherDot.BackgroundColor3 = T.Success
    launcherDot.BorderSizePixel = 0
    launcherDot.ZIndex = 1000
    launcherDot.Parent = mobToggle
    Instance.new("UICorner", launcherDot).CornerRadius = UDim.new(1, 0)

    -- Main Khaman Dhokla Script Panel Container
    local main = Instance.new("Frame")
    main.Name = "KhamanDhoklaDashboard"
    main.Size = UDim2.new(0, W, 0, H)
    main.Position = UDim2.new(0.5, -W/2, 0.56, -H/2)
    main.BackgroundColor3 = Color3.fromRGB(44, 33, 9)
    main.BackgroundTransparency = 0.02
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Active = true
    main.ZIndex = 5
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

    local mainScale = Instance.new("UIScale")
    mainScale.Scale = 1
    mainScale.Parent = main

    -- Rich Multi-Layer Khaman Dhokla Background (Turmeric Gradient + Top Specular Bar + Sponge & Tadka Garnish)
    do
        local mainGrad = Instance.new("UIGradient")
        mainGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(82, 62, 15)),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(48, 36, 10)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(30, 22, 6)),
        })
        mainGrad.Rotation = 135
        mainGrad.Parent = main

        local topGlowBar = Instance.new("Frame")
        topGlowBar.Name = "TopTurmericGlow"
        topGlowBar.Size = UDim2.new(1, 0, 0, 2)
        topGlowBar.Position = UDim2.new(0, 0, 0, 0)
        topGlowBar.BackgroundColor3 = T.Accent
        topGlowBar.BorderSizePixel = 0
        topGlowBar.ZIndex = 12
        topGlowBar.Parent = main
        local tgGrad = Instance.new("UIGradient")
        tgGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(217, 138, 10)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(254, 243, 148)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(42, 196, 88)),
        })
        tgGrad.Parent = topGlowBar

        local dhoklaBg = Instance.new("Frame")
        dhoklaBg.Name = "KhamanDhoklaSpongeTexture"
        dhoklaBg.Size = UDim2.new(1, 0, 1, 0)
        dhoklaBg.BackgroundTransparency = 1
        dhoklaBg.ZIndex = 5
        dhoklaBg.Active = false
        dhoklaBg.Parent = main

        local specks = {
            -- Golden spongy air pockets
            { x = 0.07, y = 0.27, sz = 14, col = Color3.fromRGB(250, 204, 21), tr = 0.89 },
            { x = 0.21, y = 0.44, sz = 10, col = Color3.fromRGB(250, 204, 21), tr = 0.91 },
            { x = 0.47, y = 0.32, sz = 18, col = Color3.fromRGB(250, 204, 21), tr = 0.90 },
            { x = 0.73, y = 0.25, sz = 12, col = Color3.fromRGB(250, 204, 21), tr = 0.89 },
            { x = 0.88, y = 0.51, sz = 16, col = Color3.fromRGB(250, 204, 21), tr = 0.89 },
            { x = 0.15, y = 0.75, sz = 15, col = Color3.fromRGB(250, 204, 21), tr = 0.90 },
            { x = 0.62, y = 0.71, sz = 13, col = Color3.fromRGB(250, 204, 21), tr = 0.90 },
            { x = 0.83, y = 0.81, sz = 11, col = Color3.fromRGB(250, 204, 21), tr = 0.89 },
            -- Roasted black mustard seeds (Rai tadka)
            { x = 0.12, y = 0.35, sz = 4,  col = Color3.fromRGB(16, 12, 4),    tr = 0.42 },
            { x = 0.34, y = 0.24, sz = 5,  col = Color3.fromRGB(16, 12, 4),    tr = 0.42 },
            { x = 0.57, y = 0.47, sz = 4,  col = Color3.fromRGB(16, 12, 4),    tr = 0.42 },
            { x = 0.80, y = 0.37, sz = 5,  col = Color3.fromRGB(16, 12, 4),    tr = 0.42 },
            { x = 0.28, y = 0.67, sz = 4,  col = Color3.fromRGB(16, 12, 4),    tr = 0.42 },
            { x = 0.71, y = 0.63, sz = 5,  col = Color3.fromRGB(16, 12, 4),    tr = 0.42 },
            -- Fresh coriander / curry leaf green garnish flecks
            { x = 0.18, y = 0.28, sz = 6,  col = Color3.fromRGB(42, 196, 88),  tr = 0.70 },
            { x = 0.66, y = 0.30, sz = 7,  col = Color3.fromRGB(42, 196, 88),  tr = 0.70 },
            { x = 0.41, y = 0.78, sz = 6,  col = Color3.fromRGB(42, 196, 88),  tr = 0.70 },
            { x = 0.90, y = 0.66, sz = 6,  col = Color3.fromRGB(42, 196, 88),  tr = 0.70 },
        }
        for _, sp in ipairs(specks) do
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0, sp.sz, 0, sp.sz)
            dot.Position = UDim2.new(sp.x, 0, sp.y, 0)
            dot.BackgroundColor3 = sp.col
            dot.BackgroundTransparency = sp.tr
            dot.BorderSizePixel = 0
            dot.ZIndex = 5
            dot.Active = false
            dot.Parent = dhoklaBg
            Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
        end
    end

    panelShadow = Instance.new("Frame")
    panelShadow.Name = "PanelShadow"
    panelShadow.Position = UDim2.new(0.5, -W/2 - 5, 0.56, -H/2 + 5)
    panelShadow.Size = UDim2.new(0, W + 10, 0, H + 10)
    panelShadow.BackgroundColor3 = Color3.fromRGB(14, 10, 2)
    panelShadow.BackgroundTransparency = 0.42
    panelShadow.BorderSizePixel = 0
    panelShadow.ZIndex = 4
    panelShadow.Parent = gui
    Instance.new("UICorner", panelShadow).CornerRadius = UDim.new(0, 18)

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = T.Accent
    mainStroke.Thickness = 1.5
    mainStroke.Transparency = 0.16
    mainStroke.Parent = main

    local function refreshViewportLayout()
        local currentCamera = workspace.CurrentCamera
        if not currentCamera or not main.Parent then return end
        local size = currentCamera.ViewportSize
        local newW, newH = computeWindowSize(size.X, size.Y)
        W, H = newW, newH
        main.Size = UDim2.new(0, newW, 0, newH)
        panelShadow.Size = UDim2.new(0, newW + 10, 0, newH + 10)
        if not dragging then
            main.Position = UDim2.new(0.5, -newW / 2, 0.56, -newH / 2)
            panelShadow.Position = UDim2.new(0.5, -newW / 2 - 5, 0.56, -newH / 2 + 5)
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
        if tick() - lastLauncherToggle < 0.12 then return end
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
                TweenService:Create(b, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = BtnColors[b]:Lerp(T.Neon, 0.12)
                }):Play()
            end
        end)
        b.MouseLeave:Connect(function()
            if BtnColors[b] then
                TweenService:Create(b, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = BtnColors[b]
                }):Play()
            end
        end)
    end

    -- ═══════════════════════════════════════════════════════════════════════════
    -- REFINED HEADER BAR (44px)
    -- ═══════════════════════════════════════════════════════════════════════════
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 44)
    header.BackgroundColor3 = T.BG2
    header.BackgroundTransparency = 0.08
    header.BorderSizePixel = 0
    header.ZIndex = 6
    header.Parent = main

    local headerLine = Instance.new("Frame")
    headerLine.Size = UDim2.new(1, -20, 0, 1)
    headerLine.Position = UDim2.new(0, 10, 1, -1)
    headerLine.BackgroundColor3 = T.Border
    headerLine.BackgroundTransparency = 0.35
    headerLine.BorderSizePixel = 0
    headerLine.ZIndex = 7
    headerLine.Parent = header

    local brandMark = Instance.new("Frame")
    brandMark.Size = UDim2.new(0, 28, 0, 28)
    brandMark.Position = UDim2.new(0, 11, 0.5, -14)
    brandMark.BackgroundColor3 = T.Accent
    brandMark.BorderSizePixel = 0
    brandMark.ZIndex = 8
    brandMark.Parent = header
    Instance.new("UICorner", brandMark).CornerRadius = UDim.new(0, 8)
    local bmStroke = Instance.new("UIStroke")
    bmStroke.Color = T.Neon
    bmStroke.Thickness = 1.2
    bmStroke.Transparency = 0.2
    bmStroke.Parent = brandMark

    local brandGlyph = Instance.new("TextLabel")
    brandGlyph.Size = UDim2.new(1, 0, 1, 0)
    brandGlyph.BackgroundTransparency = 1
    brandGlyph.Text = "KD"
    brandGlyph.TextColor3 = T.Dark
    brandGlyph.Font = Enum.Font.GothamBlack
    brandGlyph.TextSize = 11
    brandGlyph.ZIndex = 9
    brandGlyph.Parent = brandMark

    showDefenceToast = function(msg)
        pcall(function()
            if not gui or not gui.Parent then return end
            local old = gui:FindFirstChild("KhamanDefenceToast")
            if old then old:Destroy() end
            local tFrame = Instance.new("Frame")
            tFrame.Name = "KhamanDefenceToast"
            tFrame.Size = UDim2.new(0, 286, 0, 34)
            tFrame.Position = UDim2.new(0.5, -143, 0, -42)
            tFrame.BackgroundColor3 = T.BG2
            tFrame.BorderSizePixel = 0
            tFrame.ZIndex = 500
            tFrame.Parent = gui
            Instance.new("UICorner", tFrame).CornerRadius = UDim.new(0, 9)
            local tStroke = Instance.new("UIStroke")
            tStroke.Color = T.Accent
            tStroke.Thickness = 1.4
            tStroke.Transparency = 0.15
            tStroke.Parent = tFrame
            local tLbl = Instance.new("TextLabel")
            tLbl.Size = UDim2.new(1, -12, 1, 0)
            tLbl.Position = UDim2.new(0, 6, 0, 0)
            tLbl.BackgroundTransparency = 1
            tLbl.Text = msg
            tLbl.TextColor3 = T.Text
            tLbl.Font = Enum.Font.GothamBold
            tLbl.TextSize = 10
            tLbl.ZIndex = 501
            tLbl.Parent = tFrame
            TweenService:Create(tFrame, TweenInfo.new(0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, -143, 0, 16)
            }):Play()
            task.delay(2.5, function()
                if tFrame and tFrame.Parent then
                    local tw = TweenService:Create(tFrame, TweenInfo.new(0.22), {
                        Position = UDim2.new(0.5, -143, 0, -42),
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
    title.Size = UDim2.new(1, -216, 0, 16)
    title.Position = UDim2.new(0, 46, 0.5, -13)
    title.BackgroundTransparency = 1
    title.Text = "🟨 KHAMAN DHOKLA"
    title.TextColor3 = T.Accent
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 12
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 8
    title.Parent = header

    local subTitle = Instance.new("TextLabel")
    subTitle.Size = UDim2.new(1, -216, 0, 12)
    subTitle.Position = UDim2.new(0, 46, 0.5, 4)
    subTitle.BackgroundTransparency = 1
    subTitle.Text = "ZERO-DELAY V37  ·  " .. (isMobileDevice and "📱 ANDROID" or "💻 PC")
    subTitle.TextColor3 = T.Neon
    subTitle.Font = Enum.Font.GothamMedium
    subTitle.TextSize = 8
    subTitle.TextXAlignment = Enum.TextXAlignment.Left
    subTitle.ZIndex = 8
    subTitle.Parent = header

    -- Live HUD Badge (FPS / Ping / Active Shields)
    local hudBadge = Instance.new("Frame")
    hudBadge.Size = UDim2.new(0, 108, 0, 24)
    hudBadge.Position = UDim2.new(1, -182, 0.5, -12)
    hudBadge.BackgroundColor3 = T.Panel
    hudBadge.BorderSizePixel = 0
    hudBadge.ZIndex = 8
    hudBadge.Parent = header
    Instance.new("UICorner", hudBadge).CornerRadius = UDim.new(0, 7)
    local hudStroke = Instance.new("UIStroke")
    hudStroke.Color = T.Border
    hudStroke.Thickness = 1
    hudStroke.Transparency = 0.4
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
            frameCount = frameCount + 1
            local now = tick()
            if now - lastTime >= 0.75 then
                local fps = math.clamp(math.floor(frameCount / (now - lastTime)), 1, 240)
                frameCount = 0
                lastTime = now
                local activeProtCount = 0
                for _, sub in pairs(Anti) do
                    if typeof(sub) == "table" and sub.enabled then activeProtCount = activeProtCount + 1 end
                end
                if DefenceTroll.enabled then activeProtCount = activeProtCount + 1 end
                local pingMs = 0
                pcall(function() pingMs = math.floor(LP:GetNetworkPing() * 1000) end)
                if hudText and hudText.Parent then
                    if pingMs > 0 then
                        hudText.Text = string.format("%d FPS · %dms · 🛡️%d", fps, pingMs, activeProtCount)
                    else
                        hudText.Text = string.format("%d FPS · 🛡️ %d", fps, activeProtCount)
                    end
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
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
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
            panelShadow.Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset - 5, main.Position.Y.Scale, main.Position.Y.Offset + 5)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- ═══════════════════════════════════════════════════════════════════════════
    -- ANIMATED SLIDING PILL TAB BAR (34px) + DIRECTIONAL QUINT PAGE TRANSITIONS
    -- ═══════════════════════════════════════════════════════════════════════════
    local tabsBar = Instance.new("Frame")
    tabsBar.Name = "TabsBar"
    tabsBar.Size = UDim2.new(1, -20, 0, 34)
    tabsBar.Position = UDim2.new(0, 10, 0, 48)
    tabsBar.BackgroundColor3 = T.BG2
    tabsBar.BorderSizePixel = 0
    tabsBar.ZIndex = 6
    tabsBar.Parent = main
    Instance.new("UICorner", tabsBar).CornerRadius = UDim.new(0, 9)

    local tabsStroke = Instance.new("UIStroke")
    tabsStroke.Color = T.Border
    tabsStroke.Thickness = 1
    tabsStroke.Transparency = 0.4
    tabsStroke.Parent = tabsBar

    -- Sliding Golden Pill Indicator behind the active tab button
    local activeTabPill = Instance.new("Frame")
    activeTabPill.Name = "ActiveTabPill"
    activeTabPill.Size = UDim2.new(0.2, -4, 1, -4)
    activeTabPill.Position = UDim2.new(0, 2, 0, 2)
    activeTabPill.BackgroundColor3 = T.Accent2
    activeTabPill.BorderSizePixel = 0
    activeTabPill.ZIndex = 7
    activeTabPill.Parent = tabsBar
    Instance.new("UICorner", activeTabPill).CornerRadius = UDim.new(0, 7)
    do
        local pillGrad = Instance.new("UIGradient")
        pillGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(245, 178, 18)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(204, 122, 8)),
        })
        pillGrad.Rotation = 90
        pillGrad.Parent = activeTabPill

        local pillSt = Instance.new("UIStroke")
        pillSt.Color = T.Neon
        pillSt.Thickness = 1
        pillSt.Transparency = 0.25
        pillSt.Parent = activeTabPill
    end

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, 0, 1, -126)
    content.Position = UDim2.new(0, 0, 0, 86)
    content.BackgroundTransparency = 1
    content.ClipsDescendants = true
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
    fTop.Size = UDim2.new(1, -20, 0, 1)
    fTop.Position = UDim2.new(0, 10, 0, 0)
    fTop.BackgroundColor3 = T.Border
    fTop.BackgroundTransparency = 0.38
    fTop.BorderSizePixel = 0
    fTop.ZIndex = 7
    fTop.Parent = footer

    local footerDot = Instance.new("Frame")
    footerDot.Size = UDim2.new(0, 8, 0, 8)
    footerDot.Position = UDim2.new(0, 12, 0.5, -4)
    footerDot.BackgroundColor3 = T.Success
    footerDot.BorderSizePixel = 0
    footerDot.ZIndex = 8
    footerDot.Parent = footer
    Instance.new("UICorner", footerDot).CornerRadius = UDim.new(1, 0)

    local footerLabel = Instance.new("TextLabel")
    footerLabel.Size = UDim2.new(1, -148, 0, 16)
    footerLabel.Position = UDim2.new(0, 26, 0, 5)
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
    footerSub.Position = UDim2.new(0, 26, 0, 21)
    footerSub.BackgroundTransparency = 1
    footerSub.Text = "ready · zero-delay lock active"
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
    Instance.new("UICorner", btnUnweld).CornerRadius = UDim.new(0, 7)
    styleBtn(btnUnweld, T.Accent2)

    local TabPages, TabButtons, TabIndices = {}, {}, {}
    local tabOrderNames = {}
    local currentTabName = nil
    local tabTransitionGen = 0

    -- Smooth Directional Quint Slide + Scrollbar Fade Page Transition
    local function showTab(name)
        if not TabPages[name] then return end
        local oldName = currentTabName
        currentTabName = name
        local newIdx = TabIndices[name] or 1
        local oldIdx = (oldName and TabIndices[oldName]) or newIdx
        local total = math.max(1, #tabOrderNames)
        local wScale = 1 / total

        -- Glide the golden active tab pill smoothly to the selected tab
        TweenService:Create(activeTabPill, TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(wScale, -4, 1, -4),
            Position = UDim2.new((newIdx - 1) * wScale, 2, 0, 2),
        }):Play()

        for n, b in pairs(TabButtons) do
            local act = (n == name)
            TweenService:Create(b, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextColor3 = act and T.Dark or T.Muted,
            }):Play()
        end

        if oldName == name then
            TabPages[name].Position = UDim2.new(0, 0, 0, 0)
            TabPages[name].Visible = true
            return
        end

        tabTransitionGen = tabTransitionGen + 1
        local myTransGen = tabTransitionGen
        local dir = (newIdx >= oldIdx) and 1 or -1

        for n, p in pairs(TabPages) do
            if n ~= name and n ~= oldName then
                p.Visible = false
            end
        end

        local inPage = TabPages[name]
        local outPage = oldName and TabPages[oldName] or nil

        if outPage and outPage ~= inPage then
            TweenService:Create(outPage, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.new(-0.08 * dir, 0, 0, 0),
            }):Play()
            task.delay(0.18, function()
                if myTransGen == tabTransitionGen and currentTabName ~= oldName then
                    outPage.Visible = false
                    outPage.Position = UDim2.new(0, 0, 0, 0)
                end
            end)
        end

        inPage.Position = UDim2.new(0.10 * dir, 0, 0, 6)
        inPage.Visible = true
        TweenService:Create(inPage, TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 0, 0, 0),
        }):Play()
    end

    local function createTab(name)
        table.insert(tabOrderNames, name)
        local myIdx = #tabOrderNames
        TabIndices[name] = myIdx

        local btn = Instance.new("TextButton")
        btn.Name = name .. "TabBtn"
        btn.BackgroundTransparency = 1
        btn.BorderSizePixel = 0
        btn.Text = name:upper()
        btn.TextColor3 = T.Muted
        btn.Font = Enum.Font.GothamBlack
        btn.TextSize = 10
        btn.AutoButtonColor = false
        btn.ZIndex = 8
        btn.Parent = tabsBar
        btn.MouseButton1Click:Connect(function() sClick(); showTab(name) end)
        TabButtons[name] = btn

        local total = #tabOrderNames
        for i, tabName in ipairs(tabOrderNames) do
            local tb = TabButtons[tabName]
            local wScale = 1 / total
            tb.Size = UDim2.new(wScale, -4, 1, -4)
            tb.Position = UDim2.new((i - 1) * wScale, 2, 0, 2)
        end
        activeTabPill.Size = UDim2.new(1 / total, -4, 1, -4)

        local page = Instance.new("ScrollingFrame")
        page.Name = name .. "Page"
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 3
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
        notify("KHAMAN DHOKLA", "Auto-Nearest Player mode active")
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
    local PILL_BG_ON = Color3.fromRGB(32, 156, 72)
    do -- Scoped block for Weld Tab Presets & Floating Pills (preserves buildMainUI local register budget)
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

    local PILL_BG_OFF       = Color3.fromRGB(48, 36, 11)
    local PILL_STROKE_OFF   = Color3.fromRGB(185, 142, 24)
    local PILL_DOT_OFF      = Color3.fromRGB(168, 132, 36)
    local PILL_DOT_RING_OFF = Color3.fromRGB(234, 179, 8)
    local PILL_TXT_OFF      = Color3.fromRGB(255, 251, 235)

    PILL_BG_ON              = Color3.fromRGB(32, 156, 72)
    local PILL_STROKE_ON    = Color3.fromRGB(250, 204, 21)
    local PILL_DOT_ON       = Color3.fromRGB(254, 240, 138)
    local PILL_DOT_RING_ON  = Color3.fromRGB(255, 255, 255)
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
                Anti.FlingShield.startFn()
                notify("KHAMAN DHOKLA", "Defence Troll ON (" .. (DefenceTroll.modeLabels[DefenceTroll.mode] or DefenceTroll.mode) .. ")")
            else
                Anti.FlingShield.stopFn()
                notify("KHAMAN DHOKLA", "Defence Troll OFF")
            end
            syncAllActiveIndicators()
            if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
            return
        end
        if key == "voidthrow" then
            if FlingActive then
                StateManager:StopFling(false)
                notify("KHAMAN DHOKLA", "Void Throw stopped & safely returned")
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
                notify("KHAMAN DHOKLA", "Fling stopped & safely returned")
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
            notify("KHAMAN DHOKLA", (WELD_PRESETS[key] and WELD_PRESETS[key].label or key) .. " stopped")
            return
        end

        local targetPlr, usedNearest = resolveActiveTarget()
        if not targetPlr or targetPlr.Parent ~= Players then
            notify("KHAMAN DHOKLA", "No target player found in server!")
            sError()
            syncAllActiveIndicators()
            return
        end

        StateManager:Cleanup(true, true)
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
            notify("KHAMAN DHOKLA", prefix .. targetPlr.Name)
        else
            syncAllActiveIndicators()
            sError()
            notify("KHAMAN DHOKLA", "Failed — reference part missing")
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

    -- Advanced Live Weld & Target Utility Bar (Speed, Distance, Height, Reset, TP, Spectate)
    sectionLbl(weldTab, 10, "LIVE TROLL & WELD TUNER  (ZERO-DELAY HEIGHT / DIST / SPEED)", T.Accent)
    local tunerRow = Instance.new("Frame")
    tunerRow.Size = UDim2.new(1, 0, 0, 28)
    tunerRow.BackgroundTransparency = 1
    tunerRow.LayoutOrder = 11
    tunerRow.ZIndex = 7
    tunerRow.Parent = weldTab

    local tunerRow2 = Instance.new("Frame")
    tunerRow2.Size = UDim2.new(1, 0, 0, 28)
    tunerRow2.BackgroundTransparency = 1
    tunerRow2.LayoutOrder = 12
    tunerRow2.ZIndex = 7
    tunerRow2.Parent = weldTab

    local speedCycle = { 0.6, 1.0, 1.6, 2.5, 4.0, 5.5 }
    local speedIdx = 2
    local function makeTunerBtn(parentRow, xScale, wScale, label, onClick)
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
        b.Parent = parentRow
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        styleBtn(b, T.PanelLt)
        b.MouseButton1Click:Connect(function()
            sClick()
            onClick(b)
        end)
        return b
    end

    makeTunerBtn(tunerRow, 0.00, 0.28, "SPEED: 1.0x", function(btn)
        speedIdx = (speedIdx % #speedCycle) + 1
        V.Speed = speedCycle[speedIdx]
        btn.Text = string.format("SPEED: %.1fx", V.Speed)
    end)
    makeTunerBtn(tunerRow, 0.28, 0.18, "DIST -", function()
        V.Z = math.clamp((V.Z or 1.3) - 0.25, -3.5, 6.0)
    end)
    makeTunerBtn(tunerRow, 0.46, 0.18, "DIST +", function()
        V.Z = math.clamp((V.Z or 1.3) + 0.25, -3.5, 6.0)
    end)
    makeTunerBtn(tunerRow, 0.64, 0.18, "HEIGHT -", function()
        V.Y = math.clamp((V.Y or 0) - 0.25, -4.0, 4.0)
    end)
    makeTunerBtn(tunerRow, 0.82, 0.18, "HEIGHT +", function()
        V.Y = math.clamp((V.Y or 0) + 0.25, -4.0, 4.0)
    end)

    makeTunerBtn(tunerRow2, 0.00, 0.34, "RESET OFFSET", function()
        V.X = 0; V.Y = 0; V.Z = 1.3
        notify("KHAMAN DHOKLA", "Height & Distance offsets reset to default")
    end)
    makeTunerBtn(tunerRow2, 0.34, 0.34, "⚡ SEEK & TP", function()
        local tgt = resolveActiveTarget()
        if not tgt or tgt.Parent ~= Players then
            notify("KHAMAN DHOKLA", "No target player in server!")
            sError()
            return
        end
        task.spawn(function()
            local _, tRef = streamAndTeleportToTarget(tgt, "torso", 2.2, true)
            if tRef and tRef.Parent then
                local destCF = tRef.CFrame * CFrame.new(0, 1.5, 2.5)
                markIntentionalTeleport(destCF)
                safeReturnFromVoid(LP.Character, destCF)
                notify("KHAMAN DHOKLA", "Teleported to " .. tgt.Name .. "!")
                sSuccess()
            else
                local fallbackCF = getBestTargetCFrame(tgt)
                if fallbackCF then
                    markIntentionalTeleport(fallbackCF)
                    safeReturnFromVoid(LP.Character, fallbackCF * CFrame.new(0, 2, 0))
                    notify("KHAMAN DHOKLA", "Teleported to " .. tgt.Name .. "'s hidden zone!")
                    sSuccess()
                else
                    notify("KHAMAN DHOKLA", "Target is respawning — enable Auto-Chase to lock on!")
                    sError()
                end
            end
        end)
    end)
    makeTunerBtn(tunerRow2, 0.68, 0.32, "👁️ VIEW: OFF", function(btn)
        SpectatingTarget = not SpectatingTarget
        local currentCam = workspace.CurrentCamera
        if SpectatingTarget then
            local tgt = resolveActiveTarget()
            local tChar = tgt and findPlayerCharacterAnywhere(tgt)
            local tSubj = tChar and (tChar:FindFirstChildOfClass("Humanoid") or getRootPart(tChar))
            if currentCam and tSubj then
                currentCam.CameraSubject = tSubj
                btn.Text = "👁️ VIEW: ON"
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
        btn.Text = "👁️ VIEW: OFF"
        BtnColors[btn] = T.PanelLt
        btn.BackgroundColor3 = T.PanelLt
    end)

    -- Spawn the 3 default floating icons matching the reference screenshot (Pat, Headsit, Facebang)
    addFloatingPill("headpat")
    addFloatingPill("headsit")
    addFloatingPill("facebang")
    addFloatingPill("voidthrow")
    addFloatingPill("rewind")
    end -- end Weld Tab Presets & Floating Pills scope

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
                        notify("KHAMAN DHOKLA", "Found & teleported to " .. p.Name .. "!")
                        sSuccess()
                    else
                        local fallbackCF = getBestTargetCFrame(p)
                        if fallbackCF then
                            markIntentionalTeleport(fallbackCF)
                            safeReturnFromVoid(LP.Character, fallbackCF * CFrame.new(0, 2, 0))
                            notify("KHAMAN DHOKLA", "Teleported to " .. p.Name .. "'s hidden location!")
                            sSuccess()
                        else
                            notify("KHAMAN DHOKLA", "Seeking " .. p.Name .. " — turned on Auto-Chase!")
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
        task.wait(0.35)
        pcall(refreshList)
        if AutoReweldEnabled and LastWeldTargetUserId and p.UserId == LastWeldTargetUserId then
            hookTargetRespawn(p)
            local waitStart = tick()
            while tick() - waitStart < 12.0 and p.Parent == Players and not findPlayerCharacterAnywhere(p) do
                RunService.Heartbeat:Wait()
            end
            if p.Parent ~= Players then return end
            selectedPlayer = p
            footerLabel.Text = "Target: " .. p.Name
            footerSub.Text = "rejoined — auto re-welding"
            syncChatTarget(p)
            local key = WeldIntent.presetKey or LastPresetKey
            if key and WELD_PRESETS[key] then
                applyWeldPreset(key, p)
                syncAllActiveIndicators()
            end
        end
    end)

    Players.PlayerRemoving:Connect(function(p)
        if WeldIntent.target == p or CurrentTarget == p or selectedPlayer == p then
            LastWeldTargetUserId = p.UserId
            stopWeld()
            StateManager:Cleanup(false)
            if selectedPlayer == p then
                selectedPlayer = nil
                syncChatTarget(nil)
            end
            footerLabel.Text = "Auto: Nearest Player"
            footerSub.Text = "target left — safely returned"
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
                notify("KHAMAN DHOKLA", "No target or nearby player found")
                sError()
                return
            end
            chatTargetInput.Text = csTgt
        end
        if csMode == "message" and csMsg == "" then
            notify("KHAMAN DHOKLA", "Enter a message")
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
        notify("KHAMAN DHOKLA", "Chat spammer started")
    end

    chatStopFn = function()
        csOn = false
        csGen = csGen + 1
        chatStatusLbl.Text = "stopped · " .. csCnt .. " sent"
        chatStatusLbl.TextColor3 = T.Muted
        sToggleOff()
        notify("KHAMAN DHOKLA", "Chat spammer stopped")
    end

    chatStartBtn.MouseButton1Click:Connect(function() sClick(); chatStartFn() end)
    chatStopBtn.MouseButton1Click:Connect(function() sClick(); chatStopFn() end)
    setChatMode("roast")
    end -- end Chat Tab scope

    -- ═══════════════════════════════════════════════════════════════════════════
    -- TAB 4: ANTI (ALWAYS-ON CORE SHIELDS + DEFENCE TROLL MATRIX + ULTRA VC BYPASS V4)
    -- ═══════════════════════════════════════════════════════════════════════════
    do -- Scoped block for Anti Tab UI (preserves buildMainUI local register budget)
    local antiToggleRegistry = {} -- list of { btn = TextButton, getState = fn, isAlwaysOn = bool }
    syncAllAntiButtons = function()
        for _, entry in ipairs(antiToggleRegistry) do
            if entry.btn and entry.btn.Parent then
                local st = entry.getState()
                local lockedOn = entry.isAlwaysOn and Anti.AlwaysOnCore
                BtnColors[entry.btn] = st and PILL_BG_ON or T.PanelLt
                entry.btn.BackgroundColor3 = BtnColors[entry.btn]
                entry.btn.Text = lockedOn and "ALWAYS ON" or (st and "ON" or "OFF")
            end
        end
        if updateDefenceStatsUI then pcall(updateDefenceStatsUI) end
    end

    -- One-Tap Master Shield Bar (Enable All / Disable Optional)
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
        Anti.enableAll()
    end)

    local btnDisableAll = Instance.new("TextButton")
    btnDisableAll.Size = UDim2.new(0.36, -3, 1, 0)
    btnDisableAll.Position = UDim2.new(0.64, 6, 0, 0)
    btnDisableAll.Text = "DISABLE OPT."
    btnDisableAll.TextColor3 = Color3.new(1, 1, 1)
    btnDisableAll.Font = Enum.Font.GothamBold
    btnDisableAll.TextSize = 10
    btnDisableAll.ZIndex = 8
    btnDisableAll.Parent = masterRow
    Instance.new("UICorner", btnDisableAll).CornerRadius = UDim.new(0, 7)
    styleBtn(btnDisableAll, T.Danger)
    btnDisableAll.MouseButton1Click:Connect(function()
        sClick()
        Anti.disableAll()
    end)

    sectionLbl(antiTab, 1, "DEFENCE TROLL MATRIX V3  (6 COUNTER-MODES + OMNI-RADAR)", T.Accent)

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
    defTitle.Text = "DEFENCE TROLL MATRIX V3"
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
    defStatsLbl.Text = "⚡ COUNTERED: 0  ·  FLINGS: 0  ·  LAG PURGED: 0\nCORE 24/7: Anti-Sit · Anti-Void · Anti-Lag · Anti-Freeze ACTIVE"
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
                    "⚡ COUNTERED: %d  ·  FLINGS: %d  ·  SEATS: %d  ·  LAG: %d\nLAST: %s (%s)  ·  24/7 CORE SHIELDS ON",
                    DefenceTroll.deflectCount or 0,
                    Anti.FlingShield.blockedFlings or 0,
                    Anti.SeatTrap.neutralizedSeats or 0,
                    Anti.Lag.purgedItems or 0,
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
            DefenceTroll.stopFn()
        else
            DefenceTroll.startFn()
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
        notify("KHAMAN DHOKLA", "Defence Mode set: " .. (DefenceTroll.modeLabels[DefenceTroll.mode] or DefenceTroll.mode))
        updateDefenceStatsUI()
    end)

    rangeBtn.MouseButton1Click:Connect(function()
        sClick()
        DefenceTroll.rangeIdx = (DefenceTroll.rangeIdx % #DefenceTroll.ranges) + 1
        DefenceTroll.range = DefenceTroll.ranges[DefenceTroll.rangeIdx]
        rangeBtn.Text = "RADAR: " .. tostring(DefenceTroll.range) .. "s"
        notify("KHAMAN DHOKLA", "Deflect Radar Range: " .. tostring(DefenceTroll.range) .. " studs")
    end)

    sectionLbl(antiTab, 3, "🔒 24/7 ALWAYS-ON CORE SHIELDS (ANTI-SIT / VOID / LAG / FREEZE)", T.Success)

    local function makeAntiToggle(order, label, getState, onEnable, onDisable, isAlwaysOn)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 34)
        row.BackgroundColor3 = T.Panel
        row.BorderSizePixel = 0
        row.LayoutOrder = order
        row.ZIndex = 7
        row.Parent = antiTab
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -98, 1, 0)
        lbl.Position = UDim2.new(0, 12, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = label
        lbl.TextColor3 = isAlwaysOn and T.Neon or T.Text
        lbl.Font = isAlwaysOn and Enum.Font.GothamBold or Enum.Font.GothamMedium
        lbl.TextSize = 10
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextTruncate = Enum.TextTruncate.AtEnd
        lbl.ZIndex = 8
        lbl.Parent = row

        local st = getState()
        local lockedOn = isAlwaysOn and Anti.AlwaysOnCore
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 78, 0, 24)
        btn.Position = UDim2.new(1, -86, 0.5, -12)
        btn.Text = lockedOn and "ALWAYS ON" or (st and "ON" or "OFF")
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = lockedOn and 8 or 10
        btn.ZIndex = 8
        btn.Parent = row
        Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
        styleBtn(btn, st and PILL_BG_ON or T.PanelLt)

        table.insert(antiToggleRegistry, { btn = btn, getState = getState, isAlwaysOn = isAlwaysOn })

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

    -- 24/7 Always-On Core Shields
    makeAntiToggle(4, "🔒 Anti-Sit / Couch-Kidnap Destroyer v4 (24/7)", function() return Anti.SeatTrap.enabled end, Anti.SeatTrap.startFn, Anti.SeatTrap.stopFn, true)
    makeAntiToggle(5, "🔒 Anti-Ragdoll / Anti-Sit / Anti-Stun v4 (24/7)", function() return Anti.Ragdoll.enabled end, Anti.Ragdoll.startFn, Anti.Ragdoll.stopFn, true)
    makeAntiToggle(6, "🔒 Anti-Void v4 (2048x2048 Floor + Catch 24/7)", function() return Anti.Void.enabled end, Anti.Void.startFn, Anti.Void.stopFn, true)
    makeAntiToggle(7, "🔒 Infinite Fall Void (NaN KillPlane Lock 24/7)", function() return Anti.InfFallVoid.enabled end, Anti.InfFallVoid.startFn, Anti.InfFallVoid.stopFn, true)
    makeAntiToggle(8, "🔒 Anti-Lag v4 (Particle & Clone-Bomb Purger 24/7)", function() return Anti.Lag.enabled end, Anti.Lag.startFn, Anti.Lag.stopFn, true)
    makeAntiToggle(9, "🔒 Anti-Freeze / Anti-Anchor & Mover Purger v4 (24/7)", function() return Anti.Anchor.enabled end, Anti.Anchor.startFn, Anti.Anchor.stopFn, true)
    makeAntiToggle(10, "🔒 Anti-GameplayPaused / Anti-NetworkFreeze v4 (24/7)", function() return Anti.GamePaused.enabled end, Anti.GamePaused.startFn, Anti.GamePaused.stopFn, true)

    sectionLbl(antiTab, 11, "ADDITIONAL CHARACTER & PHYSICS SHIELDS (V4)", T.Muted)
    makeAntiToggle(12, "Anti-Fling v3 (Server No-Collide + Zero-Impulse)", function() return Anti.FlingShield.enabled end, Anti.FlingShield.startFn, Anti.FlingShield.stopFn, false)
    makeAntiToggle(13, "Anti-Kill / God-Mode v3 (Touch Shield + ForceField)", function() return Anti.Kill.enabled end, Anti.Kill.startFn, Anti.Kill.stopFn, false)
    makeAntiToggle(14, "Anti-Attach / Omni-Weld & Grab Sever v3", function() return Anti.Attach.enabled end, Anti.Attach.startFn, Anti.Attach.stopFn, false)
    makeAntiToggle(15, "Anti-Bring / Tool-Grab & Teleport Guard v3", function() return Anti.Bring.enabled end, Anti.Bring.startFn, Anti.Bring.stopFn, false)
    makeAntiToggle(16, "Anti-Tool / Couch / Carry / Cuffs Disarmer v3", function() return Anti.ToolGuard.enabled end, Anti.ToolGuard.startFn, Anti.ToolGuard.stopFn, false)
    makeAntiToggle(17, "Anti-Headsit & Anti-Facebang Evader (Library)", function() return Anti.AntiHeadsit.enabled end, Anti.AntiHeadsit.startFn, Anti.AntiHeadsit.stopFn, false)
    makeAntiToggle(18, "Anti-Bang Glitch Desync (Evade Bangs / CFrame Spoof)", function() return Anti.GlitchDesync.enabled end, Anti.GlitchDesync.startFn, Anti.GlitchDesync.stopFn, false)
    makeAntiToggle(19, "Anti-Blind / Anti-Flashbang & Fog Clear v3", function() return Anti.Blind.enabled end, Anti.Blind.startFn, Anti.Blind.stopFn, false)

    sectionLbl(antiTab, 20, "KHAMAN ANTI-VC V4 ULTRA BYPASS & COUNTER-TRAPS", T.Accent)
    makeAntiToggle(21, "Khaman Anti-VC v4 (Auto + Force Voice Bypass)", function() return Anti.VC.enabled or Anti.VC.running end, Anti.VC.startFn, Anti.VC.stopFn, false)
    makeAntiToggle(22, "Void-Pause Attacker (Banish Welded Trolls)", function() return Anti.PauseTrap.enabled end, Anti.PauseTrap.startFn, Anti.PauseTrap.stopFn, false)
    makeAntiToggle(23, "Redirect Attacker -> Nearest Bystander", function() return Anti.Redirect.enabled end, Anti.Redirect.startFn, Anti.Redirect.stopFn, false)
    makeAntiToggle(24, "Anti-Kick (Intercept Client LocalPlayer:Kick)", function() return Anti.Kick.enabled end, Anti.Kick.startFn, Anti.Kick.stopFn, false)
    makeAntiToggle(25, "Anti-AFK v3 (Idled + VirtualUser + Input Pulse)", function() return Anti.AFK.enabled end, Anti.AFK.startFn, Anti.AFK.stopFn, false)

    do
        local vcPanelRow = Instance.new("Frame")
        vcPanelRow.Size = UDim2.new(1, 0, 0, 68)
        vcPanelRow.BackgroundColor3 = T.Panel
        vcPanelRow.BorderSizePixel = 0
        vcPanelRow.LayoutOrder = 26
        vcPanelRow.ZIndex = 7
        vcPanelRow.Parent = antiTab
        Instance.new("UICorner", vcPanelRow).CornerRadius = UDim.new(0, 7)

        local vcRowLbl = Instance.new("TextLabel")
        vcRowLbl.Size = UDim2.new(1, -138, 0, 28)
        vcRowLbl.Position = UDim2.new(0, 12, 0, 4)
        vcRowLbl.BackgroundTransparency = 1
        vcRowLbl.Text = "Status: Idle · Guard:0"
        vcRowLbl.TextColor3 = T.Neon
        vcRowLbl.Font = Enum.Font.GothamBold
        vcRowLbl.TextSize = 10
        vcRowLbl.TextXAlignment = Enum.TextXAlignment.Left
        vcRowLbl.ZIndex = 8
        vcRowLbl.Parent = vcPanelRow
        Anti.VC.rowSubLbl = vcRowLbl

        local openVcPanelBtn = Instance.new("TextButton")
        openVcPanelBtn.Size = UDim2.new(0, 118, 0, 24)
        openVcPanelBtn.Position = UDim2.new(1, -126, 0, 6)
        openVcPanelBtn.Text = "OPEN ANTI-VC UI"
        openVcPanelBtn.TextColor3 = Color3.new(1, 1, 1)
        openVcPanelBtn.Font = Enum.Font.GothamBold
        openVcPanelBtn.TextSize = 9
        openVcPanelBtn.ZIndex = 8
        openVcPanelBtn.Parent = vcPanelRow
        Instance.new("UICorner", openVcPanelBtn).CornerRadius = UDim.new(0, 6)
        styleBtn(openVcPanelBtn, T.Accent2)
        openVcPanelBtn.MouseButton1Click:Connect(function()
            sClick()
            if Anti.VC.openPanelFn then Anti.VC.openPanelFn() end
        end)

        local quickForceBtn = Instance.new("TextButton")
        quickForceBtn.Size = UDim2.new(0.36, -6, 0, 26)
        quickForceBtn.Position = UDim2.new(0, 8, 0, 36)
        quickForceBtn.Text = "⚡ FORCE BYPASS"
        quickForceBtn.TextColor3 = Color3.new(1, 1, 1)
        quickForceBtn.Font = Enum.Font.GothamBold
        quickForceBtn.TextSize = 9
        quickForceBtn.ZIndex = 8
        quickForceBtn.Parent = vcPanelRow
        Instance.new("UICorner", quickForceBtn).CornerRadius = UDim.new(0, 6)
        styleBtn(quickForceBtn, Color3.fromRGB(185, 115, 12))
        quickForceBtn.MouseButton1Click:Connect(function()
            sClick()
            if Anti.VC.forceBypassFn then Anti.VC.forceBypassFn() end
        end)

        local inlineMicBtn = Instance.new("TextButton")
        inlineMicBtn.Size = UDim2.new(0.32, -4, 0, 26)
        inlineMicBtn.Position = UDim2.new(0.36, 4, 0, 36)
        inlineMicBtn.Text = "🎙️ LIVE"
        inlineMicBtn.TextColor3 = Color3.new(1, 1, 1)
        inlineMicBtn.Font = Enum.Font.GothamBold
        inlineMicBtn.TextSize = 9
        inlineMicBtn.ZIndex = 8
        inlineMicBtn.Parent = vcPanelRow
        Instance.new("UICorner", inlineMicBtn).CornerRadius = UDim.new(0, 6)
        styleBtn(inlineMicBtn, PILL_BG_ON)
        Anti.VC.inlineMicBtn = inlineMicBtn
        inlineMicBtn.MouseButton1Click:Connect(function()
            sClick()
            if Anti.VC.toggleMicFn then Anti.VC.toggleMicFn() end
        end)

        local inlineRejoinBtn = Instance.new("TextButton")
        inlineRejoinBtn.Size = UDim2.new(0.32, -8, 0, 26)
        inlineRejoinBtn.Position = UDim2.new(0.68, 4, 0, 36)
        inlineRejoinBtn.Text = "🔄 REJOIN VC"
        inlineRejoinBtn.TextColor3 = T.Neon
        inlineRejoinBtn.Font = Enum.Font.GothamBold
        inlineRejoinBtn.TextSize = 9
        inlineRejoinBtn.ZIndex = 8
        inlineRejoinBtn.Parent = vcPanelRow
        Instance.new("UICorner", inlineRejoinBtn).CornerRadius = UDim.new(0, 6)
        styleBtn(inlineRejoinBtn, T.PanelLt)
        inlineRejoinBtn.MouseButton1Click:Connect(function()
            sClick()
            if Anti.VC.rejoinFn then Anti.VC.rejoinFn() end
        end)
    end
    syncAllAntiButtons()
    end -- end Anti Tab UI scope

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
            notify("KHAMAN DHOKLA", "Rewind window set to " .. tostring(opt.val) .. " seconds (60Hz exact)")
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
        moveState.desiredWalkSpeed = currentSpeed
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
                    for _, p in ipairs(getCachedCharParts(ch)) do
                        if p.Parent and p.CanCollide then
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
        removeMobileFlyHUD()
        flyStatus.Text = "FLY  ·  OFF  (WASD / JOYSTICK + ALT)"; BtnColors[flyStatus] = T.Panel; flyStatus.BackgroundColor3 = T.Panel
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
        if not (Anti and (Anti.AlwaysOnCore or (Anti.Void and Anti.Void.enabled) or (Anti.InfFallVoid and Anti.InfFallVoid.enabled) or (Anti.Kill and Anti.Kill.enabled))) then
            pcall(function() workspace.FallenPartsDestroyHeight = OriginalFPDH end)
        end
        notify("KHAMAN DHOKLA", "Unwelded & state cleared")
        sSuccess()
    end)

    -- ═══════════════════════════════════════════════════════════════════════════
    -- MINIMIZE, CLOSE & KEYBIND (Floating CP icon only shows when panel is hidden!)
    -- ═══════════════════════════════════════════════════════════════════════════
    setPanelOpen = function(isOpen)
        gui.Enabled = true
        uiState.open = isOpen
        uiState.minimized = not isOpen
        if isOpen then
            mobToggle.Visible = false
            mainScale.Scale = 0.92
            main.Visible = true
            panelShadow.Visible = true
            TweenService:Create(mainScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1.0
            }):Play()
        else
            local tw = TweenService:Create(mainScale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Scale = 0.92
            })
            tw:Play()
            task.delay(0.14, function()
                if not uiState.open then
                    main.Visible = false
                    panelShadow.Visible = false
                    mobToggle.Visible = true
                end
            end)
        end
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
        print("[KHAMAN DHOKLA] Terminated.")
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
        dt.Text = "Close KHAMAN DHOKLA?"
        dt.TextColor3 = T.Text
        dt.Font = Enum.Font.GothamBold
        dt.TextSize = 13
        dt.ZIndex = 102
        dt.Parent = dlg

        local dm = Instance.new("TextLabel")
        dm.Size = UDim2.new(1, -24, 0, 28)
        dm.Position = UDim2.new(0, 12, 0, 34)
        dm.BackgroundTransparency = 1
        dm.Text = "Hide to the KD Dhokla icon or unload completely?"
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
        elseif inp.KeyCode == Enum.KeyCode.V and (Anti.VC.enabled or Anti.VC.running) then
            if Anti.VC.toggleMicFn then Anti.VC.toggleMicFn() end
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
    warn("[KHAMAN DHOKLA] GUI startup failed:\n" .. tostring(bootErr))
    -- Show a simple diagnostic in PlayerGui so a failed mount/build is visible.
    pcall(function()
        local playerGui = LP:FindFirstChildOfClass("PlayerGui") or LP:WaitForChild("PlayerGui", 8)
        if not playerGui then return end
        local old = playerGui:FindFirstChild("KhamanDhoklaStartupError")
        if old then old:Destroy() end
        local diagnostic = Instance.new("ScreenGui")
        diagnostic.Name = "KhamanDhoklaStartupError"
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
        title.Text = "KHAMAN DHOKLA failed to start"
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
notify("KHAMAN DHOKLA V39", "Zero-Freeze Troll + True Unlimited Fling + 24/7 Core Shields + VC V4 Ready!")
print("[KHAMAN DHOKLA V39] Ready.")
