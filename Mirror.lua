-- language: Lua, file: jamun_hub.lua, target: Roblox executor
-- jamun welder · script by akash · v10.0 "Riyon Obsidian Premium GUI + Fixed Headtag & Admin"

local P    = game:GetService("Players")
local RS   = game:GetService("RunService")
local UIS  = game:GetService("UserInputService")
local TW   = game:GetService("TweenService")
local WS   = game:GetService("Workspace")
local HS   = game:GetService("HttpService")
local RPS  = game:GetService("ReplicatedStorage")
local TC   = game:GetService("TextChatService")
local SS   = game:GetService("SoundService")
local LG   = game:GetService("Lighting")
local LP   = P.LocalPlayer
local CH   = LP.Character -- never yield forever on character
local PG   = nil
pcall(function()
    PG = LP:FindFirstChild("PlayerGui") or LP:WaitForChild("PlayerGui", 3)
end)
print("[Jamun Welder] boot…")

-- ============================================================================
-- ANIM COPY ENGINE (embedded · Coco extract · no standalone GUI)
-- ============================================================================
;(function()
    local __jamunAnimCopySrc = [=[
-- ═══════════════════════════════════════════════════════════════════════════════
-- 🎭 STANDALONE ZERO-DELAY ANIMATION COPY (Extracted from Coco Powder V36.8)
--    • Multi-Mode Zero-Delay Weld Alignment: Right, Left, Front Mirror, Back
--      Shadow, Exact Weld (0.0), Above Float, Orbit 360°, or Free Move (No TP)
--    • 1:1 Live AnimationTrack Mirroring (0.00s fade, 15ms TimePosition lock,
--      event-driven Animator.AnimationPlayed hook, ping lead & phase/speed)
--    • Cross-Rig Motor6D Transform Bridge (Same-Rig MotorPairCache, R15 <-> R6)
--    • Phase Noclip, Void Protection, Unstreamed Target Stream-Piercer & Reanim Sync
--    • Target Animate Pack Stealer + Client Twin Avatar Outfit Morph & Restore
-- ═══════════════════════════════════════════════════════════════════════════════

if type(_G.AnimCopyStandaloneCleanup) == "function" then
    pcall(_G.AnimCopyStandaloneCleanup)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")

local LP = Players.LocalPlayer
local sethiddenproperty = sethiddenproperty or set_hidden_property or sethiddenprop
local InstanceHandleNew = nil
pcall(function()
    if InstanceHandle and type(InstanceHandle.new) == "function" then
        InstanceHandleNew = InstanceHandle.new
    end
end)

local OriginalFPDH = workspace.FallenPartsDestroyHeight
if OriginalFPDH ~= OriginalFPDH then
    OriginalFPDH = -500
end

local LastKnownSafeCF = nil
local AnimateWasDisabled = false
local WeldSeekingTarget = false
local RescueGeneration = 0
local PlayerLocationCache = {}
local SelectedTargetPlayer = nil
local TypedTargetQuery = ""
local GlobalConnections = {}

local function trackConn(conn)
    if conn then
        table.insert(GlobalConnections, conn)
    end
    return conn
end

local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = tostring(title or "Anim Copy"),
            Text = tostring(text or ""),
            Duration = duration or 3,
        })
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- SAFE BOUNDS, VOID PROTECTION & CHARACTER RECOVERY HELPERS
-- ═══════════════════════════════════════════════════════════════════════════════
local function isSafePlayableCF(cf)
    -- disabled void gates — always treat as playable (jamun anti-void handles real void)
    return cf ~= nil
end

local function isLethalVoidCF(cf, velocity)
    -- disabled: jamun welder owns anti-void only
    return false
end

local findFallbackSafeCF
do
    local CachedSpawnLocation = nil
    local LastSpawnScanTick = 0
    pcall(function()
        local ch = LP and LP.Character
        local rt = ch and ch:FindFirstChild("HumanoidRootPart")
        if rt and isSafePlayableCF(rt.CFrame) then
            LastKnownSafeCF = rt.CFrame
        end
        if LP then
            trackConn(LP.CharacterAdded:Connect(function(newChar)
                task.spawn(function()
                    local r = newChar:WaitForChild("HumanoidRootPart", 3)
                    if r and isSafePlayableCF(r.CFrame) then
                        LastKnownSafeCF = r.CFrame
                    end
                end)
            end))
        end
    end)

    findFallbackSafeCF = function()
        if isSafePlayableCF(LastKnownSafeCF) then
            return LastKnownSafeCF
        end
        local myRoot = LP and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if myRoot and isSafePlayableCF(myRoot.CFrame) then
            return myRoot.CFrame
        end
        if not (CachedSpawnLocation and CachedSpawnLocation.Parent) and (tick() - LastSpawnScanTick > 15.0) then
            LastSpawnScanTick = tick()
            CachedSpawnLocation = workspace:FindFirstChildWhichIsA("SpawnLocation", true)
        end
        local spawnPart = CachedSpawnLocation
        if spawnPart and spawnPart.Parent and isSafePlayableCF(spawnPart.CFrame) then
            return spawnPart.CFrame + Vector3.new(0, 4, 0)
        end
        return CFrame.new(0, 35, 0)
    end
end

local function stopDefaultTracks(c)
    local hum = c and c:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if animator then
        local ok, tracks = pcall(function() return animator:GetPlayingAnimationTracks() end)
        if ok and tracks then
            for _, t in ipairs(tracks) do
                pcall(function() t:Stop(0) end)
                pcall(function() t:Destroy() end)
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

local function recoverCharacterState(char, safeCF)
    local isReanimActive = (_G.CocaSkyDestroyer and (_G.CocaSkyDestroyer.isAnyActive() or _G.CocaSkyDestroyer.is_reanimated()))
        or (_G._AngoorZenApi and type(_G._AngoorZenApi.is_reanimated) == "function" and _G._AngoorZenApi.is_reanimated())
    local activeRealChar = (isReanimActive and _G._AngoorZenApi and type(_G._AngoorZenApi.get_real_character) == "function" and _G._AngoorZenApi.get_real_character())
        or (isReanimActive and _G.CocaSkyDestroyer and type(_G.CocaSkyDestroyer.get_real_character) == "function" and _G.CocaSkyDestroyer.get_real_character())
        or nil
    char = char or (LP and LP.Character)
    if isReanimActive and activeRealChar and char == activeRealChar then
        if LP and LP.Character and LP.Character ~= activeRealChar then
            char = LP.Character
        else
            return
        end
    end
    if not char then return end
    local isReanimClone = isReanimActive and (char == LP.Character or char.Name == "CocaReanimation" or char.Name == "ReanimationClone")
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    pcall(function() LP.ReplicationFocus = nil end)
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
            local uprightCF = CFrame.new(pos) * CFrame.Angles(0, yYaw, 0)
            root.CFrame = uprightCF
            if isReanimActive and _G._AngoorZenApi and type(_G._AngoorZenApi.sync_now) == "function" then
                pcall(_G._AngoorZenApi.sync_now, true)
            elseif isReanimActive and _G.CocaSkyDestroyer and type(_G.CocaSkyDestroyer.sync_now) == "function" then
                pcall(_G.CocaSkyDestroyer.sync_now, true)
            end
        end
    end

    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = false
            part.Massless = false
            part.CanTouch = true
            part.CanQuery = true
            pcall(function() part.CustomPhysicalProperties = nil end)
            if part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head" then
                part.CanCollide = true
            end
        elseif part:IsA("Motor6D") and (not isReanimActive or isReanimClone) then
            pcall(function()
                part.Enabled = true
                part.Transform = CFrame.identity
            end)
        end
    end

    local animate = char:FindFirstChild("Animate")
    if animate and animate.Disabled and not WeldSeekingTarget and (not isReanimActive or isReanimClone) then
        pcall(function() animate.Disabled = false end)
    end
    AnimateWasDisabled = false
    stopDefaultTracks(char)

    if hum and hum.Health > 0 then
        pcall(function()
            if not hum:GetStateEnabled(Enum.HumanoidStateType.Running) then hum:SetStateEnabled(Enum.HumanoidStateType.Running, true) end
            if not hum:GetStateEnabled(Enum.HumanoidStateType.Jumping) then hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end
            if not hum:GetStateEnabled(Enum.HumanoidStateType.Freefall) then hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true) end
            if not hum:GetStateEnabled(Enum.HumanoidStateType.Landed) then hum:SetStateEnabled(Enum.HumanoidStateType.Landed, true) end
            if not hum:GetStateEnabled(Enum.HumanoidStateType.GettingUp) then hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true) end
            if hum.PlatformStand then hum.PlatformStand = false end
            if hum.Sit then hum.Sit = false end
            if not hum.AutoRotate then hum.AutoRotate = true end
            local curSt = hum:GetState()
            if curSt == Enum.HumanoidStateType.PlatformStanding
                or curSt == Enum.HumanoidStateType.Ragdoll
                or curSt == Enum.HumanoidStateType.FallingDown
                or curSt == Enum.HumanoidStateType.Seated
                or curSt == Enum.HumanoidStateType.Physics
                or curSt == Enum.HumanoidStateType.Dead then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end
        end)
    end
end

local AnimCopySys -- forward declaration

local function safeReturnFromVoid(char, preferredCF)
    -- disabled: no anim-copy void rescue
    return false
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- TARGET RESOLUTION, REANIM VALIDATION & STREAM-PIERCER HELPERS
-- ═══════════════════════════════════════════════════════════════════════════════
local function isPartInSafeWorldBounds(p)
    if not (p and p.Parent and p:IsA("BasePart")) then return false, nil end
    local okCF, cf = pcall(function() return p.CFrame end)
    if not okCF or not cf then return false, nil end
    local okV, vel = pcall(function() return p.AssemblyLinearVelocity end)
    if isLethalVoidCF(cf, okV and vel or nil) then return false, nil end
    local pos = cf.Position
    if math.abs(pos.Y - 85000) < 1500 then return false, nil end
    return true, pos
end

local function isValidTargetWorldCF(cf)
    if not cf then return false end
    local pos = cf.Position
    if pos.X ~= pos.X or pos.Y ~= pos.Y or pos.Z ~= pos.Z then return false end
    if pos.Magnitude < 0.5 or pos.Magnitude > 450000 then return false end
    if math.abs(pos.Y - 85000) < 1500 then return false end
    if isLethalVoidCF(cf) then return false end
    return true
end

local function isRefPartValid(part, char)
    local okBounds, pos = isPartInSafeWorldBounds(part)
    if not okBounds or not pos then return false end
    if char and not part:IsDescendantOf(char) then return false end
    if char and part.Name == "HumanoidRootPart" then
        local upper = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
        local okUpper, upperPos = isPartInSafeWorldBounds(upper)
        if okUpper and (pos - upperPos).Magnitude > 35.0 then
            return false
        end
    end
    return true
end

local function isCharacterNetlessReanimated(char)
    if not (char and char.Parent) then return false end
    local cands = {
        char:FindFirstChild("UpperTorso"),
        char:FindFirstChild("Torso"),
        char:FindFirstChild("Head"),
        char:FindFirstChild("LowerTorso"),
        char.PrimaryPart,
    }
    for _, part in ipairs(cands) do
        if part and part:IsA("BasePart") and isRefPartValid(part, char) then
            return true
        end
    end
    return false
end

local function isLocalCharAliveOrReanimated(char, hum)
    char = char or (LP and LP.Character)
    if not (char and char.Parent) then return false end
    hum = hum or char:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health > 0 then return true end
    if (_G._AngoorZenApi and type(_G._AngoorZenApi.is_reanimated) == "function" and _G._AngoorZenApi.is_reanimated())
        or (_G.CocaSkyDestroyer and (_G.CocaSkyDestroyer.isAnyActive() or _G.CocaSkyDestroyer.is_reanimated())) then
        return true
    end
    if isCharacterNetlessReanimated(char) then
        return true
    end
    return false
end

local function isLocalOwnedModel(m)
    if not m then return true end
    if LP and m == LP.Character then return true end
    local mName = m.Name
    if mName == "CocaReanimation" or mName == "AngoorReanimation" or mName == "CocoVanishGhost" or mName == "ReanimationClone" then
        return true
    end
    if _G._AngoorZenApi then
        if type(_G._AngoorZenApi.get_real_character) == "function" and m == _G._AngoorZenApi.get_real_character() then return true end
        if type(_G._AngoorZenApi.get_clone) == "function" and m == _G._AngoorZenApi.get_clone() then return true end
    end
    if _G.CocaSkyDestroyer then
        if type(_G.CocaSkyDestroyer.get_real_character) == "function" and m == _G.CocaSkyDestroyer.get_real_character() then return true end
        if type(_G.CocaSkyDestroyer.get_clone_character) == "function" and m == _G.CocaSkyDestroyer.get_clone_character() then return true end
    end
    if AnimCopySys and AnimCopySys.savedOutfitChar == m then return true end
    return false
end

local function findTargetReanimModel(targetPlr)
    if not targetPlr or targetPlr == LP then return nil end
    local tName = targetPlr.Name
    local tDisp = targetPlr.DisplayName or tName
    local candidates = {
        tName .. "_Reanim",
        tName .. "Reanim",
        tName .. "_Fake",
        tName .. "Clone",
        tName .. "Rig",
        tName .. "_Clone",
        tName .. " Dummy",
        tName .. "_Ghost",
        tDisp .. "_Fake",
        tDisp .. "_Clone",
    }

    for _, cName in ipairs(candidates) do
        local m = workspace:FindFirstChild(cName) or (workspace.CurrentCamera and workspace.CurrentCamera:FindFirstChild(cName))
        if m and m:IsA("Model") and not isLocalOwnedModel(m) then
            local ref = m:FindFirstChild("UpperTorso") or m:FindFirstChild("Torso") or m:FindFirstChild("Head") or m:FindFirstChild("HumanoidRootPart") or m.PrimaryPart
            if ref and ref:IsA("BasePart") and isRefPartValid(ref, m) then
                return m
            end
        end
    end

    local direct = workspace:FindFirstChild(tName)
    if direct and direct:IsA("Model") and not isLocalOwnedModel(direct) and direct ~= targetPlr.Character then
        local ref = direct:FindFirstChild("UpperTorso") or direct:FindFirstChild("Torso") or direct:FindFirstChild("Head") or direct:FindFirstChild("HumanoidRootPart") or direct.PrimaryPart
        if ref and ref:IsA("BasePart") and isRefPartValid(ref, direct) then
            return direct
        end
    end

    for _, fName in ipairs({ "Characters", "Players", "Entities", "Live", "Units", "Ingame", "Chars" }) do
        local f = workspace:FindFirstChild(fName)
        local found = f and f:FindFirstChild(tName)
        if found and found:IsA("Model") and not isLocalOwnedModel(found) and found ~= targetPlr.Character then
            local ref = found:FindFirstChild("UpperTorso") or found:FindFirstChild("Torso") or found:FindFirstChild("Head") or found:FindFirstChild("HumanoidRootPart") or found.PrimaryPart
            if ref and ref:IsA("BasePart") and isRefPartValid(ref, found) then
                return found
            end
        end
    end

    return nil
end

local function breakAllSeatsAndExternalJoints(char, hum, root)
    if not char then return end
    hum = hum or char:FindFirstChildOfClass("Humanoid")
    root = root or char:FindFirstChild("HumanoidRootPart")
    pcall(function()
        if hum then
            local seatPart = hum.SeatPart
            if seatPart and seatPart:IsA("BasePart") then
                pcall(function() seatPart.CanTouch = false end)
                for _, ch in ipairs(seatPart:GetChildren()) do
                    if ch:IsA("JointInstance") or ch:IsA("WeldConstraint") or ch.Name == "SeatWeld" then
                        pcall(function() ch:Destroy() end)
                    end
                end
                task.delay(0.45, function()
                    if seatPart and seatPart.Parent then
                        pcall(function() seatPart.CanTouch = true end)
                    end
                end)
            end
            if hum.Sit then hum.Sit = false end
        end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                local okJ, joints = pcall(function() return part:GetJoints() end)
                if okJ and joints then
                    for _, j in ipairs(joints) do
                        if j:IsA("JointInstance") or j:IsA("WeldConstraint") then
                            local p0, p1 = j.Part0, j.Part1
                            local p0Mine = p0 and p0:IsDescendantOf(char)
                            local p1Mine = p1 and p1:IsDescendantOf(char)
                            if (p0Mine and p1 and not p1Mine) or (p1Mine and p0 and not p0Mine) or j.Name == "SeatWeld" then
                                pcall(function() j:Destroy() end)
                            end
                        end
                    end
                end
            elseif part:IsA("SeatWeld") or part.Name == "SeatWeld" then
                pcall(function() part:Destroy() end)
            end
        end
    end)
end

local getServerSweepPoints
do
    local CachedSweepPoints = {}
    local LastSweepBuildTick = 0
    getServerSweepPoints = function()
        local now = tick()
        if #CachedSweepPoints > 0 and (now - LastSweepBuildTick) < 8.0 then
            return CachedSweepPoints
        end
        LastSweepBuildTick = now
        local pts = {}
        pcall(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("SpawnLocation") or obj:IsA("Seat") or obj:IsA("VehicleSeat") then
                    if not isLethalVoidCF(obj.CFrame) then
                        pts[#pts + 1] = obj.CFrame
                    end
                end
            end
        end)
        for _, child in ipairs(workspace:GetChildren()) do
            if child:IsA("Model") and child ~= LP.Character and not Players:GetPlayerFromCharacter(child) then
                local okP, pCF = pcall(function() return child:GetPivot() end)
                if okP and pCF and pCF.Position.Magnitude > 10 and pCF.Position.Magnitude < 100000 and not isLethalVoidCF(pCF) then
                    pts[#pts + 1] = pCF
                end
            elseif child:IsA("BasePart") and child.Position.Magnitude > 50 and child.Position.Magnitude < 100000 and not isLethalVoidCF(child.CFrame) then
                pts[#pts + 1] = child.CFrame
            end
        end
        CachedSweepPoints = pts
        return pts
    end
end

local function getFlatYawCFrame(cf, posOverride)
    if not cf then return CFrame.new() end
    local pos = posOverride or cf.Position
    local look = cf.LookVector
    local flatLook = Vector3.new(look.X, 0, look.Z)
    if flatLook.Magnitude > 0.001 then
        return CFrame.lookAt(pos, pos + flatLook.Unit, Vector3.yAxis)
    end
    local _, yYaw, _ = cf:ToEulerAnglesYXZ()
    return CFrame.new(pos) * CFrame.Angles(0, yYaw, 0)
end

local function findPlayerCharacterAnywhere(plr, skipDeepSearch)
    if not plr then return nil end
    if plr == LP then return LP.Character end
    if plr.Character and plr.Character.Parent then
        return plr.Character
    end
    local reanimModel = findTargetReanimModel(plr)
    if reanimModel and reanimModel.Parent then
        return reanimModel
    end
    if not skipDeepSearch then
        local byName = workspace:FindFirstChild(plr.Name, true)
        if byName and byName:IsA("Model") and (byName:FindFirstChildOfClass("Humanoid") or byName.PrimaryPart or byName:FindFirstChildWhichIsA("BasePart", true)) then
            return byName
        end
    else
        local direct = workspace:FindFirstChild(plr.Name)
        if direct and direct:IsA("Model") then return direct end
    end
    return plr.Character
end

local function pickTargetRef(char, mode)
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
    if hrp and hrp:IsA("BasePart") then
        if hrp.Name == "HumanoidRootPart" then
            local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
            if torso and torso:IsA("BasePart") and (hrp.Position - torso.Position).Magnitude > 35 and not isLethalVoidCF(torso.CFrame) then
                return torso
            end
        end
        return hrp
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.SeatPart and hum.SeatPart:IsA("BasePart") then
        return hum.SeatPart
    end
    return char:FindFirstChildWhichIsA("BasePart", true)
end

local function getVerifiedStreamedCFrame(plr)
    if not plr then return nil end
    local char = findPlayerCharacterAnywhere(plr, true)
    if char and char.Parent then
        local part = pickTargetRef(char, "torso")
        if part and part.Parent and not isLethalVoidCF(part.CFrame, part.AssemblyLinearVelocity) then
            local cf = part.CFrame
            PlayerLocationCache[plr.UserId] = { cf = cf, time = tick(), verified = true }
            return cf
        end
    end
    return nil
end

local function getBestTargetCFrame(plr, skipDeepSearch)
    if not plr then return nil end
    local char = findPlayerCharacterAnywhere(plr, skipDeepSearch)
    if char then
        local part = pickTargetRef(char, "torso")
        if part and part.Parent then
            local cf = part.CFrame
            if not isLethalVoidCF(cf, part.AssemblyLinearVelocity) then
                PlayerLocationCache[plr.UserId] = { cf = cf, time = tick() }
                return cf
            end
        end
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

local function ensureStreamFocusAt(cfOrPos)
    local pos = nil
    if typeof(cfOrPos) == "CFrame" then
        pos = cfOrPos.Position
    elseif typeof(cfOrPos) == "Vector3" then
        pos = cfOrPos
    end
    if not pos then return end
    task.spawn(function()
        pcall(function() LP:RequestStreamAroundAsync(pos, 1) end)
    end)
end

-- proximity / stream watcher (always on)
do
    local lastScanTick = 0
    trackConn(RunService.Heartbeat:Connect(function()
        local now = os.clock()
        if now - lastScanTick < 0.25 then return end
        lastScanTick = now
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP then
                pcall(function() getBestTargetCFrame(p, true) end)
            end
        end
    end))
end

local function syncAnimCopyReanimRoots(attachCF, excludePart)
    local tNow = os.clock()
    local netlessVel = Vector3.new(0, 25.05, 0) + Vector3.new(math.sin(tNow * 30) * 0.025, 0, math.cos(tNow * 30) * 0.025)
    local zApi = _G._AngoorZenApi
    if zApi and type(zApi.is_reanimated) == "function" and type(zApi.get_real_character) == "function" then
        local okR, isReanim = pcall(zApi.is_reanimated)
        if okR and isReanim then
            local okC, realChar = pcall(zApi.get_real_character)
            local realRoot = okC and realChar and realChar:FindFirstChild("HumanoidRootPart")
            if realRoot and realRoot ~= excludePart and realRoot.Parent then
                realRoot.Anchored = false
                realRoot.CanCollide = false
                realRoot.CFrame = attachCF
                realRoot.AssemblyLinearVelocity = netlessVel
                realRoot.AssemblyAngularVelocity = Vector3.zero
            end
            if type(zApi.sync_now) == "function" then
                pcall(zApi.sync_now, true)
            end
        end
    end
    local skyApi = _G.CocaSkyDestroyer
    if skyApi and type(skyApi.is_reanimated) == "function" and type(skyApi.get_real_character) == "function" then
        local okS, isSkyReanim = pcall(skyApi.is_reanimated)
        if okS and isSkyReanim then
            local okSC, skyRealChar = pcall(skyApi.get_real_character)
            local skyRealRoot = okSC and skyRealChar and skyRealChar:FindFirstChild("HumanoidRootPart")
            if skyRealRoot and skyRealRoot ~= excludePart and skyRealRoot.Parent then
                skyRealRoot.Anchored = false
                skyRealRoot.CanCollide = false
                skyRealRoot.CFrame = attachCF
                skyRealRoot.AssemblyLinearVelocity = netlessVel
                skyRealRoot.AssemblyAngularVelocity = Vector3.zero
            end
            if type(skyApi.sync_now) == "function" then
                pcall(skyApi.sync_now, true)
            end
        end
    end
end

local function streamAndTeleportToTarget(targetPlr, refMode, maxWaitSeconds, allowSweepOrOffset)
    if not targetPlr or targetPlr.Parent ~= Players then return nil, nil end
    maxWaitSeconds = maxWaitSeconds or 2.2
    local stepOffset = (typeof(allowSweepOrOffset) == "CFrame") and allowSweepOrOffset or CFrame.new(0, 1.5, 2)
    local myChar = LP.Character
    local myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
    local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")

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
    local tRef = tChar and pickTargetRef(tChar, refMode or "torso")
    if tRef and tRef.Parent then
        if myRoot then
            local destCF = tRef.CFrame * stepOffset
            myRoot.AssemblyLinearVelocity = Vector3.zero
            myRoot.AssemblyAngularVelocity = Vector3.zero
            myRoot.CFrame = destCF
            syncAnimCopyReanimRoots(destCF, myRoot)
        end
        return tChar, tRef
    end

    local prevSeeking = WeldSeekingTarget
    WeldSeekingTarget = true

    local started = tick()
    while tick() - started < (maxWaitSeconds * 0.65) do
        if targetPlr.Parent ~= Players then WeldSeekingTarget = prevSeeking; return nil, nil end
        tChar = findPlayerCharacterAnywhere(targetPlr)
        tRef = tChar and pickTargetRef(tChar, refMode or "torso")
        if tRef and tRef.Parent then
            WeldSeekingTarget = prevSeeking
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
                local hopDest = targetCF * CFrame.new(0, 2, 0)
                myRoot.AssemblyLinearVelocity = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
                myRoot.CFrame = hopDest
                syncAnimCopyReanimRoots(hopDest, myRoot)
            end
        else
            break
        end
        RunService.Heartbeat:Wait()
    end

    tChar = findPlayerCharacterAnywhere(targetPlr)
    tRef = tChar and pickTargetRef(tChar, refMode or "torso")
    if tRef and tRef.Parent then
        WeldSeekingTarget = prevSeeking
        return tChar, tRef
    end

    if allowSweepOrOffset ~= false then
        local probePoints = getServerSweepPoints()
        for idx, probeCF in ipairs(probePoints) do
            if tick() - started > maxWaitSeconds or idx > 28 then break end
            if targetPlr.Parent ~= Players then break end
            tChar = findPlayerCharacterAnywhere(targetPlr)
            tRef = tChar and pickTargetRef(tChar, refMode or "torso")
            if tRef and tRef.Parent then
                WeldSeekingTarget = prevSeeking
                return tChar, tRef
            end

            local knownCF = getBestTargetCFrame(targetPlr)
            local hopCF = knownCF or probeCF
            task.spawn(function()
                pcall(function() LP:RequestStreamAroundAsync(hopCF.Position, 1) end)
            end)
            myChar = LP.Character
            myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
            if myRoot then
                local hopDest = hopCF + Vector3.new(0, 3, 0)
                myRoot.CFrame = hopDest
                myRoot.AssemblyLinearVelocity = Vector3.zero
                syncAnimCopyReanimRoots(hopDest, myRoot)
            end
            RunService.Heartbeat:Wait()
        end
    end

    WeldSeekingTarget = prevSeeking
    tChar = findPlayerCharacterAnywhere(targetPlr)
    tRef = tChar and pickTargetRef(tChar, refMode or "torso")
    return tChar, tRef
end

local function getNearestPlayer(speaker)
    speaker = speaker or LP
    local myChar = speaker and speaker.Character
    local myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
    local myPos = myRoot and myRoot.Position or Vector3.zero
    local bestPlr, bestDist = nil, math.huge

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= speaker then
            local c = findPlayerCharacterAnywhere(p)
            local h = c and c:FindFirstChildOfClass("Humanoid")
            local streamedCF = getVerifiedStreamedCFrame(p)
            if streamedCF and (not h or h.Health > 0) then
                local d = (streamedCF.Position - myPos).Magnitude
                if d < bestDist then
                    bestDist = d
                    bestPlr = p
                end
            end
        end
    end
    if bestPlr then return bestPlr, bestDist end

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
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= speaker and (p.Name:lower():find(q, 1, true) or p.DisplayName:lower():find(q, 1, true)) then
            return p
        end
    end
    return nil
end

local function resolvePlayer(target, speaker)
    speaker = speaker or LP
    if typeof(target) == "Instance" and target:IsA("Player") then
        return target
    end
    if type(target) == "string" and target ~= "" then
        return findPlayerByNameOrDisplay(target, speaker)
    end
    return nil
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🎭 ANIMCOPYSYS — ZERO-DELAY ANIMATION COPY ENGINE
-- ═══════════════════════════════════════════════════════════════════════════════
AnimCopySys = {
    active = false,
    target = nil,
    sideMode = "right", -- "right", "left", "front", "back", "weld", "above", "orbit", or "free"
    sideDistance = 3.2,
    syncMotorTransforms = true,
    syncC0Deltas = true,
    copySpeedMult = 1.0,
    timeOffsetSec = 0.0,
    pingCompensate = false,
    syncTolerance = 0.015,
    rotationOffsetDeg = 0,
    spinMode = false,
    renderConn = nil,
    stepConn = nil,
    hbConn = nil,
    descConn = nil,
    animPlayedConn = nil,
    hookedAnimator = nil,
    currentLockCF = nil,
    preCopySafeCF = nil,
    clock = 0,
    missingFrames = 0,
    lastStreamReq = 0,
    mirroredTracks = {},
    animObjCache = {},
    failedIds = {},
    savedOrigMotorC0 = setmetatable({}, { __mode = "k" }),
    lastTargetAvailable = 0,
    boundCharacter = nil,
    savedOutfitChar = nil,
    savedOutfitItems = nil,
    savedFaceTexture = nil,
    onStateChanged = nil,
}

;(function()
    local function getPingSeconds()
        local ok, pingMs = pcall(function()
            return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        end)
        if ok and type(pingMs) == "number" and pingMs == pingMs and pingMs > 0 then
            return math.clamp(pingMs / 1000, 0, 1.0)
        end
        local ok2, p2 = pcall(function() return LP:GetNetworkPing() end)
        if ok2 and type(p2) == "number" and p2 == p2 and p2 > 0 then
            return math.clamp(p2, 0, 1.0)
        end
        return 0
    end

    local function computeExactSideBySideCF(tRoot, myHum, tHum, mode, dist)
        if not tRoot then return nil end
        dist = dist or 3.2
        local look = tRoot.CFrame.LookVector
        local flatLook = Vector3.new(look.X, 0, look.Z)
        if flatLook.Magnitude < 0.001 then
            flatLook = Vector3.new(0, 0, -1)
        else
            flatLook = flatLook.Unit
        end
        local flatRight = flatLook:Cross(Vector3.yAxis)
        if flatRight.Magnitude < 0.001 then
            flatRight = Vector3.new(1, 0, 0)
        else
            flatRight = flatRight.Unit
        end

        local myHip = (myHum and myHum.HipHeight and myHum.HipHeight > 0.2) and myHum.HipHeight or 2.0
        local tgHip = (tHum and tHum.HipHeight and tHum.HipHeight > 0.2) and tHum.HipHeight or 2.0
        local hipDeltaY = math.clamp(myHip - tgHip, -2.5, 2.5)

        local basePos = tRoot.Position + Vector3.new(0, hipDeltaY, 0)
        if mode == "weld" then
            return CFrame.fromMatrix(basePos, flatRight, Vector3.yAxis, -flatLook)
        elseif mode == "left" then
            local worldPos = basePos - (flatRight * dist)
            return CFrame.fromMatrix(worldPos, flatRight, Vector3.yAxis, -flatLook)
        elseif mode == "front" then
            local worldPos = basePos + (flatLook * dist)
            return CFrame.fromMatrix(worldPos, -flatRight, Vector3.yAxis, flatLook)
        elseif mode == "back" then
            local worldPos = basePos - (flatLook * dist)
            return CFrame.fromMatrix(worldPos, flatRight, Vector3.yAxis, -flatLook)
        elseif mode == "above" then
            local worldPos = basePos + Vector3.new(0, (dist or 3.8) + 1.2, 0)
            return CFrame.fromMatrix(worldPos, flatRight, Vector3.yAxis, -flatLook)
        elseif mode == "orbit" then
            local angle = os.clock() * 2.8
            local radius = math.max(1.8, dist or 3.6)
            local offsetVec = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
            local worldPos = basePos + offsetVec
            local toTarget = Vector3.new(basePos.X - worldPos.X, 0, basePos.Z - worldPos.Z)
            if toTarget.Magnitude < 0.001 then toTarget = flatLook else toTarget = toTarget.Unit end
            local rightVec = toTarget:Cross(Vector3.yAxis)
            if rightVec.Magnitude < 0.001 then rightVec = Vector3.new(1, 0, 0) else rightVec = rightVec.Unit end
            return CFrame.fromMatrix(worldPos, rightVec, Vector3.yAxis, -toTarget)
        else -- "right"
            local worldPos = basePos + (flatRight * dist)
            local outCF = CFrame.fromMatrix(worldPos, flatRight, Vector3.yAxis, -flatLook)
            if AnimCopySys.spinMode then
                return outCF * CFrame.Angles(0, (os.clock() * 6.0) % (math.pi * 2), 0)
            elseif AnimCopySys.rotationOffsetDeg and AnimCopySys.rotationOffsetDeg ~= 0 then
                return outCF * CFrame.Angles(0, math.rad(AnimCopySys.rotationOffsetDeg), 0)
            end
            return outCF
        end
    end

    do
        local rawComputeCF = computeExactSideBySideCF
        computeExactSideBySideCF = function(tRoot, myHum, tHum, mode, dist)
            local cf = rawComputeCF(tRoot, myHum, tHum, mode, dist)
            if not cf or mode == "right" then return cf end
            if AnimCopySys.spinMode then
                return cf * CFrame.Angles(0, (os.clock() * 6.0) % (math.pi * 2), 0)
            elseif AnimCopySys.rotationOffsetDeg and AnimCopySys.rotationOffsetDeg ~= 0 then
                return cf * CFrame.Angles(0, math.rad(AnimCopySys.rotationOffsetDeg), 0)
            end
            return cf
        end
    end

    AnimCopySys.ComputeSideBySideCF = computeExactSideBySideCF

    local function resolveAnimCopyTarget(explicitTarget)
        if explicitTarget then
            local p = resolvePlayer(explicitTarget, LP)
            if p and p.Parent == Players and p ~= LP then return p end
        end
        if TypedTargetQuery ~= "" then
            local byQuery = findPlayerByNameOrDisplay(TypedTargetQuery, LP)
            if byQuery and byQuery.Parent == Players and byQuery ~= LP then return byQuery end
        end
        if SelectedTargetPlayer and SelectedTargetPlayer.Parent == Players and SelectedTargetPlayer ~= LP then
            return SelectedTargetPlayer
        end
        if AnimCopySys.active and AnimCopySys.target and AnimCopySys.target.Parent == Players and AnimCopySys.target ~= LP then
            return AnimCopySys.target
        end
        return getNearestPlayer(LP)
    end
    AnimCopySys.ResolveTarget = resolveAnimCopyTarget

    local function clearMirroredTracks(fadeTime)
        fadeTime = fadeTime == nil and 0.12 or fadeTime
        for sourceTrack, info in pairs(AnimCopySys.mirroredTracks) do
            if info.track then
                pcall(function() info.track:Stop(fadeTime) end)
                pcall(function() info.track:Destroy() end)
            end
            AnimCopySys.mirroredTracks[sourceTrack] = nil
        end
    end

    function AnimCopySys:SnapSideBySideOnce(targetPlr)
        local TPlayer = resolveAnimCopyTarget(targetPlr)
        if not TPlayer or TPlayer.Parent ~= Players then
            notify("Anim Copy", "No target player found!")
            return false
        end
        local sideMode = self.sideMode or "right"
        local myChar = LP.Character
        local myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
        local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        if myChar and myRoot then
            breakAllSeatsAndExternalJoints(myChar, myHum, myRoot)
        end
        local tChar = findPlayerCharacterAnywhere(TPlayer)
        local tRoot = tChar and pickTargetRef(tChar, "root")
        local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
        if tRoot and tRoot.Parent and myRoot then
            local exactCF = computeExactSideBySideCF(tRoot, myHum, tHum, sideMode, self.sideDistance or 3.2)
            if exactCF then
                LastKnownSafeCF = exactCF
                myRoot.Anchored = false
                myRoot.AssemblyLinearVelocity = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
                myRoot.CFrame = exactCF
                syncAnimCopyReanimRoots(exactCF, myRoot)
                notify("Side-by-Side", "Snapped to " .. sideMode:upper() .. " of " .. TPlayer.DisplayName .. " (0ms)")
                return true
            end
        end
        task.spawn(function()
            local dist = self.sideDistance or 3.2
            local sideOffset = (sideMode == "left") and CFrame.new(-dist, 0, 0)
                or (sideMode == "front" and (CFrame.new(0, 0, -dist) * CFrame.Angles(0, math.pi, 0)))
                or (sideMode == "back" and CFrame.new(0, 0, dist))
                or (sideMode == "weld" and CFrame.new(0, 0, 0))
                or (sideMode == "above" and CFrame.new(0, dist + 1.0, 0))
                or CFrame.new(dist, 0, 0)
            local sChar, sRoot = streamAndTeleportToTarget(TPlayer, "root", 1.8, sideOffset)
            local mChar = LP.Character
            local mRoot = mChar and (mChar:FindFirstChild("HumanoidRootPart") or mChar:FindFirstChildWhichIsA("BasePart"))
            local mHum = mChar and mChar:FindFirstChildOfClass("Humanoid")
            local sHum = sChar and sChar:FindFirstChildOfClass("Humanoid")
            if sRoot and sRoot.Parent and mRoot then
                local exactCF = computeExactSideBySideCF(sRoot, mHum, sHum, sideMode, dist)
                if exactCF then
                    LastKnownSafeCF = exactCF
                    mRoot.Anchored = false
                    mRoot.AssemblyLinearVelocity = Vector3.zero
                    mRoot.AssemblyAngularVelocity = Vector3.zero
                    mRoot.CFrame = exactCF
                    syncAnimCopyReanimRoots(exactCF, mRoot)
                    notify("Side-by-Side", "Snapped to " .. sideMode:upper() .. " of " .. TPlayer.DisplayName)
                end
            end
        end)
        return true
    end

    function AnimCopySys:CopyTargetAnimatePack(targetPlr)
        local TPlayer = resolveAnimCopyTarget(targetPlr)
        if not TPlayer then
            notify("Anim Copy", "No target player found to steal animation pack!")
            return false
        end
        local tChar = findPlayerCharacterAnywhere(TPlayer)
        if not tChar then
            notify("Anim Copy", "Target character not streamed in yet!")
            return false
        end
        local tAnimate = tChar:FindFirstChild("Animate")
        local myChar = LP.Character
        local myAnimate = myChar and myChar:FindFirstChild("Animate")
        if not tAnimate or not myAnimate then
            notify("Anim Copy", "Animate script not found on character!")
            return false
        end
        local copiedCount = 0
        for _, tVal in ipairs(tAnimate:GetChildren()) do
            local myVal = myAnimate:FindFirstChild(tVal.Name)
            if myVal then
                for _, tAnim in ipairs(tVal:GetChildren()) do
                    if tAnim:IsA("Animation") and tAnim.AnimationId ~= "" then
                        local myAnim = myVal:FindFirstChild(tAnim.Name) or myVal:FindFirstChildOfClass("Animation")
                        if myAnim and myAnim:IsA("Animation") then
                            myAnim.AnimationId = tAnim.AnimationId
                            copiedCount = copiedCount + 1
                        end
                    end
                end
            end
        end
        local myHum = myChar:FindFirstChildOfClass("Humanoid")
        if myHum then
            stopDefaultTracks(myChar)
            pcall(function() myHum:ChangeState(Enum.HumanoidStateType.Landed) end)
        end
        notify("Pack Copied", "Copied " .. tostring(copiedCount) .. " Animation Pack tracks from " .. TPlayer.DisplayName)
        return true
    end

    function AnimCopySys:RestoreSavedMotorC0()
        if self.savedOrigMotorC0 then
            for m, origC0 in pairs(self.savedOrigMotorC0) do
                if m and m.Parent then
                    pcall(function() m.C0 = origC0 end)
                end
                self.savedOrigMotorC0[m] = nil
            end
        end
    end

    -- Twin Outfit Morph & Restore (extracted verbatim from Animation Copy tab)
    local function cloneAndWeldAccessoryToChar(srcAcc, destChar, srcCharRef)
        if not (srcAcc and destChar) then return end
        local okCl, accClone = pcall(function() return srcAcc:Clone() end)
        if not okCl or not accClone then return end
        local handle = accClone:FindFirstChild("Handle") or accClone:FindFirstChildWhichIsA("BasePart")
        for _, desc in ipairs(accClone:GetDescendants()) do
            if desc:IsA("JointInstance") or desc:IsA("WeldConstraint") or desc:IsA("RigidConstraint") or desc:IsA("WrapLayer") then
                pcall(function() desc:Destroy() end)
            elseif desc:IsA("BasePart") then
                desc.CanCollide = false
                desc.CanTouch = false
                desc.CanQuery = false
                desc.Massless = true
                desc.Anchored = false
            end
        end
        accClone.Parent = destChar
        if handle and handle:IsA("BasePart") then
            local handleAtt = handle:FindFirstChildOfClass("Attachment")
            local charAtt = nil
            if handleAtt then
                for _, d in ipairs(destChar:GetDescendants()) do
                    if d:IsA("Attachment") and d.Name == handleAtt.Name and not d:IsDescendantOf(accClone) then
                        charAtt = d
                        break
                    end
                end
            end
            local targetLimb = (charAtt and charAtt.Parent and charAtt.Parent:IsA("BasePart") and charAtt.Parent)
                or destChar:FindFirstChild("Head")
                or destChar:FindFirstChild("UpperTorso")
                or destChar:FindFirstChild("Torso")
                or destChar:FindFirstChild("HumanoidRootPart")
            if targetLimb and targetLimb:IsA("BasePart") then
                local c0 = handleAtt and handleAtt.CFrame or CFrame.identity
                local c1 = charAtt and charAtt.CFrame or CFrame.new(0, 0.5, 0)
                if not charAtt and srcCharRef then
                    local srcHandle = srcAcc:FindFirstChild("Handle")
                    local srcLimb = srcCharRef:FindFirstChild(targetLimb.Name) or srcCharRef:FindFirstChild("Head")
                    if srcHandle and srcLimb and srcHandle:IsA("BasePart") and srcLimb:IsA("BasePart") then
                        c0 = CFrame.identity
                        c1 = srcLimb.CFrame:ToObjectSpace(srcHandle.CFrame)
                    end
                end
                handle.CFrame = targetLimb.CFrame * c1 * c0:Inverse()
                local aw = Instance.new("Weld")
                aw.Name = "AccessoryWeld"
                aw.Part0 = handle
                aw.Part1 = targetLimb
                aw.C0 = c0
                aw.C1 = c1
                aw.Parent = handle
            end
        end
    end
    AnimCopySys.cloneAndWeldAccessoryToChar = cloneAndWeldAccessoryToChar

    function AnimCopySys:MorphTwinOutfit(targetPlr)
        local tgt = resolveAnimCopyTarget(targetPlr)
        local myChar = LP.Character
        local tChar = tgt and findPlayerCharacterAnywhere(tgt)
        if not tgt or not tChar or not myChar then
            notify("Outfit Morph", "Target character not streamed in yet!")
            return false
        end
        pcall(function()
            if not self.savedOutfitChar or self.savedOutfitChar ~= myChar then
                self.savedOutfitChar = myChar
                self.savedOutfitItems = {}
                for _, v in ipairs(myChar:GetChildren()) do
                    if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
                        local okS, savedCl = pcall(function() return v:Clone() end)
                        if okS and savedCl then
                            table.insert(self.savedOutfitItems, savedCl)
                        end
                    end
                end
                local mh = myChar:FindFirstChild("Head")
                local mf = mh and mh:FindFirstChildOfClass("Decal")
                self.savedFaceTexture = mf and mf.Texture or nil
            end
            for _, v in ipairs(myChar:GetChildren()) do
                if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
                    pcall(function() v:Destroy() end)
                end
            end
            for _, v in ipairs(tChar:GetChildren()) do
                if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
                    pcall(function() v:Clone().Parent = myChar end)
                elseif v:IsA("Accessory") then
                    cloneAndWeldAccessoryToChar(v, myChar, tChar)
                end
            end
            local myHead = myChar:FindFirstChild("Head")
            local tHead = tChar:FindFirstChild("Head")
            if myHead and tHead then
                local myFace = myHead:FindFirstChildOfClass("Decal")
                local tFace = tHead:FindFirstChildOfClass("Decal")
                if myFace and tFace then myFace.Texture = tFace.Texture end
            end
        end)
        notify("Twin Morph", "Cloned @" .. tgt.Name .. "'s avatar outfit & accessories!")
        return true
    end

    function AnimCopySys:RestoreOriginalOutfit()
        local myChar = LP.Character
        if not myChar or self.savedOutfitChar ~= myChar or not self.savedOutfitItems then
            notify("Outfit Restore", "Your original avatar outfit is already active!")
            return false
        end
        pcall(function()
            for _, v in ipairs(myChar:GetChildren()) do
                if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
                    pcall(function() v:Destroy() end)
                end
            end
            for _, savedItem in ipairs(self.savedOutfitItems) do
                if savedItem then
                    if savedItem:IsA("Accessory") then
                        cloneAndWeldAccessoryToChar(savedItem, myChar, nil)
                    else
                        pcall(function() savedItem:Clone().Parent = myChar end)
                    end
                end
            end
            local myHead = myChar:FindFirstChild("Head")
            local myFace = myHead and myHead:FindFirstChildOfClass("Decal")
            if myFace and self.savedFaceTexture then
                myFace.Texture = self.savedFaceTexture
            end
        end)
        notify("Outfit Restored", "Restored your original avatar outfit & accessories!")
        return true
    end

    function AnimCopySys:Stop(skipSafeReturn)
        if not self.active and not self.hbConn and not self.stepConn and not self.renderConn then return end
        self.active = false
        self.target = nil
        self.currentLockCF = nil
        pcall(function() RunService:UnbindFromRenderStep("CocoAnimCopyZeroDelayPreCam") end)
        pcall(function() RunService:UnbindFromRenderStep("CocoAnimCopyZeroDelayLock") end)
        if self.animPlayedConn then pcall(function() self.animPlayedConn:Disconnect() end); self.animPlayedConn = nil end
        self.hookedAnimator = nil
        if self.renderConn then self.renderConn:Disconnect(); self.renderConn = nil end
        if self.stepConn then self.stepConn:Disconnect(); self.stepConn = nil end
        if self.hbConn then self.hbConn:Disconnect(); self.hbConn = nil end
        if self.descConn then self.descConn:Disconnect(); self.descConn = nil end
        clearMirroredTracks(0)
        self:RestoreSavedMotorC0()
        self.lastTargetAvailable = 0
        self.boundCharacter = nil
        pcall(function() LP.ReplicationFocus = nil end)

        local myChar = LP.Character
        local myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
        local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        if myRoot and sethiddenproperty then
            pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", nil) end)
            pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootRef", nil) end)
        end
        if myChar then
            for _, d in ipairs(myChar:GetDescendants()) do
                if d:IsA("BasePart") then
                    d.Massless = false
                    d.CanQuery = true
                    d.CanTouch = true
                    if d.Name == "HumanoidRootPart" or d.Name == "Torso" or d.Name == "UpperTorso" or d.Name == "LowerTorso" or d.Name == "Head" then
                        d.CanCollide = true
                    end
                elseif d:IsA("Motor6D") then
                    pcall(function() d.Transform = CFrame.identity end)
                end
            end
            restoreAnimate(myChar)
        end
        if myHum and myHum.Health > 0 then
            pcall(function()
                myHum.PlatformStand = false
                myHum.Sit = false
                myHum.AutoRotate = true
                myHum:ChangeState(Enum.HumanoidStateType.GettingUp)
                myHum:ChangeState(Enum.HumanoidStateType.Running)
            end)
        end
        if not skipSafeReturn and myChar and myRoot then
            if isSafePlayableCF(myRoot.CFrame) then
                local cleanCF = getFlatYawCFrame(myRoot.CFrame)
                LastKnownSafeCF = cleanCF
                myRoot.AssemblyLinearVelocity = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
                myRoot.CFrame = cleanCF
            else
                safeReturnFromVoid(myChar, self.preCopySafeCF or LastKnownSafeCF)
            end
        end
        pcall(function() end) -- leave FPDH to jamun anti-void
        if type(self.onStateChanged) == "function" then
            pcall(self.onStateChanged)
        end
    end

    local MotorPairCache = setmetatable({}, { __mode = "k" })
    local function applyCrossRigMotorTransforms(myChar, tChar, myRig, tRig)
        if not myChar or not tChar then return end
        if myRig == tRig then
            local cache = MotorPairCache[tChar]
            if not cache or cache.myChar ~= myChar or (os.clock() - cache.builtAt) > 1.5 then
                local pairsList = {}
                for _, tMotor in ipairs(tChar:GetDescendants()) do
                    if tMotor:IsA("Motor6D") and tMotor.Parent then
                        local myPart = myChar:FindFirstChild(tMotor.Parent.Name)
                        local myMotor = myPart and myPart:FindFirstChild(tMotor.Name)
                        if myMotor and myMotor:IsA("Motor6D") then
                            pairsList[#pairsList + 1] = { src = tMotor, dst = myMotor }
                        end
                    end
                end
                cache = { myChar = myChar, builtAt = os.clock(), pairs = pairsList }
                MotorPairCache[tChar] = cache
            end
            for i = 1, #cache.pairs do
                local pair = cache.pairs[i]
                if pair.src.Parent and pair.dst.Parent then
                    pair.dst.Transform = pair.src.Transform
                end
            end
        elseif myRig == Enum.HumanoidRigType.R15 and tRig == Enum.HumanoidRigType.R6 then
            local tTorso = tChar:FindFirstChild("Torso")
            if not tTorso then return end
            local tNeck = tTorso:FindFirstChild("Neck")
            local tRSh = tTorso:FindFirstChild("Right Shoulder")
            local tLSh = tTorso:FindFirstChild("Left Shoulder")
            local tRHip = tTorso:FindFirstChild("Right Hip")
            local tLHip = tTorso:FindFirstChild("Left Hip")
            local tRootJ = (tChar:FindFirstChild("HumanoidRootPart") and tChar.HumanoidRootPart:FindFirstChild("RootJoint")) or tTorso:FindFirstChild("RootJoint")

            local head = myChar:FindFirstChild("Head")
            local lTorso = myChar:FindFirstChild("LowerTorso")
            local rUArm = myChar:FindFirstChild("RightUpperArm")
            local lUArm = myChar:FindFirstChild("LeftUpperArm")
            local rULeg = myChar:FindFirstChild("RightUpperLeg")
            local lULeg = myChar:FindFirstChild("LeftUpperLeg")

            if tNeck and head and head:FindFirstChild("Neck") then
                pcall(function() head.Neck.Transform = tNeck.Transform end)
            end
            if tRootJ and lTorso and lTorso:FindFirstChild("Root") then
                pcall(function() lTorso.Root.Transform = tRootJ.Transform end)
            end
            if tRSh and rUArm and rUArm:FindFirstChild("RightShoulder") then
                pcall(function() rUArm.RightShoulder.Transform = tRSh.Transform end)
            end
            if tLSh and lUArm and lUArm:FindFirstChild("LeftShoulder") then
                pcall(function() lUArm.LeftShoulder.Transform = tLSh.Transform end)
            end
            if tRHip and rULeg and rULeg:FindFirstChild("RightHip") then
                pcall(function() rULeg.RightHip.Transform = tRHip.Transform end)
            end
            if tLHip and lULeg and lULeg:FindFirstChild("LeftHip") then
                pcall(function() lULeg.LeftHip.Transform = tLHip.Transform end)
            end
        elseif myRig == Enum.HumanoidRigType.R6 and tRig == Enum.HumanoidRigType.R15 then
            local myTorso = myChar:FindFirstChild("Torso")
            if not myTorso then return end
            local head = tChar:FindFirstChild("Head")
            local uTorso = tChar:FindFirstChild("UpperTorso")
            local lTorso = tChar:FindFirstChild("LowerTorso")
            local rUArm = tChar:FindFirstChild("RightUpperArm")
            local rLArm = tChar:FindFirstChild("RightLowerArm")
            local lUArm = tChar:FindFirstChild("LeftUpperArm")
            local lLArm = tChar:FindFirstChild("LeftLowerArm")
            local rULeg = tChar:FindFirstChild("RightUpperLeg")
            local rLLeg = tChar:FindFirstChild("RightLowerLeg")
            local lULeg = tChar:FindFirstChild("LeftUpperLeg")
            local lLLeg = tChar:FindFirstChild("LeftLowerLeg")

            if head and head:FindFirstChild("Neck") and myTorso:FindFirstChild("Neck") then
                pcall(function() myTorso.Neck.Transform = head.Neck.Transform end)
            end
            local myRootJ = (myChar:FindFirstChild("HumanoidRootPart") and myChar.HumanoidRootPart:FindFirstChild("RootJoint")) or myTorso:FindFirstChild("RootJoint")
            if lTorso and lTorso:FindFirstChild("Root") and myRootJ then
                local wTf = (uTorso and uTorso:FindFirstChild("Waist") and uTorso.Waist.Transform) or CFrame.identity
                pcall(function() myRootJ.Transform = lTorso.Root.Transform * wTf end)
            end
            if rUArm and rUArm:FindFirstChild("RightShoulder") and myTorso:FindFirstChild("Right Shoulder") then
                local elb = (rLArm and rLArm:FindFirstChild("RightElbow") and rLArm.RightElbow.Transform) or CFrame.identity
                pcall(function() myTorso["Right Shoulder"].Transform = rUArm.RightShoulder.Transform * elb end)
            end
            if lUArm and lUArm:FindFirstChild("LeftShoulder") and myTorso:FindFirstChild("Left Shoulder") then
                local elb = (lLArm and lLArm:FindFirstChild("LeftElbow") and lLArm.LeftElbow.Transform) or CFrame.identity
                pcall(function() myTorso["Left Shoulder"].Transform = lUArm.LeftShoulder.Transform * elb end)
            end
            if rULeg and rULeg:FindFirstChild("RightHip") and myTorso:FindFirstChild("Right Hip") then
                local kn = (rLLeg and rLLeg:FindFirstChild("RightKnee") and rLLeg.RightKnee.Transform) or CFrame.identity
                pcall(function() myTorso["Right Hip"].Transform = rULeg.RightHip.Transform * kn end)
            end
            if lULeg and lULeg:FindFirstChild("LeftHip") and myTorso:FindFirstChild("Left Hip") then
                local kn = (lLLeg and lLLeg:FindFirstChild("LeftKnee") and lLLeg.LeftKnee.Transform) or CFrame.identity
                pcall(function() myTorso["Left Hip"].Transform = lULeg.LeftHip.Transform * kn end)
            end
        end
    end

    local function syncTargetAnimationTracksNow(self, c, hum, tc, th)
        if not self.active or not c or not hum or not tc or not th then return false end
        local tAnimator = th:FindFirstChildOfClass("Animator") or tc:FindFirstChildWhichIsA("Animator", true)
        local myAnimator = hum:FindFirstChildOfClass("Animator")
        if not myAnimator then
            pcall(function() myAnimator = Instance.new("Animator"); myAnimator.Parent = hum end)
        end
        if not myAnimator then return false end

        if tAnimator and self.hookedAnimator ~= tAnimator then
            if self.animPlayedConn then pcall(function() self.animPlayedConn:Disconnect() end); self.animPlayedConn = nil end
            self.hookedAnimator = tAnimator
            pcall(function()
                self.animPlayedConn = tAnimator.AnimationPlayed:Connect(function()
                    if not self.active then return end
                    local curC = LP.Character
                    local curH = curC and curC:FindFirstChildOfClass("Humanoid")
                    local curTC = self.target and findPlayerCharacterAnywhere(self.target)
                    local curTH = curTC and curTC:FindFirstChildOfClass("Humanoid")
                    if curC and curH and curTC and curTH then
                        syncTargetAnimationTracksNow(self, curC, curH, curTC, curTH)
                    end
                end)
            end)
        end

        local okTracks, tTracks = false, nil
        if tAnimator then
            okTracks, tTracks = pcall(function() return tAnimator:GetPlayingAnimationTracks() end)
        end

        local now = os.clock()
        local speedMult = math.clamp(self.copySpeedMult or 1.0, 0.2, 6.0)
        local timeOffset = (self.timeOffsetSec or 0.0) + (self.pingCompensate and (getPingSeconds() * 0.5) or 0.0)
        local syncTol = self.syncTolerance or 0.015

        if not okTracks or not tTracks or #tTracks == 0 then
            for sourceTrack, entry in pairs(self.mirroredTracks) do
                pcall(function() if entry.track then entry.track:Stop(0); entry.track:Destroy() end end)
                self.mirroredTracks[sourceTrack] = nil
            end
            return true
        end

        local seenTracks = {}
        local anyTrackStillLoading = false

        for i = 1, #tTracks do
            local trTrack = tTracks[i]
            local sourceWeight = trTrack.WeightCurrent or 1
            if trTrack.IsPlaying and sourceWeight > 0.0005 then
                local animObj = trTrack.Animation
                local rawAnimId = animObj and tostring(animObj.AnimationId or "") or ""
                local animId = rawAnimId
                if animId:match("^%d+$") then
                    animId = "rbxassetid://" .. animId
                end

                if animId ~= "" and not (self.failedIds[animId] and self.failedIds[animId] > tick()) then
                    seenTracks[trTrack] = true
                    local entry = self.mirroredTracks[trTrack]
                    if not entry or not entry.track or not entry.track.IsPlaying or entry.animId ~= animId then
                        if entry and entry.track then
                            pcall(function() entry.track:Stop(0); entry.track:Destroy() end)
                        end
                        entry = nil
                        pcall(function()
                            local cachedAnim = self.animObjCache[animId]
                            if not cachedAnim or cachedAnim.AnimationId ~= animId then
                                cachedAnim = Instance.new("Animation")
                                cachedAnim.AnimationId = animId
                                self.animObjCache[animId] = cachedAnim
                            end
                            local loaded = myAnimator:LoadAnimation(cachedAnim)
                            loaded.Priority = trTrack.Priority
                            loaded.Looped = trTrack.Looped
                            local sourceSpeed = trTrack.Speed or 1
                            local sourceTime = (trTrack.TimePosition or 0) + timeOffset
                            local clampedW = math.clamp(sourceWeight, 0.01, 1)
                            loaded:Play(0, clampedW, sourceSpeed * speedMult)
                            loaded:AdjustWeight(clampedW, 0)
                            local lenReady = (loaded.Length and loaded.Length > 0) or false
                            if lenReady then
                                local targetPos = loaded.Looped and (sourceTime % loaded.Length) or math.clamp(sourceTime, 0, loaded.Length)
                                loaded.TimePosition = math.max(0, targetPos)
                            else
                                anyTrackStillLoading = true
                            end
                            entry = {
                                track = loaded,
                                anim = cachedAnim,
                                animId = animId,
                                lastSeen = now,
                                lastTimeSync = now,
                                lastWeight = clampedW,
                                lastAppliedSpeed = sourceSpeed * speedMult,
                                lengthReady = lenReady,
                            }
                            self.mirroredTracks[trTrack] = entry
                            self.failedIds[animId] = nil
                        end)
                        if not entry then
                            self.failedIds[animId] = tick() + 8
                            anyTrackStillLoading = true
                        end
                    end

                    if entry and entry.track then
                        local sourceSpeed = trTrack.Speed or 1
                        local sourceTime = (trTrack.TimePosition or 0) + timeOffset
                        entry.track.Looped = trTrack.Looped
                        entry.track.Priority = trTrack.Priority
                        entry.lastSeen = now

                        local desiredSpeed = sourceSpeed * speedMult
                        if not entry.lastAppliedSpeed or math.abs(entry.lastAppliedSpeed - desiredSpeed) > 0.01 then
                            entry.track:AdjustSpeed(desiredSpeed)
                            entry.lastAppliedSpeed = desiredSpeed
                        end

                        local desiredWeight = math.clamp(sourceWeight, 0.01, 1)
                        if not entry.lastWeight or math.abs(entry.lastWeight - desiredWeight) > 0.015 then
                            entry.track:AdjustWeight(desiredWeight, 0)
                            entry.lastWeight = desiredWeight
                        end

                        local trackLen = entry.track.Length or 0
                        if trackLen > 0 then
                            local targetPos = entry.track.Looped and (sourceTime % trackLen) or math.clamp(sourceTime, 0, trackLen)
                            if not entry.lengthReady then
                                entry.lengthReady = true
                                entry.track.TimePosition = targetPos
                            else
                                local diff = math.abs(entry.track.TimePosition - targetPos)
                                if entry.track.Looped and trackLen > 0.1 then
                                    diff = math.min(diff, math.abs(trackLen - diff))
                                end
                                if diff > syncTol then
                                    entry.track.TimePosition = targetPos
                                end
                            end
                        else
                            anyTrackStillLoading = true
                        end
                    end
                end
            end
        end

        for sourceTrack, entry in pairs(self.mirroredTracks) do
            if not seenTracks[sourceTrack] then
                pcall(function() if entry.track then entry.track:Stop(0); entry.track:Destroy() end end)
                self.mirroredTracks[sourceTrack] = nil
            end
        end

        return anyTrackStillLoading
    end

    function AnimCopySys:Start(targetPlr)
        local TPlayer = resolveAnimCopyTarget(targetPlr)
        if not TPlayer or TPlayer.Parent ~= Players then
            notify("Anim Copy", "No target player found to copy animations!")
            return false
        end

        local myChar = LP.Character
        local myRoot = myChar and (myChar:FindFirstChild("HumanoidRootPart") or myChar:FindFirstChildWhichIsA("BasePart"))
        local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        if not myChar or not myRoot or not myHum or not isLocalCharAliveOrReanimated(myChar, myHum) then
            notify("Anim Copy", "Character not ready to copy animations!")
            return false
        end

        -- Fast 0.00ms Target Hot-Swap if already active
        if self.active and self.boundCharacter == myChar and self.hbConn and self.renderConn and self.stepConn then
            clearMirroredTracks(0)
            self.failedIds = {}
            self.hookedAnimator = nil
            if self.animPlayedConn then pcall(function() self.animPlayedConn:Disconnect() end); self.animPlayedConn = nil end
            self.target = TPlayer
            SelectedTargetPlayer = TPlayer
            local fastTC = findPlayerCharacterAnywhere(TPlayer)
            local fastTR = fastTC and pickTargetRef(fastTC, "root")
            local fastTH = fastTC and fastTC:FindFirstChildOfClass("Humanoid")
            if self.sideMode ~= "free" and fastTR and fastTR.Parent then
                local initCF = computeExactSideBySideCF(fastTR, myHum, fastTH, self.sideMode, self.sideDistance or 3.2)
                if initCF then
                    self.currentLockCF = initCF
                    myRoot.Anchored = false
                    myRoot.CFrame = initCF
                    myRoot.AssemblyLinearVelocity = fastTR.AssemblyLinearVelocity
                    myRoot.AssemblyAngularVelocity = Vector3.zero
                    pcall(function() LP.ReplicationFocus = fastTR end)
                    if sethiddenproperty then
                        pcall(function()
                            sethiddenproperty(myRoot, "PhysicsRepRootPart", fastTR)
                            if InstanceHandleNew then
                                sethiddenproperty(myRoot, "PhysicsRepRootRef", InstanceHandleNew(fastTR))
                            end
                            sethiddenproperty(myRoot, "NetworkIsSleeping", false)
                        end)
                    end
                    syncAnimCopyReanimRoots(initCF, myRoot)
                end
            end
            if fastTC and fastTH then
                pcall(function()
                    local needBridge = syncTargetAnimationTracksNow(self, myChar, myHum, fastTC, fastTH)
                    if self.syncMotorTransforms or needBridge or myHum.RigType ~= fastTH.RigType then
                        applyCrossRigMotorTransforms(myChar, fastTC, myHum.RigType, fastTH.RigType)
                    end
                end)
            end
            if type(self.onStateChanged) == "function" then pcall(self.onStateChanged) end
            return true, TPlayer
        end

        self:Stop(true)

        RescueGeneration = RescueGeneration + 1
        pcall(function() end) -- anim-copy FPDH void-immune removed; jamun anti-void only
        self.preCopySafeCF = isSafePlayableCF(myRoot.CFrame) and myRoot.CFrame or LastKnownSafeCF or findFallbackSafeCF()

        clearMirroredTracks(0)
        self.failedIds = {}
        self.lastTargetAvailable = os.clock()
        self.boundCharacter = myChar
        self.clock = 0
        self.missingFrames = 0
        self.lastStreamReq = 0
        self.active = true
        self.target = TPlayer
        SelectedTargetPlayer = TPlayer

        breakAllSeatsAndExternalJoints(myChar, myHum, myRoot)
        killAnimate(myChar)

        local copyCachedParts = {}
        for _, part in ipairs(myChar:GetDescendants()) do
            if part:IsA("BasePart") then
                copyCachedParts[#copyCachedParts + 1] = part
                part.CanCollide = false
                part.CanTouch = false
                part.CanQuery = false
                part.Massless = true
                part.Anchored = false
            elseif part:IsA("SeatWeld") or part.Name == "SeatWeld" then
                pcall(function() part:Destroy() end)
            end
        end

        self.descConn = myChar.DescendantAdded:Connect(function(v)
            if not self.active then return end
            if v:IsA("BasePart") then
                copyCachedParts[#copyCachedParts + 1] = v
                v.CanCollide = false
                v.CanTouch = false
                v.CanQuery = false
                v.Massless = true
                v.Anchored = false
            elseif v:IsA("Tool") then
                for _, tp in ipairs(v:GetDescendants()) do
                    if tp:IsA("BasePart") then
                        copyCachedParts[#copyCachedParts + 1] = tp
                        tp.CanCollide = false
                        tp.CanTouch = false
                        tp.CanQuery = false
                        tp.Massless = true
                        tp.Anchored = false
                    end
                end
            elseif v:IsA("SeatWeld") or v.Name == "SeatWeld" then
                pcall(function() v:Destroy() end)
            end
        end)

        local function applyCopyPhaseNoclip()
            for i = 1, #copyCachedParts do
                local v = copyCachedParts[i]
                if v and v.Parent then
                    if v.CanCollide then v.CanCollide = false end
                    if v.CanTouch then v.CanTouch = false end
                    if v.CanQuery then v.CanQuery = false end
                    if not v.Massless then v.Massless = true end
                    if v.Anchored then v.Anchored = false end
                end
            end
            if myHum and myHum.Sit then
                pcall(function() myHum.Sit = false end)
            end
        end
        applyCopyPhaseNoclip()

        local function stepAnimCopyZeroDelayWeldCF()
            if not self.active or self.sideMode == "free" then return end
            local c = LP.Character
            local root = c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChildWhichIsA("BasePart"))
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            if not c or not root or not hum then return end
            local tc = self.target and findPlayerCharacterAnywhere(self.target)
            local tr = tc and pickTargetRef(tc, "root")
            local th = tc and tc:FindFirstChildOfClass("Humanoid")
            local isCopyReanim = (tc and isCharacterNetlessReanimated(tc)) or (findTargetReanimModel(self.target) ~= nil)
            if not tc or not tr or not tr.Parent or (not isCopyReanim and (not th or th.Health <= 0)) then return end
            local tVel = tr.AssemblyLinearVelocity
            if isLethalVoidCF(tr.CFrame, tVel) then return end
            local desiredCF = computeExactSideBySideCF(tr, hum, th, self.sideMode, self.sideDistance or 3.2)
            if desiredCF then
                self.currentLockCF = desiredCF
                root.Anchored = false
                root.CFrame = desiredCF
                local microWake = Vector3.new(0, math.sin((self.clock or 0) * 24) * 0.03, 0)
                root.AssemblyLinearVelocity = (tVel.Magnitude < 350 and (tVel * 0.85) or Vector3.zero) + microWake
                root.AssemblyAngularVelocity = Vector3.zero
                syncAnimCopyReanimRoots(desiredCF, root)
                pcall(function() LP.ReplicationFocus = tr end)
                if sethiddenproperty then
                    pcall(function()
                        sethiddenproperty(root, "PhysicsRepRootPart", tr)
                        if InstanceHandleNew then
                            sethiddenproperty(root, "PhysicsRepRootRef", InstanceHandleNew(tr))
                        end
                        sethiddenproperty(root, "NetworkIsSleeping", false)
                    end)
                end
            end
        end

        -- Frame-0 Immediate CFrame Lock
        local tChar = findPlayerCharacterAnywhere(TPlayer)
        local tRoot = tChar and pickTargetRef(tChar, "root")
        local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
        if self.sideMode ~= "free" then
            if tRoot and tRoot.Parent then
                local initialCF = computeExactSideBySideCF(tRoot, myHum, tHum, self.sideMode, self.sideDistance or 3.2)
                if initialCF then
                    self.currentLockCF = initialCF
                    LastKnownSafeCF = initialCF
                    myRoot.Anchored = false
                    myRoot.CFrame = initialCF
                    myRoot.AssemblyLinearVelocity = tRoot.AssemblyLinearVelocity
                    myRoot.AssemblyAngularVelocity = Vector3.zero
                    pcall(function() LP.ReplicationFocus = tRoot end)
                    if sethiddenproperty then
                        pcall(function()
                            sethiddenproperty(myRoot, "PhysicsRepRootPart", tRoot)
                            if InstanceHandleNew then
                                sethiddenproperty(myRoot, "PhysicsRepRootRef", InstanceHandleNew(tRoot))
                            end
                            sethiddenproperty(myRoot, "NetworkIsSleeping", false)
                        end)
                    end
                    syncAnimCopyReanimRoots(initialCF, myRoot)
                end
            else
                task.spawn(function()
                    local dist = self.sideDistance or 3.2
                    local sideOffset = (self.sideMode == "left") and CFrame.new(-dist, 0, 0)
                        or (self.sideMode == "front" and (CFrame.new(0, 0, -dist) * CFrame.Angles(0, math.pi, 0)))
                        or (self.sideMode == "back" and CFrame.new(0, 0, dist))
                        or (self.sideMode == "weld" and CFrame.new(0, 0, 0))
                        or (self.sideMode == "above" and CFrame.new(0, dist + 1.0, 0))
                        or CFrame.new(dist, 0, 0)
                    streamAndTeleportToTarget(TPlayer, "root", 1.8, sideOffset)
                    if self.active then
                        stepAnimCopyZeroDelayWeldCF()
                    end
                end)
            end
        end

        if tChar and tHum then
            pcall(function()
                local needBridge = syncTargetAnimationTracksNow(self, myChar, myHum, tChar, tHum)
                if self.syncMotorTransforms or needBridge or myHum.RigType ~= tHum.RigType then
                    applyCrossRigMotorTransforms(myChar, tChar, myHum.RigType, tHum.RigType)
                end
            end)
        end

        pcall(function()
            RunService:BindToRenderStep("CocoAnimCopyZeroDelayPreCam", Enum.RenderPriority.Camera.Value - 1, stepAnimCopyZeroDelayWeldCF)
            RunService:BindToRenderStep("CocoAnimCopyZeroDelayLock", Enum.RenderPriority.Character.Value + 1, stepAnimCopyZeroDelayWeldCF)
        end)

        -- Pass 1: RenderStepped Visual Lock & Pre-Animator Track Sync
        self.renderConn = RunService.RenderStepped:Connect(function()
            if not self.active then return end
            local c = LP.Character
            local root = c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChildWhichIsA("BasePart"))
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            if not c or not root or not hum then return end

            local tc = self.target and findPlayerCharacterAnywhere(self.target)
            local tr = tc and pickTargetRef(tc, "root")
            local th = tc and tc:FindFirstChildOfClass("Humanoid")
            local isCopyReanim = (tc and isCharacterNetlessReanimated(tc)) or (findTargetReanimModel(self.target) ~= nil)
            if not tc or not tr or not tr.Parent or (not isCopyReanim and (not th or th.Health <= 0)) then return end

            if self.sideMode ~= "free" and not isLethalVoidCF(tr.CFrame, tr.AssemblyLinearVelocity) then
                local desiredCF = computeExactSideBySideCF(tr, hum, th, self.sideMode, self.sideDistance or 3.2)
                if desiredCF then
                    self.currentLockCF = desiredCF
                    root.CFrame = desiredCF
                    syncAnimCopyReanimRoots(desiredCF, root)
                end
            end
            syncTargetAnimationTracksNow(self, c, hum, tc, th)
        end)

        -- Pass 2: Stepped Phase Noclip, Physics Lock & Real-Time Motor6D Pose Bridge
        self.stepConn = RunService.Stepped:Connect(function()
            if not self.active then return end
            applyCopyPhaseNoclip()
            local c = LP.Character
            local root = c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChildWhichIsA("BasePart"))
            if self.sideMode ~= "free" and self.currentLockCF and root and root.Parent then
                root.CFrame = self.currentLockCF
                syncAnimCopyReanimRoots(self.currentLockCF, root)
            end
            local tc = self.target and findPlayerCharacterAnywhere(self.target)
            local th = tc and tc:FindFirstChildOfClass("Humanoid")
            local myH = c and c:FindFirstChildOfClass("Humanoid")
            if tc and th and myH then
                if self.syncMotorTransforms or myH.RigType ~= th.RigType then
                    applyCrossRigMotorTransforms(c, tc, myH.RigType, th.RigType)
                else
                    for _, entry in pairs(self.mirroredTracks) do
                        if not entry.lengthReady then
                            applyCrossRigMotorTransforms(c, tc, myH.RigType, th.RigType)
                            break
                        end
                    end
                end
            end
        end)

        -- Pass 3: Heartbeat Omnipresent Lock, Physics Replication & Zero-Delay Animation Sync
        self.hbConn = RunService.Heartbeat:Connect(function(dt)
            if not self.active then return end
            local c = LP.Character
            local root = c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChildWhichIsA("BasePart"))
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            if not c or not root or not hum or not isLocalCharAliveOrReanimated(c, hum) then
                self:Stop(true)
                return
            end

            if not self.target or self.target.Parent ~= Players then
                local leftName = self.target and self.target.Name or "Target"
                self:Stop(false)
                notify("Anim Copy", "Target @" .. leftName .. " left the game — detached safely.")
                return
            end

            local now = os.clock()
            if self.boundCharacter ~= c then
                clearMirroredTracks(0)
                self.boundCharacter = c
                breakAllSeatsAndExternalJoints(c, hum, root)
                killAnimate(c)
            end

            local tc = findPlayerCharacterAnywhere(self.target)
            local tr = tc and pickTargetRef(tc, "root")
            local th = tc and tc:FindFirstChildOfClass("Humanoid")

            local isTargetReanim = (tc and isCharacterNetlessReanimated(tc)) or (findTargetReanimModel(self.target) ~= nil)
            if not tr or not tr.Parent or not isRefPartValid(tr, tc) or (not isTargetReanim and (not th or th.Health <= 0)) then
                if self.sideMode ~= "free" and not (th and th.Health <= 0 and not isTargetReanim) then
                    self.missingFrames = (self.missingFrames or 0) + 1
                    pcall(function() LP.ReplicationFocus = nil end)
                    if sethiddenproperty then
                        pcall(function() sethiddenproperty(root, "PhysicsRepRootPart", nil) end)
                        pcall(function() sethiddenproperty(root, "PhysicsRepRootRef", nil) end)
                    end
                    local hasStreamedParts = (tc and tc:FindFirstChildWhichIsA("BasePart", true) ~= nil)
                    if hasStreamedParts then
                        local holdCF = self.currentLockCF or self.preCopySafeCF
                        if holdCF then
                            root.CFrame = holdCF
                            root.AssemblyLinearVelocity = Vector3.zero
                            root.AssemblyAngularVelocity = Vector3.zero
                            syncAnimCopyReanimRoots(holdCF, root)
                        end
                    else
                        local hiddenCF = getBestTargetCFrame(self.target)
                        if hiddenCF and isValidTargetWorldCF(hiddenCF) then
                            local tNow = tick()
                            if tNow - (self.lastStreamReq or 0) > 0.35 then
                                self.lastStreamReq = tNow
                                ensureStreamFocusAt(hiddenCF)
                                task.spawn(function()
                                    pcall(function() LP:RequestStreamAroundAsync(hiddenCF.Position, 1.5) end)
                                end)
                            end
                            local chaseCF = hiddenCF * CFrame.new(self.sideDistance or 3.2, 0, 0)
                            self.currentLockCF = chaseCF
                            root.CFrame = chaseCF
                            root.AssemblyLinearVelocity = Vector3.zero
                            root.AssemblyAngularVelocity = Vector3.zero
                        end
                    end
                end
                if self.lastTargetAvailable > 0 and now - self.lastTargetAvailable > 1.25 then
                    clearMirroredTracks(0.18)
                end
                return
            end
            self.missingFrames = 0
            self.lastTargetAvailable = now

            local tVel = tr.AssemblyLinearVelocity
            if self.sideMode ~= "free" and isLethalVoidCF(tr.CFrame, tVel) then
                self:Stop(false)
                -- void detach disabled
                return
            end

            local focusPart = tr
            pcall(function() LP.ReplicationFocus = focusPart end)

            PlayerLocationCache[self.target.UserId] = { cf = tr.CFrame, time = tick(), verified = true }
            if not isLethalVoidCF(tr.CFrame, tVel) and math.abs(tVel.Y) < 45 and (not th or th.FloorMaterial ~= Enum.Material.Air) then
                local _, yYaw, _ = tr.CFrame:ToEulerAnglesYXZ()
                self.preCopySafeCF = CFrame.new(tr.Position + Vector3.new(0, 2.5, 0)) * CFrame.Angles(0, yYaw, 0)
                LastKnownSafeCF = self.preCopySafeCF
            end

            local animate = c:FindFirstChild("Animate")
            if animate and not animate.Disabled then
                animate.Disabled = true
                AnimateWasDisabled = true
            end

            local speedMult = math.clamp(self.copySpeedMult or 1.0, 0.2, 6.0)
            self.clock = (self.clock or 0) + (dt * speedMult)

            if self.sideMode ~= "free" then
                local desiredCF = computeExactSideBySideCF(tr, hum, th, self.sideMode, self.sideDistance or 3.2)
                if desiredCF then
                    self.currentLockCF = desiredCF
                    root.Anchored = false
                    root.CFrame = desiredCF
                    syncAnimCopyReanimRoots(desiredCF, root)
                    local microWake = Vector3.new(0, math.sin(self.clock * 24) * 0.03, 0)
                    root.AssemblyLinearVelocity = (tVel.Magnitude < 350 and (tVel * 0.85) or Vector3.zero) + microWake
                    root.AssemblyAngularVelocity = Vector3.zero
                    if sethiddenproperty then
                        pcall(function()
                            sethiddenproperty(root, "PhysicsRepRootPart", focusPart)
                            if InstanceHandleNew then
                                sethiddenproperty(root, "PhysicsRepRootRef", InstanceHandleNew(focusPart))
                            end
                            sethiddenproperty(root, "NetworkIsSleeping", false)
                        end)
                    end
                    pcall(function()
                        if hum.Sit then hum.Sit = false end
                        hum.AutoRotate = false
                    end)
                end
            else
                pcall(function() hum.AutoRotate = true end)
            end

            local needBridge = syncTargetAnimationTracksNow(self, c, hum, tc, th)
            if needBridge or self.syncMotorTransforms or hum.RigType ~= th.RigType then
                applyCrossRigMotorTransforms(c, tc, hum.RigType, th.RigType)
            end
        end)

        if type(self.onStateChanged) == "function" then
            pcall(self.onStateChanged)
        end
        notify("Anim Copy", "Live syncing animations from @" .. TPlayer.Name .. " (" .. self.sideMode:upper() .. ")")
        return true, TPlayer
    end
end)()

_G.AnimCopySys = AnimCopySys

-- ═══════════════════════════════════════════════════════════════════════════════
-- COMPACT STANDALONE UI (ALL 13 ANIMATION COPY CONTROLS)
-- ═══════════════════════════════════════════════════════════════════════════════
local guiParent = nil
pcall(function() if gethui then guiParent = gethui() end end)
if not guiParent then
    pcall(function() guiParent = game:GetService("CoreGui") end)
end
if not guiParent then
    guiParent = LP:WaitForChild("PlayerGui")
end

local existingGui = guiParent:FindFirstChild("AnimCopyStandaloneUI")
if existingGui then existingGui:Destroy() end

-- hub export
_G.JamunAnimCopy = AnimCopySys
_G.JamunAnimCopyReady = true
print("[Jamun AnimCopy] engine ready")

]=]
    local okLoad, fnOrErr = pcall(loadstring, __jamunAnimCopySrc)
    if okLoad and type(fnOrErr) == "function" then
        local okRun, errRun = pcall(fnOrErr)
        if not okRun then
            warn("[Jamun AnimCopy] run failed:", errRun)
            print("[Jamun AnimCopy] run failed:", tostring(errRun))
        end
    else
        warn("[Jamun AnimCopy] loadstring failed:", fnOrErr)
        print("[Jamun AnimCopy] loadstring failed:", tostring(fnOrErr))
    end
end)()


-- ============================================================================
-- THEME
-- ============================================================================
local C = {
    -- Riyon V1 obsidian palette (preserved)
    glassBg      = Color3.fromRGB(8, 8, 8),
    glassTint    = Color3.fromRGB(6, 6, 8),
    glassTile    = Color3.fromRGB(14, 14, 14),
    glassInput   = Color3.fromRGB(24, 24, 24),
    surface      = Color3.fromRGB(20, 20, 20),
    surfaceHover = Color3.fromRGB(28, 28, 28),
    accent       = Color3.fromRGB(248, 248, 255),
    accentDim    = Color3.fromRGB(180, 180, 185),
    accentSoft   = Color3.fromRGB(90, 90, 100),
    danger       = Color3.fromRGB(230, 70, 70),
    warn         = Color3.fromRGB(240, 180, 60),
    good         = Color3.fromRGB(80, 220, 140),
    text         = Color3.fromRGB(220, 220, 228),
    text2        = Color3.fromRGB(150, 150, 165),
    text3        = Color3.fromRGB(100, 100, 115),
    stroke       = Color3.fromRGB(35, 35, 45),
}
C.panel=C.glassBg; C.panel2=C.glassBg; C.panel3=C.glassTile; C.input=C.glassInput
C.stroke2=C.accent; C.neon=C.accent; C.gd=C.good; C.bd=C.danger; C.wn=C.warn
C.tx=C.text; C.tx2=C.text2; C.tx3=C.text3; C.accentD=C.accentDim; C.accentS=C.accentSoft

local G = {
    -- premium dark glass
    panelTransparency=0.03, tileTransparency=0.1, inputTransparency=0.06,
    accentTransparency=0.05, borderTransparency=0.35, rowTransparency=0.5,
    radiusPanel=18, radiusTile=12, radiusInput=9,
}

local SID = "rbxassetid://6895079853"
local IS_MOBILE = UIS.TouchEnabled and not UIS.KeyboardEnabled
if _G.__jamunAntiVoid == nil then _G.__jamunAntiVoid = true end
pcall(function() if _G.__jamunAntiVoid then WS.FallenPartsDestroyHeight = -math.huge end end)

local retintPanel = nil
local applyMobileFit = nil

local function safeFont(name, fallback)
    fallback = fallback or Enum.Font.GothamMedium
    local ok, f = pcall(function() return Enum.Font[name] end)
    if ok and f then return f end
    return fallback
end

-- FontFace for live text (Enum.Font alone often won't override reanim labels)
local function fontFaceFrom(fontEnum, nameHints)
    if type(nameHints) == "table" then
        for _, n in ipairs(nameHints) do
            local ok, ff = pcall(function()
                return Font.fromName(n, Enum.FontWeight.Bold)
            end)
            if ok and ff then return ff end
            local ok2, ff2 = pcall(function()
                return Font.fromName(n, Enum.FontWeight.Regular)
            end)
            if ok2 and ff2 then return ff2 end
        end
    end
    local ok3, ff3 = pcall(function() return Font.fromEnum(fontEnum or Enum.Font.GothamMedium) end)
    if ok3 and ff3 then return ff3 end
    return Font.fromEnum(Enum.Font.GothamMedium)
end

local function applyTextFont(inst, fontEnum, face)
    if not inst then return end
    pcall(function() inst.Font = fontEnum end)
    if face then
        pcall(function() inst.FontFace = face end)
    else
        pcall(function() inst.FontFace = Font.fromEnum(fontEnum) end)
    end
end


-- ============================================================================
-- SHADERS
-- ============================================================================
local SHADERS = {
    -- full surface + accent themes (bg matches buttons)
    Neon     = { accent=Color3.fromRGB(248,248,255), accentD=Color3.fromRGB(180,180,190), accentS=Color3.fromRGB(100,100,110),
                 glassBg=Color3.fromRGB(18, 18, 22), glassTile=Color3.fromRGB(30, 30, 34), glassInput=Color3.fromRGB(40, 40, 44),
                 glassTint=Color3.fromRGB(12, 12, 16), stroke=Color3.fromRGB(55,55,65), text=Color3.fromRGB(235,235,240),
                 text2=Color3.fromRGB(160,165,180), text3=Color3.fromRGB(110,115,130), wash=Color3.fromRGB(200,200,220), font=safeFont("GothamBold"), symbol="✦" },
    Default  = { accent=Color3.fromRGB(200,210,255), accentD=Color3.fromRGB(140,150,190), accentS=Color3.fromRGB(80,85,120),
                 glassBg=Color3.fromRGB(14, 16, 28), glassTile=Color3.fromRGB(26, 28, 40), glassInput=Color3.fromRGB(36, 38, 50),
                 glassTint=Color3.fromRGB(8, 10, 22), stroke=Color3.fromRGB(48,52,70), text=Color3.fromRGB(220,225,240),
                 text2=Color3.fromRGB(150,160,185), text3=Color3.fromRGB(100,110,135), wash=Color3.fromRGB(100,120,180), font=safeFont("BuilderSans"), symbol="◈" },
    Void     = { accent=Color3.fromRGB(190,160,255), accentD=Color3.fromRGB(130,100,190), accentS=Color3.fromRGB(70,55,110),
                 glassBg=Color3.fromRGB(22, 14, 32), glassTile=Color3.fromRGB(34, 26, 44), glassInput=Color3.fromRGB(44, 36, 54),
                 glassTint=Color3.fromRGB(16, 8, 26), stroke=Color3.fromRGB(60,48,80), text=Color3.fromRGB(230,220,245),
                 text2=Color3.fromRGB(160,145,190), text3=Color3.fromRGB(110,100,140), wash=Color3.fromRGB(120,80,180), font=safeFont("GothamBlack"), symbol="☽" },
    Crimson  = { accent=Color3.fromRGB(255,120,130), accentD=Color3.fromRGB(180,70,80), accentS=Color3.fromRGB(100,40,50),
                 glassBg=Color3.fromRGB(28, 10, 12), glassTile=Color3.fromRGB(40, 22, 24), glassInput=Color3.fromRGB(50, 32, 34),
                 glassTint=Color3.fromRGB(22, 4, 6), stroke=Color3.fromRGB(70,40,42), text=Color3.fromRGB(245,220,220),
                 text2=Color3.fromRGB(190,140,145), text3=Color3.fromRGB(140,100,105), wash=Color3.fromRGB(160,50,55), font=safeFont("Antique"), symbol="♥" },
    Jamun    = { accent=Color3.fromRGB(220,120,190), accentD=Color3.fromRGB(160,70,130), accentS=Color3.fromRGB(90,40,75),
                 glassBg=Color3.fromRGB(26, 12, 24), glassTile=Color3.fromRGB(38, 24, 36), glassInput=Color3.fromRGB(48, 34, 46),
                 glassTint=Color3.fromRGB(20, 6, 18), stroke=Color3.fromRGB(70,42,62), text=Color3.fromRGB(245,225,240),
                 text2=Color3.fromRGB(185,145,175), text3=Color3.fromRGB(130,100,125), wash=Color3.fromRGB(140,50,110), font=safeFont("GothamBlack"), symbol="●" },
    Ocean    = { accent=Color3.fromRGB(100,200,255), accentD=Color3.fromRGB(60,140,200), accentS=Color3.fromRGB(40,90,130),
                 glassBg=Color3.fromRGB(8, 22, 32), glassTile=Color3.fromRGB(20, 34, 44), glassInput=Color3.fromRGB(30, 44, 54),
                 glassTint=Color3.fromRGB(2, 16, 26), stroke=Color3.fromRGB(40,60,80), text=Color3.fromRGB(220,235,245),
                 text2=Color3.fromRGB(140,175,195), text3=Color3.fromRGB(95,125,145), wash=Color3.fromRGB(40,120,180), font=safeFont("Highway"), symbol="≈" },
    Emerald  = { accent=Color3.fromRGB(90,230,170), accentD=Color3.fromRGB(50,170,120), accentS=Color3.fromRGB(30,100,70),
                 glassBg=Color3.fromRGB(8, 26, 18), glassTile=Color3.fromRGB(20, 38, 30), glassInput=Color3.fromRGB(30, 48, 40),
                 glassTint=Color3.fromRGB(2, 20, 12), stroke=Color3.fromRGB(40,70,55), text=Color3.fromRGB(220,245,230),
                 text2=Color3.fromRGB(140,190,165), text3=Color3.fromRGB(95,140,120), wash=Color3.fromRGB(40,140,100), font=safeFont("DenkOne"), symbol="♣" },
    Amber    = { accent=Color3.fromRGB(255,190,90), accentD=Color3.fromRGB(200,140,50), accentS=Color3.fromRGB(120,80,30),
                 glassBg=Color3.fromRGB(28, 20, 8), glassTile=Color3.fromRGB(40, 32, 20), glassInput=Color3.fromRGB(50, 42, 30),
                 glassTint=Color3.fromRGB(22, 14, 2), stroke=Color3.fromRGB(70,58,35), text=Color3.fromRGB(245,235,210),
                 text2=Color3.fromRGB(190,170,130), text3=Color3.fromRGB(140,125,95), wash=Color3.fromRGB(180,120,40), font=safeFont("Bodoni"), symbol="◆" },
    Rose     = { accent=Color3.fromRGB(255,140,170), accentD=Color3.fromRGB(200,90,120), accentS=Color3.fromRGB(120,50,70),
                 glassBg=Color3.fromRGB(28, 12, 18), glassTile=Color3.fromRGB(40, 24, 30), glassInput=Color3.fromRGB(50, 34, 40),
                 glassTint=Color3.fromRGB(22, 6, 12), stroke=Color3.fromRGB(75,45,55), text=Color3.fromRGB(245,225,230),
                 text2=Color3.fromRGB(195,150,165), text3=Color3.fromRGB(145,110,120), wash=Color3.fromRGB(180,70,100), font=safeFont("Fondamento"), symbol="❀" },
    Ice      = { accent=Color3.fromRGB(180,230,255), accentD=Color3.fromRGB(120,180,220), accentS=Color3.fromRGB(70,120,150),
                 glassBg=Color3.fromRGB(12, 22, 30), glassTile=Color3.fromRGB(24, 34, 42), glassInput=Color3.fromRGB(34, 44, 52),
                 glassTint=Color3.fromRGB(6, 16, 24), stroke=Color3.fromRGB(50,70,85), text=Color3.fromRGB(225,240,250),
                 text2=Color3.fromRGB(155,185,205), text3=Color3.fromRGB(110,140,160), wash=Color3.fromRGB(100,170,210), font=safeFont("JosefinSans"), symbol="❄" },
    Sunset   = { accent=Color3.fromRGB(255,140,90), accentD=Color3.fromRGB(210,90,50), accentS=Color3.fromRGB(130,55,30),
                 glassBg=Color3.fromRGB(30, 14, 8), glassTile=Color3.fromRGB(42, 26, 20), glassInput=Color3.fromRGB(52, 36, 30),
                 glassTint=Color3.fromRGB(24, 8, 2), stroke=Color3.fromRGB(75,48,38), text=Color3.fromRGB(245,228,215),
                 text2=Color3.fromRGB(195,155,130), text3=Color3.fromRGB(145,115,95), wash=Color3.fromRGB(200,90,50), font=safeFont("Fantasy"), symbol="☀" },
    Toxic    = { accent=Color3.fromRGB(170,255,80), accentD=Color3.fromRGB(110,190,40), accentS=Color3.fromRGB(60,110,25),
                 glassBg=Color3.fromRGB(12, 28, 10), glassTile=Color3.fromRGB(24, 40, 22), glassInput=Color3.fromRGB(34, 50, 32),
                 glassTint=Color3.fromRGB(6, 22, 4), stroke=Color3.fromRGB(50,75,40), text=Color3.fromRGB(230,250,215),
                 text2=Color3.fromRGB(160,200,130), text3=Color3.fromRGB(115,150,95), wash=Color3.fromRGB(100,180,40), font=safeFont("Code"), symbol="☢" },
    Midnight = { accent=Color3.fromRGB(120,140,255), accentD=Color3.fromRGB(70,90,190), accentS=Color3.fromRGB(40,50,120),
                 glassBg=Color3.fromRGB(10, 12, 30), glassTile=Color3.fromRGB(22, 24, 42), glassInput=Color3.fromRGB(32, 34, 52),
                 glassTint=Color3.fromRGB(4, 6, 24), stroke=Color3.fromRGB(40,45,80), text=Color3.fromRGB(220,225,250),
                 text2=Color3.fromRGB(140,150,200), text3=Color3.fromRGB(95,105,150), wash=Color3.fromRGB(60,70,160), font=safeFont("SciFi"), symbol="★" },
    Gold     = { accent=Color3.fromRGB(255,215,120), accentD=Color3.fromRGB(200,160,70), accentS=Color3.fromRGB(120,95,40),
                 glassBg=Color3.fromRGB(28, 24, 10), glassTile=Color3.fromRGB(40, 36, 22), glassInput=Color3.fromRGB(50, 46, 32),
                 glassTint=Color3.fromRGB(22, 18, 4), stroke=Color3.fromRGB(70,62,40), text=Color3.fromRGB(245,240,215),
                 text2=Color3.fromRGB(190,180,140), text3=Color3.fromRGB(140,130,100), wash=Color3.fromRGB(180,150,60), font=safeFont("Highway"), symbol="♛" },
    Sakura   = { accent=Color3.fromRGB(255,170,200), accentD=Color3.fromRGB(210,110,150), accentS=Color3.fromRGB(130,70,95),
                 glassBg=Color3.fromRGB(28, 14, 22), glassTile=Color3.fromRGB(40, 26, 34), glassInput=Color3.fromRGB(50, 36, 44),
                 glassTint=Color3.fromRGB(22, 8, 16), stroke=Color3.fromRGB(75,50,62), text=Color3.fromRGB(250,230,240),
                 text2=Color3.fromRGB(200,155,175), text3=Color3.fromRGB(150,115,135), wash=Color3.fromRGB(200,100,140), font=safeFont("IndieFlower"), symbol="✿" },
    Matrix   = { accent=Color3.fromRGB(80,255,120), accentD=Color3.fromRGB(40,180,80), accentS=Color3.fromRGB(25,100,50),
                 glassBg=Color3.fromRGB(4, 18, 8), glassTile=Color3.fromRGB(16, 30, 20), glassInput=Color3.fromRGB(26, 40, 30),
                 glassTint=Color3.fromRGB(0, 12, 2), stroke=Color3.fromRGB(30,60,40), text=Color3.fromRGB(200,255,210),
                 text2=Color3.fromRGB(120,190,140), text3=Color3.fromRGB(80,140,100), wash=Color3.fromRGB(30,160,70), font=safeFont("RobotoMono"), symbol="⌘" },
    -- anime / style packs
    Cyberpunk= { accent=Color3.fromRGB(0,255,220), accentD=Color3.fromRGB(255,40,180), accentS=Color3.fromRGB(80,20,120),
                 glassBg=Color3.fromRGB(8,4,18), glassTile=Color3.fromRGB(18,8,32), glassInput=Color3.fromRGB(28,12,48),
                 glassTint=Color3.fromRGB(4,2,12), stroke=Color3.fromRGB(80,30,110), text=Color3.fromRGB(220,255,250),
                 text2=Color3.fromRGB(160,200,220), text3=Color3.fromRGB(110,140,170), wash=Color3.fromRGB(255,40,180), font=safeFont("SciFi"), symbol="⬡" },
    DBZ      = { accent=Color3.fromRGB(255,160,40), accentD=Color3.fromRGB(255,90,20), accentS=Color3.fromRGB(180,50,10),
                 glassBg=Color3.fromRGB(18,10,4), glassTile=Color3.fromRGB(32,18,8), glassInput=Color3.fromRGB(48,26,12),
                 glassTint=Color3.fromRGB(12,6,2), stroke=Color3.fromRGB(90,50,20), text=Color3.fromRGB(255,240,210),
                 text2=Color3.fromRGB(220,170,100), text3=Color3.fromRGB(160,120,70), wash=Color3.fromRGB(255,120,30), font=safeFont("GothamBlack"), symbol="★" },
    Bleach   = { accent=Color3.fromRGB(220,40,40), accentD=Color3.fromRGB(160,20,20), accentS=Color3.fromRGB(90,10,10),
                 glassBg=Color3.fromRGB(6,6,8), glassTile=Color3.fromRGB(16,14,16), glassInput=Color3.fromRGB(28,22,24),
                 glassTint=Color3.fromRGB(2,2,4), stroke=Color3.fromRGB(70,30,30), text=Color3.fromRGB(240,235,235),
                 text2=Color3.fromRGB(180,150,150), text3=Color3.fromRGB(120,100,100), wash=Color3.fromRGB(180,20,20), font=safeFont("Antique"), symbol="斬" },
    Naruto   = { accent=Color3.fromRGB(255,120,30), accentD=Color3.fromRGB(40,120,220), accentS=Color3.fromRGB(20,70,140),
                 glassBg=Color3.fromRGB(14,10,6), glassTile=Color3.fromRGB(28,18,10), glassInput=Color3.fromRGB(40,26,14),
                 glassTint=Color3.fromRGB(8,6,3), stroke=Color3.fromRGB(80,50,25), text=Color3.fromRGB(255,245,220),
                 text2=Color3.fromRGB(210,160,90), text3=Color3.fromRGB(150,110,60), wash=Color3.fromRGB(50,110,200), font=safeFont("Cartoon"), symbol="忍" },
    Aether   = { accent=Color3.fromRGB(180,220,255), accentD=Color3.fromRGB(140,170,255), accentS=Color3.fromRGB(80,100,180),
                 glassBg=Color3.fromRGB(10,12,22), glassTile=Color3.fromRGB(18,22,40), glassInput=Color3.fromRGB(28,34,58),
                 glassTint=Color3.fromRGB(6,8,16), stroke=Color3.fromRGB(50,60,100), text=Color3.fromRGB(230,240,255),
                 text2=Color3.fromRGB(160,180,220), text3=Color3.fromRGB(110,130,170), wash=Color3.fromRGB(120,160,255), font=safeFont("Fondamento"), symbol="✧" },
}
local THEME_ORDER = {
    "Neon","Default","Void","Crimson","Jamun","Ocean","Emerald","Amber",
    "Rose","Ice","Sunset","Toxic","Midnight","Gold","Sakura","Matrix",
    "Cyberpunk","DBZ","Bleach","Naruto","Aether",
}
-- preferred Font.fromName candidates (Roblox has no licensed anime typefaces;
-- these are the closest bold/stylized faces available at runtime)
local THEME_FACE_HINTS = {
    Cyberpunk = {"Orbitron", "Rajdhani", "RobotoMono", "Oswald"},
    DBZ       = {"Bangers", "LuckiestGuy", "PermanentMarker", "Oswald"},
    Bleach    = {"Cinzel", "CinzelDecorative", "PlayfairDisplay", "Antique"},
    Naruto    = {"PermanentMarker", "Bangers", "ComicNeueAngular", "Cartoon"},
    Matrix    = {"RobotoMono", "SourceCodePro", "Code"},
    Toxic     = {"RobotoMono", "SourceCodePro"},
    Midnight  = {"Orbitron", "Rajdhani", "SciFi"},
    Gold      = {"Cinzel", "PlayfairDisplay"},
    Sakura    = {"GreatVibes", "DancingScript", "Fondamento"},
    Aether    = {"Cinzel", "Philosopher", "Fondamento"},
}
local currentThemeName = "Neon"
local currentFontFace = nil
local themedElements = {}
local function registerThemed(i,k) table.insert(themedElements,{inst=i,key=k}) end
local function applyShader(name)
    local s=SHADERS[name]; if not s then return end
    currentThemeName = name
    for k,v in pairs(s) do
        if type(v) == "userdata" or typeof(v) == "Color3" then
            C[k] = v
        end
    end
    C.accentD = s.accentD or C.accentDim
    C.accentS = s.accentS or C.accentSoft
    C.accentDim = C.accentD
    C.accentSoft = C.accentS
    C.stroke2 = C.accent
    C.neon = C.accent
    C.panel = C.glassBg
    C.panel2 = C.glassBg
    C.panel3 = C.glassTile
    C.input = C.glassInput
    C.tx = C.text; C.tx2 = C.text2; C.tx3 = C.text3
    if s.font then C.font = s.font end
    currentFontFace = fontFaceFrom(C.font or Enum.Font.GothamMedium, THEME_FACE_HINTS[name])
    C.fontFace = currentFontFace
    for _,e in ipairs(themedElements) do
        local inst=e.inst
        if inst and inst.Parent then
            local col=C[e.key]
            if col then
                if inst:IsA("UIStroke") then inst.Color=col
                elseif inst:IsA("TextLabel") or inst:IsA("TextButton") then
                    -- don't override selected dark-ink buttons
                    if not (inst:IsA("TextButton") and inst.TextColor3.R < 0.2) then
                        inst.TextColor3=col
                    end
                else inst.BackgroundColor3=col; if inst.SetAttribute then inst:SetAttribute("baseColor",col) end end
            end
        end
    end
    if retintPanel then pcall(retintPanel) end
    if type(_G.__jamunRetintReanim) == "function" then pcall(_G.__jamunRetintReanim) end
    -- retint headtags to match new theme
    if type(_G.__jamunRetintHT) == "function" then
        pcall(_G.__jamunRetintHT)
    elseif type(htRetintAll) == "function" then
        pcall(htRetintAll)
    end
end

-- ============================================================================
-- UI POLLER
-- ============================================================================
local UIPollers={}
local function registerUIPoller(fn) table.insert(UIPollers,fn) end
task.spawn(function() while task.wait(1) do for i=1,#UIPollers do pcall(UIPollers[i]) end end end)

-- ============================================================================
-- HELPERS
-- ============================================================================
local function corner(p,r) local u=Instance.new("UICorner"); u.CornerRadius=UDim.new(0,r or G.radiusInput); u.Parent=p; return u end
local function stroke(p,c,t,tr)
    local s=Instance.new("UIStroke"); s.Color=c or C.stroke; s.Thickness=t or 1
    s.Transparency=tr or G.borderTransparency; s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border; s.Parent=p; return s
end
local function pad(p,l,t,r,b)
    local u=Instance.new("UIPadding"); u.PaddingLeft=UDim.new(0,l or 0); u.PaddingTop=UDim.new(0,t or 0)
    u.PaddingRight=UDim.new(0,r or 0); u.PaddingBottom=UDim.new(0,b or 0); u.Parent=p; return u
end
local function L(p,t,sz,col)
    local x = Instance.new("TextLabel")
    x.BackgroundTransparency = 1
    x.Text = t or ""
    x.TextColor3 = col or C.text
    x.Font = Enum.Font.GothamMedium
    x.TextSize = sz or 12
    x.TextXAlignment = Enum.TextXAlignment.Left
    x.TextYAlignment = Enum.TextYAlignment.Center
    x.TextTruncate = Enum.TextTruncate.AtEnd
    x.Parent = p
    return x
end
local function glassTile(p,trans)
    local f = Instance.new("Frame")
    f.BackgroundColor3 = C.glassTile
    f.BackgroundTransparency = trans or G.tileTransparency
    f.BorderSizePixel = 0
    f.ClipsDescendants = true
    f.Parent = p
    corner(f, G.radiusTile)
    stroke(f, C.stroke, 1.3, 0.28)
    -- luminous top sheen
    local sheen = Instance.new("Frame")
    sheen.Name = "JamunSheen"
    sheen.Size = UDim2.new(1, 0, 0.5, 0)
    sheen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sheen.BackgroundTransparency = 0.92
    sheen.BorderSizePixel = 0
    sheen.ZIndex = 1
    sheen.Parent = f
    corner(sheen, G.radiusTile)
    local sg = Instance.new("UIGradient")
    sg.Rotation = 95
    sg.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1, C.accent),
    }
    sg.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.25),
        NumberSequenceKeypoint.new(0.55, 0.75),
        NumberSequenceKeypoint.new(1, 1),
    }
    sg.Parent = sheen
    -- hairline highlight
    local edge = Instance.new("Frame")
    edge.Name = "JamunEdge"
    edge.Size = UDim2.new(1, -4, 0, 1)
    edge.Position = UDim2.fromOffset(2, 1)
    edge.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    edge.BackgroundTransparency = 0.88
    edge.BorderSizePixel = 0
    edge.ZIndex = 2
    edge.Parent = f
    return f
end
local function BTN(p,t,accent)
    local b = Instance.new("TextButton")
    b.Name = "JamunBtn"
    b.AutoButtonColor = false
    b.BackgroundColor3 = accent and C.accent or C.glassInput
    b.BackgroundTransparency = accent and G.accentTransparency or G.inputTransparency
    b.BorderSizePixel = 0
    b.Text = t or ""
    b.TextColor3 = accent and Color3.fromRGB(8,8,12) or C.text
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 12
    b.Parent = p
    corner(b, G.radiusInput)
    stroke(b, accent and C.accent or C.stroke, 1.1, accent and 0.25 or 0.42)
    return b
end
local function B(p,ph)
    local b=Instance.new("TextBox"); b.BackgroundColor3=C.glassInput; b.BackgroundTransparency=G.inputTransparency
    b.PlaceholderText=ph; b.Text=""; b.TextColor3=C.text; b.PlaceholderColor3=C.text3
    b.Font=Enum.Font.GothamMedium; b.TextSize=11; b.BorderSizePixel=0; b.ClearTextOnFocus=false
    b.TextXAlignment=Enum.TextXAlignment.Left; b.Parent=p
    corner(b,G.radiusInput); stroke(b,C.stroke,1,G.rowTransparency); pad(b,10,0,10,0); return b
end
local function hov(b)
    if not b then return end
    b.MouseEnter:Connect(function()
        if b.BackgroundColor3 == C.accent then return end
        TW:Create(b, TweenInfo.new(0.12), {BackgroundTransparency = math.max(0, (b.BackgroundTransparency or 0.2) - 0.08)}):Play()
        local st = b:FindFirstChildOfClass("UIStroke")
        if st then TW:Create(st, TweenInfo.new(0.12), {Transparency = 0.25}):Play() end
    end)
    b.MouseLeave:Connect(function()
        if b.BackgroundColor3 == C.accent then return end
        TW:Create(b, TweenInfo.new(0.12), {BackgroundTransparency = G.inputTransparency}):Play()
        local st = b:FindFirstChildOfClass("UIStroke")
        if st then TW:Create(st, TweenInfo.new(0.12), {Transparency = 0.45}):Play() end
    end)
end
local function setToggle(b,on)
    if not b then return end
    if on then
        TW:Create(b, TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            BackgroundColor3 = C.accent,
            BackgroundTransparency = 0.06,
            TextColor3 = Color3.fromRGB(8, 8, 12),
        }):Play()
        local st = b:FindFirstChildOfClass("UIStroke")
        if st then
            TW:Create(st, TweenInfo.new(0.16), {Color = C.accent, Transparency = 0.2}):Play()
        end
    else
        TW:Create(b, TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            BackgroundColor3 = C.glassInput,
            BackgroundTransparency = G.inputTransparency,
            TextColor3 = C.text2,
        }):Play()
        local st = b:FindFirstChildOfClass("UIStroke")
        if st then
            TW:Create(st, TweenInfo.new(0.16), {Color = C.stroke, Transparency = 0.45}):Play()
        end
    end
    pcall(function()
        local font = C.font or Enum.Font.GothamMedium
        b.Font = font
        if C.fontFace then b.FontFace = C.fontFace end
    end)
end
local function onClick(b,fn)
    local last=0
    local function fire()
        local now=tick()
        if now-last < 0.12 then return end
        last = now
        if fn then pcall(fn) end
    end
    -- Activated is reliable on mobile (single tap); MouseButton1Click alone often needs 2 taps
    if b:IsA("GuiButton") then
        b.Active = true
        b.Activated:Connect(fire)
    else
        b.MouseButton1Click:Connect(fire)
    end
end

-- ============================================================================
-- SOUND
-- ============================================================================
local function mkSnd(v,p) local s=Instance.new("Sound"); s.SoundId=SID; s.Volume=v; s.PlaybackSpeed=p; s.Parent=SS; return s end
local SND = {
    hover=mkSnd(.06,1.4), click=mkSnd(.12,1.8), on=mkSnd(.16,2.2), off=mkSnd(.14,.9),
    success=mkSnd(.2,2.6), error=mkSnd(.16,.6), tab=mkSnd(.1,1.6), open=mkSnd(.14,1.3),
    close=mkSnd(.14,.8), load=mkSnd(.08,1.1),
}
local function play(s) if s and not s.IsPlaying then s:Play() end end

-- ============================================================================
-- PLAYER LOOKUP
-- ============================================================================
local function getPlayer(query, speaker)
    query=tostring(query or ""); if query=="" then return {} end
    local out={}
    for _,p in ipairs(P:GetPlayers()) do if string.lower(p.Name)==string.lower(query) then table.insert(out,p.Name) end end
    if #out==0 then for _,p in ipairs(P:GetPlayers()) do if string.lower(p.Name):sub(1,#query)==string.lower(query) then table.insert(out,p.Name) end end end
    if #out==0 then for _,p in ipairs(P:GetPlayers()) do if string.lower(p.Name):find(string.lower(query),1,true) then table.insert(out,p.Name) end end end
    if #out==0 then for _,p in ipairs(P:GetPlayers()) do if string.lower(p.DisplayName)==string.lower(query) then table.insert(out,p.Name) end end end
    if #out==0 and query:lower()=="me" and speaker then table.insert(out, speaker.Name) end
    if #out==0 and query:lower()=="all" then for _,p in ipairs(P:GetPlayers()) do if p~=speaker then table.insert(out,p.Name) end end end
    return out
end
local function r15(player)
    local c=player and player.Character; if not c then return false end
    local h=c:FindFirstChildOfClass("Humanoid")
    return h and h.RigType==Enum.HumanoidRigType.R15 or false
end

-- ============================================================================
-- ANIMATE-KILL
-- ============================================================================
local AnimateWasDisabled = false

local function stopDefaultTracks(c)
    local hum = c and c:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if animator then
        local ok, tracks = pcall(function() return animator:GetPlayingAnimationTracks() end)
        if ok and tracks then
            for _, t in ipairs(tracks) do
                pcall(function() t:Stop(0) end)
                pcall(function() t:Destroy() end)
            end
        end
    end
    local ok2, tracks2 = pcall(function() return hum:GetPlayingAnimationTracks() end)
    if ok2 and tracks2 then
        for _, t in ipairs(tracks2) do
            pcall(function() t:Stop(0) end)
            pcall(function() t:Destroy() end)
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

-- ============================================================================
-- ANIMATION LOADER
-- ============================================================================
local ANIM_VERIFY_TIME = 0.15
local ANIM_MAX_ATTEMPTS = 2

local function forcePhysicsState(hum)
    if not hum then return end
    pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Physics, true) end)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Physics) end)
end

local function tryPlayOnce(Animator, animId, hum, skipPhysics, priority)
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. tostring(animId)

    local okLoad, track = pcall(function() return Animator:LoadAnimation(anim) end)
    if not okLoad or not track then
        anim:Destroy()
        return nil, nil, false
    end

    local pri = priority or Enum.AnimationPriority.Action4
    pcall(function() track.Priority = pri end)
    pcall(function() track.Looped = true end)
    pcall(function() track:AdjustSpeed(1) end)
    if not skipPhysics then forcePhysicsState(hum) end

    local okPlay = pcall(function() track:Play(0.1) end)
    if not okPlay then
        pcall(function() track:Stop(0) end)
        pcall(function() track:Destroy() end)
        return nil, nil, false
    end

    local started = tick()
    while tick() - started < ANIM_VERIFY_TIME do
        local isPlaying = false
        pcall(function() isPlaying = track.IsPlaying end)
        if isPlaying then return track, anim, true end
        task.wait(0.02)
    end

    if hum then
        local ok2, track2 = pcall(function() return hum:LoadAnimation(anim) end)
        if ok2 and track2 then
            pcall(function() track2.Priority = pri end)
            pcall(function() track2.Looped = true end)
            pcall(function() track2:Play(0.1) end)
            local s2 = tick()
            while tick() - s2 < 0.15 do
                local ip = false
                pcall(function() ip = track2.IsPlaying end)
                if ip then
                    pcall(function() track:Stop(0) end)
                    pcall(function() track:Destroy() end)
                    return track2, anim, true
                end
                task.wait(0.02)
            end
            pcall(function() track2:Stop(0) end)
            pcall(function() track2:Destroy() end)
        end
    end

    pcall(function() track:Stop(0) end)
    pcall(function() track:Destroy() end)
    return nil, nil, false
end

local function loadPlayableAnim(Animator, animId, fallbacks, hum, skipPhysics, priority)
    if not Animator or not animId then return nil, nil end
    local cands = { animId }
    for _, f in ipairs(fallbacks or {}) do table.insert(cands, f) end
    for _, id in ipairs(cands) do
        for attempt = 1, ANIM_MAX_ATTEMPTS do
            local track, anim, ok = tryPlayOnce(Animator, id, hum, skipPhysics, priority)
            if ok then return track, anim end
            if anim then pcall(function() anim:Destroy() end) end
            if attempt < ANIM_MAX_ATTEMPTS then task.wait(0.04) end
        end
    end
    return nil, nil
end

-- ============================================================================
-- WELD DRIVER
-- ============================================================================
local CurrentWeld = nil
local OriginalFPDH = WS.FallenPartsDestroyHeight
local sethiddenproperty = sethiddenproperty or set_hidden_property or set_hidden_prop

local WeldIntent = { active=false, presetKey=nil, target=nil }
local StopGeneration = 0
_G.__jamunAutoReweld = nil

-- live Y offsets (Settings sliders write here; weld loop reads every frame)
local WeldOffsetY = {
    facebang=0, backshots=0, headsit=0, kiss=0, backpack=0,
    headpat=0, propose=0, lawl=0, hug=0, chootlelo=0,
}

local function intentStillValid(myGen)
    return WeldIntent.active and StopGeneration==myGen and WeldIntent.presetKey~=nil
end

local function getWeldTargetAlive()
    if not WeldIntent.active or not WeldIntent.target then return false end
    local tgtPlr = nil
    if typeof(WeldIntent.target)=="Instance" and WeldIntent.target:IsA("Player") then
        tgtPlr = WeldIntent.target
    elseif WeldIntent.target ~= nil then
        tgtPlr = P:FindFirstChild(tostring(WeldIntent.target))
    end
    if not tgtPlr then return false end
    local tc = tgtPlr.Character
    if not tc then return false end
    local th = tc:FindFirstChildOfClass("Humanoid")
    local thrp = tc:FindFirstChild("HumanoidRootPart")
    if th and thrp and th.Health > 0 then return true end
    return false
end

local function WeldTo(TargetPart, Offset, Speaker, AnimationId, Osc, AnimFallbacks)
    local Character=Speaker.Character; if not Character then return nil end
    local Root=Character:FindFirstChild("HumanoidRootPart")
    local Humanoid=Character:FindFirstChildWhichIsA("Humanoid")
    if not Root or not Humanoid then return nil end

    pcall(function() Humanoid.PlatformStand=true end)
    pcall(function() Humanoid.AutoRotate=false end)
    forcePhysicsState(Humanoid)

    killAnimate(Character)
    task.wait(0.06)

    local AnimTrack, AnimInstance = nil, nil
    local animAttempts = 0

    local function ensureAnim(force)
        if not AnimationId then return end
        if AnimTrack and not force then
            local ip=false; pcall(function() ip=AnimTrack.IsPlaying end)
            if ip then return end
        end
        animAttempts += 1
        if not force and animAttempts % 12 ~= 0 and AnimTrack then return end

        local Animator=Character:FindFirstChildWhichIsA("Animator", true)
        if not Animator and Humanoid then Animator=Instance.new("Animator"); Animator.Parent=Humanoid end
        if not Animator then return end

        if AnimInstance and AnimInstance.Parent~=nil then
            local ok,track=pcall(function() return Animator:LoadAnimation(AnimInstance) end)
            if ok and track then
                pcall(function() track.Priority=Enum.AnimationPriority.Action4 end)
                pcall(function() track.Looped=true end)
                forcePhysicsState(Humanoid)
                pcall(function() track:Play(0.1) end)
                local started = tick()
                while tick() - started < ANIM_VERIFY_TIME do
                    local ip=false; pcall(function() ip=track.IsPlaying end)
                    if ip then AnimTrack=track; return end
                    task.wait(0.02)
                end
                pcall(function() track:Stop(0) end); pcall(function() track:Destroy() end)
            end
        end
        local track,anim = loadPlayableAnim(Animator, AnimationId, AnimFallbacks, Humanoid)
        if track then AnimTrack=track; AnimInstance=anim end
    end
    ensureAnim(true)

    for _,v in pairs(Character:GetDescendants()) do
        if v:IsA("BasePart") then v.CanCollide=false; v.Massless=true end
    end
    local Weld={}; local Conn=nil; local clock=0

    Conn = RS.Heartbeat:Connect(function(dt)
        if not Character.Parent then if Weld.Destroy then Weld:Destroy() end return end
        if Character ~= LP.Character then
            if Weld.Destroy then Weld:Destroy() end
            return
        end
        if not TargetPart.Parent then return end

        local animate = Character:FindFirstChild("Animate")
        if animate and not animate.Disabled then
            animate.Disabled = true
            AnimateWasDisabled = true
        end

        clock = clock + dt
        -- live Y offset from Settings (works mid-weld)
        local dy = 0
        if WeldIntent.presetKey and WeldOffsetY[WeldIntent.presetKey] then
            dy = WeldOffsetY[WeldIntent.presetKey] or 0
        end
        local baseOff = Offset
        if dy ~= 0 then
            baseOff = CFrame.new(0, dy, 0) * Offset
        end
        local localOffset = baseOff
        if Osc and Osc.period and Osc.period>0 then
            local phase=(math.sin(clock*(2*math.pi)/Osc.period)+1)*0.5
            localOffset = baseOff * CFrame.new(0,0,-Osc.distance*phase)
        end
        Root.CFrame = TargetPart.CFrame * localOffset
        Root.AssemblyLinearVelocity = Vector3.zero
        Root.AssemblyAngularVelocity = Vector3.zero
        if sethiddenproperty then pcall(function()
            sethiddenproperty(Root,"PhysicsRepRootPart",TargetPart)
            sethiddenproperty(Root,"PhysicsRepRootRef",InstanceHandle.new(TargetPart))
        end) end
        pcall(function() ensureAnim(false) end)
        pcall(function() if not Humanoid.PlatformStand then Humanoid.PlatformStand=true end end)
    end)
    function Weld:Destroy()
        if Conn then Conn:Disconnect(); Conn=nil end
        if AnimTrack then pcall(function() AnimTrack:Stop(0.3) end); AnimTrack=nil end
        if Root then Root.AssemblyLinearVelocity=Vector3.zero; Root.AssemblyAngularVelocity=Vector3.zero end
        local c = Speaker.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then
                pcall(function() h.PlatformStand=false end)
                pcall(function() h.AutoRotate=true end)
            end
        end
        restoreAnimate(c or LP.Character)
    end
    return Weld
end

local function unweld()
    if CurrentWeld then pcall(function() CurrentWeld:Destroy() end); CurrentWeld=nil end
    if AnimateWasDisabled and LP.Character then
        pcall(function() restoreAnimate(LP.Character) end)
    end
    pcall(function() WS.FallenPartsDestroyHeight = OriginalFPDH end)
end

-- ============================================================================
-- TARGET RESOLVER
-- ============================================================================
local function pickTargetRef(tchar, mode)
    if not tchar then return nil end
    return tchar:FindFirstChild("HumanoidRootPart")
end

local function resolvePlayer(target, speaker)
    if typeof(target)=="Instance" and target:IsA("Player") then
        if target.Parent==P and target~=speaker then return target end; return nil
    end
    local results=getPlayer(tostring(target or ""), speaker)
    for _,v in ipairs(results) do local cand=P:FindFirstChild(v); if cand and cand~=speaker then return cand end end
    return nil
end

local function weldToTarget(target, speaker, offset, animId, osc, refMode, animFallbacks, callerGen)
    local TPlayer=resolvePlayer(target, speaker); if not TPlayer then return false,nil end
    local char=TPlayer.Character; if not char then return false,TPlayer end
    local TRoot=pickTargetRef(char, refMode or "torso"); if not TRoot then return false,TPlayer end
    task.spawn(function()
        pcall(function() WS.FallenPartsDestroyHeight = 0/0 end)
        local w = WeldTo(TRoot, offset, speaker, animId, osc, animFallbacks)
        if callerGen and callerGen ~= StopGeneration then
            if w then pcall(function() w:Destroy() end) end
            return
        end
        local old = CurrentWeld
        CurrentWeld = w
        if old and old ~= w then pcall(function() old:Destroy() end) end
    end)
    return true, TPlayer
end

-- ============================================================================
-- ANTI VOID / ANTI KILL / ANTI GAMEPLAY PAUSED / ANTI AFK
-- ============================================================================
local avOn, avCharAddedConn, avCharConns, avHealthConns = false, nil, {}, {}
local function avForceAlive(h)
    if not h or not h.Parent then return end
    pcall(function()
        if h.MaxHealth<=0 then h.MaxHealth=100 end
        if h.Health<h.MaxHealth then h.Health=h.MaxHealth end
        if h.PlatformStand then h.PlatformStand=false end
        if h.Sit then h.Sit=false end
    end)
end
local function avHookHumanoid(h)
    if not h or not h.Parent then return end
    pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Dead,false) end)
    pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false) end)
    pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false) end)
    table.insert(avHealthConns, h.HealthChanged:Connect(function(hp) if avOn and hp<h.MaxHealth then task.defer(function() avForceAlive(h) end) end end))
    table.insert(avHealthConns, h.Died:Connect(function() if avOn then task.wait(0.02); avForceAlive(h) end end))
end
local function avHookChar(c)
    if not c then return end; avCharConns={}; avHealthConns={}
    local hum=c:FindFirstChildOfClass("Humanoid"); if hum then avHookHumanoid(hum) end
    table.insert(avCharConns, c.ChildAdded:Connect(function(ch) if ch:IsA("Humanoid") then avHookHumanoid(ch) end end))
end
local function avUnhookChar()
    for _,c in ipairs(avCharConns) do pcall(function() c:Disconnect() end) end
    for _,c in ipairs(avHealthConns) do pcall(function() c:Disconnect() end) end
    avCharConns={}; avHealthConns={}
end
local function avStart()
    if avOn then return end; avOn=true
    pcall(function() WS.FallenPartsDestroyHeight = -math.huge end)
    avHookChar(LP.Character)
    avCharAddedConn = LP.CharacterAdded:Connect(function(c)
        if not avOn then return end; task.wait(0.3); avUnhookChar(); avHookChar(c)
        pcall(function() WS.FallenPartsDestroyHeight = -math.huge end)
    end)
end
local function avStop()
    if not avOn then return end; avOn=false
    if avCharAddedConn then avCharAddedConn:Disconnect(); avCharAddedConn=nil end
    avUnhookChar()
end

local akOn, akCharConn = false, nil
local function akApply(char)
    if not char then return end
    for _,p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then
            if p.CanTouch then p.CanTouch=false end
            if p.CanQuery then p.CanQuery=false end
            if not p.CanCollide then p.CanCollide=true end
        end
    end
end
local function akStart()
    if akOn then return end; akOn=true
    pcall(function() WS.FallenPartsDestroyHeight = -math.huge end)
    akApply(LP.Character)
    if akCharConn then akCharConn:Disconnect() end
    akCharConn = LP.CharacterAdded:Connect(function(c) if not akOn then return end; task.wait(0.4); akApply(c) end)
end
local function akStop()
    if not akOn then return end; akOn=false
    if akCharConn then akCharConn:Disconnect(); akCharConn=nil end
end

local agpOn = false
local networkPaused
local function agpKill()
    local COREGUI = game:GetService("CoreGui")
    pcall(function() if networkPaused then networkPaused:Disconnect() end end)
    pcall(function()
        networkPaused = COREGUI.RobloxGui.ChildAdded:Connect(function(obj)
            if agpOn and obj.Name=="CoreScripts/NetworkPause" then
                pcall(function() obj:Destroy() end)
            end
        end)
    end)
    pcall(function()
        if agpOn and COREGUI.RobloxGui:FindFirstChild("CoreScripts/NetworkPause") then
            COREGUI.RobloxGui["CoreScripts/NetworkPause"]:Destroy()
        end
    end)
end
local function agpStart()
    if agpOn then return end
    agpOn = true
    agpKill()
end
local function agpStop()
    if not agpOn then return end
    agpOn = false
    pcall(function() if networkPaused then networkPaused:Disconnect() end end)
    networkPaused = nil
end

local aafkStart, aafkStop, asStart, asStop
local aafkOn, asOn = false, false
;(function()
local antiAfkCon
aafkStart = function()
    if aafkOn then return end
    aafkOn = true
    pcall(function()
        if getconnections then
            for _,c in getconnections(LP.Idled) do
                pcall(function() c:Disable() end)
                pcall(function() c:Disconnect() end)
            end
        end
        if antiAfkCon then pcall(function() antiAfkCon:Disconnect() end) end
        antiAfkCon = LP.Idled:Connect(function()
            if not aafkOn then return end
            local VIM=Instance.new("VirtualInputManager")
            VIM:SendMouseButtonEvent(0,0,0,true,game,0)
            VIM:SendMouseButtonEvent(0,0,0,false,game,0)
            VIM:Destroy()
        end)
    end)
end
aafkStop = function()
    if not aafkOn then return end
    aafkOn = false
    if antiAfkCon then pcall(function() antiAfkCon:Disconnect() end); antiAfkCon=nil end
end

-- Anti Sit
local asCharConn, asHbConn
local function asApply(char)
    if not char then return end
    local h = char:FindFirstChildOfClass("Humanoid")
    if not h then return end
    pcall(function()
        if h.Sit then h.Sit = false end
        if h.SeatPart then
            local sp = h.SeatPart
            for _, j in ipairs(sp:GetChildren()) do
                if j:IsA("Weld") or j.Name == "SeatWeld" then pcall(function() j:Destroy() end) end
            end
        end
        h:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        local st = h:GetState()
        if st == Enum.HumanoidStateType.Seated then
            h:ChangeState(Enum.HumanoidStateType.GettingUp)
            h:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end
asStart = function()
    if asOn then return end
    asOn = true
    asApply(LP.Character)
    if asCharConn then pcall(function() asCharConn:Disconnect() end) end
    asCharConn = LP.CharacterAdded:Connect(function(c)
        if not asOn then return end
        task.wait(0.25)
        asApply(c)
    end)
    if asHbConn then pcall(function() asHbConn:Disconnect() end) end
    asHbConn = RS.Heartbeat:Connect(function()
        if not asOn then return end
        local c = LP.Character
        if not c then return end
        local h = c:FindFirstChildOfClass("Humanoid")
        if h and (h.Sit or h.SeatPart) then asApply(c) end
    end)
end
asStop = function()
    if not asOn then return end
    asOn = false
    if asCharConn then pcall(function() asCharConn:Disconnect() end); asCharConn=nil end
    if asHbConn then pcall(function() asHbConn:Disconnect() end); asHbConn=nil end
    local c = LP.Character
    local h = c and c:FindFirstChildOfClass("Humanoid")
    if h then pcall(function() h:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end) end
end
end)()

-- expose for Anti UI
_G.__jamunAnti = {
    voidStart = function()
        _G.__jamunAntiVoid = true
        avStart()
    end,
    voidStop = function()
        _G.__jamunAntiVoid = false
        avStop()
    end,
    voidOn = function() return avOn == true end,
    killStart = akStart,
    killStop = akStop,
    killOn = function() return akOn end,
    gpStart = agpStart,
    gpStop = agpStop,
    gpOn = function() return agpOn end,
    afkStart = aafkStart,
    afkStop = aafkStop,
    afkOn = function() return aafkOn end,
    sitStart = asStart,
    sitStop = asStop,
    sitOn = function() return asOn end,
}

-- ============================================================================
-- FPS + PING
-- ============================================================================
local fps_val, ping_val = 60, 0
local fps_acc, fps_frames = 0, 0
registerUIPoller(function() pcall(function() ping_val = math.floor(LP:GetNetworkPing()*1000+0.5) end) end)

-- ============================================================================
-- HOTKEYS
-- ============================================================================
local HOTKEYS = {}
local function keyName(k)
    if not k then return "—" end
    local n = k.Name; if #n==1 then return n end
    return (n:gsub("KeyCode%.",""):gsub("MouseButton","M"))
end
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    for _,h in pairs(HOTKEYS) do if h.key and input.KeyCode==h.key and h.fn then pcall(h.fn) end end
end)

-- ============================================================================
-- STATE
-- ============================================================================
local sel, selId, selName = nil, nil, nil
local selDisplay = nil
local tgtJoinState = nil
local wsOn=false; local wsVal=16
local DEFAULT_WALKSPEED = 16
local activeWeldMode = "facebang"
local lastSafeCF = nil
local csOn=false; local csMode="roast"; local csTgt=""; local csMsg=""; local csSym="AT"; local csEmoji="RANDOM"; local csIdx=1; local csCnt=0; local csMtd="-"
local csCh=nil; local csLg=nil; local csGen=0
local panelSizeUser = nil

-- ============================================================================
-- WELD PRESETS
-- ============================================================================
local WELD_PRESETS = {
    facebang  = { offset=CFrame.new(0,2.5,-3.8)*CFrame.Angles(0,math.rad(180),0),
                  anim15=85194549268064, anim6=85194549268064, animFallbacks={4555808220, 109168916859109},
                  osc={distance=2.9, period=0.22}, refMode="head" },
    backshots = { offset=CFrame.new(0,0,3.2),
                  anim15=85194549268064, anim6=85194549268064, animFallbacks={4555808220, 109168916859109},
                  osc={distance=2.9, period=0.22}, refMode="torso" },
    headsit   = { offset=CFrame.new(0,3,0), anim15=2506281703, anim6=2506281703, animFallbacks={2510238627,507768375,180426354}, osc=nil, refMode="head" },
    kiss      = { offset=CFrame.new(0,0,-1.1)*CFrame.Angles(0,math.rad(180),0), anim15=81124524945738, anim6=81124524945738, animFallbacks={3576686446,3019619673,15849372443}, osc=nil, refMode="torso" },
    backpack  = { offset=CFrame.new(0,0,1.05)*CFrame.Angles(0,math.rad(180),0), anim15=2506281703, anim6=2506281703, animFallbacks={2510238627,507768375,180426354}, osc=nil, refMode="torso" },
    headpat   = { offset=CFrame.new(0,0,-1.9)*CFrame.Angles(0,math.rad(180),0),
                  anim15=114313599861536, anim6=114313599861536, animFallbacks={},
                  osc=nil, refMode="head" },
    propose   = { offset=CFrame.new(0,0,-3.5)*CFrame.Angles(0,math.rad(180),0),
                  anim15=107416091886634, anim6=107416091886634, animFallbacks={132376545587908, 70639053125611},
                  osc=nil, refMode="torso" },
    lawl      = { offset=CFrame.new(0,0,-3.2)*CFrame.Angles(0,math.rad(180),0),
                  anim15=98316145061745, anim6=98316145061745, animFallbacks={},
                  osc=nil, refMode="torso" },
    hug       = { offset=CFrame.new(0,0,-1.4)*CFrame.Angles(0,math.rad(180),0),
                  anim15=95247520541805, anim6=95247520541805, animFallbacks={},
                  osc=nil, refMode="torso" },
    chootlelo = { offset=CFrame.new(0,0,-1.6),
                  anim15=81480655904728, anim6=81480655904728, animFallbacks={},
                  osc=nil, refMode="torso" },
}

local function resolvePresetOffset(presetKey, preset)
    local base = preset.offset
    local dy = WeldOffsetY[presetKey] or 0
    if not dy or dy == 0 then return base end
    return CFrame.new(0, dy, 0) * base
end

-- ============================================================================
-- APPLY / SWITCH / STOP
-- ============================================================================
local function applyWeldPreset(presetKey, target, callerGen)
    local preset = WELD_PRESETS[presetKey]; if not preset then return false end
    if callerGen and callerGen ~= StopGeneration then return false end
    local myGen = StopGeneration
    local anim = r15(LP) and preset.anim15 or preset.anim6
    -- pass base offset only; Y from WeldOffsetY is applied live each frame in WeldTo
    local ok, tplayer = weldToTarget(target, LP, preset.offset, anim, preset.osc, preset.refMode, preset.animFallbacks, myGen)
    if ok then
        if callerGen and callerGen ~= StopGeneration then pcall(function() unweld() end); return false end
        activeWeldMode = presetKey; WeldIntent.active = true; WeldIntent.presetKey = presetKey; WeldIntent.target = tplayer or target
        avStart(); akStart(); return true
    end
    return false
end

local function switchWeld(presetKey, target) return applyWeldPreset(presetKey, target) end

local function stopWeld()
    StopGeneration = StopGeneration + 1
    WeldIntent.active = false; WeldIntent.presetKey = nil; WeldIntent.target = nil
    unweld(); avStop(); akStop()
    pcall(function() WS.FallenPartsDestroyHeight = OriginalFPDH end)
    local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if h then
        if h.PlatformStand then h.PlatformStand=false end
        if h.Sit then h.Sit=false end
        pcall(function() h:ChangeState(Enum.HumanoidStateType.Running) end)
    end
    local killedGen = StopGeneration
    task.defer(function()
        if StopGeneration == killedGen and not WeldIntent.active and CurrentWeld then
            pcall(function() CurrentWeld:Destroy() end); CurrentWeld = nil
        end
    end)
end


-- ============================================================================
-- CLICK TARGET TOOL (equip in inventory · click player to weld · unequip to stop)
-- ============================================================================
local ClickToolPreset = "facebang"
local ClickToolInstance = nil
local ClickToolOwnedByUs = false
local CLICK_TOOL_NAME = "Jamun Click Weld"

local CLICK_PRESET_ORDER = {
    "facebang","backshots","headsit","kiss","backpack",
    "headpat","propose","lawl","hug","chootlelo",
}
local CLICK_PRESET_LABEL = {
    facebang="Face Bang", backshots="Backshots", headsit="Headsit",
    kiss="Kiss", backpack="Backpack", headpat="Headpat",
    propose="Propose", lawl="Lawl", hug="Hug", chootlelo="Choot Lelo",
}

local function playerFromPart(part)
    if not part then return nil end
    local cur = part
    while cur and cur ~= workspace do
        local plr = P:GetPlayerFromCharacter(cur)
        if plr then return plr end
        cur = cur.Parent
    end
    return nil
end

local function destroyClickTool()
    if ClickToolInstance then
        pcall(function() ClickToolInstance:Destroy() end)
        ClickToolInstance = nil
    end
    -- also clear strays with same name
    for _, bag in ipairs({ LP:FindFirstChild("Backpack"), LP.Character }) do
        if bag then
            local t = bag:FindFirstChild(CLICK_TOOL_NAME)
            if t then pcall(function() t:Destroy() end) end
        end
    end
end

local function wireClickTool(tool)
    ClickToolInstance = tool
    tool.RequiresHandle = false
    tool.CanBeDropped = false
    tool.ManualActivationOnly = false

    -- keep walk/run alive: never disable Animate (that causes the slide)
    local suppressConn = nil
    tool.Equipped:Connect(function()
        local char = LP.Character
        if not char then return end

        pcall(function()
            local animate = char:FindFirstChild("Animate")
            if animate then
                for _, folderName in ipairs({"toolnone", "toolslash", "toollunge", "tooljab"}) do
                    local folder = animate:FindFirstChild(folderName)
                    if folder then
                        for _, child in ipairs(folder:GetDescendants()) do
                            if child:IsA("Animation") then
                                child:SetAttribute("JamunPrevAnimId", child.AnimationId)
                                child.AnimationId = ""
                            end
                        end
                    end
                end
            end
        end)

        if suppressConn then pcall(function() suppressConn:Disconnect() end) end
        suppressConn = RS.Heartbeat:Connect(function()
            if not tool.Parent or tool.Parent ~= LP.Character then return end
            local c = LP.Character
            if not c then return end
            local hum = c:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local animator = hum:FindFirstChildOfClass("Animator")
            if not animator then return end
            pcall(function()
                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                    local n = string.lower(track.Name or "")
                    if n:find("tool", 1, true) then
                        track:Stop(0)
                    end
                end
            end)
        end)
    end)

    tool.Unequipped:Connect(function()
        if suppressConn then pcall(function() suppressConn:Disconnect() end); suppressConn = nil end
        local char = LP.Character
        if char then
            pcall(function()
                local animate = char:FindFirstChild("Animate")
                if animate then
                    for _, child in ipairs(animate:GetDescendants()) do
                        if child:IsA("Animation") then
                            local prev = child:GetAttribute("JamunPrevAnimId")
                            if prev and prev ~= "" then
                                child.AnimationId = prev
                                child:SetAttribute("JamunPrevAnimId", nil)
                            end
                        end
                    end
                end
            end)
        end
        -- unequip = stop weld
        pcall(stopWeld)
        _G.__jamunAutoReweld = nil
    end)

    tool.Activated:Connect(function()
        if not tool.Parent or tool.Parent ~= LP.Character then return end
        local mouse = LP:GetMouse()
        local targetPart = mouse and mouse.Target
        local hitPlr = playerFromPart(targetPart)
        if not hitPlr then
            -- fallback ray from camera
            local cam = workspace.CurrentCamera
            if cam and mouse then
                local unit = mouse.UnitRay
                local params = RaycastParams.new()
                params.FilterType = Enum.RaycastFilterType.Exclude
                params.FilterDescendantsInstances = { LP.Character }
                local hit = workspace:Raycast(unit.Origin, unit.Direction * 500, params)
                if hit then hitPlr = playerFromPart(hit.Instance) end
            end
        end
        if not hitPlr or hitPlr == LP then return end
        local preset = ClickToolPreset
        if not WELD_PRESETS[preset] then preset = "facebang" end
        local myGen = StopGeneration
        local ok
        if CurrentWeld then
            ok = switchWeld(preset, hitPlr)
        else
            ok = applyWeldPreset(preset, hitPlr, myGen)
        end
        if ok then
            activeWeldMode = preset
        end
    end)
end

local function giveClickTool()
    destroyClickTool()
    local tool = Instance.new("Tool")
    tool.Name = CLICK_TOOL_NAME
    tool.ToolTip = "Click a player to weld · Unequip to stop · Preset: " .. (CLICK_PRESET_LABEL[ClickToolPreset] or ClickToolPreset)
    tool.RequiresHandle = false
    tool.CanBeDropped = false
    tool.TextureId = ""

    -- invisible 0-size grip so nothing shows in hand
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.05, 0.05, 0.05)
    handle.Transparency = 1
    handle.CanCollide = false
    handle.Massless = true
    handle.Anchored = false
    handle.Parent = tool

    wireClickTool(tool)

    local bag = LP:FindFirstChild("Backpack") or LP:WaitForChild("Backpack", 5)
    if bag then
        tool.Parent = bag
    else
        tool.Parent = LP
    end
    ClickToolOwnedByUs = true
    return tool
end

_G.__jamunGiveClickTool = giveClickTool
_G.__jamunSetClickToolPreset = function(key)
    if WELD_PRESETS[key] then
        ClickToolPreset = key
        if ClickToolInstance then
            ClickToolInstance.ToolTip = "Click a player to weld · Unequip to stop · Preset: " .. (CLICK_PRESET_LABEL[key] or key)
        end
        return true
    end
    return false
end
_G.__jamunGetClickToolPreset = function() return ClickToolPreset end

-- ============================================================================
-- PROXIMITY WATCHER
-- ============================================================================
local function isTargetOnBaseplate(tplayer)
    if not tplayer or not tplayer.Parent then return false end
    local char=tplayer.Character; if not char then return false end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return false end
    return true
end

task.spawn(function()
    while true do
        task.wait(WeldIntent.active and not CurrentWeld and 0.1 or 0.3)
        if WeldIntent.active and WeldIntent.presetKey then
            local myChar = LP.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if myRoot and not CurrentWeld then
                local target = WeldIntent.target
                if target then
                    local myGen = StopGeneration
                    local tplayer = nil
                    if typeof(target)=="Instance" and target:IsA("Player") then
                        if target.Parent==P then tplayer = target end
                    else
                        local results = getPlayer(tostring(target), LP)
                        for _,n in ipairs(results) do local c=P:FindFirstChild(n); if c then tplayer=c; break end end
                    end
                    if tplayer and tplayer.Character and isTargetOnBaseplate(tplayer) then
                        if intentStillValid(myGen) then
                            local ok = applyWeldPreset(WeldIntent.presetKey, tplayer, myGen)
                            if not ok then
                                task.wait(0.15)
                                if intentStillValid(myGen) and tplayer.Character and not CurrentWeld then
                                    applyWeldPreset(WeldIntent.presetKey, tplayer, myGen)
                                end
                            end
                            if StopGeneration ~= myGen and not WeldIntent.active then pcall(function() unweld() end) end
                        end
                    end
                end
            end
        end
    end
end)

-- ============================================================================
-- MASTER HEARTBEAT
-- ============================================================================
local ACC_SAFETY, ACC_AV, ACC_AK, ACC_AGP = 0,0,0,0
local lastRootPos, lastRootCheckT, flingSnapCooldown = nil, 0, 0
local FLING_VEL_THRESHOLD, FLING_DELTA_THRESHOLD, FLING_CHECK_INTERVAL = 500, 25, 0.05

_G.__jamunAdminBypassUntil = 0
_G.__jamunResetSafety = function(newCF, bypassSeconds)
    local now = tick()
    if typeof(newCF) == "CFrame" then
        lastRootPos = newCF.Position
        lastSafeCF = newCF
    else
        lastRootPos = nil
    end
    lastRootCheckT = now
    local dur = tonumber(bypassSeconds) or 1.2
    flingSnapCooldown = math.max(flingSnapCooldown, now + dur)
    _G.__jamunAdminBypassUntil = math.max(_G.__jamunAdminBypassUntil or 0, now + dur)
end

RS.Heartbeat:Connect(function(dt)
    do
        local c=LP.Character
        local r=c and c:FindFirstChild("HumanoidRootPart")
        local h=c and c:FindFirstChildOfClass("Humanoid")
        if r and h then
            local now=tick()
            if now - lastRootCheckT >= FLING_CHECK_INTERVAL then
                local pos=r.Position
                local velMag=r.AssemblyLinearVelocity.Magnitude
                local deltaMag=lastRootPos and (pos-lastRootPos).Magnitude or 0
                local triggered = velMag>FLING_VEL_THRESHOLD or deltaMag>FLING_DELTA_THRESHOLD
                local animCopyOn = (_G.JamunAnimCopy and _G.JamunAnimCopy.active) == true
                local adminBypass = now < (_G.__jamunAdminBypassUntil or 0)
                -- never fling-snap while welded / intent active / anim copy / admin command
                if triggered and now > flingSnapCooldown and not adminBypass and not animCopyOn and not CurrentWeld and not WeldIntent.active and not getWeldTargetAlive() then
                    flingSnapCooldown = now + 0.4
                    local base=WS:FindFirstChild("Baseplate")
                    local snap = lastSafeCF or (base and CFrame.new(base.Position+Vector3.new(0,6,0))) or CFrame.new(0,100,0)
                    r.CFrame = snap; r.AssemblyLinearVelocity=Vector3.zero; r.AssemblyAngularVelocity=Vector3.zero
                    if h.Health < h.MaxHealth then h.Health = h.MaxHealth end
                    if h.PlatformStand then h.PlatformStand=false end
                    if h.Sit then h.Sit=false end
                end
                lastRootPos = pos; lastRootCheckT = now
            end
        else lastRootPos = nil end
    end

    fps_acc = fps_acc + dt; fps_frames = fps_frames + 1
    if fps_acc >= 1.0 then fps_val = math.floor(fps_frames/fps_acc+0.5); fps_acc, fps_frames = 0, 0 end

    if avOn then ACC_AV = ACC_AV + dt; if ACC_AV >= 0.25 then ACC_AV = 0; pcall(function()
        if _G.__jamunAntiVoid ~= false and WS.FallenPartsDestroyHeight ~= -math.huge then WS.FallenPartsDestroyHeight = -math.huge end
        local c=LP.Character; if not c then return end
        local h=c:FindFirstChildOfClass("Humanoid"); if not h then return end
        if h.Health < h.MaxHealth then h.Health = h.MaxHealth end
    end) end end
    if akOn then ACC_AK = ACC_AK + dt; if ACC_AK >= 0.25 then ACC_AK = 0; pcall(function()
        if _G.__jamunAntiVoid ~= false and WS.FallenPartsDestroyHeight ~= -math.huge then WS.FallenPartsDestroyHeight = -math.huge end
        local c=LP.Character; if not c then return end
        if c.Parent ~= WS then c.Parent = WS end
        for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then
            if p.CanTouch then p.CanTouch=false end
            if p.CanQuery then p.CanQuery=false end
            if not p.CanCollide then p.CanCollide=true end
        end end
    end) end end
    if agpOn then ACC_AGP = ACC_AGP + dt; if ACC_AGP >= 0.25 then ACC_AGP = 0; agpKill() end end

    ACC_SAFETY = ACC_SAFETY + dt; if ACC_SAFETY < 0.1 then return end; ACC_SAFETY = 0
    local c = LP.Character; if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart"); local h = c:FindFirstChildOfClass("Humanoid")
    if not r or not h then return end
    -- jamun weld anti-void (FPDH) stays active via av/ak; this block only recovers when NOT following a weld target
    local followingVoid = CurrentWeld or WeldIntent.active or getWeldTargetAlive()
        or ((_G.JamunAnimCopy and _G.JamunAnimCopy.active) == true)
        or (tick() < (_G.__jamunAdminBypassUntil or 0))
    if followingVoid then
        -- allow secret void / mic-up trails; keep FPDH deep via avStart
        if wsOn and h.WalkSpeed ~= wsVal then h.WalkSpeed = wsVal end
        return
    end
    local inVoid = (r.Position.Y < -350)
    if not inVoid then
        local base = WS:FindFirstChild("Baseplate")
        if base and r.Position.Y < (base.Position.Y - 200) and r.Position.Y < -350 then inVoid = true end
    end
    if inVoid then
        local base = WS:FindFirstChild("Baseplate")
        local snap = lastSafeCF or (base and CFrame.new(base.Position+Vector3.new(0,6,0))) or CFrame.new(0,100,0)
        r.CFrame = snap; r.AssemblyLinearVelocity=Vector3.zero; r.AssemblyAngularVelocity=Vector3.zero
        h.Health = h.MaxHealth
        if h.PlatformStand then h.PlatformStand=false end
        if h.Sit then h.Sit=false end
        return
    end
    if wsOn then if h.WalkSpeed ~= wsVal then h.WalkSpeed = wsVal end
    else if h.WalkSpeed ~= DEFAULT_WALKSPEED then h.WalkSpeed = DEFAULT_WALKSPEED end end
    if h.FloorMaterial ~= Enum.Material.Air then lastSafeCF = r.CFrame end
    local shouldTP = false
    if lastSafeCF and (r.Position-lastSafeCF.Position).Magnitude > 1000 then shouldTP = true end
    if shouldTP then
        local base = WS:FindFirstChild("Baseplate")
        local target = lastSafeCF or (base and CFrame.new(base.Position+Vector3.new(0,6,0))) or CFrame.new(0,100,0)
        r.CFrame = target; r.AssemblyLinearVelocity=Vector3.zero; r.AssemblyAngularVelocity=Vector3.zero
        h.Health = h.MaxHealth
        if h.PlatformStand then h.PlatformStand=false end
        if h.Sit then h.Sit=false end
    end
end)

LP.CharacterAdded:Connect(function(c)
    CH = c; task.wait(0.6)
    if CurrentWeld then pcall(function() CurrentWeld:Destroy() end); CurrentWeld = nil end
    pcall(function()
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then
            if h.PlatformStand then h.PlatformStand=false end
            if h.Sit then h.Sit=false end
            h.WalkSpeed = wsOn and wsVal or DEFAULT_WALKSPEED
        end
    end)
    lastRootPos = nil; lastSafeCF = nil
    if WeldIntent.active and WeldIntent.presetKey and WeldIntent.target then
        local myGen = StopGeneration
        task.defer(function()
            if not intentStillValid(myGen) then return end
            applyWeldPreset(WeldIntent.presetKey, WeldIntent.target, myGen)
        end)
    end
end)

-- ============================================================================
-- CHAT SPAMMER
-- ============================================================================
local CS_D=5; local CS_M=200; local CS_CL=" BETA BOL BUNDBAZZ CLAN ON TOP"; local CS_R=" TMKX MAI "
local CS_W={"NOOB","ROOKIE","AMATEUR","TRAINEE","BEGINNER","SLOWPOKE","SLEEPY","CLUMSY","DORK","NERD","GEEK","DWEEB","SQUISHY","WOBBLY","FUZZY","SPARKLY","GIGGLY","WIGGLY","SNAIL","TURTLE","PANDA","SLOTH","MOOSE","HAMSTER","PUPPY","KITTEN","DUCKLING","PENGUIN","NARWHAL","PLATYPUS","CAPYBARA","ALPACA","RACCOON","SQUIRREL","OTTER","BEAVER","HEDGEHOG","MEERKAT","FERRET","BUNNY","CHIPMUNK","PUFFIN","TOUCAN","FLAMINGO","MANATEE","WALRUS","PELICAN","SEAGULL","PIGEON","SPARROW","ROBIN","FINCH","WREN","MAGPIE","CROW","RAVEN","STARLING","SWALLOW","MARTIN","SWIFT","DOVE","QUAIL","PHEASANT","TURKEY","DUCK","CHICKEN","ROOSTER","PARROT","MACAW","COCKATOO","BUDGIE","CANARY"}
local CS_S={RANDOM={"@","#","$","%","^","&","*","!","?","~","+","=","-","_",".",",",":",";","|","/","\\","<",">","[","]","{","}","(",")"},AT={"@"},HASH={"#"},DOLLAR={"$"},PERCENT={"%"},STAR={"*"},EXCLAMATION={"!"},QUESTION={"?"},DOT={"."},TILDE={"~"},BRACKETS={"[","]","{","}","(",")","<",">"},SPECIAL={"@","#","$","%","&","*","!"},MIXED={"@","#","$","%","&","*","!","?"}}
local CS_K={"RANDOM","AT","HASH","DOLLAR","PERCENT","STAR","EXCLAMATION","QUESTION","DOT","TILDE","BRACKETS","SPECIAL","MIXED"}
local CS_L={RANDOM="Random",AT="@",HASH="#",DOLLAR="$",PERCENT="%",STAR="*",EXCLAMATION="!",QUESTION="?",DOT=".",TILDE="~",BRACKETS="Brackets",SPECIAL="Special",MIXED="Mixed"}
local CS_E={"🔥","😂","💀","🗿","😭","😎","🤡","👻","👀","💯","🚨","😍","⚡","💔","🗣️","🧠","🤖","🥶","😈","🤣","💥","✨","🙏","😱"}
local CS_EMOJI_S={
    NONE={},
    RANDOM=CS_E,
    LAUGH={"😂","🤣","😂"},
    SKULL={"💀","☠️","💀"},
    FIRE={"🔥","🔥","🔥"},
    PARTY={"🎉","✨","🥳","🥳"},
    CRY={"😭","😭","😭"},
    MIXED={"🔥","😂","💀","✨","💯","😎"},
}
local CS_EMOJI_K={"NONE","RANDOM","LAUGH","SKULL","FIRE","PARTY","CRY","MIXED"}
local CS_EMOJI_L={NONE="None",RANDOM="Random",LAUGH="😂 Laugh",SKULL="💀 Skull",FIRE="🔥 Fire",PARTY="🎉 Party",CRY="😭 Cry",MIXED="Mixed"}

local function gC()
    if TC.ChatVersion ~= Enum.ChatVersion.TextChatService then return nil end
    local ok,res=pcall(function()
        local c=TC:FindFirstChild("TextChannels"); if not c then return nil end
        return c:FindFirstChild("RBXGeneral") or c:GetChildren()[1]
    end)
    return ok and res or nil
end
local function gL()
    local ok,res=pcall(function()
        local d=RPS:FindFirstChild("DefaultChatSystemChatEvents")
        if d and d:FindFirstChild("SayMessageRequest") then return d.SayMessageRequest end
    end)
    return ok and res or nil
end
local function snd2(tx)
    if #tx>CS_M then tx=tx:sub(1,CS_M) end
    if TC.ChatVersion==Enum.ChatVersion.TextChatService then
        if not csCh or not csCh.Parent then csCh=gC() end
        if csCh then local ok=pcall(function() csCh:SendAsync(tx) end); if ok then csMtd="TextChat"; return true end end
    end
    if not csLg then csLg=gL() end
    if csLg then local ok=pcall(function() csLg:FireServer(tx,"All") end); if ok then csMtd="Legacy"; return true end end
    return false
end
local function gS()
    local s=CS_S[csSym] or CS_S.RANDOM
    if csSym=="RANDOM" then local x=s[csIdx]; csIdx=csIdx+1; if csIdx>#s then csIdx=1 end; return x end
    return s[math.random(1,#s)]
end
-- build a symbol block of exact length. single-char sets rep one char;
-- multi-char sets (RANDOM/MIXED/BRACKETS/SPECIAL) mix so filter is less likely to strip the run
local function buildSymBlock(n)
    if n <= 0 then return "" end
    local set = CS_S[csSym] or CS_S.RANDOM
    if #set == 1 then
        return set[1]:rep(n)
    end
    -- RANDOM advances the cycle index so successive messages keep walking the set
    if csSym == "RANDOM" then
        local out = table.create(n)
        for i = 1, n do
            out[i] = gS()
        end
        return table.concat(out)
    end
    local out = table.create(n)
    for i = 1, n do
        out[i] = set[math.random(1, #set)]
    end
    return table.concat(out)
end
local function resolveTargetDisplay()
    if sel then
        local ok,dn=pcall(function() return sel.DisplayName end); if ok and dn and dn~="" then return dn end
        local ok2,nm=pcall(function() return sel.Name end); if ok2 and nm and nm~="" then return nm end
    end
    if selDisplay and selDisplay~="" then return selDisplay end
    if selName and selName~="" then return selName end
    if csTgt and csTgt~="" then return (tostring(csTgt):gsub("^%s*@+%s*","")) end
    return nil
end
local function pickEmojis()
    local set = CS_EMOJI_S[csEmoji] or CS_EMOJI_S.RANDOM
    if not set or #set == 0 or csEmoji == "NONE" then return "" end
    if csEmoji == "RANDOM" and math.random() > 0.85 then return "" end
    local count = math.random(1, math.min(3, #set))
    local out = ""
    for i = 1, count do
        out = out .. set[math.random(1, #set)]
    end
    return out
end
local function bld()
    local c=""
    if csMode=="clan" then c=(csTgt..CS_CL):upper()
    elseif csMode=="message" then c=csMsg:upper()
    else
        local raw=resolveTargetDisplay()
        if (raw==nil or raw=="") and csTgt and csTgt~="" then raw=csTgt end
        if raw==nil or raw=="" then raw="everyone" end
        raw = tostring(raw):gsub("^%s*@+%s*","")
        c=("@"..raw.." "..CS_R..CS_W[math.random(1,#CS_W)]):upper()
    end
    local emojiSuffix = pickEmojis()
    -- layout Kai asked for:
    --   line 1  symbols
    --   line 2  clan / message / roast text
    --   line 3  emojis
    local MIN_SYM = 16
    local MAX_SYM = 80
    local nl = 2  -- two newlines between the three blocks
    local budget = CS_M - #emojiSuffix - nl
    local maxContent = math.max(8, budget - MIN_SYM)
    if #c > maxContent then
        c = c:sub(1, maxContent)
    end
    local symCount = math.clamp(budget - #c, MIN_SYM, MAX_SYM)
    local symLine = buildSymBlock(symCount)
    local out = symLine .. "\n" .. c .. "\n" .. emojiSuffix
    if #out > CS_M then
        local room = CS_M - #c - #emojiSuffix - nl
        if room < 0 then room = 0 end
        symLine = buildSymBlock(math.min(symCount, room))
        if #symLine > room then symLine = symLine:sub(1, room) end
        out = symLine .. "\n" .. c .. "\n" .. emojiSuffix
        if #out > CS_M then
            out = out:sub(1, CS_M)
        end
    end
    return out
end

-- ============================================================================
-- FLY (superman) — mobile-safe
-- ============================================================================
-- why mobile got stuck:
--   * PlatformStand=true disables the default touch move handler on many
--     Android/iOS clients, so ControlModule:GetMoveVector() froze at its last
--     value and BodyVelocity kept shoving the character into a wall.
--   * the gyro was re-aimed at the camera every RenderStepped frame, which
--     fought the mobile camera drag.
-- fix:
--   * keep PlatformStand=false on touch so the thumbstick pipeline stays live.
--   * read MoveDirection (physical) and GetMoveVector (control) every frame,
--     fall back to neither — do NOT layer a third "held keys" path on mobile.
--   * gyro only follows yaw (heading), not pitch — no camera lock.
--   * zero BodyVelocity when input is idle so the char doesn't drift.
-- ============================================================================
local FLY = {
    active      = false,
    speed       = 120,
    conns       = {},
    gyro        = nil,
    vel         = nil,
    animTrack   = nil,
    animInst    = nil,
    fwdPose     = false,
    held        = {forward=0,backward=0,left=0,right=0},
    wasAnimate  = false,
    controlMod  = nil,
}
_G.sflySpeed = FLY.speed

;(function()
local FLY_ANIM_REST    = 10714347256
local FLY_ANIM_FORWARD = 10714177846

local function flyGetControl()
    if FLY.controlMod then return FLY.controlMod end
    pcall(function()
        local pscripts = LP:FindFirstChild("PlayerScripts")
        if not pscripts then return end
        local mod = pscripts:FindFirstChild("PlayerModule")
        if not mod then return end
        local ctrl = mod:FindFirstChild("ControlModule")
        if ctrl then FLY.controlMod = require(ctrl) end
        if not FLY.controlMod then
            local ok, PM = pcall(require, mod)
            if ok and type(PM)=="table" then
                if type(PM.GetControls)=="function" then FLY.controlMod = PM:GetControls()
                elseif PM.ControlModule then FLY.controlMod = PM.ControlModule end
            end
        end
    end)
    return FLY.controlMod
end

local function flyReadInput()
    local fwd, str, vert = 0, 0, 0
    -- prefer control module vector (works with thumbstick + keyboard both)
    local cm = flyGetControl()
    if cm and typeof(cm.GetMoveVector)=="function" then
        local ok, mv = pcall(function() return cm:GetMoveVector() end)
        if ok and typeof(mv)=="Vector3" and mv.Magnitude>0.05 then
            fwd = -mv.Z; str = mv.X
        end
    end
    -- physical fallback (mobile thumbstick sets this even without control module)
    if math.abs(fwd)<0.05 and math.abs(str)<0.05 then
        local ch = LP.Character
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        if hum and hum.MoveDirection.Magnitude>0.05 then
            local cam = WS.CurrentCamera
            if cam then
                local lv = cam.CFrame.LookVector
                local rv = cam.CFrame.RightVector
                local l2 = Vector3.new(lv.X,0,lv.Z)
                local r2 = Vector3.new(rv.X,0,rv.Z)
                if l2.Magnitude>0.001 and r2.Magnitude>0.001 then
                    fwd = hum.MoveDirection:Dot(l2.Unit)
                    str = hum.MoveDirection:Dot(r2.Unit)
                end
            end
        end
    end
    -- desktop held-key fallback only; do not use on mobile or we double-shoot
    if not IS_MOBILE and math.abs(fwd)<0.05 and math.abs(str)<0.05 then
        fwd  = FLY.held.forward - FLY.held.backward
        str  = FLY.held.right   - FLY.held.left
    end
    local jumpHeld = false
    pcall(function() jumpHeld = UIS:IsKeyDown(Enum.KeyCode.Space) end)
    if not jumpHeld and not (vert>0.1) then
        local downHeld = false
        pcall(function()
            downHeld = UIS:IsKeyDown(Enum.KeyCode.LeftShift)
                    or UIS:IsKeyDown(Enum.KeyCode.LeftControl)
        end)
        if downHeld then vert = -1 end
    else
        vert = 1
    end
    return fwd, str, vert
end

local function flyPlayAnim(animId, tpos)
    local ch = LP.Character; if not ch then return end
    local hum = ch:FindFirstChildOfClass("Humanoid"); if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then animator = Instance.new("Animator"); animator.Parent = hum end
    if FLY.animTrack then pcall(function() FLY.animTrack:Stop(0) end) end
    if FLY.animInst  then pcall(function() FLY.animInst:Destroy() end) end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. tostring(animId)
    FLY.animInst = anim
    local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
    if not ok or not track then return end
    pcall(function() track.Priority = Enum.AnimationPriority.Action4 end)
    pcall(function() track.Looped = true end)
    pcall(function() track:Play(0.1) end)
    pcall(function() track.TimePosition = tpos or 0; track:AdjustSpeed(0) end)
    FLY.animTrack = track
end

local function flyStopAnim()
    if FLY.animTrack then pcall(function() FLY.animTrack:Stop(0) end); FLY.animTrack=nil end
    if FLY.animInst  then pcall(function() FLY.animInst:Destroy() end); FLY.animInst=nil end
    FLY.fwdPose = false
end

local flyGravityOriginal = WS.Gravity

function _G.startJamunFly()
    if FLY.active then return end
    local ch = LP.Character; if not ch then return end
    local hum = ch:FindFirstChildOfClass("Humanoid")
    local root = ch:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end

    FLY.active = true
    flyGravityOriginal = WS.Gravity

    -- skip the "jump first" prelude on mobile — it desyncs the touch control module
    if not IS_MOBILE then
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
        task.wait(0.1)
        if not FLY.active then return end
    end

    pcall(function() WS.Gravity = 0 end)
    -- mobile: keep PlatformStand false so the thumbstick pipeline keeps working
    pcall(function() hum.PlatformStand = not IS_MOBILE end)
    pcall(function() hum.AutoRotate = false end)

    local animate = ch:FindFirstChild("Animate")
    if animate and not animate.Disabled then
        animate.Disabled = true
        FLY.wasAnimate = true
    end
    stopDefaultTracks(ch)

    flyPlayAnim(FLY_ANIM_REST, 4)

    local oldGyro = root:FindFirstChild("JamunFlyGyro");   if oldGyro then oldGyro:Destroy() end
    local oldVel  = root:FindFirstChild("JamunFlyVelocity"); if oldVel then oldVel:Destroy() end

    local gyro = Instance.new("BodyGyro")
    gyro.Name = "JamunFlyGyro"
    gyro.P = 90000
    gyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
    gyro.CFrame = root.CFrame
    gyro.Parent = root
    FLY.gyro = gyro

    local vel = Instance.new("BodyVelocity")
    vel.Name = "JamunFlyVelocity"
    vel.MaxForce = Vector3.new(9e9,9e9,9e9)
    vel.Velocity = Vector3.zero
    vel.Parent = root
    FLY.vel = vel

    local smooth = Vector3.zero
    local yawGoal = root.CFrame

    local renderConn = RS.RenderStepped:Connect(function()
        if not FLY.active then return end
        local cam = WS.CurrentCamera
        local croot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if not cam or not croot or not FLY.vel or not FLY.gyro then return end
        if not FLY.vel.Parent or not FLY.gyro.Parent then return end

        local fwd, str, vert = flyReadInput()
        local dir = cam.CFrame.LookVector*fwd + cam.CFrame.RightVector*str
        if vert ~= 0 then dir = dir + Vector3.new(0, vert, 0) end

        if fwd > 0.15 then
            if not FLY.fwdPose then FLY.fwdPose = true; flyPlayAnim(FLY_ANIM_FORWARD, 4.65) end
        elseif FLY.fwdPose then
            FLY.fwdPose = false; flyPlayAnim(FLY_ANIM_REST, 4)
        end

        local target
        if dir.Magnitude > 0.05 then
            target = dir.Unit * (tonumber(_G.sflySpeed) or 120)
        else
            -- idle: hold still, zero vertical drift
            target = Vector3.zero
        end
        smooth = smooth:Lerp(target, 0.25)
        FLY.vel.Velocity = smooth

        -- mobile: keep movement pipeline alive by zeroing PlatformStand every frame
        if IS_MOBILE then
            local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.PlatformStand then hum.PlatformStand = false end
        end

        -- orientation:
        --   moving  → full 90° superman: head along path, body horizontal (ref pose)
        --   idle    → upright, yaw follows camera
        local orient
        if smooth.Magnitude > 4 then
            local headDir = smooth.Unit
            -- right axis stable against world up (or camera right if climbing/diving straight)
            local worldUp = Vector3.new(0, 1, 0)
            local right = headDir:Cross(worldUp)
            if right.Magnitude < 0.08 then
                right = headDir:Cross(cam.CFrame.RightVector)
            end
            if right.Magnitude < 1e-4 then
                right = Vector3.new(1, 0, 0)
            end
            right = right.Unit
            -- fromMatrix(pos, right, up): Up = head → head points along flight (90° body)
            -- Look ends up belly-toward-ground when flying level
            orient = CFrame.fromMatrix(croot.Position, right, headDir)
        else
            local look = cam.CFrame.LookVector
            local flat = Vector3.new(look.X, 0, look.Z)
            if flat.Magnitude > 0.001 then
                orient = CFrame.lookAt(croot.Position, croot.Position + flat.Unit)
            else
                orient = CFrame.new(croot.Position) * (croot.CFrame - croot.CFrame.Position)
            end
        end
        yawGoal = orient
        FLY.gyro.CFrame = FLY.gyro.CFrame:Lerp(yawGoal, 0.28)
    end)
    table.insert(FLY.conns, renderConn)

    local jumpConn = UIS.JumpRequest:Connect(function() end)
    table.insert(FLY.conns, jumpConn)

    -- key handlers only matter on desktop; harmless on mobile
    local keyBegan = UIS.InputBegan:Connect(function(i, gpe)
        if gpe or not FLY.active then return end
        local k = i.KeyCode
        if k==Enum.KeyCode.W then FLY.held.forward=1
        elseif k==Enum.KeyCode.S then FLY.held.backward=1
        elseif k==Enum.KeyCode.A then FLY.held.left=1
        elseif k==Enum.KeyCode.D then FLY.held.right=1 end
    end)
    table.insert(FLY.conns, keyBegan)

    local keyEnded = UIS.InputEnded:Connect(function(i)
        local k = i.KeyCode
        if k==Enum.KeyCode.W then FLY.held.forward=0
        elseif k==Enum.KeyCode.S then FLY.held.backward=0
        elseif k==Enum.KeyCode.A then FLY.held.left=0
        elseif k==Enum.KeyCode.D then FLY.held.right=0 end
    end)
    table.insert(FLY.conns, keyEnded)
end

function _G.stopJamunFly()
    if not FLY.active then return end
    FLY.active = false

    pcall(function() WS.Gravity = flyGravityOriginal end)

    local ch = LP.Character
    local hum = ch and ch:FindFirstChildOfClass("Humanoid")
    local root = ch and ch:FindFirstChild("HumanoidRootPart")

    -- kill movers first so nothing fights the restore
    if root then
        local g = root:FindFirstChild("JamunFlyGyro"); if g then g:Destroy() end
        local v = root:FindFirstChild("JamunFlyVelocity"); if v then v:Destroy() end
        pcall(function()
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end)
    end
    FLY.gyro, FLY.vel = nil, nil

    flyStopAnim()

    for _,c in ipairs(FLY.conns) do pcall(function() c:Disconnect() end) end
    FLY.conns = {}

    -- restore rotation + stance so shiftlock / camera-follow works again
    -- AutoRotate was left false and is what kills mobile shiftlock after fly
    if hum then
        pcall(function()
            hum.PlatformStand = false
            hum.Sit = false
            hum.AutoRotate = true
        end)
    end

    if FLY.wasAnimate and ch then
        local animate = ch:FindFirstChild("Animate")
        if animate then animate.Disabled = false end
        FLY.wasAnimate = false
    end

    FLY.held = {forward=0,backward=0,left=0,right=0}
    FLY.fwdPose = false
    FLY.controlMod = nil  -- force re-resolve next fly so control module is fresh

    if hum then
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
        task.defer(function()
            if not hum or not hum.Parent then return end
            pcall(function()
                hum.AutoRotate = true
                hum.PlatformStand = false
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end)
            -- one-frame nudge: align yaw to camera so shiftlock doesn't start facing wrong
            if IS_MOBILE and root and root.Parent then
                local cam = WS.CurrentCamera
                if cam then
                    local look = cam.CFrame.LookVector
                    local flat = Vector3.new(look.X, 0, look.Z)
                    if flat.Magnitude > 0.001 then
                        local pos = root.Position
                        pcall(function()
                            root.CFrame = CFrame.lookAt(pos, pos + flat.Unit)
                        end)
                    end
                end
            end
        end)
    end
end

function _G.toggleJamunFly()
    if FLY.active then _G.stopJamunFly() else _G.startJamunFly() end
end
end)()

-- ============================================================================
-- ONE CLICK LOUD (Mic Up) — shared apply
-- ============================================================================
local OCL_PRESET = {
    -- Mic Up LOUD v3.1 (from loud capture, incl. WetLevel)
    { name="chorus", props={ {"Rate",0}, {"Mix",1}, {"Depth",1} } },
    { name="distortion", props={ {"Level",1} } },
    { name="equalier", props={ {"LowGain",10}, {"MidGain",10}, {"HighGain",10}, {"MidRange",{min=20000,max=20000}} } },
    { name="flter", props={ {"FilterType",0}, {"Gain",30}, {"Q",0.1} } },
    { name="reverb", props={
        {"DecayTime",0.1}, {"Density",1}, {"DecayRatio",1}, {"Diffusion",0},
        {"DryLevel",20}, {"WetLevel",20},
        {"EarlyDelayTime",0}, {"HighCutFrequency",20000},
        {"LateDelayTime",0.1}, {"LowShelfFrequency",20000}, {"LowShelfGain",12},
        {"ReferenceFrequency",20000},
    }},
}
local function oclApply()
    local addEv = RPS:FindFirstChild("event_effect_add")
    local propEv = RPS:FindFirstChild("event_effect_property")
    if not addEv or not propEv then
        return false, "remotes missing (Mic Up only)"
    end
    local applied = {}
    for _, fx in ipairs(OCL_PRESET) do
        local okAdd = pcall(function() addEv:FireServer(fx.name) end)
        if not okAdd then
            table.insert(applied, fx.name..":add_fail")
        else
            task.wait(0.05)
            local okAll = true
            for _, p in ipairs(fx.props) do
                local ok = pcall(function() propEv:FireServer(fx.name, p[1], p[2]) end)
                if not ok then okAll = false end
                task.wait(0.02)
            end
            table.insert(applied, fx.name..(okAll and ":ok" or ":partial"))
        end
        task.wait(0.06)
    end
    return true, table.concat(applied, ", ")
end
_G.__jamunOclApply = oclApply

LP.CharacterAdded:Connect(function()
    if FLY.active then _G.stopJamunFly() end
end)

-- ============================================================================

-- ============================================================================
-- ZEN REANIMATIONS HUB (embedded, core untouched, scoped for register limit)
-- ============================================================================
;(function()
--[[
================================================================================
  CHUNK 5: ZEN REANIMATIONS HUB, CUSTOM KEYFRAME PLAYER, STATE ANIMATIONS,
           BANG REANIM LOCK, SPEED CONTROLLER, LIMB HIDER & KEYBINDS
  Deobfuscated & Reconstructed from Tesla Deo (root.73.124 .. root.75)
  100% Validated Executable Roblox Luau Script (Standalone + Hub-Embeddable)
================================================================================
]]

local CoreGui          = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")
local Players          = game:GetService("Players")
local LocalPlayer      = Players.LocalPlayer

-- Optional host hooks when running alongside Chunks 1-4 (with safe standalone fallbacks)
local function safeRestoreCollisions()
    if type(_G.restoreCollisions) == "function" then
        pcall(_G.restoreCollisions)
    end
end

local function safeStopAntiFling()
    if type(_G.stopAntiFling) == "function" then
        pcall(_G.stopAntiFling)
    end
end

local function safeResetVelocityHooks()
    if type(_G.resetVelocityHooks) == "function" then
        pcall(_G.resetVelocityHooks)
    end
end

local function safeSyncPhysicsStep(myRoot, targetRoot)
    if type(_G.syncBangPhysics) == "function" then
        pcall(_G.syncBangPhysics, myRoot, targetRoot)
    elseif myRoot and myRoot.Parent then
        for _, part in ipairs(myRoot.Parent:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

-- ============================================================================
-- MAIN BUILDER: buildAngoorReanimTab(hostContainer)
-- Exact reconstruction of root.73.124 and all 84 child closures (root.73.124.0 .. 84)
-- ============================================================================
local buildAngoorReanimTab
buildAngoorReanimTab = function(hostContainer)
    _G.buildAngoorReanimTab = buildAngoorReanimTab

    -- If executed standalone without a parent container, create a draggable ScreenGui host window
    local createdStandaloneGui = false
    if not hostContainer then
        local guiParent = nil
        pcall(function() guiParent = (gethui and gethui()) or CoreGui end)
        if not guiParent then
            guiParent = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
        end
        if not guiParent then return end

        local existingGui = guiParent:FindFirstChild("AngoorZenReanimStandalone")
        if existingGui then
            existingGui:Destroy()
        end

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "AngoorZenReanimStandalone"
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        screenGui.Parent = guiParent

        local standaloneHost = Instance.new("Frame")
        standaloneHost.Name = "ZenStandaloneHost"
        standaloneHost.Size = UDim2.new(0, 380, 0, 460)
        standaloneHost.Position = UDim2.new(0.5, -190, 0.5, -230)
        standaloneHost.BackgroundTransparency = 1
        standaloneHost.Parent = screenGui

        hostContainer = standaloneHost
        createdStandaloneGui = true
    end

    -- Theme palette (root.73.124 @ PC 87..314)
    local Theme = {
        bg           = C.glassBg,
        bgCard       = C.glassTile,
        surface      = C.glassTile,
        surfaceHover = C.glassInput,
        input        = C.glassInput,
        accent       = C.accent,
        accentDim    = C.accentDim or C.accentD or C.accent,
        accentGlow   = C.accent,
        danger       = C.danger,
        dangerDim    = Color3.fromRGB(160, 50, 50),
        dangerHover  = Color3.fromRGB(50, 20, 20),
        success      = C.good or C.gd,
        warning      = C.warn or C.wn,
        text         = C.text,
        textMuted    = C.text2,
        textDim      = C.text3,
        divider      = C.stroke,
        border       = C.stroke,
        green        = C.good or Color3.fromRGB(80, 220, 140),
        font         = C.font or Enum.Font.GothamMedium,
    }
    local function pullThemeFromHub()
        Theme.bg = C.glassBg
        Theme.bgCard = C.glassTile
        Theme.surface = C.glassTile
        Theme.surfaceHover = C.glassInput
        Theme.input = C.glassInput
        Theme.accent = C.accent
        Theme.accentDim = C.accentDim or C.accent
        Theme.accentGlow = C.accent
        Theme.text = C.text
        Theme.textMuted = C.text2
        Theme.textDim = C.text3
        Theme.divider = C.stroke
        Theme.border = C.stroke
        Theme.font = C.font or Enum.Font.GothamMedium
        Theme.success = C.good
        Theme.green = C.good
        Theme.warning = C.warn
        Theme.danger = C.danger
    end
    local function retintReanimEmbed()
        pullThemeFromHub()
        local embed = _G.__jamunReanimEmbed
        if not (embed and embed.Parent) then
            embed = nil
            pcall(function()
                if hostContainer then embed = hostContainer:FindFirstChild("ZenReanimEmbed") end
            end)
        end
        if not embed then
            pcall(function()
                local pg = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
                if pg then
                    for _,d in ipairs(pg:GetDescendants()) do
                        if d.Name == "ZenReanimEmbed" then embed = d; break end
                    end
                end
            end)
        end
        if not embed then
            pcall(function()
                local cg = game:GetService("CoreGui")
                for _,d in ipairs(cg:GetDescendants()) do
                    if d.Name == "ZenReanimEmbed" then embed = d; break end
                end
            end)
        end
        if not embed then return end
        _G.__jamunReanimEmbed = embed
        local font = C.font or Theme.font or Enum.Font.GothamMedium
        local face = currentFontFace or C.fontFace or fontFaceFrom(font, THEME_FACE_HINTS[currentThemeName])
        Theme.font = font
        pcall(function()
            embed.BackgroundColor3 = Theme.bg
            local st = embed:FindFirstChildOfClass("UIStroke")
            if st then st.Color = Theme.accent end
        end)
        for _,d in ipairs(embed:GetDescendants()) do
            pcall(function()
                if d:IsA("TextBox") then
                    d.BackgroundColor3 = Theme.input
                    d.TextColor3 = Theme.text
                    d.PlaceholderColor3 = Theme.textMuted
                    applyTextFont(d, font, face)
                elseif d:IsA("TextButton") then
                    local selected = d.TextColor3.R < 0.2 and d.BackgroundTransparency < 0.25
                    if selected then
                        d.BackgroundColor3 = Theme.accent
                        d.TextColor3 = Color3.fromRGB(8,8,12)
                    else
                        if d.BackgroundTransparency <= 0.35 then
                            d.BackgroundColor3 = Theme.surface
                        end
                        if d.TextColor3.R > 0.5 then d.TextColor3 = Theme.text
                        elseif d.TextColor3.R > 0.3 then d.TextColor3 = Theme.textMuted end
                    end
                    applyTextFont(d, font, face)
                    local s = d:FindFirstChildOfClass("UIStroke")
                    if s then s.Color = selected and Theme.accent or Theme.border end
                elseif d:IsA("TextLabel") then
                    local tc = d.TextColor3
                    if tc.R > 0.7 then d.TextColor3 = Theme.text
                    elseif tc.R > 0.4 then d.TextColor3 = Theme.textMuted
                    elseif tc.R > 0.25 then d.TextColor3 = Theme.textDim end
                    applyTextFont(d, font, face)
                elseif d:IsA("Frame") or d:IsA("ScrollingFrame") then
                    if d:IsA("ScrollingFrame") then d.ScrollBarImageColor3 = Theme.accent end
                    local bc = d.BackgroundColor3
                    if d.BackgroundTransparency <= 0.3 and bc.R < 0.3 and bc.G < 0.3 then
                        d.BackgroundColor3 = Theme.bgCard
                    end
                    local s = d:FindFirstChildOfClass("UIStroke")
                    if s and s.Thickness <= 2 then s.Color = Theme.border end
                end
            end)
        end
    end
    _G.__jamunRetintReanim = retintReanimEmbed

    -- Helper root.73.124.0: Add UICorner
    local function addCorner(inst, radiusOffset)
        local corner = Instance.new("UICorner", inst)
        corner.CornerRadius = UDim.new(0, radiusOffset or 8)
        return corner
    end

    -- Helper root.73.124.1: Add UIStroke
    local function addStroke(inst, color, thickness, transparency)
        local stroke = Instance.new("UIStroke", inst)
        stroke.Color = color or Theme.accent
        stroke.Thickness = thickness or 1
        stroke.Transparency = transparency or 0.6
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        return stroke
    end

    -- Helper root.73.124.2: Play Tween
    local function playTween(inst, props, duration, easingStyle, easingDir)
        local info = TweenInfo.new(
            duration or 0.2,
            easingStyle or Enum.EasingStyle.Quad,
            easingDir or Enum.EasingDirection.Out
        )
        local tw = TweenService:Create(inst, info, props)
        tw:Play()
        return tw
    end

    -- Helper root.73.124.3: Load Reanimation Module (Local cache -> Backup GitHub -> Primary GitHub -> Safe Fallback)
    local function loadReanimModule()
        if type(isfile) == "function" and type(readfile) == "function" then
            local okFile, exists = pcall(isfile, "angoorreanim_module.lua")
            if okFile and exists then
                local okRead, content = pcall(readfile, "angoorreanim_module.lua")
                if okRead and type(content) == "string" and #content > 50 then
                    local fn = loadstring(content)
                    if fn then
                        local okRun, api = pcall(fn)
                        if okRun and type(api) == "table" then
                            return api
                        end
                    end
                end
            end
        end

        local urls = {
            "https://raw.githubusercontent.com/teslapapa50-source/Module/refs/heads/main/Module",
            "https://raw.githubusercontent.com/horizen-rblx/reanimsource/main/module.lua",
        }
        for _, url in ipairs(urls) do
            local okHttp, src = pcall(function()
                return game:HttpGet(url)
            end)
            if okHttp and type(src) == "string" and #src > 50 then
                local fn = loadstring(src)
                if fn then
                    if type(writefile) == "function" then
                        pcall(writefile, "angoorreanim_module.lua", src)
                    end
                    local okRun, api = pcall(fn)
                    if okRun and type(api) == "table" then
                        return api
                    end
                end
            end
        end

        -- Safe fallback API table so UI never crashes if offline or module host is unreachable
        local fallbackReanimated = false
        local playListeners = {}
        local stopListeners = {}
        local currentSpeed = 1.0
        return {
            _isFallback = true,
            is_reanimated = function()
                return fallbackReanimated
            end,
            reanimate = function(state)
                if state == nil then
                    fallbackReanimated = not fallbackReanimated
                else
                    fallbackReanimated = (state == true)
                end
                return true
            end,
            play_animation = function(animPath, spd)
                currentSpeed = spd or currentSpeed
                for _, cb in ipairs(playListeners) do
                    pcall(cb, animPath)
                end
                return true
            end,
            stop_animation = function()
                for _, cb in ipairs(stopListeners) do
                    pcall(cb)
                end
                return true
            end,
            preload_animation = function(_) end,
            set_animation_speed = function(spd)
                currentSpeed = spd or 1.0
            end,
            on_animation_play = function(cb)
                if type(cb) == "function" then
                    table.insert(playListeners, cb)
                end
            end,
            on_animation_stop = function(cb)
                if type(cb) == "function" then
                    table.insert(stopListeners, cb)
                end
            end,
            get_clone = function()
                return LocalPlayer and LocalPlayer.Character
            end,
            get_real_character = function()
                return LocalPlayer and LocalPlayer.Character
            end,
        }
    end

    local zenApi = _G._AngoorZenApi
    if zenApi and type(zenApi.reanimate) ~= "function" then
        _G._AngoorZenApi = nil
        zenApi = nil
    end
    if not zenApi then
        local okMod, modRes = pcall(loadReanimModule)
        if okMod and type(modRes) == "table" then
            zenApi = modRes
            _G._AngoorZenApi = zenApi
        else
            warn("Zen Reanimations: Failed to load module.lua. Error: " .. tostring(modRes))
            return
        end
    end

    -- Animation Repository & Cache Configuration (root.73.124 @ PC 8295..8365)
    local allAnimations = type(_G._AngoorZenAnims) == "table" and _G._AngoorZenAnims or {}
    local GITHUB_TREE_URL  = "https://api.github.com/repos/teslapapa50-source/Animations/git/trees/main?recursive=1"
    local RAW_ANIMS_BASE   = "https://raw.githubusercontent.com/teslapapa50-source/Animations/main/"
    local ANIMS_CACHE_FILE = "angoorreanim_anims.json"
    local CONFIG_FILE      = "angoorreanim.json"

    -- Forward declarations for UI refresh functions
    local populateList
    local updateNowPlayingUI
    local refreshBindsTab
    local syncLimbsUIFromState
    local stopBang

    -- Helper root.73.124.4: Build URL-encoded raw GitHub animation URL
    local function buildRawAnimUrl(relPath)
        local s = tostring(relPath or "")
        local encoded = s:gsub("([^%w%-%._~/])", function(ch)
            return string.format("%%%02X", string.byte(ch))
        end)
        return RAW_ANIMS_BASE .. encoded
    end

    -- Helper root.73.124.5: Sort animations alphabetically & store in _G._AngoorZenAnims
    local function setSortedAnimations(list)
        if type(list) ~= "table" then return end
        table.sort(list, function(a, b)
            local na = tostring(a and a.name or ""):lower()
            local nb = tostring(b and b.name or ""):lower()
            return na < nb
        end)
        allAnimations = list
        _G._AngoorZenAnims = list
    end

    -- Helper root.73.124.6: Parse cached animations JSON string
    local function loadCachedAnimsJson(jsonStr)
        if type(jsonStr) ~= "string" or #jsonStr < 5 then
            return false
        end
        if jsonStr:sub(1, 3) == "\239\187\191" then
            jsonStr = jsonStr:sub(4)
        end
        local ok, decoded = pcall(function()
            return HttpService:JSONDecode(jsonStr)
        end)
        if not ok or type(decoded) ~= "table" then
            return false
        end
        local parsed = {}
        for _, item in ipairs(decoded) do
            if type(item) == "table" and item.name and item.path then
                table.insert(parsed, {
                    name     = item.name,
                    path     = item.path,
                    category = item.category or "Reanims",
                    isCustom = (item.isCustom == true),
                })
            end
        end
        if #parsed == 0 then
            return false
        end
        setSortedAnimations(parsed)
        return true
    end

    -- Helper root.73.124.7: Parse GitHub Git Tree API JSON response
    local function parseGitHubTreeJson(jsonStr)
        if type(jsonStr) ~= "string" or #jsonStr < 10 then
            return nil
        end
        local ok, decoded = pcall(function()
            return HttpService:JSONDecode(jsonStr)
        end)
        if not ok or type(decoded) ~= "table" or type(decoded.tree) ~= "table" then
            return nil
        end
        local list = {}
        for _, entry in ipairs(decoded.tree) do
            if type(entry) == "table" and entry.type == "blob" and entry.path then
                local p = tostring(entry.path)
                local lowerP = p:lower()
                if not p:find("/") and (lowerP:sub(-4) == ".lua" or lowerP:sub(-5) == ".luau") then
                    local cleanName = p:gsub("%.luau$", ""):gsub("%.lua$", "")
                    if cleanName ~= "" then
                        table.insert(list, {
                            name     = cleanName,
                            path     = buildRawAnimUrl(p),
                            category = "Reanims",
                        })
                    end
                end
            end
        end
        if #list == 0 then
            return nil
        end
        return list
    end

    -- Persistent User Config State (root.73.124 @ PC 7968..8003)
    local savedConfig = {
        favs        = {},
        binds       = {},
        states      = {},
        speed       = 1,
        speedBinds  = {},
        customAnims = {},
        hiddenLimbs = {},
    }

    -- Helper root.73.124.8: Merge customAnims from savedConfig into allAnimations
    local function mergeSavedCustomAnims()
        if not savedConfig or not savedConfig.customAnims then return end
        local existing = {}
        for _, item in ipairs(allAnimations) do
            if item and item.name then
                existing[tostring(item.name)] = true
            end
        end
        for _, custom in ipairs(savedConfig.customAnims) do
            if custom and custom.name and not existing[custom.name] then
                table.insert(allAnimations, {
                    name     = custom.name,
                    path     = custom.script,
                    category = "Custom",
                    isCustom = true,
                })
                existing[custom.name] = true
            end
        end
        setSortedAnimations(allAnimations)
    end

    -- Helper root.73.124.9: Save non-custom Reanims list to angoorreanim_anims.json
    local function saveAnimsCacheToFile()
        if type(writefile) ~= "function" then return end
        local toSave = {}
        for _, item in ipairs(allAnimations) do
            if not item.isCustom then
                table.insert(toSave, {
                    name     = item.name,
                    path     = item.path,
                    category = item.category or "Reanims",
                })
            end
        end
        pcall(function()
            writefile(ANIMS_CACHE_FILE, HttpService:JSONEncode(toSave))
        end)
    end

    -- Helper root.73.124.10: Fetch animations tree from GitHub in background
    local function fetchGitHubAnimationsAsync()
        local ok, res = pcall(function()
            return game:HttpGet(GITHUB_TREE_URL)
        end)
        if not ok or type(res) ~= "string" then
            warn("[ANGOOR] Animations repo scan failed: " .. tostring(res))
            return
        end
        local parsed = parseGitHubTreeJson(res)
        if not parsed then
            warn("[ANGOOR] Animations repo tree empty/invalid")
            return
        end
        setSortedAnimations(parsed)
        mergeSavedCustomAnims()
        saveAnimsCacheToFile()
        if type(populateList) == "function" then
            pcall(populateList)
        end
        print("[ANGOOR] loaded " .. tostring(#allAnimations) .. " animations from GitHub Animations repo")
    end

    -- Load cached animations & launch background GitHub refresh
    if #allAnimations == 0 then
        if type(isfile) == "function" and type(readfile) == "function" then
            local okExists, exists = pcall(isfile, ANIMS_CACHE_FILE)
            if okExists and exists then
                local okRead, rawJson = pcall(readfile, ANIMS_CACHE_FILE)
                if okRead then
                    loadCachedAnimsJson(rawJson)
                end
            end
        end
        task.spawn(fetchGitHubAnimationsAsync)
    end

    -- Helper root.73.124.11: Load user config from angoorreanim.json
    if type(isfile) == "function" and type(readfile) == "function" then
        local okExists, exists = pcall(isfile, CONFIG_FILE)
        if okExists and exists then
            pcall(function()
                local raw = readfile(CONFIG_FILE)
                local decoded = HttpService:JSONDecode(raw)
                if type(decoded) == "table" then
                    if type(decoded.favs) == "table" then savedConfig.favs = decoded.favs end
                    if type(decoded.binds) == "table" then savedConfig.binds = decoded.binds end
                    if type(decoded.states) == "table" then savedConfig.states = decoded.states end
                    if decoded.speed then savedConfig.speed = tonumber(decoded.speed) or 1 end
                    if type(decoded.speedBinds) == "table" then savedConfig.speedBinds = decoded.speedBinds end
                    if type(decoded.customAnims) == "table" then savedConfig.customAnims = decoded.customAnims end
                    if type(decoded.hiddenLimbs) == "table" then savedConfig.hiddenLimbs = decoded.hiddenLimbs end
                end
            end)
        end
    end

    if type(_G.hiddenBodyParts) ~= "table" then
        _G.hiddenBodyParts = {}
    end
    if type(savedConfig.hiddenLimbs) == "table" then
        for partName, isHidden in pairs(savedConfig.hiddenLimbs) do
            if isHidden then
                _G.hiddenBodyParts[partName] = true
            end
        end
    end

    if type(savedConfig.customAnims) == "table" and #savedConfig.customAnims > 0 then
        mergeSavedCustomAnims()
    end

    -- Helper root.73.124.13: Global refresh hook _G._AngoorZenRefreshList
    _G._AngoorZenRefreshList = function()
        mergeSavedCustomAnims()
        if type(populateList) == "function" then
            pcall(populateList)
        end
    end

    -- Helper root.73.124.14: Save user config to angoorreanim.json
    local function saveConfig()
        if type(writefile) ~= "function" then return end
        pcall(function()
            writefile(CONFIG_FILE, HttpService:JSONEncode(savedConfig))
        end)
    end

    -- Helper root.73.124.15: Preload up to 12 favorite animations in background
    task.spawn(function()
        task.wait(2)
        if not zenApi or type(zenApi.preload_animation) ~= "function" then return end
        local favs = savedConfig.favs or {}
        local count = 0
        for favName, isFav in pairs(favs) do
            if isFav then
                if count >= 12 then break end
                for _, item in ipairs(allAnimations) do
                    if item.name == favName and type(item.path) == "string" and item.path:sub(1, 4) == "http" then
                        pcall(zenApi.preload_animation, item.path)
                        count = count + 1
                        task.wait(0.35)
                        break
                    end
                end
            end
        end
    end)

    -- Playback & Tab State Variables
    local currentSpeed    = tonumber(savedConfig.speed) or 1
    local nowPlayingName  = nil
    local isPlayingManual = false
    local activeSubTab    = "Fun"
    local listShowCount   = 100

    -- If ZenReanimEmbed already exists in hostContainer, just make it visible
    local existingEmbed = hostContainer:FindFirstChild("ZenReanimEmbed")
    if existingEmbed then
        existingEmbed.Visible = true
        return
    end

    -- ========================================================================
    -- UI CONSTRUCTION: ZenReanimEmbed (root.73.124 @ PC 5261..6610)
    -- ========================================================================
    local embedFrame = Instance.new("Frame")
    embedFrame.Name = "ZenReanimEmbed"
    _G.__jamunReanimEmbed = embedFrame
    embedFrame.Size = UDim2.fromScale(1, 1)
    embedFrame.Position = UDim2.new(0, 0, 0, 0)
    embedFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    embedFrame.BorderSizePixel = 0
    embedFrame.ClipsDescendants = true
    embedFrame.Parent = hostContainer
    addCorner(embedFrame, 14)

    local bgGrad = Instance.new("UIGradient", embedFrame)
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 24)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 8)),
    })
    bgGrad.Rotation = 90

    local mainStroke = addStroke(embedFrame, Theme.accent, 1.5, 0)
    local strokeGrad = Instance.new("UIGradient", mainStroke)
    strokeGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.2, 0.6),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(0.8, 0.6),
        NumberSequenceKeypoint.new(1, 1),
    })
    strokeGrad.Rotation = 45

    -- Header Bar
    local headerBar = Instance.new("Frame")
    headerBar.Size = UDim2.new(1, 0, 0, 44)
    headerBar.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
    headerBar.BorderSizePixel = 0
    headerBar.ZIndex = 20
    headerBar.Parent = embedFrame
    addCorner(headerBar, 14)

    local headerDivider = Instance.new("Frame")
    headerDivider.Size = UDim2.new(1, 0, 0, 1)
    headerDivider.Position = UDim2.new(0, 0, 1, -1)
    headerDivider.BackgroundColor3 = Theme.divider
    headerDivider.BorderSizePixel = 0
    headerDivider.ZIndex = 20
    headerDivider.Parent = headerBar

    local reanimHeaderTitle = Instance.new("TextLabel")
    reanimHeaderTitle.Size = UDim2.new(0, 160, 0, 26)
    reanimHeaderTitle.Position = UDim2.new(0, 12, 0.5, -13)
    reanimHeaderTitle.BackgroundTransparency = 1
    reanimHeaderTitle.Text = "Reanim"
    reanimHeaderTitle.TextColor3 = Theme.text
    reanimHeaderTitle.Font = Enum.Font.GothamBlack
    reanimHeaderTitle.TextSize = 13
    reanimHeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
    reanimHeaderTitle.ZIndex = 21
    reanimHeaderTitle.Parent = headerBar

    local reanimToggleBtn = Instance.new("TextButton")
    reanimToggleBtn.Size = UDim2.new(0, 118, 0, 26)
    reanimToggleBtn.Position = UDim2.new(1, -128, 0.5, -13)
    reanimToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    reanimToggleBtn.Text = "Enable Reanim"
    reanimToggleBtn.TextColor3 = Theme.text
    reanimToggleBtn.Font = Enum.Font.GothamBold
    reanimToggleBtn.TextSize = 10
    reanimToggleBtn.ZIndex = 21
    reanimToggleBtn.Parent = headerBar
    addCorner(reanimToggleBtn, 100)
    local reanimBtnStroke = addStroke(reanimToggleBtn, Theme.border, 1, 0.2)

    -- Closure root.73.124.17: Update Enable/Disable Reanim button appearance
    local function updateReanimBtnVisual()
        if not zenApi then
            reanimToggleBtn.Text = "Module missing"
            return
        end
        local isReanim = false
        pcall(function()
            isReanim = zenApi.is_reanimated()
        end)
        if isReanim then
            reanimToggleBtn.Text = "Disable Reanim"
            reanimToggleBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
            reanimToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            reanimBtnStroke.Color = Color3.fromRGB(160, 160, 160)
            reanimBtnStroke.Transparency = 0.2
        else
            reanimToggleBtn.Text = "Enable Reanim"
            reanimToggleBtn.TextColor3 = Theme.text
            reanimToggleBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            reanimBtnStroke.Color = Theme.border
            reanimBtnStroke.Transparency = 0.4
        end
    end

    -- Closure root.73.124.18: Toggle Reanimation on click
    reanimToggleBtn.MouseButton1Click:Connect(function()
        if not zenApi or type(zenApi.reanimate) ~= "function" then
            pcall(function()
                zenApi = loadReanimModule()
                _G._AngoorZenApi = zenApi
            end)
            if not zenApi or type(zenApi.reanimate) ~= "function" then
                reanimToggleBtn.Text = "Module missing"
                warn("Zen Reanimations: module API not loaded")
                return
            end
        end
        local currentlyReanimated = false
        pcall(function()
            currentlyReanimated = zenApi.is_reanimated()
        end)
        local targetState = not currentlyReanimated
        reanimToggleBtn.Text = targetState and "Reanimating..." or "Disabling..."
        reanimToggleBtn.TextColor3 = Theme.textMuted
        task.spawn(function()
            if not targetState and type(stopBang) == "function" then
                pcall(stopBang)
            end
            local okCall, errMsg = pcall(function()
                return zenApi.reanimate(targetState)
            end)
            if not okCall then
                warn("Zen Reanimations crash:", errMsg)
                reanimToggleBtn.Text = "Reanim error"
                task.wait(1.2)
                updateReanimBtnVisual()
                return
            end
            if type(errMsg) == "string" and errMsg ~= "Already reanimated." and errMsg ~= "" then
                warn("Zen Reanimations:", errMsg)
            end
            updateReanimBtnVisual()
            if not targetState then
                isPlayingManual = false
                if type(updateNowPlayingUI) == "function" then
                    pcall(updateNowPlayingUI, nil)
                end
                if type(stopBang) == "function" then
                    pcall(stopBang)
                end
            end
        end)
    end)

    -- Body Container
    local bodyContainer = Instance.new("Frame")
    bodyContainer.Name = "BodyContainer"
    bodyContainer.Size = UDim2.new(1, 0, 1, -48)
    bodyContainer.Position = UDim2.new(0, 0, 0, 48)
    bodyContainer.BackgroundTransparency = 1
    bodyContainer.ClipsDescendants = true
    bodyContainer.Parent = embedFrame

    local stateAssignModal = nil
    local addCustomModal   = nil

    -- Closure root.73.124.20 & 21: drag ONLY in standalone window — never when hosted inside Jamun
    -- (dragging embedFrame inside the panel made the reanim page "get lost")
    if createdStandaloneGui then
        local draggingHeader = false
        local dragStartPos   = nil
        local frameStartPos  = nil
        local dragTarget     = hostContainer

        headerBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingHeader = true
                dragStartPos = input.Position
                frameStartPos = dragTarget.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        draggingHeader = false
                    end
                end)
            end
        end)

        headerBar.InputChanged:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and draggingHeader and dragStartPos and frameStartPos then
                local delta = input.Position - dragStartPos
                dragTarget.Position = UDim2.new(
                    frameStartPos.X.Scale,
                    frameStartPos.X.Offset + delta.X,
                    frameStartPos.Y.Scale,
                    frameStartPos.Y.Offset + delta.Y
                )
            end
        end)
    else
        -- pinned inside host: force fill + no offset so scrollers stay stable
        embedFrame.Position = UDim2.new(0, 0, 0, 0)
        embedFrame.Size = UDim2.fromScale(1, 1)
        embedFrame.AnchorPoint = Vector2.new(0, 0)
    end

    -- ========================================================================
    -- SUB-TAB BAR: Fun, Bang, Favs, Custom, Binds, States, Speed, Limbs
    -- ========================================================================
    local SUB_TABS = { "Fun", "Bang", "Favs", "Binds", "Speed", "Limbs" }
    local subTabButtons = {}
    local switchSubTab

    local subTabBar = Instance.new("Frame")
    subTabBar.Name = "SubTabBar"
    subTabBar.Size = UDim2.new(1, -20, 0, 34)
    subTabBar.Position = UDim2.new(0, 10, 0, 8)
    subTabBar.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    subTabBar.BackgroundTransparency = 0.2
    subTabBar.BorderSizePixel = 0
    subTabBar.ClipsDescendants = true
    subTabBar.Parent = bodyContainer
    addCorner(subTabBar, 100)

    local tabBarStroke = addStroke(subTabBar, Theme.accent, 1.2, 0)
    local tabBarStrokeGrad = Instance.new("UIGradient", tabBarStroke)
    tabBarStrokeGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.4, 1),
        NumberSequenceKeypoint.new(0.5, 0.2),
        NumberSequenceKeypoint.new(0.6, 1),
        NumberSequenceKeypoint.new(1, 1),
    })
    tabBarStrokeGrad.Rotation = 0

    -- Closure root.73.124.22: Rotating shimmer on SubTabBar stroke
    task.spawn(function()
        local tw = TweenService:Create(
            tabBarStrokeGrad,
            TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
            { Rotation = 360 }
        )
        tw:Play()
    end)

    local tabBarBgGrad = Instance.new("UIGradient", subTabBar)
    tabBarBgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(36, 36, 44)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 22)),
    })
    tabBarBgGrad.Rotation = 45

    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Size = UDim2.new(1, -8, 1, -6)
    tabScroll.Position = UDim2.new(0, 4, 0, 3)
    tabScroll.BackgroundTransparency = 1
    tabScroll.BorderSizePixel = 0
    tabScroll.ScrollBarThickness = 3
    tabScroll.ScrollBarImageColor3 = Theme.accent
    tabScroll.ScrollBarImageTransparency = 0.3
    tabScroll.ScrollingDirection = Enum.ScrollingDirection.X
    tabScroll.ElasticBehavior = Enum.ElasticBehavior.Always
    tabScroll.ScrollingEnabled = true
    pcall(function()
        tabScroll.AutomaticCanvasSize = Enum.AutomaticSize.None
    end)
    tabScroll.Parent = subTabBar

    local tabListLayout = Instance.new("UIListLayout")
    tabListLayout.FillDirection = Enum.FillDirection.Horizontal
    tabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    tabListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    tabListLayout.Padding = UDim.new(0, 6)
    tabListLayout.Parent = tabScroll

    -- Closure root.73.124.24: Update horizontal tab scroll canvas width
    local function updateTabBarCanvasSize()
        local totalW = 0
        for _, child in ipairs(tabScroll:GetChildren()) do
            if child:IsA("TextButton") then
                totalW = totalW + child.AbsoluteSize.X + tabListLayout.Padding.Offset
            end
        end
        local minW = math.max(totalW + 12, (#SUB_TABS * 64) + 20)
        tabScroll.CanvasSize = UDim2.new(0, minW, 0, 0)
    end

    for idx, tabName in ipairs(SUB_TABS) do
        local tb = Instance.new("TextButton")
        tb.Size = UDim2.new(0, 58, 1, 0)
        tb.BackgroundColor3 = (idx == 1) and Theme.accent or Color3.fromRGB(30, 30, 35)
        tb.BackgroundTransparency = (idx == 1) and 0 or 0.5
        tb.Text = tabName
        tb.TextColor3 = (idx == 1) and Color3.fromRGB(8, 8, 10) or Theme.textMuted
        tb.Font = (idx == 1) and Enum.Font.GothamBold or Enum.Font.GothamMedium
        tb.TextSize = 10
        tb.AutoButtonColor = false
        tb.Parent = tabScroll
        addCorner(tb, 100)

        subTabButtons[tabName] = { btn = tb }

        local function onTabClick()
            if type(switchSubTab) == "function" then
                switchSubTab(tabName)
            end
        end
        tb.MouseButton1Click:Connect(onTabClick)
    end

    task.defer(function()
        task.wait()
        updateTabBarCanvasSize()
        task.wait(0.1)
        updateTabBarCanvasSize()
    end)

    tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabScroll.CanvasSize = UDim2.new(0, math.max(tabListLayout.AbsoluteContentSize.X + 16, 1), 0, 0)
    end)

    -- ========================================================================
    -- BOTTOM NOW-PLAYING BAR (root.73.124 @ PC 8572..9076)
    -- ========================================================================
    local nowPlayingBar = Instance.new("Frame")
    nowPlayingBar.Size = UDim2.new(1, -20, 0, 32)
    nowPlayingBar.Position = UDim2.new(0, 10, 1, -40)
    nowPlayingBar.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
    nowPlayingBar.BorderSizePixel = 0
    nowPlayingBar.ZIndex = 15
    nowPlayingBar.Parent = bodyContainer
    addCorner(nowPlayingBar, 100)
    addStroke(nowPlayingBar, Theme.border, 1, 0.4)

    local statusDot = Instance.new("Frame")
    statusDot.Size = UDim2.new(0, 7, 0, 7)
    statusDot.Position = UDim2.new(0, 12, 0.5, -3.5)
    statusDot.BackgroundColor3 = Theme.textMuted
    statusDot.BorderSizePixel = 0
    statusDot.ZIndex = 16
    statusDot.Parent = nowPlayingBar
    addCorner(statusDot, 4)

    local nowPlayingLbl = Instance.new("TextLabel")
    nowPlayingLbl.Size = UDim2.new(1, -68, 1, 0)
    nowPlayingLbl.Position = UDim2.new(0, 28, 0, 0)
    nowPlayingLbl.BackgroundTransparency = 1
    nowPlayingLbl.Text = "No animation playing"
    nowPlayingLbl.TextColor3 = Theme.textMuted
    nowPlayingLbl.Font = Enum.Font.GothamMedium
    nowPlayingLbl.TextSize = 10.5
    nowPlayingLbl.TextXAlignment = Enum.TextXAlignment.Left
    nowPlayingLbl.TextTruncate = Enum.TextTruncate.AtEnd
    nowPlayingLbl.ZIndex = 16
    nowPlayingLbl.Parent = nowPlayingBar

    local stopAnimBtn = Instance.new("TextButton")
    stopAnimBtn.Size = UDim2.new(0, 22, 0, 22)
    stopAnimBtn.Position = UDim2.new(1, -28, 0.5, -11)
    stopAnimBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    stopAnimBtn.Text = ""
    stopAnimBtn.ZIndex = 16
    stopAnimBtn.Parent = nowPlayingBar
    addCorner(stopAnimBtn, 11)
    local stopBtnStroke = addStroke(stopAnimBtn, Theme.divider, 1, 0.3)

    local stopSquareIcon = Instance.new("Frame")
    stopSquareIcon.Size = UDim2.new(0, 8, 0, 8)
    stopSquareIcon.Position = UDim2.new(0.5, -4, 0.5, -4)
    stopSquareIcon.BackgroundColor3 = Theme.textMuted
    stopSquareIcon.BorderSizePixel = 0
    stopSquareIcon.ZIndex = 17
    stopSquareIcon.Parent = stopAnimBtn
    addCorner(stopSquareIcon, 2)

    -- Closure root.73.124.29: Update Now Playing status bar
    updateNowPlayingUI = function(animTitle)
        nowPlayingName = animTitle
        if animTitle and animTitle ~= "" then
            local cleanTitle = tostring(animTitle):gsub("%.lua$", "")
            nowPlayingLbl.Text = "▶  " .. cleanTitle
            nowPlayingLbl.TextColor3 = Theme.text
            statusDot.BackgroundColor3 = Theme.green
            stopSquareIcon.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
            playTween(stopAnimBtn, { BackgroundColor3 = Color3.fromRGB(35, 20, 20) }, 0.2)
            playTween(stopBtnStroke, { Color = Color3.fromRGB(160, 50, 50), Transparency = 0.2 }, 0.2)
        else
            nowPlayingLbl.Text = "No animation playing"
            nowPlayingLbl.TextColor3 = Theme.textMuted
            statusDot.BackgroundColor3 = Theme.textMuted
            stopSquareIcon.BackgroundColor3 = Theme.textMuted
            playTween(stopAnimBtn, { BackgroundColor3 = Color3.fromRGB(24, 24, 24) }, 0.2)
            playTween(stopBtnStroke, { Color = Theme.divider, Transparency = 0.5 }, 0.2)
        end
    end

    -- Closure root.73.124.30: Stop currently playing animation
    stopAnimBtn.MouseButton1Click:Connect(function()
        isPlayingManual = false
        if zenApi and type(zenApi.stop_animation) == "function" then
            pcall(zenApi.stop_animation)
        end
        updateNowPlayingUI(nil)
    end)

    -- Closure root.73.124.31 & 32: Hook module play/stop callbacks
    if zenApi and type(zenApi.on_animation_play) == "function" then
        zenApi.on_animation_play(function(playedPath)
            local matchedName = nil
            for _, item in ipairs(allAnimations) do
                if item.path == playedPath then
                    matchedName = item.name
                    break
                end
            end
            updateNowPlayingUI(matchedName or "Playing Animation")
        end)
    end
    if zenApi and type(zenApi.on_animation_stop) == "function" then
        zenApi.on_animation_stop(function()
            updateNowPlayingUI(nil)
        end)
    end

    -- ========================================================================
    -- CONTENT PAGES CONTAINER (root.73.124 @ PC 9083..11284)
    -- ========================================================================
    local pagesHolder = Instance.new("Frame")
    pagesHolder.Size = UDim2.new(1, -20, 1, -94)
    pagesHolder.Position = UDim2.new(0, 10, 0, 48)
    pagesHolder.BackgroundTransparency = 1
    pagesHolder.Parent = bodyContainer

    -- 1. FUN / FAVS / CUSTOM LIST PAGE
    local listPage = Instance.new("Frame")
    listPage.Size = UDim2.new(1, 0, 1, 0)
    listPage.BackgroundTransparency = 1
    listPage.Visible = true
    listPage.Parent = pagesHolder

    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(1, -96, 0, 30)
    searchBox.Position = UDim2.new(0, 0, 0, 0)
    searchBox.BackgroundColor3 = Theme.input
    searchBox.PlaceholderText = "Search animations..."
    searchBox.PlaceholderColor3 = Theme.textMuted
    searchBox.Text = ""
    searchBox.TextColor3 = Theme.text
    searchBox.Font = Enum.Font.GothamMedium
    searchBox.TextSize = 10.5
    searchBox.TextXAlignment = Enum.TextXAlignment.Left
    searchBox.ClearTextOnFocus = false
    searchBox.Parent = listPage
    addCorner(searchBox, 100)
    addStroke(searchBox, Theme.divider, 1, 0.2)

    local searchPad = Instance.new("UIPadding")
    searchPad.PaddingLeft = UDim.new(0, 12)
    searchPad.PaddingRight = UDim.new(0, 10)
    searchPad.Parent = searchBox

    local addCustomOpenBtn = Instance.new("TextButton")
    addCustomOpenBtn.Size = UDim2.new(0, 90, 0, 30)
    addCustomOpenBtn.Position = UDim2.new(1, -90, 0, 0)
    addCustomOpenBtn.BackgroundColor3 = Theme.surface
    addCustomOpenBtn.Text = "+ Add Custom"
    addCustomOpenBtn.TextColor3 = Theme.accent
    addCustomOpenBtn.Font = Enum.Font.GothamBold
    addCustomOpenBtn.TextSize = 9.5
    addCustomOpenBtn.Parent = listPage
    addCorner(addCustomOpenBtn, 100)
    addStroke(addCustomOpenBtn, Theme.border, 1, 0.3)

    local animListScroll = Instance.new("ScrollingFrame")
    animListScroll.Size = UDim2.new(1, 0, 1, -38)
    animListScroll.Position = UDim2.new(0, 0, 0, 38)
    animListScroll.BackgroundTransparency = 1
    animListScroll.BorderSizePixel = 0
    animListScroll.ScrollBarThickness = 3
    animListScroll.ScrollBarImageColor3 = Theme.accent
    animListScroll.ScrollBarImageTransparency = 0.6
    animListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    animListScroll.Parent = listPage

    local animListLayout = Instance.new("UIListLayout")
    animListLayout.Padding = UDim.new(0, 4)
    animListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    animListLayout.Parent = animListScroll

    local emptyFavsLabel = Instance.new("TextLabel")
    emptyFavsLabel.Size = UDim2.new(1, 0, 0, 60)
    emptyFavsLabel.Position = UDim2.new(0, 0, 0.3, 0)
    emptyFavsLabel.BackgroundTransparency = 1
    emptyFavsLabel.Text = "No favorite animations yet.\nClick the star icon (★) on any animation in the Reanims tab!"
    emptyFavsLabel.TextColor3 = Theme.textMuted
    emptyFavsLabel.Font = Enum.Font.GothamMedium
    emptyFavsLabel.TextSize = 11
    emptyFavsLabel.Visible = false
    emptyFavsLabel.Parent = listPage

    local emptyCustomLabel = Instance.new("TextLabel")
    emptyCustomLabel.Size = UDim2.new(1, 0, 0, 60)
    emptyCustomLabel.Position = UDim2.new(0, 0, 0.3, 0)
    emptyCustomLabel.BackgroundTransparency = 1
    emptyCustomLabel.Text = "No custom animations added yet.\nClick [+ Add Custom] above to paste and import animations!"
    emptyCustomLabel.TextColor3 = Theme.textMuted
    emptyCustomLabel.Font = Enum.Font.GothamMedium
    emptyCustomLabel.TextSize = 11
    emptyCustomLabel.Visible = false
    emptyCustomLabel.Parent = listPage

    -- 2. BINDS PAGE
    local bindsPage = Instance.new("ScrollingFrame")
    bindsPage.Size = UDim2.new(1, 0, 1, 0)
    bindsPage.BackgroundTransparency = 1
    bindsPage.BorderSizePixel = 0
    bindsPage.ScrollBarThickness = 3
    bindsPage.ScrollBarImageColor3 = Theme.accent
    bindsPage.ScrollBarImageTransparency = 0.6
    bindsPage.Visible = false
    bindsPage.Parent = pagesHolder

    local bindsLayout = Instance.new("UIListLayout")
    bindsLayout.Padding = UDim.new(0, 6)
    bindsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    bindsLayout.Parent = bindsPage

    local bindsHintLabel = Instance.new("TextLabel")
    bindsHintLabel.Size = UDim2.new(1, 0, 0, 20)
    bindsHintLabel.BackgroundTransparency = 1
    bindsHintLabel.Text = "Click key button to rebind  |  Click [X] to unbind"
    bindsHintLabel.TextColor3 = Theme.textMuted
    bindsHintLabel.Font = Enum.Font.GothamMedium
    bindsHintLabel.TextSize = 10
    bindsHintLabel.TextXAlignment = Enum.TextXAlignment.Left
    bindsHintLabel.Parent = bindsPage

    local emptyBindsLabel = Instance.new("TextLabel")
    emptyBindsLabel.Size = UDim2.new(1, 0, 0, 60)
    emptyBindsLabel.BackgroundTransparency = 1
    emptyBindsLabel.Text = "No keybinds assigned yet.\nIn the Reanims tab, click [+] next to any animation to bind a key!"
    emptyBindsLabel.TextColor3 = Theme.textMuted
    emptyBindsLabel.Font = Enum.Font.GothamMedium
    emptyBindsLabel.TextSize = 11
    emptyBindsLabel.Visible = false
    emptyBindsLabel.Parent = bindsPage

    -- 3. SPEED PAGE
    local speedPage = Instance.new("ScrollingFrame")
    speedPage.Size = UDim2.new(1, 0, 1, 0)
    speedPage.BackgroundTransparency = 1
    speedPage.BorderSizePixel = 0
    speedPage.ScrollBarThickness = 3
    speedPage.ScrollBarImageColor3 = Theme.accent
    speedPage.ScrollBarImageTransparency = 0.6
    speedPage.Visible = false
    speedPage.Parent = pagesHolder

    local speedLayout = Instance.new("UIListLayout")
    speedLayout.Padding = UDim.new(0, 10)
    speedLayout.SortOrder = Enum.SortOrder.LayoutOrder
    speedLayout.Parent = speedPage

    local speedSliderCard = Instance.new("Frame")
    speedSliderCard.Size = UDim2.new(1, 0, 0, 78)
    speedSliderCard.BackgroundColor3 = Theme.bgCard
    speedSliderCard.Parent = speedPage
    addCorner(speedSliderCard, 8)
    addStroke(speedSliderCard, Theme.divider, 1, 0)

    local speedTitleLbl = Instance.new("TextLabel")
    speedTitleLbl.Size = UDim2.new(1, -20, 0, 22)
    speedTitleLbl.Position = UDim2.new(0, 10, 0, 8)
    speedTitleLbl.BackgroundTransparency = 1
    speedTitleLbl.Text = "PLAYBACK SPEED"
    speedTitleLbl.TextColor3 = Theme.textMuted
    speedTitleLbl.Font = Enum.Font.GothamBold
    speedTitleLbl.TextSize = 10
    speedTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    speedTitleLbl.Parent = speedSliderCard

    local sliderTrack = Instance.new("Frame")
    sliderTrack.Size = UDim2.new(1, -130, 0, 6)
    sliderTrack.Position = UDim2.new(0, 10, 0, 46)
    sliderTrack.BackgroundColor3 = Theme.surface
    sliderTrack.BorderSizePixel = 0
    sliderTrack.Parent = speedSliderCard
    addCorner(sliderTrack, 3)

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0.3, 0, 1, 0)
    sliderFill.BackgroundColor3 = Theme.accent
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack
    addCorner(sliderFill, 3)

    local sliderKnob = Instance.new("Frame")
    sliderKnob.Size = UDim2.new(0, 14, 0, 14)
    sliderKnob.Position = UDim2.new(1, -7, 0.5, -7)
    sliderKnob.BackgroundColor3 = Theme.text
    sliderKnob.BorderSizePixel = 0
    sliderKnob.Parent = sliderFill
    addCorner(sliderKnob, 7)

    local speedValueLbl = Instance.new("TextLabel")
    speedValueLbl.Size = UDim2.new(0, 48, 0, 22)
    speedValueLbl.Position = UDim2.new(1, -114, 0, 38)
    speedValueLbl.BackgroundColor3 = Theme.input
    speedValueLbl.Text = string.format("%.1fx", currentSpeed)
    speedValueLbl.TextColor3 = Theme.accent
    speedValueLbl.Font = Enum.Font.GothamBold
    speedValueLbl.TextSize = 10
    speedValueLbl.Parent = speedSliderCard
    addCorner(speedValueLbl, 4)
    addStroke(speedValueLbl, Theme.divider, 1, 0)

    local resetSpeedBtn = Instance.new("TextButton")
    resetSpeedBtn.Size = UDim2.new(0, 54, 0, 22)
    resetSpeedBtn.Position = UDim2.new(1, -60, 0, 38)
    resetSpeedBtn.BackgroundColor3 = Theme.surface
    resetSpeedBtn.Text = "Reset 1.0x"
    resetSpeedBtn.TextColor3 = Theme.text
    resetSpeedBtn.Font = Enum.Font.GothamSemibold
    resetSpeedBtn.TextSize = 9
    resetSpeedBtn.Parent = speedSliderCard
    addCorner(resetSpeedBtn, 4)
    addStroke(resetSpeedBtn, Theme.divider, 1, 0)

    -- Closure root.73.124.33: Apply playback speed
    local function applyPlaybackSpeed(val)
        local rounded = math.clamp(math.floor(val * 10) / 10, 0.1, 5)
        currentSpeed = rounded
        savedConfig.speed = currentSpeed
        saveConfig()
        speedValueLbl.Text = string.format("%.1fx", currentSpeed)
        local alpha = math.clamp((currentSpeed - 0.1) / (3 - 0.1), 0, 1)
        sliderFill.Size = UDim2.new(alpha, 0, 1, 0)
        if zenApi and type(zenApi.set_animation_speed) == "function" then
            pcall(zenApi.set_animation_speed, currentSpeed)
        end
    end

    resetSpeedBtn.MouseButton1Click:Connect(function()
        applyPlaybackSpeed(1)
    end)

    -- Closure root.73.124.35..38: Drag speed slider
    local draggingSpeedSlider = false
    local function updateSpeedFromInput(input)
        local w = math.max(sliderTrack.AbsoluteSize.X, 1)
        local relX = math.clamp(input.Position.X - sliderTrack.AbsolutePosition.X, 0, w)
        applyPlaybackSpeed(0.1 + 2.9 * (relX / w))
    end

    speedSliderCard.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSpeedSlider = true
            updateSpeedFromInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSpeedSlider = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if draggingSpeedSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSpeedFromInput(input)
        end
    end)

    -- Speed Presets & Hotkeys Card
    local speedPresetsCard = Instance.new("Frame")
    speedPresetsCard.Size = UDim2.new(1, 0, 0, 110)
    speedPresetsCard.BackgroundColor3 = Theme.bgCard
    speedPresetsCard.Parent = speedPage
    addCorner(speedPresetsCard, 8)
    addStroke(speedPresetsCard, Theme.divider, 1, 0)

    local presetsHeaderLbl = Instance.new("TextLabel")
    presetsHeaderLbl.Size = UDim2.new(1, -20, 0, 20)
    presetsHeaderLbl.Position = UDim2.new(0, 10, 0, 8)
    presetsHeaderLbl.BackgroundTransparency = 1
    presetsHeaderLbl.Text = "SPEED PRESETS & HOTKEYS"
    presetsHeaderLbl.TextColor3 = Theme.textMuted
    presetsHeaderLbl.Font = Enum.Font.GothamBold
    presetsHeaderLbl.TextSize = 10
    presetsHeaderLbl.TextXAlignment = Enum.TextXAlignment.Left
    presetsHeaderLbl.Parent = speedPresetsCard

    local presetsSubLbl = Instance.new("TextLabel")
    presetsSubLbl.Size = UDim2.new(1, -20, 0, 14)
    presetsSubLbl.Position = UDim2.new(0, 10, 0, 26)
    presetsSubLbl.BackgroundTransparency = 1
    presetsSubLbl.Text = "Click speed button to apply  |  Click [+] to bind key"
    presetsSubLbl.TextColor3 = Theme.textMuted
    presetsSubLbl.Font = Enum.Font.Gotham
    presetsSubLbl.TextSize = 9
    presetsSubLbl.TextXAlignment = Enum.TextXAlignment.Left
    presetsSubLbl.Parent = speedPresetsCard

    local SPEED_PRESETS = { 0.5, 1, 1.5, 2, 3 }
    local presetsGrid = Instance.new("Frame")
    presetsGrid.Size = UDim2.new(1, -20, 0, 52)
    presetsGrid.Position = UDim2.new(0, 10, 0, 48)
    presetsGrid.BackgroundTransparency = 1
    presetsGrid.Parent = speedPresetsCard

    local pendingSpeedBindKey = nil
    local speedBindButtons    = {}

    for idx, spdVal in ipairs(SPEED_PRESETS) do
        local colScale = 1 / #SPEED_PRESETS
        local spdBtn = Instance.new("TextButton")
        spdBtn.Size = UDim2.new(colScale, -4, 0, 24)
        spdBtn.Position = UDim2.new((idx - 1) * colScale, 2, 0, 0)
        spdBtn.BackgroundColor3 = Theme.surface
        spdBtn.Text = string.format("%.1fx", spdVal)
        spdBtn.TextColor3 = Theme.text
        spdBtn.Font = Enum.Font.GothamBold
        spdBtn.TextSize = 11
        spdBtn.Parent = presetsGrid
        addCorner(spdBtn, 4)
        addStroke(spdBtn, Theme.divider, 1, 0)

        spdBtn.MouseButton1Click:Connect(function()
            applyPlaybackSpeed(spdVal)
        end)

        local spdKeyStr = tostring(spdVal)
        local boundKey = savedConfig.speedBinds[spdKeyStr]
        local bindBtn = Instance.new("TextButton")
        bindBtn.Size = UDim2.new(colScale, -4, 0, 20)
        bindBtn.Position = UDim2.new((idx - 1) * colScale, 2, 0, 28)
        bindBtn.BackgroundColor3 = Theme.input
        bindBtn.Text = boundKey and ("[" .. boundKey .. "]") or "[+]"
        bindBtn.TextColor3 = boundKey and Theme.accent or Theme.textMuted
        bindBtn.Font = Enum.Font.GothamSemibold
        bindBtn.TextSize = 9
        bindBtn.Parent = presetsGrid
        addCorner(bindBtn, 4)
        addStroke(bindBtn, Theme.divider, 1, 0)

        speedBindButtons[spdKeyStr] = bindBtn

        -- Closure root.73.124.40: Toggle speed hotkey binding mode
        bindBtn.MouseButton1Click:Connect(function()
            if pendingSpeedBindKey == spdKeyStr then
                pendingSpeedBindKey = nil
                local curBind = savedConfig.speedBinds[spdKeyStr]
                bindBtn.Text = curBind and ("[" .. curBind .. "]") or "[+]"
                bindBtn.TextColor3 = curBind and Theme.accent or Theme.textMuted
            else
                pendingSpeedBindKey = spdKeyStr
                bindBtn.Text = "[?]"
                bindBtn.TextColor3 = Color3.fromRGB(255, 180, 50)
            end
        end)
    end

    -- 4. STATES PAGE (Idle, Walk, Run, Jump, Fall)
    local statesPage = Instance.new("ScrollingFrame")
    statesPage.Size = UDim2.new(1, 0, 1, 0)
    statesPage.BackgroundTransparency = 1
    statesPage.BorderSizePixel = 0
    statesPage.ScrollBarThickness = 3
    statesPage.ScrollBarImageColor3 = Theme.accent
    statesPage.ScrollBarImageTransparency = 0.6
    statesPage.Visible = false
    statesPage.Parent = pagesHolder

    local statesLayout = Instance.new("UIListLayout")
    statesLayout.Padding = UDim.new(0, 8)
    statesLayout.SortOrder = Enum.SortOrder.LayoutOrder
    statesLayout.Parent = statesPage

    local statesTitleLbl = Instance.new("TextLabel")
    statesTitleLbl.Size = UDim2.new(1, 0, 0, 18)
    statesTitleLbl.BackgroundTransparency = 1
    statesTitleLbl.Text = "CHARACTER STATE ANIMATIONS"
    statesTitleLbl.TextColor3 = Theme.textMuted
    statesTitleLbl.Font = Enum.Font.GothamBold
    statesTitleLbl.TextSize = 10
    statesTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    statesTitleLbl.Parent = statesPage

    local statesSubLbl = Instance.new("TextLabel")
    statesSubLbl.Size = UDim2.new(1, 0, 0, 14)
    statesSubLbl.BackgroundTransparency = 1
    statesSubLbl.Text = "Automatically triggers animations on character movement"
    statesSubLbl.TextColor3 = Theme.textMuted
    statesSubLbl.Font = Enum.Font.Gotham
    statesSubLbl.TextSize = 9
    statesSubLbl.TextXAlignment = Enum.TextXAlignment.Left
    statesSubLbl.Parent = statesPage

    local STATE_NAMES = { "Idle", "Walk", "Run", "Jump", "Fall" }
    local stateAssignButtons = {}
    local assigningStateName = nil

    -- State Animation Picker Modal (root.73.124 @ PC 751..1525)
    stateAssignModal = Instance.new("Frame")
    stateAssignModal.Size = UDim2.new(1, 0, 1, 0)
    stateAssignModal.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    stateAssignModal.BackgroundTransparency = 0.4
    stateAssignModal.BorderSizePixel = 0
    stateAssignModal.ZIndex = 50
    stateAssignModal.Visible = false
    stateAssignModal.Parent = embedFrame

    local stateModalCard = Instance.new("Frame")
    stateModalCard.Size = UDim2.new(0, 330, 0, 400)
    stateModalCard.Position = UDim2.new(0.5, -165, 0.5, -200)
    stateModalCard.BackgroundColor3 = Theme.bgCard
    stateModalCard.BorderSizePixel = 0
    stateModalCard.ZIndex = 51
    stateModalCard.Parent = stateAssignModal
    addCorner(stateModalCard, 10)
    addStroke(stateModalCard, Theme.border, 1.5, 0)

    local stateModalTitle = Instance.new("TextLabel")
    stateModalTitle.Size = UDim2.new(1, -50, 0, 36)
    stateModalTitle.Position = UDim2.new(0, 14, 0, 6)
    stateModalTitle.BackgroundTransparency = 1
    stateModalTitle.Text = "Select Animation for State"
    stateModalTitle.TextColor3 = Theme.text
    stateModalTitle.Font = Enum.Font.GothamBlack
    stateModalTitle.TextSize = 12
    stateModalTitle.TextXAlignment = Enum.TextXAlignment.Left
    stateModalTitle.ZIndex = 52
    stateModalTitle.Parent = stateModalCard

    local stateModalCloseBtn = Instance.new("TextButton")
    stateModalCloseBtn.Size = UDim2.new(0, 24, 0, 24)
    stateModalCloseBtn.Position = UDim2.new(1, -34, 0, 10)
    stateModalCloseBtn.BackgroundColor3 = Theme.surface
    stateModalCloseBtn.Text = "✕"
    stateModalCloseBtn.TextColor3 = Theme.textMuted
    stateModalCloseBtn.Font = Enum.Font.GothamBold
    stateModalCloseBtn.TextSize = 11
    stateModalCloseBtn.ZIndex = 52
    stateModalCloseBtn.Parent = stateModalCard
    addCorner(stateModalCloseBtn, 12)

    stateModalCloseBtn.MouseButton1Click:Connect(function()
        stateAssignModal.Visible = false
        assigningStateName = nil
    end)

    local stateModalSearch = Instance.new("TextBox")
    stateModalSearch.Size = UDim2.new(1, -28, 0, 30)
    stateModalSearch.Position = UDim2.new(0, 14, 0, 44)
    stateModalSearch.BackgroundColor3 = Theme.input
    stateModalSearch.PlaceholderText = "Search animations to assign..."
    stateModalSearch.PlaceholderColor3 = Theme.textMuted
    stateModalSearch.Text = ""
    stateModalSearch.TextColor3 = Theme.text
    stateModalSearch.Font = Enum.Font.GothamMedium
    stateModalSearch.TextSize = 11
    stateModalSearch.TextXAlignment = Enum.TextXAlignment.Left
    stateModalSearch.ZIndex = 52
    stateModalSearch.ClearTextOnFocus = false
    stateModalSearch.Parent = stateModalCard
    addCorner(stateModalSearch, 6)
    addStroke(stateModalSearch, Theme.divider, 1, 0)

    local stateModalSearchPad = Instance.new("UIPadding")
    stateModalSearchPad.PaddingLeft = UDim.new(0, 10)
    stateModalSearchPad.PaddingRight = UDim.new(0, 10)
    stateModalSearchPad.Parent = stateModalSearch

    local stateModalScroll = Instance.new("ScrollingFrame")
    stateModalScroll.Size = UDim2.new(1, -28, 1, -90)
    stateModalScroll.Position = UDim2.new(0, 14, 0, 80)
    stateModalScroll.BackgroundTransparency = 1
    stateModalScroll.BorderSizePixel = 0
    stateModalScroll.ScrollBarThickness = 3
    stateModalScroll.ScrollBarImageColor3 = Theme.accent
    stateModalScroll.ScrollBarImageTransparency = 0.6
    stateModalScroll.ZIndex = 52
    stateModalScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    stateModalScroll.Parent = stateModalCard

    local stateModalListLayout = Instance.new("UIListLayout")
    stateModalListLayout.Padding = UDim.new(0, 4)
    stateModalListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    stateModalListLayout.Parent = stateModalScroll

    -- Closure root.73.124.42: Populate state animation picker list
    local function populateStatePickerList(queryText)
        for _, child in ipairs(stateModalScroll:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        local q = tostring(queryText or ""):lower()
        local count = 0
        for _, animEntry in ipairs(allAnimations) do
            if q == "" or animEntry.name:lower():find(q, 1, true) then
                count = count + 1
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -6, 0, 28)
                btn.BackgroundColor3 = Theme.surface
                btn.Text = animEntry.name
                btn.TextColor3 = Theme.text
                btn.Font = Enum.Font.GothamMedium
                btn.TextSize = 11
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.TextTruncate = Enum.TextTruncate.AtEnd
                btn.ZIndex = 53
                btn.Parent = stateModalScroll
                addCorner(btn, 4)
                addStroke(btn, Theme.divider, 1, 0)

                local pad = Instance.new("UIPadding")
                pad.PaddingLeft = UDim.new(0, 10)
                pad.Parent = btn

                btn.MouseButton1Click:Connect(function()
                    if assigningStateName then
                        savedConfig.states[assigningStateName] = {
                            name = animEntry.name,
                            path = animEntry.path,
                        }
                        saveConfig()
                        local stateBtn = stateAssignButtons[assigningStateName]
                        if stateBtn then
                            stateBtn.Text = animEntry.name
                            stateBtn.TextColor3 = Color3.fromRGB(100, 220, 120)
                        end
                    end
                    stateAssignModal.Visible = false
                    assigningStateName = nil
                end)
            end
        end
        stateModalScroll.CanvasSize = UDim2.new(0, 0, 0, count * 32)
    end

    stateModalSearch:GetPropertyChangedSignal("Text"):Connect(function()
        populateStatePickerList(stateModalSearch.Text)
    end)

    -- Build rows for Idle, Walk, Run, Jump, Fall
    for _, stateName in ipairs(STATE_NAMES) do
        local rowFrame = Instance.new("Frame")
        rowFrame.Size = UDim2.new(1, 0, 0, 42)
        rowFrame.BackgroundColor3 = Theme.bgCard
        rowFrame.Parent = statesPage
        addCorner(rowFrame, 6)
        addStroke(rowFrame, Theme.divider, 1, 0)

        local stLbl = Instance.new("TextLabel")
        stLbl.Size = UDim2.new(0, 70, 1, 0)
        stLbl.Position = UDim2.new(0, 12, 0, 0)
        stLbl.BackgroundTransparency = 1
        stLbl.Text = stateName
        stLbl.TextColor3 = Theme.text
        stLbl.Font = Enum.Font.GothamBold
        stLbl.TextSize = 11
        stLbl.TextXAlignment = Enum.TextXAlignment.Left
        stLbl.Parent = rowFrame

        local curStateCfg = savedConfig.states[stateName]
        local assignBtn = Instance.new("TextButton")
        assignBtn.Size = UDim2.new(1, -150, 0, 26)
        assignBtn.Position = UDim2.new(0, 84, 0.5, -13)
        assignBtn.BackgroundColor3 = Theme.surface
        assignBtn.Text = (curStateCfg and curStateCfg.name) or "None"
        assignBtn.TextColor3 = (curStateCfg and curStateCfg.name) and Color3.fromRGB(100, 220, 120) or Theme.textMuted
        assignBtn.Font = Enum.Font.GothamMedium
        assignBtn.TextSize = 11
        assignBtn.TextXAlignment = Enum.TextXAlignment.Left
        assignBtn.TextTruncate = Enum.TextTruncate.AtEnd
        assignBtn.Parent = rowFrame
        addCorner(assignBtn, 4)
        addStroke(assignBtn, Theme.divider, 1, 0)

        local assignPad = Instance.new("UIPadding")
        assignPad.PaddingLeft = UDim.new(0, 8)
        assignPad.PaddingRight = UDim.new(0, 8)
        assignPad.Parent = assignBtn

        stateAssignButtons[stateName] = assignBtn

        assignBtn.MouseButton1Click:Connect(function()
            assigningStateName = stateName
            stateModalTitle.Text = "Assign Animation for: " .. stateName
            stateModalSearch.Text = ""
            populateStatePickerList("")
            stateAssignModal.Visible = true
        end)

        local clearBtn = Instance.new("TextButton")
        clearBtn.Size = UDim2.new(0, 52, 0, 26)
        clearBtn.Position = UDim2.new(1, -60, 0.5, -13)
        clearBtn.BackgroundColor3 = Theme.surface
        clearBtn.Text = "Clear"
        clearBtn.TextColor3 = Theme.textMuted
        clearBtn.Font = Enum.Font.GothamSemibold
        clearBtn.TextSize = 10
        clearBtn.Parent = rowFrame
        addCorner(clearBtn, 4)
        addStroke(clearBtn, Theme.divider, 1, 0)

        clearBtn.MouseEnter:Connect(function()
            playTween(clearBtn, { BackgroundColor3 = Theme.dangerHover, TextColor3 = Theme.accent }, 0.15)
        end)
        clearBtn.MouseLeave:Connect(function()
            playTween(clearBtn, { BackgroundColor3 = Theme.surface, TextColor3 = Theme.textMuted }, 0.15)
        end)
        clearBtn.MouseButton1Click:Connect(function()
            savedConfig.states[stateName] = nil
            saveConfig()
            assignBtn.Text = "None"
            assignBtn.TextColor3 = Theme.textMuted
        end)
    end

    -- ========================================================================
    -- ADD CUSTOM ANIMATION MODAL (root.73.124 @ PC 1528..2680)
    -- ========================================================================
    addCustomModal = Instance.new("Frame")
    addCustomModal.Name = "AddCustomModal"
    addCustomModal.Size = UDim2.new(1, 0, 1, 0)
    addCustomModal.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    addCustomModal.BackgroundTransparency = 0.4
    addCustomModal.BorderSizePixel = 0
    addCustomModal.ZIndex = 50
    addCustomModal.Visible = false
    addCustomModal.Parent = embedFrame

    local customModalCard = Instance.new("Frame")
    customModalCard.Size = UDim2.new(0, 330, 0, 380)
    customModalCard.Position = UDim2.new(0.5, -165, 0.5, -190)
    customModalCard.BackgroundColor3 = Theme.bgCard
    customModalCard.BorderSizePixel = 0
    customModalCard.ZIndex = 51
    customModalCard.Parent = addCustomModal
    addCorner(customModalCard, 10)
    addStroke(customModalCard, Theme.border, 1.5, 0)

    local customModalTitle = Instance.new("TextLabel")
    customModalTitle.Size = UDim2.new(1, -50, 0, 36)
    customModalTitle.Position = UDim2.new(0, 14, 0, 6)
    customModalTitle.BackgroundTransparency = 1
    customModalTitle.Text = "Add Custom Animation"
    customModalTitle.TextColor3 = Theme.text
    customModalTitle.Font = Enum.Font.GothamBlack
    customModalTitle.TextSize = 12
    customModalTitle.TextXAlignment = Enum.TextXAlignment.Left
    customModalTitle.ZIndex = 52
    customModalTitle.Parent = customModalCard

    local customModalCloseBtn = Instance.new("TextButton")
    customModalCloseBtn.Size = UDim2.new(0, 24, 0, 24)
    customModalCloseBtn.Position = UDim2.new(1, -34, 0, 10)
    customModalCloseBtn.BackgroundColor3 = Theme.surface
    customModalCloseBtn.Text = "✕"
    customModalCloseBtn.TextColor3 = Theme.textMuted
    customModalCloseBtn.Font = Enum.Font.GothamBold
    customModalCloseBtn.TextSize = 11
    customModalCloseBtn.ZIndex = 52
    customModalCloseBtn.Parent = customModalCard
    addCorner(customModalCloseBtn, 12)

    local customNameInput = Instance.new("TextBox")
    customNameInput.Size = UDim2.new(1, -28, 0, 28)
    customNameInput.Position = UDim2.new(0, 14, 0, 44)
    customNameInput.BackgroundColor3 = Theme.input
    customNameInput.PlaceholderText = "Animation Name (optional)"
    customNameInput.PlaceholderColor3 = Theme.textMuted
    customNameInput.Text = ""
    customNameInput.TextColor3 = Theme.text
    customNameInput.Font = Enum.Font.GothamMedium
    customNameInput.TextSize = 11
    customNameInput.TextXAlignment = Enum.TextXAlignment.Left
    customNameInput.ClearTextOnFocus = false
    customNameInput.ZIndex = 52
    customNameInput.Parent = customModalCard
    addCorner(customNameInput, 6)
    addStroke(customNameInput, Theme.divider, 1, 0)

    local customNamePad = Instance.new("UIPadding")
    customNamePad.PaddingLeft = UDim.new(0, 10)
    customNamePad.Parent = customNameInput

    local customCodeInput = Instance.new("TextBox")
    customCodeInput.Size = UDim2.new(1, -28, 0, 210)
    customCodeInput.Position = UDim2.new(0, 14, 0, 80)
    customCodeInput.BackgroundColor3 = Theme.input
    customCodeInput.PlaceholderText = "Paste keyframe script or table here...\n(Or press Ctrl+V to paste from clipboard)"
    customCodeInput.PlaceholderColor3 = Theme.textMuted
    customCodeInput.Text = ""
    customCodeInput.TextColor3 = Theme.green
    customCodeInput.Font = Enum.Font.Code
    customCodeInput.TextSize = 10
    customCodeInput.MultiLine = true
    customCodeInput.ClearTextOnFocus = false
    customCodeInput.TextWrapped = true
    customCodeInput.TextXAlignment = Enum.TextXAlignment.Left
    customCodeInput.TextYAlignment = Enum.TextYAlignment.Top
    customCodeInput.ClipsDescendants = true
    customCodeInput.ZIndex = 52
    customCodeInput.Parent = customModalCard
    addCorner(customCodeInput, 6)
    addStroke(customCodeInput, Theme.divider, 1, 0)

    local customCodePad = Instance.new("UIPadding")
    customCodePad.PaddingLeft = UDim.new(0, 8)
    customCodePad.PaddingTop = UDim.new(0, 8)
    customCodePad.PaddingRight = UDim.new(0, 8)
    customCodePad.Parent = customCodeInput

    local customModalStatus = Instance.new("TextLabel")
    customModalStatus.Size = UDim2.new(1, -28, 0, 20)
    customModalStatus.Position = UDim2.new(0, 14, 0, 298)
    customModalStatus.BackgroundTransparency = 1
    customModalStatus.Text = "Paste keyframe data or script table above."
    customModalStatus.TextColor3 = Theme.textMuted
    customModalStatus.Font = Enum.Font.Gotham
    customModalStatus.TextSize = 10
    customModalStatus.TextXAlignment = Enum.TextXAlignment.Left
    customModalStatus.ZIndex = 52
    customModalStatus.Parent = customModalCard

    local customSaveBtn = Instance.new("TextButton")
    customSaveBtn.Size = UDim2.new(1, -28, 0, 32)
    customSaveBtn.Position = UDim2.new(0, 14, 1, -44)
    customSaveBtn.BackgroundColor3 = Color3.fromRGB(24, 40, 30)
    customSaveBtn.Text = "+ Add Animation"
    customSaveBtn.TextColor3 = Theme.green
    customSaveBtn.Font = Enum.Font.GothamBold
    customSaveBtn.TextSize = 11
    customSaveBtn.ZIndex = 52
    customSaveBtn.Parent = customModalCard
    addCorner(customSaveBtn, 6)
    addStroke(customSaveBtn, Color3.fromRGB(40, 100, 60), 1, 0.4)

    -- Closure root.73.124.44: Close & reset Custom Animation Modal
    local function closeCustomModal()
        addCustomModal.Visible = false
        customNameInput.Text = ""
        customCodeInput.Text = ""
        customModalStatus.Text = "Paste keyframe data or script table above."
        customModalStatus.TextColor3 = Theme.textMuted
    end
    customModalCloseBtn.MouseButton1Click:Connect(closeCustomModal)

    -- Closure root.73.124.45: Open Custom Animation Modal
    addCustomOpenBtn.MouseButton1Click:Connect(function()
        if type(switchSubTab) == "function" then
            pcall(switchSubTab, "Custom")
        end
        addCustomModal.Visible = true
        addCustomModal.ZIndex = 100
        customModalCard.ZIndex = 101
        task.defer(function()
            pcall(function()
                customNameInput:CaptureFocus()
            end)
        end)
    end)

    -- Closure root.73.124.46..48: Ctrl+V clipboard paste support inside Custom Code Box
    local codeBoxFocused = false
    customCodeInput.Focused:Connect(function() codeBoxFocused = true end)
    customCodeInput.FocusLost:Connect(function() codeBoxFocused = false end)

    UserInputService.InputBegan:Connect(function(input)
        if not codeBoxFocused then return end
        if input.KeyCode == Enum.KeyCode.V then
            local ctrlHeld = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
                or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
            if ctrlHeld then
                task.spawn(function()
                    local clipFn = (type(getclipboard) == "function" and getclipboard)
                        or (type(getclip) == "function" and getclip)
                    if clipFn then
                        local ok, clipStr = pcall(clipFn)
                        if ok and type(clipStr) == "string" and #clipStr > 0 then
                            customCodeInput.Text = clipStr
                            customModalStatus.Text = "Loaded " .. tostring(#clipStr) .. " characters from clipboard."
                            customModalStatus.TextColor3 = Theme.green
                        end
                    end
                end)
            end
        end
    end)

    -- Closure root.73.124.49: Validate & save custom keyframe animation or URL
    customSaveBtn.MouseButton1Click:Connect(function()
        local rawCode = tostring(customCodeInput.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
        if rawCode == "" then
            customModalStatus.Text = "Paste keyframe script, table, or animation URL first!"
            customModalStatus.TextColor3 = Color3.fromRGB(255, 120, 120)
            return
        end

        local isUrl = (rawCode:sub(1, 4) == "http") or (rawCode:find("raw.githubusercontent", 1, true) ~= nil)
        local isKeyframeTable = (rawCode:find("{", 1, true) ~= nil)
            and (rawCode:find("Time%s*=") ~= nil or rawCode:find("return%s*{") ~= nil or rawCode:find("CFrame%.new") ~= nil)

        if not isUrl and not isKeyframeTable then
            customModalStatus.Text = "Invalid: paste keyframe Lua/table OR a direct .lua URL"
            customModalStatus.TextColor3 = Color3.fromRGB(255, 120, 120)
            return
        end

        savedConfig.customAnims = savedConfig.customAnims or {}
        local rawName = tostring(customNameInput.Text or ""):match("^%s*(.-)%s*$")
        if not rawName or rawName == "" then
            rawName = "Custom_" .. tostring(#savedConfig.customAnims + 1)
        end

        local function nameExists(n)
            for _, a in ipairs(allAnimations) do
                if a.name == n then return true end
            end
            for _, c in ipairs(savedConfig.customAnims) do
                if c.name == n then return true end
            end
            return false
        end

        local finalName = rawName
        local suffix = 2
        while nameExists(finalName) do
            finalName = rawName .. "_" .. tostring(suffix)
            suffix = suffix + 1
        end

        local storedPath = rawCode
        if not (rawCode:sub(1, 4) == "http") and type(writefile) == "function" then
            pcall(function()
                if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder("angoorreanim_cache") then
                    makefolder("angoorreanim_cache")
                end
            end)
            local safeFile = finalName:gsub("[^%w%._%-]", "_")
            local cacheFilePath = "angoorreanim_cache/Custom_" .. safeFile .. ".lua"
            local okWrite = pcall(writefile, cacheFilePath, rawCode)
            if okWrite then
                storedPath = cacheFilePath
            end
        end

        table.insert(savedConfig.customAnims, {
            name   = finalName,
            script = storedPath,
        })
        local okSave = pcall(saveConfig)
        if not okSave then
            customModalStatus.Text = "Saved in session (writefile unavailable)"
            customModalStatus.TextColor3 = Theme.warning
        end

        table.insert(allAnimations, {
            name     = finalName,
            path     = storedPath,
            category = "Custom",
            isCustom = true,
        })
        setSortedAnimations(allAnimations)

        activeSubTab = "Custom"
        if type(switchSubTab) == "function" then
            pcall(switchSubTab, "Custom")
        end
        if type(populateList) == "function" then
            pcall(populateList)
        end
        closeCustomModal()
        if type(updateNowPlayingUI) == "function" then
            pcall(updateNowPlayingUI, nil)
        end
        customModalStatus.Text = "Added: " .. finalName
        customModalStatus.TextColor3 = Theme.green
        print("[ANGOOR] custom anim saved:", finalName, (rawCode:sub(1, 4) == "http") and "(url)" or "(inline)", #rawCode, "chars")
    end)

    -- ========================================================================
    -- 5. LIMBS PAGE (Master Limbs Switch + 6 Individual Body Part Switches)
    -- ========================================================================
    local limbsPage = Instance.new("ScrollingFrame")
    limbsPage.Size = UDim2.new(1, 0, 1, 0)
    limbsPage.BackgroundTransparency = 1
    limbsPage.BorderSizePixel = 0
    limbsPage.ScrollBarThickness = 3
    limbsPage.ScrollBarImageColor3 = Theme.accent
    limbsPage.ScrollBarImageTransparency = 0.6
    pcall(function()
        limbsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
    end)
    limbsPage.CanvasSize = UDim2.new(0, 0, 0, 420)
    limbsPage.Visible = false
    limbsPage.Parent = pagesHolder

    local limbsPad = Instance.new("UIPadding")
    limbsPad.PaddingLeft = UDim.new(0, 2)
    limbsPad.PaddingRight = UDim.new(0, 4)
    limbsPad.PaddingTop = UDim.new(0, 2)
    limbsPad.PaddingBottom = UDim.new(0, 12)
    limbsPad.Parent = limbsPage

    local limbsLayout = Instance.new("UIListLayout")
    limbsLayout.Padding = UDim.new(0, 8)
    limbsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    limbsLayout.Parent = limbsPage

    local limbsTitleLbl = Instance.new("TextLabel")
    limbsTitleLbl.Size = UDim2.new(1, 0, 0, 16)
    limbsTitleLbl.BackgroundTransparency = 1
    limbsTitleLbl.Text = "LIMB & BODY VISIBILITY"
    limbsTitleLbl.TextColor3 = Theme.textMuted
    limbsTitleLbl.Font = Enum.Font.GothamBold
    limbsTitleLbl.TextSize = 10
    limbsTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    limbsTitleLbl.LayoutOrder = 1
    limbsTitleLbl.Parent = limbsPage

    -- Closure root.73.124.56: Create pill toggle switch widget
    local function createLimbToggleSwitch(parentFrame, xOffset, yOffset)
        local track = Instance.new("Frame", parentFrame)
        track.Size = UDim2.new(0, 44, 0, 22)
        track.Position = UDim2.new(1, xOffset or -54, 0.5, yOffset or -11)
        track.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        track.BackgroundTransparency = 0.5
        track.BorderSizePixel = 0
        addCorner(track, 100)

        local trackStroke = Instance.new("UIStroke", track)
        trackStroke.Color = Color3.fromRGB(255, 255, 255)
        trackStroke.Thickness = 1
        trackStroke.Transparency = 0.85

        local knob = Instance.new("Frame", track)
        knob.Size = UDim2.new(0, 16, 0, 16)
        knob.Position = UDim2.new(0, 3, 0.5, -8)
        knob.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        knob.BorderSizePixel = 0
        addCorner(knob, 100)

        local knobGrad = Instance.new("UIGradient", knob)
        knobGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150)),
        })
        knobGrad.Rotation = 90

        local knobStroke = Instance.new("UIStroke", knob)
        knobStroke.Color = Color3.fromRGB(255, 255, 255)
        knobStroke.Thickness = 1
        knobStroke.Transparency = 0.5

        local glowFrame = Instance.new("Frame", knob)
        glowFrame.Size = UDim2.new(1, 0, 1, 0)
        glowFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        glowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        glowFrame.BackgroundTransparency = 1
        glowFrame.ZIndex = knob.ZIndex - 1
        addCorner(glowFrame, 100)

        local glowStroke = Instance.new("UIStroke", glowFrame)
        glowStroke.Color = Color3.fromRGB(80, 220, 140)
        glowStroke.Thickness = 5
        glowStroke.Transparency = 1

        return track, knob, glowStroke
    end

    -- Closure root.73.124.57: Set pill switch visual state
    local function setSwitchVisual(track, knob, glowStroke, isOn, animate)
        local bgCol   = isOn and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(15, 15, 15)
        local knobCol = isOn and Color3.fromRGB(80, 220, 140) or Color3.fromRGB(100, 100, 100)
        local knobPos = isOn and UDim2.new(0, 25, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        local glowTr  = isOn and 0.65 or 1

        if animate then
            playTween(track, { BackgroundColor3 = bgCol }, 0.25)
            playTween(knob, { BackgroundColor3 = knobCol, Position = knobPos }, 0.25, Enum.EasingStyle.Back)
            if glowStroke then
                playTween(glowStroke, { Transparency = glowTr }, 0.25)
            end
        else
            track.BackgroundColor3 = bgCol
            knob.BackgroundColor3 = knobCol
            knob.Position = knobPos
            if glowStroke then
                glowStroke.Transparency = glowTr
            end
        end
    end

    -- Master Limbs Card
    local masterLimbCard = Instance.new("Frame")
    masterLimbCard.Size = UDim2.new(1, 0, 0, 46)
    masterLimbCard.BackgroundColor3 = Theme.surface
    masterLimbCard.BorderSizePixel = 0
    masterLimbCard.LayoutOrder = 2
    masterLimbCard.Parent = limbsPage
    addCorner(masterLimbCard, 10)

    local masterStroke = Instance.new("UIStroke", masterLimbCard)
    masterStroke.Color = Color3.fromRGB(255, 255, 255)
    masterStroke.Thickness = 1
    masterStroke.Transparency = 0.88

    local masterTextWrap = Instance.new("Frame")
    masterTextWrap.Size = UDim2.new(1, -125, 1, 0)
    masterTextWrap.Position = UDim2.new(0, 14, 0, 0)
    masterTextWrap.BackgroundTransparency = 1
    masterTextWrap.Parent = masterLimbCard

    local masterTitle = Instance.new("TextLabel")
    masterTitle.Size = UDim2.new(1, 0, 0, 20)
    masterTitle.Position = UDim2.new(0, 0, 0, 5)
    masterTitle.BackgroundTransparency = 1
    masterTitle.Text = "Master Limbs Switch"
    masterTitle.TextColor3 = Color3.fromRGB(245, 245, 250)
    masterTitle.Font = Enum.Font.GothamBlack
    masterTitle.TextSize = 11
    masterTitle.TextXAlignment = Enum.TextXAlignment.Left
    masterTitle.Parent = masterTextWrap

    local masterSub = Instance.new("TextLabel")
    masterSub.Size = UDim2.new(1, 0, 0, 16)
    masterSub.Position = UDim2.new(0, 0, 0, 23)
    masterSub.BackgroundTransparency = 1
    masterSub.Text = "Toggle all body parts on or off at once"
    masterSub.TextColor3 = Theme.textMuted
    masterSub.Font = Enum.Font.Gotham
    masterSub.TextSize = 9
    masterSub.TextXAlignment = Enum.TextXAlignment.Left
    masterSub.TextTruncate = Enum.TextTruncate.AtEnd
    masterSub.Parent = masterTextWrap

    local masterStatusLbl = Instance.new("TextLabel")
    masterStatusLbl.Size = UDim2.new(0, 54, 1, 0)
    masterStatusLbl.Position = UDim2.new(1, -114, 0, 0)
    masterStatusLbl.BackgroundTransparency = 1
    masterStatusLbl.Font = Enum.Font.GothamBold
    masterStatusLbl.TextSize = 9
    masterStatusLbl.TextXAlignment = Enum.TextXAlignment.Right
    masterStatusLbl.Text = "ALL SHOWN"
    masterStatusLbl.TextColor3 = Color3.fromRGB(80, 220, 140)
    masterStatusLbl.Parent = masterLimbCard

    local masterTrack, masterKnob, masterGlow = createLimbToggleSwitch(masterLimbCard, -54, -11)

    local masterHitBtn = Instance.new("TextButton")
    masterHitBtn.Size = UDim2.new(1, 0, 1, 0)
    masterHitBtn.BackgroundTransparency = 1
    masterHitBtn.Text = ""
    masterHitBtn.ZIndex = 5
    masterHitBtn.Parent = masterLimbCard

    masterHitBtn.MouseEnter:Connect(function()
        playTween(masterLimbCard, { BackgroundColor3 = Theme.surfaceHover }, 0.2)
    end)
    masterHitBtn.MouseLeave:Connect(function()
        playTween(masterLimbCard, { BackgroundColor3 = Theme.surface }, 0.2)
    end)

    local indivHeaderWrap = Instance.new("Frame")
    indivHeaderWrap.Size = UDim2.new(1, 0, 0, 18)
    indivHeaderWrap.BackgroundTransparency = 1
    indivHeaderWrap.LayoutOrder = 3
    indivHeaderWrap.Parent = limbsPage

    local indivHeaderLbl = Instance.new("TextLabel")
    indivHeaderLbl.Size = UDim2.new(1, 0, 1, 0)
    indivHeaderLbl.BackgroundTransparency = 1
    indivHeaderLbl.Text = "INDIVIDUAL BODY PARTS"
    indivHeaderLbl.TextColor3 = Theme.textDim
    indivHeaderLbl.Font = Enum.Font.GothamBold
    indivHeaderLbl.TextSize = 9
    indivHeaderLbl.TextXAlignment = Enum.TextXAlignment.Left
    indivHeaderLbl.Parent = indivHeaderWrap

    -- 6 Limb Definitions (root.73.124 @ PC 7625..7832)
    local LIMB_GROUPS = {
        {
            id    = "Head",
            name  = "Head (Face, Hats, Nametag)",
            desc  = "Hides head, all hats, hair, face decals & player billboard",
            parts = { "Head" },
        },
        {
            id    = "Torso",
            name  = "Torso",
            desc  = "Hides main body (Torso, UpperTorso, LowerTorso)",
            parts = { "Torso", "UpperTorso", "LowerTorso" },
        },
        {
            id    = "Left Arm",
            name  = "Left Arm",
            desc  = "Hides Left Arm / UpperArm / LowerArm / LeftHand",
            parts = { "Left Arm", "LeftUpperArm", "LeftLowerArm", "LeftHand" },
        },
        {
            id    = "Right Arm",
            name  = "Right Arm",
            desc  = "Hides Right Arm / UpperArm / LowerArm / RightHand",
            parts = { "Right Arm", "RightUpperArm", "RightLowerArm", "RightHand" },
        },
        {
            id    = "Left Leg",
            name  = "Left Leg",
            desc  = "Hides Left Leg / UpperLeg / LowerLeg / LeftFoot",
            parts = { "Left Leg", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot" },
        },
        {
            id    = "Right Leg",
            name  = "Right Leg",
            desc  = "Hides Right Leg / UpperLeg / LowerLeg / RightFoot",
            parts = { "Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot" },
        },
    }

    local limbRowWidgets = {}

    local function isPartHidden(partName)
        if savedConfig.hiddenLimbs and savedConfig.hiddenLimbs[partName] then
            return true
        end
        if _G.hiddenBodyParts and _G.hiddenBodyParts[partName] then
            return true
        end
        return false
    end

    local function isGroupHidden(group)
        for _, pName in ipairs(group.parts) do
            if isPartHidden(pName) then
                return true
            end
        end
        return false
    end

    -- Closure root.73.124.60: Update Master Limbs switch state
    local function updateMasterLimbSwitch(animate)
        local hiddenCount = 0
        for _, grp in ipairs(LIMB_GROUPS) do
            if isGroupHidden(grp) then
                hiddenCount = hiddenCount + 1
            end
        end
        if hiddenCount == 0 then
            masterStatusLbl.Text = "ALL SHOWN"
            masterStatusLbl.TextColor3 = Color3.fromRGB(80, 220, 140)
            setSwitchVisual(masterTrack, masterKnob, masterGlow, true, animate)
        elseif hiddenCount == #LIMB_GROUPS then
            masterStatusLbl.Text = "ALL HIDDEN"
            masterStatusLbl.TextColor3 = Color3.fromRGB(235, 75, 75)
            setSwitchVisual(masterTrack, masterKnob, masterGlow, false, animate)
        else
            masterStatusLbl.Text = "CUSTOM"
            masterStatusLbl.TextColor3 = Color3.fromRGB(240, 180, 60)
            local bgCol   = Color3.fromRGB(18, 18, 22)
            local knobCol = Color3.fromRGB(140, 140, 150)
            local knobPos = UDim2.new(0, 3, 0.5, -8)
            if animate then
                playTween(masterTrack, { BackgroundColor3 = bgCol }, 0.25)
                playTween(masterKnob, { BackgroundColor3 = knobCol, Position = knobPos }, 0.25, Enum.EasingStyle.Back)
                if masterGlow then playTween(masterGlow, { Transparency = 1 }, 0.25) end
            else
                masterTrack.BackgroundColor3 = bgCol
                masterKnob.BackgroundColor3 = knobCol
                masterKnob.Position = knobPos
                if masterGlow then masterGlow.Transparency = 1 end
            end
        end
    end

    -- Closure root.73.124.61: Set individual limb group hidden/shown
    local function setLimbGroupHidden(group, hideBool, skipMasterUpdate, animate)
        if animate == nil then animate = true end
        for _, partName in ipairs(group.parts) do
            if hideBool then
                _G.hiddenBodyParts[partName] = true
                savedConfig.hiddenLimbs[partName] = true
            else
                _G.hiddenBodyParts[partName] = nil
                savedConfig.hiddenLimbs[partName] = nil
            end
        end
        saveConfig()
        local w = limbRowWidgets[group.id]
        if w then
            local shown = not hideBool
            w.statusLbl.Text = shown and "VISIBLE" or "HIDDEN"
            w.statusLbl.TextColor3 = shown and Color3.fromRGB(80, 220, 140) or Color3.fromRGB(235, 75, 75)
            setSwitchVisual(w.track, w.knob, w.glowStroke, shown, animate)
        end
        if not skipMasterUpdate then
            updateMasterLimbSwitch(true)
        end
    end

    -- Closure root.73.124.62: Master Limbs toggle click
    masterHitBtn.MouseButton1Click:Connect(function()
        local hiddenCount = 0
        for _, grp in ipairs(LIMB_GROUPS) do
            if isGroupHidden(grp) then
                hiddenCount = hiddenCount + 1
            end
        end
        local hideAll = (hiddenCount == 0)
        for _, grp in ipairs(LIMB_GROUPS) do
            setLimbGroupHidden(grp, hideAll, true, true)
        end
        updateMasterLimbSwitch(true)
    end)

    -- Create individual limb cards
    for idx, grp in ipairs(LIMB_GROUPS) do
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, 0, 0, 44)
        card.BackgroundColor3 = Theme.surface
        card.BorderSizePixel = 0
        card.LayoutOrder = 3 + idx
        card.Parent = limbsPage
        addCorner(card, 10)

        local st = Instance.new("UIStroke", card)
        st.Color = Color3.fromRGB(255, 255, 255)
        st.Thickness = 1
        st.Transparency = 0.9

        local textWrap = Instance.new("Frame")
        textWrap.Size = UDim2.new(1, -125, 1, 0)
        textWrap.Position = UDim2.new(0, 14, 0, 0)
        textWrap.BackgroundTransparency = 1
        textWrap.Parent = card

        local titleLbl = Instance.new("TextLabel")
        titleLbl.Size = UDim2.new(1, 0, 0, 20)
        titleLbl.Position = UDim2.new(0, 0, 0, 5)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Text = grp.name
        titleLbl.TextColor3 = Color3.fromRGB(240, 240, 248)
        titleLbl.Font = Enum.Font.GothamBold
        titleLbl.TextSize = 11
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Parent = textWrap

        local descLbl = Instance.new("TextLabel")
        descLbl.Size = UDim2.new(1, 0, 0, 16)
        descLbl.Position = UDim2.new(0, 0, 0, 23)
        descLbl.BackgroundTransparency = 1
        descLbl.Text = grp.desc
        descLbl.TextColor3 = Theme.textMuted
        descLbl.Font = Enum.Font.Gotham
        descLbl.TextSize = 9
        descLbl.TextXAlignment = Enum.TextXAlignment.Left
        descLbl.TextTruncate = Enum.TextTruncate.AtEnd
        descLbl.Parent = textWrap

        local currentlyHidden = isGroupHidden(grp)
        local statusLbl = Instance.new("TextLabel")
        statusLbl.Size = UDim2.new(0, 52, 1, 0)
        statusLbl.Position = UDim2.new(1, -112, 0, 0)
        statusLbl.BackgroundTransparency = 1
        statusLbl.Font = Enum.Font.GothamBold
        statusLbl.TextSize = 9
        statusLbl.TextXAlignment = Enum.TextXAlignment.Right
        statusLbl.Text = currentlyHidden and "HIDDEN" or "VISIBLE"
        statusLbl.TextColor3 = currentlyHidden and Color3.fromRGB(235, 75, 75) or Color3.fromRGB(80, 220, 140)
        statusLbl.Parent = card

        local trk, knb, glw = createLimbToggleSwitch(card, -54, -11)
        setSwitchVisual(trk, knb, glw, not currentlyHidden, false)

        local hitBtn = Instance.new("TextButton")
        hitBtn.Size = UDim2.new(1, 0, 1, 0)
        hitBtn.BackgroundTransparency = 1
        hitBtn.Text = ""
        hitBtn.ZIndex = 5
        hitBtn.Parent = card

        hitBtn.MouseEnter:Connect(function()
            playTween(card, { BackgroundColor3 = Theme.surfaceHover }, 0.2)
        end)
        hitBtn.MouseLeave:Connect(function()
            playTween(card, { BackgroundColor3 = Theme.surface }, 0.2)
        end)

        limbRowWidgets[grp.id] = {
            statusLbl  = statusLbl,
            track      = trk,
            knob       = knb,
            glowStroke = glw,
        }

        hitBtn.MouseButton1Click:Connect(function()
            local nowHidden = isGroupHidden(grp)
            setLimbGroupHidden(grp, not nowHidden, false, true)
        end)
    end

    -- Closure root.73.124.66: Sync all limb switches from state
    syncLimbsUIFromState = function()
        for _, grp in ipairs(LIMB_GROUPS) do
            local hid = isGroupHidden(grp)
            local w = limbRowWidgets[grp.id]
            if w then
                local shown = not hid
                w.statusLbl.Text = shown and "VISIBLE" or "HIDDEN"
                w.statusLbl.TextColor3 = shown and Color3.fromRGB(80, 220, 140) or Color3.fromRGB(235, 75, 75)
                setSwitchVisual(w.track, w.knob, w.glowStroke, shown, false)
            end
        end
        updateMasterLimbSwitch(false)
    end

    -- Closure root.73.124.67: RenderStepped Limb Hider on Reanim Clone
    RunService.RenderStepped:Connect(function()
        if not zenApi or type(zenApi.get_clone) ~= "function" then return end
        local cloneChar = zenApi.get_clone()
        if not cloneChar then return end
        if not _G.hiddenBodyParts or next(_G.hiddenBodyParts) == nil then return end

        for partName, isHid in pairs(_G.hiddenBodyParts) do
            if isHid then
                local part = cloneChar:FindFirstChild(partName)
                if part and part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 1
                    part.Transparency = 1
                end
                if partName == "Head" then
                    for _, desc in ipairs(cloneChar:GetDescendants()) do
                        if desc:IsA("Decal") then
                            desc.Transparency = 1
                        elseif desc:IsA("Accessory") then
                            local handle = desc:FindFirstChild("Handle")
                            if handle and handle:IsA("BasePart") then
                                handle.LocalTransparencyModifier = 1
                                handle.Transparency = 1
                            end
                        end
                    end
                    local hum = cloneChar:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum.DisplayName = ""
                        hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
                        hum.NameDisplayDistance = 100
                        hum.HealthDisplayDistance = 100
                    end
                end
            end
        end
    end)

    limbsPage.CanvasSize = UDim2.new(0, 0, 0, (#LIMB_GROUPS * 56) + 80)

    -- ========================================================================
    -- ANIMATION LIST POPULATOR & PLAYBACK ENGINE (root.73.124.68 .. 72)
    -- ========================================================================
    local ROW_HEIGHT         = 38
    local pendingAnimBindObj = nil
    local selectedAnimName   = nil
    local renderedRowMap     = {}

    -- Closure root.73.124.68: Play or toggle an animation entry
    local function playOrToggleAnimation(animEntry)
        local reanimated = false
        if zenApi and type(zenApi.is_reanimated) == "function" then
            pcall(function() reanimated = zenApi.is_reanimated() end)
        end
        if not reanimated then
            warn("Zen Reanimations: Enable Reanimation first to play animations!")
            return
        end
        if not animEntry or not animEntry.path then
            warn("Zen Reanimations: Invalid animation entry")
            return
        end

        if nowPlayingName == animEntry.name then
            isPlayingManual = false
            nowPlayingName = nil
            if zenApi and type(zenApi.stop_animation) == "function" then
                pcall(zenApi.stop_animation)
            end
            selectedAnimName = nil
            updateNowPlayingUI(nil)
            return
        end

        isPlayingManual = true
        selectedAnimName = animEntry.name
        nowPlayingName = animEntry.name
        updateNowPlayingUI("Loading " .. tostring(animEntry.name) .. "...")

        task.spawn(function()
            if zenApi and type(zenApi.stop_animation) == "function" then
                pcall(zenApi.stop_animation)
            end
            task.wait()

            local playPath = animEntry.path
            if type(playPath) == "string" and playPath:sub(1, 4) ~= "http" and #playPath > 800 and not playPath:find("angoorreanim_cache", 1, true) then
                if type(writefile) == "function" then
                    pcall(function()
                        if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder("angoorreanim_cache") then
                            makefolder("angoorreanim_cache")
                        end
                        local safeName = tostring(animEntry.name):gsub("[^%w%._%-]", "_")
                        local cachedPath = "angoorreanim_cache/Custom_" .. safeName .. ".lua"
                        writefile(cachedPath, playPath)
                        playPath = cachedPath
                        animEntry.path = cachedPath
                        for _, c in ipairs(savedConfig.customAnims or {}) do
                            if c.name == animEntry.name then
                                c.script = cachedPath
                            end
                        end
                        pcall(saveConfig)
                    end)
                end
            end

            local res = zenApi.play_animation(playPath, currentSpeed)
            if type(res) == "string" then
                warn("Zen Reanimations Error:", res)
                task.wait(0.05)
                local retryRes = zenApi.play_animation(playPath, currentSpeed)
                if type(retryRes) == "string" then
                    warn("Zen Reanimations Error (retry):", retryRes)
                    isPlayingManual = false
                    nowPlayingName = nil
                    selectedAnimName = nil
                    updateNowPlayingUI(nil)
                    return
                end
            end
            nowPlayingName = animEntry.name
            selectedAnimName = animEntry.name
            updateNowPlayingUI(animEntry.name)
        end)
    end

    -- Closure root.73.124.69: Populate Fun / Favs / Custom animation list
    populateList = function()
        for _, child in ipairs(animListScroll:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        table.clear(renderedRowMap)

        local query = tostring(searchBox.Text or ""):lower()
        local filtered = {}

        for _, item in ipairs(allAnimations) do
            local isCust = (item.isCustom == true) or (item.category == "Custom")
            if activeSubTab == "Favs" then
                if savedConfig.favs[item.name] and (query == "" or item.name:lower():find(query, 1, true)) then
                    table.insert(filtered, item)
                end
            elseif activeSubTab == "Custom" then
                -- Custom tab removed — skip
            else
                if item.category ~= "Recorded" and (query == "" or item.name:lower():find(query, 1, true)) then
                    table.insert(filtered, item)
                end
            end
        end

        if activeSubTab == "Favs" then
            emptyFavsLabel.Visible = (#filtered == 0)
            emptyCustomLabel.Visible = false
        elseif activeSubTab == "Custom" then
            emptyFavsLabel.Visible = false
            emptyCustomLabel.Visible = (#filtered == 0)
        else
            emptyFavsLabel.Visible = false
            emptyCustomLabel.Visible = false
        end

        local defaultPageSize = 100
        if query ~= "" then
            listShowCount = #filtered
        else
            if not listShowCount or listShowCount < defaultPageSize then
                listShowCount = defaultPageSize
            end
        end

        local showCount = math.min(listShowCount, #filtered)
        for i = 1, showCount do
            if i % 20 == 0 then
                task.wait()
            end
            local animEntry = filtered[i]
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, -6, 0, ROW_HEIGHT)
            row.BackgroundColor3 = Theme.surface
            row.BorderSizePixel = 0
            row.LayoutOrder = i
            row.Parent = animListScroll
            addCorner(row, 6)

            local isSel = (selectedAnimName == animEntry.name)
            local rowStroke = addStroke(
                row,
                isSel and Theme.accent or Theme.divider,
                1,
                isSel and 0 or 0.5
            )

            -- Favorite Star Button
            local starBtn = Instance.new("TextButton")
            starBtn.Size = UDim2.new(0, 24, 1, 0)
            starBtn.Position = UDim2.new(0, 4, 0, 0)
            starBtn.BackgroundTransparency = 1
            local isFav = savedConfig.favs[animEntry.name] == true
            starBtn.Text = isFav and "★" or "☆"
            starBtn.TextColor3 = isFav and Color3.fromRGB(255, 215, 0) or Theme.textMuted
            starBtn.Font = Enum.Font.GothamBold
            starBtn.TextSize = 14
            starBtn.Parent = row

            starBtn.MouseButton1Click:Connect(function()
                if savedConfig.favs[animEntry.name] then
                    savedConfig.favs[animEntry.name] = nil
                    starBtn.Text = "☆"
                    starBtn.TextColor3 = Theme.textMuted
                else
                    savedConfig.favs[animEntry.name] = true
                    starBtn.Text = "★"
                    starBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
                end
                saveConfig()
                if activeSubTab == "Favs" then
                    populateList()
                end
            end)

            local isCustomEntry = (animEntry.isCustom == true) or (animEntry.category == "Custom") or (animEntry.category == "Recorded")
            local nameBtn = Instance.new("TextButton")
            nameBtn.Size = UDim2.new(1, isCustomEntry and -108 or -78, 1, 0)
            nameBtn.Position = UDim2.new(0, 30, 0, 0)
            nameBtn.BackgroundTransparency = 1
            nameBtn.RichText = true
            if isCustomEntry then
                nameBtn.Text = animEntry.name .. ' <font color="rgb(80,210,255)">[CUSTOM]</font>'
            else
                nameBtn.Text = animEntry.name
            end
            nameBtn.TextColor3 = isSel and Theme.accent or Theme.text
            nameBtn.Font = isSel and Enum.Font.GothamBold or Enum.Font.GothamMedium
            nameBtn.TextSize = 11
            nameBtn.TextXAlignment = Enum.TextXAlignment.Left
            nameBtn.TextTruncate = Enum.TextTruncate.AtEnd
            nameBtn.Parent = row

            renderedRowMap[animEntry.name] = {
                stroke = rowStroke,
                btn    = nameBtn,
                star   = starBtn,
            }

            nameBtn.MouseEnter:Connect(function()
                if selectedAnimName ~= animEntry.name then
                    playTween(row, { BackgroundColor3 = Theme.surfaceHover }, 0.15)
                end
            end)
            nameBtn.MouseLeave:Connect(function()
                if selectedAnimName ~= animEntry.name then
                    playTween(row, { BackgroundColor3 = Theme.surface }, 0.15)
                end
            end)
            nameBtn.MouseButton1Click:Connect(function()
                playOrToggleAnimation(animEntry)
                for entryName, widgets in pairs(renderedRowMap) do
                    local active = (selectedAnimName == entryName)
                    widgets.stroke.Color = active and Theme.accent or Theme.divider
                    widgets.stroke.Transparency = active and 0 or 0.5
                    widgets.btn.TextColor3 = active and Theme.accent or Theme.text
                    widgets.btn.Font = active and Enum.Font.GothamBold or Enum.Font.GothamMedium
                end
            end)

            -- Keybind Button
            local curBind = savedConfig.binds[animEntry.name]
            local bindBtn = Instance.new("TextButton")
            bindBtn.Size = UDim2.new(0, 38, 0, 22)
            bindBtn.Position = UDim2.new(1, isCustomEntry and -72 or -44, 0.5, -11)
            bindBtn.BackgroundColor3 = Theme.input
            bindBtn.Text = curBind and ("[" .. curBind .. "]") or "[+]"
            bindBtn.TextColor3 = curBind and Theme.accent or Theme.textMuted
            bindBtn.Font = Enum.Font.GothamSemibold
            bindBtn.TextSize = 10
            bindBtn.Parent = row
            addCorner(bindBtn, 4)
            addStroke(bindBtn, Theme.divider, 1, 0)

            bindBtn.MouseButton1Click:Connect(function()
                if pendingAnimBindObj and pendingAnimBindObj.name == animEntry.name then
                    pendingAnimBindObj = nil
                    local b = savedConfig.binds[animEntry.name]
                    bindBtn.Text = b and ("[" .. b .. "]") or "[+]"
                    bindBtn.TextColor3 = b and Theme.accent or Theme.textMuted
                else
                    pendingAnimBindObj = { name = animEntry.name, btn = bindBtn }
                    bindBtn.Text = "[?]"
                    bindBtn.TextColor3 = Color3.fromRGB(255, 180, 50)
                end
            end)

            -- Delete Custom Animation Button
            if isCustomEntry then
                local delBtn = Instance.new("TextButton")
                delBtn.Size = UDim2.new(0, 24, 0, 22)
                delBtn.Position = UDim2.new(1, -28, 0.5, -11)
                delBtn.BackgroundColor3 = Theme.surface
                delBtn.Text = "✕"
                delBtn.TextColor3 = Theme.textMuted
                delBtn.Font = Enum.Font.GothamBold
                delBtn.TextSize = 10
                delBtn.Parent = row
                addCorner(delBtn, 4)
                addStroke(delBtn, Theme.divider, 1, 0)

                delBtn.MouseButton1Click:Connect(function()
                    for idxAll = #allAnimations, 1, -1 do
                        if allAnimations[idxAll].name == animEntry.name then
                            table.remove(allAnimations, idxAll)
                        end
                    end
                    for idxCust = #savedConfig.customAnims, 1, -1 do
                        if savedConfig.customAnims[idxCust].name == animEntry.name then
                            table.remove(savedConfig.customAnims, idxCust)
                        end
                    end
                    savedConfig.favs[animEntry.name] = nil
                    savedConfig.binds[animEntry.name] = nil
                    saveConfig()
                    populateList()
                end)
            end
        end

        if showCount < #filtered and query == "" then
            local moreBtn = Instance.new("TextButton")
            moreBtn.Size = UDim2.new(1, -6, 0, 40)
            moreBtn.BackgroundColor3 = Theme.bgCard
            moreBtn.Text = "Scroll for more  ·  " .. tostring(showCount) .. "/" .. tostring(#filtered)
            moreBtn.TextColor3 = Theme.textMuted
            moreBtn.Font = Enum.Font.GothamMedium
            moreBtn.TextSize = 11
            moreBtn.LayoutOrder = showCount + 1
            moreBtn.Parent = animListScroll
            addCorner(moreBtn, 8)
            addStroke(moreBtn, Theme.divider, 1, 0.3)

            moreBtn.MouseButton1Click:Connect(function()
                listShowCount = (listShowCount or defaultPageSize) + defaultPageSize
                moreBtn.Text = "Loading..."
                task.defer(populateList)
            end)
        end

        local extraSpace = (showCount < #filtered and query == "") and 48 or 8
        animListScroll.CanvasSize = UDim2.new(0, 0, 0, math.max(showCount, 1) * (ROW_HEIGHT + 4) + extraSpace)
    end

    -- Closure root.73.124.70: Infinite scroll pagination on animListScroll
    local loadingMorePage = false
    animListScroll:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        if loadingMorePage then return end
        local q = tostring(searchBox.Text or ""):lower()
        if q ~= "" then return end
        if activeSubTab == "Favs" or activeSubTab == "Custom" then return end
        if animListScroll.CanvasSize.Y.Offset <= animListScroll.AbsoluteSize.Y + 4 then return end
        if animListScroll.CanvasPosition.Y >= (animListScroll.CanvasSize.Y.Offset - animListScroll.AbsoluteSize.Y - 80) then
            loadingMorePage = true
            listShowCount = (listShowCount or 100) + 100
            task.defer(function()
                pcall(populateList)
                loadingMorePage = false
            end)
        end
    end)

    -- Closure root.73.124.71: Debounced search input handler
    local searchGeneration = 0
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        searchGeneration = searchGeneration + 1
        local myGen = searchGeneration
        listShowCount = 100
        task.delay(0.18, function()
            if searchGeneration == myGen then
                pcall(populateList)
            end
        end)
    end)

    -- Closure root.73.124.72: Refresh Binds Tab
    refreshBindsTab = function()
        for _, child in ipairs(bindsPage:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        local bindEntries = {}
        for animName, keyName in pairs(savedConfig.binds) do
            local matchedPath = nil
            for _, item in ipairs(allAnimations) do
                if item.name == animName then
                    matchedPath = item.path
                    break
                end
            end
            if matchedPath then
                table.insert(bindEntries, {
                    name = animName,
                    path = matchedPath,
                    key  = keyName,
                })
            end
        end
        table.sort(bindEntries, function(a, b)
            return a.name:lower() < b.name:lower()
        end)
        emptyBindsLabel.Visible = (#bindEntries == 0)

        for idx, entry in ipairs(bindEntries) do
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, -6, 0, 36)
            row.BackgroundColor3 = Theme.surface
            row.BorderSizePixel = 0
            row.LayoutOrder = idx + 1
            row.Parent = bindsPage
            addCorner(row, 6)
            addStroke(row, Theme.divider, 1, 0.4)

            local playBtn = Instance.new("TextButton")
            playBtn.Size = UDim2.new(1, -120, 1, 0)
            playBtn.Position = UDim2.new(0, 12, 0, 0)
            playBtn.BackgroundTransparency = 1
            playBtn.Text = entry.name
            playBtn.TextColor3 = Theme.text
            playBtn.Font = Enum.Font.GothamMedium
            playBtn.TextSize = 11
            playBtn.TextXAlignment = Enum.TextXAlignment.Left
            playBtn.TextTruncate = Enum.TextTruncate.AtEnd
            playBtn.Parent = row

            playBtn.MouseButton1Click:Connect(function()
                playOrToggleAnimation(entry)
            end)

            local keyBtn = Instance.new("TextButton")
            keyBtn.Size = UDim2.new(0, 48, 0, 24)
            keyBtn.Position = UDim2.new(1, -100, 0.5, -12)
            keyBtn.BackgroundColor3 = Theme.input
            keyBtn.Text = "[" .. tostring(entry.key) .. "]"
            keyBtn.TextColor3 = Theme.accent
            keyBtn.Font = Enum.Font.GothamBold
            keyBtn.TextSize = 10
            keyBtn.Parent = row
            addCorner(keyBtn, 4)
            addStroke(keyBtn, Theme.divider, 1, 0)

            keyBtn.MouseButton1Click:Connect(function()
                if pendingAnimBindObj and pendingAnimBindObj.name == entry.name then
                    pendingAnimBindObj = nil
                    keyBtn.Text = "[" .. tostring(entry.key) .. "]"
                    keyBtn.TextColor3 = Theme.accent
                else
                    pendingAnimBindObj = { name = entry.name, btn = keyBtn }
                    keyBtn.Text = "[?]"
                    keyBtn.TextColor3 = Color3.fromRGB(255, 180, 50)
                end
            end)

            local unbindBtn = Instance.new("TextButton")
            unbindBtn.Size = UDim2.new(0, 42, 0, 24)
            unbindBtn.Position = UDim2.new(1, -48, 0.5, -12)
            unbindBtn.BackgroundColor3 = Theme.surface
            unbindBtn.Text = "Unbind"
            unbindBtn.TextColor3 = Theme.textMuted
            unbindBtn.Font = Enum.Font.GothamSemibold
            unbindBtn.TextSize = 9
            unbindBtn.Parent = row
            addCorner(unbindBtn, 4)
            addStroke(unbindBtn, Theme.divider, 1, 0)

            unbindBtn.MouseEnter:Connect(function()
                playTween(unbindBtn, { BackgroundColor3 = Theme.dangerHover, TextColor3 = Theme.accent }, 0.15)
            end)
            unbindBtn.MouseLeave:Connect(function()
                playTween(unbindBtn, { BackgroundColor3 = Theme.surface, TextColor3 = Theme.textMuted }, 0.15)
            end)
            unbindBtn.MouseButton1Click:Connect(function()
                savedConfig.binds[entry.name] = nil
                saveConfig()
                refreshBindsTab()
            end)
        end

        bindsPage.CanvasSize = UDim2.new(0, 0, 0, 26 + (#bindEntries * 42))
    end

    -- ========================================================================
    -- 6. BANG REANIMATION TAB (root.73.124 @ PC 3248..4200, closures 73..80)
    -- ========================================================================
    local bangPage = Instance.new("Frame")
    bangPage.Size = UDim2.new(1, -20, 1, -90)
    bangPage.Position = UDim2.new(0, 10, 0, 48)
    bangPage.BackgroundTransparency = 1
    bangPage.Visible = false
    bangPage.Parent = bodyContainer

    local bangTargetInput = Instance.new("TextBox")
    bangTargetInput.Size = UDim2.new(1, 0, 0, 30)
    bangTargetInput.Position = UDim2.new(0, 0, 0, 0)
    bangTargetInput.BackgroundColor3 = Theme.input
    bangTargetInput.PlaceholderText = "Target username..."
    bangTargetInput.Text = ""
    bangTargetInput.TextColor3 = Theme.text
    bangTargetInput.Font = Enum.Font.Gotham
    bangTargetInput.TextSize = 12
    bangTargetInput.ClearTextOnFocus = false
    bangTargetInput.Parent = bangPage
    addCorner(bangTargetInput, 8)
    addStroke(bangTargetInput, Theme.border, 1, 0.4)

    local bangAnimSearch = Instance.new("TextBox")
    bangAnimSearch.Size = UDim2.new(1, 0, 0, 28)
    bangAnimSearch.Position = UDim2.new(0, 0, 0, 36)
    bangAnimSearch.BackgroundColor3 = Theme.input
    bangAnimSearch.PlaceholderText = "Search animations..."
    bangAnimSearch.Text = ""
    bangAnimSearch.TextColor3 = Theme.text
    bangAnimSearch.Font = Enum.Font.Gotham
    bangAnimSearch.TextSize = 12
    bangAnimSearch.ClearTextOnFocus = false
    bangAnimSearch.Parent = bangPage
    addCorner(bangAnimSearch, 8)
    addStroke(bangAnimSearch, Theme.border, 1, 0.4)

    local bangSelectedLbl = Instance.new("TextLabel")
    bangSelectedLbl.Size = UDim2.new(1, 0, 0, 16)
    bangSelectedLbl.Position = UDim2.new(0, 0, 0, 68)
    bangSelectedLbl.BackgroundTransparency = 1
    bangSelectedLbl.Text = "Bang reanim: (none)"
    bangSelectedLbl.TextColor3 = Theme.textMuted
    bangSelectedLbl.Font = Enum.Font.GothamSemibold
    bangSelectedLbl.TextSize = 11
    bangSelectedLbl.TextXAlignment = Enum.TextXAlignment.Left
    bangSelectedLbl.Parent = bangPage

    local bangAnimScroll = Instance.new("ScrollingFrame")
    bangAnimScroll.Size = UDim2.new(1, 0, 1, -160)
    bangAnimScroll.Position = UDim2.new(0, 0, 0, 88)
    bangAnimScroll.BackgroundColor3 = Theme.surface
    bangAnimScroll.BorderSizePixel = 0
    bangAnimScroll.ScrollBarThickness = 3
    bangAnimScroll.Parent = bangPage
    addCorner(bangAnimScroll, 8)

    local bangListLayout = Instance.new("UIListLayout", bangAnimScroll)
    bangListLayout.Padding = UDim.new(0, 4)

    local bangListPad = Instance.new("UIPadding", bangAnimScroll)
    bangListPad.PaddingTop = UDim.new(0, 4)
    bangListPad.PaddingLeft = UDim.new(0, 4)
    bangListPad.PaddingRight = UDim.new(0, 4)

    local selectedBangAnim   = nil
    local lastBangTargetName = ""
    local bangLockActive     = false
    local bangLockMode       = nil
    local bangLockConnObj    = nil
    local bangStatus         = nil

    -- Closure root.73.124.73: Find player by exact or partial Name / DisplayName
    local function findTargetPlayer(queryStr)
        if not queryStr or queryStr == "" then return nil end
        local q = queryStr:lower()
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name:lower() == q or p.DisplayName:lower() == q then
                return p
            end
        end
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name:lower():find(q, 1, true) or p.DisplayName:lower():find(q, 1, true) then
                return p
            end
        end
        return nil
    end

    -- Closure root.73.124.74: Restore character humanoid & root physics cleanly
    local function restoreCharacterPhysics(charModel)
        if not charModel then return end
        pcall(function()
            local rootPart = charModel:FindFirstChild("HumanoidRootPart")
            local hum      = charModel:FindFirstChildWhichIsA("Humanoid")
            if rootPart then
                rootPart.Anchored = false
                rootPart.AssemblyLinearVelocity = Vector3.zero
                rootPart.AssemblyAngularVelocity = Vector3.zero
            end
            if hum then
                hum.Sit = false
                hum.PlatformStand = false
                hum.AutoRotate = true
                hum.WalkSpeed = 16
                hum.JumpPower = 50
                hum.JumpHeight = 7.2
                hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                task.defer(function()
                    if hum and hum.Parent then
                        hum.PlatformStand = false
                        hum.WalkSpeed = 16
                        hum.JumpPower = 50
                        hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
                    end
                end)
            end
        end)
    end

    -- Closure root.73.124.75: Stop Bang Reanimation Lock
    stopBang = function()
        bangLockActive = false
        bangLockMode = nil
        if bangLockConnObj then
            pcall(function() bangLockConnObj:Disconnect() end)
            bangLockConnObj = nil
        end
        pcall(function() RunService:UnbindFromRenderStep("ZenBangLock") end)
        safeRestoreCollisions()
        safeStopAntiFling()
        safeResetVelocityHooks()
        pcall(function()
            if zenApi and type(zenApi.stop_animation) == "function" then
                zenApi.stop_animation()
            end
        end)
        restoreCharacterPhysics(LocalPlayer and LocalPlayer.Character)
        pcall(function()
            if zenApi and type(zenApi.get_real_character) == "function" then
                restoreCharacterPhysics(zenApi.get_real_character())
            end
        end)
        task.spawn(function()
            for _ = 1, 8 do
                task.wait(0.05)
                restoreCharacterPhysics(LocalPlayer and LocalPlayer.Character)
                pcall(function()
                    if zenApi and type(zenApi.get_real_character) == "function" then
                        restoreCharacterPhysics(zenApi.get_real_character())
                    end
                end)
            end
        end)
        if bangStatus then
            bangStatus.Text = "Idle — click same button to stop"
        end
    end

    -- Closure root.73.124.76: Start Bang Reanimation Lock ("face" or "back")
    local function startBangReanim(modeKey)
        local typed = tostring(bangTargetInput.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
        local queryToUse = (typed ~= "") and typed or lastBangTargetName
        local targetPlr = findTargetPlayer(queryToUse)
        if not targetPlr or not targetPlr.Character then
            if bangStatus then bangStatus.Text = "Invalid target" end
            return
        end
        if not LocalPlayer or not LocalPlayer.Character then
            if bangStatus then bangStatus.Text = "No character" end
            return
        end
        if bangLockActive and bangLockMode == modeKey then
            stopBang()
            return
        end
        stopBang()
        bangLockActive = true
        bangLockMode = modeKey
        lastBangTargetName = targetPlr.Name

        if bangStatus then
            local prefix = (modeKey == "face") and "Face Bang → " or "Backshots → "
            bangStatus.Text = prefix .. targetPlr.Name
        end

        local offsetY = (modeKey == "face") and 1.65 or 0
        local offsetZ = (modeKey == "face") and -0.55 or 1.5
        local yawDeg  = (modeKey == "face") and 180 or 0

        if selectedBangAnim and selectedBangAnim.path then
            task.spawn(function()
                pcall(function()
                    if not zenApi.is_reanimated() then
                        zenApi.reanimate(true)
                        updateReanimBtnVisual()
                    end
                    zenApi.play_animation(selectedBangAnim.path, currentSpeed)
                end)
            end)
        end

        local function collectLocalRoots()
            local list = {}
            if zenApi and type(zenApi.get_real_character) == "function" then
                local realChar = zenApi.get_real_character()
                if realChar and realChar.Parent then
                    local r = realChar:FindFirstChild("HumanoidRootPart")
                    if r then
                        table.insert(list, { root = r, char = realChar })
                    end
                end
            end
            if LocalPlayer.Character then
                local r = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if r then
                    local already = false
                    for _, item in ipairs(list) do
                        if item.root == r then
                            already = true
                            break
                        end
                    end
                    if not already then
                        table.insert(list, { root = r, char = LocalPlayer.Character })
                    end
                end
            end
            return list
        end

        local function stepLock()
            if not bangLockActive then return end
            local liveTarget = Players:FindFirstChild(lastBangTargetName) or targetPlr
            if not liveTarget or not liveTarget.Character then return end
            local targetRoot = liveTarget.Character:FindFirstChild("HumanoidRootPart")
            if not targetRoot then return end

            local posOffset = CFrame.new(0, offsetY, offsetZ)
            local rotOffset = CFrame.Angles(0, math.rad(yawDeg), 0)
            local desiredCF = (targetRoot.CFrame * posOffset) * rotOffset

            for _, entry in ipairs(collectLocalRoots()) do
                entry.root.CFrame = desiredCF
                entry.root.AssemblyLinearVelocity = targetRoot.AssemblyLinearVelocity
                entry.root.AssemblyAngularVelocity = Vector3.zero
                safeSyncPhysicsStep(entry.root, targetRoot)
                if entry.char then
                    local hum = entry.char:FindFirstChildWhichIsA("Humanoid")
                    if hum then
                        pcall(function()
                            hum.PlatformStand = true
                            hum.AutoRotate = false
                            hum.WalkSpeed = 0
                            hum:ChangeState(Enum.HumanoidStateType.Physics)
                        end)
                    end
                end
            end
        end

        stepLock()
        local stepName = "ZenBangLock"
        pcall(function() RunService:UnbindFromRenderStep(stepName) end)
        local hbConn = RunService.Heartbeat:Connect(stepLock)
        local rsConn = RunService.RenderStepped:Connect(stepLock)
        pcall(function()
            RunService:BindToRenderStep(stepName, Enum.RenderPriority.Camera.Value + 1, stepLock)
        end)

        bangLockConnObj = {
            Disconnect = function()
                pcall(function() hbConn:Disconnect() end)
                pcall(function() rsConn:Disconnect() end)
                pcall(function() RunService:UnbindFromRenderStep(stepName) end)
            end,
        }
    end

    -- Closure root.73.124.77: Populate Bang Animation selector list
    local populateBangAnimList
    populateBangAnimList = function()
        for _, child in ipairs(bangAnimScroll:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        local q = tostring(bangAnimSearch.Text or ""):lower()
        for _, animEntry in ipairs(allAnimations) do
            local cat = animEntry.category or "Reanims"
            if cat ~= "Unicorns" and (q == "" or animEntry.name:lower():find(q, 1, true)) then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -8, 0, 26)
                local isSel = selectedBangAnim and (selectedBangAnim.name == animEntry.name)
                btn.BackgroundColor3 = isSel and Theme.surfaceHover or Theme.bgCard
                btn.Text = "  " .. animEntry.name
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.TextColor3 = Theme.text
                btn.Font = Enum.Font.GothamSemibold
                btn.TextSize = 11
                btn.AutoButtonColor = false
                btn.Parent = bangAnimScroll
                addCorner(btn, 6)

                btn.MouseButton1Click:Connect(function()
                    selectedBangAnim = {
                        name = animEntry.name,
                        path = animEntry.path,
                    }
                    bangSelectedLbl.Text = "Bang reanim: " .. animEntry.name
                    if zenApi and type(zenApi.preload_animation) == "function" then
                        task.spawn(zenApi.preload_animation, animEntry.path)
                    end
                    populateBangAnimList()
                end)
            end
        end
        bangAnimScroll.CanvasSize = UDim2.new(0, 0, 0, bangListLayout.AbsoluteContentSize.Y + 8)
    end

    task.defer(populateBangAnimList)
    bangAnimSearch:GetPropertyChangedSignal("Text"):Connect(populateBangAnimList)

    local faceBangBtn = Instance.new("TextButton")
    faceBangBtn.Size = UDim2.new(0.48, -2, 0, 32)
    faceBangBtn.Position = UDim2.new(0, 0, 1, -52)
    faceBangBtn.BackgroundColor3 = Theme.surface
    faceBangBtn.Text = "Face Bang"
    faceBangBtn.TextColor3 = Theme.text
    faceBangBtn.Font = Enum.Font.GothamBold
    faceBangBtn.TextSize = 12
    faceBangBtn.Parent = bangPage
    addCorner(faceBangBtn, 10)

    local backshotsBtn = Instance.new("TextButton")
    backshotsBtn.Size = UDim2.new(0.48, -2, 0, 32)
    backshotsBtn.Position = UDim2.new(0.52, 2, 1, -52)
    backshotsBtn.BackgroundColor3 = Theme.surface
    backshotsBtn.Text = "Backshots"
    backshotsBtn.TextColor3 = Theme.text
    backshotsBtn.Font = Enum.Font.GothamBold
    backshotsBtn.TextSize = 12
    backshotsBtn.Parent = bangPage
    addCorner(backshotsBtn, 10)

    bangStatus = Instance.new("TextLabel")
    bangStatus.Size = UDim2.new(1, 0, 0, 14)
    bangStatus.Position = UDim2.new(0, 0, 1, -16)
    bangStatus.BackgroundTransparency = 1
    bangStatus.Text = "Idle — click same button to stop"
    bangStatus.TextColor3 = Theme.textMuted
    bangStatus.Font = Enum.Font.Gotham
    bangStatus.TextSize = 10
    bangStatus.TextXAlignment = Enum.TextXAlignment.Left
    bangStatus.Parent = bangPage

    local lastBangClickTick = 0
    local function onBangModeButton(modeKey)
        local now = tick()
        if (now - lastBangClickTick) < 0.2 then return end
        lastBangClickTick = now
        if bangLockActive and bangLockMode == modeKey then
            stopBang()
            return
        end
        startBangReanim(modeKey)
    end

    faceBangBtn.MouseButton1Click:Connect(function() onBangModeButton("face") end)
    backshotsBtn.MouseButton1Click:Connect(function() onBangModeButton("back") end)

    -- ========================================================================
    -- SUB-TAB SWITCHER (root.73.124.81)
    -- ========================================================================
    switchSubTab = function(tabName)
        activeSubTab = tabName
        for name, info in pairs(subTabButtons) do
            local isCurrent = (name == tabName)
            playTween(
                info.btn,
                {
                    BackgroundColor3       = isCurrent and Theme.accent or Color3.fromRGB(30, 30, 35),
                    BackgroundTransparency = isCurrent and 0 or 0.5,
                    TextColor3             = isCurrent and Color3.fromRGB(8, 8, 10) or Theme.textMuted,
                },
                0.2,
                Enum.EasingStyle.Quint
            )
            info.btn.Font = isCurrent and Enum.Font.GothamBold or Enum.Font.GothamMedium
        end

        local isListTab = (tabName == "Fun" or tabName == "Favs")
        bangPage.Visible   = (tabName == "Bang")
        listPage.Visible   = isListTab
        bindsPage.Visible  = (tabName == "Binds")
        speedPage.Visible  = (tabName == "Speed")
        statesPage.Visible = false
        limbsPage.Visible  = (tabName == "Limbs")

        local activePage = (isListTab and listPage)
            or (tabName == "Binds" and bindsPage)
            or (tabName == "Speed" and speedPage)
            or (tabName == "Limbs" and limbsPage)

        if activePage then
            activePage.Position = UDim2.new(0, 0, 0, 6)
            playTween(activePage, { Position = UDim2.new(0, 0, 0, 0) }, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        end

        if tabName == "Favs" then
            searchBox.PlaceholderText = "Search favorites..."
            addCustomOpenBtn.Visible = false
            searchBox.Size = UDim2.new(1, 0, 0, 30)
            populateList()
        elseif tabName == "Fun" then
            listShowCount = 100
            searchBox.PlaceholderText = "Search animations..."
            addCustomOpenBtn.Visible = false
            searchBox.Size = UDim2.new(1, -96, 0, 30)
            populateList()
        elseif tabName == "Binds" then
            refreshBindsTab()
        elseif tabName == "Limbs" then
            syncLimbsUIFromState()
        elseif tabName == "Bang" then
            populateBangAnimList()
        end
    end

    -- ========================================================================
    -- STATE ANIMATIONS HEARTBEAT MONITOR (root.73.124.82)
    -- ========================================================================
    local currentAutoState = nil
    local stateTickCounter = 0

    -- States tab removed: state auto-play monitor disabled
    -- (kept variables so residual config load does not error)
    do end

    -- ========================================================================
    -- KEYBIND LISTENER (root.73.124.83)
    -- ========================================================================
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        local keyName = input.KeyCode.Name

        -- 1. Assigning an animation keybind
        if pendingAnimBindObj then
            savedConfig.binds[pendingAnimBindObj.name] = keyName
            saveConfig()
            if pendingAnimBindObj.btn then
                pendingAnimBindObj.btn.Text = "[" .. keyName .. "]"
                pendingAnimBindObj.btn.TextColor3 = Theme.accent
            end
            pendingAnimBindObj = nil
            return
        end

        -- 2. Assigning a speed preset keybind
        if pendingSpeedBindKey then
            savedConfig.speedBinds[pendingSpeedBindKey] = keyName
            saveConfig()
            local btn = speedBindButtons[pendingSpeedBindKey]
            if btn then
                btn.Text = "[" .. keyName .. "]"
                btn.TextColor3 = Theme.accent
            end
            pendingSpeedBindKey = nil
            return
        end

        if gameProcessed then return end

        -- 3. Triggering a speed preset keybind
        for spdStr, boundKey in pairs(savedConfig.speedBinds) do
            if boundKey == keyName then
                local numSpd = tonumber(spdStr)
                if numSpd then
                    applyPlaybackSpeed(numSpd)
                end
                return
            end
        end

        -- 4. Triggering an animation keybind
        for animName, boundKey in pairs(savedConfig.binds) do
            if boundKey == keyName then
                for _, item in ipairs(allAnimations) do
                    if item.name == animName then
                        playOrToggleAnimation(item)
                        return
                    end
                end
            end
        end
    end)

    -- Initial UI state sync (root.73.124.84)
    if zenApi then
        updateReanimBtnVisual()
        applyPlaybackSpeed(currentSpeed)
        task.defer(function()
            task.wait(0.15)
            if #allAnimations > 0 then
                pcall(populateList)
            end
        end)
    end
end

_G.buildAngoorReanimTab = buildAngoorReanimTab

-- ============================================================================

end)()

-- ============================================================================
-- UI BOOT (scoped function — Delta / Luau 200 local register limit)
-- ============================================================================
-- ============================================================================
-- JAMUN OWNER CONFIG + HEADTAG SYSTEM (embedded · theme-aware · fixed)
-- ============================================================================
local JAMUN_OWNER_USERNAME = "anime_akash99"
local JAMUN_OWNER_DISPLAY  = "BBZ_JAMUN"

local function isJamunOwner(player)
    if not player then return false end
    return string.lower(tostring(player.Name or "")) == JAMUN_OWNER_USERNAME
end

local __HT = {
    Running     = true,
    Enabled     = true,   -- starts ON by default
    Connections = {},
    Actives     = {},
    Tags        = {},     -- [Player] = BillboardGui ref
    Building    = {},     -- race guard per Player
}

;(function()
    local _htEnv = (typeof(getgenv) == "function" and getgenv()) or _G
    if type(_htEnv.__JamunHT) == "table" and type(_htEnv.__JamunHT.Destroy) == "function" then
        pcall(_htEnv.__JamunHT.Destroy)
    end
    _htEnv.__JamunHT = __HT
    local HT_CONFIG = {
        NAME               = "Jamun",
        LABEL_TEXT         = "JAMUN USER",
        CARD_SIZE          = UDim2.fromOffset(112, 30),
        OWNER_CARD_SIZE    = UDim2.fromOffset(128, 34),
        STUDS_OFFSET_Y     = 2.8,
        MAX_DISTANCE       = 300,
        PRESENCE_WINDOW_S  = 75,
        PRESENCE_REFRESH_S = 12,
        HEARTBEAT_EVERY_S  = 20,
        PREFIX             = "eternity:activity:",
        SUPABASE_URL       = "https://vvfjjfjnmazdkevbcxag.supabase.co",
        SUPABASE_KEY       = "sb_publishable_8QiOom6aAy0rE1NHF5yyXw_A77BuEet",
        HEARTBEAT_URL      = "https://vvfjjfjnmazdkevbcxag.supabase.co/functions/v1/heartbeat",
    }

    -- headtag theme table: one entry per SHADER — unique look per theme
    local HT_THEMES = {
        Neon      = { bg=Color3.fromRGB(8,8,10),    accent=Color3.fromRGB(248,248,255), text=Color3.fromRGB(235,235,240), label="✦ JAMUN USER" },
        Default   = { bg=Color3.fromRGB(14,16,28),   accent=Color3.fromRGB(200,210,255), text=Color3.fromRGB(220,225,240), label="◈ JAMUN USER" },
        Void      = { bg=Color3.fromRGB(22,14,32),   accent=Color3.fromRGB(190,160,255), text=Color3.fromRGB(230,220,245), label="☽ JAMUN USER" },
        Crimson   = { bg=Color3.fromRGB(28,10,12),   accent=Color3.fromRGB(255,120,130), text=Color3.fromRGB(245,220,220), label="♥ JAMUN USER" },
        Jamun     = { bg=Color3.fromRGB(26,12,24),   accent=Color3.fromRGB(220,120,190), text=Color3.fromRGB(245,225,240), label="● JAMUN USER" },
        Ocean     = { bg=Color3.fromRGB(8,22,32),    accent=Color3.fromRGB(100,200,255), text=Color3.fromRGB(220,235,245), label="≈ JAMUN USER" },
        Emerald   = { bg=Color3.fromRGB(8,26,18),    accent=Color3.fromRGB(90,230,170),  text=Color3.fromRGB(220,245,230), label="♣ JAMUN USER" },
        Amber     = { bg=Color3.fromRGB(28,20,8),    accent=Color3.fromRGB(255,190,90),  text=Color3.fromRGB(245,235,210), label="◆ JAMUN USER" },
        Rose      = { bg=Color3.fromRGB(28,12,18),   accent=Color3.fromRGB(255,140,170), text=Color3.fromRGB(245,225,230), label="❀ JAMUN USER" },
        Ice       = { bg=Color3.fromRGB(12,22,30),   accent=Color3.fromRGB(180,230,255), text=Color3.fromRGB(225,240,250), label="❄ JAMUN USER" },
        Sunset    = { bg=Color3.fromRGB(30,14,8),    accent=Color3.fromRGB(255,140,90),  text=Color3.fromRGB(245,228,215), label="☀ JAMUN USER" },
        Toxic     = { bg=Color3.fromRGB(12,28,10),   accent=Color3.fromRGB(170,255,80),  text=Color3.fromRGB(230,250,215), label="☢ JAMUN USER" },
        Midnight  = { bg=Color3.fromRGB(10,12,30),   accent=Color3.fromRGB(120,140,255), text=Color3.fromRGB(220,225,250), label="★ JAMUN USER" },
        Gold      = { bg=Color3.fromRGB(28,24,10),   accent=Color3.fromRGB(255,215,120), text=Color3.fromRGB(245,240,215), label="♛ JAMUN USER" },
        Sakura    = { bg=Color3.fromRGB(28,14,22),   accent=Color3.fromRGB(255,170,200), text=Color3.fromRGB(250,230,240), label="✿ JAMUN USER" },
        Matrix    = { bg=Color3.fromRGB(4,18,8),     accent=Color3.fromRGB(80,255,120),  text=Color3.fromRGB(200,255,210), label="⌘ JAMUN USER" },
        Cyberpunk = { bg=Color3.fromRGB(8,4,18),     accent=Color3.fromRGB(0,255,220),   text=Color3.fromRGB(220,255,250), label="⬡ JAMUN USER" },
        DBZ       = { bg=Color3.fromRGB(18,10,4),    accent=Color3.fromRGB(255,160,40),  text=Color3.fromRGB(255,240,210), label="★ JAMUN USER" },
        Bleach    = { bg=Color3.fromRGB(6,6,8),      accent=Color3.fromRGB(220,40,40),   text=Color3.fromRGB(240,235,235), label="斬 JAMUN USER" },
        Naruto    = { bg=Color3.fromRGB(14,10,6),    accent=Color3.fromRGB(255,120,30),  text=Color3.fromRGB(255,245,220), label="忍 JAMUN USER" },
        Aether    = { bg=Color3.fromRGB(10,12,22),   accent=Color3.fromRGB(180,220,255), text=Color3.fromRGB(230,240,255), label="✧ JAMUN USER" },
    }

    local function htGetTheme()
        return HT_THEMES[currentThemeName] or HT_THEMES["Neon"]
    end

    -- HTTP helpers (Delta / Fluxus / Synapse / Wave / Arceus-safe)
    local function htRequest(url, method, body)
        local req = (typeof(syn) == "table" and syn.request)
                 or (typeof(http) == "table" and http.request)
                 or (typeof(fluxus) == "table" and fluxus.request)
                 or (typeof(http_request) == "function" and http_request)
                 or (typeof(request) == "function" and request)
        if type(req) == "function" then
            local ok, res = pcall(req, {
                Url = url,
                Method = method or "GET",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["apikey"] = HT_CONFIG.SUPABASE_KEY,
                    ["Authorization"] = "Bearer " .. HT_CONFIG.SUPABASE_KEY,
                },
                Body = body,
            })
            if ok and type(res) == "table" then
                local status = tonumber(res.StatusCode or res.status or 200) or 200
                if res.Success == false or status >= 400 then
                    return nil
                end
                return res.Body or res.body
            end
        end
        if method == "GET" or not method then
            local ok, b = pcall(game.HttpGet, game, url, true)
            if ok then return b end
        end
        return nil
    end

    local function htIsActive(player)
        if not player or player.Parent ~= P then return false end
        if player == LP or isJamunOwner(player) then return true end
        local t = __HT.Actives[player]
        return t ~= nil and (tick() - t) <= HT_CONFIG.PRESENCE_WINDOW_S
    end
    __HT.IsActive = htIsActive

    local function htRemoveTag(character)
        local head = character and character:FindFirstChild("Head")
        local old = head and head:FindFirstChild(HT_CONFIG.NAME)
        if old then pcall(function() old:Destroy() end) end
    end

    local function htBuildTag(character, player)
        if not __HT.Running or not __HT.Enabled then return end
        if not character or not character.Parent or not player or player.Parent ~= P then return end
        if __HT.Building[player] == character then return end
        __HT.Building[player] = character
        local head = character:FindFirstChild("Head") or character:WaitForChild("Head", 10)
        if __HT.Building[player] == character then __HT.Building[player] = nil end
        if not head or not head.Parent then return end
        if not __HT.Running or not __HT.Enabled or not htIsActive(player) then return end

        htRemoveTag(character)
        local th = htGetTheme()
        local isOwner = isJamunOwner(player)
        if isOwner then
            th = {
                bg     = Color3.fromRGB(22, 16, 4),
                accent = Color3.fromRGB(255, 215, 120),
                text   = Color3.fromRGB(255, 245, 200),
                label  = "♛ JAMUN OWNER",
            }
        end

        local gui = Instance.new("BillboardGui")
        gui.Name = HT_CONFIG.NAME
        gui.Adornee = head
        gui.AlwaysOnTop = true
        gui.LightInfluence = 0
        gui.MaxDistance = HT_CONFIG.MAX_DISTANCE
        gui.ResetOnSpawn = false
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Size = isOwner and HT_CONFIG.OWNER_CARD_SIZE or HT_CONFIG.CARD_SIZE
        gui.StudsOffset = Vector3.new(0, HT_CONFIG.STUDS_OFFSET_Y, 0)
        gui.Enabled = __HT.Enabled

        local card = Instance.new("Frame", gui)
        card.Size = UDim2.new(1, 0, 1, 0)
        card.BackgroundColor3 = th.bg
        card.BackgroundTransparency = 0.08
        card.BorderSizePixel = 0
        local cc = Instance.new("UICorner", card); cc.CornerRadius = UDim.new(0, 7)

        if isOwner then
            local ownerGrad = Instance.new("UIGradient", card)
            ownerGrad.Rotation = 135
            ownerGrad.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0,   Color3.fromRGB(58, 42, 10)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(26, 18, 5)),
                ColorSequenceKeypoint.new(1,   Color3.fromRGB(58, 42, 10)),
            }
            task.spawn(function()
                local a2 = 0
                while __HT.Running and card and card.Parent do
                    a2 = (a2 + 0.8) % 360
                    ownerGrad.Rotation = 135 + math.sin(math.rad(a2)) * 25
                    task.wait(0.03)
                end
            end)
        end

        local pad = Instance.new("UIPadding", card)
        pad.PaddingLeft = UDim.new(0, 6); pad.PaddingRight = UDim.new(0, 6)

        if not isOwner then
            local sheen = Instance.new("Frame", card)
            sheen.Size = UDim2.new(1, -2, 0, 1); sheen.Position = UDim2.new(0, 1, 0, 1)
            sheen.BackgroundColor3 = Color3.fromRGB(255, 230, 245)
            sheen.BackgroundTransparency = 0.65; sheen.BorderSizePixel = 0
            sheen.ZIndex = 3
            local sC = Instance.new("UICorner", sheen); sC.CornerRadius = UDim.new(1, 0)
            local sG = Instance.new("UIGradient", sheen)
            sG.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.3, 0.1),
                NumberSequenceKeypoint.new(0.7, 0.1),
                NumberSequenceKeypoint.new(1, 1),
            }
        end

        local cardStroke = Instance.new("UIStroke", card)
        cardStroke.Color = th.accent
        cardStroke.Thickness = isOwner and 1.8 or 1.2
        cardStroke.Transparency = 0.18

        local strokeGrad = Instance.new("UIGradient", cardStroke)
        strokeGrad.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.5, 0.65),
            NumberSequenceKeypoint.new(1, 0),
        }

        local lbl = Instance.new("TextLabel", card)
        lbl.Name = "Label"
        lbl.Size = UDim2.new(1, 0, 0, 12)
        lbl.Position = UDim2.new(0, 0, 0, 2)
        lbl.BackgroundTransparency = 1
        lbl.Text = th.label
        lbl.TextColor3 = th.accent
        lbl.Font = isOwner and Enum.Font.GothamBlack or Enum.Font.GothamBold
        lbl.TextSize = isOwner and 9 or 8
        lbl.TextXAlignment = Enum.TextXAlignment.Center
        lbl.TextTruncate = Enum.TextTruncate.AtEnd

        local dname = Instance.new("TextLabel", card)
        dname.Name = "DisplayName"
        dname.Size = UDim2.new(1, 0, 0, 14)
        dname.Position = UDim2.new(0, 0, 0, 14)
        dname.BackgroundTransparency = 1
        dname.Text = player.DisplayName
        dname.TextColor3 = th.text
        dname.Font = Enum.Font.GothamSemibold
        dname.TextSize = isOwner and 11 or 10
        dname.TextXAlignment = Enum.TextXAlignment.Center
        dname.TextTruncate = Enum.TextTruncate.AtEnd

        __HT.Tags[player] = { gui=gui, card=card, stroke=cardStroke, strokeGrad=strokeGrad, lbl=lbl, dname=dname }
        gui.Parent = head

        task.spawn(function()
            local angle = 0
            while __HT.Running and gui and gui.Parent == head and head.Parent do
                local cam = WS.CurrentCamera
                local dist = cam and (cam.CFrame.Position - head.Position).Magnitude or 0
                if __HT.Enabled and htIsActive(player) and dist <= HT_CONFIG.MAX_DISTANCE then
                    gui.Enabled = true
                    angle = (angle + 1.4) % 360
                    strokeGrad.Rotation = angle
                    task.wait(0.03)
                else
                    gui.Enabled = false
                    task.wait(0.35)
                end
            end
            if __HT.Tags[player] and __HT.Tags[player].gui == gui then
                __HT.Tags[player] = nil
            end
        end)
    end

    function htSyncAll()
        for _, p in ipairs(P:GetPlayers()) do
            if p.Character then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    if __HT.Enabled and htIsActive(p) then
                        if not head:FindFirstChild(HT_CONFIG.NAME) then
                            task.spawn(htBuildTag, p.Character, p)
                        end
                    else
                        htRemoveTag(p.Character)
                        __HT.Tags[p] = nil
                    end
                end
            end
        end
    end

    -- retint all existing tags when theme changes (never overwrites Owner gold tag)
    function htRetintAll()
        local th = htGetTheme()
        for player, refs in pairs(__HT.Tags) do
            pcall(function()
                if isJamunOwner(player) then return end
                if refs.card and refs.card.Parent then refs.card.BackgroundColor3 = th.bg end
                if refs.stroke and refs.stroke.Parent then refs.stroke.Color = th.accent end
                if refs.lbl and refs.lbl.Parent then
                    refs.lbl.TextColor3 = th.accent
                    refs.lbl.Text = th.label
                end
                if refs.dname and refs.dname.Parent then refs.dname.TextColor3 = th.text end
            end)
        end
    end
    __HT.RetintAll = htRetintAll
    __HT.SyncAll   = htSyncAll
    _G.__jamunRetintHT = htRetintAll

    local function htSendHeartbeat()
        if not __HT.Running or not __HT.Enabled then return end
        pcall(htRequest, HT_CONFIG.HEARTBEAT_URL, "POST",
            HS:JSONEncode({ name = LP.Name, jobId = tostring(game.JobId or "") }))
    end

    local function htRefreshPresence()
        if not __HT.Running or not __HT.Enabled then return end
        local keys = {}
        for _, p in ipairs(P:GetPlayers()) do
            if p ~= LP then
                table.insert(keys, HT_CONFIG.PREFIX .. string.lower(p.Name))
            end
        end
        if #keys == 0 then
            htSyncAll()
            return
        end
        local url = HT_CONFIG.SUPABASE_URL .. "/rest/v1/stats?apikey=" .. HT_CONFIG.SUPABASE_KEY
            .. "&key=in.(" .. table.concat(keys, ",") .. ")&select=key,value"
        local raw = htRequest(url, "GET")
        local alive = {}
        if raw and raw ~= "" then
            local ok, rows = pcall(HS.JSONDecode, HS, raw)
            if ok and type(rows) == "table" then
                local myJob = tostring(game.JobId or "")
                local nowMs = os.time() * 1000
                for _, row in ipairs(rows) do
                    if type(row) == "table" and type(row.key) == "string" and row.key:sub(1, #HT_CONFIG.PREFIX) == HT_CONFIG.PREFIX then
                        local ok2, data = false, nil
                        if type(row.value) == "table" then
                            ok2, data = true, row.value
                        elseif type(row.value) == "string" and row.value ~= "" then
                            ok2, data = pcall(HS.JSONDecode, HS, row.value)
                        end
                        if ok2 and type(data) == "table" then
                            local rowJob = tostring(data.jobId or "")
                            local sameServer = (myJob == "" and rowJob == "") or (myJob ~= "" and rowJob == myJob)
                            local lastPing = tonumber(data.last_ping) or 0
                            if lastPing > 0 and lastPing < 1e11 then
                                lastPing = lastPing * 1000
                            end
                            local age = nowMs - lastPing
                            if sameServer and age >= -15000 and age <= HT_CONFIG.PRESENCE_WINDOW_S * 1000 then
                                alive[string.lower(row.key:sub(#HT_CONFIG.PREFIX + 1))] = true
                            end
                        end
                    end
                end
            end
        end
        for _, p in ipairs(P:GetPlayers()) do
            if p ~= LP then
                local lname = string.lower(p.Name)
                if alive[lname] then
                    __HT.Actives[p] = tick()
                elseif __HT.Actives[p] and (tick() - __HT.Actives[p]) > HT_CONFIG.PRESENCE_WINDOW_S then
                    __HT.Actives[p] = nil
                end
            end
        end
        htSyncAll()
    end

    __HT.RefreshPresence = htRefreshPresence
    __HT.SendHeartbeat   = htSendHeartbeat
    __HT.MarkActive      = function(player)
        if player and player.Parent == P then
            __HT.Actives[player] = tick()
            htSyncAll()
        end
    end

    function __HT.SetEnabled(val)
        __HT.Enabled = (val == true)
        if __HT.Enabled then
            task.spawn(htSendHeartbeat)
            htSyncAll()
            task.spawn(htRefreshPresence)
        else
            for _, p in ipairs(P:GetPlayers()) do
                if p.Character then htRemoveTag(p.Character) end
                __HT.Tags[p] = nil
            end
        end
    end

    function __HT.Destroy()
        __HT.Running = false
        for _, c in ipairs(__HT.Connections) do pcall(function() c:Disconnect() end) end
        __HT.Connections = {}
        for _, p in ipairs(P:GetPlayers()) do
            if p.Character then htRemoveTag(p.Character) end
        end
        __HT.Tags = {}
    end

    local function htBindPlayer(player)
        local function onChar(char)
            if player ~= LP then task.wait(0.3) end
            if char and char.Parent and __HT.Running then
                local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 10)
                if __HT.Enabled and head and htIsActive(player) then
                    task.spawn(htBuildTag, char, player)
                end
            end
        end
        if player.Character then task.spawn(onChar, player.Character) end
        table.insert(__HT.Connections, player.CharacterAdded:Connect(onChar))
    end

    table.insert(__HT.Connections, P.PlayerAdded:Connect(function(p)
        htBindPlayer(p)
        task.delay(2, function()
            if __HT.Running and __HT.Enabled then pcall(htRefreshPresence) end
        end)
    end))
    table.insert(__HT.Connections, P.PlayerRemoving:Connect(function(p)
        __HT.Actives[p] = nil
        __HT.Tags[p] = nil
    end))

    for _, p in ipairs(P:GetPlayers()) do
        htBindPlayer(p)
    end
    htSyncAll()

    -- immediate heartbeat + periodic heartbeat
    task.spawn(function()
        while __HT.Running do
            if __HT.Enabled then pcall(htSendHeartbeat) end
            task.wait(HT_CONFIG.HEARTBEAT_EVERY_S)
        end
    end)

    -- immediate presence fetch (1.5s after boot) + periodic refresh
    task.spawn(function()
        task.wait(1.5)
        while __HT.Running do
            if __HT.Enabled then pcall(htRefreshPresence) end
            task.wait(HT_CONFIG.PRESENCE_REFRESH_S)
        end
    end)
end)()

-- ============================================================================
-- JAMUN OWNER ADMIN COMMANDS (Owner: @anime_akash99 / BBZ_JAMUN)
-- Works via both TextChatService & Legacy Chat on all players who executed script
-- ============================================================================
;(function()
    local _admEnv = (typeof(getgenv) == "function" and getgenv()) or _G
    if type(_admEnv.__JamunAdmin) == "table" and type(_admEnv.__JamunAdmin.Destroy) == "function" then
        pcall(_admEnv.__JamunAdmin.Destroy)
    end

    local ADM = {
        Running     = true,
        Connections = {},
        SpinConn    = nil,
        OrbitConn   = nil,
        FollowConn  = nil,
        NoclipConn  = nil,
        BlindGui    = nil,
        LastSeen    = {},
    }
    _admEnv.__JamunAdmin = ADM

    local TeleportService = game:GetService("TeleportService")
    local StarterGui      = game:GetService("StarterGui")

    local function admNotify(title, text, dur)
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title    = tostring(title or "Jamun Admin"),
                Text     = tostring(text or ""),
                Duration = dur or 4,
            })
        end)
    end

    local function findPlayerByToken(tok)
        if not tok or tok == "" then return nil end
        local q = string.lower(tostring(tok):gsub("^@+", ""))
        for _, p in ipairs(P:GetPlayers()) do
            if string.lower(p.Name) == q or string.lower(p.DisplayName) == q then return p end
        end
        for _, p in ipairs(P:GetPlayers()) do
            if string.lower(p.Name):sub(1, #q) == q or string.lower(p.DisplayName):sub(1, #q) == q then return p end
        end
        for _, p in ipairs(P:GetPlayers()) do
            if string.lower(p.Name):find(q, 1, true) or string.lower(p.DisplayName):find(q, 1, true) then return p end
        end
        return nil
    end

    local function matchesLocalTarget(tok, sender, allowOwnerOnAll)
        if not tok or tok == "" then
            if isJamunOwner(LP) then return allowOwnerOnAll == true end
            return true
        end
        local q = string.lower(tostring(tok):gsub("^@+", ""))
        if q == "all" then
            if isJamunOwner(LP) then return allowOwnerOnAll == true end
            return true
        elseif q == "others" then
            return LP ~= sender
        elseif q == "me" then
            return LP == sender
        end
        local myN = string.lower(LP.Name)
        local myD = string.lower(LP.DisplayName)
        return myN == q or myD == q
            or myN:sub(1, #q) == q or myD:sub(1, #q) == q
            or myN:find(q, 1, true) ~= nil or myD:find(q, 1, true) ~= nil
    end

    local function stopAdminLoops()
        if ADM.SpinConn   then pcall(function() ADM.SpinConn:Disconnect() end);   ADM.SpinConn   = nil end
        if ADM.OrbitConn  then pcall(function() ADM.OrbitConn:Disconnect() end);  ADM.OrbitConn  = nil end
        if ADM.FollowConn then pcall(function() ADM.FollowConn:Disconnect() end); ADM.FollowConn = nil end
        if _G.JamunAnimCopy and _G.JamunAnimCopy.active and type(_G.JamunAnimCopy.Stop) == "function" then
            pcall(function() _G.JamunAnimCopy:Stop() end)
        end
    end

    local function setBlind(state)
        if ADM.BlindGui then pcall(function() ADM.BlindGui:Destroy() end); ADM.BlindGui = nil end
        if not state then return end
        local sg = Instance.new("ScreenGui")
        sg.Name = "JamunAdminBlind"
        sg.ResetOnSpawn = false
        sg.IgnoreGuiInset = true
        sg.DisplayOrder = 999999
        local f = Instance.new("Frame", sg)
        f.Size = UDim2.fromScale(1, 1)
        f.BackgroundColor3 = Color3.new(0, 0, 0)
        f.BorderSizePixel = 0
        pcall(function()
            local h = (typeof(gethui) == "function" and gethui()) or game:GetService("CoreGui")
            sg.Parent = h
        end)
        if not sg.Parent then
            local pg = LP:FindFirstChild("PlayerGui")
            if pg then sg.Parent = pg end
        end
        ADM.BlindGui = sg
    end

    local function setNoclip(state)
        if ADM.NoclipConn then pcall(function() ADM.NoclipConn:Disconnect() end); ADM.NoclipConn = nil end
        if state then
            ADM.NoclipConn = RS.Stepped:Connect(function()
                local c = LP.Character
                if not c then return end
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end)
        else
            local c = LP.Character
            if c then
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") and (part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end

    local function handleOwnerCommand(sender, rawMsg)
        if not ADM.Running then return end
        if not sender or not isJamunOwner(sender) then return end
        if type(rawMsg) ~= "string" then return end

        local msg = rawMsg:gsub("^%s+", ""):gsub("%s+$", "")
        if #msg < 2 then return end
        local pfx = msg:sub(1, 1)
        if pfx ~= ";" and pfx ~= "!" and pfx ~= "." then return end

        -- deduplicate when both TextChatService & Player.Chatted fire
        local dedupKey = tostring(sender.UserId) .. "|" .. msg
        local now = tick()
        if ADM.LastSeen[dedupKey] and (now - ADM.LastSeen[dedupKey]) < 0.35 then return end
        for k, t in pairs(ADM.LastSeen) do
            if now - t > 10 then ADM.LastSeen[k] = nil end
        end
        ADM.LastSeen[dedupKey] = now

        -- mark Owner active immediately so gold tag shows even before next Supabase poll
        if __HT and type(__HT.MarkActive) == "function" then
            pcall(__HT.MarkActive, sender)
        end

        local body = msg:sub(2)
        local args = {}
        for word in body:gmatch("%S+") do
            table.insert(args, word)
        end
        if #args == 0 then return end

        local cmd = string.lower(args[1])
        local a1  = args[2]
        local a2  = args[3]
        local restAfter1 = (#args >= 2) and table.concat(args, " ", 2) or ""
        local restAfter2 = (#args >= 3) and table.concat(args, " ", 3) or ""

        local myChar = LP.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local myHum  = myChar and myChar:FindFirstChildOfClass("Humanoid")
        local ownerChar = sender.Character
        local ownerRoot = ownerChar and ownerChar:FindFirstChild("HumanoidRootPart")

        -- ── Owner-side utility & tag commands ──
        if cmd == "cmds" or cmd == "help" then
            if isJamunOwner(LP) then
                local list = ";bring ;tp ;to ;kill ;reset ;freeze ;unfreeze ;sit ;unsit ;jump ;fling ;void ;speed ;jp ;gravity ;fly ;unfly ;noclip ;clip ;spin ;unspin ;orbit ;unorbit ;follow ;unfollow ;blind ;unblind ;dance ;say ;kick ;rejoin ;facebang ;backshots ;headsit ;kiss ;backpack ;hug ;unweld ;tag ;untag ;users"
                print("[Jamun Owner Commands] " .. list)
                admNotify("Jamun Owner Commands", "Printed all commands in F9 console! Prefix: ; ! .", 5)
            end
            return
        elseif cmd == "users" then
            task.spawn(function()
                if __HT and type(__HT.RefreshPresence) == "function" then
                    pcall(__HT.RefreshPresence)
                end
                if isJamunOwner(LP) then
                    local names = {}
                    for _, p in ipairs(P:GetPlayers()) do
                        if __HT and __HT.IsActive and __HT.IsActive(p) then
                            table.insert(names, p.DisplayName .. " (@" .. p.Name .. ")")
                        end
                    end
                    local txt = (#names > 0) and table.concat(names, ", ") or "Only you"
                    print("[Jamun Users] " .. txt)
                    admNotify("Jamun Users (" .. tostring(#names) .. ")", txt, 5)
                end
            end)
            return
        elseif cmd == "tag" or (cmd == "tags" and string.lower(tostring(a1 or "")) == "on") then
            if __HT and type(__HT.SetEnabled) == "function" then
                __HT.SetEnabled(true)
            end
            if isJamunOwner(LP) then admNotify("Jamun Headtag", "Headtags enabled & synced", 3) end
            return
        elseif cmd == "untag" or (cmd == "tags" and string.lower(tostring(a1 or "")) == "off") then
            if __HT and type(__HT.SetEnabled) == "function" then
                __HT.SetEnabled(false)
            end
            if isJamunOwner(LP) then admNotify("Jamun Headtag", "Headtags disabled", 3) end
            return
        elseif cmd == "to" then
            if isJamunOwner(LP) and a1 and myRoot then
                local dest = findPlayerByToken(a1)
                local dRoot = dest and dest.Character and dest.Character:FindFirstChild("HumanoidRootPart")
                if dRoot then
                    local targetCF = dRoot.CFrame * CFrame.new(0, 0, -3)
                    if _G.__jamunResetSafety then _G.__jamunResetSafety(targetCF, 1.5) end
                    myRoot.AssemblyLinearVelocity = Vector3.zero
                    myRoot.CFrame = targetCF
                end
            end
            return
        end

        -- ── Targeted commands (execute on matching Jamun users) ──
        if cmd == "bring" then
            if not matchesLocalTarget(a1, sender, false) then return end
            if myRoot and ownerRoot then
                stopAdminLoops()
                pcall(stopWeld)
                local targetCF = ownerRoot.CFrame * CFrame.new(0, 0, -3)
                if _G.__jamunResetSafety then _G.__jamunResetSafety(targetCF, 1.5) end
                myRoot.Anchored = false
                myRoot.AssemblyLinearVelocity = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
                myRoot.CFrame = targetCF
            end
        elseif cmd == "tp" then
            if not a1 then return end
            if not a2 then
                -- ;tp <dest> for owner
                if isJamunOwner(LP) and myRoot then
                    local dest = findPlayerByToken(a1)
                    local dRoot = dest and dest.Character and dest.Character:FindFirstChild("HumanoidRootPart")
                    if dRoot then
                        local targetCF = dRoot.CFrame * CFrame.new(0, 0, -3)
                        if _G.__jamunResetSafety then _G.__jamunResetSafety(targetCF, 1.5) end
                        myRoot.AssemblyLinearVelocity = Vector3.zero
                        myRoot.CFrame = targetCF
                    end
                end
                return
            end
            if not matchesLocalTarget(a1, sender, true) then return end
            local dest = (string.lower(a2) == "me") and sender or findPlayerByToken(a2)
            local dRoot = dest and dest.Character and dest.Character:FindFirstChild("HumanoidRootPart")
            if myRoot and dRoot then
                local targetCF = dRoot.CFrame * CFrame.new(0, 0, -3)
                if _G.__jamunResetSafety then _G.__jamunResetSafety(targetCF, 1.5) end
                myRoot.Anchored = false
                myRoot.AssemblyLinearVelocity = Vector3.zero
                myRoot.CFrame = targetCF
            end
        elseif cmd == "kill" or cmd == "reset" or cmd == "re" then
            if not matchesLocalTarget(a1, sender, (a1 ~= nil and string.lower(a1) == "me")) then return end
            stopAdminLoops()
            pcall(stopWeld)
            pcall(avStop)
            pcall(akStop)
            if _G.__jamunResetSafety then _G.__jamunResetSafety(nil, 2.0) end
            if myHum then
                pcall(function() myHum:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end)
                myHum.Health = 0
                pcall(function() myHum:ChangeState(Enum.HumanoidStateType.Dead) end)
            end
            if myChar then pcall(function() myChar:BreakJoints() end) end
        elseif cmd == "freeze" then
            if not matchesLocalTarget(a1, sender, false) then return end
            if myRoot then myRoot.Anchored = true end
        elseif cmd == "unfreeze" then
            if not matchesLocalTarget(a1, sender, true) then return end
            if myRoot then myRoot.Anchored = false end
        elseif cmd == "sit" then
            if not matchesLocalTarget(a1, sender, false) then return end
            pcall(asStop)
            if myHum then
                pcall(function() myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end)
                myHum.Sit = true
            end
        elseif cmd == "unsit" then
            if not matchesLocalTarget(a1, sender, true) then return end
            if myHum then myHum.Sit = false end
        elseif cmd == "jump" then
            if not matchesLocalTarget(a1, sender, false) then return end
            if myHum then
                myHum.Jump = true
                pcall(function() myHum:ChangeState(Enum.HumanoidStateType.Jumping) end)
            end
        elseif cmd == "fling" then
            if not matchesLocalTarget(a1, sender, false) then return end
            if myRoot then
                if _G.__jamunResetSafety then _G.__jamunResetSafety(nil, 3.5) end
                myRoot.Anchored = false
                myRoot.AssemblyLinearVelocity = Vector3.new(math.random(-250, 250), 450, math.random(-250, 250))
                myRoot.AssemblyAngularVelocity = Vector3.new(90, 90, 90)
            end
        elseif cmd == "void" then
            if not matchesLocalTarget(a1, sender, false) then return end
            if myRoot then
                stopAdminLoops()
                pcall(stopWeld)
                pcall(avStop)
                pcall(akStop)
                if _G.__jamunResetSafety then _G.__jamunResetSafety(nil, 4.5) end
                pcall(function()
                    WS.FallenPartsDestroyHeight = (OriginalFPDH == OriginalFPDH and OriginalFPDH > -10000) and OriginalFPDH or -500
                end)
                myRoot.Anchored = false
                myRoot.CFrame = CFrame.new(myRoot.Position.X, -5000, myRoot.Position.Z)
            end
        elseif cmd == "speed" or cmd == "ws" then
            -- supports both ";ws 80" (self for owner) and ";ws <target> 80"
            local numOnly = tonumber(a1)
            if numOnly and not a2 then
                if isJamunOwner(LP) and myHum then
                    wsVal = numOnly; wsOn = true; myHum.WalkSpeed = numOnly
                end
                return
            end
            if not matchesLocalTarget(a1, sender, true) then return end
            local spd = tonumber(a2) or 16
            if myHum then wsVal = spd; wsOn = (spd ~= 16); myHum.WalkSpeed = spd end
        elseif cmd == "jp" or cmd == "jumppower" then
            local numOnly = tonumber(a1)
            if numOnly and not a2 then
                if isJamunOwner(LP) and myHum then
                    pcall(function() myHum.UseJumpPower = true; myHum.JumpPower = numOnly end)
                end
                return
            end
            if not matchesLocalTarget(a1, sender, true) then return end
            local jp = tonumber(a2) or 50
            if myHum then
                pcall(function() myHum.UseJumpPower = true; myHum.JumpPower = jp end)
            end
        elseif cmd == "gravity" then
            local numOnly = tonumber(a1)
            if numOnly and not a2 then
                if isJamunOwner(LP) then WS.Gravity = numOnly end
                return
            end
            if not matchesLocalTarget(a1, sender, true) then return end
            WS.Gravity = tonumber(a2) or 196.2
        elseif cmd == "fly" then
            if not a1 then
                if isJamunOwner(LP) and type(_G.startJamunFly) == "function" then _G.startJamunFly() end
                return
            end
            if not matchesLocalTarget(a1, sender, true) then return end
            if type(_G.startJamunFly) == "function" then _G.startJamunFly() end
        elseif cmd == "unfly" then
            if not a1 then
                if isJamunOwner(LP) and type(_G.stopJamunFly) == "function" then _G.stopJamunFly() end
                return
            end
            if not matchesLocalTarget(a1, sender, true) then return end
            if type(_G.stopJamunFly) == "function" then _G.stopJamunFly() end
        elseif cmd == "noclip" then
            if not a1 then
                if isJamunOwner(LP) then setNoclip(true) end
                return
            end
            if not matchesLocalTarget(a1, sender, true) then return end
            setNoclip(true)
        elseif cmd == "clip" or cmd == "unnoclip" then
            if not a1 then
                if isJamunOwner(LP) then setNoclip(false) end
                return
            end
            if not matchesLocalTarget(a1, sender, true) then return end
            setNoclip(false)
        elseif cmd == "spin" then
            if not matchesLocalTarget(a1, sender, false) then return end
            local spd = tonumber(a2) or 12
            if ADM.SpinConn then pcall(function() ADM.SpinConn:Disconnect() end) end
            ADM.SpinConn = RS.Heartbeat:Connect(function(dt)
                local r = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                if r then r.CFrame = r.CFrame * CFrame.Angles(0, dt * spd, 0) end
            end)
        elseif cmd == "unspin" then
            if not matchesLocalTarget(a1, sender, true) then return end
            if ADM.SpinConn then pcall(function() ADM.SpinConn:Disconnect() end); ADM.SpinConn = nil end
        elseif cmd == "orbit" then
            if not matchesLocalTarget(a1, sender, false) then return end
            local radius = tonumber(a2) or 6
            stopAdminLoops()
            local ang = 0
            ADM.OrbitConn = RS.Heartbeat:Connect(function(dt)
                local r = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                local oR = sender.Character and sender.Character:FindFirstChild("HumanoidRootPart")
                if not r or not oR then return end
                ang = ang + dt * 3
                local pos = oR.Position + Vector3.new(math.cos(ang) * radius, 0, math.sin(ang) * radius)
                local targetCF = CFrame.lookAt(pos, oR.Position)
                if _G.__jamunResetSafety then _G.__jamunResetSafety(targetCF, 0.5) end
                r.CFrame = targetCF
                r.AssemblyLinearVelocity = Vector3.zero
            end)
        elseif cmd == "unorbit" then
            if not matchesLocalTarget(a1, sender, true) then return end
            if ADM.OrbitConn then pcall(function() ADM.OrbitConn:Disconnect() end); ADM.OrbitConn = nil end
        elseif cmd == "follow" then
            if not matchesLocalTarget(a1, sender, false) then return end
            stopAdminLoops()
            ADM.FollowConn = RS.Heartbeat:Connect(function()
                local h = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                local oR = sender.Character and sender.Character:FindFirstChild("HumanoidRootPart")
                if h and oR then h:MoveTo(oR.Position) end
            end)
        elseif cmd == "unfollow" then
            if not matchesLocalTarget(a1, sender, true) then return end
            if ADM.FollowConn then pcall(function() ADM.FollowConn:Disconnect() end); ADM.FollowConn = nil end
        elseif cmd == "blind" then
            if not matchesLocalTarget(a1, sender, false) then return end
            setBlind(true)
        elseif cmd == "unblind" then
            if not matchesLocalTarget(a1, sender, true) then return end
            setBlind(false)
        elseif cmd == "dance" then
            if not matchesLocalTarget(a1, sender, false) then return end
            pcall(function() snd2("/e dance") end)
        elseif cmd == "say" or cmd == "chat" then
            if not a1 or restAfter2 == "" then return end
            if not matchesLocalTarget(a1, sender, false) then return end
            pcall(function() snd2(restAfter2) end)
        elseif cmd == "kick" then
            if not matchesLocalTarget(a1, sender, false) then return end
            local reason = (restAfter2 ~= "") and restAfter2 or ("Kicked by Jamun Owner (" .. JAMUN_OWNER_DISPLAY .. ")")
            LP:Kick(reason)
        elseif cmd == "rejoin" or cmd == "rj" then
            if not a1 then
                if isJamunOwner(LP) then
                    pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP) end)
                end
                return
            end
            if not matchesLocalTarget(a1, sender, true) then return end
            pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP) end)
        elseif cmd == "unweld" then
            if not matchesLocalTarget(a1, sender, true) then return end
            stopAdminLoops()
            pcall(stopWeld)
        elseif WELD_PRESETS[cmd] then
            if not matchesLocalTarget(a1, sender, false) then return end
            local victim = (a2 and findPlayerByToken(a2)) or sender
            if victim and victim ~= LP then
                stopAdminLoops()
                pcall(applyWeldPreset, cmd, victim, StopGeneration)
            end
        end
    end

    -- Hook TextChatService (modern Roblox chat)
    pcall(function()
        if TC then
            table.insert(ADM.Connections, TC.MessageReceived:Connect(function(tcm)
                if not tcm or not tcm.TextSource then return end
                if tcm.Status and tcm.Status ~= Enum.TextChatMessageStatus.Success and tcm.Status ~= Enum.TextChatMessageStatus.Sending then
                    return
                end
                local sender = P:GetPlayerByUserId(tcm.TextSource.UserId)
                if sender then
                    pcall(handleOwnerCommand, sender, tcm.Text)
                end
            end))
        end
    end)

    -- Hook Legacy Player.Chatted (fallback & classic chat games)
    local function hookPlayerChat(plr)
        if not plr then return end
        table.insert(ADM.Connections, plr.Chatted:Connect(function(msg)
            pcall(handleOwnerCommand, plr, msg)
        end))
    end
    for _, plr in ipairs(P:GetPlayers()) do hookPlayerChat(plr) end
    table.insert(ADM.Connections, P.PlayerAdded:Connect(hookPlayerChat))

    function ADM.Destroy()
        ADM.Running = false
        stopAdminLoops()
        setNoclip(false)
        setBlind(false)
        for _, c in ipairs(ADM.Connections) do pcall(function() c:Disconnect() end) end
        ADM.Connections = {}
    end

    if isJamunOwner(LP) then
        task.defer(function()
            admNotify("Jamun Owner Loaded", "Welcome " .. JAMUN_OWNER_DISPLAY .. " (@" .. JAMUN_OWNER_USERNAME .. ") · Type ;cmds", 5)
        end)
    end
end)()

-- ============================================================================
local function __jamunBuildUI()
-- SCREEN GUI
-- ============================================================================
pcall(function()
    local roots = {}
    if typeof(gethui) == "function" then
        local h = gethui(); if h then table.insert(roots, h) end
    end
    pcall(function() table.insert(roots, game:GetService("CoreGui")) end)
    if PG then table.insert(roots, PG) end
    if LP and LP:FindFirstChild("PlayerGui") then table.insert(roots, LP.PlayerGui) end
    for _, r in ipairs(roots) do
        local old = r:FindFirstChild("JamunWelder")
        if old then pcall(function() old:Destroy() end) end
    end
end)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JamunWelder"; ScreenGui.ResetOnSpawn = false; ScreenGui.IgnoreGuiInset = true; ScreenGui.DisplayOrder = 100
-- Delta-friendly parent order: gethui → CoreGui → PlayerGui
pcall(function()
    local h = (typeof(gethui) == "function" and gethui()) or nil
    if h then ScreenGui.Parent = h end
end)
if not ScreenGui.Parent then
    pcall(function()
        local cg = game:GetService("CoreGui")
        if typeof(cloneref) == "function" then cg = cloneref(cg) end
        ScreenGui.Parent = cg
    end)
end
if not ScreenGui.Parent then
    pcall(function()
        local pg = PG or (LP and LP:FindFirstChild("PlayerGui"))
        if pg then ScreenGui.Parent = pg end
    end)
end
if not ScreenGui.Parent then
    warn("[Jamun Welder] cannot parent ScreenGui — aborting UI")
    print("[Jamun Welder] cannot parent ScreenGui — aborting UI")
    return
end
print("[Jamun Welder] ScreenGui parented to", ScreenGui.Parent.Name)

local RIYON_BG_IMAGE = "rbxassetid://72660622902200"

local Backdrop = Instance.new("Frame")
Backdrop.Name = "Backdrop"
Backdrop.Size = UDim2.fromScale(1, 1)
Backdrop.BackgroundColor3 = C.glassTint
Backdrop.BackgroundTransparency = 0.62
Backdrop.BorderSizePixel = 0
Backdrop.Visible = false
Backdrop.Parent = ScreenGui

local W, H = 510, 540
local Holder = Instance.new("Frame")
Holder.Name = "Holder"
Holder.BackgroundTransparency = 1
Holder.Size = UDim2.fromScale(1, 1)
Holder.Position = UDim2.fromOffset(0, 0)
Holder.Parent = ScreenGui
local PanelScale = Instance.new("UIScale")
PanelScale.Scale = 1
PanelScale.Parent = Holder

-- ── Riyon MainGUI Window ──────────────────────────────────────────────────
local Panel = Instance.new("Frame")
Panel.Name = "MainGUI"
Panel.Size = UDim2.fromOffset(W, H)
Panel.AnchorPoint = Vector2.new(0.5, 0.5)
Panel.Position = UDim2.fromScale(0.5, 0.52)
Panel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Panel.BackgroundTransparency = 0.02
Panel.BorderSizePixel = 0
Panel.Active = true
Panel.Visible = false
Panel.ClipsDescendants = true
Panel.Parent = Holder
corner(Panel, 16)

local panelGrad = Instance.new("UIGradient")
panelGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 24, 24)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 8)),
})
panelGrad.Rotation = 90
panelGrad.Parent = Panel

local PanelBgImg = Instance.new("ImageLabel")
PanelBgImg.Name = "BgImage"
PanelBgImg.Size = UDim2.fromScale(1, 1)
PanelBgImg.Position = UDim2.fromOffset(0, 0)
PanelBgImg.BackgroundTransparency = 1
PanelBgImg.Image = RIYON_BG_IMAGE
PanelBgImg.ImageColor3 = C.accent
PanelBgImg.ImageTransparency = 0.58
PanelBgImg.ScaleType = Enum.ScaleType.Crop
PanelBgImg.ZIndex = 0
PanelBgImg.Parent = Panel
corner(PanelBgImg, 16)

local panelStroke = stroke(Panel, C.accent, 1.5, 0)
local borderShimGrad = Instance.new("UIGradient")
borderShimGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0.0, 1),
    NumberSequenceKeypoint.new(0.2, 0.6),
    NumberSequenceKeypoint.new(0.5, 0),
    NumberSequenceKeypoint.new(0.8, 0.6),
    NumberSequenceKeypoint.new(1.0, 1),
})
borderShimGrad.Rotation = 45
borderShimGrad.Parent = panelStroke
task.spawn(function()
    local angle = 45
    while Panel and Panel.Parent do
        if Panel.Visible then
            angle = (angle + 1.2) % 360
            borderShimGrad.Rotation = angle
        end
        task.wait(0.025)
    end
end)
registerThemed(panelStroke, "accent")

-- ── Riyon Title Bar (38px) ────────────────────────────────────────────────
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Position = UDim2.fromOffset(0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
TitleBar.BackgroundTransparency = 0.35
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 10
TitleBar.Parent = Panel

local titleDivider = Instance.new("Frame")
titleDivider.Size = UDim2.new(1, -24, 0, 1)
titleDivider.Position = UDim2.new(0, 12, 1, -1)
titleDivider.BackgroundColor3 = C.stroke
titleDivider.BackgroundTransparency = 0.35
titleDivider.BorderSizePixel = 0
titleDivider.ZIndex = 11
titleDivider.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "BrandTitle"
Title.Size = UDim2.new(0, 155, 0, 22)
Title.Position = UDim2.new(0, 14, 0.5, -11)
Title.BackgroundTransparency = 1
Title.Text = "✦  JAMUN WELDER"
Title.TextColor3 = Color3.fromRGB(245, 245, 250)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 14
Title.ZIndex = 12
Title.Parent = TitleBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(0, 120, 0, 16)
SubTitle.Position = UDim2.new(0, 172, 0.5, -8)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "v10 · by akash"
SubTitle.TextColor3 = C.text3
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.TextSize = 10
SubTitle.ZIndex = 12
SubTitle.Parent = TitleBar

if isJamunOwner(LP) then
    local ownerChip = Instance.new("TextLabel")
    ownerChip.Size = UDim2.fromOffset(66, 18)
    ownerChip.Position = UDim2.new(0, 260, 0.5, -9)
    ownerChip.BackgroundColor3 = Color3.fromRGB(40, 30, 8)
    ownerChip.BackgroundTransparency = 0.15
    ownerChip.Text = "♛ OWNER"
    ownerChip.TextColor3 = Color3.fromRGB(255, 215, 120)
    ownerChip.Font = Enum.Font.GothamBlack
    ownerChip.TextSize = 9
    ownerChip.ZIndex = 12
    ownerChip.Parent = TitleBar
    corner(ownerChip, 100)
    stroke(ownerChip, Color3.fromRGB(255, 215, 120), 1, 0.35)
end

local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Size = UDim2.fromOffset(24, 24)
MinBtn.Position = UDim2.new(1, -60, 0.5, -12)
MinBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
MinBtn.BackgroundTransparency = 0.15
MinBtn.BorderSizePixel = 0
MinBtn.Text = "—"
MinBtn.TextColor3 = C.text2
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 12
MinBtn.AutoButtonColor = false
MinBtn.ZIndex = 12
MinBtn.Parent = TitleBar
corner(MinBtn, 12)
stroke(MinBtn, C.stroke, 1, 0.35)
hov(MinBtn)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.fromOffset(24, 24)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 18, 20)
CloseBtn.BackgroundTransparency = 0.15
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 140, 140)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 15
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 12
CloseBtn.Parent = TitleBar
corner(CloseBtn, 12)
stroke(CloseBtn, Color3.fromRGB(160, 55, 55), 1, 0.35)

-- ── Layout Metrics & Content Area ─────────────────────────────────────────
local PAD = 14
local HEADER_H = 44
local DOCK_H = 44
local innerW = W - PAD * 2

local Content = Instance.new("Frame")
Content.Name = "ContentArea"
Content.Size = UDim2.new(1, -PAD * 2, 1, -(HEADER_H + DOCK_H + PAD + 8))
Content.Position = UDim2.new(0, PAD, 0, HEADER_H + 6)
Content.BackgroundTransparency = 1
Content.ClipsDescendants = true
Content.ZIndex = 2
Content.Parent = Panel

-- ── Riyon Bottom Navigation Dock ──────────────────────────────────────────
local TabTrack = Instance.new("Frame")
TabTrack.Name = "BottomDock"
TabTrack.Size = UDim2.new(1, -PAD * 2, 0, DOCK_H)
TabTrack.Position = UDim2.new(0, PAD, 1, -(DOCK_H + 10))
TabTrack.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
TabTrack.BackgroundTransparency = 0.08
TabTrack.BorderSizePixel = 0
TabTrack.ClipsDescendants = true
TabTrack.ZIndex = 10
TabTrack.Parent = Panel
corner(TabTrack, 14)
local dockStroke = stroke(TabTrack, C.accent, 1.2, 0.55)

local dockBgImg = Instance.new("ImageLabel")
dockBgImg.Name = "DockBgImage"
dockBgImg.Size = UDim2.fromScale(1, 1)
dockBgImg.BackgroundTransparency = 1
dockBgImg.Image = RIYON_BG_IMAGE
dockBgImg.ImageColor3 = C.accent
dockBgImg.ImageTransparency = 0.68
dockBgImg.ScaleType = Enum.ScaleType.Crop
dockBgImg.ZIndex = 10
dockBgImg.Parent = TabTrack
corner(dockBgImg, 14)

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -12, 1, -10)
TabBar.Position = UDim2.fromOffset(6, 5)
TabBar.BackgroundTransparency = 1
TabBar.ZIndex = 11
TabBar.Parent = TabTrack

local TabList = Instance.new("UIListLayout")
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.VerticalAlignment = Enum.VerticalAlignment.Center
TabList.Padding = UDim.new(0, 6)
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = TabBar

local tabOrder = {"target", "character", "chat", "others", "reanim"}
local tabName = {
    target    = "Target",
    character = "Character",
    chat      = "Chat",
    others    = "Others",
    reanim    = "Reanim",
}
local tabs, pages = {}, {}
local tabW = math.floor((innerW - 12 - 6 * 4) / 5)
for i, n in ipairs(tabOrder) do
    local b = BTN(TabBar, tabName[n])
    b.Size = UDim2.fromOffset(tabW, DOCK_H - 10)
    b.LayoutOrder = i
    b.TextSize = 11
    b.TextColor3 = C.text2
    b.ZIndex = 12
    corner(b, 10)
    tabs[n] = b

    local p
    if n == "reanim" then
        p = Instance.new("Frame")
        p.Size = UDim2.fromScale(1, 1)
        p.BackgroundTransparency = 1
        p.BorderSizePixel = 0
        p.Visible = false
        p.ClipsDescendants = true
        p.Parent = Content
    else
        p = Instance.new("ScrollingFrame")
        p.Size = UDim2.fromScale(1, 1)
        p.BackgroundTransparency = 1
        p.BorderSizePixel = 0
        p.Visible = false
        p.ScrollBarThickness = 3
        p.ScrollBarImageColor3 = C.accent
        p.CanvasSize = UDim2.fromOffset(0, 800)
        p.Parent = Content
    end
    pages[n] = p
end

local built, tabBuilders = {}, {}
local function selectTab(n)
    play(SND.tab)
    for k, v in pairs(tabs) do
        local on = (k == n)
        setToggle(v, on)
        if on then
            v.TextColor3 = Color3.fromRGB(8, 8, 12)
        end
        pcall(function()
            local font = C.font or Enum.Font.GothamBold
            v.Font = on and Enum.Font.GothamBold or font
            if C.fontFace then v.FontFace = C.fontFace end
        end)
    end
    for k, v in pairs(pages) do v.Visible = (k == n) end
    if not built[n] and tabBuilders[n] then built[n] = true; tabBuilders[n]() end
end
for _, n in ipairs(tabOrder) do onClick(tabs[n], function() selectTab(n) end) end

-- ── Riyon Minimized Bottom Capsule ────────────────────────────────────────
local MinimizedCapsule = Instance.new("TextButton")
MinimizedCapsule.Name = "MinimizedCapsule"
MinimizedCapsule.Size = UDim2.fromOffset(210, 38)
MinimizedCapsule.AnchorPoint = Vector2.new(0.5, 1)
MinimizedCapsule.Position = UDim2.new(0.5, 0, 1, -16)
MinimizedCapsule.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
MinimizedCapsule.BackgroundTransparency = 0.06
MinimizedCapsule.BorderSizePixel = 0
MinimizedCapsule.Text = ""
MinimizedCapsule.AutoButtonColor = false
MinimizedCapsule.Visible = false
MinimizedCapsule.ZIndex = 90
MinimizedCapsule.Parent = ScreenGui
corner(MinimizedCapsule, 100)
local minCapStroke = stroke(MinimizedCapsule, C.accent, 1.4, 0.25)

;(function()
    local mcLayout = Instance.new("UIListLayout", MinimizedCapsule)
    mcLayout.FillDirection = Enum.FillDirection.Horizontal
    mcLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    mcLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    mcLayout.Padding = UDim.new(0, 9)
    mcLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local mcBrand = Instance.new("TextLabel", MinimizedCapsule)
    mcBrand.Size = UDim2.fromOffset(48, 18)
    mcBrand.BackgroundTransparency = 1
    mcBrand.Text = "JAMUN"
    mcBrand.Font = Enum.Font.GothamBlack
    mcBrand.TextSize = 11
    mcBrand.TextColor3 = Color3.fromRGB(245, 245, 250)
    mcBrand.LayoutOrder = 1
    mcBrand.ZIndex = 91

    local mcSep = Instance.new("Frame", MinimizedCapsule)
    mcSep.Size = UDim2.fromOffset(1, 14)
    mcSep.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    mcSep.BackgroundTransparency = 0.78
    mcSep.BorderSizePixel = 0
    mcSep.LayoutOrder = 2
    mcSep.ZIndex = 91

    local mcAv = Instance.new("ImageLabel", MinimizedCapsule)
    mcAv.Size = UDim2.fromOffset(22, 22)
    mcAv.BackgroundTransparency = 1
    mcAv.LayoutOrder = 3
    mcAv.ZIndex = 91
    corner(mcAv, 100)
    pcall(function()
        mcAv.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LP.UserId) .. "&w=150&h=150"
    end)

    local mcName = Instance.new("TextLabel", MinimizedCapsule)
    mcName.BackgroundTransparency = 1
    mcName.Size = UDim2.new(0, 0, 1, 0)
    mcName.AutomaticSize = Enum.AutomaticSize.X
    mcName.Text = LP.DisplayName
    mcName.Font = Enum.Font.GothamMedium
    mcName.TextSize = 11
    mcName.TextColor3 = Color3.fromRGB(235, 235, 242)
    mcName.LayoutOrder = 4
    mcName.ZIndex = 91
end)()

-- ── OPEN / CLOSE / MINIMIZE ───────────────────────────────────────────────
local open = false
local function setOpen(state, toMinimized)
    open = state
    if open then
        MinimizedCapsule.Visible = false
        Backdrop.Visible = true
        Panel.Visible = true
        Panel.BackgroundTransparency = 0.85
        TW:Create(Panel, TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundTransparency = 0.02 }):Play()
        TW:Create(panelStroke, TweenInfo.new(0.22), { Transparency = 0 }):Play()
    else
        local tw = TW:Create(Panel, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In), { BackgroundTransparency = 1 })
        TW:Create(panelStroke, TweenInfo.new(0.18), { Transparency = 1 }):Play()
        tw:Play()
        tw.Completed:Connect(function()
            if open then return end
            Panel.Visible = false
            Backdrop.Visible = false
            Panel.BackgroundTransparency = 0.02
            if toMinimized then
                MinimizedCapsule.Visible = true
            end
        end)
    end
end

onClick(MinBtn, function()
    play(SND.close)
    setOpen(false, true)
end)
onClick(CloseBtn, function()
    play(SND.close)
    setOpen(false, false)
end)
onClick(MinimizedCapsule, function()
    play(SND.open)
    setOpen(true, false)
end)

-- ── Riyon Floating TopCapsule (Status Bar: Brand · FPS · Ping · Target · Active · TAG) ──
local TopCapsule, topCapStroke, topCapBgImg
;(function()
    TopCapsule = Instance.new("ImageLabel")
    TopCapsule.Name = "TopCapsule"
    TopCapsule.AnchorPoint = Vector2.new(0.5, 0)
    TopCapsule.Size = UDim2.fromOffset(310, 38)
    TopCapsule.Position = UDim2.new(0.5, 0, 0, 10)
    TopCapsule.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    TopCapsule.BackgroundTransparency = 0.22
    TopCapsule.BorderSizePixel = 0
    TopCapsule.Image = RIYON_BG_IMAGE
    TopCapsule.ImageColor3 = C.accent
    TopCapsule.ImageTransparency = 0.58
    TopCapsule.ScaleType = Enum.ScaleType.Crop
    TopCapsule.Active = true
    TopCapsule.ZIndex = 100
    TopCapsule.Parent = ScreenGui
    corner(TopCapsule, 18)
    topCapBgImg = TopCapsule

    topCapStroke = stroke(TopCapsule, C.accent, 1.8, 0)
    local tcGrad = Instance.new("UIGradient", topCapStroke)
    tcGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0.0, 1),
        NumberSequenceKeypoint.new(0.2, 0.9),
        NumberSequenceKeypoint.new(0.4, 0.35),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(0.6, 0.35),
        NumberSequenceKeypoint.new(0.8, 0.9),
        NumberSequenceKeypoint.new(1.0, 1),
    })
    RS.RenderStepped:Connect(function(dt)
        if tcGrad and tcGrad.Parent and TopCapsule.Visible then
            tcGrad.Rotation = (tcGrad.Rotation + 45 * dt) % 360
        end
    end)

    -- glowing drag handle pill underneath capsule
    local dragBar = Instance.new("Frame", TopCapsule)
    dragBar.Size = UDim2.fromOffset(30, 3)
    dragBar.Position = UDim2.new(0.5, -15, 1, 2)
    dragBar.BackgroundColor3 = C.accent
    dragBar.BackgroundTransparency = 0.25
    dragBar.BorderSizePixel = 0
    dragBar.ZIndex = 100
    corner(dragBar, 2)
    registerThemed(dragBar, "accent")

    local inner = Instance.new("Frame", TopCapsule)
    inner.Size = UDim2.fromScale(1, 1)
    inner.BackgroundTransparency = 1
    inner.ClipsDescendants = true
    inner.ZIndex = 101
    corner(inner, 18)

    local tcLayout = Instance.new("UIListLayout", inner)
    tcLayout.FillDirection = Enum.FillDirection.Horizontal
    tcLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tcLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    tcLayout.Padding = UDim.new(0, 10)
    tcLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local tcPad = Instance.new("UIPadding", inner)
    tcPad.PaddingLeft = UDim.new(0, 14)
    tcPad.PaddingRight = UDim.new(0, 14)

    -- Brand toggle button inside TopCapsule
    local capBrand = Instance.new("TextButton", inner)
    capBrand.Size = UDim2.fromOffset(52, 22)
    capBrand.BackgroundTransparency = 1
    capBrand.Text = "JAMUN"
    capBrand.Font = Enum.Font.GothamBlack
    capBrand.TextSize = 11
    capBrand.TextColor3 = Color3.fromRGB(245, 245, 250)
    capBrand.AutoButtonColor = false
    capBrand.LayoutOrder = 1
    capBrand.ZIndex = 102
    onClick(capBrand, function()
        play(open and SND.close or SND.open)
        setOpen(not open, false)
    end)

    -- Live FPS label
    local fpsLbl = Instance.new("TextLabel", inner)
    fpsLbl.BackgroundTransparency = 1
    fpsLbl.RichText = true
    fpsLbl.Text = "FPS: <font color=\"#2ECC71\">60</font>"
    fpsLbl.Font = Enum.Font.GothamBold
    fpsLbl.TextSize = 10
    fpsLbl.TextColor3 = Color3.fromRGB(160, 160, 172)
    fpsLbl.AutomaticSize = Enum.AutomaticSize.XY
    fpsLbl.LayoutOrder = 2
    fpsLbl.ZIndex = 102

    -- Live Ping label
    local pingLbl = Instance.new("TextLabel", inner)
    pingLbl.BackgroundTransparency = 1
    pingLbl.RichText = true
    pingLbl.Text = "Ping: <font color=\"#2ECC71\">--</font>"
    pingLbl.Font = Enum.Font.GothamBold
    pingLbl.TextSize = 10
    pingLbl.TextColor3 = Color3.fromRGB(160, 160, 172)
    pingLbl.AutomaticSize = Enum.AutomaticSize.XY
    pingLbl.LayoutOrder = 3
    pingLbl.ZIndex = 102

    -- Live Target Pill (auto-hides when no target selected)
    local tgtPill = Instance.new("Frame", inner)
    tgtPill.Name = "TargetIndicator"
    tgtPill.Size = UDim2.new(0, 0, 0, 22)
    tgtPill.AutomaticSize = Enum.AutomaticSize.X
    tgtPill.BackgroundColor3 = Color3.fromRGB(32, 16, 18)
    tgtPill.BackgroundTransparency = 0.2
    tgtPill.BorderSizePixel = 0
    tgtPill.Visible = false
    tgtPill.LayoutOrder = 4
    tgtPill.ZIndex = 102
    corner(tgtPill, 11)
    stroke(tgtPill, Color3.fromRGB(190, 65, 65), 1, 0.45)
    local tpPad = Instance.new("UIPadding", tgtPill)
    tpPad.PaddingLeft = UDim.new(0, 6); tpPad.PaddingRight = UDim.new(0, 6)
    local tpLay = Instance.new("UIListLayout", tgtPill)
    tpLay.FillDirection = Enum.FillDirection.Horizontal
    tpLay.VerticalAlignment = Enum.VerticalAlignment.Center
    tpLay.Padding = UDim.new(0, 5)

    local tpAv = Instance.new("ImageLabel", tgtPill)
    tpAv.Size = UDim2.fromOffset(15, 15)
    tpAv.BackgroundTransparency = 1
    tpAv.ZIndex = 103
    corner(tpAv, 8)

    local tpTxt = Instance.new("TextLabel", tgtPill)
    tpTxt.BackgroundTransparency = 1
    tpTxt.Size = UDim2.new(0, 0, 1, 0)
    tpTxt.AutomaticSize = Enum.AutomaticSize.X
    tpTxt.RichText = true
    tpTxt.Font = Enum.Font.GothamMedium
    tpTxt.TextSize = 10
    tpTxt.TextColor3 = Color3.fromRGB(220, 220, 228)
    tpTxt.ZIndex = 103

    local tpClear = Instance.new("TextButton", tgtPill)
    tpClear.Size = UDim2.fromOffset(14, 14)
    tpClear.BackgroundColor3 = Color3.fromRGB(65, 20, 22)
    tpClear.BorderSizePixel = 0
    tpClear.Text = "×"
    tpClear.Font = Enum.Font.GothamBold
    tpClear.TextSize = 10
    tpClear.TextColor3 = Color3.fromRGB(255, 150, 150)
    tpClear.AutoButtonColor = false
    tpClear.ZIndex = 104
    corner(tpClear, 7)
    onClick(tpClear, function()
        play(SND.off)
        pcall(stopWeld)
        _G.__jamunAutoReweld = nil
        sel, selId, selName, selDisplay = nil, nil, nil, nil
        tgtPill.Visible = false
    end)

    -- Active Feature Pill (green pulsing dot)
    local featPill = Instance.new("Frame", inner)
    featPill.Name = "ActiveFeaturePill"
    featPill.Size = UDim2.new(0, 0, 0, 20)
    featPill.AutomaticSize = Enum.AutomaticSize.X
    featPill.BackgroundColor3 = Color3.fromRGB(15, 28, 20)
    featPill.BorderSizePixel = 0
    featPill.Visible = false
    featPill.LayoutOrder = 5
    featPill.ZIndex = 102
    corner(featPill, 10)
    stroke(featPill, Color3.fromRGB(60, 180, 100), 1.1, 0.45)
    local fpPad = Instance.new("UIPadding", featPill)
    fpPad.PaddingLeft = UDim.new(0, 8); fpPad.PaddingRight = UDim.new(0, 8)
    local fpLay = Instance.new("UIListLayout", featPill)
    fpLay.FillDirection = Enum.FillDirection.Horizontal
    fpLay.VerticalAlignment = Enum.VerticalAlignment.Center
    fpLay.Padding = UDim.new(0, 5)

    local fpDot = Instance.new("Frame", featPill)
    fpDot.Size = UDim2.fromOffset(6, 6)
    fpDot.BackgroundColor3 = Color3.fromRGB(80, 220, 130)
    fpDot.BorderSizePixel = 0
    fpDot.ZIndex = 103
    corner(fpDot, 3)

    local fpLbl = Instance.new("TextLabel", featPill)
    fpLbl.BackgroundTransparency = 1
    fpLbl.Size = UDim2.new(0, 0, 1, 0)
    fpLbl.AutomaticSize = Enum.AutomaticSize.X
    fpLbl.Font = Enum.Font.GothamBold
    fpLbl.TextSize = 10
    fpLbl.TextColor3 = Color3.fromRGB(80, 220, 130)
    fpLbl.ZIndex = 103

    -- Quick Headtag mini toggle inside TopCapsule (Riyon TAG switch)
    local tagWrap = Instance.new("Frame", inner)
    tagWrap.Size = UDim2.fromOffset(72, 20)
    tagWrap.BackgroundTransparency = 1
    tagWrap.LayoutOrder = 6
    tagWrap.ZIndex = 102

    local tagLbl = Instance.new("TextLabel", tagWrap)
    tagLbl.Size = UDim2.fromOffset(44, 20)
    tagLbl.Position = UDim2.fromOffset(0, 0)
    tagLbl.BackgroundTransparency = 1
    tagLbl.Text = "TAG: ON"
    tagLbl.Font = Enum.Font.GothamBold
    tagLbl.TextSize = 9
    tagLbl.TextColor3 = C.accent
    tagLbl.TextXAlignment = Enum.TextXAlignment.Left
    tagLbl.ZIndex = 103

    local tagSw = Instance.new("TextButton", tagWrap)
    tagSw.Size = UDim2.fromOffset(24, 12)
    tagSw.Position = UDim2.new(1, -24, 0.5, -6)
    tagSw.BackgroundColor3 = C.good
    tagSw.Text = ""
    tagSw.AutoButtonColor = false
    tagSw.ZIndex = 103
    corner(tagSw, 6)

    local tagKnob = Instance.new("Frame", tagSw)
    tagKnob.Size = UDim2.fromOffset(8, 8)
    tagKnob.Position = UDim2.new(1, -10, 0.5, -4)
    tagKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tagKnob.BorderSizePixel = 0
    tagKnob.ZIndex = 104
    corner(tagKnob, 4)

    local function syncCapTag()
        local on = __HT and __HT.Enabled == true
        tagLbl.Text = on and "TAG: ON" or "TAG: OFF"
        tagLbl.TextColor3 = on and C.accent or C.text3
        TW:Create(tagSw, TweenInfo.new(0.16), { BackgroundColor3 = on and C.good or Color3.fromRGB(50, 50, 60) }):Play()
        TW:Create(tagKnob, TweenInfo.new(0.16), { Position = on and UDim2.new(1, -10, 0.5, -4) or UDim2.new(0, 2, 0.5, -4) }):Play()
    end
    onClick(tagSw, function()
        if __HT then
            __HT.SetEnabled(not __HT.Enabled)
            play(__HT.Enabled and SND.on or SND.off)
        end
        syncCapTag()
    end)

    -- Auto-resize TopCapsule width smoothly to fit pills
    local function resizeCapsule()
        local w = tcLayout.AbsoluteContentSize.X + tcPad.PaddingLeft.Offset + tcPad.PaddingRight.Offset
        w = math.max(w, 160)
        TW:Create(TopCapsule, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(w, 38)
        }):Play()
    end
    tcLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeCapsule)
    task.defer(resizeCapsule)

    -- Draggable TopCapsule
    local capDrag, capStart, capPos0 = false, nil, nil
    TopCapsule.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            capDrag = true; capStart = i.Position; capPos0 = TopCapsule.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if capDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - capStart
            TopCapsule.Position = UDim2.new(capPos0.X.Scale, capPos0.X.Offset + d.X, capPos0.Y.Scale, capPos0.Y.Offset + d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            capDrag = false
        end
    end)

    -- Poll live stats, target, active feature, and tag state
    local lastCapTargetId = nil
    registerUIPoller(function()
        local fCol = (fps_val >= 55 and "#2ECC71") or (fps_val >= 30 and "#F1C40F") or "#E74C3C"
        fpsLbl.Text = "FPS: <font color=\"" .. fCol .. "\">" .. tostring(fps_val) .. "</font>"
        local pCol = (ping_val <= 60 and "#2ECC71") or (ping_val <= 120 and "#F1C40F") or "#E74C3C"
        pingLbl.Text = "Ping: <font color=\"" .. pCol .. "\">" .. tostring(ping_val) .. "ms</font>"

        if sel and sel.Parent == P then
            if lastCapTargetId ~= sel.UserId then
                lastCapTargetId = sel.UserId
                tpTxt.Text = "<font color=\"rgb(255,110,110)\">" .. tostring(sel.DisplayName or sel.Name) .. "</font>"
                pcall(function()
                    tpAv.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(sel.UserId) .. "&w=150&h=150"
                end)
            end
            tgtPill.Visible = true
        else
            lastCapTargetId = nil
            tgtPill.Visible = false
        end

        local activeLabel = nil
        if CurrentWeld and WeldIntent.presetKey then
            activeLabel = CLICK_PRESET_LABEL[WeldIntent.presetKey] or WeldIntent.presetKey
        elseif _G.JamunAnimCopy and _G.JamunAnimCopy.active then
            activeLabel = "Copy Anim"
        elseif FLY.active then
            activeLabel = "Fly"
        end
        if activeLabel then
            fpLbl.Text = activeLabel
            featPill.Visible = true
        else
            featPill.Visible = false
        end
        syncCapTag()
    end)
    syncCapTag()
end)()

-- ── Theme Retint & Responsive Mobile Fit ──────────────────────────────────
retintPanel = function()
    local sdef = SHADERS[currentThemeName] or {}
    local font = sdef.font or C.font or Enum.Font.GothamMedium
    C.font = font
    local face = currentFontFace or C.fontFace or fontFaceFrom(font, THEME_FACE_HINTS[currentThemeName])
    C.fontFace = face
    currentFontFace = face

    pcall(function()
        panelStroke.Color = C.accent
        PanelBgImg.ImageColor3 = C.accent
        panelGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, C.glassTile:Lerp(C.accent, 0.08)),
            ColorSequenceKeypoint.new(1, C.glassBg),
        })
        if dockStroke then dockStroke.Color = C.accent end
        if dockBgImg then dockBgImg.ImageColor3 = C.accent end
        if topCapStroke then topCapStroke.Color = C.accent end
        if topCapBgImg then topCapBgImg.ImageColor3 = C.accent end
        if minCapStroke then minCapStroke.Color = C.accent end
        if Backdrop then Backdrop.BackgroundColor3 = C.glassTint end
    end)

    pcall(function()
        local side = ScreenGui:FindFirstChild("JamunSideToggle")
        if side and side:IsA("TextButton") then
            side.BackgroundColor3 = C.glassBg
            side.TextColor3 = C.accent
            local st = side:FindFirstChildOfClass("UIStroke")
            if st then st.Color = C.accent end
        end
    end)

    pcall(function()
        for _, d in ipairs(Panel:GetDescendants()) do
            if d:IsA("TextBox") then
                d.BackgroundColor3 = C.glassInput
                d.TextColor3 = C.text
                d.PlaceholderColor3 = C.text3
                applyTextFont(d, font, face)
            elseif d:IsA("TextButton") then
                local selected = d.TextColor3.R < 0.2 and d.TextColor3.G < 0.2 and d.BackgroundTransparency < 0.2
                if selected then
                    d.BackgroundColor3 = C.accent
                    d.TextColor3 = Color3.fromRGB(8, 8, 12)
                else
                    if d.BackgroundTransparency <= 0.35 and d.Name ~= "CloseBtn" then
                        d.BackgroundColor3 = C.glassInput
                    end
                    if d.Name ~= "CloseBtn" then
                        if d.TextColor3.R > 0.5 then d.TextColor3 = C.text
                        elseif d.TextColor3.R > 0.3 then d.TextColor3 = C.text2 end
                    end
                end
                applyTextFont(d, font, face)
                local st = d:FindFirstChildOfClass("UIStroke")
                if st and d.Name ~= "CloseBtn" then
                    st.Color = selected and C.accent or C.stroke
                end
            elseif d:IsA("TextLabel") then
                local tc = d.TextColor3
                if tc.R > 0.7 and tc.G > 0.7 then d.TextColor3 = C.text
                elseif tc.R > 0.4 and tc.G > 0.4 then d.TextColor3 = C.text2
                elseif tc.R > 0.25 then d.TextColor3 = C.text3 end
                applyTextFont(d, font, face)
            elseif d:IsA("Frame") then
                if d.Name == "BottomDock" then
                    d.BackgroundColor3 = C.glassTile
                elseif d.BackgroundTransparency <= 0.25 and d.BackgroundTransparency >= 0 then
                    local bc = d.BackgroundColor3
                    if bc.R < 0.25 and bc.G < 0.25 and bc.B < 0.3 then
                        d.BackgroundColor3 = C.glassTile
                    end
                end
                local st = d:FindFirstChildOfClass("UIStroke")
                if st and st.Thickness <= 1.6 then st.Color = C.stroke end
            elseif d:IsA("ScrollingFrame") then
                d.ScrollBarImageColor3 = C.accent
            end
        end
    end)

    if type(_G.__jamunRetintReanim) == "function" then pcall(_G.__jamunRetintReanim) end
end

applyMobileFit = function()
    if panelSizeUser then return end
    local cam = WS.CurrentCamera
    local vp = cam and cam.ViewportSize or Vector2.new(1280, 720)
    local padX, padY = 28, 74
    local sx = (vp.X - padX) / W
    local sy = (vp.Y - padY) / H
    local s = math.clamp(math.min(sx, sy), 0.38, 1.0)
    pcall(function()
        PanelScale.Scale = s
        Panel.AnchorPoint = Vector2.new(0.5, 0.5)
        Panel.Position = UDim2.fromScale(0.5, 0.53)
    end)
end

pcall(function()
    local cam = WS.CurrentCamera
    if cam then
        cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            if applyMobileFit then pcall(applyMobileFit) end
        end)
    end
    WS:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        local nc = WS.CurrentCamera
        if nc then
            pcall(function()
                nc:GetPropertyChangedSignal("ViewportSize"):Connect(function()
                    if applyMobileFit then pcall(applyMobileFit) end
                end)
            end)
            if applyMobileFit then pcall(applyMobileFit) end
        end
    end)
end)

-- ============================================================================
-- TARGET TAB
-- ============================================================================

-- HOISTED ANTI VC SOURCE --
local __antiVCSource = [[
-- language: Lua, file: anti_vc_bypass.lua, target: Roblox executor
-- Anti-VC Bypass · extracted from Zen/Eternity VC Bypass (cleaned)
-- Flow: joinVoice → wait unmute → leaveVoice → disable StateChanged hooks → rejoin → swap mic button

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RRS = game:GetService("RobloxReplicatedStorage")

local cloneref_ = (typeof(cloneref) == "function" and cloneref) or function(x) return x end
local clonefunction_ = (typeof(clonefunction) == "function" and clonefunction) or function(f) return f end

local function notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "Anti-VC",
            Text = text or "",
            Duration = 4,
        })
    end)
    print("[Anti-VC]", title, text)
end

local function findMicButton()
    for _, d in ipairs(CoreGui:GetDescendants()) do
        if d.Name == "toggle_mic_mute" then
            return d, d.Parent
        end
    end
    return nil, nil
end

local function getMicIcon(btn)
    return (btn or error("no mic btn"))
        :WaitForChild("IntegrationIconFrame", 15)
        :WaitForChild("IntegrationIcon", 15)["1"]
end

local MUTED_ICON = "rbxasset://textures/ui/VoiceChat/MicLight/Muted.png"

local function run()
    local VoiceChatService = cloneref_(game:GetService("VoiceChatService"))
    local VoiceChatInternal = cloneref_(game:GetService("VoiceChatInternal"))

    local getconns = clonefunction_(getconnections)
    local stash = Instance.new("Folder")
    stash.Name = "AntiVC_Stash"
    stash.Parent = RRS

    local micBtn, micParent = findMicButton()

    local function isPublishPaused()
        return VoiceChatInternal:IsPublishPaused()
    end

    local function setPublishPaused(paused)
        VoiceChatInternal:PublishPause(paused)
    end

    -- if mic UI missing, join voice first so Roblox creates it
    if not micBtn then
        pcall(function() VoiceChatService:joinVoice() end)
        task.wait(1)
        if micParent then
            micBtn = micParent:WaitForChild("toggle_mic_mute", 15)
        else
            micBtn, micParent = findMicButton()
        end
        if not micBtn then
            error("Mic button not found after joinVoice")
        end
    end

    notify("Anti-VC", "Unmute your mic when prompted, then wait…")

    -- wait until user unmutes (icon no longer Muted)
    repeat
        task.wait(0.5)
        local ok, icon = pcall(getMicIcon, micBtn)
        if not ok or not icon then
            -- mic may have been rebuilt
            micBtn, micParent = findMicButton()
            if not micBtn then
                error("Mic button lost while waiting for unmute")
            end
        else
            if icon.Image ~= MUTED_ICON then
                break
            end
        end
    until false

    -- leave, strip StateChanged listeners, rejoin
    pcall(function() VoiceChatService:leaveVoice() end)
    task.wait(2)

    local okConns, conns = pcall(function()
        return getconns(VoiceChatInternal.StateChanged)
    end)
    if okConns and type(conns) == "table" then
        -- Eternity disables from index 7 upward (skip early internal handlers)
        for i = 7, #conns do
            if conns[i] then
                pcall(function() conns[i]:Disable() end)
            end
        end
    end

    task.wait(2)
    pcall(function() VoiceChatService:joinVoice() end)

    -- re-acquire mic after rejoin
    task.wait(0.5)
    if micParent then
        pcall(function()
            micBtn = micParent:WaitForChild("toggle_mic_mute", 15)
        end)
    end
    if not micBtn or not micBtn.Parent then
        micBtn, micParent = findMicButton()
    end

    if micBtn and micParent then
        -- move original mic into stash, put clone in UI
        local clone = micBtn:Clone()
        micBtn.Parent = stash
        clone.Name = "toggle_mic_mute_new"
        clone.Parent = micParent

        local cloneIcon = getMicIcon(clone)
        local origIcon = getMicIcon(micBtn)

        -- start paused (looks muted)
        setPublishPaused(true)
        cloneIcon.Image = MUTED_ICON

        local hit = clone:WaitForChild("IconHitArea_toggle_mic_mute", 15)
        if hit then
            hit.Activated:Connect(function()
                local nowPaused = not isPublishPaused()
                setPublishPaused(nowPaused)
                if nowPaused then
                    cloneIcon.Image = MUTED_ICON
                else
                    cloneIcon.Image = origIcon.Image
                end
            end)
        end
    end

    notify("Anti-VC", "Active — use the mic button to publish/unpublish")
    getgenv().AntiVCActive = true
    return true
end

local ok, err = pcall(run)
if not ok then
    notify("Anti-VC Error", tostring(err))
    warn("[Anti-VC]", err)
end
]]
_G.__jamunAntiVCSource = __antiVCSource

tabBuilders.target = function()
    local page = pages.target
    page.CanvasSize = UDim2.fromOffset(0, 980)
    local tgtInput = nil -- forward-declared so Copy Anim section can read it

    -- sub-sections like reanim (Weld / Settings)
    local subBar = Instance.new("Frame")
    subBar.Size = UDim2.new(1, 0, 0, 30)
    subBar.Position = UDim2.fromOffset(0, 0)
    subBar.BackgroundColor3 = C.glassTile
    subBar.BackgroundTransparency = 0.2
    subBar.BorderSizePixel = 0
    subBar.Parent = page
    corner(subBar, 10)
    stroke(subBar, C.stroke, 1, 0.55)

    local weldSecBtn = BTN(subBar, "Weld")
    weldSecBtn.Size = UDim2.new(1/3, -6, 1, -6)
    weldSecBtn.Position = UDim2.new(0, 3, 0, 3)
    weldSecBtn.TextSize = 11
    hov(weldSecBtn)

    local copySecBtn = BTN(subBar, "Copy Anim")
    copySecBtn.Size = UDim2.new(1/3, -6, 1, -6)
    copySecBtn.Position = UDim2.new(1/3, 3, 0, 3)
    copySecBtn.TextSize = 11
    hov(copySecBtn)

    local setSecBtn = BTN(subBar, "Settings")
    setSecBtn.Size = UDim2.new(1/3, -6, 1, -6)
    setSecBtn.Position = UDim2.new(2/3, 3, 0, 3)
    setSecBtn.TextSize = 11
    hov(setSecBtn)

    local weldHost = Instance.new("Frame")
    weldHost.Name = "WeldSection"
    weldHost.Size = UDim2.new(1, 0, 0, 900)
    weldHost.Position = UDim2.fromOffset(0, 38)
    weldHost.BackgroundTransparency = 1
    weldHost.Parent = page

    local copyHost = Instance.new("Frame")
    copyHost.Name = "CopyAnimSection"
    copyHost.Size = UDim2.new(1, 0, 0, 900)
    copyHost.Position = UDim2.fromOffset(0, 38)
    copyHost.BackgroundTransparency = 1
    copyHost.Visible = false
    copyHost.Parent = page

    local settingsHost = Instance.new("Frame")
    settingsHost.Name = "SettingsSection"
    settingsHost.Size = UDim2.new(1, 0, 0, 900)
    settingsHost.Position = UDim2.fromOffset(0, 38)
    settingsHost.BackgroundTransparency = 1
    settingsHost.Visible = false
    settingsHost.Parent = page

    local function showTargetSec(which)
        weldHost.Visible = which == "weld"
        copyHost.Visible = which == "copy"
        settingsHost.Visible = which == "settings"
        setToggle(weldSecBtn, which == "weld")
        setToggle(copySecBtn, which == "copy")
        setToggle(setSecBtn, which == "settings")
        for _,pair in ipairs({{weldSecBtn,"weld"},{copySecBtn,"copy"},{setSecBtn,"settings"}}) do
            if which == pair[2] then pair[1].TextColor3 = Color3.fromRGB(8,8,12) end
            pcall(function()
                local f=C.font or Enum.Font.GothamMedium
                pair[1].Font=f
                if C.fontFace then pair[1].FontFace=C.fontFace end
            end)
        end
        play(SND.tab)
    end
    onClick(weldSecBtn, function() showTargetSec("weld") end)
    onClick(copySecBtn, function() showTargetSec("copy") end)
    onClick(setSecBtn, function() showTargetSec("settings") end)
    showTargetSec("weld")

    -- ═══════════════════════════════════════════
    -- COPY ANIM SECTION (uses weld target)
    -- ═══════════════════════════════════════════
    do
        local note = glassTile(copyHost)
        note.Size = UDim2.new(1, 0, 0, 36)
        note.Position = UDim2.fromOffset(0, 0)
        local noteL = L(note, "Mirror target animations live · pick target in Weld tab", 11, C.accent)
        noteL.Size = UDim2.new(1, -16, 1, 0)
        noteL.Position = UDim2.fromOffset(12, 0)
        noteL.Font = Enum.Font.GothamBold
        pcall(function() if C.fontFace then noteL.FontFace = C.fontFace end end)

        local statusCard = glassTile(copyHost)
        statusCard.Size = UDim2.new(1, 0, 0, 44)
        statusCard.Position = UDim2.fromOffset(0, 44)
        local acStatus = L(statusCard, "idle · pick target in Weld", 11, C.text3)
        acStatus.Size = UDim2.new(1, -16, 1, 0)
        acStatus.Position = UDim2.fromOffset(12, 0)

        local modeTitle = L(copyHost, "Alignment", 12, C.text)
        modeTitle.Size = UDim2.new(1, 0, 0, 16)
        modeTitle.Position = UDim2.fromOffset(0, 98)

        local modes = {
            {"right","Right"},{"left","Left"},{"front","Front"},{"back","Back"},
            {"weld","Weld"},{"above","Above"},{"orbit","Orbit"},{"free","Free"},
        }
        local modeBtns = {}
        local modeW = math.floor((innerW - 18) / 4)
        local function setMode(id)
            local sys = _G.JamunAnimCopy
            if sys then sys.sideMode = id end
            for mid, b in pairs(modeBtns) do setToggle(b, mid == id) end
        end
        for i, m in ipairs(modes) do
            local col = (i-1) % 4
            local row = math.floor((i-1) / 4)
            local b = BTN(copyHost, m[2])
            b.Size = UDim2.fromOffset(modeW, 30)
            b.Position = UDim2.fromOffset(col * (modeW + 6), 118 + row * 36)
            b.TextSize = 11
            hov(b)
            modeBtns[m[1]] = b
            onClick(b, function() setMode(m[1]); play(SND.click) end)
        end
        setMode("right")

        local distTitle = L(copyHost, "Distance", 12, C.text)
        distTitle.Size = UDim2.new(1, 0, 0, 16)
        distTitle.Position = UDim2.fromOffset(0, 198)
        local distCard = glassTile(copyHost)
        distCard.Size = UDim2.new(1, 0, 0, 48)
        distCard.Position = UDim2.fromOffset(0, 218)
        local distVal = L(distCard, "3.2", 12, C.text)
        distVal.Size = UDim2.fromOffset(48, 20)
        distVal.Position = UDim2.new(1, -56, 0, 14)
        distVal.TextXAlignment = Enum.TextXAlignment.Right
        local distMinus = BTN(distCard, "−")
        distMinus.Size = UDim2.fromOffset(36, 28)
        distMinus.Position = UDim2.fromOffset(12, 10)
        hov(distMinus)
        local distPlus = BTN(distCard, "+")
        distPlus.Size = UDim2.fromOffset(36, 28)
        distPlus.Position = UDim2.fromOffset(54, 10)
        hov(distPlus)
        local function bumpDist(d)
            local sys = _G.JamunAnimCopy
            local cur = (sys and sys.sideDistance) or 3.2
            cur = math.clamp(cur + d, 0.5, 20)
            if sys then sys.sideDistance = cur end
            distVal.Text = string.format("%.1f", cur)
        end
        onClick(distMinus, function() bumpDist(-0.5) end)
        onClick(distPlus, function() bumpDist(0.5) end)

        local optY = 278
        local spinBtn = BTN(copyHost, "Spin: OFF")
        spinBtn.Size = UDim2.new(0.5, -4, 0, 32)
        spinBtn.Position = UDim2.fromOffset(0, optY)
        hov(spinBtn)
        local motorBtn = BTN(copyHost, "Motors: ON")
        motorBtn.Size = UDim2.new(0.5, -4, 0, 32)
        motorBtn.Position = UDim2.new(0.5, 4, 0, optY)
        hov(motorBtn)
        onClick(spinBtn, function()
            local sys = _G.JamunAnimCopy
            if not sys then return end
            sys.spinMode = not sys.spinMode
            spinBtn.Text = sys.spinMode and "Spin: ON" or "Spin: OFF"
            setToggle(spinBtn, sys.spinMode)
        end)
        onClick(motorBtn, function()
            local sys = _G.JamunAnimCopy
            if not sys then return end
            sys.syncMotorTransforms = not sys.syncMotorTransforms
            motorBtn.Text = sys.syncMotorTransforms and "Motors: ON" or "Motors: OFF"
            setToggle(motorBtn, sys.syncMotorTransforms)
        end)
        setToggle(motorBtn, true)

        local startBtn = BTN(copyHost, "START COPY")
        startBtn.Size = UDim2.new(0.5, -4, 0, 40)
        startBtn.Position = UDim2.fromOffset(0, optY + 44)
        startBtn.TextSize = 13
        startBtn.Font = Enum.Font.GothamBold
        startBtn.BackgroundColor3 = C.accent
        startBtn.BackgroundTransparency = 0.1
        startBtn.TextColor3 = Color3.fromRGB(8, 8, 12)
        hov(startBtn)
        local stopBtn = BTN(copyHost, "STOP")
        stopBtn.Size = UDim2.new(0.5, -4, 0, 40)
        stopBtn.Position = UDim2.new(0.5, 4, 0, optY + 44)
        stopBtn.TextSize = 13
        stopBtn.BackgroundColor3 = C.danger
        stopBtn.BackgroundTransparency = 0.25
        hov(stopBtn)

        local function resolveCopyTarget()
            if sel and typeof(sel) == "Instance" and sel:IsA("Player") and sel.Parent then
                return sel
            end
            local q = selName or (tgtInput and tgtInput.Text) or ""
            if q ~= "" then
                local r = getPlayer(q, LP)
                if r and r[1] then return P:FindFirstChild(r[1]) end
            end
            return nil
        end

        onClick(startBtn, function()
            local sys = _G.JamunAnimCopy
            if not sys or type(sys.Start) ~= "function" then
                acStatus.Text = "engine not loaded"
                acStatus.TextColor3 = C.danger
                play(SND.error)
                return
            end
            local plr = resolveCopyTarget()
            if not plr then
                acStatus.Text = "type a name or pick target"
                acStatus.TextColor3 = C.warn
                play(SND.error)
                return
            end
            play(SND.on)
            local ok = sys:Start(plr)
            if ok ~= false and sys.active then
                acStatus.Text = "copying · "..plr.DisplayName
                acStatus.TextColor3 = C.good
            else
                acStatus.Text = "failed to start"
                acStatus.TextColor3 = C.danger
            end
        end)
        onClick(stopBtn, function()
            local sys = _G.JamunAnimCopy
            if sys and type(sys.Stop) == "function" then
                pcall(function() sys:Stop() end)
            end
            acStatus.Text = "stopped"
            acStatus.TextColor3 = C.text3
            play(SND.off)
        end)

        registerUIPoller(function()
            local sys = _G.JamunAnimCopy
            if not sys then return end
            if sys.active and sys.target then
                acStatus.Text = "copying · "..(sys.target.DisplayName or sys.target.Name)
                acStatus.TextColor3 = C.good
            end
        end)

        copyHost.Size = UDim2.new(1, 0, 0, optY + 100)
    end

    -- Settings: X offset sliders per weld
    do
        local sTitle = L(settingsHost, "Weld Vertical Height (Y Offset)", 13, C.text)
        sTitle.Size = UDim2.new(1,0,0,18); sTitle.Position = UDim2.fromOffset(0,0)
        local sSub = L(settingsHost, "slide vertical offset · updates live while welded", 9, C.text3)
        sSub.Size = UDim2.new(1,0,0,12); sSub.Position = UDim2.fromOffset(0,20)

        local order = {"facebang","backshots","headsit","kiss","backpack","headpat","propose","lawl","hug","chootlelo"}
        local labels = {
            facebang="Face Bang", backshots="Backshots", headsit="Headsit", kiss="Kiss",
            backpack="Backpack", headpat="Headpat", propose="Propose", lawl="Lawl",
            hug="Hug", chootlelo="Choot Lelo",
        }
        local y = 42
        local sliderSetters = {}
        local MINY, MAXY = -8, 8
        for _, key in ipairs(order) do
            local card = glassTile(settingsHost)
            card.Size = UDim2.new(1, 0, 0, 52)
            card.Position = UDim2.fromOffset(0, y)
            local nameL = L(card, labels[key] or key, 11, C.text)
            nameL.Size = UDim2.new(0.45, 0, 0, 14); nameL.Position = UDim2.fromOffset(12, 6)
            local valL = L(card, string.format("Y  %.2f", WeldOffsetY[key] or 0), 10, C.accent)
            valL.Size = UDim2.new(0.4, 0, 0, 14); valL.Position = UDim2.new(1, -120, 0, 6)
            valL.TextXAlignment = Enum.TextXAlignment.Right

            local track = Instance.new("Frame")
            track.Size = UDim2.new(1, -24, 0, 8)
            track.Position = UDim2.fromOffset(12, 32)
            track.BackgroundColor3 = C.glassInput
            track.BackgroundTransparency = 0.35
            track.BorderSizePixel = 0
            track.Parent = card
            corner(track, 4)

            local fill = Instance.new("Frame")
            fill.BackgroundColor3 = C.accent
            fill.BackgroundTransparency = 0.15
            fill.BorderSizePixel = 0
            fill.Parent = track
            corner(fill, 4)

            local function setFromRel(rel)
                local v = MINY + rel * (MAXY - MINY)
                v = math.floor(v * 20 + 0.5) / 20
                WeldOffsetY[key] = v
                local t = (v - MINY) / (MAXY - MINY)
                fill.Size = UDim2.new(t, 0, 1, 0)
                valL.Text = string.format("Y  %.2f", v)
            end
            local function setFromValue(v)
                v = math.clamp(v or 0, MINY, MAXY)
                setFromRel((v - MINY) / (MAXY - MINY))
            end
            sliderSetters[key] = setFromValue
            setFromValue(WeldOffsetY[key] or 0)

            local dragging = false
            local function fromInput(input)
                local abs = track.AbsolutePosition
                local sz = track.AbsoluteSize
                if sz.X <= 0 then return end
                local rel = math.clamp((input.Position.X - abs.X) / sz.X, 0, 1)
                setFromRel(rel)
            end
            track.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    dragging = true; fromInput(i)
                end
            end)
            UIS.InputChanged:Connect(function(i)
                if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                    fromInput(i)
                end
            end)
            UIS.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            y = y + 58
        end
        local resetAll = BTN(settingsHost, "Reset all Y offsets")
        resetAll.Size = UDim2.new(1, 0, 0, 30)
        resetAll.Position = UDim2.fromOffset(0, y + 6)
        hov(resetAll)
        onClick(resetAll, function()
            for _, key in ipairs(order) do
                WeldOffsetY[key] = 0
                if sliderSetters[key] then sliderSetters[key](0) end
            end
            play(SND.success)
        end)
        page.CanvasSize = UDim2.fromOffset(0, math.max(980, y + 80))
    end

    local fp = weldHost
    local tTitle = L(fp, "Target Weld Actions", 13, C.text); tTitle.Size = UDim2.new(1,0,0,18); tTitle.Position = UDim2.fromOffset(0,0)
    local tStatus = L(fp, "idle", 10, C.text3); tStatus.Size = UDim2.new(1,0,0,14); tStatus.Position = UDim2.fromOffset(0,20)

    local fCard = glassTile(fp); fCard.Size = UDim2.new(1,0,0,68); fCard.Position = UDim2.fromOffset(0,40)
    local AV = Instance.new("ImageLabel"); AV.Size = UDim2.fromOffset(48,48); AV.Position = UDim2.fromOffset(10,10)
    AV.BackgroundColor3 = C.glassInput; AV.BackgroundTransparency = G.inputTransparency; AV.BorderSizePixel = 0; AV.Parent = fCard
    corner(AV, G.radiusTile); stroke(AV, C.stroke, 1, G.rowTransparency)
    local NL = L(fCard, "No target", 12, C.text); NL.Size = UDim2.new(1,-70,0,14); NL.Position = UDim2.fromOffset(70,9)
    local UL = L(fCard, "—", 10, C.text3); UL.Size = UDim2.new(1,-70,0,12); UL.Position = UDim2.fromOffset(70,26)
    local AL = L(fCard, "age —", 10, C.text3); AL.Size = UDim2.fromOffset(100,12); AL.Position = UDim2.fromOffset(70,44)
    local FL = L(fCard, "friends —", 10, C.text3); FL.Size = UDim2.fromOffset(130,12); FL.Position = UDim2.new(1,-140,0,44)

    local TSTAT = L(fp, "", 9, C.text3); TSTAT.Size = UDim2.new(1,0,0,12); TSTAT.Position = UDim2.fromOffset(0,116)

    local actGap = 6; local actW = math.floor((innerW-actGap*2)/3)
    local faceBang = BTN(fp, "Face Bang"); faceBang.Size = UDim2.fromOffset(actW,32); faceBang.Position = UDim2.fromOffset(0,134)
    local backshots = BTN(fp, "Backshots"); backshots.Size = UDim2.fromOffset(actW,32); backshots.Position = UDim2.fromOffset(actW+actGap,134)
    local headsit = BTN(fp, "Headsit"); headsit.Size = UDim2.fromOffset(actW,32); headsit.Position = UDim2.fromOffset((actW+actGap)*2,134)
    local kiss = BTN(fp, "Kiss"); kiss.Size = UDim2.fromOffset(actW,32); kiss.Position = UDim2.fromOffset(0,172)
    local backpack = BTN(fp, "Backpack"); backpack.Size = UDim2.fromOffset(actW,32); backpack.Position = UDim2.fromOffset(actW+actGap,172)
    local headpat = BTN(fp, "Headpat"); headpat.Size = UDim2.fromOffset(actW,32); headpat.Position = UDim2.fromOffset((actW+actGap)*2,172)
    local propose = BTN(fp, "Propose"); propose.Size = UDim2.fromOffset(actW,32); propose.Position = UDim2.fromOffset(0,210)
    local lawl = BTN(fp, "Lawl"); lawl.Size = UDim2.fromOffset(actW,32); lawl.Position = UDim2.fromOffset(actW+actGap,210)
    local hug = BTN(fp, "Hug"); hug.Size = UDim2.fromOffset(actW,32); hug.Position = UDim2.fromOffset((actW+actGap)*2,210)
    local chootLelo = BTN(fp, "Choot Lelo"); chootLelo.Size = UDim2.fromOffset(actW,32); chootLelo.Position = UDim2.fromOffset(0,248)
    local spectateBtn = BTN(fp, "Spectate"); spectateBtn.Size = UDim2.fromOffset(actW,32); spectateBtn.Position = UDim2.fromOffset(actW+actGap,248)
    local stopBtn = BTN(fp, "Stop All"); stopBtn.Size = UDim2.new(1,0,0,32); stopBtn.Position = UDim2.fromOffset(0,288)
    stopBtn.BackgroundColor3 = C.danger; stopBtn.BackgroundTransparency = 0.30; stopBtn.TextColor3 = C.text
    local ss = stopBtn:FindFirstChildOfClass("UIStroke"); if ss then ss.Color = C.danger end
    for _,b in ipairs({faceBang,backshots,headsit,kiss,backpack,headpat,propose,lawl,hug,chootLelo,spectateBtn}) do hov(b) end; hov(stopBtn)

    local tgtLbl = L(fp, "Target username · press Enter", 9, C.text3); tgtLbl.Size = UDim2.new(1,0,0,12); tgtLbl.Position = UDim2.fromOffset(0,330)
    tgtInput = B(fp, "enter username"); tgtInput.Size = UDim2.new(1,0,0,30); tgtInput.Position = UDim2.fromOffset(0,344)
    local tgtHint = L(fp, "", 9, C.text3); tgtHint.Size = UDim2.new(1,0,0,12); tgtHint.Position = UDim2.fromOffset(0,378)

    local allFeatureBtns = { faceBang, backshots, headsit, kiss, backpack, headpat, propose, lawl, hug, chootLelo }
    local function clearToggles() for _,b in ipairs(allFeatureBtns) do setToggle(b, false) end end

    local function startFeature(presetKey, btn)
        local targetArg = sel or selName or tgtInput.Text
        if not targetArg or targetArg == "" then play(SND.error); tStatus.Text = "enter a target"; tStatus.TextColor3 = C.danger; return end
        local myGen = StopGeneration
        clearToggles()
        local ok
        if CurrentWeld then ok = switchWeld(presetKey, targetArg) else ok = applyWeldPreset(presetKey, targetArg, myGen) end
        if ok then
            setToggle(btn, true)
            tStatus.Text = presetKey .. " → " .. (sel and sel.Name or tostring(targetArg))
            tStatus.TextColor3 = C.accent
        else
            tStatus.Text = "target not found"; tStatus.TextColor3 = C.danger; play(SND.error)
        end
    end

    onClick(faceBang,  function() startFeature("facebang",  faceBang)  end)
    onClick(backshots, function() startFeature("backshots", backshots) end)
    onClick(headsit,   function() startFeature("headsit",   headsit)   end)
    onClick(kiss,      function() startFeature("kiss",      kiss)      end)
    onClick(backpack,  function() startFeature("backpack",  backpack)  end)
    onClick(headpat,   function() startFeature("headpat",   headpat)   end)
    onClick(propose,   function() startFeature("propose",   propose)   end)
    onClick(lawl,      function() startFeature("lawl",      lawl)      end)
    onClick(hug,       function() startFeature("hug",       hug)       end)
    onClick(chootLelo, function() startFeature("chootlelo", chootLelo) end)

    -- Spectate / Teleport (not welds)
    local spectateOn = false
    local spectateConn = nil
    local function stopSpectate()
        spectateOn = false
        if spectateConn then spectateConn:Disconnect(); spectateConn = nil end
        local cam = WS.CurrentCamera
        if cam then
            pcall(function()
                cam.CameraType = Enum.CameraType.Custom
                local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                if hum then cam.CameraSubject = hum end
            end)
        end
        setToggle(spectateBtn, false)
        if tStatus then tStatus.Text = "spectate off"; tStatus.TextColor3 = C.text3 end
    end
    local function startSpectate(targetArg)
        local plr = resolvePlayer(targetArg, LP)
        if not plr or not plr.Character then
            play(SND.error)
            if tStatus then tStatus.Text = "spectate · no target"; tStatus.TextColor3 = C.danger end
            return
        end
        local thrp = plr.Character:FindFirstChild("HumanoidRootPart")
        local thum = plr.Character:FindFirstChildOfClass("Humanoid")
        if not thrp then
            play(SND.error)
            return
        end
        stopSpectate()
        spectateOn = true
        setToggle(spectateBtn, true)
        local cam = WS.CurrentCamera
        if cam then
            pcall(function()
                cam.CameraType = Enum.CameraType.Custom
                cam.CameraSubject = thum or thrp
            end)
        end
        spectateConn = RS.Heartbeat:Connect(function()
            if not spectateOn then return end
            local p2 = plr
            if not p2 or not p2.Parent then stopSpectate(); return end
            local c2 = p2.Character
            if not c2 then return end
            local h2 = c2:FindFirstChildOfClass("Humanoid")
            local r2 = c2:FindFirstChild("HumanoidRootPart")
            local cam2 = WS.CurrentCamera
            if cam2 and (h2 or r2) then
                pcall(function() cam2.CameraSubject = h2 or r2 end)
            end
        end)
        play(SND.on)
        if tStatus then tStatus.Text = "spectating · "..plr.Name; tStatus.TextColor3 = C.good end
    end
    onClick(spectateBtn, function()
        if spectateOn then
            play(SND.off); stopSpectate(); return
        end
        local targetArg = sel or selName or tgtInput.Text
        if not targetArg or tostring(targetArg) == "" then
            play(SND.error)
            if tStatus then tStatus.Text = "pick a target first"; tStatus.TextColor3 = C.danger end
            return
        end
        startSpectate(targetArg)
    end)

    onClick(stopBtn, function()
        pcall(function() if spectateOn then stopSpectate() end end)
        stopWeld(); clearToggles()
        if _G.stopJamunFly then _G.stopJamunFly() end
        _G.__jamunAutoReweld = nil
        tStatus.Text = "stopped"; tStatus.TextColor3 = C.text3
        play(SND.off)
    end)

    -- Click Target Tool card
    local ctTitle = L(fp, "Click Target Tool", 12, C.text)
    ctTitle.Size = UDim2.new(1,0,0,16); ctTitle.Position = UDim2.fromOffset(0, 400)
    local ctSub = L(fp, "equip from inventory · click player to weld · unequip stops", 9, C.text3)
    ctSub.Size = UDim2.new(1,0,0,12); ctSub.Position = UDim2.fromOffset(0, 418)

    local ctCard = glassTile(fp)
    ctCard.Size = UDim2.new(1,0,0,96); ctCard.Position = UDim2.fromOffset(0, 436)

    local ctPresetLbl = L(ctCard, "weld mode", 9, C.text3)
    ctPresetLbl.Size = UDim2.fromOffset(80,12); ctPresetLbl.Position = UDim2.fromOffset(12, 8)

    local ctPresetBtn = BTN(ctCard, CLICK_PRESET_LABEL[ClickToolPreset] or "Face Bang")
    ctPresetBtn.Size = UDim2.new(1, -24, 0, 28); ctPresetBtn.Position = UDim2.fromOffset(12, 24)
    ctPresetBtn.TextSize = 11; hov(ctPresetBtn)

    local ctIdx = 1
    for i,k in ipairs(CLICK_PRESET_ORDER) do
        if k == ClickToolPreset then ctIdx = i; break end
    end
    onClick(ctPresetBtn, function()
        ctIdx = (ctIdx % #CLICK_PRESET_ORDER) + 1
        local key = CLICK_PRESET_ORDER[ctIdx]
        ClickToolPreset = key
        if _G.__jamunSetClickToolPreset then _G.__jamunSetClickToolPreset(key) end
        ctPresetBtn.Text = CLICK_PRESET_LABEL[key] or key
        play(SND.tab)
        tStatus.Text = "tool preset · " .. (CLICK_PRESET_LABEL[key] or key)
        tStatus.TextColor3 = C.accent
    end)

    local ctGive = BTN(ctCard, "Give Tool")
    ctGive.Size = UDim2.fromOffset(100, 28); ctGive.Position = UDim2.fromOffset(12, 58)
    ctGive.BackgroundColor3 = C.accent; ctGive.BackgroundTransparency = 0.25; ctGive.TextColor3 = C.text
    hov(ctGive)
    local ctRemove = BTN(ctCard, "Remove")
    ctRemove.Size = UDim2.fromOffset(80, 28); ctRemove.Position = UDim2.fromOffset(120, 58)
    hov(ctRemove)

    onClick(ctGive, function()
        if giveClickTool then
            giveClickTool()
            play(SND.success)
            tStatus.Text = "tool in backpack · equip & click a player"
            tStatus.TextColor3 = C.good
        end
    end)
    onClick(ctRemove, function()
        destroyClickTool()
        play(SND.off)
        tStatus.Text = "tool removed"
        tStatus.TextColor3 = C.text3
    end)

    page.CanvasSize = UDim2.fromOffset(0, math.max(page.CanvasSize.Y.Offset, 560 + 38))

    local lastHintState = nil
    registerUIPoller(function()
        local joined = sel ~= nil
        local offline = (not sel) and (selName ~= nil or selId ~= nil)
        if joined then
            local inS = false; for _,p in ipairs(P:GetPlayers()) do if p==sel then inS=true; break end end
            if not inS then joined=false; offline=true end
        end
        local state = joined and "joined" or (offline and "offline" or "none")
        if state ~= lastHintState then
            lastHintState = state
            if state=="joined" then tgtHint.Text="target joined"; tgtHint.TextColor3=C.good
            elseif state=="offline" then tgtHint.Text="target offline · will attach on spawn"; tgtHint.TextColor3=C.warn
            else tgtHint.Text=""; tgtHint.TextColor3=C.text3 end
        end
        if not sel then
            if selName then TSTAT.Text="target left · "..selName; TSTAT.TextColor3=C.danger
            elseif selId then TSTAT.Text="target left"; TSTAT.TextColor3=C.danger
            elseif TSTAT.Text~="" then TSTAT.Text="" end
            return
        end
        local inS=false; for _,p in ipairs(P:GetPlayers()) do if p==sel then inS=true; break end end
        if not inS then TSTAT.Text="target left"; TSTAT.TextColor3=C.danger; return end
        local c=sel.Character; if not c then TSTAT.Text="respawning…"; TSTAT.TextColor3=C.warn; return end
        local h=c:FindFirstChildOfClass("Humanoid"); if not h then TSTAT.Text="no humanoid"; TSTAT.TextColor3=C.warn; return end
        if h.Health<=0 then TSTAT.Text="target dead"; TSTAT.TextColor3=C.warn; return end
        local ping=0; pcall(function() ping=math.floor(sel:GetNetworkPing()*1000) end)
        TSTAT.Text="target locked · "..ping.."ms"; TSTAT.TextColor3=C.good
    end)

    -- =================================================================
    -- strict username resolution. order:
    --   1. exact Name (case-sensitive)
    --   2. exact Name (case-insensitive)
    --   3. exact DisplayName, unique
    --   4. unique Name prefix (case-insensitive)
    --   5. unique substring of Name or DisplayName (case-insensitive)
    --   6. offline: POST users/v1/usernames/users
    --   7. offline: GET users/v1/users/search by keyword
    -- any tie in 3/4/5 bails with a count
    -- =================================================================
    local function collect(pred)
        local out = {}
        for _,p in ipairs(P:GetPlayers()) do
            if p ~= LP and pred(p) then table.insert(out, p) end
        end
        return out
    end
    local function selectByName(rawName)
        if not rawName or rawName=="" then play(SND.error); tStatus.Text="enter a username"; tStatus.TextColor3=C.danger; tgtHint.Text=""; return end
        local name = rawName:gsub("^%s+",""):gsub("%s+$",""):gsub("^%s*@+%s*","")
        if name == "" then play(SND.error); tStatus.Text="enter a username"; tStatus.TextColor3=C.danger; return end
        local lower = string.lower(name)

        -- 1. exact Name case-sensitive
        local found
        for _,p in ipairs(P:GetPlayers()) do
            if p ~= LP and p.Name == name then found = p; break end
        end
        -- 2. exact Name case-insensitive
        if not found then
            local c = collect(function(p) return string.lower(p.Name) == lower end)
            if #c == 1 then found = c[1]
            elseif #c > 1 then play(SND.error); tStatus.Text="ambiguous — "..#c.." players"; tStatus.TextColor3=C.warn; return end
        end
        -- 3. exact DisplayName, unique
        if not found then
            local c = collect(function(p) return string.lower(p.DisplayName) == lower end)
            if #c == 1 then found = c[1]
            elseif #c > 1 then play(SND.error); tStatus.Text="ambiguous display — "..#c.." players"; tStatus.TextColor3=C.warn; return end
        end
        -- 4. unique Name prefix
        if not found then
            local c = collect(function(p) return string.lower(p.Name):sub(1,#lower) == lower end)
            if #c == 1 then found = c[1]
            elseif #c > 1 then play(SND.error); tStatus.Text="ambiguous prefix — "..#c.." players"; tStatus.TextColor3=C.warn; return end
        end
        -- 5. unique substring in Name or DisplayName
        if not found then
            local c = collect(function(p)
                return string.lower(p.Name):find(lower,1,true)
                    or string.lower(p.DisplayName):find(lower,1,true)
            end)
            if #c == 1 then found = c[1]
            elseif #c > 1 then play(SND.error); tStatus.Text="ambiguous substring — "..#c.." players"; tStatus.TextColor3=C.warn; return end
        end

        if found then
            sel=found; selId=found.UserId; selName=found.Name; selDisplay=found.DisplayName; tgtJoinState="joined"
            tStatus.Text="target · "..found.Name; tStatus.TextColor3=C.good
            NL.Text=found.DisplayName; UL.Text="@"..found.Name
            AL.Text="age —"; FL.Text="friends —"
            tgtHint.Text="target joined"; tgtHint.TextColor3=C.good
            tgtInput.Text=found.Name
            if _G.__jamunChatTargetBox then _G.__jamunChatTargetBox.Text=found.DisplayName end
            pcall(function() AV.Image=P:GetUserThumbnailAsync(found.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100) end)
            task.spawn(function()
                pcall(function()
                    local r=HS:GetAsync("https://users.roblox.com/v1/users/"..found.UserId)
                    local d=HS:JSONDecode(r)
                    if d.created then
                        local c=DateTime.fromISO(d.created)
                        local days=(DateTime.now().UnixTimestamp-c.UnixTimestamp)/86400
                        if days<30 then AL.Text="age "..math.floor(days).."d"
                        elseif days<365 then AL.Text="age "..math.floor(days/30).."mo"
                        else AL.Text="age "..math.floor(days/365).."y" end
                    end
                end)
                pcall(function()
                    local r=HS:GetAsync("https://friends.roblox.com/v1/users/"..found.UserId.."/friends/count")
                    local d=HS:JSONDecode(r)
                    if d.count then FL.Text="friends "..d.count end
                end)
            end)
            return
        end

        -- 6. offline username resolve
        local offlineId, offlineDisplay, offlineName = nil, nil, nil
        pcall(function()
            local body = HS:JSONEncode({ usernames = { name }, excludeBannedUsers = false })
            local res  = HS:PostAsync("https://users.roblox.com/v1/usernames/users", body, Enum.HttpContentType.ApplicationJson)
            local dec  = HS:JSONDecode(res)
            if dec.data and dec.data[1] then
                offlineId = dec.data[1].id
                offlineName = dec.data[1].name
                offlineDisplay = dec.data[1].displayName or offlineName or name
            end
        end)
        -- 7. offline users/search
        if not offlineId then
            pcall(function()
                local res = HS:GetAsync("https://users.roblox.com/v1/users/search?keyword="..HS:UrlEncode(name).."&limit=10")
                local dec = HS:JSONDecode(res)
                if dec.data then
                    for _,u in ipairs(dec.data) do
                        if u.name and string.lower(u.name) == lower then
                            offlineId = u.id; offlineName = u.name; offlineDisplay = u.displayName or u.name; break
                        end
                    end
                    if not offlineId then
                        for _,u in ipairs(dec.data) do
                            if u.displayName and string.lower(u.displayName) == lower then
                                offlineId = u.id; offlineName = u.name; offlineDisplay = u.displayName or u.name; break
                            end
                        end
                    end
                end
            end)
        end
        if not offlineId then
            play(SND.error)
            tStatus.Text="no player found · "..name
            tStatus.TextColor3=C.danger
            tgtHint.Text="name does not match any username or display name"
            tgtHint.TextColor3=C.danger
            return
        end

        sel=nil; selId=offlineId; selName=offlineName or name; selDisplay=offlineDisplay or name; tgtJoinState="offline"
        tStatus.Text="waiting for · "..(offlineDisplay or name); tStatus.TextColor3=C.warn
        NL.Text=offlineDisplay or name; UL.Text="@"..(offlineName or name)
        pcall(function() AV.Image=P:GetUserThumbnailAsync(offlineId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100) end)
        AL.Text="age —"; FL.Text="friends —"
        tgtHint.Text="target offline · will attach on spawn"; tgtHint.TextColor3=C.warn
        if _G.__jamunChatTargetBox then _G.__jamunChatTargetBox.Text=offlineDisplay or name end
        task.spawn(function()
            pcall(function()
                local r=HS:GetAsync("https://users.roblox.com/v1/users/"..offlineId)
                local d=HS:JSONDecode(r)
                if d.created then
                    local c=DateTime.fromISO(d.created)
                    local days=(DateTime.now().UnixTimestamp-c.UnixTimestamp)/86400
                    if days<30 then AL.Text="age "..math.floor(days).."d"
                    elseif days<365 then AL.Text="age "..math.floor(days/30).."mo"
                    else AL.Text="age "..math.floor(days/365).."y" end
                end
            end)
            pcall(function()
                local r=HS:GetAsync("https://friends.roblox.com/v1/users/"..offlineId.."/friends/count")
                local d=HS:JSONDecode(r)
                if d.count then FL.Text="friends "..d.count end
            end)
        end)
    end

    tgtInput.FocusLost:Connect(function(enterPressed)
        TypedTargetQuery = tostring(tgtInput.Text or "")
        if enterPressed then play(SND.click); selectByName(tgtInput.Text) end
    end)
    tgtInput:GetPropertyChangedSignal("Text"):Connect(function()
        TypedTargetQuery = tostring(tgtInput.Text or "")
        if not sel and not selName then tgtHint.Text=""; tgtHint.TextColor3=C.text3 end
    end)

    P.PlayerRemoving:Connect(function(p)
        if sel==p then
            if WeldIntent.active and WeldIntent.presetKey then
                local wasTgt = false
                local t = WeldIntent.target
                if typeof(t)=="Instance" and t:IsA("Player") then wasTgt = (t==p)
                elseif t and tostring(t):lower()==string.lower(p.Name) then wasTgt = true end
                if wasTgt then
                    _G.__jamunAutoReweld = { preset = WeldIntent.presetKey, userId = p.UserId, name = p.Name }
                end
            end
            selId=p.UserId; selName=p.Name; selDisplay=p.DisplayName; sel=nil; tgtJoinState="offline"
            tgtHint.Text="target offline · will attach on spawn"; tgtHint.TextColor3=C.warn
            if _G.__jamunAutoReweld then
                stopWeld(); clearToggles()
                tStatus.Text = "target left · weld stopped"
                tStatus.TextColor3 = C.danger
            end
        end
    end)
    P.PlayerAdded:Connect(function(p)
        local match=(selId and p.UserId==selId) or (selName and string.lower(p.Name)==string.lower(selName)) or (selDisplay and string.lower(p.DisplayName)==string.lower(selDisplay))
        if match and not sel then
            sel=p; selId=p.UserId; selName=p.Name; selDisplay=p.DisplayName; tgtJoinState="joined"
            tStatus.Text="joined · "..p.Name; tStatus.TextColor3=C.good
            NL.Text=p.DisplayName; UL.Text="@"..p.Name; tgtInput.Text=p.Name
            if _G.__jamunChatTargetBox then _G.__jamunChatTargetBox.Text=p.DisplayName end
            pcall(function() AV.Image=P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100) end)
            local reweld = _G.__jamunAutoReweld
            if reweld and reweld.userId == p.UserId and reweld.preset and WELD_PRESETS[reweld.preset] then
                _G.__jamunAutoReweld = nil
                task.spawn(function()
                    local deadline = tick() + 15
                    while tick() < deadline do
                        if p.Character then
                            local hum = p.Character:FindFirstChildOfClass("Humanoid")
                            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                            if hum and hrp and hum.Health > 0 then break end
                        end
                        task.wait(0.2)
                    end
                    task.wait(1.0)
                    if sel ~= p then return end
                    local applied = false
                    for attempt = 1, 5 do
                        if sel ~= p then return end
                        if not WeldIntent.active then
                            local myGen = StopGeneration
                            applied = applyWeldPreset(reweld.preset, p, myGen)
                        end
                        if applied then break end
                        task.wait(0.8)
                    end
                    if applied then
                        local map = { facebang=faceBang, backshots=backshots, headsit=headsit, kiss=kiss, backpack=backpack, headpat=headpat, propose=propose, lawl=lawl, hug=hug, chootlelo=chootLelo }
                        clearToggles(); local b = map[reweld.preset]; if b then setToggle(b, true) end
                        tStatus.Text = "re-welded · "..reweld.preset.." · "..p.Name
                        tStatus.TextColor3 = C.accent
                    else
                        tStatus.Text = "re-weld failed · "..p.Name
                        tStatus.TextColor3 = C.danger
                    end
                end)
            end
        end
    end)

    for _,p in ipairs(P:GetPlayers()) do
        if p ~= LP then
            p.CharacterAdded:Connect(function()
                if not WeldIntent.active or not WeldIntent.presetKey then return end
                local t = WeldIntent.target
                local isThis = false
                if typeof(t)=="Instance" and t:IsA("Player") then isThis = (t == p)
                elseif t and tostring(t):lower() == string.lower(p.Name) then isThis = true end
                if not isThis then return end
                local stash = WeldIntent.presetKey
                task.wait(0.6)
                if not WeldIntent.active then return end
                local myGen = StopGeneration
                applyWeldPreset(stash, p, myGen)
            end)
        end
    end
    P.PlayerAdded:Connect(function(p)
        if p == LP then return end
        p.CharacterAdded:Connect(function()
            if not WeldIntent.active or not WeldIntent.presetKey then return end
            local t = WeldIntent.target
            local isThis = false
            if typeof(t)=="Instance" and t:IsA("Player") then isThis = (t == p)
            elseif t and tostring(t):lower() == string.lower(p.Name) then isThis = true end
            if not isThis then return end
            local stash = WeldIntent.presetKey
            task.wait(0.6)
            if not WeldIntent.active then return end
            local myGen = StopGeneration
            applyWeldPreset(stash, p, myGen)
        end)
    end)
end

-- ============================================================================
-- MOVE TAB
-- ============================================================================
tabBuilders.character = function()
    local mp = pages.character
    mp.CanvasSize = UDim2.fromOffset(0, 0)
    mp.ScrollingEnabled = false -- sub-hosts handle scroll (anti)

    -- subtabs
    local subBar = Instance.new("Frame")
    subBar.Size = UDim2.new(1, 0, 0, 32)
    subBar.BackgroundColor3 = C.glassTile
    subBar.BackgroundTransparency = 0.15
    subBar.BorderSizePixel = 0
    subBar.Parent = mp
    corner(subBar, 12)
    stroke(subBar, C.stroke, 1, 0.5)
    local subGlow = Instance.new("UIGradient")
    subGlow.Rotation = 90
    subGlow.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180,180,200)),
    }
    subGlow.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.85),
        NumberSequenceKeypoint.new(1, 0.95),
    }
    subGlow.Parent = subBar

    local moveSecBtn = BTN(subBar, "Move")
    moveSecBtn.Size = UDim2.new(0.5, -6, 1, -6)
    moveSecBtn.Position = UDim2.new(0, 3, 0, 3)
    moveSecBtn.TextSize = 11
    hov(moveSecBtn)

    local antiSecBtn = BTN(subBar, "Anti")
    antiSecBtn.Size = UDim2.new(0.5, -6, 1, -6)
    antiSecBtn.Position = UDim2.new(0.5, 3, 0, 3)
    antiSecBtn.TextSize = 11
    hov(antiSecBtn)

    local moveHost = Instance.new("Frame")
    moveHost.Size = UDim2.new(1, 0, 1, -44)
    moveHost.Position = UDim2.fromOffset(0, 40)
    moveHost.BackgroundTransparency = 1
    moveHost.Parent = mp

    -- Anti gets its own scroll so long toggle list never clips
    local antiHost = Instance.new("ScrollingFrame")
    antiHost.Name = "AntiScroll"
    antiHost.Size = UDim2.new(1, 0, 1, -44)
    antiHost.Position = UDim2.fromOffset(0, 40)
    antiHost.BackgroundTransparency = 1
    antiHost.BorderSizePixel = 0
    antiHost.ScrollBarThickness = 3
    antiHost.ScrollBarImageColor3 = C.accent
    antiHost.CanvasSize = UDim2.fromOffset(0, 520)
    antiHost.AutomaticCanvasSize = Enum.AutomaticSize.Y
    antiHost.ClipsDescendants = true
    antiHost.Visible = false
    antiHost.Parent = mp
    local antiPad = Instance.new("UIPadding")
    antiPad.PaddingBottom = UDim.new(0, 24)
    antiPad.Parent = antiHost

    local function showCharSec(which)
        local isMove = which == "move"
        moveHost.Visible = isMove
        antiHost.Visible = not isMove
        setToggle(moveSecBtn, isMove)
        setToggle(antiSecBtn, not isMove)
        if isMove then moveSecBtn.TextColor3 = Color3.fromRGB(8,8,12)
        else antiSecBtn.TextColor3 = Color3.fromRGB(8,8,12) end
        for _,b in ipairs({moveSecBtn, antiSecBtn}) do
            pcall(function()
                local f=C.font or Enum.Font.GothamMedium
                b.Font=f
                if C.fontFace then b.FontFace=C.fontFace end
            end)
        end
        play(SND.tab)
    end
    onClick(moveSecBtn, function() showCharSec("move") end)
    onClick(antiSecBtn, function() showCharSec("anti") end)
    showCharSec("move")

    -- ── MOVE: Walkspeed + Fly ──
    local wsLbl=L(moveHost,"Walk Speed Modifier",13,C.text); wsLbl.Size=UDim2.new(1,0,0,18); wsLbl.Position=UDim2.fromOffset(0,0)
    local wC=glassTile(moveHost); wC.Size=UDim2.new(1,0,0,72); wC.Position=UDim2.fromOffset(0,24)
    local wL=L(wC,"current · 16",10,C.text3); wL.Size=UDim2.new(1,-16,0,14); wL.Position=UDim2.fromOffset(12,10)
    local wB=B(wC,"speed"); wB.Size=UDim2.fromOffset(70,30); wB.Position=UDim2.fromOffset(12,32); wB.TextSize=11
    wB.Text = tostring(wsVal)
    wB.ClearTextOnFocus = true
    local wToggle=BTN(wC,"OFF"); wToggle.Size=UDim2.fromOffset(110,30); wToggle.Position=UDim2.fromOffset(90,32); wToggle.TextSize=11; hov(wToggle)
    local function applyWS()
        local c=LP.Character; if not c then return end
        local h=c:FindFirstChildOfClass("Humanoid"); if h then h.WalkSpeed=wsVal end
    end
    local function commitWS()
        local raw = (wB.Text or ""):gsub("%s",""):gsub("%D","")
        local n = tonumber(raw)
        if n and n>=0 and n<=1000 then
            wsVal = n
            wB.Text = tostring(n)
            if wsOn then applyWS() end
            wL.Text = "current · "..n
            wL.TextColor3 = C.text3
        else
            wB.Text = tostring(wsVal)
        end
    end
    wB.FocusLost:Connect(function() commitWS() end)
    local function toggleWalk()
        if CurrentWeld or WeldIntent.active or FLY.active then
            play(SND.error)
            wL.Text="stop weld / fly first"; wL.TextColor3=C.warn
            task.delay(1.5, function() if wL.Text=="stop weld / fly first" then wL.Text=(wsOn and ("current · "..wsVal) or ("current · "..DEFAULT_WALKSPEED)); wL.TextColor3=C.text3 end end)
            return
        end
        if wsOn then
            play(SND.off); wsOn=false
            local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed=DEFAULT_WALKSPEED; if h.PlatformStand then h.PlatformStand=false end; if h.Sit then h.Sit=false end; pcall(function() h:ChangeState(Enum.HumanoidStateType.Running) end) end
            wL.Text="current · "..DEFAULT_WALKSPEED; wL.TextColor3=C.text3
            setToggle(wToggle,false); wToggle.Text="OFF"
        else
            play(SND.on)
            commitWS()
            wsOn=true
            applyWS()
            wL.Text="current · "..wsVal; wL.TextColor3=C.good
            setToggle(wToggle,true); wToggle.Text="ON"
        end
    end
    onClick(wToggle, toggleWalk)
    local wMini=BTN(wC,"Panel"); wMini.Size=UDim2.fromOffset(56,30); wMini.Position=UDim2.new(1,-68,0,32); wMini.TextSize=10; hov(wMini)
    onClick(wMini, function()
        local m = ScreenGui:FindFirstChild("MiniWS")
        if m then m.Visible = true end
        play(SND.tab)
    end)

    local fLbl=L(moveHost,"Superman Fly (Mobile & PC)",13,C.text); fLbl.Size=UDim2.new(1,0,0,18); fLbl.Position=UDim2.fromOffset(0,108)
    local fCard=glassTile(moveHost); fCard.Size=UDim2.new(1,0,0,72); fCard.Position=UDim2.fromOffset(0,132)
    local fL=L(fCard,"hold space · speed box",10,C.text3); fL.Size=UDim2.new(1,-16,0,14); fL.Position=UDim2.fromOffset(12,10)
    local fSpdBox=B(fCard,"spd"); fSpdBox.Size=UDim2.fromOffset(70,30); fSpdBox.Position=UDim2.fromOffset(12,32); fSpdBox.TextSize=11
    fSpdBox.Text = tostring(math.floor(_G.sflySpeed or 120))
    fSpdBox.ClearTextOnFocus = true
    local fToggle=BTN(fCard,"OFF"); fToggle.Size=UDim2.fromOffset(110,30); fToggle.Position=UDim2.fromOffset(90,32); fToggle.TextSize=11; hov(fToggle)
    local function refreshFlyUI()
        if FLY.active then
            setToggle(fToggle,true); fToggle.Text="ON"
            fL.Text="flying · "..tostring(math.floor(FLY.speed or 120)); fL.TextColor3=C.good
        else
            setToggle(fToggle,false); fToggle.Text="OFF"
            fL.Text="hold space · speed box"; fL.TextColor3=C.text3
        end
    end
    local function toggleFlyUI()
        if not FLY.active then
            if CurrentWeld or WeldIntent.active then
                play(SND.error)
                fL.Text="stop weld first"; fL.TextColor3=C.warn
                task.delay(1.5, refreshFlyUI)
                return
            end
            if wsOn then
                play(SND.off); wsOn=false
                local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                if h then h.WalkSpeed=DEFAULT_WALKSPEED end
                setToggle(wToggle,false); wToggle.Text="OFF"
                wL.Text="current · "..DEFAULT_WALKSPEED
            end
            play(SND.on)
            _G.startJamunFly()
        else
            play(SND.off)
            _G.stopJamunFly()
        end
        refreshFlyUI()
    end
    onClick(fToggle, toggleFlyUI)
    local fMini=BTN(fCard,"Panel"); fMini.Size=UDim2.fromOffset(56,30); fMini.Position=UDim2.new(1,-68,0,32); fMini.TextSize=10; hov(fMini)
    onClick(fMini, function()
        local m = ScreenGui:FindFirstChild("MiniFly")
        if m then m.Visible = true end
        play(SND.tab)
    end)
    fSpdBox.FocusLost:Connect(function()
        local n = tonumber(fSpdBox.Text)
        if n and n>=20 and n<=500 then
            _G.sflySpeed = n; FLY.speed = n
            if FLY.active then refreshFlyUI() end
        else
            fSpdBox.Text = tostring(math.floor(_G.sflySpeed or 120))
        end
    end)
    registerUIPoller(function()
        if FLY.active ~= (fToggle.Text=="ON") then refreshFlyUI() end
    end)

    -- ── ANTI section ──
    local antiHead = L(antiHost, "Protection & Anti Toggles", 13, C.text)
    antiHead.Size = UDim2.new(1, 0, 0, 18)
    antiHead.Position = UDim2.fromOffset(0, 0)
    local antiSub = L(antiHost, "each switch independent · on / off anytime", 9, C.text3)
    antiSub.Size = UDim2.new(1, 0, 0, 14)
    antiSub.Position = UDim2.fromOffset(0, 18)

    local function mkAntiRow(parent, y, title, desc)
        local card = glassTile(parent)
        card.Size = UDim2.new(1, 0, 0, 54)
        card.Position = UDim2.fromOffset(0, y)
        local t = L(card, title, 12, C.text)
        t.Size = UDim2.new(1, -100, 0, 16)
        t.Position = UDim2.fromOffset(12, 10)
        local d = L(card, desc, 9, C.text3)
        d.Size = UDim2.new(1, -100, 0, 14)
        d.Position = UDim2.fromOffset(12, 28)
        local btn = BTN(card, "OFF")
        btn.Size = UDim2.fromOffset(72, 28)
        btn.Position = UDim2.new(1, -84, 0.5, -14)
        hov(btn)
        return card, btn, d
    end

    local function bindToggle(btn, isOnFn, startFn, stopFn)
        local function refresh()
            local on = isOnFn()
            setToggle(btn, on)
            btn.Text = on and "ON" or "OFF"
        end
        onClick(btn, function()
            if isOnFn() then
                play(SND.off)
                pcall(stopFn)
            else
                play(SND.on)
                pcall(startFn)
            end
            refresh()
        end)
        refresh()
        registerUIPoller(refresh)
    end

    local A = _G.__jamunAnti
    local y = 40
    local _, voidBtn = mkAntiRow(antiHost, y, "Anti Void", "deep FPDH · void recovery while free-roam")
    bindToggle(voidBtn,
        function() return A and A.voidOn and A.voidOn() end,
        function() if A then A.voidStart() end end,
        function() if A then A.voidStop() end end)

    y = y + 62
    local _, killBtn = mkAntiRow(antiHost, y, "Anti Kill", "no-touch parts · resists kill bricks")
    bindToggle(killBtn,
        function() return A and A.killOn and A.killOn() end,
        function() if A then A.killStart() end end,
        function() if A then A.killStop() end end)

    y = y + 62
    local _, gpBtn = mkAntiRow(antiHost, y, "Anti Gameplay Paused", "kills network pause overlay")
    bindToggle(gpBtn,
        function() return A and A.gpOn and A.gpOn() end,
        function() if A then A.gpStart() end end,
        function() if A then A.gpStop() end end)

    y = y + 62
    local _, afkBtn = mkAntiRow(antiHost, y, "Anti AFK", "blocks idle kick")
    bindToggle(afkBtn,
        function() return A and A.afkOn and A.afkOn() end,
        function() if A then A.afkStart() end end,
        function() if A then A.afkStop() end end)

    y = y + 62
    local _, sitBtn = mkAntiRow(antiHost, y, "Anti Sit", "breaks seats · blocks seated state")
    bindToggle(sitBtn,
        function() return A and A.sitOn and A.sitOn() end,
        function() if A then A.sitStart() end end,
        function() if A then A.sitStop() end end)

    y = y + 62
    -- Anti VC — Load only (no on/off)
    local avcCard = glassTile(antiHost)
    avcCard.Size = UDim2.new(1, 0, 0, 54)
    avcCard.Position = UDim2.fromOffset(0, y)
    local avcL = L(avcCard, "Anti VC", 12, C.text)
    avcL.Size = UDim2.new(1, -100, 0, 16)
    avcL.Position = UDim2.fromOffset(12, 10)
    local avcD = L(avcCard, "Mic Up · load once to enable", 9, C.text3)
    avcD.Size = UDim2.new(1, -100, 0, 14)
    avcD.Position = UDim2.fromOffset(12, 28)
    local avcBtn = BTN(avcCard, "Load")
    avcBtn.Size = UDim2.fromOffset(72, 28)
    avcBtn.Position = UDim2.new(1, -84, 0.5, -14)
    hov(avcBtn)
    onClick(avcBtn, function()
        if avcBtn.Text == "Done" then return end
        avcBtn.Text = "..."
        avcBtn.Active = false
        play(SND.on)
        local srcCode = _G.__jamunAntiVCSource
        if type(srcCode) ~= "string" then
            avcBtn.Text = "Load"
            avcBtn.Active = true
            avcD.Text = "source missing"
            avcD.TextColor3 = C.danger
            return
        end
        local ok, err = pcall(loadstring, srcCode)
        if ok and type(err) == "function" then
            local ok2, err2 = pcall(err)
            if ok2 then
                avcBtn.Text = "Done"
                setToggle(avcBtn, true)
                avcD.Text = "loaded · use mic button"
                avcD.TextColor3 = C.good
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification",{Title="Anti-VC",Text="Loaded!",Duration=3})
                end)
            else
                warn("[Anti-VC]", err2)
                avcBtn.Text = "Load"
                avcBtn.Active = true
                avcD.Text = tostring(err2)
                avcD.TextColor3 = C.danger
            end
        else
            avcBtn.Text = "Load"
            avcBtn.Active = true
            avcD.Text = "load failed"
            avcD.TextColor3 = C.danger
        end
    end)

    antiHost.CanvasSize = UDim2.fromOffset(0, y + 140)
    mp.CanvasSize = UDim2.fromOffset(0, 360)
end

-- ============================================================================
-- CHAT TAB

-- ============================================================================
tabBuilders.chat = function()
    local cp=pages.chat; cp.CanvasSize=UDim2.fromOffset(0,420)
    local csST=L(cp,"idle",10,C.text3); csST.Size=UDim2.new(1,0,0,14); csST.Position=UDim2.fromOffset(0,0)
    local cTB=Instance.new("Frame"); cTB.Size=UDim2.new(1,0,0,30); cTB.Position=UDim2.fromOffset(0,20); cTB.BackgroundTransparency=1; cTB.Parent=cp
    local cTL=Instance.new("UIListLayout"); cTL.FillDirection=Enum.FillDirection.Horizontal; cTL.Padding=UDim.new(0,4); cTL.Parent=cTB
    local cT={}
    local cN={"clan","message","roast"}
    local cL={clan="Clan",message="Message",roast="Roast"}
    local modeW=math.floor((innerW-8)/3)
    local cTLB=L(cp,"target",9,C.text3); cTLB.Size=UDim2.new(1,0,0,12); cTLB.Position=UDim2.fromOffset(0,58)
    local cTBX=B(cp,"target name"); cTBX.Size=UDim2.new(1,0,0,30); cTBX.Position=UDim2.fromOffset(0,74)
    _G.__jamunChatTargetBox=cTBX
    local cMLB=L(cp,"message",9,C.text3); cMLB.Size=UDim2.new(1,0,0,12); cMLB.Position=UDim2.fromOffset(0,58); cMLB.Visible=false
    local cMBX=B(cp,"message"); cMBX.Size=UDim2.new(1,0,0,30); cMBX.Position=UDim2.fromOffset(0,74); cMBX.Visible=false
    for i,n in ipairs(cN) do
        local b=BTN(cTB,cL[n]); b.Size=UDim2.fromOffset(modeW,30); b.LayoutOrder=i; b.TextSize=11
        cT[n]=b; hov(b)
        if n==csMode then setToggle(b,true) end
        local function switch()
            play(SND.tab); csMode=n
            for k,v in pairs(cT) do setToggle(v,k==n) end
            cTLB.Visible=(n~="message"); cTBX.Visible=(n~="message")
            cMLB.Visible=(n=="message"); cMBX.Visible=(n=="message")
        end
        b.MouseButton1Click:Connect(switch)
    end
    local cDO, cEDO = false, false
    local cDD, cEDD
    local cSBLbl=L(cp,"character set",9,C.text3); cSBLbl.Size=UDim2.new(1,0,0,12); cSBLbl.Position=UDim2.fromOffset(0,114)
    local cSB=BTN(cp,"@"); cSB.Size=UDim2.new(1,0,0,30); cSB.Position=UDim2.fromOffset(0,130)
    cSB.TextSize=11; cSB.TextXAlignment=Enum.TextXAlignment.Left; pad(cSB,10,0,10,0); hov(cSB)
    _G.__jamunChatSetBtn=cSB
    local ddH=math.min(26*#CS_K+8, 220)
    cDD=glassTile(cp,0.10); cDD.Size=UDim2.new(1,0,0,ddH); cDD.Position=UDim2.fromOffset(0,162); cDD.Visible=false; cDD.ZIndex=40
    for i,k in ipairs(CS_K) do
        local ob=BTN(cDD,CS_L[k]); ob.Size=UDim2.new(1,-8,0,22); ob.Position=UDim2.fromOffset(4,(i-1)*26+4)
        ob.TextSize=11; ob.TextXAlignment=Enum.TextXAlignment.Left; pad(ob,10,0,10,0); ob.ZIndex=41; hov(ob)
        onClick(ob,function()
            csSym=k; csIdx=1; cSB.Text=CS_L[k]
            cDD.Visible=false; cDO=false
            if cEDD then cEDD.Visible=false end; cEDO=false
        end)
    end
    onClick(cSB,function()
        play(cDO and SND.close or SND.open)
        cDO=not cDO; cDD.Visible=cDO
        if cDO and cEDD then cEDO=false; cEDD.Visible=false end
    end)

    local cEBLbl=L(cp,"emoji set",9,C.text3); cEBLbl.Size=UDim2.new(1,0,0,12); cEBLbl.Position=UDim2.fromOffset(0,168)
    local cEB=BTN(cp,"Random"); cEB.Size=UDim2.new(1,0,0,30); cEB.Position=UDim2.fromOffset(0,184)
    cEB.TextSize=11; cEB.TextXAlignment=Enum.TextXAlignment.Left; pad(cEB,10,0,10,0); hov(cEB)
    cEB.Text = CS_EMOJI_L[csEmoji] or "Random"
    local eDdH=math.min(26*#CS_EMOJI_K+8, 200)
    cEDD=glassTile(cp,0.10); cEDD.Size=UDim2.new(1,0,0,eDdH); cEDD.Position=UDim2.fromOffset(0,216); cEDD.Visible=false; cEDD.ZIndex=40
    for i,k in ipairs(CS_EMOJI_K) do
        local ob=BTN(cEDD,CS_EMOJI_L[k]); ob.Size=UDim2.new(1,-8,0,22); ob.Position=UDim2.fromOffset(4,(i-1)*26+4)
        ob.TextSize=11; ob.TextXAlignment=Enum.TextXAlignment.Left; pad(ob,10,0,10,0); ob.ZIndex=41; hov(ob)
        onClick(ob,function()
            csEmoji=k; cEB.Text=CS_EMOJI_L[k]
            cEDD.Visible=false; cEDO=false
            if cDD then cDD.Visible=false end; cDO=false
        end)
    end
    onClick(cEB,function()
        play(cEDO and SND.close or SND.open)
        cEDO=not cEDO; cEDD.Visible=cEDO
        if cEDO and cDD then cDO=false; cDD.Visible=false end
    end)

    -- keep Start/Stop tight under emoji row; dropdown overlays above
    local cBtnY=222
    cEDD.Position=UDim2.fromOffset(0,216)
    cEDD.ZIndex=50
    local cSt=BTN(cp,"Start"); cSt.Size=UDim2.fromOffset(110,32); cSt.Position=UDim2.fromOffset(0,cBtnY)
    cSt.BackgroundColor3=C.accent; cSt.BackgroundTransparency=0.30; cSt.TextColor3=C.text; hov(cSt)
    local cSp=BTN(cp,"Stop"); cSp.Size=UDim2.fromOffset(110,32); cSp.Position=UDim2.fromOffset(118,cBtnY); hov(cSp)
    local cRowY=cBtnY+42
    local cS1=L(cp,"—",10,C.text3); cS1.Size=UDim2.new(.33,0,0,12); cS1.Position=UDim2.fromOffset(0,cRowY); cS1.TextXAlignment=Enum.TextXAlignment.Center
    local cS2=L(cp,"0",10,C.text3); cS2.Size=UDim2.new(.33,0,0,12); cS2.Position=UDim2.new(.33,0,0,cRowY); cS2.TextXAlignment=Enum.TextXAlignment.Center
    local cS3=L(cp,"AT",10,C.text3); cS3.Size=UDim2.new(.33,0,0,12); cS3.Position=UDim2.new(.66,0,0,cRowY); cS3.TextXAlignment=Enum.TextXAlignment.Center
    cp.CanvasSize=UDim2.fromOffset(0, math.max(420, cRowY+30))
    local function csLoop(gen)
        local cachedDisplay=resolveTargetDisplay()
        while csOn and csGen==gen do
            cachedDisplay=resolveTargetDisplay() or cachedDisplay
            local m=bld()
            if m~="" then
                if snd2(m) then
                    csCnt=csCnt+1; cS2.Text=tostring(csCnt); cS1.Text=csMtd; cS3.Text=csSym
                    csST.Text="running · "..csMtd; csST.TextColor3=C.good
                else csST.Text="failed to send"; csST.TextColor3=C.danger end
            end
            task.wait(CS_D)
        end
    end
    local function csStartFn()
        if csOn then return end
        csTgt=(cTBX.Text or ""):gsub("^%s*@+%s*",""); csMsg=cMBX.Text
        if csMode=="roast" then
            local resolved=resolveTargetDisplay()
            if resolved then csTgt=resolved end
            if csTgt=="" or csTgt==nil then if _G.__jamunChatTargetBox then csTgt=_G.__jamunChatTargetBox.Text end end
            if csTgt=="" or csTgt==nil then play(SND.error); csST.Text="enter a target"; csST.TextColor3=C.danger; return end
            cTBX.Text=csTgt
        end
        if csMode=="message" and csMsg=="" then play(SND.error); csST.Text="enter a message"; csST.TextColor3=C.danger; return end
        if csMode~="message" and (csTgt=="" or csTgt==nil) then play(SND.error); csST.Text="enter a target"; csST.TextColor3=C.danger; return end
        play(SND.on); csOn=true; csGen=csGen+1; csST.Text="running · "..csMode; csST.TextColor3=C.good
        cS3.Text=csSym
        local g=csGen; task.spawn(function() csLoop(g) end)
    end
    local function csStopFn() csOn=false; csGen=csGen+1; csST.Text="stopped"; csST.TextColor3=C.text3 end
    onClick(cSt,csStartFn)
    onClick(cSp,function() play(SND.off); csStopFn() end)
end

-- ============================================================================
-- OTHERS TAB
-- ============================================================================
tabBuilders.others = function()
    local ap=pages.others; ap.CanvasSize=UDim2.fromOffset(0,1100)

    -- sub-sections like Target (UI / System)
    local oSubBar = Instance.new("Frame")
    oSubBar.Size = UDim2.new(1, 0, 0, 30)
    oSubBar.Position = UDim2.fromOffset(0, 0)
    oSubBar.BackgroundColor3 = C.glassTile
    oSubBar.BackgroundTransparency = 0.2
    oSubBar.BorderSizePixel = 0
    oSubBar.Parent = ap
    corner(oSubBar, 10)
    stroke(oSubBar, C.stroke, 1, 0.55)

    local uiSecBtn = BTN(oSubBar, "UI")
    uiSecBtn.Size = UDim2.new(0.5, -6, 1, -6)
    uiSecBtn.Position = UDim2.new(0, 3, 0, 3)
    uiSecBtn.TextSize = 11
    hov(uiSecBtn)

    local sysSecBtn = BTN(oSubBar, "System")
    sysSecBtn.Size = UDim2.new(0.5, -6, 1, -6)
    sysSecBtn.Position = UDim2.new(0.5, 3, 0, 3)
    sysSecBtn.TextSize = 11
    hov(sysSecBtn)

    local uiHost = Instance.new("Frame")
    uiHost.Name = "UISection"
    uiHost.Size = UDim2.new(1, 0, 0, 1000)
    uiHost.Position = UDim2.fromOffset(0, 38)
    uiHost.BackgroundTransparency = 1
    uiHost.Parent = ap

    local sysHost = Instance.new("Frame")
    sysHost.Name = "SystemSection"
    sysHost.Size = UDim2.new(1, 0, 0, 1000)
    sysHost.Position = UDim2.fromOffset(0, 38)
    sysHost.BackgroundTransparency = 1
    sysHost.Visible = false
    sysHost.Parent = ap

    local function showOthersSec(which)
        local isUI = which == "ui"
        uiHost.Visible = isUI
        sysHost.Visible = not isUI
        setToggle(uiSecBtn, isUI)
        setToggle(sysSecBtn, not isUI)
        if isUI then
            uiSecBtn.TextColor3 = Color3.fromRGB(8,8,12)
        else
            sysSecBtn.TextColor3 = Color3.fromRGB(8,8,12)
        end
        for _,b in ipairs({uiSecBtn, sysSecBtn}) do
            pcall(function()
                local f=C.font or Enum.Font.GothamMedium
                b.Font=f
                if C.fontFace then b.FontFace=C.fontFace end
            end)
        end
        play(SND.tab)
    end
    onClick(uiSecBtn, function() showOthersSec("ui") end)
    onClick(sysSecBtn, function() showOthersSec("system") end)
    showOthersSec("ui")

    -- UI SECTION: theme gallery with picture cards
    local uiTitle=L(uiHost,"Themes",13,C.text); uiTitle.Size=UDim2.new(1,0,0,18); uiTitle.Position=UDim2.fromOffset(0,0)
    local uiSub=L(uiHost,"tap a card · background + accent update together",9,C.text3)
    uiSub.Size=UDim2.new(1,0,0,12); uiSub.Position=UDim2.fromOffset(0,18)

    local themeBtns = {}
    local gapT, cardW, cardH = 8, 0, 72
    cardW = math.floor((innerW - gapT*3) / 4)
    local y = 38
    for i, name in ipairs(THEME_ORDER) do
        local row = math.floor((i-1)/4)
        local col = (i-1)%4
        local sdef = SHADERS[name]
        local card = Instance.new("TextButton")
        card.Size = UDim2.fromOffset(cardW, cardH)
        card.Position = UDim2.fromOffset(col*(cardW+gapT), y + row*(cardH+gapT))
        card.BackgroundColor3 = sdef.glassTile or C.glassTile
        card.BorderSizePixel = 0
        card.AutoButtonColor = false
        card.Text = ""
        card.Active = true
        card.Parent = uiHost
        corner(card, 10)
        local cst = stroke(card, sdef.stroke or C.stroke, 1, 0.35)

        -- picture area (gradient art)
        local pic = Instance.new("Frame")
        pic.Size = UDim2.new(1, -10, 0, 36)
        pic.Position = UDim2.fromOffset(5, 5)
        pic.BackgroundColor3 = sdef.glassBg or C.glassBg
        pic.BorderSizePixel = 0
        pic.Parent = card
        corner(pic, 7)
        local pg = Instance.new("UIGradient")
        pg.Rotation = 135
        pg.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, sdef.accent or C.accent),
            ColorSequenceKeypoint.new(0.45, sdef.wash or sdef.accentS or C.accentSoft),
            ColorSequenceKeypoint.new(1, sdef.glassBg or C.glassBg),
        }
        pg.Parent = pic
        local sym = Instance.new("TextLabel")
        sym.Size = UDim2.fromScale(1, 1)
        sym.BackgroundTransparency = 1
        sym.Text = sdef.symbol or "◆"
        sym.TextColor3 = Color3.fromRGB(255,255,255)
        sym.TextTransparency = 0.15
        sym.Font = Enum.Font.GothamBold
        sym.TextSize = 16
        sym.Parent = pic

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -8, 0, 16)
        label.Position = UDim2.fromOffset(4, 48)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = sdef.text or C.text
        label.Font = Enum.Font.GothamMedium
        label.TextSize = 10
        label.Parent = card

        -- accent chip
        local chip = Instance.new("Frame")
        chip.Size = UDim2.fromOffset(10, 10)
        chip.Position = UDim2.new(1, -16, 0, 8)
        chip.BackgroundColor3 = sdef.accent
        chip.BorderSizePixel = 0
        chip.Parent = pic
        corner(chip, 4)

        themeBtns[name] = { card=card, stroke=cst, label=label }
        onClick(card, function()
            applyShader(name)
            for n,t in pairs(themeBtns) do
                local on = (n == name)
                if on then
                    t.stroke.Color = C.accent
                    t.stroke.Transparency = 0.05
                    t.stroke.Thickness = 1.6
                else
                    local sd = SHADERS[n]
                    t.stroke.Color = sd and sd.stroke or C.stroke
                    t.stroke.Transparency = 0.35
                    t.stroke.Thickness = 1
                end
            end
            play(SND.success)
        end)
    end
    -- mark current
    do
        local t = themeBtns[currentThemeName]
        if t then t.stroke.Color = C.accent; t.stroke.Transparency = 0.05; t.stroke.Thickness = 1.6 end
    end
    local rows = math.ceil(#THEME_ORDER / 4)

    -- Panel size (moved to UI)
    local pszY = y + rows*(cardH+gapT) + 16
    local pszTitle=L(uiHost,"Panel Size",13,C.text); pszTitle.Size=UDim2.new(1,0,0,18); pszTitle.Position=UDim2.fromOffset(0,pszY)
    local pszSub=L(uiHost,"override auto-fit · 0.40 – 2.00",9,C.text3); pszSub.Size=UDim2.new(1,0,0,12); pszSub.Position=UDim2.fromOffset(0,pszY+18)
    local pszCard=glassTile(uiHost); pszCard.Size=UDim2.new(1,0,0,88); pszCard.Position=UDim2.fromOffset(0,pszY+36)
    local pszVal=L(pszCard,"1.00",11,C.text); pszVal.Size=UDim2.fromOffset(52,16); pszVal.Position=UDim2.new(1,-60,0,8); pszVal.TextXAlignment=Enum.TextXAlignment.Right
    local pszReset=BTN(pszCard,"Reset"); pszReset.Size=UDim2.fromOffset(60,18); pszReset.Position=UDim2.new(1,-130,0,8); pszReset.TextSize=10; hov(pszReset)
    local pszTrack=Instance.new("Frame"); pszTrack.Size=UDim2.new(1,-24,0,10); pszTrack.Position=UDim2.fromOffset(12,40)
    pszTrack.BackgroundColor3=C.glassInput; pszTrack.BackgroundTransparency=0.5; pszTrack.BorderSizePixel=0; pszTrack.Parent=pszCard; corner(pszTrack,5)
    local PSZ_MIN,PSZ_MAX=0.4,2.0
    local pszFill=Instance.new("Frame"); pszFill.Size=UDim2.new((PanelScale.Scale-PSZ_MIN)/(PSZ_MAX-PSZ_MIN),0,1,0)
    pszFill.BackgroundColor3=C.accent; pszFill.BackgroundTransparency=0.15; pszFill.BorderSizePixel=0; pszFill.Parent=pszTrack; corner(pszFill,5)
    local function applyPsz(v)
        v=math.clamp(v,PSZ_MIN,PSZ_MAX)
        pszFill.Size=UDim2.new((v-PSZ_MIN)/(PSZ_MAX-PSZ_MIN),0,1,0)
        pszVal.Text=string.format("%.2f",v)
        panelSizeUser=v; PanelScale.Scale=v
    end
    local function updatePszFromInput(input)
        local abs=pszTrack.AbsolutePosition; local sz=pszTrack.AbsoluteSize
        if sz.X<=0 then return end
        local rel=math.clamp((input.Position.X-abs.X)/sz.X,0,1)
        applyPsz(PSZ_MIN+rel*(PSZ_MAX-PSZ_MIN))
    end
    local pszDragging=false
    pszTrack.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            pszDragging=true; updatePszFromInput(i)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if pszDragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then updatePszFromInput(i) end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then pszDragging=false end
    end)
    onClick(pszReset,function()
        panelSizeUser=nil; PanelScale.Scale=1
        pszFill.Size=UDim2.new((1.0-PSZ_MIN)/(PSZ_MAX-PSZ_MIN),0,1,0)
        pszVal.Text="1.00"; play(SND.success)
        if applyMobileFit then pcall(applyMobileFit) end
    end)
    registerUIPoller(function()
        if panelSizeUser then pszVal.Text=string.format("%.2f",panelSizeUser)
        else pszVal.Text=string.format("%.2f·auto",PanelScale.Scale) end
    end)

    uiHost.Size = UDim2.new(1, 0, 0, pszY + 140)


    -- SYSTEM SECTION — Headtag + One Click Loud + Support
    local yOff = 0

    -- ── Headtag toggle ──────────────────────────────────────────────────────
    local htTitle = L(sysHost, "Headtag", 13, C.text)
    htTitle.Size = UDim2.new(1,0,0,18); htTitle.Position = UDim2.fromOffset(0, yOff)
    local htCard = glassTile(sysHost)
    htCard.Size = UDim2.new(1,0,0,52); htCard.Position = UDim2.fromOffset(0, yOff+22)

    local htL = L(htCard, "Jamun Headtag", 12, C.text)
    htL.Size = UDim2.new(1,-110,0,16); htL.Position = UDim2.fromOffset(12,8)
    local htD = L(htCard, "shows tag above Jamun users · theme-synced", 9, C.text3)
    htD.Size = UDim2.new(1,-110,0,13); htD.Position = UDim2.fromOffset(12,26)

    local htBtn = BTN(htCard, "OFF")
    htBtn.Size = UDim2.fromOffset(72,28); htBtn.Position = UDim2.new(1,-84,0.5,-14); hov(htBtn)

    local function refreshHtBtn()
        local on = __HT and __HT.Enabled == true
        setToggle(htBtn, on)
        htBtn.Text = on and "ON" or "OFF"
        htD.Text = on and "active · tags visible above Jamun users" or "shows tag above Jamun users · theme-synced"
        htD.TextColor3 = on and C.good or C.text3
    end
    onClick(htBtn, function()
        if __HT then
            __HT.SetEnabled(not __HT.Enabled)
            play(__HT.Enabled and SND.on or SND.off)
        end
        refreshHtBtn()
    end)
    registerUIPoller(refreshHtBtn)
    refreshHtBtn()
    yOff = yOff + 88

    local oclTitle=L(sysHost,"One Click Loud",13,C.text)
    oclTitle.Size=UDim2.new(1,0,0,18); oclTitle.Position=UDim2.fromOffset(0,yOff)
    local oclCard=glassTile(sysHost)
    oclCard.Size=UDim2.new(1,0,0,96); oclCard.Position=UDim2.fromOffset(0,yOff+22)
    local oclL=L(oclCard,"One Click Loud",11,C.text)
    oclL.Size=UDim2.new(1,-16,0,14); oclL.Position=UDim2.fromOffset(10,8)
    local oclD=L(oclCard,"Mic Up only · LOUD v3.1 · chorus · dist · eq · filter · reverb",9,C.text3)
    oclD.Size=UDim2.new(1,-16,0,24); oclD.Position=UDim2.fromOffset(10,26)
    oclD.TextWrapped=true
    local oclBtn=BTN(oclCard,"APPLY")
    oclBtn.Size=UDim2.new(1,-90,0,32); oclBtn.Position=UDim2.fromOffset(10,56)
    oclBtn.TextSize=13; oclBtn.Font=Enum.Font.GothamBold
    oclBtn.BackgroundColor3=C.accent; oclBtn.BackgroundTransparency=0.12
    oclBtn.TextColor3=Color3.fromRGB(8,8,12); hov(oclBtn)
    local oclMini=BTN(oclCard,"Panel")
    oclMini.Size=UDim2.fromOffset(64,32); oclMini.Position=UDim2.new(1,-74,0,56)
    oclMini.TextSize=11; hov(oclMini)
    onClick(oclMini, function()
        local m = ScreenGui:FindFirstChild("MiniLoud")
        if m then m.Visible = true end
        play(SND.tab)
    end)
    onClick(oclBtn, function()
        oclBtn.Text = "..."
        play(SND.on)
        task.spawn(function()
            local ok, msg = oclApply()
            if ok then
                oclBtn.Text = "APPLY"
                oclD.Text = "LOUD on · reapply anytime"
                oclD.TextColor3 = C.good
                play(SND.success)
            else
                oclBtn.Text = "APPLY"
                oclD.Text = tostring(msg)
                oclD.TextColor3 = C.danger
                play(SND.error)
            end
        end)
    end)

    yOff = yOff + 130
    local admTitle=L(sysHost,"Owner Admin Commands",13,C.text); admTitle.Size=UDim2.new(1,0,0,18); admTitle.Position=UDim2.fromOffset(0,yOff)
    local admCard=glassTile(sysHost); admCard.Size=UDim2.new(1,0,0,86); admCard.Position=UDim2.fromOffset(0,yOff+22)
    local admL=L(admCard,"Owner: @anime_akash99 (BBZ_JAMUN) · Prefix: ; ! .",10,C.accent)
    admL.Size=UDim2.new(1,-20,0,14); admL.Position=UDim2.fromOffset(10,8)
    local admD=L(admCard,";bring  ;tp  ;to  ;kill  ;freeze  ;sit  ;jump  ;fling  ;void  ;ws  ;jp  ;fly  ;noclip  ;spin  ;orbit  ;follow  ;blind  ;say  ;kick  ;rejoin  ;tag  ;untag  ;users  ;cmds",9,C.text2)
    admD.Size=UDim2.new(1,-20,0,54); admD.Position=UDim2.fromOffset(10,26)
    admD.TextWrapped=true; admD.TextYAlignment=Enum.TextYAlignment.Top

    yOff = yOff + 122
    local supportTitle=L(sysHost,"Support",13,C.text); supportTitle.Size=UDim2.new(1,0,0,18); supportTitle.Position=UDim2.fromOffset(0,yOff)
    local supportCard=glassTile(sysHost); supportCard.Size=UDim2.new(1,0,0,110); supportCard.Position=UDim2.fromOffset(0,yOff+22)
    local supportNote=L(supportCard,"thank you for using this script i appreciate your support if theres any glitch in the script contact me on discord - ibame_akash",11,C.text2)
    supportNote.Size=UDim2.new(1,-20,1,-16)
    supportNote.Position=UDim2.fromOffset(10,8)
    supportNote.TextWrapped=true
    supportNote.TextXAlignment=Enum.TextXAlignment.Left
    supportNote.TextYAlignment=Enum.TextYAlignment.Top
    supportNote.Font=Enum.Font.GothamMedium
    ap.CanvasSize=UDim2.fromOffset(0, math.max(uiHost.Size.Y.Offset + 50, yOff+200 + 38))
end

-- ============================================================================
-- DRAG
-- ============================================================================
local dragging,dragStart,startPos
Panel.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        dragging=true; dragStart=input.Position; startPos=Panel.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        local delta=input.Position-dragStart
        Panel.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
end)

-- ============================================================================
-- SIDE TOGGLE
-- ============================================================================
local SideBtn=Instance.new("TextButton")
SideBtn.Name="JamunSideToggle"
SideBtn.Size=UDim2.fromOffset(46,46); SideBtn.Position=UDim2.new(0,12,0.5,-23)
SideBtn.BackgroundColor3=C.glassBg; SideBtn.BackgroundTransparency=G.panelTransparency
SideBtn.BorderSizePixel=0; SideBtn.Text="★"; SideBtn.TextColor3=C.accent
SideBtn.Font=Enum.Font.GothamBold; SideBtn.TextSize=20; SideBtn.AutoButtonColor=false; SideBtn.Parent=ScreenGui
corner(SideBtn,14)
local sideStroke=stroke(SideBtn, C.accent, 1.4, 0.35)
local sideGrad=Instance.new("UIGradient")
sideGrad.Rotation=135
sideGrad.Color=ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 18, 26)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 10, 14)),
}
sideGrad.Parent=SideBtn
SideBtn.MouseEnter:Connect(function() TW:Create(SideBtn,TweenInfo.new(0.15),{BackgroundTransparency=0.02}):Play() end)
SideBtn.MouseLeave:Connect(function()
    if not pillDrag or not pillDrag.moved then
        TW:Create(SideBtn,TweenInfo.new(0.15),{BackgroundTransparency=G.panelTransparency}):Play()
    end
end)
local pillDrag=nil; local pillStartClock=0
SideBtn.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
        local abs=SideBtn.AbsolutePosition
        pillDrag={startI=i.Position,startP=Vector2.new(abs.X,abs.Y),startSize=SideBtn.AbsoluteSize,moved=false}
        pillStartClock=tick()
    end
end)
UIS.InputChanged:Connect(function(i)
    if not pillDrag then return end
    if i.UserInputType~=Enum.UserInputType.Touch and i.UserInputType~=Enum.UserInputType.MouseMovement then return end
    local d=i.Position-pillDrag.startI
    if math.abs(d.X)>4 or math.abs(d.Y)>4 then pillDrag.moved=true end
    if pillDrag.moved then
        local vp=WS.CurrentCamera and WS.CurrentCamera.ViewportSize or Vector2.new(1280,720)
        local nx=pillDrag.startP.X+d.X; local ny=pillDrag.startP.Y+d.Y
        local maxX=vp.X-pillDrag.startSize.X; local maxY=vp.Y-pillDrag.startSize.Y
        if maxX<0 then maxX=0 end; if maxY<0 then maxY=0 end
        nx=math.clamp(nx,0,maxX); ny=math.clamp(ny,0,maxY)
        SideBtn.Position=UDim2.fromOffset(nx,ny)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType~=Enum.UserInputType.Touch and i.UserInputType~=Enum.UserInputType.MouseButton1 then return end
    if not pillDrag then return end
    local wasDrag=pillDrag.moved
    pillDrag=nil
    if not wasDrag and (tick()-pillStartClock)<0.6 then setOpen(not open) end
end)


-- ============================================================================
-- MINI PANELS (Loud / Walkspeed / Fly) — small, closable, no main panel needed
-- ============================================================================
local function makeDraggable(frame)
    local drag, d0, p0
    frame.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            drag=true; d0=i.Position; p0=frame.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if not drag then return end
        if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
            local d=i.Position-d0
            frame.Position=UDim2.new(p0.X.Scale,p0.X.Offset+d.X,p0.Y.Scale,p0.Y.Offset+d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
    end)
end

local function mkMiniShell(name, title, w, h, pos)
    local f=Instance.new("Frame")
    f.Name=name
    f.Size=UDim2.fromOffset(w,h)
    f.Position=pos
    f.BackgroundColor3=C.glassBg
    f.BackgroundTransparency=G.panelTransparency
    f.BorderSizePixel=0
    f.Active=true
    f.Visible=false
    f.Parent=ScreenGui
    corner(f,10)
    stroke(f,C.stroke,1.2,0.3)
    local t=Instance.new("TextLabel")
    t.BackgroundTransparency=1
    t.Size=UDim2.new(1,-28,0,18)
    t.Position=UDim2.fromOffset(8,6)
    t.Font=Enum.Font.GothamBold
    t.TextSize=11
    t.TextColor3=C.text
    t.TextXAlignment=Enum.TextXAlignment.Left
    t.Text=title
    t.Parent=f
    local x=Instance.new("TextButton")
    x.Size=UDim2.fromOffset(20,20)
    x.Position=UDim2.new(1,-24,0,4)
    x.BackgroundTransparency=1
    x.Text="×"
    x.TextColor3=C.text3
    x.Font=Enum.Font.GothamBold
    x.TextSize=16
    x.AutoButtonColor=false
    x.Parent=f
    onClick(x,function() f.Visible=false end)
    makeDraggable(f)
    return f
end

-- Loud mini
local MiniLoud = mkMiniShell("MiniLoud","One Click Loud",150,92,UDim2.new(0,12,0.35,0))
local mlNote=Instance.new("TextLabel")
mlNote.BackgroundTransparency=1
mlNote.Size=UDim2.new(1,-12,0,14)
mlNote.Position=UDim2.fromOffset(6,24)
mlNote.Font=Enum.Font.Gotham
mlNote.TextSize=9
mlNote.TextColor3=C.text3
mlNote.TextXAlignment=Enum.TextXAlignment.Left
mlNote.Text="Mic Up only"
mlNote.Parent=MiniLoud
local mlBtn=Instance.new("TextButton")
mlBtn.Size=UDim2.new(1,-16,0,34)
mlBtn.Position=UDim2.fromOffset(8,48)
mlBtn.BackgroundColor3=C.accent
mlBtn.BackgroundTransparency=0.1
mlBtn.Text="APPLY"
mlBtn.TextColor3=Color3.fromRGB(8,8,12)
mlBtn.Font=Enum.Font.GothamBold
mlBtn.TextSize=13
mlBtn.BorderSizePixel=0
mlBtn.AutoButtonColor=false
mlBtn.Parent=MiniLoud
corner(mlBtn,8)
onClick(mlBtn,function()
    mlBtn.Text="..."
    play(SND.on)
    task.spawn(function()
        local ok,msg=oclApply()
        mlBtn.Text="APPLY"
        mlNote.Text = ok and "applied · reapply ok" or tostring(msg)
        mlNote.TextColor3 = ok and C.good or C.danger
        if ok then play(SND.success) else play(SND.error) end
    end)
end)

-- Walkspeed mini
local MiniWS = mkMiniShell("MiniWS","Walk Speed",150,100,UDim2.new(0,12,0.50,0))
local mwBox=Instance.new("TextBox")
mwBox.Size=UDim2.new(1,-16,0,26)
mwBox.Position=UDim2.fromOffset(8,28)
mwBox.BackgroundColor3=C.glassInput
mwBox.BackgroundTransparency=G.inputTransparency
mwBox.Text=tostring(wsVal)
mwBox.PlaceholderText="speed"
mwBox.TextColor3=C.text
mwBox.PlaceholderColor3=C.text3
mwBox.Font=Enum.Font.GothamMedium
mwBox.TextSize=12
mwBox.BorderSizePixel=0
mwBox.ClearTextOnFocus=true
mwBox.Parent=MiniWS
corner(mwBox,6)
local mwBtn=Instance.new("TextButton")
mwBtn.Size=UDim2.new(1,-16,0,28)
mwBtn.Position=UDim2.fromOffset(8,62)
mwBtn.BackgroundColor3=C.glassInput
mwBtn.BackgroundTransparency=G.inputTransparency
mwBtn.Text="OFF"
mwBtn.TextColor3=C.text2
mwBtn.Font=Enum.Font.GothamBold
mwBtn.TextSize=12
mwBtn.BorderSizePixel=0
mwBtn.AutoButtonColor=false
mwBtn.Parent=MiniWS
corner(mwBtn,7)
local function refreshMiniWS()
    mwBtn.Text = wsOn and "ON" or "OFF"
    if wsOn then
        mwBtn.BackgroundColor3=C.accent
        mwBtn.BackgroundTransparency=0.08
        mwBtn.TextColor3=Color3.fromRGB(8,8,12)
    else
        mwBtn.BackgroundColor3=C.glassInput
        mwBtn.BackgroundTransparency=G.inputTransparency
        mwBtn.TextColor3=C.text2
    end
    mwBox.Text=tostring(wsVal)
end
onClick(mwBtn,function()
    local n=tonumber(mwBox.Text)
    if n and n>=0 and n<=1000 then wsVal=n end
    if wsOn then
        wsOn=false
        local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=DEFAULT_WALKSPEED end
        play(SND.off)
    else
        wsOn=true
        local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed=wsVal end
        play(SND.on)
    end
    refreshMiniWS()
end)
mwBox.FocusLost:Connect(function()
    local n=tonumber(mwBox.Text)
    if n and n>=0 and n<=1000 then
        wsVal=n
        if wsOn then
            local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed=wsVal end
        end
    else
        mwBox.Text=tostring(wsVal)
    end
end)

-- Fly mini
local MiniFly = mkMiniShell("MiniFly","Fly",120,72,UDim2.new(0,12,0.65,0))
local mfBtn=Instance.new("TextButton")
mfBtn.Size=UDim2.new(1,-16,0,32)
mfBtn.Position=UDim2.fromOffset(8,30)
mfBtn.BackgroundColor3=C.glassInput
mfBtn.BackgroundTransparency=G.inputTransparency
mfBtn.Text="OFF"
mfBtn.TextColor3=C.text2
mfBtn.Font=Enum.Font.GothamBold
mfBtn.TextSize=12
mfBtn.BorderSizePixel=0
mfBtn.AutoButtonColor=false
mfBtn.Parent=MiniFly
corner(mfBtn,7)
local function refreshMiniFly()
    if FLY.active then
        mfBtn.Text="ON"
        mfBtn.BackgroundColor3=C.accent
        mfBtn.BackgroundTransparency=0.08
        mfBtn.TextColor3=Color3.fromRGB(8,8,12)
    else
        mfBtn.Text="OFF"
        mfBtn.BackgroundColor3=C.glassInput
        mfBtn.BackgroundTransparency=G.inputTransparency
        mfBtn.TextColor3=C.text2
    end
end
onClick(mfBtn,function()
    if FLY.active then
        _G.stopJamunFly()
        play(SND.off)
    else
        _G.startJamunFly()
        play(SND.on)
    end
    refreshMiniFly()
end)
registerUIPoller(function()
    if MiniWS.Visible then refreshMiniWS() end
    if MiniFly.Visible then refreshMiniFly() end
end)



-- ============================================================================
-- BOOT
-- ============================================================================
if retintPanel then pcall(retintPanel) end
if applyMobileFit then pcall(applyMobileFit) end
task.defer(function() if applyMobileFit then pcall(applyMobileFit) end end)


-- ============================================================================
-- REANIM TAB
-- ============================================================================
tabBuilders.reanim = function()
    local rp = pages.reanim
    rp.ClipsDescendants = true
    for _, ch in ipairs(rp:GetChildren()) do pcall(function() ch:Destroy() end) end

    -- sub-bar matching others tab style
    local rSubBar = Instance.new("Frame")
    rSubBar.Size = UDim2.new(1,0,0,30); rSubBar.Position = UDim2.fromOffset(0,0)
    rSubBar.BackgroundColor3 = C.glassTile; rSubBar.BackgroundTransparency = 0.2
    rSubBar.BorderSizePixel = 0; rSubBar.Parent = rp
    corner(rSubBar, 10); stroke(rSubBar, C.stroke, 1, 0.55)

    local rAnimBtn = BTN(rSubBar, "Animations")
    rAnimBtn.Size = UDim2.new(0.5,-6,1,-6); rAnimBtn.Position = UDim2.new(0,3,0,3)
    rAnimBtn.TextSize = 11; hov(rAnimBtn)

    local rSettBtn = BTN(rSubBar, "Settings")
    rSettBtn.Size = UDim2.new(0.5,-6,1,-6); rSettBtn.Position = UDim2.new(0.5,3,0,3)
    rSettBtn.TextSize = 11; hov(rSettBtn)

    -- embed container sits below sub-bar
    local embedHost = Instance.new("Frame")
    embedHost.Size = UDim2.new(1,0,1,-38); embedHost.Position = UDim2.fromOffset(0,38)
    embedHost.BackgroundTransparency = 1; embedHost.ClipsDescendants = true
    embedHost.Parent = rp

    local function showReanimSec(which)
        local isAnim = which == "anim"
        setToggle(rAnimBtn, isAnim); setToggle(rSettBtn, not isAnim)
        if isAnim then rAnimBtn.TextColor3 = Color3.fromRGB(8,8,12)
        else rSettBtn.TextColor3 = Color3.fromRGB(8,8,12) end
        play(SND.tab)
        -- show/hide embed sections if buildAngoorReanimTab exposes them
        local embed = embedHost:FindFirstChild("ZenReanimEmbed")
        if embed then
            for _, ch in ipairs(embed:GetDescendants()) do
                if ch.Name == "AnimationsPanel" then ch.Visible = isAnim end
                if ch.Name == "SettingsPanel" then ch.Visible = not isAnim end
            end
        end
    end
    onClick(rAnimBtn, function() showReanimSec("anim") end)
    onClick(rSettBtn, function() showReanimSec("settings") end)

    if type(_G.buildAngoorReanimTab) == "function" then
        pcall(_G.buildAngoorReanimTab, embedHost)
        local embed = embedHost:FindFirstChild("ZenReanimEmbed")
        if embed then
            embed.Position = UDim2.new(0,0,0,0)
            embed.Size = UDim2.fromScale(1,1)
            embed.AnchorPoint = Vector2.new(0,0)
            embed.ClipsDescendants = true
        end
    else
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.fromScale(1,1); lbl.BackgroundTransparency = 1
        lbl.Text = "reanim module not loaded"; lbl.TextColor3 = C.danger
        lbl.Font = Enum.Font.GothamMedium; lbl.TextSize = 12; lbl.Parent = embedHost
    end

    -- default to Animations sec
    setToggle(rAnimBtn, true); rAnimBtn.TextColor3 = Color3.fromRGB(8,8,12)
    setToggle(rSettBtn, false)
end

print("[Jamun Welder] building UI…")
local okOpen, errOpen = pcall(function() setOpen(true) end)
if not okOpen then
    warn("[Jamun Welder] setOpen error:", errOpen)
    print("[Jamun Welder] setOpen error:", tostring(errOpen))
end
local okTab, errTab = pcall(function() selectTab("target") end)
if not okTab then
    warn("[Jamun Welder] selectTab error:", errTab)
    print("[Jamun Welder] selectTab error:", tostring(errTab))
    -- fallback: still try open empty panel
    pcall(function() setOpen(true) end)
else
    print("[Jamun Welder] loaded · v10.0 Riyon Obsidian GUI + Headtag + Admin")
end


end

local okUI, errUI = pcall(__jamunBuildUI)
if not okUI then
    warn("[Jamun Welder] UI build failed:", errUI)
    print("[Jamun Welder] UI build failed:", tostring(errUI))
else
    print("[Jamun Welder] UI ready · delta-safe")
end
