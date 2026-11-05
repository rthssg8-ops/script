print(string.char(91,75,72,65,77,65,78,32,68,72,79,75,76,65,93,32,86,51,55,32,71,111,108,100,101,110,32,84,97,100,107,97,32,90,101,114,111,45,68,101,108,97,121,32,38,32,82,101,102,105,110,101,100,32,85,73,32,69,100,105,116,105,111,110,32,98,111,111,116,115,116,114,97,112,112,105,110,103,46,46,46))
if not game:IsLoaded() then
local _0xF999 = pcall(function() game.Loaded:Wait() end)
if not _0xF999 then task.wait(1) end
end
local _0xC77A = game:GetService(string.char(82,117,110,83,101,114,118,105,99,101))
local _0xC3F7 = game:GetService(string.char(80,108,97,121,101,114,115))
local _0xB2E3 = game:GetService(string.char(85,115,101,114,73,110,112,117,116,83,101,114,118,105,99,101))
local _0xFD0E = game:GetService(string.char(84,119,101,101,110,83,101,114,118,105,99,101))
local _0x19ED = game:GetService(string.char(68,101,98,114,105,115))
local _0xD606 = game:GetService(string.char(83,111,117,110,100,83,101,114,118,105,99,101))
local _0x4CD5 = game:GetService(string.char(83,116,97,114,116,101,114,71,117,105))
local _0x2083 = game:GetService(string.char(82,101,112,108,105,99,97,116,101,100,83,116,111,114,97,103,101))
local _0xC00E = game:GetService(string.char(84,101,120,116,67,104,97,116,83,101,114,118,105,99,101))
local _0x6B21 = nil
pcall(function() _0x6B21 = game:GetService(string.char(67,111,114,101,71,117,105)) end)local _0xA6AA = _0xC3F7.LocalPlayer
local _0xF60B = tick()
while not _0xA6AA and tick() - _0xF60B < 12 do
task.wait(0.1)
_0xA6AA = _0xC3F7.LocalPlayer
end
if not _0xA6AA then
warn(string.char(91,75,72,65,77,65,78,32,68,72,79,75,76,65,93,32,83,116,97,114,116,117,112,32,115,116,111,112,112,101,100,58,32,76,111,99,97,108,80,108,97,121,101,114,32,119,97,115,32,117,110,97,118,97,105,108,97,98,108,101,32,97,102,116,101,114,32,49,50,32,115,101,99,111,110,100,115,46,32,69,120,101,99,117,116,101,32,97,102,116,101,114,32,106,111,105,110,105,110,103,32,97,32,103,97,109,101,46))
return
end
local _0xF28E = nillocal function _0x6A77()
local _0x4CD6 = _0xA6AA:FindFirstChildOfClass(string.char(80,108,97,121,101,114,71,117,105)) or _0xA6AA:FindFirstChild(string.char(80,108,97,121,101,114,71,117,105))
if not _0x4CD6 then
pcall(function() _0x4CD6 = _0xA6AA:WaitForChild(string.char(80,108,97,121,101,114,71,117,105), 6) end)
end
if _0x4CD6 then return _0x4CD6 end
local _0xA819, _0x90C7 = pcall(function()
if typeof(gethui) ==string.char(102,117,110,99,116,105,111,110)then return gethui() end
return nil
end)
if _0xA819 and typeof(_0x90C7) ==string.char(73,110,115,116,97,110,99,101)then return _0x90C7 end
if _0x6B21 then
local _0xF999 = pcall(function() return _0x6B21:GetChildren() end)
if _0xF999 then return _0x6B21 end
end
return _0xA6AA:FindFirstChildOfClass(string.char(80,108,97,121,101,114,71,117,105))
end
local _0x9617 = _0x6A77()
if not _0x9617 then
warn(string.char(91,75,72,65,77,65,78,32,68,72,79,75,76,65,93,32,71,85,73,32,99,111,110,116,97,105,110,101,114,32,109,105,115,115,105,110,103,46,32,82,101,45,101,120,101,99,117,116,101,32,97,102,116,101,114,32,106,111,105,110,105,110,103,32,97,32,103,97,109,101,46))
return
end
local function _0x3CEC(container)
if not container then return end
pcall(function()
for _0x9094, child in ipairs(container:GetChildren()) do
if child.Name:match(string.char(94,75,104,97,109,97,110,68,104,111,107,108,97)) or child.Name:match(string.char(94,67,111,99,111,80,111,119,100,101,114)) then
child:Destroy()
end
end
end)
end
_0x3CEC(_0x9617)
_0x3CEC(_0xA6AA:FindFirstChildOfClass(string.char(80,108,97,121,101,114,71,117,105)))
if _0x6B21 then _0x3CEC(_0x6B21) end
local _0x2668 = _0x2668 or set_hidden_property or set_hidden_prop
local _0x3E41 = nil
pcall(function()
if InstanceHandle and typeof(InstanceHandle.new) ==string.char(102,117,110,99,116,105,111,110)then
_0x3E41 = InstanceHandle.new
end
end)local _0x8319 = workspace.CurrentCamera or workspace:FindFirstChildOfClass(string.char(67,97,109,101,114,97))
if not _0x8319 then
local _0x599C = tick()
while not _0x8319 and tick() - _0x599C < 2.0 do
task.wait(0.1)
_0x8319 = workspace.CurrentCamera or workspace:FindFirstChildOfClass(string.char(67,97,109,101,114,97))
end
end
workspace:GetPropertyChangedSignal(string.char(67,117,114,114,101,110,116,67,97,109,101,114,97)):Connect(function()
if workspace.CurrentCamera then
_0x8319 = workspace.CurrentCamera
end
end)
local _0x90E7 = {BG = Color3.fromRGB(28, 21, 6),BG2 = Color3.fromRGB(42, 31, 9),Panel = Color3.fromRGB(58, 44, 12),PanelLt = Color3.fromRGB(82, 62, 17),Border = Color3.fromRGB(218, 165, 32),Accent = Color3.fromRGB(250, 204, 21),Accent2 = Color3.fromRGB(217, 138, 10),Neon = Color3.fromRGB(254, 243, 148),Success = Color3.fromRGB(38, 198, 90),Danger = Color3.fromRGB(239, 68, 68),Warning = Color3.fromRGB(245, 168, 18),Pink = Color3.fromRGB(252, 211, 77),Purple = Color3.fromRGB(234, 179, 8),Text = Color3.fromRGB(255, 252, 238),Muted = Color3.fromRGB(224, 201, 142),Dark = Color3.fromRGB(18, 13, 4),Active = Color3.fromRGB(108, 82, 20),}
local function _0xD64C(id, vol, pitch)
pcall(function()
local _0x87D3 = Instance.new(string.char(83,111,117,110,100))
_0x87D3.SoundId =string.char(114,98,120,97,115,115,101,116,105,100,58,47,47).. tostring(id)
_0x87D3.Volume = vol or 0.4
_0x87D3.PlaybackSpeed = pitch or 1
_0x87D3.Parent = _0xD606
_0x87D3:Play()
_0x19ED:AddItem(_0x87D3, 4)
end)
end
local _0x0909 = function() _0xD64C(12221967, 0.35, 1.8) end
local _0x9FE9 = function() _0xD64C(12221967, 0.12, 2.5) end
local _0xCAE4 = function() _0xD64C(5696552322, 0.5, 1.2) end
local _0xB065 = function() _0xD64C(5766952670, 0.5, 0.9) end
local _0xF140 = function() _0xD64C(5696552322, 0.4, 1.6) end
local _0xED6E = function() _0xD64C(5696552322, 0.4, 0.7) end
local _0xEA8A = function() _0xD64C(6895079853, 0.5, 1.4) end
local _0x6F35 = function() _0xD64C(9069609267, 0.6, 1.2) end
local _0x2DB3 = nil
local _0x8AC6 = nil
local function _0xA387(_0x1412, text)
pcall(function()
_0x4CD5:SetCore(string.char(83,101,110,100,78,111,116,105,102,105,99,97,116,105,111,110), {
Title = _0x1412 orstring.char(75,72,65,77,65,78,32,68,72,79,75,76,65),
Text = text or"",
Duration = 3,
Icon =string.char(114,98,120,97,115,115,101,116,105,100,58,47,47,49,48,56,53,48,50,53,55,52,48,52)})
end)
end
local function _0xA1A7(player)
if not player or not player.Character then return nil end
local _0xA778 = player.Character:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0xA778 then return nil end
return _0xA778.RigType
end
local function _0xC5B7(player)
return _0xA1A7(player) == Enum.HumanoidRigType.R15
end
local _0x68F1 = { X = 0, Y = 0, Z = 1.3, RX = 0, RY = 0, RZ = 0, Speed = 1.0 }
local _0xB42E = nil
local _0x6652 = nil
local _0x0A85 = nillocal _0xA36A = nil
local _0xBBEA = {}
local function _0x7A5D(player)if not _0xA36A or not _0xA36A.Parent then return end
if player and player.Parent == _0xC3F7 then
_0xA36A.Text = player.Name
else
_0xA36A.Text =""end
end
local _0x8668 = workspace.FallenPartsDestroyHeight
if _0x8668 ~= _0x8668 or _0x8668 < -10000 or _0x8668 > 500 then
_0x8668 = -500
end
local _0xF0B5 = nil
local _0x2CD3 = true
local _0x839F = nil
local _0x518F = nil
local _0x243A = { _0x0A3D = false, presetKey = nil, _0x43DF = nil, waitingForSpawn = false, autoNearest = false }
local _0x4964 = 0
local _0xF3B0 = false
local _0xB7ED = nil
local _0xCE0F = nil
local _0x5752 = nil
local _0x4652 = nil
local _0xBF41 = nil
local _0xA2C6 = nil
local _0x3FD6 = nil
local _0x7067 = nil
local _0x1FB2 = 0
local _0x5BCC = false
local _0xA9FC = {}local function _0x97B4(_0x5685)
if not _0x5685 then return false end
local _0x41D2 = _0x5685.Position
if _0x41D2.X ~= _0x41D2.X or _0x41D2.Y ~= _0x41D2.Y or _0x41D2.Z ~= _0x41D2.Z then return false end
local _0x110E = _0x8668 + 15
if _0x41D2.Y <= _0x110E or _0x41D2.Y > 150000 then return false end
if _0x41D2.Magnitude > 250000 then return false end
return true
endlocal function _0xD510(_0x5685, velocity)
if not _0x5685 then return true end
local _0x41D2 = _0x5685.Position
if _0x41D2.X ~= _0x41D2.X or _0x41D2.Y ~= _0x41D2.Y or _0x41D2.Z ~= _0x41D2.Z then return true end
if _0x41D2.Magnitude > 450000 then return true end
local _0x94A3 = velocity and velocity.Y or 0
if _0x41D2.Y <= (_0x8668 + 8) then return true end
if _0x41D2.Y <= (_0x8668 + 45) and _0x94A3 < -95 then return true end
return false
end
local function _0x6660()
if _0x97B4(_0x7067) then
return _0x7067
end
local _0xD18E = workspace:FindFirstChildWhichIsA(string.char(83,112,97,119,110,76,111,99,97,116,105,111,110), true)
if _0xD18E and _0x97B4(_0xD18E.CFrame) then
return _0xD18E.CFrame + Vector3.new(0, 4, 0)
end
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= _0xA6AA and (not _0xF3B0 or _0x1CEE ~= _0x6652) and _0x1CEE.Character then
local _0x5CFE = _0x1CEE.Character:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116))
if _0x5CFE and _0x97B4(_0x5CFE.CFrame) then
return _0x5CFE.CFrame * CFrame.new(0, 2, 4)
end
end
end
return CFrame.new(0, 35, 0)
end
local _0x5DAB
local _0xC3EF
local _0xDF2E
local _0x207A
local _0x363C
local _0xAE44
local _0xB106 = false
local _0x1978 = false
local _0x8A10 = {}
local _0x77B5 = {}
local _0xD7A4 = {}local function _0x1B4F()
return (_0xB42E ~= nil and not _0xB42E.destroyed) or _0xF3B0
endlocal _0x02BF = {
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
local _0x3E10 = 0local _0x977C = setmetatable({}, { __mode =string.char(107)})
local function _0x04D0(_0x5BFE)
if not _0x5BFE then return {} end
local _0x4599 = _0x977C[_0x5BFE]
if _0x4599 then return _0x4599.parts end
local _0x6B2D = {}
for _0x9094, _0x000B in ipairs(_0x5BFE:GetDescendants()) do
if _0x000B:IsA(string.char(66,97,115,101,80,97,114,116)) then
_0x6B2D[#_0x6B2D + 1] = _0x000B
end
end
_0x4599 = { _0x6B2D = _0x6B2D }
_0x977C[_0x5BFE] = _0x4599
_0x5BFE.DescendantAdded:Connect(function(_0x000B)
if _0x000B:IsA(string.char(66,97,115,101,80,97,114,116)) then
_0x6B2D[#_0x6B2D + 1] = _0x000B
end
end)
_0x5BFE.DescendantRemoving:Connect(function(_0x000B)
if _0x000B:IsA(string.char(66,97,115,101,80,97,114,116)) then
for i = #_0x6B2D, 1, -1 do
if _0x6B2D[i] == _0x000B then
table.remove(_0x6B2D, i)
break
end
end
end
end)
return _0x6B2D
endlocal function _0x4DA4(_0x5BFE)
if not _0x5BFE then return nil end
local _0xDD60 = _0x5BFE:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116))
if _0xDD60 and _0xDD60:IsA(string.char(66,97,115,101,80,97,114,116)) then return _0xDD60 end
local _0xA778 = _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA778 and _0xA778.RootPart and _0xA778.RootPart:IsA(string.char(66,97,115,101,80,97,114,116)) then return _0xA778.RootPart end
if _0x5BFE.PrimaryPart and _0x5BFE.PrimaryPart:IsA(string.char(66,97,115,101,80,97,114,116)) then return _0x5BFE.PrimaryPart end
local _0xA604 = _0x5BFE:FindFirstChild(string.char(85,112,112,101,114,84,111,114,115,111)) or _0x5BFE:FindFirstChild(string.char(76,111,119,101,114,84,111,114,115,111)) or _0x5BFE:FindFirstChild(string.char(84,111,114,115,111)) or _0x5BFE:FindFirstChild(string.char(72,101,97,100))
if _0xA604 and _0xA604:IsA(string.char(66,97,115,101,80,97,114,116)) then return _0xA604 end
return _0x5BFE:FindFirstChildWhichIsA(string.char(66,97,115,101,80,97,114,116))
endlocal function _0xF424(_0x5BFE)
if not _0x5BFE then return end
local _0xA778 = _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA778 then
pcall(function()
local _0x0E07 = _0xA778.SeatPart
if _0x0E07 then
pcall(function() _0x0E07.CanTouch = false end)
for _0x9094, _0x25EB in ipairs(_0x0E07:GetDescendants()) do
if _0x25EB:IsA(string.char(87,101,108,100)) or _0x25EB:IsA(string.char(87,101,108,100,67,111,110,115,116,114,97,105,110,116)) or _0x25EB:IsA(string.char(77,111,116,111,114,54,68)) or _0x25EB.Name ==string.char(83,101,97,116,87,101,108,100)then
_0x25EB:Destroy()
end
end
end
_0xA778.Sit = false
end)
end
for _0x9094, _0x69FF in ipairs(_0x5BFE:GetDescendants()) do
if _0x69FF:IsA(string.char(83,101,97,116,87,101,108,100)) or _0x69FF.Name ==string.char(83,101,97,116,87,101,108,100)then
pcall(function() _0x69FF:Destroy() end)
elseif _0x69FF:IsA(string.char(66,97,115,101,80,97,114,116)) then
local _0x2340, _0x4BFD = pcall(function() return _0x69FF:GetJoints() end)
if _0x2340 and _0x4BFD then
for _0x9094, j in ipairs(_0x4BFD) do
if j:IsA(string.char(74,111,105,110,116,73,110,115,116,97,110,99,101)) or j:IsA(string.char(87,101,108,100,67,111,110,115,116,114,97,105,110,116)) then
local _0xD8D8, _0x9AC3 = j.Part0, j.Part1
local _0x5043 = _0xD8D8 and _0xD8D8:IsDescendantOf(_0x5BFE)
local _0x57B1 = _0x9AC3 and _0x9AC3:IsDescendantOf(_0x5BFE)
if (_0x5043 and _0x9AC3 and not _0x57B1) or (_0x57B1 and _0xD8D8 and not _0x5043) then
pcall(function() j:Destroy() end)
end
end
end
end
end
end
end
local _0x3C23 = {}
function _0x3C23:StopAllAnimations()
for _0x9094, _0xA453 in ipairs(_0xBBEA) do
pcall(function() _0xA453:Stop(0) end)
pcall(function() _0xA453:Destroy() end)
end
_0xBBEA = {}
end
function _0x3C23:ResetPhysics(character)
if not character then return end
local _0xE5AE = _0x4DA4(character)
if _0xE5AE then
if _0x2668 then
pcall(function() _0x2668(_0xE5AE,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), nil) end)
pcall(function() _0x2668(_0xE5AE,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), nil) end)
end
_0xE5AE.Anchored = false
_0xE5AE.AssemblyLinearVelocity = Vector3.zero
_0xE5AE.AssemblyAngularVelocity = Vector3.zero
end
for _0x9094, _0x5959 in ipairs(_0x04D0(character)) do
if _0x5959.Parent then
_0x5959.Massless = false
pcall(function() _0x5959.CustomPhysicalProperties = nil end)
if not (_0x02BF and _0x02BF.noclip) and (_0x5959.Name ==string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116)or _0x5959.Name ==string.char(84,111,114,115,111)or _0x5959.Name ==string.char(85,112,112,101,114,84,111,114,115,111)or _0x5959.Name ==string.char(76,111,119,101,114,84,111,114,115,111)or _0x5959.Name ==string.char(72,101,97,100)) then
_0x5959.CanCollide = true
end
end
end
end
function _0x3C23:StopFling(skipReturn)
local _0xC45F = _0xF3B0
local _0x2AAA = _0xCE0F
if _0xB7ED then _0xB7ED:Disconnect(); _0xB7ED = nil end
if self.FlingStepConn then self.FlingStepConn:Disconnect(); self.FlingStepConn = nil end
if _0xA6AA.Character then
local _0x32EC = _0x4DA4(_0xA6AA.Character)
if _0x32EC and _0x2668 then
pcall(function() _0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), nil) end)
pcall(function() _0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), nil) end)
end
for _0x9094, _0x5959 in ipairs(_0x04D0(_0xA6AA.Character)) do
if _0x5959.Parent then
pcall(function() _0x5959.CustomPhysicalProperties = nil end)
end
end
end
_0xF3B0 = false
_0xCE0F = nil
if _0xA2C6 then _0xA2C6.Visible = false end
local _0x6EE9 = workspace.CurrentCamera
if _0x6EE9 and (_0x5752 or _0x4652) then
pcall(function()
_0x6EE9.CameraType = _0x5752 or Enum.CameraType.Custom
local _0x4545 = _0xA6AA.Character and _0xA6AA.Character:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
_0x6EE9.CameraSubject = _0x4545 or _0x4652
end)
end
_0x5752 = nil
_0x4652 = nil
_0xBF41 = nil
if _0xC45F and not skipReturn and _0xA6AA.Character then
_0x1FB2 = tick()
_0xDF2E(_0xA6AA.Character, _0x2AAA)
end
if _0x207A then pcall(_0x207A) end
end
function _0x3C23:Cleanup(keepTarget, skipReturn)
if _0xB42E then
pcall(function() _0xB42E:Destroy(skipReturn) end)
_0xB42E = nil
end
self:StopAllAnimations()
self:StopFling(skipReturn)
if _0xF0B5 then
pcall(function()
local _0x6EE9 = workspace.CurrentCamera
if _0x6EE9 then
_0x6EE9.CameraSubject = _0xF0B5
_0x6EE9.CameraType = Enum.CameraType.Custom
end
end)
_0xF0B5 = nil
end
if _0xA6AA.Character and not skipReturn then
self:ResetPhysics(_0xA6AA.Character)
local _0xE5AE = _0x4DA4(_0xA6AA.Character)
if _0xE5AE and not _0x97B4(_0xE5AE.CFrame) then
_0xDF2E(_0xA6AA.Character, _0x7067)
end
end
if not keepTarget then _0x6652 = nil end
end
local _0x8AAF = 0.12
local _0xEB3A = 2
local function _0xC7E9(_0xA778)
if not _0xA778 then return end
pcall(function() _0xA778:SetStateEnabled(Enum.HumanoidStateType.Physics, true) end)
pcall(function() _0xA778:ChangeState(Enum.HumanoidStateType.Physics) end)
end
local function _0x1A56(animId)
local _0x1224 = tostring(animId or""):gsub(string.char(37,115,43),"")
local _0x34FF = _0x1224:match(string.char(40,37,100,43,41,36))
return _0x34FF or _0x1224
endlocal function _0x8052(_0xFC4D, animId, fallbacks, _0xA778, priority)
if not _0xFC4D or not animId then return nil, nil end
local _0x1DAA = _0x1A56(animId)
if _0x1DAA ==""then return nil, nil end
local _0xC20E = Instance.new(string.char(65,110,105,109,97,116,105,111,110))
_0xC20E.AnimationId =string.char(114,98,120,97,115,115,101,116,105,100,58,47,47).. _0x1DAA
local _0x5253, _0xA453 = pcall(function() return _0xFC4D:LoadAnimation(_0xC20E) end)
if (not _0x5253 or not _0xA453) and _0xA778 then
_0x5253, _0xA453 = pcall(function() return _0xA778:LoadAnimation(_0xC20E) end)
end
if _0x5253 and _0xA453 then
pcall(function() _0xA453.Priority = priority or Enum.AnimationPriority.Action4 end)
pcall(function() if not _0xA453.Priority then _0xA453.Priority = Enum.AnimationPriority.Action end end)
pcall(function() _0xA453.Looped = true end)
_0xC7E9(_0xA778)
local _0x0084 = math.clamp(_0x68F1.Speed or 1.0, 0.2, 6.0)
local _0x8581 = pcall(function() _0xA453:Play(0, 1, _0x0084) end)
if _0x8581 then
pcall(function() _0xA453:AdjustSpeed(_0x0084) end)
table.insert(_0xBBEA, _0xA453)
return _0xA453, _0xC20E
end
end
pcall(function() _0xC20E:Destroy() end)for _0x9094, fb in ipairs(fallbacks or {}) do
local _0xD10F = _0x1A56(fb)
if _0xD10F ~=""then
local _0xB2A9 = Instance.new(string.char(65,110,105,109,97,116,105,111,110))
_0xB2A9.AnimationId =string.char(114,98,120,97,115,115,101,116,105,100,58,47,47).. _0xD10F
local _0x6FD2, _0x89EC = pcall(function() return _0xFC4D:LoadAnimation(_0xB2A9) end)
if _0x6FD2 and _0x89EC then
pcall(function() _0x89EC.Priority = priority or Enum.AnimationPriority.Action4 end)
pcall(function() _0x89EC.Looped = true end)
_0xC7E9(_0xA778)
local _0x0084 = math.clamp(_0x68F1.Speed or 1.0, 0.2, 6.0)
if pcall(function() _0x89EC:Play(0, 1, _0x0084) end) then
pcall(function() _0x89EC:AdjustSpeed(_0x0084) end)
table.insert(_0xBBEA, _0x89EC)
return _0x89EC, _0xB2A9
end
end
pcall(function() _0xB2A9:Destroy() end)
end
end
return nil, nil
end
local _0x22AB = false
local function _0x36A6(_0x4E33)
local _0xA778 = _0x4E33 and _0x4E33:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0xA778 then return end
local _0x2FBB = _0xA778:FindFirstChildOfClass(string.char(65,110,105,109,97,116,111,114))
if _0x2FBB then
local _0xF999, _0x6F65 = pcall(function() return _0x2FBB:GetPlayingAnimationTracks() end)
if _0xF999 and _0x6F65 then
for _0x9094, _0x6299 in ipairs(_0x6F65) do
pcall(function() _0x6299:Stop(0) end); pcall(function() _0x6299:Destroy() end)
end
end
end
end
local function _0x1B7E(_0x4E33)
if not _0x4E33 then return end
local _0x20CB = _0x4E33:FindFirstChild(string.char(65,110,105,109,97,116,101))
if _0x20CB and not _0x20CB.Disabled then
_0x20CB.Disabled = true
_0x22AB = true
end
_0x36A6(_0x4E33)
end
local function _0x0334(_0x4E33)
if _0x4E33 then
local _0x20CB = _0x4E33:FindFirstChild(string.char(65,110,105,109,97,116,101))
if _0x20CB and _0x20CB.Disabled then
_0x20CB.Disabled = false
end
end
_0x22AB = false
end
_0xC3EF = function(_0x5BFE, safeCF)
_0x5BFE = _0x5BFE or (_0xA6AA and _0xA6AA.Character)
if not _0x5BFE then return end
local _0xE5AE = _0x4DA4(_0x5BFE)
local _0xA778 = _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xE5AE then
if _0x2668 then
pcall(function() _0x2668(_0xE5AE,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), nil) end)
pcall(function() _0x2668(_0xE5AE,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), nil) end)
end
_0xE5AE.Anchored = false
_0xE5AE.AssemblyLinearVelocity = Vector3.zero
_0xE5AE.AssemblyAngularVelocity = Vector3.zero
local _0x6424 = nil
if _0x97B4(safeCF) then
_0x6424 = safeCF
elseif _0x97B4(_0xE5AE.CFrame) then
_0x6424 = _0xE5AE.CFrame
else
_0x6424 = _0x6660()
end
if _0x6424 then
local _0x41D2 = _0x6424.Position
local _0x9094, _0x45E4, _0x9094 = _0x6424:ToEulerAnglesYXZ()
_0xE5AE.CFrame = CFrame.new(_0x41D2) * CFrame.Angles(0, _0x45E4, 0)
end
end
for _0x9094, _0x5959 in ipairs(_0x04D0(_0x5BFE)) do
if _0x5959.Parent then
_0x5959.Anchored = false
_0x5959.Massless = false
pcall(function() _0x5959.CustomPhysicalProperties = nil end)
if not (_0x02BF and _0x02BF.noclip) and (_0x5959.Name ==string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116)or _0x5959.Name ==string.char(84,111,114,115,111)or _0x5959.Name ==string.char(85,112,112,101,114,84,111,114,115,111)or _0x5959.Name ==string.char(76,111,119,101,114,84,111,114,115,111)or _0x5959.Name ==string.char(72,101,97,100)) then
_0x5959.CanCollide = true
end
if not (_0x5DAB and _0x5DAB.Kill and _0x5DAB.Kill.enabled) then
_0x5959.CanTouch = true
_0x5959.CanQuery = true
end
end
end_0x36A6(_0x5BFE)
_0x0334(_0x5BFE)
if _0xA778 and _0xA778.Health > 0 then
pcall(function()
if not _0xA778.EvaluateStateMachine then _0xA778.EvaluateStateMachine = true end
_0xA778:SetStateEnabled(Enum.HumanoidStateType.Running, true)
_0xA778:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
_0xA778:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
_0xA778:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
_0xA778:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
_0xA778:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
_0xA778.PlatformStand = false
_0xA778.Sit = false
_0xA778.AutoRotate = true
if _0xA778.WalkSpeed < 8 then
_0xA778.WalkSpeed = (_0x02BF and _0x02BF.speed and _0x02BF.desiredWalkSpeed) or 16
end
_0xA778:ChangeState(Enum.HumanoidStateType.GettingUp)
_0xA778:ChangeState(Enum.HumanoidStateType.Running)
end)
end
local _0x6EE9 = workspace.CurrentCamera
if _0x6EE9 and _0xA778 and not _0x5BCC then
pcall(function()
_0x6EE9.CameraType = Enum.CameraType.Custom
_0x6EE9.CameraSubject = _0xA778
end)
end
end_0xDF2E = function(_0x5BFE, preferredCF)
_0x5BFE = _0x5BFE or (_0xA6AA and _0xA6AA.Character)
if not _0x5BFE then return end
if (_0xB42E ~= nil and not _0xB42E.destroyed) or _0xF3B0 then return end
local _0xE5AE = _0x4DA4(_0x5BFE)
local _0xA778 = _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
local _0xDD0F = false
if _0xE5AE then
local _0x1CEE = _0xE5AE.Position
local _0x324B = _0xE5AE.AssemblyLinearVelocity
if _0x1CEE.Y <= math.max(_0x8668 + 45, -160) or _0x1CEE.Magnitude > 18000 or _0x324B.Magnitude > 160 then
_0xDD0F = true
end
end
local _0xA2EE = _0x97B4(preferredCF) and preferredCF
or (_0xE5AE and _0x97B4(_0xE5AE.CFrame) and _0xE5AE.CFrame)
or _0x6660()
local _0x41D2 = _0xA2EE.Position
local _0x9094, _0x45E4, _0x9094 = _0xA2EE:ToEulerAnglesYXZ()
local _0x7D9B = CFrame.new(_0x41D2 + Vector3.new(0, 1.2, 0)) * CFrame.Angles(0, _0x45E4, 0)
_0x363C(_0x7D9B)
_0xC3EF(_0x5BFE, _0x7D9B)
if not _0xE5AE or not _0xE5AE.Parent then return end
_0x3E10 = _0x3E10 + 1
local _0x9852 = _0x3E10if not _0xDD0F then
_0xB106 = false
return
end
task.spawn(function()
_0xB106 = true
pcall(function()
_0xE5AE.Anchored = true
for _0x9094 = 1, 2 do
if not _0xE5AE.Parent or _0x9852 ~= _0x3E10 or (_0xB42E ~= nil and not _0xB42E.destroyed) or _0xF3B0 then
break
end
_0xE5AE.AssemblyLinearVelocity = Vector3.zero
_0xE5AE.AssemblyAngularVelocity = Vector3.zero
_0xE5AE.CFrame = _0x7D9B
_0xC77A.Heartbeat:Wait()
end
if _0xE5AE.Parent then
_0xE5AE.Anchored = false
if _0x9852 == _0x3E10 and (_0xB42E == nil or _0xB42E.destroyed) and not _0xF3B0 then
_0xE5AE.AssemblyLinearVelocity = Vector3.zero
_0xE5AE.AssemblyAngularVelocity = Vector3.zero
_0xE5AE.CFrame = _0x7D9B
end
end
if _0x9852 == _0x3E10 and (_0xB42E == nil or _0xB42E.destroyed) and not _0xF3B0 then
if _0xA778 and _0xA778.Parent and _0xA778.Health > 0 then
_0xA778.PlatformStand = false
_0xA778.Sit = false
_0xA778.AutoRotate = true
_0xA778:ChangeState(Enum.HumanoidStateType.GettingUp)
_0xA778:ChangeState(Enum.HumanoidStateType.Running)
end
end
end)
if _0x9852 == _0x3E10 then
_0xB106 = false
end
if not (_0x5DAB and (_0x5DAB.AlwaysOnCore or (_0x5DAB.Void and _0x5DAB.Void.enabled) or (_0x5DAB.InfFallVoid and _0x5DAB.InfFallVoid.enabled) or (_0x5DAB.Kill and _0x5DAB.Kill.enabled))) and not _0x243A.active and not _0xF3B0 then
pcall(function() workspace.FallenPartsDestroyHeight = _0x8668 end)
end
end)
end_0xC77A.Heartbeat:Connect(function()
local _0x5BFE = _0xA6AA.Character
local _0xE5AE = _0x4DA4(_0x5BFE)
local _0xA778 = _0x5BFE and _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0xE5AE or not _0xA778 or _0xA778.Health <= 0 then return end
if not _0x1B4F() and not (_0xAE44 and _0xAE44.rewinding) then
local _0x6355 = _0xE5AE.AssemblyLinearVelocity.Magnitude
if _0x97B4(_0xE5AE.CFrame) and _0x6355 < 110 and _0xA778.FloorMaterial ~= Enum.Material.Air then
local _0x9094, _0x45E4, _0x9094 = _0xE5AE.CFrame:ToEulerAnglesYXZ()
_0x7067 = CFrame.new(_0xE5AE.Position) * CFrame.Angles(0, _0x45E4, 0)
elseif _0xE5AE.Position.Y <= math.max(_0x8668 + 22, -260) or _0xE5AE.Position.Magnitude > 22000 then
if (_0x5DAB and _0x5DAB.Void and _0x5DAB.Void.enabled) or (tick() - _0x1FB2 < 6.0) then
_0xDF2E(_0x5BFE, _0x7067)
end
end
end
end)
local _0x7EF3local _0x4E36
local _0x76B4
local _0xF668
local _0x5D16
local _0xA4A2
local _0x4681, _0x8324, _0x638F, _0xB894, _0xE84F, _0xE947
dolocal function _0xFE31(TargetPart, Offset, Speaker, AnimationId, Osc, AnimFallbacks, TargetPlayer, RefMode)
local _0x4363 = Speaker.Character
if not _0x4363 then return nil end
local _0x5D4E = _0x4DA4(_0x4363)
local _0x118B = _0x4363:FindFirstChildWhichIsA(string.char(72,117,109,97,110,111,105,100))
if not _0x5D4E or not _0x118B or _0x118B.Health <= 0 then return nil end_0x3E10 = _0x3E10 + 1
_0x5D4E.Anchored = false
_0xF424(_0x4363)
local _0x3C6D = (TargetPart and TargetPart.Parent) or (TargetPlayer and _0x4E36(TargetPlayer))
local _0x6962 = _0x3C6D and _0x3C6D:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))local _0x9623 = nil
if TargetPart and TargetPart.Parent and not _0xD510(TargetPart.CFrame, TargetPart.AssemblyLinearVelocity) then
local _0x9094, _0x45E4, _0x9094 = TargetPart.CFrame:ToEulerAnglesYXZ()
_0x9623 = CFrame.new(TargetPart.Position + Vector3.new(0, 2.5, 0)) * CFrame.Angles(0, _0x45E4, 0)
_0x7067 = _0x9623
else
_0x9623 = (_0x97B4(_0x5D4E.CFrame) and _0x5D4E.CFrame)
or (_0x97B4(_0x7067) and _0x7067)
or _0x6660()
end
pcall(function() _0x118B.Sit = false end)
pcall(function() _0x118B.PlatformStand = true end)
pcall(function() _0x118B.AutoRotate = false end)
_0xC7E9(_0x118B)
_0x1B7E(_0x4363)
local function _0xE560()
if not _0x4363 or not _0x4363.Parent then return end
for _0x9094, _0x324B in ipairs(_0x04D0(_0x4363)) do
if _0x324B.Parent then
if _0x324B.CanCollide then _0x324B.CanCollide = false end
if _0x324B.CanTouch then _0x324B.CanTouch = false end
if _0x324B.CanQuery then _0x324B.CanQuery = false end
if not _0x324B.Massless then _0x324B.Massless = true end
if _0x324B.Anchored then _0x324B.Anchored = false end
end
end
if _0x118B and _0x118B.Sit then
pcall(function() _0x118B.Sit = false end)
end
end
_0xE560()local _0x4944 = 0
local function _0x571C()
local _0x0BC9 = CFrame.new(_0x68F1.X or 0, _0x68F1.Y or 0, (_0x68F1.Z or 1.3) - 1.3)
local _0xAFF9 = Offset * _0x0BC9
if Osc and Osc.period and Osc.period > 0 then
local _0xBA8A = (math.sin(_0x4944 * (2 * math.pi) / Osc.period) + 1) * 0.5
_0xAFF9 = _0xAFF9 * CFrame.new(0, 0, -Osc.distance * _0xBA8A)
end
return TargetPart.CFrame * _0xAFF9
end
local function _0x7E12(_0x5959)
if not _0x2668 or not _0x5D4E or not _0x5D4E.Parent then return end
pcall(function()
_0x2668(_0x5D4E,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), _0x5959)
if _0x3E41 then
_0x2668(_0x5D4E,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), _0x5959 and _0x3E41(_0x5959) or nil)
end
end)
end
local _0xF49F = nil
if TargetPart and TargetPart.Parent then
_0xF49F = _0x571C()
_0x363C(_0xF49F)
_0x5D4E.CFrame = _0xF49F
_0x5D4E.AssemblyLinearVelocity = Vector3.zero
_0x5D4E.AssemblyAngularVelocity = Vector3.zero
_0x7E12(TargetPart)
endlocal _0x4F44, _0x61AF = nil, nil
local _0x5F9F = 0
local _0xB649 = { destroyed = false }
local function _0x6F3A(force)
if not AnimationId or _0xB649.destroyed then return end
if _0x4F44 and not force then
local _0x051D = false
pcall(function()
_0x051D = _0x4F44.IsPlaying
if _0x051D and _0x4F44.Length > 0 and _0x4F44.TimePosition >= (_0x4F44.Length - 0.04) then
_0x4F44.TimePosition = 0
end
end)
if _0x051D then
pcall(function() _0x4F44:AdjustSpeed(math.clamp(_0x68F1.Speed or 1.0, 0.2, 6.0)) end)
return
end
end
_0x5F9F = _0x5F9F + 1
if not force and _0x5F9F % 10 ~= 0 and _0x4F44 then return end
local _0xFC4D = _0x4363:FindFirstChildWhichIsA(string.char(65,110,105,109,97,116,111,114), true)
if not _0xFC4D and _0x118B then
_0xFC4D = Instance.new(string.char(65,110,105,109,97,116,111,114))
_0xFC4D.Parent = _0x118B
end
if not _0xFC4D then return end
local _0xA453, _0xC20E = _0x8052(_0xFC4D, AnimationId, AnimFallbacks, _0x118B)
if _0xA453 then
if _0x4F44 and _0x4F44 ~= _0xA453 then
pcall(function() _0x4F44:Stop(0); _0x4F44:Destroy() end)
end
if _0x61AF and _0x61AF ~= _0xC20E then
pcall(function() _0x61AF:Destroy() end)
end
_0x4F44 = _0xA453
_0x61AF = _0xC20E
end
end
_0x6F3A(true)
local _0xC8E0 = nil
local _0xFFC0 = nil
local _0x9DAA = nil
local _0x5E5A = 0
function _0xB649:Destroy(skipReturn)
if self.destroyed then return end
self.destroyed = true
if _0xC8E0 then _0xC8E0:Disconnect(); _0xC8E0 = nil end
if _0xFFC0 then _0xFFC0:Disconnect(); _0xFFC0 = nil end
if _0x9DAA then _0x9DAA:Disconnect(); _0x9DAA = nil end
pcall(function() _0xA6AA.ReplicationFocus = nil end)
if _0x5D4E and _0x2668 then
pcall(function() _0x2668(_0x5D4E,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), nil) end)
pcall(function() _0x2668(_0x5D4E,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), nil) end)
end
if _0x4F44 then
pcall(function() _0x4F44:Stop(0) end)
pcall(function() _0x4F44:Destroy() end)
_0x4F44 = nil
end
if _0x61AF then
pcall(function() _0x61AF:Destroy() end)
_0x61AF = nil
end
if _0xB42E == self then
_0xB42E = nil
end
if not skipReturn then
_0x1FB2 = tick()
_0xDF2E(_0x4363, _0x9623)
if _0xA6AA.Character and _0xA6AA.Character ~= _0x4363 then
_0xDF2E(_0xA6AA.Character, _0x9623)
end
end
end_0x9DAA = _0xC77A.Stepped:Connect(function()
if _0xB649.destroyed then return end
_0xE560()
if TargetPart and TargetPart.Parent and _0x5D4E and _0x5D4E.Parent and not _0xD510(TargetPart.CFrame, TargetPart.AssemblyLinearVelocity) then
_0xF49F = _0x571C()
_0x363C(_0xF49F)
_0x5D4E.CFrame = _0xF49F
_0x5D4E.AssemblyLinearVelocity = Vector3.zero
_0x5D4E.AssemblyAngularVelocity = Vector3.zero
_0x7E12(TargetPart)
end
end)_0xFFC0 = _0xC77A.RenderStepped:Connect(function()
if _0xB649.destroyed then return end
if TargetPart and TargetPart.Parent and _0x5D4E and _0x5D4E.Parent and not _0xD510(TargetPart.CFrame, TargetPart.AssemblyLinearVelocity) then
_0xF49F = _0x571C()
_0x363C(_0xF49F)
_0x5D4E.CFrame = _0xF49F
_0x7E12(TargetPart)
end
end)
_0xC8E0 = _0xC77A.Heartbeat:Connect(function(_0x004C)if not _0x4363.Parent or _0x4363 ~= _0xA6AA.Character or not _0x5D4E.Parent or not _0x118B.Parent or _0x118B.Health <= 0 then
_0xB649:Destroy(true)
return
endif TargetPlayer and TargetPlayer.Parent ~= _0xC3F7 then
_0xB649:Destroy(false)
if _0x7EF3 then pcall(_0x7EF3) end
if _0x207A then pcall(_0x207A) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(84,97,114,103,101,116,32,108,101,102,116,32,115,101,114,118,101,114,32,226,128,148,32,115,97,102,101,108,121,32,114,101,116,117,114,110,101,100))
return
endif _0x6962 and _0x6962.Parent and _0x6962.Health <= 0 then
_0xB649:Destroy(false)
return
endif not TargetPart or not TargetPart.Parent or (TargetPlayer and _0x4E36(TargetPlayer) ~= _0x3C6D) then
if TargetPlayer then
local _0xC855 = _0x4E36(TargetPlayer)
local _0x12B5 = _0xC855 and _0xC855:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0x12B5 and _0x12B5.Health <= 0 then
_0xB649:Destroy(false)
return
end
local _0x2E0F = _0xC855 and _0x76B4(_0xC855, RefMode orstring.char(116,111,114,115,111))
if _0x2E0F and _0x2E0F.Parent then
_0x3C6D = _0xC855
_0x6962 = _0x12B5
TargetPart = _0x2E0F
_0x5E5A = 0
else
_0x5E5A = _0x5E5A + 1
local _0x3526 = _0xF668(TargetPlayer)
if _0x3526 and not _0xD510(_0x3526) then
pcall(function() _0xA6AA:RequestStreamAroundAsync(_0x3526.Position, 1) end)
_0x5D4E.CFrame = _0x3526 * Offset
_0x5D4E.AssemblyLinearVelocity = Vector3.zero
_0x5D4E.AssemblyAngularVelocity = Vector3.zero
_0x363C(_0x5D4E.CFrame)
end
if _0x5E5A > 100 then
_0xB649:Destroy(false)
end
return
end
else
_0xB649:Destroy(false)
return
end
else
_0x5E5A = 0
endlocal _0x3F0E = TargetPart.AssemblyLinearVelocity
if _0xD510(TargetPart.CFrame, _0x3F0E) then
_0xB649:Destroy(false)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(84,97,114,103,101,116,32,102,101,108,108,32,105,110,116,111,32,108,101,116,104,97,108,32,86,111,105,100,32,226,128,148,32,100,101,116,97,99,104,101,100,32,115,97,102,101,108,121,33))
return
endpcall(function() _0xA6AA.ReplicationFocus = TargetPart end)if TargetPlayer then
_0xA9FC[TargetPlayer.UserId] = { _0x5685 = TargetPart.CFrame, time = tick(), fromPart = true }
end
if not _0xD510(TargetPart.CFrame, _0x3F0E) then
local _0x9094, _0x45E4, _0x9094 = TargetPart.CFrame:ToEulerAnglesYXZ()
_0x9623 = CFrame.new(TargetPart.Position + Vector3.new(0, 2.5, 0)) * CFrame.Angles(0, _0x45E4, 0)
_0x7067 = _0x9623
end
local _0x20CB = _0x4363:FindFirstChild(string.char(65,110,105,109,97,116,101))
if _0x20CB and not _0x20CB.Disabled then
_0x20CB.Disabled = true
_0x22AB = true
end
local _0xF03B = math.clamp(_0x68F1.Speed or 1.0, 0.2, 6.0)
_0x4944 = _0x4944 + (_0x004C * _0xF03B)
_0xF49F = _0x571C()
_0x5D4E.CFrame = _0xF49F
_0x5D4E.AssemblyLinearVelocity = Vector3.zero
_0x5D4E.AssemblyAngularVelocity = Vector3.zero
_0x363C(_0x5D4E.CFrame)
_0x7E12(TargetPart)
pcall(function() _0x6F3A(false) end)
pcall(function()
if not _0x118B.PlatformStand then _0x118B.PlatformStand = true end
if _0x118B.Sit then _0x118B.Sit = false end
end)
end)
return _0xB649
end
local function _0x44C6(skipReturn)
if _0xB42E then
pcall(function() _0xB42E:Destroy(skipReturn) end)
_0xB42E = nil
elseif not skipReturn and _0xA6AA.Character then
pcall(function() _0xDF2E(_0xA6AA.Character, _0x7067) end)
end
if not (_0x5DAB and _0x5DAB.Void and _0x5DAB.Void.enabled) and not (_0x5DAB and _0x5DAB.InfFallVoid and _0x5DAB.InfFallVoid.enabled) and not (_0x5DAB and _0x5DAB.Kill and _0x5DAB.Kill.enabled) then
pcall(function() workspace.FallenPartsDestroyHeight = _0x8668 end)
end
end
local _0xB18B = 116235062592344_0xA4A2 = {
facebang = { _0x4CD8 = CFrame.new(0, 1.2, -3.0) * CFrame.Angles(0, math.rad(180), 0),
anim15 = _0xB18B, anim6 = _0xB18B,
animFallbacks = {128342454196913, 5918726674, 148840371, 4555808220, 109168916859109},
osc = {distance = 2.5, period = 0.20}, _0xB516 =string.char(104,101,97,100), label =string.char(70,97,99,101,32,66,97,110,103)},
backshots = { _0x4CD8 = CFrame.new(0, 0, 2.5),
anim15 = _0xB18B, anim6 = _0xB18B,
animFallbacks = {128342454196913, 5918726674, 148840371, 4555808220, 109168916859109},
osc = {distance = 2.0, period = 0.20}, _0xB516 =string.char(116,111,114,115,111), label =string.char(66,97,99,107,115,104,111,116,115)},
headsit = { _0x4CD8 = CFrame.new(0, 1.5, 0),
anim15 = 2506281703, anim6 = 2506281703,
animFallbacks = {2510238627, 507768375, 180426354},
osc = nil, _0xB516 =string.char(104,101,97,100), label =string.char(72,101,97,100,115,105,116)},
kiss = { _0x4CD8 = CFrame.new(0, 0, -1.2) * CFrame.Angles(0, math.rad(180), 0),
anim15 = 81124524945738, anim6 = 81124524945738,
animFallbacks = {3576686446, 3019619673, 15849372443},
osc = nil, _0xB516 =string.char(116,111,114,115,111), label =string.char(75,105,115,115)},
backpack = { _0x4CD8 = CFrame.new(0, 0.5, 1.1) * CFrame.Angles(0, math.rad(180), 0),
anim15 = 2506281703, anim6 = 2506281703,
animFallbacks = {2510238627, 507768375, 180426354},
osc = nil, _0xB516 =string.char(116,111,114,115,111), label =string.char(66,97,99,107,112,97,99,107)},
headpat = { _0x4CD8 = CFrame.new(0, 0, -2.5) * CFrame.Angles(0, math.rad(180), 0),
anim15 = 114313599861536, anim6 = 114313599861536,
animFallbacks = {}, osc = nil, _0xB516 =string.char(116,111,114,115,111), label =string.char(72,101,97,100,112,97,116)},
propose = { _0x4CD8 = CFrame.new(0, -1.0, -2.5) * CFrame.Angles(0, math.rad(180), 0),
anim15 = 70639053125611, anim6 = 70639053125611,
animFallbacks = {}, osc = nil, _0xB516 =string.char(116,111,114,115,111), label =string.char(80,114,111,112,111,115,101)},
hug = { _0x4CD8 = CFrame.new(0, 0, -1.2) * CFrame.Angles(0, math.rad(180), 0),
anim15 = 95247520541805, anim6 = 95247520541805,
animFallbacks = {}, osc = nil, _0xB516 =string.char(116,111,114,115,111), label =string.char(72,117,103)},
}
_0xA4A2.bang = _0xA4A2.backshots
_0xA4A2.chase = {
_0x4CD8 = CFrame.new(0, 0, 1.5),
anim15 = nil,
anim6 = nil,
animFallbacks = {},
osc = nil,
_0xB516 =string.char(116,111,114,115,111),
label =string.char(65,117,116,111,45,67,104,97,115,101,32,40,70,111,108,108,111,119,41)}local _0xA13B = {}
local _0x0C55 = {string.char(67,104,97,114,97,99,116,101,114,115),string.char(80,108,97,121,101,114,115),string.char(69,110,116,105,116,105,101,115),string.char(76,105,118,101),string.char(85,110,105,116,115),string.char(73,110,103,97,109,101),string.char(67,104,97,114,115)}
_0x4E36 = function(plr)
if not plr then return nil end
if plr.Character and plr.Character.Parent then
_0xA13B[plr.UserId] = { model = plr.Character, lastScan = tick() }
return plr.Character
end
local _0xA824 = _0xA13B[plr.UserId]
if _0xA824 and _0xA824.model and _0xA824.model.Parent then
return _0xA824.model
end
local _0x2FEB = workspace:FindFirstChild(plr.Name)
if _0x2FEB and _0x2FEB:IsA(string.char(77,111,100,101,108)) and (_0x2FEB:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100)) or _0x2FEB:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116)) or _0x2FEB.PrimaryPart) then
_0xA13B[plr.UserId] = { model = _0x2FEB, lastScan = tick() }
return _0x2FEB
end
for _0x9094, folderName in ipairs(_0x0C55) do
local _0x8D48 = workspace:FindFirstChild(folderName)
local _0x42E3 = _0x8D48 and _0x8D48:FindFirstChild(plr.Name)
if _0x42E3 and _0x42E3:IsA(string.char(77,111,100,101,108)) and (_0x42E3:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100)) or _0x42E3:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116)) or _0x42E3.PrimaryPart or _0x42E3:FindFirstChildWhichIsA(string.char(66,97,115,101,80,97,114,116), true)) then
_0xA13B[plr.UserId] = { model = _0x42E3, lastScan = tick() }
return _0x42E3
end
end
local _0x60A3 = tick()
if not _0xA824 or (_0x60A3 - (_0xA824.lastScan or 0)) > 1.5 then
_0xA13B[plr.UserId] = { model = nil, lastScan = _0x60A3 }
local _0xDB38 = workspace:FindFirstChild(plr.Name, true)
if _0xDB38 and _0xDB38:IsA(string.char(77,111,100,101,108)) and _0xDB38:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100)) then
_0xA13B[plr.UserId] = { model = _0xDB38, lastScan = _0x60A3 }
return _0xDB38
end
end
return plr.Character
end_0x76B4 = function(_0x5BFE, _0xA3C6)
if not _0x5BFE then return nil end
if _0xA3C6 ==string.char(104,101,97,100)then
local _0xA077 = _0x5BFE:FindFirstChild(string.char(72,101,97,100)) or _0x5BFE:FindFirstChild(string.char(104,101,97,100), true)
if _0xA077 and _0xA077:IsA(string.char(66,97,115,101,80,97,114,116)) then return _0xA077 end
for _0x9094, _0x69FF in ipairs(_0x04D0(_0x5BFE)) do
if _0x69FF.Name:lower():find(string.char(104,101,97,100), 1, true) then
return _0x69FF
end
end
end
local _0xA778 = _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
local _0xDD60 = _0x5BFE:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116))
or (_0xA778 and _0xA778.RootPart)
or _0x5BFE.PrimaryPart
or _0x5BFE:FindFirstChild(string.char(85,112,112,101,114,84,111,114,115,111))
or _0x5BFE:FindFirstChild(string.char(76,111,119,101,114,84,111,114,115,111))
or _0x5BFE:FindFirstChild(string.char(84,111,114,115,111))
or _0x5BFE:FindFirstChild(string.char(72,101,97,100))
if _0xDD60 and _0xDD60:IsA(string.char(66,97,115,101,80,97,114,116)) then return _0xDD60 end
if _0xA778 and _0xA778.SeatPart and _0xA778.SeatPart:IsA(string.char(66,97,115,101,80,97,114,116)) then
return _0xA778.SeatPart
end
return _0x5BFE:FindFirstChildWhichIsA(string.char(66,97,115,101,80,97,114,116), true)
end_0xF668 = function(plr)
if not plr then return nil end
local _0x5BFE = _0x4E36(plr)
if _0x5BFE then
local _0xA778 = _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0xA778 or _0xA778.Health > 0 then
local _0x5959 = _0x76B4(_0x5BFE,string.char(116,111,114,115,111))
if _0x5959 and _0x5959.Parent then
local _0x5685 = _0x5959.CFrame
if not _0xD510(_0x5685, _0x5959.AssemblyLinearVelocity) then
_0xA9FC[plr.UserId] = { _0x5685 = _0x5685, time = tick(), fromPart = true }
return _0x5685
end
end
local _0xA824 = _0xA9FC[plr.UserId]
local _0x190F, _0x15D9 = pcall(function() return _0x5BFE:GetPivot() end)
if _0x190F and _0x15D9 and _0x15D9.Position.Magnitude > 5 and not _0xD510(_0x15D9) then
if not _0xA824 or not _0xA824.fromPart or (tick() - (_0xA824.time or 0)) > 2.0 then
_0xA9FC[plr.UserId] = { _0x5685 = _0x15D9, time = tick(), fromPart = false }
return _0x15D9
end
end
local _0x792E, _0xC76B = pcall(function() return _0x5BFE.WorldPivot end)
if _0x792E and _0xC76B and _0xC76B.Position.Magnitude > 5 and not _0xD510(_0xC76B) then
if not _0xA824 or not _0xA824.fromPart or (tick() - (_0xA824.time or 0)) > 2.0 then
_0xA9FC[plr.UserId] = { _0x5685 = _0xC76B, time = tick(), fromPart = false }
return _0xC76B
end
end
end
end
local _0xA824 = _0xA9FC[plr.UserId]
if _0xA824 and _0xA824.cf and not _0xD510(_0xA824.cf) then
return _0xA824.cf
end
return nil
enddo
local _0xDDDF = 0
_0xC77A.Heartbeat:Connect(function()
local _0x60A3 = tick()
if _0x60A3 - _0xDDDF < 0.15 then return end
_0xDDDF = _0x60A3
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= _0xA6AA then
pcall(function() _0xF668(_0x1CEE) end)
end
end
end)
end_0x5D16 = function(_0x49D0, _0xB516, maxWaitSeconds, allowSweep)
if not _0x49D0 or _0x49D0.Parent ~= _0xC3F7 then return nil, nil end
maxWaitSeconds = maxWaitSeconds or 2.2local _0x2EC9 = _0x4E36(_0x49D0)
local _0x6143 = _0x2EC9 and _0x2EC9:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0x6143 and _0x6143.Health <= 0 then
return _0x2EC9, nil
end
local _0x5378 = _0x2EC9 and _0x76B4(_0x2EC9, _0xB516 orstring.char(116,111,114,115,111))
if _0x5378 and _0x5378.Parent then
if _0xA6AA.Character then _0xF424(_0xA6AA.Character) end
return _0x2EC9, _0x5378
end
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
local _0x9C01 = (_0x32EC and _0x97B4(_0x32EC.CFrame) and _0x32EC.CFrame) or _0x7067
if _0x1213 then
_0xF424(_0x1213)
for _0x9094, _0x324B in ipairs(_0x04D0(_0x1213)) do
if _0x324B.Parent then
_0x324B.CanCollide = false
_0x324B.CanTouch = false
_0x324B.Anchored = false
end
end
endlocal _0x1093 = tick()
while tick() - _0x1093 < (maxWaitSeconds * 0.70) do
if _0x49D0.Parent ~= _0xC3F7 then return nil, nil end
_0x2EC9 = _0x4E36(_0x49D0)
_0x6143 = _0x2EC9 and _0x2EC9:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0x6143 and _0x6143.Health <= 0 then return _0x2EC9, nil end
_0x5378 = _0x2EC9 and _0x76B4(_0x2EC9, _0xB516 orstring.char(116,111,114,115,111))
if _0x5378 and _0x5378.Parent then
return _0x2EC9, _0x5378
end
local _0x6424 = _0xF668(_0x49D0)
if _0x6424 then
task.spawn(function()
pcall(function() _0xA6AA:RequestStreamAroundAsync(_0x6424.Position, 1.5) end)
end)
_0x1213 = _0xA6AA.Character
_0x32EC = _0x4DA4(_0x1213)
if _0x32EC then
local _0xED15 = _0x6424 * CFrame.new(0, 2, 0)
_0x363C(_0xED15)
_0x32EC.AssemblyLinearVelocity = Vector3.zero
_0x32EC.AssemblyAngularVelocity = Vector3.zero
_0x32EC.CFrame = _0xED15
end
else
break
end
_0xC77A.Heartbeat:Wait()
end
_0x2EC9 = _0x4E36(_0x49D0)
_0x5378 = _0x2EC9 and _0x76B4(_0x2EC9, _0xB516 orstring.char(116,111,114,115,111))
if _0x5378 and _0x5378.Parent then return _0x2EC9, _0x5378 end
if not allowSweep then
if (not _0x5378 or not _0x5378.Parent) and _0xA6AA.Character then
_0xC3EF(_0xA6AA.Character, _0x9C01)
end
return _0x2EC9, _0x5378
endlocal _0x2933 = {}
for _0x9094, child in ipairs(workspace:GetChildren()) do
if child:IsA(string.char(83,112,97,119,110,76,111,99,97,116,105,111,110)) or child:IsA(string.char(83,101,97,116)) or child:IsA(string.char(86,101,104,105,99,108,101,83,101,97,116)) then
if not _0xD510(child.CFrame) then
table.insert(_0x2933, child.CFrame)
end
elseif child:IsA(string.char(77,111,100,101,108)) and child ~= _0xA6AA.Character then
local _0xCB85, _0x09D6 = pcall(function() return child:GetPivot() end)
if _0xCB85 and _0x09D6 and _0x09D6.Position.Magnitude > 10 and not _0xD510(_0x09D6) then
table.insert(_0x2933, _0x09D6)
end
end
end
for _0xF25B, probeCF in ipairs(_0x2933) do
if tick() - _0x1093 > maxWaitSeconds or _0xF25B > 20 then break end
_0x2EC9 = _0x4E36(_0x49D0)
_0x6143 = _0x2EC9 and _0x2EC9:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0x6143 and _0x6143.Health <= 0 then break end
_0x5378 = _0x2EC9 and _0x76B4(_0x2EC9, _0xB516 orstring.char(116,111,114,115,111))
if _0x5378 and _0x5378.Parent then return _0x2EC9, _0x5378 end
local _0x60A5 = _0xF668(_0x49D0)
local _0xED15 = _0x60A5 or probeCF
task.spawn(function()
pcall(function() _0xA6AA:RequestStreamAroundAsync(_0xED15.Position, 1) end)
end)
if _0x60A5 then
_0x1213 = _0xA6AA.Character
_0x32EC = _0x4DA4(_0x1213)
if _0x32EC then
local _0xE347 = _0x60A5 + Vector3.new(0, 3, 0)
_0x363C(_0xE347)
_0x32EC.CFrame = _0xE347
_0x32EC.AssemblyLinearVelocity = Vector3.zero
end
end
_0xC77A.Heartbeat:Wait()
end
_0x2EC9 = _0x4E36(_0x49D0)
_0x5378 = _0x2EC9 and _0x76B4(_0x2EC9, _0xB516 orstring.char(116,111,114,115,111))
if not _0x5378 or not _0x5378.Parent then
_0x1213 = _0xA6AA.Character
if _0x1213 then
_0xC3EF(_0x1213, _0x9C01)
end
end
return _0x2EC9, _0x5378
end
_0x4681 = function(speaker)
speaker = speaker or _0xA6AA
local _0x1213 = speaker and speaker.Character
local _0x32EC = _0x4DA4(_0x1213)
local _0xFC96 = _0x32EC and _0x32EC.Position or Vector3.zero
local _0xE2FF, _0xC27B = nil, math.hugefor _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= speaker then
local _0x4E33 = _0x4E36(_0x1CEE)
local _0xA077 = _0x4E33 and _0x4E33:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
local _0x5685 = _0xF668(_0x1CEE)
if _0x5685 and (not _0xA077 or _0xA077.Health > 0) then
local _0x000B = (_0x5685.Position - _0xFC96).Magnitude
if _0x000B < _0xC27B then
_0xC27B = _0x000B
_0xE2FF = _0x1CEE
end
end
end
endif not _0xE2FF then
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= speaker then
return _0x1CEE, math.huge
end
end
end
return _0xE2FF, _0xC27B
end
_0x8324 = function(query, speaker)
speaker = speaker or _0xA6AA
if not query then return nil end
local _0xDDC2 = tostring(query):gsub(string.char(94,37,115,42,64,43,37,115,42),""):gsub(string.char(94,37,115,43),""):gsub(string.char(37,115,43,36),""):lower()
if _0xDDC2 ==""then return nil end
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= speaker and (_0x1CEE.Name:lower() == _0xDDC2 or _0x1CEE.DisplayName:lower() == _0xDDC2) then
return _0x1CEE
end
end
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= speaker and (_0x1CEE.Name:lower():sub(1, #_0xDDC2) == _0xDDC2 or _0x1CEE.DisplayName:lower():sub(1, #_0xDDC2) == _0xDDC2) then
return _0x1CEE
end
end
return nil
end
_0x638F = function(_0x43DF, speaker)
speaker = speaker or _0xA6AA
if typeof(_0x43DF) ==string.char(73,110,115,116,97,110,99,101)and _0x43DF:IsA(string.char(80,108,97,121,101,114)) then
if _0x43DF.Parent == _0xC3F7 and _0x43DF ~= speaker then return _0x43DF end
return _0x4681(speaker)
end
if _0x43DF ~= nil and tostring(_0x43DF) ~=""then
local _0x42E3 = _0x8324(_0x43DF, speaker)
if _0x42E3 and _0x42E3.Parent == _0xC3F7 then return _0x42E3 end
end
if _0x0A85 and _0x0A85.Parent == _0xC3F7 then
return _0x0A85
end
return _0x4681(speaker)
end
_0xB894 = function()
if _0x0A85 and _0x0A85.Parent == _0xC3F7 then
return _0x0A85, false
end
if _0xA36A and _0xA36A.Parent then
local _0xB58A = (_0xA36A.Text or""):gsub(string.char(94,37,115,42,64,43,37,115,42),""):gsub(string.char(94,37,115,43),""):gsub(string.char(37,115,43,36),"")
if _0xB58A ~=""then
local _0xDB38 = _0x8324(_0xB58A, _0xA6AA)
if _0xDB38 and _0xDB38.Parent == _0xC3F7 then
return _0xDB38, false
end
end
end
local _0xDEA7 = _0x4681(_0xA6AA)
return _0xDEA7, true
end
local function _0x4EB3(_0x43DF, speaker, _0x4CD8, animId, osc, _0xB516, animFallbacks, callerGen)
local _0xE160 = _0x638F(_0x43DF, speaker)
if not _0xE160 or _0xE160.Parent ~= _0xC3F7 then return false, nil end
local _0x9586 = callerGen or _0x4964
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
local _0x1213 = speaker and speaker.Character
local _0x32EC = _0x4DA4(_0x1213)local _0x55AA = _0x4E36(_0xE160)
local _0xAF1D = _0x55AA and _0x55AA:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
local _0x1DC4 = _0x55AA and _0x76B4(_0x55AA, _0xB516 orstring.char(116,111,114,115,111))
if _0x1213 and _0x32EC and _0x1DC4 and _0x1DC4.Parent and (not _0xAF1D or _0xAF1D.Health > 0) then
local _0x9AED = _0xB42E
if _0x9AED then
_0xB42E = nil
pcall(function() _0x9AED:Destroy(true) end)
end
if _0x2668 then
pcall(function() _0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), nil) end)
pcall(function() _0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), nil) end)
end
local _0x25EB = _0xFE31(_0x1DC4, _0x4CD8, speaker, animId, osc, animFallbacks, _0xE160, _0xB516 orstring.char(116,111,114,115,111))
_0xB42E = _0x25EB
if _0x207A then pcall(_0x207A) end
return true, _0xE160
endtask.spawn(function()
local _0x599C = tick()
while (not _0x1213 or not _0x32EC) and tick() - _0x599C < 2.5 do
if _0x9586 ~= _0x4964 then return end
_0xC77A.Heartbeat:Wait()
_0x1213 = speaker and speaker.Character
_0x32EC = _0x4DA4(_0x1213)
end
if not _0x1213 or not _0x32EC or _0x9586 ~= _0x4964 then return end
local _0x5BFE, _0x1B62 = _0x5D16(_0xE160, _0xB516 orstring.char(116,111,114,115,111), 2.4, true)
if _0x9586 ~= _0x4964 then return end
if not _0x1B62 or not _0x1B62.Parent thenreturn
end
local _0x6143 = _0x5BFE and _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0x6143 and _0x6143.Health <= 0 then return end
_0x1213 = speaker and speaker.Character
_0x32EC = _0x4DA4(_0x1213)
if _0x32EC then
if _0x2668 then
pcall(function() _0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), nil) end)
pcall(function() _0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), nil) end)
end
_0x32EC.AssemblyLinearVelocity = Vector3.zero
_0x32EC.AssemblyAngularVelocity = Vector3.zero
local _0x6A8A = _0x1B62.CFrame * _0x4CD8
_0x363C(_0x6A8A)
_0x32EC.CFrame = _0x6A8A
end
local _0x9AED = _0xB42E
if _0x9AED then
_0xB42E = nil
pcall(function() _0x9AED:Destroy(true) end)
end
local _0x25EB = _0xFE31(_0x1B62, _0x4CD8, speaker, animId, osc, animFallbacks, _0xE160, _0xB516 orstring.char(116,111,114,115,111))
if _0x9586 ~= _0x4964 then
if _0x25EB then pcall(function() _0x25EB:Destroy(false) end) end
return
end
_0xB42E = _0x25EB
if _0x207A then pcall(_0x207A) end
end)
return true, _0xE160
end
_0xE84F = function(presetKey, _0x43DF, callerGen)
local _0x099A = _0xA4A2[presetKey]; if not _0x099A then return false end
if callerGen and callerGen ~= _0x4964 then return false end
local _0x9586 = _0x4964
local _0xE160 = _0x638F(_0x43DF, _0xA6AA)
if not _0xE160 or _0xE160.Parent ~= _0xC3F7 then return false end
_0x243A.active = true
_0x243A.presetKey = presetKey
_0x243A.target = _0xE160
_0x518F = presetKey
_0x839F = _0xE160.UserId
local _0xC20E = _0xC5B7(_0xA6AA) and _0x099A.anim15 or _0x099A.anim6
local _0xF999 = _0x4EB3(_0xE160, _0xA6AA, _0x099A.offset, _0xC20E, _0x099A.osc, _0x099A.refMode, _0x099A.animFallbacks, _0x9586)
return _0xF999
end
_0x7EF3 = function()
_0x4964 = _0x4964 + 1
_0x243A.active = false
_0x243A.presetKey = nil
_0x243A.target = nil
pcall(function() _0xA6AA.ReplicationFocus = nil end)
_0x44C6(false)
if not (_0x5DAB and _0x5DAB.Void and _0x5DAB.Void.enabled) and not (_0x5DAB and _0x5DAB.InfFallVoid and _0x5DAB.InfFallVoid.enabled) and not (_0x5DAB and _0x5DAB.Kill and _0x5DAB.Kill.enabled) then
pcall(function() workspace.FallenPartsDestroyHeight = _0x8668 end)
end
if _0xA6AA.Character then
pcall(function() _0xC3EF(_0xA6AA.Character, nil) end)
end
end
_0xE947 = function(_0x49D0)
if not _0x49D0 then return end
if _0x49D0:FindFirstChild(string.char(95,95,75,104,97,109,97,110,68,104,111,107,108,97,72,111,111,107)) then return end
local _0xC0D0 = Instance.new(string.char(66,111,111,108,86,97,108,117,101))
_0xC0D0.Name =string.char(95,95,75,104,97,109,97,110,68,104,111,107,108,97,72,111,111,107)_0xC0D0.Parent = _0x49D0
_0x49D0.CharacterAdded:Connect(function(_0xC855)
if not _0x2CD3 or not _0x243A.active then return end
if _0x243A.target ~= _0x49D0 and _0x839F ~= _0x49D0.UserId then return endlocal _0x8923 = tick()
while tick() - _0x8923 < 2.0 and _0xC855.Parent and not _0x76B4(_0xC855,string.char(116,111,114,115,111)) do
_0xC77A.Heartbeat:Wait()
end
if not _0x243A.active or _0x49D0.Parent ~= _0xC3F7 then return end
if _0xB42E then
pcall(function() _0xB42E:Destroy(true) end)
_0xB42E = nil
end
local _0xE12E = _0x243A.presetKey or _0x518F
if _0xE12E and _0xA4A2[_0xE12E] then
_0xE84F(_0xE12E, _0x49D0)
if _0x207A then pcall(_0x207A) end
end
end)
end_0xA6AA.CharacterAdded:Connect(function(newMyChar)
if not _0x2CD3 or not _0x243A.active then return end
local _0x8923 = tick()
while tick() - _0x8923 < 2.5 and newMyChar.Parent and not _0x4DA4(newMyChar) do
_0xC77A.Heartbeat:Wait()
end
if not _0x243A.active then return end
local _0x9BBF = _0x243A.target
local _0xE12E = _0x243A.presetKey or _0x518F
if _0x9BBF and _0x9BBF.Parent == _0xC3F7 and _0xE12E and _0xA4A2[_0xE12E] then
if _0xB42E then
pcall(function() _0xB42E:Destroy(true) end)
_0xB42E = nil
end
_0xE84F(_0xE12E, _0x9BBF)
if _0x207A then pcall(_0x207A) end
end
end)local _0xA48A = false
local _0xABCF = 0
_0xC77A.Heartbeat:Connect(function()
if not _0x2CD3 or not _0x243A.active or not _0x243A.presetKey or _0xF3B0 or _0xA48A then
return
end
local _0x9BBF = _0x243A.target
if not _0x9BBF or _0x9BBF.Parent ~= _0xC3F7 then
_0x7EF3()
if _0x207A then pcall(_0x207A) end
return
end
if not _0xB42E or _0xB42E.destroyed then
local _0x60A3 = tick()
if _0x60A3 - _0xABCF < 0.20 then return end
local _0x0391 = _0x4E36(_0x9BBF)
local _0x6776 = _0x0391 and _0x0391:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))if _0x6776 and _0x6776.Health <= 0 then
return
end
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
local _0x4545 = _0x1213 and _0x1213:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0x32EC and _0x4545 and _0x4545.Health > 0 then
_0xABCF = _0x60A3
_0xA48A = true
task.spawn(function()
pcall(function()
local _0x099A = _0xA4A2[_0x243A.presetKey]
local _0xB516 = _0x099A and _0x099A.refMode orstring.char(116,111,114,115,111)local _0x2EC9, _0x5378 = _0x5D16(_0x9BBF, _0xB516, 1.0, false)
local _0x6143 = _0x2EC9 and _0x2EC9:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0x243A.active and (not _0xB42E or _0xB42E.destroyed) and _0x5378 and _0x5378.Parent and (not _0x6143 or _0x6143.Health > 0) then
if not _0xD510(_0x5378.CFrame, _0x5378.AssemblyLinearVelocity) then
_0xE84F(_0x243A.presetKey, _0x9BBF)
if _0x207A then pcall(_0x207A) end
end
end
end)
_0xA48A = false
end)
end
end
end)
end_0xAE44 = {
enabled = true,
rewinding = false,
duration = 8.0,maxBufferSeconds = 10.5,speedMultiplier = 1.0,instantMode = false,rewindCamera = true,buffer = {},hudFrame = nil,
hudLabel = nil,
hudBarFill = nil,
activeTracks = {},
}
dolocal _0x5E90 = 0
local _0x5E0E = 1 / 60local function _0xF1A1(_0x5685)
if not _0x5685 then return false end
local _0x1CEE = _0x5685.Position
return (_0x1CEE.X == _0x1CEE.X and _0x1CEE.Y == _0x1CEE.Y and _0x1CEE.Z == _0x1CEE.Z and _0x1CEE.Magnitude < 250000)
end
local function _0xF9A9(_0xA778)
local _0xC218 = {}
if not _0xA778 then return _0xC218 end
local _0x2FBB = _0xA778:FindFirstChildOfClass(string.char(65,110,105,109,97,116,111,114))
if not _0x2FBB then return _0xC218 end
local _0xF999, _0x6F65 = pcall(function() return _0x2FBB:GetPlayingAnimationTracks() end)
if not _0xF999 or not _0x6F65 then return _0xC218 end
for _0x9094, _0x6F27 in ipairs(_0x6F65) do
pcall(function()
if _0x6F27.IsPlaying and _0x6F27.Animation and _0x6F27.Animation.AnimationId ~=""then
table.insert(_0xC218, {
id = _0x6F27.Animation.AnimationId,
timePos = _0x6F27.TimePosition,
speed = _0x6F27.Speed,
_0x9766 = _0x6F27.WeightCurrent,
pri = _0x6F27.Priority,
})
end
end)
end
return _0xC218
end
local function _0x5986(_0x5BFE)
if not _0x5BFE then return nil end
local _0x4073 = _0x5BFE:FindFirstChildOfClass(string.char(84,111,111,108))
return _0x4073 and _0x4073.Name or nil
end
local function _0x97D4(_0x5BFE, desiredToolName)
if not _0x5BFE then return end
local _0xA778 = _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0xA778 then return end
local _0x738F = _0x5BFE:FindFirstChildOfClass(string.char(84,111,111,108))
if desiredToolName then
if not _0x738F or _0x738F.Name ~= desiredToolName then
local _0x92A3 = _0xA6AA:FindFirstChildOfClass(string.char(66,97,99,107,112,97,99,107))
local _0x42E3 = _0x92A3 and _0x92A3:FindFirstChild(desiredToolName)
if _0x42E3 and _0x42E3:IsA(string.char(84,111,111,108)) then
pcall(function() _0xA778:EquipTool(_0x42E3) end)
end
end
else
if _0x738F then
pcall(function() _0xA778:UnequipTools() end)
end
end
end
local function _0xC8AA()
if _0xAE44.hudFrame and _0xAE44.hudFrame.Parent then
return _0xAE44.hudFrame
end
if not _0xF28E or not _0xF28E.Parent then return nil end
local _0x3FBB = Instance.new(string.char(70,114,97,109,101))
_0x3FBB.Name =string.char(75,104,97,109,97,110,82,101,119,105,110,100,72,85,68)_0x3FBB.Size = UDim2.new(0, 276, 0, 44)
_0x3FBB.Position = UDim2.new(0.5, -138, 0, 56)
_0x3FBB.BackgroundColor3 = _0x90E7.BG2
_0x3FBB.BackgroundTransparency = 0.08
_0x3FBB.BorderSizePixel = 0
_0x3FBB.Visible = false
_0x3FBB.ZIndex = 950
_0x3FBB.Parent = _0xF28E
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x3FBB).CornerRadius = UDim.new(0, 10)
local _0xE898 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0xE898.Color = _0x90E7.Accent
_0xE898.Thickness = 1.5
_0xE898.Transparency = 0.15
_0xE898.Parent = _0x3FBB
local _0x2594 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x2594.Size = UDim2.new(1, -16, 0, 20)
_0x2594.Position = UDim2.new(0, 8, 0, 4)
_0x2594.BackgroundTransparency = 1
_0x2594.Text =string.char(226,143,170,32,82,69,87,73,78,68,73,78,71,32,84,73,77,69,32,40,45,48,46,48,115,32,47,32,56,46,48,115,41)_0x2594.TextColor3 = _0x90E7.Neon
_0x2594.Font = Enum.Font.GothamBold
_0x2594.TextSize = 10
_0x2594.ZIndex = 951
_0x2594.Parent = _0x3FBB
local _0x5B67 = Instance.new(string.char(70,114,97,109,101))
_0x5B67.Size = UDim2.new(1, -20, 0, 6)
_0x5B67.Position = UDim2.new(0, 10, 0, 29)
_0x5B67.BackgroundColor3 = _0x90E7.PanelLt
_0x5B67.BorderSizePixel = 0
_0x5B67.ZIndex = 951
_0x5B67.Parent = _0x3FBB
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x5B67).CornerRadius = UDim.new(1, 0)
local _0xF3D4 = Instance.new(string.char(70,114,97,109,101))
_0xF3D4.Size = UDim2.new(1, 0, 1, 0)
_0xF3D4.BackgroundColor3 = _0x90E7.Accent
_0xF3D4.BorderSizePixel = 0
_0xF3D4.ZIndex = 952
_0xF3D4.Parent = _0x5B67
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xF3D4).CornerRadius = UDim.new(1, 0)
_0xAE44.hudFrame = _0x3FBB
_0xAE44.hudLabel = _0x2594
_0xAE44.hudBarFill = _0xF3D4
return _0x3FBB
end_0xC77A.Heartbeat:Connect(function()
if not _0xAE44.enabled or _0xAE44.rewinding or _0xF3B0 or _0x1978 then
return
end
local _0x60A3 = tick()
if _0x60A3 - _0x5E90 < (_0x5E0E * 0.85) then return end
_0x5E90 = _0x60A3
local _0x5BFE = _0xA6AA.Character
local _0xE5AE = _0x5BFE and _0x5BFE:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116))
local _0xA778 = _0x5BFE and _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0xE5AE or not _0xA778 or _0xA778.Health <= 0 then return end
if not _0xF1A1(_0xE5AE.CFrame) then return end
local _0x6EE9 = workspace.CurrentCamera
local _0x9BFA = {
_0x6299 = _0x60A3,
_0x5685 = _0xE5AE.CFrame,
_0x6355 = _0xE5AE.AssemblyLinearVelocity,
angVel = _0xE5AE.AssemblyAngularVelocity,
camCF = _0x6EE9 and _0x6EE9.CFrame or nil,
camFov = _0x6EE9 and _0x6EE9.FieldOfView or 70,
humState = _0xA778:GetState(),
walkSpeed = _0xA778.WalkSpeed,
jumpPower = _0xA778.JumpPower,
sit = _0xA778.Sit,
platformStand = _0xA778.PlatformStand,
toolName = _0x5986(_0x5BFE),
weldActive = _0x243A.active,
weldPreset = _0x243A.presetKey,
weldTarget = _0x243A.target,
vX = _0x68F1.X, vY = _0x68F1.Y, vZ = _0x68F1.Z, vSpeed = _0x68F1.Speed,
anims = _0xF9A9(_0xA778),
}
local _0x7B35 = _0xAE44.buffer
_0x7B35[#_0x7B35 + 1] = _0x9BFAlocal _0x0385 = _0x60A3 - _0xAE44.maxBufferSeconds
while #_0x7B35 > 2 and _0x7B35[1].t < _0x0385 do
table.remove(_0x7B35, 1)
end
end)
local function _0xD0DD()
for _0x9094, _0x6F27 in pairs(_0xAE44.activeTracks) do
pcall(function() _0x6F27:Stop(0) end)
pcall(function() _0x6F27:Destroy() end)
end
_0xAE44.activeTracks = {}
end
local function _0x97EB(_0x5BFE, _0xE5AE, _0xA778, _0x9BFA, scrubAnims)
if not _0x5BFE or not _0xE5AE or not _0x9BFA then return end
_0x363C(_0x9BFA.cf)
_0xE5AE.CFrame = _0x9BFA.cf
_0xE5AE.AssemblyLinearVelocity = Vector3.zero
_0xE5AE.AssemblyAngularVelocity = Vector3.zero
if _0x9BFA.vX then _0x68F1.X = _0x9BFA.vX; _0x68F1.Y = _0x9BFA.vY; _0x68F1.Z = _0x9BFA.vZ; _0x68F1.Speed = _0x9BFA.vSpeed end
if _0xAE44.rewindCamera and _0x9BFA.camCF then
local _0x6EE9 = workspace.CurrentCamera
if _0x6EE9 and not _0x5BCC then
pcall(function()
_0x6EE9.CFrame = _0x9BFA.camCF
if _0x9BFA.camFov then _0x6EE9.FieldOfView = _0x9BFA.camFov end
end)
end
end
if _0x9BFA.toolName ~= nil or _0x5BFE:FindFirstChildOfClass(string.char(84,111,111,108)) then
_0x97D4(_0x5BFE, _0x9BFA.toolName)
end
if scrubAnims and _0xA778 and _0x9BFA.anims then
local _0x2FBB = _0xA778:FindFirstChildOfClass(string.char(65,110,105,109,97,116,111,114))
if _0x2FBB then
for _0x9094, aInfo in ipairs(_0x9BFA.anims) do
local _0x6F27 = _0xAE44.activeTracks[aInfo.id]
if not _0x6F27 or not _0x6F27.IsPlaying then
pcall(function()
local _0x3A68 = Instance.new(string.char(65,110,105,109,97,116,105,111,110))
_0x3A68.AnimationId = aInfo.id
_0x6F27 = _0x2FBB:LoadAnimation(_0x3A68)
_0x6F27.Priority = aInfo.pri or Enum.AnimationPriority.Action
_0x6F27:Play(0.05)
_0xAE44.activeTracks[aInfo.id] = _0x6F27
end)
end
if _0x6F27 then
pcall(function()
_0x6F27:AdjustSpeed(0)
_0x6F27.TimePosition = aInfo.timePos
_0x6F27:AdjustWeight(math.clamp(aInfo.weight or 1, 0.05, 1))
end)
end
end
end
end
end
function _0xAE44:Stop(restoreSnap)
if not self.rewinding then return end
self.rewinding = false
_0xD0DD()
if self.hudFrame then self.hudFrame.Visible = false end
local _0x5BFE = _0xA6AA.Character
local _0xE5AE = _0x5BFE and _0x5BFE:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116))
local _0xA778 = _0x5BFE and _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0x5BFE then
for _0x9094, _0x5959 in ipairs(_0x04D0(_0x5BFE)) do
if _0x5959.Parent then
_0x5959.Massless = false
if not (_0x02BF and _0x02BF.noclip) and (_0x5959.Name ==string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116)or _0x5959.Name ==string.char(84,111,114,115,111)or _0x5959.Name ==string.char(85,112,112,101,114,84,111,114,115,111)or _0x5959.Name ==string.char(76,111,119,101,114,84,111,114,115,111)or _0x5959.Name ==string.char(72,101,97,100)) then
_0x5959.CanCollide = true
end
end
end
_0x0334(_0x5BFE)
end
if _0xE5AE and restoreSnap then
_0x363C(_0xE5AE.CFrame)
if _0x97B4(_0xE5AE.CFrame) then
_0x7067 = _0xE5AE.CFrame
end
if restoreSnap.vel and restoreSnap.vel.Magnitude < 120 and restoreSnap.vel.Y > -65 then
_0xE5AE.AssemblyLinearVelocity = restoreSnap.vel
else
_0xE5AE.AssemblyLinearVelocity = Vector3.zero
end
_0xE5AE.AssemblyAngularVelocity = Vector3.zero
end
if _0xA778 and _0xA778.Health > 0 then
pcall(function()
_0xA778.PlatformStand = false
_0xA778.Sit = restoreSnap and restoreSnap.sit or false
_0xA778.AutoRotate = true
if restoreSnap and restoreSnap.walkSpeed and not (_0x02BF and _0x02BF.speed) then
_0xA778.WalkSpeed = restoreSnap.walkSpeed
end
if restoreSnap and restoreSnap.humState and restoreSnap.humState ~= Enum.HumanoidStateType.Dead then
_0xA778:ChangeState(restoreSnap.humState)
else
_0xA778:ChangeState(Enum.HumanoidStateType.Running)
end
end)
end
if not (_0x5DAB and (_0x5DAB.AlwaysOnCore or (_0x5DAB.Void and _0x5DAB.Void.enabled) or (_0x5DAB.InfFallVoid and _0x5DAB.InfFallVoid.enabled) or (_0x5DAB.Kill and _0x5DAB.Kill.enabled))) and not _0x243A.active and not _0xF3B0 then
pcall(function() workspace.FallenPartsDestroyHeight = _0x8668 end)
end
if _0x207A then pcall(_0x207A) end
end
function _0xAE44:Start(customSeconds)
if self.rewinding thenself:Stop(nil)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(226,143,185,239,184,143,32,82,101,119,105,110,100,32,108,111,99,107,101,100,32,97,116,32,99,117,114,114,101,110,116,32,112,111,105,110,116,33))
_0xED6E()
return
end
local _0xCE98 = math.clamp(tonumber(customSeconds) or self.duration or 8.0, 1.0, 10.0)
local _0x7B35 = self.buffer
if #_0x7B35 < 2 then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(82,101,119,105,110,100,32,98,117,102,102,101,114,32,119,97,114,109,105,110,103,32,117,112,32,226,128,148,32,109,111,118,101,32,97,114,111,117,110,100,32,102,111,114,32,97,32,109,111,109,101,110,116,33))
_0xB065()
return
end
local _0x5BFE = _0xA6AA.Character
local _0xE5AE = _0x5BFE and _0x5BFE:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116))
local _0xA778 = _0x5BFE and _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0x5BFE or not _0xE5AE or not _0xA778 or _0xA778.Health <= 0 then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(67,104,97,114,97,99,116,101,114,32,110,111,116,32,114,101,97,100,121,32,116,111,32,114,101,119,105,110,100,33))
_0xB065()
return
endif _0xF3B0 then _0x3C23:StopFling(true) end
if _0x243A.active then _0x7EF3() end
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
local _0xE0ED = _0x7B35[#_0x7B35].t
local _0xB8DF = _0xE0ED - _0xCE98
local _0xCC14 = #_0x7B35
local _0x738E = 1
for i = #_0x7B35, 1, -1 do
if _0x7B35[i].t >= _0xB8DF then
_0x738E = i
else
break
end
end
local _0xB131 = math.max(0.1, _0xE0ED - _0x7B35[_0x738E].t)
self.rewinding = true
if _0x207A then pcall(_0x207A) end
_0xEA8A()if self.instantMode then
local _0x46D4 = _0x7B35[_0x738E]
for i = #_0x7B35, _0x738E + 1, -1 do
table.remove(_0x7B35, i)
end
_0x97EB(_0x5BFE, _0xE5AE, _0xA778, _0x46D4, false)
self:Stop(_0x46D4)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65), string.format(string.char(226,143,170,32,73,110,115,116,97,110,116,32,82,101,119,105,110,100,32,40,45,37,46,49,102,115,41,32,99,111,109,112,108,101,116,101,33), _0xB131))
_0xCAE4()
return
endlocal _0xF27C = _0xC8AA()
if _0xF27C then _0xF27C.Visible = true end
_0x1B7E(_0x5BFE)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65), string.format(string.char(226,143,170,32,82,101,119,105,110,100,105,110,103,32,37,46,49,102,32,115,101,99,111,110,100,115,32,119,105,116,104,32,101,120,97,99,116,32,112,114,101,99,105,115,105,111,110,46,46,46), _0xB131))
task.spawn(function()
local _0x7EAF = _0xE0ED
local _0x8D1C = _0x7B35[_0xCC14]
while self.rewinding do
local _0x004C = _0xC77A.Heartbeat:Wait()
if not self.rewinding then break end
if not _0x5BFE.Parent or _0xA6AA.Character ~= _0x5BFE or not _0xE5AE.Parent or not _0xA778.Parent or _0xA778.Health <= 0 then
break
endfor _0x9094, _0x1CEE in ipairs(_0x04D0(_0x5BFE)) do
if _0x1CEE.Parent and _0x1CEE.CanCollide then
_0x1CEE.CanCollide = false
end
end
_0x7EAF = _0x7EAF - (_0x004C * (self.speedMultiplier or 1.0))
local _0xC3BD = _0xE0ED - _0x7EAF
local _0x41AB = math.clamp(1 - (_0xC3BD / _0xB131), 0, 1)
if self.hudLabel then
self.hudLabel.Text = string.format(string.char(226,143,170,32,82,69,87,73,78,68,73,78,71,58,32,45,37,46,49,102,115,32,47,32,37,46,49,102,115,32,40,84,97,112,32,116,111,32,83,116,111,112,41), math.min(_0xC3BD, _0xB131), _0xB131)
end
if self.hudBarFill then
self.hudBarFill.Size = UDim2.new(_0x41AB, 0, 1, 0)
endwhile #_0x7B35 > _0x738E and _0x7B35[#_0x7B35].t > _0x7EAF do
_0x8D1C = table.remove(_0x7B35, #_0x7B35)
end
local _0x7FAA = _0x7B35[#_0x7B35] or _0x8D1C
if _0x7FAA and _0x8D1C and _0x7FAA ~= _0x8D1C and (_0x8D1C.t - _0x7FAA.t) > 0.0001 then
local _0x5987 = math.clamp((_0x7EAF - _0x7FAA.t) / (_0x8D1C.t - _0x7FAA.t), 0, 1)
local _0x881C = _0x7FAA.cf:Lerp(_0x8D1C.cf, _0x5987)
local _0xFC50 = (_0x7FAA.camCF and _0x8D1C.camCF) and _0x7FAA.camCF:Lerp(_0x8D1C.camCF, _0x5987) or _0x7FAA.camCF
local _0x9688 = {
_0x5685 = _0x881C,
camCF = _0xFC50,
camFov = _0x7FAA.camFov,
toolName = _0x7FAA.toolName,
anims = _0x7FAA.anims,
_0x6355 = _0x7FAA.vel,
sit = _0x7FAA.sit,
walkSpeed = _0x7FAA.walkSpeed,
humState = _0x7FAA.humState,
vX = _0x7FAA.vX, vY = _0x7FAA.vY, vZ = _0x7FAA.vZ, vSpeed = _0x7FAA.vSpeed,
}
_0x97EB(_0x5BFE, _0xE5AE, _0xA778, _0x9688, true)
elseif _0x7FAA then
_0x97EB(_0x5BFE, _0xE5AE, _0xA778, _0x7FAA, true)
end
if _0x7EAF <= _0x7B35[_0x738E].t or #_0x7B35 <= _0x738E then
_0x8D1C = _0x7B35[_0x738E] or _0x7FAA
break
end
end
if self.rewinding then
self:Stop(_0x8D1C)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65), string.format(string.char(226,156,168,32,82,101,119,111,117,110,100,32,45,37,46,49,102,115,32,119,105,116,104,32,101,120,97,99,116,32,112,114,101,99,105,115,105,111,110,33), _0xB131))
_0xCAE4()
end
end)
end
endlocal function _0x3D9C(_0x5BFE, isLocalRam)
if not _0x5BFE then return end
for _0x9094, _0x5959 in ipairs(_0x04D0(_0x5BFE)) do
if _0x5959.Parent then
local _0xD01E = (_0x5959.Name ==string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116)or _0x5959.Name ==string.char(84,111,114,115,111)or _0x5959.Name ==string.char(85,112,112,101,114,84,111,114,115,111)or _0x5959.Name ==string.char(76,111,119,101,114,84,111,114,115,111)or _0x5959.Name ==string.char(72,101,97,100))
if isLocalRam then
_0x5959.CanCollide = _0xD01E
_0x5959.CanTouch = false
_0x5959.Massless = false
if _0xD01E then
pcall(function()
_0x5959.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5, 100, 100)
end)
end
else
if _0xD01E then
_0x5959.CanCollide = true
end
_0x5959.Massless = false
end
end
end
end
local function _0x0F95(durationSeconds, modeTitle, isVoidThrow, explicitTarget)
local _0x0FE0 = (durationSeconds == nil or durationSeconds <= 0)
local _0x49D0, _0xAF3C
if explicitTarget and explicitTarget.Parent == _0xC3F7 then
_0x49D0, _0xAF3C = explicitTarget, false
else
_0x49D0, _0xAF3C = _0xB894()
end
if not _0x49D0 or _0x49D0.Parent ~= _0xC3F7 then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(78,111,32,116,97,114,103,101,116,32,112,108,97,121,101,114,32,102,111,117,110,100,32,105,110,32,115,101,114,118,101,114,33))
_0xB065()
return
end
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
local _0x4545 = _0x1213 and _0x1213:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0x32EC then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(76,111,99,97,108,32,99,104,97,114,97,99,116,101,114,32,110,111,116,32,114,101,97,100,121,33))
_0xB065()
return
endlocal _0xCE2F = _0x97B4(_0x32EC.CFrame) and _0x32EC.CFrame or _0x6660()local _0x2EC9 = _0x4E36(_0x49D0)
local _0x9DA4 = _0x2EC9 and _0x2EC9:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
local _0x2876 = _0x2EC9 and _0x76B4(_0x2EC9,string.char(116,111,114,115,111))
if not _0x2876 or not _0x2876.Parent then
_0x2EC9, _0x2876 = _0x5D16(_0x49D0,string.char(116,111,114,115,111), 2.2)
_0x9DA4 = _0x2EC9 and _0x2EC9:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
else
_0xF424(_0x1213)
end
if not _0x0FE0 and (not _0x2876 or not _0x2876.Parent) then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(67,111,117,108,100,32,110,111,116,32,115,116,114,101,97,109,32,116,97,114,103,101,116,32,226,128,148,32,116,114,121,32,97,103,97,105,110,33))
_0xB065()
return
end
local _0xFA9B = _0xCE2F
_0x7067 = _0xFA9B
_0x3C23:Cleanup(true, true)
_0x6652 = _0x49D0
_0xF3B0 = true
_0xCE0F = _0xFA9Blocal _0x6EE9 = workspace.CurrentCamera
if _0x6EE9 then
_0x5752 = _0x6EE9.CameraType
_0x4652 = _0x6EE9.CameraSubject
_0xBF41 = _0x6EE9.CFrame
pcall(function()
if _0x9DA4 then
_0x6EE9.CameraSubject = _0x9DA4
end
end)
end
if _0x207A then pcall(_0x207A) end
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
_0x839F = _0x49D0.UserId
_0xE947(_0x49D0)
if _0x1213 then _0x1B7E(_0x1213) end
if _0xA2C6 then
_0xA2C6.Visible = true
if _0x3FD6 then
_0x3FD6.Text = _0x0FE0
andstring.char(226,153,190,239,184,143,32,85,78,76,73,77,73,84,69,68,32,70,76,73,78,71,32,40,84,97,112,32,83,84,79,80,32,116,111,32,101,110,100,41)or (tostring(math.ceil(durationSeconds)) ..string.char(115,32,114,101,109,97,105,110,105,110,103))
end
end
_0x6F35()
local _0x59E7 = isVoidThrow andstring.char(86,111,105,100,32,84,104,114,111,119,32,118,50,32,40)or (_0xAF3C andstring.char(65,117,116,111,45,78,101,97,114,101,115,116,32,70,108,105,110,103,32,40)orstring.char(78,101,98,117,108,97,32,70,108,105,110,103,32,40))
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65), _0x59E7 .. tostring(modeTitle) ..string.char(41,32,45,62,32).. _0x49D0.Name)
local _0x3292 = tick()
local _0x0838 = 0
local _0x1266 = (_0x2876 and _0x2876.Parent and _0x2876.CFrame) or _0xFA9B
local _0x78F8 = Vector3.new(0, -150000, 0)
local _0x19DF = Vector3.new(120000, 120000, 120000)
local _0x555F = false
local _0x8C6F = 0if _0x2876 and _0x2876.Parent and _0x32EC and _0x32EC.Parent then
pcall(function() _0xA6AA.ReplicationFocus = _0x2876 end)
if _0x2668 then
pcall(function()
_0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), _0x2876)
if _0x3E41 then
_0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), _0x3E41(_0x2876))
end
end)
end
_0x3D9C(_0x1213, true)
if _0x2EC9 and _0x2EC9.Parent then
_0x3D9C(_0x2EC9, false)
end
_0x363C(_0x1266)
_0x32EC.CFrame = _0x1266
_0x32EC.AssemblyLinearVelocity = _0x78F8
_0x32EC.AssemblyAngularVelocity = _0x19DF
end
local function _0x1A70(msg, playSuccess)
_0x3C23:StopFling(false)
if msg then _0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65), msg) end
if playSuccess then _0xCAE4() end
end_0x3C23.FlingStepConn = _0xC77A.Stepped:Connect(function()
if not _0xF3B0 then
if _0x3C23.FlingStepConn then _0x3C23.FlingStepConn:Disconnect(); _0x3C23.FlingStepConn = nil end
return
end
_0x1213 = _0xA6AA.Character
_0x32EC = _0x4DA4(_0x1213)
_0x4545 = _0x1213 and _0x1213:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0x1213 or not _0x32EC then return end
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
if _0x555F thenif _0x2668 then
pcall(function() _0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), nil) end)
pcall(function() _0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), nil) end)
end
_0x32EC.CFrame = _0xFA9B
_0x32EC.AssemblyLinearVelocity = Vector3.zero
_0x32EC.AssemblyAngularVelocity = Vector3.zero
return
end
if _0x2876 and _0x2876.Parent and _0x2668 then
pcall(function()
_0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), _0x2876)
if _0x3E41 then
_0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), _0x3E41(_0x2876))
end
end)
end
_0x3D9C(_0x1213, true)
if _0x2EC9 and _0x2EC9.Parent then
_0x3D9C(_0x2EC9, false)
end
if _0x4545 then
pcall(function()
if _0x4545.Sit then _0x4545.Sit = false end
if not _0x4545.PlatformStand then _0x4545.PlatformStand = true end
_0x4545:ChangeState(Enum.HumanoidStateType.Physics)
end)
end
if _0x1266 then
_0x32EC.CFrame = _0x1266
_0x32EC.AssemblyLinearVelocity = _0x78F8
_0x32EC.AssemblyAngularVelocity = _0x19DF
pcall(function()
_0x32EC.Velocity = _0x78F8
_0x32EC.RotVelocity = _0x19DF
end)
end
end)
_0xB7ED = _0xC77A.Heartbeat:Connect(function()
if not _0xF3B0 then
_0x1A70(nil, false)
return
end_0x1213 = _0xA6AA.Character
_0x32EC = _0x4DA4(_0x1213)
_0x4545 = _0x1213 and _0x1213:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0x1213 or not _0x32EC or (_0x4545 and _0x4545.Health <= 0) then
if _0x0FE0 then
returnelse
_0x1A70(string.char(76,111,99,97,108,32,99,104,97,114,97,99,116,101,114,32,114,101,115,101,116,32,226,128,148,32,102,108,105,110,103,32,115,116,111,112,112,101,100,46), false)
return
end
endif not _0x49D0 or _0x49D0.Parent ~= _0xC3F7 then
if _0x0FE0 and _0xAF3C then
local _0x8CFA = _0x4681(_0xA6AA)
if _0x8CFA and _0x8CFA.Parent == _0xC3F7 then
_0x49D0 = _0x8CFA
_0x6652 = _0x49D0
_0x2EC9 = nil
_0x2876 = nil
else
_0x555F = true
if _0x3FD6 then _0x3FD6.Text =string.char(226,153,190,239,184,143,32,85,78,76,73,77,73,84,69,68,32,40,87,97,105,116,105,110,103,32,102,111,114,32,112,108,97,121,101,114,115,46,46,46,41)end
return
end
else
_0x1A70(string.char(226,156,168,32,84,97,114,103,101,116,32,108,101,102,116,32,115,101,114,118,101,114,32,226,128,148,32,115,97,102,101,108,121,32,114,101,116,117,114,110,101,100,33), true)
return
end
endlocal _0x33F3 = _0x4E36(_0x49D0)
if _0x33F3 ~= _0x2EC9 or not _0x2876 or not _0x2876.Parent then
_0x2EC9 = _0x33F3
_0x9DA4 = _0x2EC9 and _0x2EC9:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
_0x2876 = _0x2EC9 and _0x76B4(_0x2EC9,string.char(116,111,114,115,111))
end
local _0xE363 = (_0x9DA4 and _0x9DA4.Parent and _0x9DA4.Health <= 0)
local _0x1312 = false
if _0x2876 and _0x2876.Parent then
local _0xA0DC = _0x2876.Position
local _0x3F0E = _0x2876.AssemblyLinearVelocity
local _0xF630 = math.min(_0x8668 + 14, -245)
_0x1312 = (_0xA0DC.Y <= _0xF630)
or (_0xA0DC.Y <= -190 and _0x3F0E.Y < -85)
or (_0xA0DC.Magnitude > 28000)
endif not _0x2876 or not _0x2876.Parent or _0xE363 or _0x1312 then
if not _0x0FE0 thenif _0xE363 then
_0x1A70(string.char(239,191,189,239,191,189,32).. _0x49D0.Name ..string.char(32,100,105,101,100,32,105,110,32,116,104,101,32,86,111,105,100,33,32,83,97,102,101,108,121,32,114,101,116,117,114,110,101,100,46), true)
return
elseif _0x1312 and _0x2876 then
local _0xA0DC = _0x2876.Position
local _0xFFDA = CFrame.new(_0xA0DC.X, math.clamp(_0x8668 - 180, -850, -380), _0xA0DC.Z)
_0x32EC.CFrame = _0xFFDA
_0x32EC.AssemblyLinearVelocity = Vector3.new(0, -180000, 0)
_0x1A70(string.char(239,191,189,239,191,189,32).. _0x49D0.Name ..string.char(32,116,114,97,112,112,101,100,32,105,110,32,86,111,105,100,32,38,32,101,108,105,109,105,110,97,116,101,100,33,32,83,97,102,101,108,121,32,114,101,116,117,114,110,101,100,46), true)
return
else
local _0x3526 = _0xF668(_0x49D0)
if _0x3526 and _0xD510(_0x3526) then
_0x1A70(string.char(239,191,189,239,191,189,32).. _0x49D0.Name ..string.char(32,100,101,115,116,114,111,121,101,100,32,105,110,32,116,104,101,32,86,111,105,100,33,32,83,97,102,101,108,121,32,114,101,116,117,114,110,101,100,46), true)
return
end
return
end
elseif _0xAF3C then
local _0x56CA = _0x4681(_0xA6AA)
if _0x56CA and _0x56CA ~= _0x49D0 and _0x56CA.Parent == _0xC3F7 then
local _0x8D83 = _0x4E36(_0x56CA)
local _0x4207 = _0x8D83 and _0x8D83:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
local _0x5CBB = _0x8D83 and _0x76B4(_0x8D83,string.char(116,111,114,115,111))
if _0x5CBB and (not _0x4207 or _0x4207.Health > 0) and not _0xD510(_0x5CBB.CFrame, _0x5CBB.AssemblyLinearVelocity) then
_0x49D0 = _0x56CA
_0x6652 = _0x56CA
_0x2EC9 = _0x8D83
_0x9DA4 = _0x4207
_0x2876 = _0x5CBB
_0x555F = false
end
end
endif not _0x2876 or not _0x2876.Parent or _0xE363 or _0x1312 then
_0x555F = true
if _0x2668 then
pcall(function() _0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), nil) end)
pcall(function() _0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), nil) end)
end
_0x363C(_0xFA9B)
_0x32EC.CFrame = _0xFA9B
_0x32EC.AssemblyLinearVelocity = Vector3.zero
_0x32EC.AssemblyAngularVelocity = Vector3.zero
if _0x3FD6 then
_0x3FD6.Text =string.char(226,153,190,239,184,143,32,85,78,76,73,77,73,84,69,68,32,40,87,97,105,116,105,110,103,32).. _0x49D0.Name ..string.char(32,114,101,115,112,97,119,110,41)endlocal _0x60A3 = tick()
if not _0xE363 and (_0x60A3 - _0x8C6F) > 0.6 then
_0x8C6F = _0x60A3
local _0x60A5 = _0xF668(_0x49D0)
if _0x60A5 and not _0xD510(_0x60A5) then
task.spawn(function()
pcall(function() _0xA6AA:RequestStreamAroundAsync(_0x60A5.Position, 1) end)
end)
end
end
return
end
end
endif _0x555F then
_0x555F = false
_0x1B7E(_0x1213)
if _0x6EE9 and _0x9DA4 and not _0x5BCC then
pcall(function() _0x6EE9.CameraSubject = _0x9DA4 end)
end
end
local _0xDFBB = tick() - _0x3292
if not _0x0FE0 then
local _0xD68B = math.max(0, durationSeconds - _0xDFBB)
if _0x3FD6 then
_0x3FD6.Text =string.char(226,143,179,32).. string.format(string.char(37,46,49,102), _0xD68B) ..string.char(115,32,108,101,102,116)end
if _0xD68B <= 0 then
_0x1A70(string.char(226,156,168,32).. tostring(modeTitle) ..string.char(32,102,105,110,105,115,104,101,100,32,38,32,115,97,102,101,108,121,32,114,101,116,117,114,110,101,100,33), true)
return
end
else
if _0x3FD6 then
_0x3FD6.Text = string.format(string.char(226,153,190,239,184,143,32,85,78,76,73,77,73,84,69,68,32,194,183,32,37,46,48,102,115,32,40,37,115,41), _0xDFBB, _0x49D0.Name:sub(1, 10))
end
endpcall(function() _0xA6AA.ReplicationFocus = _0x2876 end)
if _0x2668 then
pcall(function()
_0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,80,97,114,116), _0x2876)
if _0x3E41 then
_0x2668(_0x32EC,string.char(80,104,121,115,105,99,115,82,101,112,82,111,111,116,82,101,102), _0x3E41(_0x2876))
end
end)
end
local _0xA0DC = _0x2876.Position
local _0x3F0E = _0x2876.AssemblyLinearVelocity
_0x0838 = _0x0838 + 1
local _0x6299 = tick() * 45local _0x7DE7 = (_0x9DA4 and _0x9DA4.MoveDirection) or Vector3.zero
local _0x2D75 = Vector3.new(_0x3F0E.X, 0, _0x3F0E.Z)
if _0x2D75.Magnitude > 140 then
_0x2D75 = _0x2D75.Unit * 140
end
local _0xE8E9 = (_0x2D75 * 0.065) + (_0x7DE7 * 1.35)
local _0x0CC6 = _0xA0DC + _0xE8E9local _0xFD0F = Vector3.new(_0x0CC6.X, 0, _0x0CC6.Z)
if _0xFD0F.Magnitude < 1 then
_0xFD0F = Vector3.new(math.cos(_0x6299), 0, math.sin(_0x6299))
else
_0xFD0F = _0xFD0F.Unit
end
if isVoidThrow then
local _0x817A = _0x0838 % 12
if _0x817A <= 6 thenlocal _0x399A = 1.5 - ((_0x817A / 6) * 2.7)
local _0x5B3C = Vector3.new(math.cos(_0x6299 * 1.9) * 0.55, _0x399A, math.sin(_0x6299 * 1.9) * 0.55)
local _0x6273 = math.max(_0x0CC6.Y + _0x5B3C.Y, _0x8668 + 22)
_0x1266 = CFrame.new(_0x0CC6.X + _0x5B3C.X, _0x6273, _0x0CC6.Z + _0x5B3C.Z)
* CFrame.Angles(math.rad((_0x0838 * 73) % 360), _0x6299, math.rad((_0x0838 * 137) % 360))
_0x78F8 = Vector3.new(
_0xFD0F.X * 75000 + math.random(-25000, 25000),
-175000,
_0xFD0F.Z * 75000 + math.random(-25000, 25000)
)
_0x19DF = Vector3.new(145000, 145000, 145000)
elseif _0x817A <= 9 thenlocal _0x75DD = -_0xFD0F * ((_0x817A % 2 == 0) and 0.85 or -0.45)
local _0x6273 = math.max(_0x0CC6.Y - 0.35, _0x8668 + 22)
_0x1266 = CFrame.new(_0x0CC6.X + _0x75DD.X, _0x6273, _0x0CC6.Z + _0x75DD.Z)
* CFrame.Angles(_0x6299, _0x6299 * 1.7, -_0x6299)
_0x78F8 = Vector3.new(
_0xFD0F.X * 135000,
-115000,
_0xFD0F.Z * 135000
)
_0x19DF = Vector3.new(160000, -160000, 160000)
elselocal _0xD0A4 = math.clamp(_0x8668 - 165, -820, -350)
_0x1266 = CFrame.new(_0x0CC6.X, _0xD0A4, _0x0CC6.Z)
* CFrame.Angles(math.rad(180), _0x6299, 0)
_0x78F8 = Vector3.new(_0xFD0F.X * 95000, -195000, _0xFD0F.Z * 95000)
_0x19DF = Vector3.new(150000, 150000, 150000)
end
elselocal _0x2AC4 = (_0x0838 % 3 == 0) and 0.15 or ((_0x0838 % 2 == 0) and 0.75 or 1.85)
local _0xF611 = math.sin(_0x0838 * 0.85) * 1.1
local _0x6273 = math.max(_0x0CC6.Y + _0xF611, _0x8668 + 22)
local _0x20CA = Vector3.new(math.cos(_0x6299) * _0x2AC4, 0, math.sin(_0x6299) * _0x2AC4)
_0x1266 = CFrame.new(Vector3.new(_0x0CC6.X, _0x6273, _0x0CC6.Z) + _0x20CA)
* CFrame.Angles(math.rad((_0x0838 * 65) % 360), _0x6299, math.rad((_0x0838 * 115) % 360))
_0x78F8 = Vector3.new(
_0xFD0F.X * 90000 + math.random(-45000, 45000),
(_0x0838 % 2 == 0) and -130000 or 110000,
_0xFD0F.Z * 90000 + math.random(-45000, 45000)
)
_0x19DF = Vector3.new(135000, 135000, 135000)
end
_0x363C(_0x1266)
_0x32EC.CFrame = _0x1266
_0x32EC.AssemblyLinearVelocity = _0x78F8
_0x32EC.AssemblyAngularVelocity = _0x19DF
pcall(function()
_0x32EC.Velocity = _0x78F8
_0x32EC.RotVelocity = _0x19DF
end)
end)
end
local function _0xC789(explicitTarget, customDuration)
_0x0F95(customDuration or 5.5,string.char(86,111,105,100,32,84,104,114,111,119,32,118,50), true, explicitTarget)
end
local function _0xFF07()
local _0x49D0, _0xAF3C = _0xB894()
if not _0x49D0 then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(78,111,32,116,97,114,103,101,116,32,111,114,32,110,101,97,114,98,121,32,112,108,97,121,101,114,32,102,111,117,110,100,33))
_0xB065()
return
end
if not _0xF28E then return end
local _0xA2A1 = Instance.new(string.char(70,114,97,109,101))
_0xA2A1.Size = UDim2.new(1, 0, 1, 0)
_0xA2A1.BackgroundColor3 = Color3.new(0, 0, 0)
_0xA2A1.BackgroundTransparency = 0.5
_0xA2A1.ZIndex = 120
_0xA2A1.Parent = _0xF28E
local _0xA400 = Instance.new(string.char(70,114,97,109,101))
_0xA400.Size = UDim2.new(0, 306, 0, 284)
_0xA400.Position = UDim2.new(0.5, -153, 0.5, -142)
_0xA400.BackgroundColor3 = _0x90E7.Panel
_0xA400.BorderSizePixel = 0
_0xA400.ZIndex = 121
_0xA400.Parent = _0xA2A1
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xA400).CornerRadius = UDim.new(0, 12)
local _0x2A64 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x2A64.Color = _0x90E7.Purple
_0x2A64.Thickness = 1.5
_0x2A64.Transparency = 0.3
_0x2A64.Parent = _0xA400
local _0x579D = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x579D.Size = UDim2.new(1, -20, 0, 24)
_0x579D.Position = UDim2.new(0, 10, 0, 10)
_0x579D.BackgroundTransparency = 1
_0x579D.Text =string.char(86,79,73,68,32,84,72,82,79,87,32,86,50,32,38,32,78,69,66,85,76,65,32,70,76,73,78,71)_0x579D.TextColor3 = _0x90E7.Purple
_0x579D.Font = Enum.Font.GothamBold
_0x579D.TextSize = 12
_0x579D.ZIndex = 122
_0x579D.Parent = _0xA400
local _0x9BA5 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x9BA5.Size = UDim2.new(1, -20, 0, 18)
_0x9BA5.Position = UDim2.new(0, 10, 0, 32)
_0x9BA5.BackgroundTransparency = 1
_0x9BA5.Text = (_0xAF3C andstring.char(97,117,116,111,45,110,101,97,114,101,115,116,58,32)orstring.char(116,97,114,103,101,116,58,32)) .. _0x49D0.Name ..string.char(32,40,49,48,48,45,100,101,110,115,105,116,121,32,118,111,105,100,32,116,114,97,112,41)_0x9BA5.TextColor3 = _0x90E7.Muted
_0x9BA5.Font = Enum.Font.Gotham
_0x9BA5.TextSize = 10
_0x9BA5.ZIndex = 122
_0x9BA5.Parent = _0xA400
local function _0x630F(y, text, color, cb)
local _0x4973 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x4973.Size = UDim2.new(1, -24, 0, 32)
_0x4973.Position = UDim2.new(0, 12, 0, y)
_0x4973.BackgroundColor3 = color
_0x4973.Text = text
_0x4973.TextColor3 = Color3.new(1, 1, 1)
_0x4973.Font = Enum.Font.GothamBold
_0x4973.TextSize = 10
_0x4973.ZIndex = 123
_0x4973.Parent = _0xA400
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4973).CornerRadius = UDim.new(0, 6)
_0x4973.MouseEnter:Connect(function()
_0x9FE9()
_0xFD0E:Create(_0x4973, TweenInfo.new(0.12), {BackgroundColor3 = color:Lerp(Color3.new(1, 1, 1), 0.12)}):Play()
end)
_0x4973.MouseLeave:Connect(function()
_0xFD0E:Create(_0x4973, TweenInfo.new(0.18), {BackgroundColor3 = color}):Play()
end)
_0x4973.MouseButton1Click:Connect(function()
_0x0909()
_0xA2A1:Destroy()
cb()
end)
end
_0x630F(58,string.char(226,153,190,239,184,143,32,85,110,108,105,109,105,116,101,100,32,78,101,98,117,108,97,32,70,108,105,110,103,32,40,78,111,110,45,83,116,111,112,32,84,105,108,108,32,83,116,111,112,112,101,100,41), _0x90E7.Accent2, function()
_0x0F95(-1,string.char(85,110,108,105,109,105,116,101,100,32,78,111,110,45,83,116,111,112), false, _0x49D0)
end)
_0x630F(96,string.char(239,191,189,239,191,189,239,184,143,32,85,110,108,105,109,105,116,101,100,32,86,111,105,100,32,76,111,99,107,32,40,84,114,97,112,32,38,32,82,101,45,70,108,105,110,103,32,78,111,110,45,83,116,111,112,41), Color3.fromRGB(185, 45, 95), function()
_0x0F95(-1,string.char(85,110,108,105,109,105,116,101,100,32,86,111,105,100,32,76,111,99,107), true, _0x49D0)
end)
_0x630F(134,string.char(226,154,161,32,86,111,105,100,32,84,104,114,111,119,32,118,50,32,40,53,46,53,115,32,66,117,114,121,32,43,32,67,97,116,97,112,117,108,116,32,43,32,83,105,110,107,104,111,108,101,41), Color3.fromRGB(145, 95, 18), function()
_0xC789(_0x49D0, 5.5)
end)
_0x630F(172,string.char(239,191,189,239,191,189,239,184,143,32,52,32,83,101,99,111,110,100,115,32,40,72,105,103,104,45,68,101,110,115,105,116,121,32,86,111,114,116,101,120,32,66,108,97,115,116,41), Color3.fromRGB(76, 79, 87), function()
_0x0F95(4.0,string.char(52,32,83,101,99,111,110,100,115), false, _0x49D0)
end)
_0x630F(210,string.char(226,152,132,239,184,143,32,56,32,83,101,99,111,110,100,115,32,40,69,120,116,114,101,109,101,32,79,109,110,105,45,86,111,114,116,101,120,41), Color3.fromRGB(104, 108, 117), function()
_0x0F95(8.0,string.char(56,32,83,101,99,111,110,100,115), false, _0x49D0)
end)
local _0x7DA0 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x7DA0.Size = UDim2.new(0, 24, 0, 24)
_0x7DA0.Position = UDim2.new(1, -30, 0, 8)
_0x7DA0.BackgroundTransparency = 1
_0x7DA0.Text =string.char(88)_0x7DA0.TextColor3 = _0x90E7.Muted
_0x7DA0.Font = Enum.Font.GothamBold
_0x7DA0.TextSize = 12
_0x7DA0.ZIndex = 124
_0x7DA0.Parent = _0xA400
_0x7DA0.MouseButton1Click:Connect(function()
_0x0909()
_0xA2A1:Destroy()
end)
end
local _0x59D4, _0x546D, _0xC080, _0x48CA, _0xC9A9, _0x50D5, _0x21C1, _0x7154, _0xA6C9 = false,string.char(114,111,97,115,116),"","", 0,string.char(45), 0, nil, nil
do
local _0xAB73 = 5
local _0x3F08 = 200
local _0xB53F =string.char(32,84,77,75,88,32,77,65,73,32)local _0x47FC =string.char(75,72,65,77,65,78,32,68,72,79,75,76,65,32,79,78,32,84,79,80)local _0x6939 = {string.char(78,79,79,66),string.char(82,79,79,75,73,69),string.char(65,77,65,84,69,85,82),string.char(84,82,65,73,78,69,69),string.char(66,69,71,73,78,78,69,82),string.char(83,76,79,87,80,79,75,69),string.char(83,76,69,69,80,89),string.char(67,76,85,77,83,89),string.char(68,79,82,75),string.char(78,69,82,68),string.char(71,69,69,75),string.char(68,87,69,69,66),string.char(83,81,85,73,83,72,89),string.char(87,79,66,66,76,89),string.char(70,85,90,90,89),string.char(83,80,65,82,75,76,89),string.char(71,73,71,71,76,89),string.char(87,73,71,71,76,89),string.char(83,78,65,73,76),string.char(84,85,82,84,76,69),string.char(80,65,78,68,65),string.char(83,76,79,84,72),string.char(77,79,79,83,69),string.char(72,65,77,83,84,69,82),string.char(80,85,80,80,89),string.char(75,73,84,84,69,78),string.char(68,85,67,75,76,73,78,71),string.char(80,69,78,71,85,73,78),string.char(78,65,82,87,72,65,76),string.char(80,76,65,84,89,80,85,83),string.char(67,65,80,89,66,65,82,65),string.char(65,76,80,65,67,65),string.char(82,65,67,67,79,79,78),string.char(83,81,85,73,82,82,69,76),string.char(79,84,84,69,82),string.char(66,69,65,86,69,82),string.char(72,69,68,71,69,72,79,71),string.char(77,69,69,82,75,65,84),string.char(70,69,82,82,69,84),string.char(66,85,78,78,89),string.char(67,72,73,80,77,85,78,75),string.char(80,85,70,70,73,78),string.char(84,79,85,67,65,78),string.char(70,76,65,77,73,78,71,79),string.char(77,65,78,65,84,69,69),string.char(87,65,76,82,85,83),string.char(80,69,76,73,67,65,78),string.char(83,69,65,71,85,76,76),string.char(80,73,71,69,79,78),string.char(83,80,65,82,82,79,87),string.char(82,79,66,73,78),string.char(70,73,78,67,72),string.char(87,82,69,78),string.char(77,65,71,80,73,69),string.char(67,82,79,87),string.char(82,65,86,69,78),string.char(83,84,65,82,76,73,78,71),string.char(83,87,65,76,76,79,87),string.char(77,65,82,84,73,78),string.char(83,87,73,70,84),string.char(68,79,86,69),string.char(81,85,65,73,76),string.char(80,72,69,65,83,65,78,84),string.char(84,85,82,75,69,89),string.char(68,85,67,75),string.char(67,72,73,67,75,69,78),string.char(82,79,79,83,84,69,82),string.char(80,65,82,82,79,84),string.char(77,65,67,65,87),string.char(67,79,67,75,65,84,79,79),string.char(66,85,68,71,73,69),string.char(67,65,78,65,82,89)}
local _0x4E38 = {string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(226,154,161),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189),string.char(226,156,168),string.char(239,191,189,239,191,189),string.char(239,191,189,239,191,189)}
local _0x175C =string.char(64)local _0x4D63 = 120
local _0xF9A6 = nil
local _0xEC6F = nil
local function _0xA42A()
if _0xC00E.ChatVersion ~= Enum.ChatVersion.TextChatService then return nil end
local _0xF999, _0x2D15 = pcall(function()
local _0x4E33 = _0xC00E:FindFirstChild(string.char(84,101,120,116,67,104,97,110,110,101,108,115))
if not _0x4E33 then return nil end
return _0x4E33:FindFirstChild(string.char(82,66,88,71,101,110,101,114,97,108)) or _0x4E33:GetChildren()[1]
end)
return _0xF999 and _0x2D15 or nil
end
local function _0xEC5E()
local _0xF999, _0x2D15 = pcall(function()
local _0x000B = _0x2083:FindFirstChild(string.char(68,101,102,97,117,108,116,67,104,97,116,83,121,115,116,101,109,67,104,97,116,69,118,101,110,116,115))
if _0x000B and _0x000B:FindFirstChild(string.char(83,97,121,77,101,115,115,97,103,101,82,101,113,117,101,115,116)) then return _0x000B.SayMessageRequest end
end)
return _0xF999 and _0x2D15 or nil
end
_0xA6C9 = function(tx)
if #tx > _0x3F08 then tx = tx:sub(1, _0x3F08) end
if _0xC00E.ChatVersion == Enum.ChatVersion.TextChatService then
if not _0xF9A6 or not _0xF9A6.Parent then _0xF9A6 = _0xA42A() end
if _0xF9A6 then local _0xF999 = pcall(function() _0xF9A6:SendAsync(tx) end); if _0xF999 then _0x50D5 =string.char(84,101,120,116,67,104,97,116); return true end end
end
if not _0xEC6F then _0xEC6F = _0xEC5E() end
if _0xEC6F then local _0xF999 = pcall(function() _0xEC6F:FireServer(tx,string.char(65,108,108)) end); if _0xF999 then _0x50D5 =string.char(76,101,103,97,99,121); return true end end
return false
end
local function _0x4917()
if math.random() > 0.75 then return""end
local _0x342C = math.random(1, 3)
local _0xF315 =""for _0x9094 = 1, _0x342C do
_0xF315 = _0xF315 .. _0x4E38[math.random(1, #_0x4E38)]
end
return _0xF315
end
local function _0x64B5()
if _0xC080 and _0xC080 ~=""then
local _0xFD82 = tostring(_0xC080):gsub(string.char(94,37,115,42,64,43,37,115,42),"")
local _0xD159 = _0x8324(_0xFD82, _0xA6AA)
if _0xD159 then
return (_0xD159.DisplayName ~=""and _0xD159.DisplayName) or _0xD159.Name
end
end
local _0x49D0 = _0xB894()
if _0x49D0 then
local _0xF999, _0xBF87 = pcall(function() return _0x49D0.DisplayName end)
if _0xF999 and _0xBF87 and _0xBF87 ~=""then return _0xBF87 end
local _0x6FD2, _0x394C = pcall(function() return _0x49D0.Name end)
if _0x6FD2 and _0x394C and _0x394C ~=""then return _0x394C end
end
if _0xC080 and _0xC080 ~=""then return (tostring(_0xC080):gsub(string.char(94,37,115,42,64,43,37,115,42),"")) end
return nil
end
local function _0x4276()
local _0xF315 =""for _0x9094 = 1, _0x4D63 do
_0xF315 = _0xF315 .. _0x175C
end
return _0xF315
end
_0x7154 = function()
if _0x546D ==string.char(109,101,115,115,97,103,101)then
return (_0x47FC ..string.char(32).. _0x48CA:upper() .. _0x4276() .. _0x4917()):sub(1, _0x3F08)
end
local _0x1224 = _0x64B5()
if not _0x1224 or _0x1224 ==""then _0x1224 = _0xC080 end
if not _0x1224 or _0x1224 ==""then _0x1224 =string.char(101,118,101,114,121,111,110,101)end
_0x1224 = tostring(_0x1224):gsub(string.char(94,37,115,42,64,43,37,115,42),"")
local _0xA776 =string.char(64).. _0x1224 .. _0xB53F .. _0x6939[math.random(1, #_0x6939)]
return (_0x47FC ..string.char(32).. _0x4276() ..string.char(32).. _0xA776:upper() .. _0x4917()):sub(1, _0x3F08)
end
endlocal _0xA00F = nil
_0x5DAB = {
AlwaysOnCore = true,Void = { enabled = false, alwaysOn = true, charAdded = nil, healthConns = {}, charConns = {}, loopConn = nil, steppedConn = nil, safetyFloor = nil, rescues = 0, startFn = nil, stopFn = nil },
InfFallVoid = { enabled = false, alwaysOn = true, steppedConn = nil, startFn = nil, stopFn = nil },
Lag = { enabled = false, alwaysOn = true, wsDescConn = nil, loopConn = nil, purgedItems = 0, throttledEmitters = setmetatable({}, {__mode =string.char(107)}), startFn = nil, stopFn = nil },
Kill = { enabled = false, charAdded = nil, descConn = nil, loopConn = nil, wsDescConn = nil, blockedTouches = 0, originalPartFlags = setmetatable({}, {__mode =string.char(107)}), startFn = nil, stopFn = nil },
GamePaused = { enabled = false, alwaysOn = true, childAdded = nil, propConn = nil, loopConn = nil, startFn = nil, stopFn = nil },
AFK = { enabled = false, conn = nil, loopConn = nil, startFn = nil, stopFn = nil },
VC = {
enabled = false,
running = false,
userMuted = false,
hookInstalled = false,
blockedMutes = 0,
rejoins = 0,
watchdogConn = nil,
stateConn = nil,
statusText =string.char(83,116,97,116,117,115,58,32,73,100,108,101),
statusLbl = nil,
activateBtn = nil,
_0x3185 = nil,
micToggleBtn = nil,
_0xFBCF = nil,
rowSubLbl = nil,
_0xA067 = nil,
openPanelFn = nil,
startFn = nil,
stopFn = nil,
forceBypassFn = nil,
toggleMicFn = nil,
rejoinFn = nil,
},
Redirect = { enabled = false, startFn = nil, stopFn = nil },
PauseTrap = { enabled = false, startFn = nil, stopFn = nil },
FlingShield = { enabled = false, steppedConn = nil, heartbeatConn = nil, plrAddedConn = nil, preStepCF = nil, blockedFlings = 0, startFn = nil, stopFn = nil },Ragdoll = { enabled = false, alwaysOn = true, steppedConn = nil, stateConn = nil, descConn = nil, charAdded = nil, recoveries = 0, lastDeepCleanse = 0, startFn = nil, stopFn = nil },
Anchor = { enabled = false, alwaysOn = true, steppedConn = nil, descConn = nil, charAdded = nil, partConns = setmetatable({}, {__mode =string.char(107)}), purgedMovers = 0, lastMoverSweep = 0, startFn = nil, stopFn = nil },
Attach = { enabled = false, steppedConn = nil, descConn = nil, severedCount = 0, startFn = nil, stopFn = nil },
Blind = { enabled = false, loopConn = nil, lightChildConn = nil, camChildConn = nil, guiChildConn = nil, startFn = nil, stopFn = nil },
Bring = { enabled = false, steppedConn = nil, heartbeatConn = nil, lastCF = nil, lastSafeTime = 0, blockedBrings = 0, startFn = nil, stopFn = nil },
SeatTrap = { enabled = false, alwaysOn = true, wsDescConn = nil, loopConn = nil, savedSeats = setmetatable({}, {__mode =string.char(107)}), neutralizedSeats = 0, startFn = nil, stopFn = nil },
ToolGuard = { enabled = false, loopConn = nil, disarmedTools = 0, startFn = nil, stopFn = nil },
AntiHeadsit = { enabled = false, steppedConn = nil, evadedCount = 0, lastEvade = 0, startFn = nil, stopFn = nil },
GlitchDesync = { enabled = false, _0xA3C6 =string.char(78,111,114,109,97,108), steppedConn = nil, heartbeatConn = nil, realCF = nil, realVel = Vector3.zero, realRot = Vector3.zero, startFn = nil, stopFn = nil },
Kick = { enabled = false, hooked = false, originalKick = nil, blockedKicks = 0, startFn = nil, stopFn = nil },
enableAll = nil,
disableAll = nil,
enforceAlwaysOn = nil,
}
local _0x7DE1 = {
enabled = false,
_0xA3C6 =string.char(71,111,100,77,97,116,114,105,120),
range = 7.5,
deflectCount = 0,
lastAttackerName =string.char(78,111,110,101),
lastThreatReason =string.char(83,116,97,110,100,98,121),
modes = {string.char(71,111,100,77,97,116,114,105,120),string.char(82,101,118,101,114,115,101,70,108,105,110,103),string.char(86,111,105,100,80,97,117,115,101),string.char(82,101,100,105,114,101,99,116),string.char(66,108,97,99,107,104,111,108,101),string.char(83,107,121,79,114,98,105,116)},
modeLabels = {
GodMatrix =string.char(71,79,68,32,77,65,84,82,73,88,32,226,154,161),
ReverseFling =string.char(82,69,86,69,82,83,69,32,70,76,73,78,71,32,239,191,189,239,191,189,239,184,143),
VoidPause =string.char(86,79,73,68,45,80,65,85,83,69,32,226,157,132,239,184,143),
Redirect =string.char(82,69,68,73,82,69,67,84,32,239,191,189,239,191,189),
Blackhole =string.char(66,76,65,67,75,72,79,76,69,32,239,191,189,239,191,189),
SkyOrbit =string.char(83,75,89,32,79,82,66,73,84,32,239,191,189,239,191,189),
},
ranges = { 5.0, 7.5, 11.0, 16.0, 22.0 },
rangeIdx = 2,
lastDeflect = 0,
startFn = nil,
stopFn = nil,
}_0x363C = function(_0x5685)
_0x02BF.lastTeleportTick = tick()
if _0x5685 then
_0x5DAB.Bring.lastCF = _0x5685
_0x5DAB.Bring.lastSafeTime = tick()
_0x5DAB.FlingShield.preStepCF = _0x5685
if _0x5DAB.GlitchDesync and _0x5DAB.GlitchDesync.enabled then
_0x5DAB.GlitchDesync.realCF = _0x5685
end
_0x7067 = _0x5685
end
end;(function()local _0xFC7F, _0xC54C, _0xA25E, _0x0606, _0x0E9F, _0xC838, _0x486A, _0xF12C, _0x879F, _0x559B
local _0xE9DA, _0x8C2F, _0xE1A6, _0x708D, _0x557D, _0x3D9F, _0x2D4F, _0xA4A6
local _0x8E13, _0xE011, _0xC237, _0x7E9F, _0xA023, _0xDCCA, _0x91B8, _0x1419
local _0x9887, _0x41CA, _0xFE3D, _0x8024, _0x4D8B, _0x65FFlocal function _0x0CCA(_0x41D2, customY)
local _0x1957 = _0x5DAB.Void.safetyFloor
if not _0x1957 or not _0x1957.Parent then
_0x1957 = Instance.new(string.char(80,97,114,116))
_0x1957.Name =string.char(75,104,97,109,97,110,86,111,105,100,83,97,102,101,116,121,70,108,111,111,114)_0x1957.Anchored = true
_0x1957.CanCollide = true
_0x1957.CanTouch = false
_0x1957.CanQuery = false
_0x1957.Locked = true
_0x1957.Size = Vector3.new(2048, 2, 2048)
_0x1957.Transparency = 0.72
_0x1957.Material = Enum.Material.ForceField
_0x1957.Color = Color3.fromRGB(250, 204, 21)
_0x1957.Parent = workspace
_0x5DAB.Void.safetyFloor = _0x1957
end
_0x1957.CFrame = CFrame.new(_0x41D2.X, customY or (_0x41D2.Y - 3.5), _0x41D2.Z)
end
local function _0xFA7D()
if _0x5DAB.Void.safetyFloor then
pcall(function() _0x5DAB.Void.safetyFloor:Destroy() end)
_0x5DAB.Void.safetyFloor = nil
end
end
local function _0x8002(_0xA077)
if not _0xA077 or not _0xA077.Parent then return end
pcall(function()
_0xA077:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
_0xA077:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
_0xA077:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
_0xA077:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
if _0xA077.MaxHealth <= 0 then _0xA077.MaxHealth = 100 end
if _0xA077.Health <= 0 or _0xA077.Health < _0xA077.MaxHealth then _0xA077.Health = _0xA077.MaxHealth end
if not _0x1B4F() and not (_0x02BF and _0x02BF.fly) then
if _0xA077.PlatformStand then _0xA077.PlatformStand = false end
if _0xA077.Sit then _0xA077.Sit = false end
end
if _0xA077:GetState() == Enum.HumanoidStateType.Dead then
_0xA077:ChangeState(Enum.HumanoidStateType.Running)
end
end)
end
local function _0x738B(_0xA077)
if not _0xA077 or not _0xA077.Parent then return end
_0x8002(_0xA077)
table.insert(_0x5DAB.Void.healthConns, _0xA077.HealthChanged:Connect(function(hp)
if _0x5DAB.Void.enabled and hp < _0xA077.MaxHealth then
task.defer(function() _0x8002(_0xA077) end)
end
end))
table.insert(_0x5DAB.Void.healthConns, _0xA077.StateChanged:Connect(function(_0x9094, newState)
if _0x5DAB.Void.enabled and newState == Enum.HumanoidStateType.Dead then
_0x8002(_0xA077)
end
end))
end
local function _0x7FFA(_0x4E33)
if not _0x4E33 then return end
for _0x9094, x in ipairs(_0x5DAB.Void.charConns) do pcall(function() x:Disconnect() end) end
_0x5DAB.Void.charConns = {}
for _0x9094, x in ipairs(_0x5DAB.Void.healthConns) do pcall(function() x:Disconnect() end) end
_0x5DAB.Void.healthConns = {}
local _0xA778 = _0x4E33:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA778 then _0x738B(_0xA778) end
table.insert(_0x5DAB.Void.charConns, _0x4E33.ChildAdded:Connect(function(_0x7B2F)
if _0x7B2F:IsA(string.char(72,117,109,97,110,111,105,100)) then _0x738B(_0x7B2F) end
end))
end
_0xFC7F = function(silent)
if _0x5DAB.Void.enabled and _0x5DAB.Void.steppedConn and _0x5DAB.Void.loopConn then return end
_0x5DAB.Void.enabled = true
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
_0x7FFA(_0xA6AA.Character)
if _0x5DAB.Void.charAdded then _0x5DAB.Void.charAdded:Disconnect() end
_0x5DAB.Void.charAdded = _0xA6AA.CharacterAdded:Connect(function(_0x4E33)
if not _0x5DAB.Void.enabled then return end
task.wait(0.1)
_0x7FFA(_0x4E33)
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
end)
if _0x5DAB.Void.steppedConn then _0x5DAB.Void.steppedConn:Disconnect() end
_0x5DAB.Void.steppedConn = _0xC77A.Stepped:Connect(function()
if not _0x5DAB.Void.enabled then return end
if workspace.FallenPartsDestroyHeight == workspace.FallenPartsDestroyHeight then
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
end
local _0x4E33 = _0xA6AA.Character
local _0x5CFE = _0x4DA4(_0x4E33)
if not _0x5CFE or _0x1B4F() or _0x1978 or (_0xAE44 and _0xAE44.rewinding) then
return
end
local _0x41D2 = _0x5CFE.Position
local _0x6355 = _0x5CFE.AssemblyLinearVelocity
local _0x2585 = math.max(_0x8668 + 55, -180)
local _0x221A = _0x41D2.Y + (_0x6355.Y * 0.055)
if _0x41D2.Y <= _0x2585 or _0x221A <= _0x2585 or (_0x41D2.Y <= (_0x2585 + 45) and _0x6355.Y < -95) or _0x41D2.Magnitude > 45000 then
_0x5CFE.AssemblyLinearVelocity = Vector3.new(_0x6355.X * 0.05, math.max(0, _0x6355.Y), _0x6355.Z * 0.05)
_0x5CFE.AssemblyAngularVelocity = Vector3.zero
_0x0CCA(_0x41D2, math.max(_0x41D2.Y - 3.5, _0x2585 + 12))
_0x5DAB.Void.rescues = _0x5DAB.Void.rescues + 1
_0x363C(_0x7067)
_0xDF2E(_0x4E33, _0x7067)
elseif _0x5DAB.Void.safetyFloor and _0x41D2.Y > -15 and math.abs(_0x6355.Y) < 25 then
_0xFA7D()
end
end)
if _0x5DAB.Void.loopConn then _0x5DAB.Void.loopConn:Disconnect() end
local _0x747C = 0
_0x5DAB.Void.loopConn = _0xC77A.Heartbeat:Connect(function()
if not _0x5DAB.Void.enabled then return end
local _0x60A3 = tick()
if _0x60A3 - _0x747C < 0.35 then return end
_0x747C = _0x60A3
local _0x4E33 = _0xA6AA.Character
if not _0x4E33 then return end
local _0xA077 = _0x4E33:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA077 and _0xA077.Health < _0xA077.MaxHealth then _0x8002(_0xA077) end
end)
if _0xA00F then pcall(_0xA00F) end
if not silent then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,86,111,105,100,32,118,52,32,40,65,108,119,97,121,115,45,79,110,32,50,48,52,56,120,50,48,52,56,32,70,108,111,111,114,32,43,32,67,97,116,99,104,41,32,65,67,84,73,86,69))
_0xF140()
end
end
_0xC54C = function()
if _0x5DAB.AlwaysOnCore or _0x5DAB.Void.alwaysOn then
_0xFC7F(true)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(239,191,189,239,191,189,32,65,110,116,105,45,86,111,105,100,32,105,115,32,108,111,99,107,101,100,32,65,76,87,65,89,83,45,79,78,32,102,111,114,32,112,101,114,109,97,110,101,110,116,32,112,114,111,116,101,99,116,105,111,110,33))
return
end
if not _0x5DAB.Void.enabled then return end
_0x5DAB.Void.enabled = false
if _0x5DAB.Void.charAdded then _0x5DAB.Void.charAdded:Disconnect(); _0x5DAB.Void.charAdded = nil end
if _0x5DAB.Void.steppedConn then _0x5DAB.Void.steppedConn:Disconnect(); _0x5DAB.Void.steppedConn = nil end
if _0x5DAB.Void.loopConn then _0x5DAB.Void.loopConn:Disconnect(); _0x5DAB.Void.loopConn = nil end
for _0x9094, x in ipairs(_0x5DAB.Void.charConns) do pcall(function() x:Disconnect() end) end
_0x5DAB.Void.charConns = {}
for _0x9094, x in ipairs(_0x5DAB.Void.healthConns) do pcall(function() x:Disconnect() end) end
_0x5DAB.Void.healthConns = {}
_0xFA7D()
if _0xA00F then pcall(_0xA00F) end
end
_0x5DAB.Void.startFn = _0xFC7F
_0x5DAB.Void.stopFn = _0xC54C_0x5DAB.InfFallVoid.startFn = function(silent)
if _0x5DAB.InfFallVoid.enabled then return end
_0x5DAB.InfFallVoid.enabled = true
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
if _0xA00F then pcall(_0xA00F) end
if not silent then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(73,110,102,105,110,105,116,101,32,70,97,108,108,32,86,111,105,100,32,79,78,32,40,70,97,108,108,101,110,80,97,114,116,115,68,101,115,116,114,111,121,72,101,105,103,104,116,32,61,32,78,97,78,41))
_0xF140()
end
end
_0x5DAB.InfFallVoid.stopFn = function()
if _0x5DAB.AlwaysOnCore or _0x5DAB.InfFallVoid.alwaysOn then
_0x5DAB.InfFallVoid.startFn(true)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(239,191,189,239,191,189,32,73,110,102,105,110,105,116,101,32,70,97,108,108,32,86,111,105,100,32,105,115,32,108,111,99,107,101,100,32,65,76,87,65,89,83,45,79,78,33))
return
end
_0x5DAB.InfFallVoid.enabled = false
if _0xA00F then pcall(_0xA00F) end
endlocal _0x6392 = {
ParticleEmitter = true,
Trail = true,
Beam = true,
Smoke = true,
Fire = true,
Sparkles = true,
}
local function _0x19EB(_0x4A72)
if not _0x4A72 or not _0x4A72.Parent then return end
if _0xF28E and _0x4A72:IsDescendantOf(_0xF28E) then return end
local _0x9D92 = _0x4A72.ClassName
if _0x6392[_0x9D92] then
local _0x1213 = _0xA6AA.Character
if not (_0x1213 and _0x4A72:IsDescendantOf(_0x1213)) then
pcall(function()
if _0x4A72.Enabled then
_0x4A72.Enabled = false
_0x5DAB.Lag.throttledEmitters[_0x4A72] = true
_0x5DAB.Lag.purgedItems = (_0x5DAB.Lag.purgedItems or 0) + 1
end
if _0x9D92 ==string.char(80,97,114,116,105,99,108,101,69,109,105,116,116,101,114)and _0x4A72.Rate > 12 then
_0x4A72.Rate = 0
end
end)
end
elseif _0x9D92 ==string.char(69,120,112,108,111,115,105,111,110)then
pcall(function()
_0x4A72.BlastPressure = 0
_0x4A72.BlastRadius = 0
_0x4A72.DestroyJointRadiusPercent = 0
_0x4A72.Visible = false
_0x5DAB.Lag.purgedItems = (_0x5DAB.Lag.purgedItems or 0) + 1
end)
elseif _0x9D92 ==string.char(80,111,105,110,116,76,105,103,104,116)or _0x9D92 ==string.char(83,117,114,102,97,99,101,76,105,103,104,116)or _0x9D92 ==string.char(83,112,111,116,76,105,103,104,116)then
pcall(function()
if _0x4A72.Shadows then _0x4A72.Shadows = false end
end)
elseif _0x4A72:IsA(string.char(66,97,115,101,80,97,114,116)) then
local _0x1CEE = _0x4A72.Parent
if _0x1CEE and (_0x1CEE:IsA(string.char(84,111,111,108)) or _0x1CEE:IsA(string.char(65,99,99,101,115,115,111,114,121)) or _0x1CEE:IsA(string.char(72,97,116))) and _0x1CEE.Parent == workspace then
pcall(function()
if _0x4A72.CanTouch then _0x4A72.CanTouch = false end
if _0x4A72.CanCollide then _0x4A72.CanCollide = false end
_0x4A72.Massless = true
_0x5DAB.Lag.purgedItems = (_0x5DAB.Lag.purgedItems or 0) + 1
end)
end
end
end
_0xFE3D = function(silent)
if _0x5DAB.Lag.enabled and _0x5DAB.Lag.wsDescConn and _0x5DAB.Lag.loopConn then return end
_0x5DAB.Lag.enabled = true
pcall(function()
local _0x0E3D = game:GetService(string.char(76,105,103,104,116,105,110,103))
_0x0E3D.GlobalShadows = false
end)
if _0x5DAB.Lag.wsDescConn then _0x5DAB.Lag.wsDescConn:Disconnect() end
_0x5DAB.Lag.wsDescConn = workspace.DescendantAdded:Connect(function(_0x4A72)
if not _0x5DAB.Lag.enabled then return end
_0x19EB(_0x4A72)
end)
if _0x5DAB.Lag.loopConn then _0x5DAB.Lag.loopConn:Disconnect() end
local _0x619B = 0
_0x5DAB.Lag.loopConn = _0xC77A.Heartbeat:Connect(function()
if not _0x5DAB.Lag.enabled then return end
local _0x60A3 = tick()
if _0x60A3 - _0x619B < 2.5 then return end
_0x619B = _0x60A3
local _0xA3AD = 0
for _0x9094, child in ipairs(workspace:GetChildren()) do
if child:IsA(string.char(84,111,111,108)) or child:IsA(string.char(65,99,99,101,115,115,111,114,121)) or child:IsA(string.char(72,97,116)) then
for _0x9094, _0x000B in ipairs(child:GetDescendants()) do
if _0x000B:IsA(string.char(66,97,115,101,80,97,114,116)) then
if _0x000B.CanTouch then _0x000B.CanTouch = false end
if _0x000B.CanCollide then _0x000B.CanCollide = false end
elseif _0x6392[_0x000B.ClassName] and _0x000B.Enabled then
_0x000B.Enabled = false
end
end
elseif child:IsA(string.char(83,111,117,110,100)) and child.IsPlaying then
_0xA3AD = _0xA3AD + 1
if _0xA3AD > 16 then
pcall(function() child:Stop() end)
_0x5DAB.Lag.purgedItems = (_0x5DAB.Lag.purgedItems or 0) + 1
end
end
end
for _0x975E, _0x9094 in pairs(_0xA9FC) do
if not _0xC3F7:GetPlayerByUserId(_0x975E) then
_0xA9FC[_0x975E] = nil
end
end
end)
if _0xA00F then pcall(_0xA00F) end
if not silent then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,76,97,103,32,118,52,32,40,65,108,119,97,121,115,45,79,110,32,80,97,114,116,105,99,108,101,47,67,108,111,110,101,45,66,111,109,98,32,80,117,114,103,101,114,41,32,65,67,84,73,86,69))
_0xF140()
end
end
_0x8024 = function()
if _0x5DAB.AlwaysOnCore or _0x5DAB.Lag.alwaysOn then
_0xFE3D(true)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(239,191,189,239,191,189,32,65,110,116,105,45,76,97,103,32,105,115,32,108,111,99,107,101,100,32,65,76,87,65,89,83,45,79,78,32,102,111,114,32,109,97,120,32,70,80,83,32,38,32,99,114,97,115,104,32,112,114,111,116,101,99,116,105,111,110,33))
return
end
if not _0x5DAB.Lag.enabled then return end
_0x5DAB.Lag.enabled = false
if _0x5DAB.Lag.wsDescConn then _0x5DAB.Lag.wsDescConn:Disconnect(); _0x5DAB.Lag.wsDescConn = nil end
if _0x5DAB.Lag.loopConn then _0x5DAB.Lag.loopConn:Disconnect(); _0x5DAB.Lag.loopConn = nil end
if _0xA00F then pcall(_0xA00F) end
end
_0x5DAB.Lag.startFn = _0xFE3D
_0x5DAB.Lag.stopFn = _0x8024local function _0x3D9D(_0x1CEE)
if not (_0x1CEE and _0x1CEE:IsA(string.char(66,97,115,101,80,97,114,116))) then return end
local _0xBC73 = _0x5DAB.Kill.originalPartFlags[_0x1CEE]
if not _0xBC73 then
_0xBC73 = { CanTouch = _0x1CEE.CanTouch, CanQuery = _0x1CEE.CanQuery }
_0x5DAB.Kill.originalPartFlags[_0x1CEE] = _0xBC73
end
pcall(function()
if _0x1CEE.CanTouch then _0x1CEE.CanTouch = false end
if _0x1CEE.CanQuery then _0x1CEE.CanQuery = false end
end)
end
local function _0xEC2D(_0x5BFE)
if not _0x5BFE then return end
for _0x9094, _0x1CEE in ipairs(_0x04D0(_0x5BFE)) do
_0x3D9D(_0x1CEE)
end
pcall(function()
if not _0x5BFE:FindFirstChild(string.char(95,95,75,104,97,109,97,110,71,111,100,70,111,114,99,101,70,105,101,108,100)) then
local _0xCC58 = Instance.new(string.char(70,111,114,99,101,70,105,101,108,100))
_0xCC58.Name =string.char(95,95,75,104,97,109,97,110,71,111,100,70,111,114,99,101,70,105,101,108,100)_0xCC58.Visible = false
_0xCC58.Parent = _0x5BFE
end
end)
local _0xA778 = _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA778 then
pcall(function()
_0xA778:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
if _0xA778.MaxHealth <= 0 then _0xA778.MaxHealth = 100 end
if _0xA778.Health <= 0 or _0xA778.Health < _0xA778.MaxHealth then
_0xA778.Health = _0xA778.MaxHealth
end
end)
end
end
local function _0x63D8(_0x5BFE)
if _0x5DAB.Kill.descConn then _0x5DAB.Kill.descConn:Disconnect(); _0x5DAB.Kill.descConn = nil end
if not _0x5BFE then return end
_0xEC2D(_0x5BFE)
_0x5DAB.Kill.descConn = _0x5BFE.DescendantAdded:Connect(function(_0x4A72)
if _0x5DAB.Kill.enabled and _0x4A72:IsA(string.char(66,97,115,101,80,97,114,116)) then _0x3D9D(_0x4A72) end
end)
end
_0xA25E = function()
if _0x5DAB.Kill.enabled then return end
_0x5DAB.Kill.enabled = true
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
_0x63D8(_0xA6AA.Character)
if _0x5DAB.Kill.charAdded then _0x5DAB.Kill.charAdded:Disconnect() end
_0x5DAB.Kill.charAdded = _0xA6AA.CharacterAdded:Connect(function(_0x4E33)
if not _0x5DAB.Kill.enabled then return end
task.wait(0.15)
_0x63D8(_0x4E33)
end)
if _0x5DAB.Kill.wsDescConn then _0x5DAB.Kill.wsDescConn:Disconnect() end
_0x5DAB.Kill.wsDescConn = workspace.DescendantAdded:Connect(function(_0x4A72)
if not _0x5DAB.Kill.enabled then return end
if _0x4A72:IsA(string.char(69,120,112,108,111,115,105,111,110)) then
pcall(function()
_0x4A72.BlastPressure = 0
_0x4A72.BlastRadius = 0
_0x4A72.DestroyJointRadiusPercent = 0
end)
end
end)
if _0x5DAB.Kill.loopConn then _0x5DAB.Kill.loopConn:Disconnect() end
_0x5DAB.Kill.loopConn = _0xC77A.Stepped:Connect(function()
if not _0x5DAB.Kill.enabled then return end
local _0x4E33 = _0xA6AA.Character
if not _0x4E33 then return end
for _0x9094, _0x1CEE in ipairs(_0x04D0(_0x4E33)) do
if _0x1CEE.Parent then
if _0x1CEE.CanTouch then _0x1CEE.CanTouch = false end
if _0x1CEE.CanQuery then _0x1CEE.CanQuery = false end
end
end
local _0xA778 = _0x4E33:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA778 and _0xA778.Health > 0 and _0xA778.Health < _0xA778.MaxHealth then
pcall(function() _0xA778.Health = _0xA778.MaxHealth end)
end
end)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,75,105,108,108,32,47,32,71,111,100,45,77,111,100,101,32,118,51,32,40,84,111,117,99,104,32,83,104,105,101,108,100,32,43,32,70,111,114,99,101,70,105,101,108,100,32,43,32,66,108,97,115,116,32,73,109,109,117,110,105,116,121,41,32,79,78))
_0xF140()
end
_0x0606 = function()
if not _0x5DAB.Kill.enabled then return end
_0x5DAB.Kill.enabled = false
if _0x5DAB.Kill.charAdded then _0x5DAB.Kill.charAdded:Disconnect(); _0x5DAB.Kill.charAdded = nil end
if _0x5DAB.Kill.descConn then _0x5DAB.Kill.descConn:Disconnect(); _0x5DAB.Kill.descConn = nil end
if _0x5DAB.Kill.wsDescConn then _0x5DAB.Kill.wsDescConn:Disconnect(); _0x5DAB.Kill.wsDescConn = nil end
if _0x5DAB.Kill.loopConn then _0x5DAB.Kill.loopConn:Disconnect(); _0x5DAB.Kill.loopConn = nil end
for _0x5959, _0xBC73 in pairs(_0x5DAB.Kill.originalPartFlags) do
if _0x5959 and _0x5959.Parent then
pcall(function()
_0x5959.CanTouch = _0xBC73.CanTouch
_0x5959.CanQuery = _0xBC73.CanQuery
end)
end
_0x5DAB.Kill.originalPartFlags[_0x5959] = nil
end
local _0x4E33 = _0xA6AA.Character
if _0x4E33 then
local _0xCC58 = _0x4E33:FindFirstChild(string.char(95,95,75,104,97,109,97,110,71,111,100,70,111,114,99,101,70,105,101,108,100))
if _0xCC58 then pcall(function() _0xCC58:Destroy() end) end
local _0xA778 = _0x4E33:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA778 and not (_0x5DAB.Void and _0x5DAB.Void.enabled) then
pcall(function() _0xA778:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end)
end
end
if not (_0x5DAB.AlwaysOnCore or (_0x5DAB.Void and _0x5DAB.Void.enabled) or (_0x5DAB.InfFallVoid and _0x5DAB.InfFallVoid.enabled)) and not _0x243A.active and not _0xF3B0 then
pcall(function() workspace.FallenPartsDestroyHeight = _0x8668 end)
end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,75,105,108,108,32,100,105,115,97,98,108,101,100,32,38,32,112,97,114,116,32,102,108,97,103,115,32,114,101,115,116,111,114,101,100))
_0xED6E()
end
_0x5DAB.Kill.startFn = _0xA25E
_0x5DAB.Kill.stopFn = _0x0606local function _0xF473()
pcall(function()
game:GetService(string.char(71,117,105,83,101,114,118,105,99,101)):SetGameplayPausedNotificationEnabled(false)
end)
pcall(function()
if _0xA6AA.GameplayPaused then _0xA6AA.GameplayPaused = false end
end)
pcall(function()
local _0xC59D = _0x6B21 and _0x6B21:FindFirstChild(string.char(82,111,98,108,111,120,71,117,105))
if _0xC59D then
local _0x644A = _0xC59D:FindFirstChild(string.char(67,111,114,101,83,99,114,105,112,116,115,47,78,101,116,119,111,114,107,80,97,117,115,101))
if _0x644A then _0x644A:Destroy() end
end
end)
end
_0x0E9F = function(silent)
if _0x5DAB.GamePaused.enabled and _0x5DAB.GamePaused.loopConn then return end
_0x5DAB.GamePaused.enabled = true
_0xF473()
pcall(function()
local _0xC59D = _0x6B21 and _0x6B21:FindFirstChild(string.char(82,111,98,108,111,120,71,117,105))
if _0xC59D then
if _0x5DAB.GamePaused.childAdded then _0x5DAB.GamePaused.childAdded:Disconnect() end
_0x5DAB.GamePaused.childAdded = _0xC59D.ChildAdded:Connect(function(_0x4A72)
if _0x5DAB.GamePaused.enabled and _0x4A72.Name:find(string.char(78,101,116,119,111,114,107,80,97,117,115,101)) then
pcall(function() _0x4A72:Destroy() end)
end
end)
end
end)
if _0x5DAB.GamePaused.propConn then _0x5DAB.GamePaused.propConn:Disconnect() end
pcall(function()
_0x5DAB.GamePaused.propConn = _0xA6AA:GetPropertyChangedSignal(string.char(71,97,109,101,112,108,97,121,80,97,117,115,101,100)):Connect(function()
if _0x5DAB.GamePaused.enabled then
pcall(function() _0xA6AA.GameplayPaused = false end)
_0xF473()
end
end)
end)
if _0x5DAB.GamePaused.loopConn then _0x5DAB.GamePaused.loopConn:Disconnect() end
_0x5DAB.GamePaused.loopConn = _0xC77A.Heartbeat:Connect(function()
if not _0x5DAB.GamePaused.enabled then return end
if _0xA6AA.GameplayPaused then
pcall(function() _0xA6AA.GameplayPaused = false end)
end
end)
if _0xA00F then pcall(_0xA00F) end
if not silent then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,71,97,109,101,112,108,97,121,80,97,117,115,101,100,32,47,32,65,110,116,105,45,70,114,101,101,122,101,32,118,52,32,65,67,84,73,86,69))
_0xF140()
end
end
_0xC838 = function()
if _0x5DAB.AlwaysOnCore or _0x5DAB.GamePaused.alwaysOn then
_0x0E9F(true)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(239,191,189,239,191,189,32,65,110,116,105,45,71,97,109,101,112,108,97,121,80,97,117,115,101,100,32,105,115,32,108,111,99,107,101,100,32,65,76,87,65,89,83,45,79,78,33))
return
end
if not _0x5DAB.GamePaused.enabled then return end
_0x5DAB.GamePaused.enabled = false
if _0x5DAB.GamePaused.childAdded then _0x5DAB.GamePaused.childAdded:Disconnect(); _0x5DAB.GamePaused.childAdded = nil end
if _0x5DAB.GamePaused.propConn then _0x5DAB.GamePaused.propConn:Disconnect(); _0x5DAB.GamePaused.propConn = nil end
if _0x5DAB.GamePaused.loopConn then _0x5DAB.GamePaused.loopConn:Disconnect(); _0x5DAB.GamePaused.loopConn = nil end
if _0xA00F then pcall(_0xA00F) end
end
_0x5DAB.GamePaused.startFn = _0x0E9F
_0x5DAB.GamePaused.stopFn = _0xC838local function _0xB998()
pcall(function()
local _0xADAD = game:GetService(string.char(86,105,114,116,117,97,108,85,115,101,114))
_0xADAD:CaptureController()
_0xADAD:ClickButton2(Vector2.zero, workspace.CurrentCamera and workspace.CurrentCamera.CFrame or CFrame.new())
end)
pcall(function()
local _0xB22E = game:GetService(string.char(86,105,114,116,117,97,108,73,110,112,117,116,77,97,110,97,103,101,114))
_0xB22E:SendMouseMoveEvent(1, 1, game)
end)
end
_0x486A = function()
if _0x5DAB.AFK.enabled then return end
_0x5DAB.AFK.enabled = true
pcall(function()
if getconnections then
for _0x9094, _0x4E33 in ipairs(getconnections(_0xA6AA.Idled)) do
pcall(function() _0x4E33:Disable() end)
pcall(function() _0x4E33:Disconnect() end)
end
end
end)
if _0x5DAB.AFK.conn then _0x5DAB.AFK.conn:Disconnect() end
_0x5DAB.AFK.conn = _0xA6AA.Idled:Connect(function()
if not _0x5DAB.AFK.enabled then return end
_0xB998()
end)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,65,70,75,32,118,51,32,40,77,117,108,116,105,45,72,111,111,107,41,32,79,78))
_0xF140()
end
_0xF12C = function()
if not _0x5DAB.AFK.enabled then return end
_0x5DAB.AFK.enabled = false
if _0x5DAB.AFK.conn then _0x5DAB.AFK.conn:Disconnect(); _0x5DAB.AFK.conn = nil end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,65,70,75,32,100,105,115,97,98,108,101,100))
_0xED6E()
end
_0x5DAB.AFK.startFn = _0x486A
_0x5DAB.AFK.stopFn = _0xF12Clocal _0xD5AF =string.char(114,98,120,97,115,115,101,116,58,47,47,116,101,120,116,117,114,101,115,47,117,105,47,86,111,105,99,101,67,104,97,116,47,77,105,99,76,105,103,104,116,47,77,117,116,101,100,46,112,110,103)local _0x6659 =string.char(114,98,120,97,115,115,101,116,58,47,47,116,101,120,116,117,114,101,115,47,117,105,47,86,111,105,99,101,67,104,97,116,47,77,105,99,76,105,103,104,116,47,85,110,109,117,116,101,100,46,112,110,103)local _0xC563 = nil
local function _0x4506(_0x43E0)
if not _0x43E0 then return nil end
local _0xF999, _0x2D15 = pcall(function()
local _0x3FBB = _0x43E0:FindFirstChild(string.char(73,110,116,101,103,114,97,116,105,111,110,73,99,111,110,70,114,97,109,101), true) or _0x43E0:WaitForChild(string.char(73,110,116,101,103,114,97,116,105,111,110,73,99,111,110,70,114,97,109,101), 1.5)
local _0x5E4C = _0x3FBB and (_0x3FBB:FindFirstChild(string.char(73,110,116,101,103,114,97,116,105,111,110,73,99,111,110), true) or _0x3FBB:WaitForChild(string.char(73,110,116,101,103,114,97,116,105,111,110,73,99,111,110), 1.5))
return _0x5E4C and (_0x5E4C:FindFirstChild(string.char(49)) or _0x5E4C:FindFirstChildWhichIsA(string.char(73,109,97,103,101,76,97,98,101,108)))
end)
if _0xF999 and _0x2D15 then return _0x2D15 end
for _0x9094, _0x000B in ipairs(_0x43E0:GetDescendants()) do
if _0x000B:IsA(string.char(73,109,97,103,101,76,97,98,101,108)) and (_0x000B.Name ==string.char(49)or _0x000B.Name:lower():find(string.char(105,99,111,110), 1, true) or _0x000B.Image:lower():find(string.char(118,111,105,99,101,99,104,97,116), 1, true) or _0x000B.Image:lower():find(string.char(109,105,99), 1, true)) then
return _0x000B
end
end
return nil
end
local function _0x6CFB(_0xFA91)
if not _0xFA91 then return nil, nil end
local _0x78E5 = nil
pcall(function()
for _0x9094, _0x324B in ipairs(_0xFA91:GetDescendants()) do
if _0x324B.Name ==string.char(116,111,103,103,108,101,95,109,105,99,95,109,117,116,101)then
_0x78E5 = _0x324B
break
end
end
if not _0x78E5 then
for _0x9094, _0x324B in ipairs(_0xFA91:GetDescendants()) do
if _0x324B.Name ==string.char(73,99,111,110,72,105,116,65,114,101,97,95,116,111,103,103,108,101,95,109,105,99,95,109,117,116,101)and _0x324B.Parent then
_0x78E5 = _0x324B.Parent
break
end
end
end
end)
return _0x78E5, (_0x78E5 and _0x78E5.Parent or nil)
end
local function _0xB9AF(statusStr, statusCol, btnStr)
_0x5DAB.VC.statusText = statusStr or _0x5DAB.VC.statusText
local _0xA45D = _0x5DAB.VC.userMuted andstring.char(239,191,189,239,191,189,32,77,73,67,58,32,77,85,84,69,68,32,40,84,65,80,32,84,79,32,85,78,77,85,84,69,41)orstring.char(239,191,189,239,191,189,239,184,143,32,77,73,67,58,32,76,73,86,69,32,47,32,85,78,77,85,84,69,68,32,40,84,65,80,32,84,79,32,77,85,84,69,41)local _0x6F85 = _0x5DAB.VC.userMuted and _0x90E7.Danger or _0x90E7.Success
if _0x5DAB.VC.statusLbl and _0x5DAB.VC.statusLbl.Parent then
_0x5DAB.VC.statusLbl.Text = string.format(string.char(37,115,32,32,194,183,32,32,66,108,111,99,107,101,100,32,77,117,116,101,115,58,32,37,100), statusStr orstring.char(83,116,97,116,117,115,58,32,73,100,108,101), _0x5DAB.VC.blockedMutes or 0)
if statusCol then _0x5DAB.VC.statusLbl.TextColor3 = statusCol end
end
if _0x5DAB.VC.activateBtn and _0x5DAB.VC.activateBtn.Parent and btnStr then
_0x5DAB.VC.activateBtn.Text = btnStr
end
if _0x5DAB.VC.micToggleBtn and _0x5DAB.VC.micToggleBtn.Parent then
_0x5DAB.VC.micToggleBtn.Text = _0xA45D
_0x5DAB.VC.micToggleBtn.BackgroundColor3 = _0x6F85
end
if _0x5DAB.VC.inlineMicBtn and _0x5DAB.VC.inlineMicBtn.Parent then
_0x5DAB.VC.inlineMicBtn.Text = _0x5DAB.VC.userMuted andstring.char(239,191,189,239,191,189,32,77,85,84,69,68)orstring.char(239,191,189,239,191,189,239,184,143,32,76,73,86,69)_0x5DAB.VC.inlineMicBtn.BackgroundColor3 = _0x6F85
end
if _0x5DAB.VC.rowSubLbl and _0x5DAB.VC.rowSubLbl.Parent then
_0x5DAB.VC.rowSubLbl.Text = string.format(string.char(37,115,32,194,183,32,71,117,97,114,100,58,37,100), statusStr orstring.char(83,116,97,116,117,115,58,32,73,100,108,101), _0x5DAB.VC.blockedMutes or 0)
end
end
local function _0x4F29()
local _0xF364 = (type(cloneref) ==string.char(102,117,110,99,116,105,111,110)and cloneref) or function(...) return ... end
local _0x33A0, _0xE7BC = nil, nil
pcall(function() _0x33A0 = _0xF364(game:GetService(string.char(86,111,105,99,101,67,104,97,116,83,101,114,118,105,99,101))) end)
pcall(function() _0xE7BC = _0xF364(game:GetService(string.char(86,111,105,99,101,67,104,97,116,73,110,116,101,114,110,97,108))) end)
return _0x33A0, _0xE7BC
end
local function _0xA2A2(_0xE7BC, pauseState)
if not _0xE7BC then
local _0x9094, _0xCC6E = _0x4F29()
_0xE7BC = _0xCC6E
end
if not _0xE7BC then return false end
local _0xF999 = pcall(function()
if _0xC563 then
_0xC563(_0xE7BC, pauseState)
else
_0xE7BC:PublishPause(pauseState)
end
end)
return _0xF999
end
local function _0xA9C5(_0xE7BC)
if not _0xE7BC then
local _0x9094, _0xCC6E = _0x4F29()
_0xE7BC = _0xCC6E
end
if not _0xE7BC then return false end
local _0xF999, _0x2D15 = pcall(function() return _0xE7BC:IsPublishPaused() end)
return _0xF999 and _0x2D15 == true
end
local function _0xFB73(_0xE7BC, _0x33A0)
local _0x83AA = (type(clonefunction) ==string.char(102,117,110,99,116,105,111,110)and clonefunction) or function(...) return ... end
if type(getconnections) ~=string.char(102,117,110,99,116,105,111,110)then return 0 end
local _0xEF86 = _0x83AA(getconnections)
local _0x8577 = 0
pcall(function()
if _0xE7BC and _0xE7BC.StateChanged then
local _0x9A50 = _0xEF86(_0xE7BC.StateChanged)
for i = 1, #_0x9A50 do
local _0x4E33 = _0x9A50[i]
local _0x1C54 = (i >= 7)
if not _0x1C54 and _0x4E33 and _0x4E33.Function and debug and type(debug.getconstants) ==string.char(102,117,110,99,116,105,111,110)then
local _0x662A, _0xBCAC = pcall(debug.getconstants, _0x4E33.Function)
if _0x662A and type(_0xBCAC) ==string.char(116,97,98,108,101)then
for _0x9094, val in pairs(_0xBCAC) do
local _0x87D3 = tostring(val):lower()
if _0x87D3:find(string.char(115,117,115,112,101,110,100), 1, true) or _0x87D3:find(string.char(109,111,100,101,114,97,116,101,100), 1, true) or _0x87D3:find(string.char(98,97,110,110,101,100), 1, true) or _0x87D3:find(string.char(112,117,98,108,105,115,104,112,97,117,115,101), 1, true) then
_0x1C54 = true
break
end
end
end
end
if _0x1C54 and _0x4E33 then
pcall(function() _0x4E33:Disable() end)
_0x8577 = _0x8577 + 1
end
end
end
end)
for _0x9094, sigName in ipairs({string.char(76,111,99,97,108,80,108,97,121,101,114,77,111,100,101,114,97,116,101,100),string.char(80,108,97,121,101,114,77,105,99,65,99,116,105,118,105,116,121,83,105,103,110,97,108,67,104,97,110,103,101),string.char(80,97,114,116,105,99,105,112,97,110,116,115,83,116,97,116,101,67,104,97,110,103,101,100)}) do
pcall(function()
local _0x4552 = _0xE7BC and _0xE7BC[sigName]
if _0x4552 and sigName ==string.char(76,111,99,97,108,80,108,97,121,101,114,77,111,100,101,114,97,116,101,100)then
for _0x9094, _0x4E33 in ipairs(_0xEF86(_0x4552)) do
pcall(function() _0x4E33:Disable() end)
pcall(function() _0x4E33:Disconnect() end)
_0x8577 = _0x8577 + 1
end
end
end)
pcall(function()
local _0x4552 = _0x33A0 and _0x33A0[sigName]
if _0x4552 and sigName ==string.char(76,111,99,97,108,80,108,97,121,101,114,77,111,100,101,114,97,116,101,100)then
for _0x9094, _0x4E33 in ipairs(_0xEF86(_0x4552)) do
pcall(function() _0x4E33:Disable() end)
pcall(function() _0x4E33:Disconnect() end)
_0x8577 = _0x8577 + 1
end
end
end)
end
return _0x8577
end
local function _0x7C8A(_0xE7BC)
if _0x5DAB.VC.hookInstalled or not _0xE7BC then return end
pcall(function()
if type(hookfunction) ==string.char(102,117,110,99,116,105,111,110)and type(_0xE7BC.PublishPause) ==string.char(102,117,110,99,116,105,111,110)then
_0x5DAB.VC.hookInstalled = true
local _0x6BAE
_0x6BAE = hookfunction(_0xE7BC.PublishPause, function(selfArg, pauseArg, ...)
if _0x5DAB.VC.enabled and selfArg == _0xE7BC and pauseArg == true and not _0x5DAB.VC.userMuted then
_0x5DAB.VC.blockedMutes = (_0x5DAB.VC.blockedMutes or 0) + 1
return _0x6BAE(selfArg, false, ...)
end
return _0x6BAE(selfArg, pauseArg, ...)
end)
_0xC563 = _0x6BAE
end
end)
end
local function _0x4FA2(_0xFA91, _0xE7BC)
local _0xA6B7, _0x3B4D = _0x6CFB(_0xFA91)
if not _0xA6B7 or not _0x3B4D then return false end
for _0x9094, storeName in ipairs({string.char(75,104,97,109,97,110,86,67,66,121,112,97,115,115,83,116,111,114,101),string.char(65,110,103,111,111,114,86,67,66,121,112,97,115,115,83,116,111,114,101)}) do
local _0x30CC = _0xFA91:FindFirstChild(storeName)
if _0x30CC then pcall(function() _0x30CC:Destroy() end) end
end
local _0x2A2C = _0x3B4D:FindFirstChild(string.char(116,111,103,103,108,101,95,109,105,99,95,109,117,116,101,95,110,101,119))
if _0x2A2C then pcall(function() _0x2A2C:Destroy() end) end
local _0x54BD = Instance.new(string.char(70,111,108,100,101,114))
_0x54BD.Name =string.char(75,104,97,109,97,110,86,67,66,121,112,97,115,115,83,116,111,114,101)_0x54BD.Parent = _0xFA91
local _0x9437 = _0xA6B7:Clone()
_0xA6B7.Parent = _0x54BD
_0x9437.Name =string.char(116,111,103,103,108,101,95,109,105,99,95,109,117,116,101,95,110,101,119)_0x9437.Parent = _0x3B4D
local _0xDA93 = _0x4506(_0x9437)
local _0x3DD1 = _0x4506(_0xA6B7)
local function _0x6D52()
if not _0xDA93 then return end
if _0x5DAB.VC.userMuted then
_0xDA93.Image = _0xD5AF
elseif _0x3DD1 and _0x3DD1.Image ~=""and _0x3DD1.Image ~= _0xD5AF then
_0xDA93.Image = _0x3DD1.Image
else
_0xDA93.Image = _0x6659
end
end
_0x6D52()
local _0x9131 = _0x9437:FindFirstChild(string.char(73,99,111,110,72,105,116,65,114,101,97,95,116,111,103,103,108,101,95,109,105,99,95,109,117,116,101), true) or _0x9437:FindFirstChildWhichIsA(string.char(71,117,105,66,117,116,116,111,110), true) or _0x9437
if _0x9131 and _0x9131:IsA(string.char(71,117,105,66,117,116,116,111,110)) then
_0x9131.Activated:Connect(function()
if _0x5DAB.VC.toggleMicFn then
_0x5DAB.VC.toggleMicFn()
end
_0x6D52()
end)
end
return true
end
local function _0xFC76()
if _0x5DAB.VC.watchdogConn then _0x5DAB.VC.watchdogConn:Disconnect(); _0x5DAB.VC.watchdogConn = nil end
local _0xB405 = 0
_0x5DAB.VC.watchdogConn = _0xC77A.Heartbeat:Connect(function()
if not _0x5DAB.VC.enabled then return end
local _0x60A3 = tick()
if _0x60A3 - _0xB405 < 0.25 then return end
_0xB405 = _0x60A3
local _0x33A0, _0xE7BC = _0x4F29()
if not _0xE7BC then return end
local _0x6BD0 = _0xA9C5(_0xE7BC)
if not _0x5DAB.VC.userMuted and _0x6BD0 then
_0xA2A2(_0xE7BC, false)
_0x5DAB.VC.blockedMutes = (_0x5DAB.VC.blockedMutes or 0) + 1
_0xB9AF(string.char(83,116,97,116,117,115,58,32,65,99,116,105,118,101,32,40,76,105,118,101,41), _0x90E7.Success,string.char(75,72,65,77,65,78,32,65,78,84,73,45,86,67,32,65,67,84,73,86,69))
elseif _0x5DAB.VC.userMuted and not _0x6BD0 then
_0xA2A2(_0xE7BC, true)
end
local _0xFA91 = _0x6B21 or game:GetService(string.char(67,111,114,101,71,117,105))
if _0xFA91 then
for _0x9094, _0x324B in ipairs(_0xFA91:GetChildren()) do
if _0x324B.Name ==string.char(75,104,97,109,97,110,86,67,66,121,112,97,115,115,83,116,111,114,101)then
local _0x3C37 = _0x324B:FindFirstChild(string.char(116,111,103,103,108,101,95,109,105,99,95,109,117,116,101))
local _0x3DD1 = _0x4506(_0x3C37)
local _0xCF41 = _0xFA91:FindFirstChild(string.char(116,111,103,103,108,101,95,109,105,99,95,109,117,116,101,95,110,101,119), true)
local _0x7A7E = _0x4506(_0xCF41)
if _0x7A7E then
if _0x5DAB.VC.userMuted then
_0x7A7E.Image = _0xD5AF
elseif _0x3DD1 and _0x3DD1.Image ~=""and _0x3DD1.Image ~= _0xD5AF then
_0x7A7E.Image = _0x3DD1.Image
else
_0x7A7E.Image = _0x6659
end
end
break
end
end
end
end)
end
_0x5DAB.VC.toggleMicFn = function()
local _0x33A0, _0xE7BC = _0x4F29()
if not _0x5DAB.VC.enabled and not _0x5DAB.VC.running then
if _0x5DAB.VC.forceBypassFn then
_0x5DAB.VC.forceBypassFn()
end
return
end
_0x5DAB.VC.userMuted = not _0x5DAB.VC.userMuted
_0xA2A2(_0xE7BC, _0x5DAB.VC.userMuted)
if _0x5DAB.VC.userMuted then
_0xB9AF(string.char(83,116,97,116,117,115,58,32,65,99,116,105,118,101,32,40,77,105,99,32,77,117,116,101,100,41), _0x90E7.Warning,string.char(75,72,65,77,65,78,32,65,78,84,73,45,86,67,32,65,67,84,73,86,69))
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(239,191,189,239,191,189,32,77,105,99,32,77,117,116,101,100,32,40,80,114,111,116,101,99,116,101,100,41))
_0xED6E()
else
_0xFB73(_0xE7BC, _0x33A0)
_0xA2A2(_0xE7BC, false)
_0xB9AF(string.char(83,116,97,116,117,115,58,32,65,99,116,105,118,101,32,40,77,105,99,32,76,73,86,69,41), _0x90E7.Success,string.char(75,72,65,77,65,78,32,65,78,84,73,45,86,67,32,65,67,84,73,86,69))
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(239,191,189,239,191,189,239,184,143,32,77,105,99,32,76,73,86,69,32,47,32,85,110,109,117,116,101,100,32,40,65,110,116,105,45,70,111,114,99,101,45,77,117,116,101,32,65,99,116,105,118,101,41))
_0xF140()
end
end
_0x5DAB.VC.rejoinFn = function()
if _0x5DAB.VC.running then return end
_0x5DAB.VC.running = true
_0xB9AF(string.char(83,116,97,116,117,115,58,32,82,101,106,111,105,110,105,110,103,32,86,111,105,99,101,46,46,46), _0x90E7.Warning,string.char(82,69,74,79,73,78,73,78,71,46,46,46))
task.spawn(function()
local _0x33A0, _0xE7BC = _0x4F29()
pcall(function() if _0x33A0 then _0x33A0:leaveVoice() end end)
task.wait(0.85)
_0xFB73(_0xE7BC, _0x33A0)
task.wait(0.45)
pcall(function() if _0x33A0 then _0x33A0:joinVoice() end end)
task.wait(0.75)
_0xFB73(_0xE7BC, _0x33A0)
_0x7C8A(_0xE7BC)
_0x5DAB.VC.userMuted = false
_0xA2A2(_0xE7BC, false)
local _0xFA91 = _0x6B21 or game:GetService(string.char(67,111,114,101,71,117,105))
if _0xFA91 then pcall(function() _0x4FA2(_0xFA91, _0xE7BC) end) end
_0x5DAB.VC.rejoins = (_0x5DAB.VC.rejoins or 0) + 1
_0x5DAB.VC.running = false
_0x5DAB.VC.enabled = true
_0xFC76()
_0xB9AF(string.char(83,116,97,116,117,115,58,32,65,99,116,105,118,101,32,40,77,105,99,32,76,73,86,69,41), _0x90E7.Success,string.char(75,72,65,77,65,78,32,65,78,84,73,45,86,67,32,65,67,84,73,86,69))
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(239,191,189,239,191,189,32,86,111,105,99,101,32,82,101,106,111,105,110,101,100,32,38,32,85,110,98,97,110,32,80,117,108,115,101,32,67,111,109,112,108,101,116,101,33))
_0xCAE4()
end)
end
_0x5DAB.VC.forceBypassFn = function()
if _0x5DAB.VC.running then
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(66,121,112,97,115,115,32,115,101,113,117,101,110,99,101,32,97,108,114,101,97,100,121,32,114,117,110,110,105,110,103,46,46,46))
return
end
_0x5DAB.VC.running = true
_0xB9AF(string.char(83,116,97,116,117,115,58,32,70,111,114,99,101,45,66,121,112,97,115,115,105,110,103,46,46,46), _0x90E7.Warning,string.char(66,89,80,65,83,83,73,78,71,46,46,46))
if _0xA00F then pcall(_0xA00F) end
_0xF140()
task.spawn(function()
local _0xF999, _0xA263 = pcall(function()
local _0x33A0, _0xE7BC = _0x4F29()
local _0xFA91 = _0x6B21 or game:GetService(string.char(67,111,114,101,71,117,105))
local _0xA6B7 = _0x6CFB(_0xFA91)
if not _0xA6B7 and _0x33A0 then
pcall(function() _0x33A0:joinVoice() end)
task.wait(0.7)
_0xA6B7 = _0x6CFB(_0xFA91)
end
if _0xA6B7 then
local _0xCDFC = _0x4506(_0xA6B7)
if _0xCDFC and _0xCDFC.Image == _0xD5AF and type(firesignal) ==string.char(102,117,110,99,116,105,111,110)then
local _0xC3BE = _0xA6B7:FindFirstChild(string.char(73,99,111,110,72,105,116,65,114,101,97,95,116,111,103,103,108,101,95,109,105,99,95,109,117,116,101), true) or _0xA6B7
pcall(function() firesignal(_0xC3BE.Activated) end)
pcall(function() firesignal(_0xC3BE.MouseButton1Click) end)
task.wait(0.25)
end
end
if _0x33A0 then pcall(function() _0x33A0:leaveVoice() end) end
task.wait(1.1)
_0xFB73(_0xE7BC, _0x33A0)
task.wait(0.8)
if _0x33A0 then pcall(function() _0x33A0:joinVoice() end) end
task.wait(0.9)
_0xFB73(_0xE7BC, _0x33A0)
_0x7C8A(_0xE7BC)
if _0xFA91 then
pcall(function() _0x4FA2(_0xFA91, _0xE7BC) end)
end
_0x5DAB.VC.userMuted = false
_0xA2A2(_0xE7BC, false)
_0x5DAB.VC.running = false
_0x5DAB.VC.enabled = true
_0xFC76()
_0xB9AF(string.char(83,116,97,116,117,115,58,32,65,99,116,105,118,101,32,40,77,105,99,32,76,73,86,69,41), _0x90E7.Success,string.char(75,72,65,77,65,78,32,65,78,84,73,45,86,67,32,65,67,84,73,86,69))
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(226,154,161,32,73,110,115,116,97,110,116,32,86,67,32,66,121,112,97,115,115,32,86,52,32,65,99,116,105,118,101,33,32,77,105,99,32,105,115,32,76,73,86,69,46))
_0xCAE4()
end)
if not _0xF999 then
_0x5DAB.VC.running = false
_0xB9AF(string.char(83,116,97,116,117,115,58,32,69,114,114,111,114,32,40).. tostring(_0xA263):sub(1, 22) ..string.char(41), _0x90E7.Danger,string.char(82,69,84,82,89,32,66,89,80,65,83,83))
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(66,121,112,97,115,115,32,69,114,114,111,114,58,32).. tostring(_0xA263))
end
end)
end
_0x879F = function()
if _0x5DAB.VC.enabled then
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(65,108,114,101,97,100,121,32,97,99,116,105,118,101,32,226,128,148,32,117,115,101,32,77,105,99,32,84,111,103,103,108,101,32,111,114,32,82,101,106,111,105,110,33))
return
end
if _0x5DAB.VC.running then
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(66,121,112,97,115,115,32,105,110,32,112,114,111,103,114,101,115,115,32,226,128,148,32,117,110,109,117,116,101,32,109,105,99,32,111,114,32,116,97,112,32,73,110,115,116,97,110,116,32,70,111,114,99,101,32,66,121,112,97,115,115,33))
return
end
_0x5DAB.VC.running = true
_0xB9AF(string.char(83,116,97,116,117,115,58,32,87,97,105,116,105,110,103,32,102,111,114,32,117,110,109,117,116,101,46,46,46), _0x90E7.Warning,string.char(87,65,73,84,73,78,71,46,46,46))
if _0xA00F then pcall(_0xA00F) end
_0xF140()
task.spawn(function()
local _0xF999, _0xA263 = pcall(function()
local _0x33A0, _0xE7BC = _0x4F29()
local _0xFA91 = _0x6B21 or game:GetService(string.char(67,111,114,101,71,117,105))
local _0xA6B7, _0x3B4D = _0x6CFB(_0xFA91)
if not _0xA6B7 then
pcall(function() if _0x33A0 then _0x33A0:joinVoice() end end)
task.wait(0.9)
_0xA6B7, _0x3B4D = _0x6CFB(_0xFA91)
end
if _0xA6B7 then
local _0xCDFC = _0x4506(_0xA6B7)
if _0xCDFC and _0xCDFC.Image == _0xD5AF and type(firesignal) ==string.char(102,117,110,99,116,105,111,110)then
local _0xC3BE = _0xA6B7:FindFirstChild(string.char(73,99,111,110,72,105,116,65,114,101,97,95,116,111,103,103,108,101,95,109,105,99,95,109,117,116,101), true) or _0xA6B7
pcall(function() firesignal(_0xC3BE.Activated) end)
pcall(function() firesignal(_0xC3BE.MouseButton1Click) end)
task.wait(0.25)
_0xCDFC = _0x4506(_0xA6B7) or _0xCDFC
end
if _0xCDFC and _0xCDFC.Image == _0xD5AF then
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(85,110,109,117,116,101,32,121,111,117,114,32,109,105,99,32,40,111,114,32,119,97,105,116,32,49,50,115,32,102,111,114,32,65,117,116,111,32,70,111,114,99,101,45,66,121,112,97,115,115,41))
local _0x9110 = tick()
while _0xCDFC and _0xCDFC.Image == _0xD5AF and (tick() - _0x9110) < 12 do
if not _0x5DAB.VC.running then
error(string.char(67,97,110,99,101,108,108,101,100))
end
task.wait(0.35)
_0xCDFC = _0x4506(_0xA6B7) or _0xCDFC
end
end
else
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(84,111,112,66,97,114,32,104,105,100,100,101,110,32,226,128,148,32,114,117,110,110,105,110,103,32,68,105,114,101,99,116,32,69,110,103,105,110,101,32,86,67,32,66,121,112,97,115,115,32,86,52,46,46,46))
end
pcall(function() if _0x33A0 then _0x33A0:leaveVoice() end end)
task.wait(1.5)
_0xFB73(_0xE7BC, _0x33A0)
task.wait(1.2)
pcall(function() if _0x33A0 then _0x33A0:joinVoice() end end)
task.wait(1.0)
_0xFB73(_0xE7BC, _0x33A0)
_0x7C8A(_0xE7BC)
if _0xFA91 then
pcall(function() _0x4FA2(_0xFA91, _0xE7BC) end)
end
_0x5DAB.VC.userMuted = false
_0xA2A2(_0xE7BC, false)
_0x5DAB.VC.running = false
_0x5DAB.VC.enabled = true
_0xFC76()
_0xB9AF(string.char(83,116,97,116,117,115,58,32,65,99,116,105,118,101,32,40,77,105,99,32,76,73,86,69,41), _0x90E7.Success,string.char(75,72,65,77,65,78,32,65,78,84,73,45,86,67,32,65,67,84,73,86,69))
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(65,99,116,105,118,97,116,101,100,32,86,52,32,66,121,112,97,115,115,33,32,77,105,99,32,105,115,32,76,73,86,69,32,40,80,114,101,115,115,32,91,86,93,32,111,114,32,117,115,101,32,85,73,32,116,111,32,109,117,116,101,47,117,110,109,117,116,101,41))
_0xCAE4()
end)
if not _0xF999 then
_0x5DAB.VC.running = false
_0x5DAB.VC.enabled = false
_0xB9AF(string.char(83,116,97,116,117,115,58,32,70,97,105,108,101,100), _0x90E7.Danger,string.char(82,69,84,82,89))
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(69,114,114,111,114,58,32).. tostring(_0xA263))
warn(string.char(91,75,72,65,77,65,78,32,65,78,84,73,45,86,67,93,32,69,114,114,111,114,58), _0xA263)
end
end)
end
_0x559B = function()
if not _0x5DAB.VC.enabled and not _0x5DAB.VC.running then return end
_0x5DAB.VC.running = false
_0x5DAB.VC.enabled = false
if _0x5DAB.VC.watchdogConn then _0x5DAB.VC.watchdogConn:Disconnect(); _0x5DAB.VC.watchdogConn = nil end
pcall(function()
local _0xFA91 = _0x6B21 or game:GetService(string.char(67,111,114,101,71,117,105))
local _0x711B = _0xFA91 and (_0xFA91:FindFirstChild(string.char(75,104,97,109,97,110,86,67,66,121,112,97,115,115,83,116,111,114,101)) or _0xFA91:FindFirstChild(string.char(65,110,103,111,111,114,86,67,66,121,112,97,115,115,83,116,111,114,101)))
if _0x711B then
local _0x3C37 = _0x711B:FindFirstChild(string.char(116,111,103,103,108,101,95,109,105,99,95,109,117,116,101))
for _0x9094, _0x324B in ipairs(_0xFA91:GetDescendants()) do
if _0x324B.Name ==string.char(116,111,103,103,108,101,95,109,105,99,95,109,117,116,101,95,110,101,119)and _0x324B.Parent then
if _0x3C37 then
_0x3C37.Parent = _0x324B.Parent
end
_0x324B:Destroy()
break
end
end
_0x711B:Destroy()
end
end)
_0xB9AF(string.char(83,116,97,116,117,115,58,32,73,100,108,101), _0x90E7.Muted,string.char(65,67,84,73,86,65,84,69,32,75,72,65,77,65,78,32,65,78,84,73,32,86,67))
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67),string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67,32,114,101,115,101,116,32,116,111,32,73,100,108,101))
_0xED6E()
end
_0x5DAB.VC.startFn = _0x879F
_0x5DAB.VC.stopFn = _0x559B
_G.ActivateKhamanAntiVC = _0x879F
_G.ForceKhamanAntiVC = _0x5DAB.VC.forceBypassFn
_G.ToggleKhamanVCMic = _0x5DAB.VC.toggleMicFn
_G.ActivateTeslaAntiVC = _0x879F
_0x5DAB.VC.openPanelFn = function()
local _0xFA91 = _0x6B21 or game:GetService(string.char(67,111,114,101,71,117,105))
local _0x4CD6 = _0xA6AA and _0xA6AA:FindFirstChildOfClass(string.char(80,108,97,121,101,114,71,117,105))
for _0x9094, panelName in ipairs({string.char(75,104,97,109,97,110,65,110,116,105,86,67,80,97,110,101,108),string.char(84,101,115,108,97,65,110,116,105,86,67,80,97,110,101,108)}) do
local _0x3596 = (_0xFA91 and _0xFA91:FindFirstChild(panelName))
or (_0x4CD6 and _0x4CD6:FindFirstChild(panelName))
if _0x3596 then
_0x3596:Destroy()
return
end
end
local _0x8BF2 = Instance.new(string.char(83,99,114,101,101,110,71,117,105))
_0x8BF2.Name =string.char(75,104,97,109,97,110,65,110,116,105,86,67,80,97,110,101,108)_0x8BF2.ResetOnSpawn = false
_0x8BF2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_0x8BF2.DisplayOrder = 1000002
local _0x0CDB = pcall(function()
_0x8BF2.Parent = _0xFA91
end)
if not _0x0CDB or not _0x8BF2.Parent then
_0x8BF2.Parent = _0x4CD6 or _0xA6AA:WaitForChild(string.char(80,108,97,121,101,114,71,117,105))
end
local _0x2C6B = Instance.new(string.char(70,114,97,109,101), _0x8BF2)
_0x2C6B.Name =string.char(75,104,97,109,97,110,65,110,116,105,86,67,67,97,114,100)_0x2C6B.Size = UDim2.new(0, 304, 0, 296)
_0x2C6B.Position = UDim2.new(0.5, -152, 0.5, -148)
_0x2C6B.BackgroundColor3 = _0x90E7.BG2
_0x2C6B.BorderSizePixel = 0
_0x2C6B.Active = true
pcall(function() _0x2C6B.Draggable = true end)
local _0xC2C9 = Instance.new(string.char(85,73,67,111,114,110,101,114), _0x2C6B)
_0xC2C9.CornerRadius = UDim.new(0, 12)
local _0x04FE = Instance.new(string.char(85,73,83,116,114,111,107,101), _0x2C6B)
_0x04FE.Color = _0x90E7.Accent
_0x04FE.Thickness = 1.6
local _0x7DA0 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110), _0x2C6B)
_0x7DA0.Size = UDim2.new(0, 24, 0, 22)
_0x7DA0.Position = UDim2.new(1, -24, 0, 0)
_0x7DA0.BackgroundTransparency = 1
_0x7DA0.Text =string.char(226,156,149)_0x7DA0.Font = Enum.Font.GothamBold
_0x7DA0.TextSize = 12
_0x7DA0.TextColor3 = _0x90E7.Muted
_0x7DA0.ZIndex = 5
_0x7DA0.MouseButton1Click:Connect(function()
_0x0909()
_0x8BF2:Destroy()
end)
local _0xFBD5 = Instance.new(string.char(85,73,80,97,100,100,105,110,103), _0x2C6B)
_0xFBD5.PaddingTop = UDim.new(0, 10)
_0xFBD5.PaddingBottom = UDim.new(0, 10)
_0xFBD5.PaddingLeft = UDim.new(0, 12)
_0xFBD5.PaddingRight = UDim.new(0, 12)
local _0xB97B = Instance.new(string.char(85,73,76,105,115,116,76,97,121,111,117,116), _0x2C6B)
_0xB97B.FillDirection = Enum.FillDirection.Vertical
_0xB97B.Padding = UDim.new(0, 6)
_0xB97B.SortOrder = Enum.SortOrder.LayoutOrder
local _0xA265 = Instance.new(string.char(84,101,120,116,76,97,98,101,108), _0x2C6B)
_0xA265.LayoutOrder = 1
_0xA265.Size = UDim2.new(1, -24, 0, 18)
_0xA265.BackgroundTransparency = 1
_0xA265.Text =string.char(239,191,189,239,191,189,32,75,72,65,77,65,78,32,65,78,84,73,45,86,67,32,86,52,32,85,76,84,82,65,32,66,89,80,65,83,83)_0xA265.Font = Enum.Font.GothamBlack
_0xA265.TextSize = 11
_0xA265.TextColor3 = _0x90E7.Accent
_0xA265.TextXAlignment = Enum.TextXAlignment.Left
local _0xD2EF = Instance.new(string.char(84,101,120,116,76,97,98,101,108), _0x2C6B)
_0xD2EF.LayoutOrder = 2
_0xD2EF.Size = UDim2.new(1, 0, 0, 18)
_0xD2EF.BackgroundTransparency = 1
_0xD2EF.Text = (_0x5DAB.VC.statusText orstring.char(83,116,97,116,117,115,58,32,73,100,108,101)) ..string.char(32,32,194,183,32,32,66,108,111,99,107,101,100,32,77,117,116,101,115,58,32).. tostring(_0x5DAB.VC.blockedMutes or 0)
_0xD2EF.Font = Enum.Font.GothamBold
_0xD2EF.TextSize = 10
_0xD2EF.TextColor3 = _0x5DAB.VC.enabled and _0x90E7.Success
or (_0x5DAB.VC.running and _0x90E7.Warning or _0x90E7.Muted)
_0xD2EF.TextXAlignment = Enum.TextXAlignment.Left
_0x5DAB.VC.statusLbl = _0xD2EF
local _0x7782 = Instance.new(string.char(84,101,120,116,76,97,98,101,108), _0x2C6B)
_0x7782.LayoutOrder = 3
_0x7782.Size = UDim2.new(1, 0, 0, 68)
_0x7782.BackgroundColor3 = _0x90E7.Panel
_0x7782.BorderSizePixel = 0
_0x7782.Text =string.char(226,128,162,32,65,117,116,111,32,66,121,112,97,115,115,58,32,85,110,109,117,116,101,115,32,43,32,115,116,114,105,112,115,32,83,116,97,116,101,67,104,97,110,103,101,100,32,38,32,77,111,100,101,114,97,116,105,111,110,10,226,128,162,32,73,110,115,116,97,110,116,32,70,111,114,99,101,32,66,121,112,97,115,115,58,32,48,45,119,97,105,116,32,100,105,114,101,99,116,32,86,111,105,99,101,67,104,97,116,73,110,116,101,114,110,97,108,32,117,110,108,111,99,107,10,226,128,162,32,65,110,116,105,45,70,111,114,99,101,45,77,117,116,101,32,87,97,116,99,104,100,111,103,58,32,75,101,101,112,115,32,109,105,99,32,76,73,86,69,32,50,52,47,55,32,40,75,101,121,58,32,91,86,93,41)_0x7782.Font = Enum.Font.Gotham
_0x7782.TextSize = 9
_0x7782.TextColor3 = _0x90E7.Text
_0x7782.TextXAlignment = Enum.TextXAlignment.Left
_0x7782.TextYAlignment = Enum.TextYAlignment.Top
_0x7782.TextWrapped = true
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x7782).CornerRadius = UDim.new(0, 8)
local _0x502F = Instance.new(string.char(85,73,80,97,100,100,105,110,103), _0x7782)
_0x502F.PaddingTop = UDim.new(0, 6)
_0x502F.PaddingLeft = UDim.new(0, 8)
_0x502F.PaddingRight = UDim.new(0, 8)
local _0x4BE2 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110), _0x2C6B)
_0x4BE2.LayoutOrder = 4
_0x4BE2.Size = UDim2.new(1, 0, 0, 34)
_0x4BE2.BackgroundColor3 = _0x90E7.Accent2
_0x4BE2.BorderSizePixel = 0
_0x4BE2.Text = _0x5DAB.VC.enabled andstring.char(75,72,65,77,65,78,32,65,78,84,73,45,86,67,32,65,67,84,73,86,69)or (_0x5DAB.VC.running andstring.char(87,65,73,84,73,78,71,46,46,46)orstring.char(65,67,84,73,86,65,84,69,32,65,85,84,79,32,86,67,32,66,89,80,65,83,83))
_0x4BE2.Font = Enum.Font.GothamBold
_0x4BE2.TextSize = 11
_0x4BE2.TextColor3 = Color3.new(1, 1, 1)
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4BE2).CornerRadius = UDim.new(0, 7)
_0x5DAB.VC.activateBtn = _0x4BE2
_0x4BE2.MouseButton1Click:Connect(function()
_0x0909()
_0x879F()
end)
local _0x3185 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110), _0x2C6B)
_0x3185.LayoutOrder = 5
_0x3185.Size = UDim2.new(1, 0, 0, 32)
_0x3185.BackgroundColor3 = Color3.fromRGB(185, 115, 12)
_0x3185.BorderSizePixel = 0
_0x3185.Text =string.char(226,154,161,32,73,78,83,84,65,78,84,32,70,79,82,67,69,32,66,89,80,65,83,83,32,40,48,45,87,65,73,84,41)_0x3185.Font = Enum.Font.GothamBold
_0x3185.TextSize = 10
_0x3185.TextColor3 = Color3.new(1, 1, 1)
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x3185).CornerRadius = UDim.new(0, 7)
_0x5DAB.VC.forceBtn = _0x3185
_0x3185.MouseButton1Click:Connect(function()
_0x0909()
_0x5DAB.VC.forceBypassFn()
end)
local _0xA6B7 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110), _0x2C6B)
_0xA6B7.LayoutOrder = 6
_0xA6B7.Size = UDim2.new(1, 0, 0, 32)
_0xA6B7.BackgroundColor3 = _0x5DAB.VC.userMuted and _0x90E7.Danger or _0x90E7.Success
_0xA6B7.BorderSizePixel = 0
_0xA6B7.Text = _0x5DAB.VC.userMuted andstring.char(239,191,189,239,191,189,32,77,73,67,58,32,77,85,84,69,68,32,40,84,65,80,32,84,79,32,85,78,77,85,84,69,41)orstring.char(239,191,189,239,191,189,239,184,143,32,77,73,67,58,32,76,73,86,69,32,47,32,85,78,77,85,84,69,68,32,40,84,65,80,32,84,79,32,77,85,84,69,41)_0xA6B7.Font = Enum.Font.GothamBold
_0xA6B7.TextSize = 10
_0xA6B7.TextColor3 = Color3.new(1, 1, 1)
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xA6B7).CornerRadius = UDim.new(0, 7)
_0x5DAB.VC.micToggleBtn = _0xA6B7
_0xA6B7.MouseButton1Click:Connect(function()
_0x0909()
_0x5DAB.VC.toggleMicFn()
end)
local _0xFBCF = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110), _0x2C6B)
_0xFBCF.LayoutOrder = 7
_0xFBCF.Size = UDim2.new(1, 0, 0, 30)
_0xFBCF.BackgroundColor3 = _0x90E7.PanelLt
_0xFBCF.BorderSizePixel = 0
_0xFBCF.Text =string.char(239,191,189,239,191,189,32,70,79,82,67,69,32,82,69,74,79,73,78,32,86,79,73,67,69,32,38,32,85,78,66,65,78,32,80,85,76,83,69)_0xFBCF.Font = Enum.Font.GothamBold
_0xFBCF.TextSize = 10
_0xFBCF.TextColor3 = _0x90E7.Neon
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xFBCF).CornerRadius = UDim.new(0, 7)
_0x5DAB.VC.rejoinBtn = _0xFBCF
_0xFBCF.MouseButton1Click:Connect(function()
_0x0909()
_0x5DAB.VC.rejoinFn()
end)
endlocal function _0x39D2(_0x4E33, _0xA778)
if _0xA778 then
local _0xE21C = _0xA778.SeatPart
if _0xE21C then
pcall(function()
_0xE21C.Disabled = true
_0xE21C.CanTouch = false
for _0x9094, _0x25EB in ipairs(_0xE21C:GetChildren()) do
if _0x25EB:IsA(string.char(87,101,108,100)) or _0x25EB:IsA(string.char(87,101,108,100,67,111,110,115,116,114,97,105,110,116)) or _0x25EB:IsA(string.char(77,111,116,111,114,54,68)) or _0x25EB.Name ==string.char(83,101,97,116,87,101,108,100)then
_0x25EB:Destroy()
end
end
end)
end
end
local _0xE5AE = _0x4DA4(_0x4E33)
if _0xE5AE then
local _0x2340, _0x4BFD = pcall(function() return _0xE5AE:GetJoints() end)
if _0x2340 and _0x4BFD then
for _0x9094, j in ipairs(_0x4BFD) do
if j.Name ==string.char(83,101,97,116,87,101,108,100)or j:IsA(string.char(83,101,97,116,87,101,108,100)) then
pcall(function() j:Destroy() end)
end
end
end
end
end
local function _0xEB07(_0x4E33)
if not _0x4E33 or _0x1B4F() then return end
for _0x9094, _0x4A72 in ipairs(_0x4E33:GetDescendants()) do
if _0x4A72:IsA(string.char(77,111,116,111,114,54,68)) and not _0x4A72.Enabled then
pcall(function() _0x4A72.Enabled = true end)
elseif _0x4A72:IsA(string.char(83,101,97,116,87,101,108,100)) or _0x4A72.Name ==string.char(83,101,97,116,87,101,108,100)or _0x4A72.Name:lower():find(string.char(114,97,103,100,111,108,108), 1, true) then
if not _0x4A72:IsA(string.char(66,97,115,101,80,97,114,116)) and not _0x4A72:IsA(string.char(72,117,109,97,110,111,105,100)) then
pcall(function() _0x4A72:Destroy() end)
end
elseif _0x4A72:IsA(string.char(66,97,108,108,83,111,99,107,101,116,67,111,110,115,116,114,97,105,110,116)) or _0x4A72:IsA(string.char(72,105,110,103,101,67,111,110,115,116,114,97,105,110,116)) then
pcall(function() _0x4A72:Destroy() end)
end
end
end
local function _0x11E6(_0xA778)
if not _0xA778 then return end
pcall(function()
_0xA778:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
_0xA778:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
_0xA778:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
_0xA778:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
end)
end
local function _0xABC3(_0x4E33, forceDeep)
if not _0x4E33 then return end
if _0x1B4F() or (_0xAE44 and _0xAE44.rewinding) then return end
local _0xA778 = _0x4E33:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA778 then
if _0xA778.Sit or _0xA778.SeatPart ~= nil then
_0x39D2(_0x4E33, _0xA778)
pcall(function() _0xA778.Sit = false end)
end
if not (_0x02BF and _0x02BF.fly) then
if _0xA778.PlatformStand then
pcall(function() _0xA778.PlatformStand = false end)
end
if not _0xA778.AutoRotate then
pcall(function() _0xA778.AutoRotate = true end)
end
if not _0xA778.EvaluateStateMachine then
pcall(function() _0xA778.EvaluateStateMachine = true end)
end
local _0xE898 = _0xA778:GetState()
if _0xE898 == Enum.HumanoidStateType.Ragdoll
or _0xE898 == Enum.HumanoidStateType.FallingDown
or _0xE898 == Enum.HumanoidStateType.PlatformStanding
or _0xE898 == Enum.HumanoidStateType.Seated then
pcall(function()
_0xA778:ChangeState(Enum.HumanoidStateType.GettingUp)
_0xA778:ChangeState(Enum.HumanoidStateType.Running)
end)
_0x5DAB.Ragdoll.recoveries = _0x5DAB.Ragdoll.recoveries + 1
end
if _0xA778.WalkSpeed < 8 and not (_0x02BF and _0x02BF.speed) then
pcall(function() _0xA778.WalkSpeed = 16 end)
end
end
end
if forceDeep then
_0xEB07(_0x4E33)
end
end
_0xE9DA = function(silent)
if _0x5DAB.Ragdoll.enabled and _0x5DAB.Ragdoll.steppedConn then return end
_0x5DAB.Ragdoll.enabled = true
local function _0x2D9A(_0x5BFE)
if _0x5DAB.Ragdoll.descConn then _0x5DAB.Ragdoll.descConn:Disconnect(); _0x5DAB.Ragdoll.descConn = nil end
if _0x5DAB.Ragdoll.stateConn then _0x5DAB.Ragdoll.stateConn:Disconnect(); _0x5DAB.Ragdoll.stateConn = nil end
if not _0x5BFE then return end
local _0xA778 = _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA778 then _0x11E6(_0xA778) end
_0xABC3(_0x5BFE, true)
_0x5DAB.Ragdoll.descConn = _0x5BFE.DescendantAdded:Connect(function(_0x4A72)
if not _0x5DAB.Ragdoll.enabled or _0x1B4F() then return end
if _0x4A72:IsA(string.char(72,117,109,97,110,111,105,100)) then
_0x11E6(_0x4A72)
elseif _0x4A72:IsA(string.char(77,111,116,111,114,54,68)) and not _0x4A72.Enabled then
pcall(function() _0x4A72.Enabled = true end)
elseif _0x4A72:IsA(string.char(83,101,97,116,87,101,108,100)) or _0x4A72.Name ==string.char(83,101,97,116,87,101,108,100)or _0x4A72.Name:lower():find(string.char(114,97,103,100,111,108,108), 1, true)
or _0x4A72:IsA(string.char(66,97,108,108,83,111,99,107,101,116,67,111,110,115,116,114,97,105,110,116)) or _0x4A72:IsA(string.char(72,105,110,103,101,67,111,110,115,116,114,97,105,110,116)) then
pcall(function() _0x4A72:Destroy() end)
end
end)
if _0xA778 then
_0x5DAB.Ragdoll.stateConn = _0xA778.StateChanged:Connect(function(_0x9094, state)
if not _0x5DAB.Ragdoll.enabled or _0x1B4F() then return end
if state == Enum.HumanoidStateType.Ragdoll
or state == Enum.HumanoidStateType.FallingDown
or state == Enum.HumanoidStateType.Seated then
task.defer(function()
if _0x5DAB.Ragdoll.enabled and _0x5BFE.Parent and not _0x1B4F() then
_0xABC3(_0x5BFE, true)
end
end)
end
end)
end
end
_0x2D9A(_0xA6AA.Character)
if _0x5DAB.Ragdoll.charAdded then _0x5DAB.Ragdoll.charAdded:Disconnect() end
_0x5DAB.Ragdoll.charAdded = _0xA6AA.CharacterAdded:Connect(function(_0x4E33)
task.wait(0.1)
if _0x5DAB.Ragdoll.enabled then _0x2D9A(_0x4E33) end
end)
if _0x5DAB.Ragdoll.steppedConn then _0x5DAB.Ragdoll.steppedConn:Disconnect() end
_0x5DAB.Ragdoll.steppedConn = _0xC77A.Stepped:Connect(function()
if not _0x5DAB.Ragdoll.enabled or _0x1B4F() then return end
_0xABC3(_0xA6AA.Character, false)
end)
if _0xA00F then pcall(_0xA00F) end
if not silent then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,82,97,103,100,111,108,108,32,47,32,65,110,116,105,45,83,105,116,32,47,32,65,110,116,105,45,83,116,117,110,32,118,52,32,40,65,108,119,97,121,115,45,79,110,41,32,65,67,84,73,86,69))
_0xF140()
end
end
_0x8C2F = function()
if _0x5DAB.AlwaysOnCore or _0x5DAB.Ragdoll.alwaysOn then
_0xE9DA(true)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(239,191,189,239,191,189,32,65,110,116,105,45,83,105,116,32,47,32,65,110,116,105,45,82,97,103,100,111,108,108,32,105,115,32,108,111,99,107,101,100,32,65,76,87,65,89,83,45,79,78,33))
return
end
if not _0x5DAB.Ragdoll.enabled then return end
_0x5DAB.Ragdoll.enabled = false
if _0x5DAB.Ragdoll.steppedConn then _0x5DAB.Ragdoll.steppedConn:Disconnect(); _0x5DAB.Ragdoll.steppedConn = nil end
if _0x5DAB.Ragdoll.descConn then _0x5DAB.Ragdoll.descConn:Disconnect(); _0x5DAB.Ragdoll.descConn = nil end
if _0x5DAB.Ragdoll.stateConn then _0x5DAB.Ragdoll.stateConn:Disconnect(); _0x5DAB.Ragdoll.stateConn = nil end
if _0x5DAB.Ragdoll.charAdded then _0x5DAB.Ragdoll.charAdded:Disconnect(); _0x5DAB.Ragdoll.charAdded = nil end
if _0xA00F then pcall(_0xA00F) end
end
_0x5DAB.Ragdoll.startFn = _0xE9DA
_0x5DAB.Ragdoll.stopFn = _0x8C2Flocal _0x5E69 = {
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
local function _0xFE29(_0x5959)
if not (_0x5959 and _0x5959:IsA(string.char(66,97,115,101,80,97,114,116))) or _0x5DAB.Anchor.partConns[_0x5959] then return end
_0x5DAB.Anchor.partConns[_0x5959] = _0x5959:GetPropertyChangedSignal(string.char(65,110,99,104,111,114,101,100)):Connect(function()
if _0x5DAB.Anchor.enabled and _0x5959.Parent and _0x5959.Anchored and not _0x1978 and not _0xB106 then
pcall(function() _0x5959.Anchored = false end)
_0x5DAB.Anchor.purgedMovers = _0x5DAB.Anchor.purgedMovers + 1
end
end)
end
local function _0x4230(_0x4E33, forceMoverSweep)
if not _0x4E33 then return end
for _0x9094, _0x5959 in ipairs(_0x04D0(_0x4E33)) do
if _0x5959.Parent and _0x5959.Anchored and not _0x1978 and not _0xB106 then
_0x5959.Anchored = false
_0x5DAB.Anchor.purgedMovers = _0x5DAB.Anchor.purgedMovers + 1
end
end
if not _0x1B4F() and not (_0x02BF and _0x02BF.fly) then
local _0xA778 = _0x4E33:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA778 then
if not _0xA778.EvaluateStateMachine then
pcall(function() _0xA778.EvaluateStateMachine = true end)
end
if _0xA778.WalkSpeed <= 1 then
pcall(function() _0xA778.WalkSpeed = (_0x02BF and _0x02BF.speed and _0x02BF.desiredWalkSpeed) or 16 end)
end
end
end
if forceMoverSweep then
for _0x9094, _0x4A72 in ipairs(_0x4E33:GetDescendants()) do
if _0x4A72:IsA(string.char(66,97,115,101,80,97,114,116)) then
_0xFE29(_0x4A72)
elseif _0x5E69[_0x4A72.ClassName] and not _0x4A72.Name:match(string.char(94,67,111,99,111)) and not _0x4A72.Name:match(string.char(94,75,104,97,109,97,110)) then
pcall(function()
_0x4A72:Destroy()
_0x5DAB.Anchor.purgedMovers = _0x5DAB.Anchor.purgedMovers + 1
end)
end
end
end
end
local function _0x2D84(_0x5BFE)
if _0x5DAB.Anchor.descConn then _0x5DAB.Anchor.descConn:Disconnect(); _0x5DAB.Anchor.descConn = nil end
for _0x5959, conn in pairs(_0x5DAB.Anchor.partConns) do
if conn then pcall(function() conn:Disconnect() end) end
_0x5DAB.Anchor.partConns[_0x5959] = nil
end
if not _0x5BFE then return end
_0x4230(_0x5BFE, true)
_0x5DAB.Anchor.descConn = _0x5BFE.DescendantAdded:Connect(function(_0x4A72)
if not _0x5DAB.Anchor.enabled then return end
if _0x4A72:IsA(string.char(66,97,115,101,80,97,114,116)) then
_0xFE29(_0x4A72)
if _0x4A72.Anchored and not _0x1978 and not _0xB106 then
pcall(function() _0x4A72.Anchored = false end)
end
elseif _0x5E69[_0x4A72.ClassName] and not _0x4A72.Name:match(string.char(94,67,111,99,111)) and not _0x4A72.Name:match(string.char(94,75,104,97,109,97,110)) then
pcall(function() _0x4A72:Destroy(); _0x5DAB.Anchor.purgedMovers = _0x5DAB.Anchor.purgedMovers + 1 end)
end
end)
end
_0xE1A6 = function(silent)
if _0x5DAB.Anchor.enabled and _0x5DAB.Anchor.steppedConn then return end
_0x5DAB.Anchor.enabled = true
_0x2D84(_0xA6AA.Character)
if _0x5DAB.Anchor.charAdded then _0x5DAB.Anchor.charAdded:Disconnect() end
_0x5DAB.Anchor.charAdded = _0xA6AA.CharacterAdded:Connect(function(_0x5BFE)
task.wait(0.1)
if _0x5DAB.Anchor.enabled then _0x2D84(_0x5BFE) end
end)
if _0x5DAB.Anchor.steppedConn then _0x5DAB.Anchor.steppedConn:Disconnect() end
_0x5DAB.Anchor.steppedConn = _0xC77A.Stepped:Connect(function()
if not _0x5DAB.Anchor.enabled then return end
_0x4230(_0xA6AA.Character, false)
end)
if _0xA00F then pcall(_0xA00F) end
if not silent then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,70,114,101,101,122,101,32,47,32,65,110,116,105,45,65,110,99,104,111,114,32,118,52,32,40,65,108,119,97,121,115,45,79,110,41,32,65,67,84,73,86,69))
_0xF140()
end
end
_0x708D = function()
if _0x5DAB.AlwaysOnCore or _0x5DAB.Anchor.alwaysOn then
_0xE1A6(true)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(239,191,189,239,191,189,32,65,110,116,105,45,70,114,101,101,122,101,32,47,32,65,110,116,105,45,65,110,99,104,111,114,32,105,115,32,108,111,99,107,101,100,32,65,76,87,65,89,83,45,79,78,33))
return
end
if not _0x5DAB.Anchor.enabled then return end
_0x5DAB.Anchor.enabled = false
if _0x5DAB.Anchor.steppedConn then _0x5DAB.Anchor.steppedConn:Disconnect(); _0x5DAB.Anchor.steppedConn = nil end
if _0x5DAB.Anchor.descConn then _0x5DAB.Anchor.descConn:Disconnect(); _0x5DAB.Anchor.descConn = nil end
if _0x5DAB.Anchor.charAdded then _0x5DAB.Anchor.charAdded:Disconnect(); _0x5DAB.Anchor.charAdded = nil end
for _0x5959, conn in pairs(_0x5DAB.Anchor.partConns) do
if conn then pcall(function() conn:Disconnect() end) end
_0x5DAB.Anchor.partConns[_0x5959] = nil
end
if _0xA00F then pcall(_0xA00F) end
end
_0x5DAB.Anchor.startFn = _0xE1A6
_0x5DAB.Anchor.stopFn = _0x708Dlocal function _0xBFF0(_0x4A72, _0x1213)
if not _0x4A72 or not _0x1213 then return false end
if _0x4A72:IsA(string.char(74,111,105,110,116,73,110,115,116,97,110,99,101)) or _0x4A72:IsA(string.char(87,101,108,100,67,111,110,115,116,114,97,105,110,116)) then
local _0xD8D8, _0x9AC3 = _0x4A72.Part0, _0x4A72.Part1
local _0x5043 = _0xD8D8 and _0xD8D8:IsDescendantOf(_0x1213)
local _0x57B1 = _0x9AC3 and _0x9AC3:IsDescendantOf(_0x1213)
if (_0x5043 and _0x9AC3 and not _0x57B1) or (_0x57B1 and _0xD8D8 and not _0x5043) then
return true
end
elseif _0x4A72:IsA(string.char(67,111,110,115,116,114,97,105,110,116)) then
local _0xE84B, _0x2696 = _0x4A72.Attachment0, _0x4A72.Attachment1
local _0xCF44 = _0xE84B and _0xE84B:IsDescendantOf(_0x1213)
local _0xADC8 = _0x2696 and _0x2696:IsDescendantOf(_0x1213)
if (_0xCF44 and _0x2696 and not _0xADC8) or (_0xADC8 and _0xE84B and not _0xCF44) then
return true
end
end
return false
end
local function _0x6EA6()
local _0x1213 = _0xA6AA.Character
if not _0x1213 then return 0 end
local _0xCDA1 = 0
for _0x9094, _0x5959 in ipairs(_0x04D0(_0x1213)) do
if _0x5959.Parent then
local _0x2340, _0x4BFD = pcall(function() return _0x5959:GetJoints() end)
if _0x2340 and _0x4BFD then
for _0x9094, j in ipairs(_0x4BFD) do
if _0xBFF0(j, _0x1213) then
pcall(function() j:Destroy() end)
_0xCDA1 = _0xCDA1 + 1
end
end
end
end
end
_0x5DAB.Attach.severedCount = _0x5DAB.Attach.severedCount + _0xCDA1
return _0xCDA1
end
_0x557D = function()
if _0x5DAB.Attach.enabled then return end
_0x5DAB.Attach.enabled = true
_0x6EA6()
if _0x5DAB.Attach.steppedConn then _0x5DAB.Attach.steppedConn:Disconnect() end
_0x5DAB.Attach.steppedConn = _0xC77A.Stepped:Connect(function()
if not _0x5DAB.Attach.enabled or _0x1B4F() then return end
_0x6EA6()
end)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,65,116,116,97,99,104,32,47,32,79,109,110,105,45,87,101,108,100,32,38,32,71,114,97,98,32,83,101,118,101,114,32,118,51,32,79,78))
_0xF140()
end
_0x3D9F = function()
if not _0x5DAB.Attach.enabled then return end
_0x5DAB.Attach.enabled = false
if _0x5DAB.Attach.steppedConn then _0x5DAB.Attach.steppedConn:Disconnect(); _0x5DAB.Attach.steppedConn = nil end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,65,116,116,97,99,104,32,100,105,115,97,98,108,101,100))
_0xED6E()
end
_0x5DAB.Attach.startFn = _0x557D
_0x5DAB.Attach.stopFn = _0x3D9Flocal function _0x23B3()
local _0x0E3D = game:GetService(string.char(76,105,103,104,116,105,110,103))
pcall(function()
if _0x0E3D.FogEnd < 250 then _0x0E3D.FogEnd = 100000 end
for _0x9094, eff in ipairs(_0x0E3D:GetChildren()) do
if eff:IsA(string.char(66,108,117,114,69,102,102,101,99,116)) and eff.Size > 4 then
eff.Enabled = false; eff.Size = 0
elseif eff:IsA(string.char(67,111,108,111,114,67,111,114,114,101,99,116,105,111,110,69,102,102,101,99,116)) and (eff.Brightness < -0.25 or eff.Brightness > 0.6 or eff.Contrast > 1.5 or eff.TintColor ~= Color3.new(1, 1, 1)) then
eff.Enabled = false
elseif eff:IsA(string.char(68,101,112,116,104,79,102,70,105,101,108,100,69,102,102,101,99,116)) and eff.FarIntensity > 0.5 then
eff.Enabled = false
elseif eff:IsA(string.char(66,108,111,111,109,69,102,102,101,99,116)) and eff.Intensity > 2.5 then
eff.Enabled = false
elseif eff:IsA(string.char(65,116,109,111,115,112,104,101,114,101)) and eff.Density > 0.65 then
eff.Density = 0.25
end
end
local _0x6EE9 = workspace.CurrentCamera
if _0x6EE9 then
if _0x6EE9.FieldOfView < 40 or _0x6EE9.FieldOfView > 115 then
_0x6EE9.FieldOfView = 70
end
for _0x9094, eff in ipairs(_0x6EE9:GetChildren()) do
if eff:IsA(string.char(80,111,115,116,69,102,102,101,99,116)) and not eff.Name:match(string.char(94,67,111,99,111)) and not eff.Name:match(string.char(94,75,104,97,109,97,110)) then
eff.Enabled = false
end
end
end
local _0x4CD6 = _0xA6AA:FindFirstChildOfClass(string.char(80,108,97,121,101,114,71,117,105))
if _0x4CD6 then
for _0x9094, sg in ipairs(_0x4CD6:GetChildren()) do
if sg:IsA(string.char(83,99,114,101,101,110,71,117,105)) and not sg.Name:match(string.char(94,75,104,97,109,97,110)) and not sg.Name:match(string.char(94,67,111,99,111)) then
local _0xCDBF = sg.Name:lower()
if _0xCDBF:find(string.char(98,108,105,110,100), 1, true)
or _0xCDBF:find(string.char(102,108,97,115,104), 1, true)
or _0xCDBF:find(string.char(98,108,97,99,107,111,117,116), 1, true)
or _0xCDBF:find(string.char(106,117,109,112,115,99,97,114,101), 1, true)
or _0xCDBF:find(string.char(102,97,100,101), 1, true) then
sg.Enabled = false
end
end
end
end
end)
end
_0x2D4F = function()
if _0x5DAB.Blind.enabled then return end
_0x5DAB.Blind.enabled = true
_0x23B3()
if _0x5DAB.Blind.loopConn then _0x5DAB.Blind.loopConn:Disconnect() end
_0x5DAB.Blind.loopConn = _0xC77A.Heartbeat:Connect(function()
if not _0x5DAB.Blind.enabled then return end
_0x23B3()
end)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,66,108,105,110,100,32,47,32,65,110,116,105,45,70,108,97,115,104,98,97,110,103,32,38,32,70,111,103,32,67,108,101,97,114,32,118,51,32,79,78))
_0xF140()
end
_0xA4A6 = function()
if not _0x5DAB.Blind.enabled then return end
_0x5DAB.Blind.enabled = false
if _0x5DAB.Blind.loopConn then _0x5DAB.Blind.loopConn:Disconnect(); _0x5DAB.Blind.loopConn = nil end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,66,108,105,110,100,32,100,105,115,97,98,108,101,100))
_0xED6E()
end
_0x5DAB.Blind.startFn = _0x2D4F
_0x5DAB.Blind.stopFn = _0xA4A6_0x8E13 = function()
if _0x5DAB.Bring.enabled then return end
_0x5DAB.Bring.enabled = true
local _0x4E33 = _0xA6AA.Character
local _0xE5AE = _0x4DA4(_0x4E33)
if _0xE5AE and _0x97B4(_0xE5AE.CFrame) then
_0x5DAB.Bring.lastCF = _0xE5AE.CFrame
_0x5DAB.Bring.lastSafeTime = tick()
end
if _0x5DAB.Bring.steppedConn then _0x5DAB.Bring.steppedConn:Disconnect() end
_0x5DAB.Bring.steppedConn = _0xC77A.Stepped:Connect(function(_0x9094, _0x004C)
if not _0x5DAB.Bring.enabled then return end
if _0x1B4F() or _0x1978 or (_0x02BF and _0x02BF.fly) or (_0xAE44 and _0xAE44.rewinding) then
local _0x7B2F = _0xA6AA.Character
local _0x5CFE = _0x4DA4(_0x7B2F)
if _0x5CFE and _0x97B4(_0x5CFE.CFrame) then _0x5DAB.Bring.lastCF = _0x5CFE.CFrame end
return
end
if tick() - (_0x02BF.lastTeleportTick or 0) < 0.85 then return end
local _0x7B2F = _0xA6AA.Character
local _0x5CFE = _0x4DA4(_0x7B2F)
local _0xA778 = _0x7B2F and _0x7B2F:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0x5CFE or not _0xA778 or _0xA778.Health <= 0 then return end
if _0x5DAB.Bring.lastCF then
local _0x0E43 = (_0x5CFE.Position - _0x5DAB.Bring.lastCF.Position).Magnitude
local _0x1AEC = math.max(38, (_0xA778.WalkSpeed or 16) * math.max(_0x004C or 0.016, 0.016) * 4.5 + 22)
if _0x0E43 > _0x1AEC then
_0x6EA6()
_0x5CFE.AssemblyLinearVelocity = Vector3.zero
_0x5CFE.AssemblyAngularVelocity = Vector3.zero
_0x5CFE.CFrame = _0x5DAB.Bring.lastCF
_0x5DAB.Bring.blockedBrings = _0x5DAB.Bring.blockedBrings + 1
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,66,114,105,110,103,32,118,51,58,32,66,108,111,99,107,101,100,32,104,111,115,116,105,108,101,32,116,101,108,101,112,111,114,116,47,103,114,97,98,33))
elseif _0x97B4(_0x5CFE.CFrame) then
_0x5DAB.Bring.lastCF = _0x5CFE.CFrame
end
elseif _0x97B4(_0x5CFE.CFrame) then
_0x5DAB.Bring.lastCF = _0x5CFE.CFrame
end
end)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,66,114,105,110,103,32,47,32,84,111,111,108,45,71,114,97,98,32,38,32,83,110,97,112,32,71,117,97,114,100,32,118,51,32,79,78))
_0xF140()
end
_0xE011 = function()
if not _0x5DAB.Bring.enabled then return end
_0x5DAB.Bring.enabled = false
if _0x5DAB.Bring.steppedConn then _0x5DAB.Bring.steppedConn:Disconnect(); _0x5DAB.Bring.steppedConn = nil end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,66,114,105,110,103,32,100,105,115,97,98,108,101,100))
_0xED6E()
end
_0x5DAB.Bring.startFn = _0x8E13
_0x5DAB.Bring.stopFn = _0xE011local function _0x159C()
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
if not _0x32EC then return end
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= _0xA6AA and _0x1CEE.Character then
local _0xEC72 = _0x4DA4(_0x1CEE.Character)
local _0x1D3E = _0xEC72 and (_0xEC72.AssemblyLinearVelocity.Magnitude > 50 or _0xEC72.AssemblyAngularVelocity.Magnitude > 25)
for _0x9094, _0x5959 in ipairs(_0x04D0(_0x1CEE.Character)) do
if _0x5959.Parent then
if _0x5959.CanCollide then _0x5959.CanCollide = false end
if _0x5959.CanTouch then _0x5959.CanTouch = false end
if not _0x5959.Massless then _0x5959.Massless = true end
if _0x1D3E then
pcall(function()
_0x5959.AssemblyLinearVelocity = Vector3.zero
_0x5959.AssemblyAngularVelocity = Vector3.zero
end)
end
end
end
end
end
end
_0xC237 = function()
if _0x5DAB.FlingShield.enabled then return end
_0x5DAB.FlingShield.enabled = true
pcall(function()
local _0x8AF0 = game:GetService(string.char(80,104,121,115,105,99,115,83,101,114,118,105,99,101))
_0x8AF0:RegisterCollisionGroup(string.char(75,104,97,109,97,110,78,111,67,111,108,108,105,100,101))
_0x8AF0:CollisionGroupSetCollidable(string.char(75,104,97,109,97,110,78,111,67,111,108,108,105,100,101),string.char(68,101,102,97,117,108,116), false)
end)
if _0x5DAB.FlingShield.steppedConn then _0x5DAB.FlingShield.steppedConn:Disconnect() end
_0x5DAB.FlingShield.steppedConn = _0xC77A.Stepped:Connect(function()
if not _0x5DAB.FlingShield.enabled and not _0x7DE1.enabled then return end
if _0x1B4F() or _0x1978 or (_0xAE44 and _0xAE44.rewinding) then return end
_0x159C()
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
if _0x32EC and _0x97B4(_0x32EC.CFrame) then
if _0x32EC.AssemblyLinearVelocity.Magnitude < 90 and _0x32EC.AssemblyAngularVelocity.Magnitude < 35 then
_0x5DAB.FlingShield.preStepCF = _0x32EC.CFrame
else
_0x32EC.AssemblyLinearVelocity = Vector3.zero
_0x32EC.AssemblyAngularVelocity = Vector3.zero
if _0x5DAB.FlingShield.preStepCF then
_0x32EC.CFrame = _0x5DAB.FlingShield.preStepCF
end
_0x5DAB.FlingShield.blockedFlings = _0x5DAB.FlingShield.blockedFlings + 1
end
end
end)
if _0x5DAB.FlingShield.heartbeatConn then _0x5DAB.FlingShield.heartbeatConn:Disconnect() end
_0x5DAB.FlingShield.heartbeatConn = _0xC77A.Heartbeat:Connect(function()
if not _0x5DAB.FlingShield.enabled and not _0x7DE1.enabled then return end
if _0x1B4F() or _0x1978 or (_0xAE44 and _0xAE44.rewinding) then return end
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
if not _0x32EC then return end
if _0x32EC.AssemblyLinearVelocity.Magnitude > 90 or _0x32EC.AssemblyAngularVelocity.Magnitude > 35 then
_0x32EC.AssemblyLinearVelocity = Vector3.zero
_0x32EC.AssemblyAngularVelocity = Vector3.zero
if _0x5DAB.FlingShield.preStepCF and _0x97B4(_0x5DAB.FlingShield.preStepCF) then
_0x32EC.CFrame = _0x5DAB.FlingShield.preStepCF
end
_0x5DAB.FlingShield.blockedFlings = _0x5DAB.FlingShield.blockedFlings + 1
end
end)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,70,108,105,110,103,32,83,104,105,101,108,100,32,118,51,32,40,83,101,114,118,101,114,45,87,105,100,101,32,78,111,45,67,111,108,108,105,100,101,32,43,32,90,101,114,111,45,73,109,112,117,108,115,101,41,32,79,78))
_0xF140()
end
_0x7E9F = function()
if not _0x5DAB.FlingShield.enabled then return end
_0x5DAB.FlingShield.enabled = false
if not _0x7DE1.enabled then
if _0x5DAB.FlingShield.steppedConn then
_0x5DAB.FlingShield.steppedConn:Disconnect()
_0x5DAB.FlingShield.steppedConn = nil
end
if _0x5DAB.FlingShield.heartbeatConn then
_0x5DAB.FlingShield.heartbeatConn:Disconnect()
_0x5DAB.FlingShield.heartbeatConn = nil
end
end
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= _0xA6AA and _0x1CEE.Character then
for _0x9094, _0x5959 in ipairs(_0x04D0(_0x1CEE.Character)) do
if _0x5959.Parent and (_0x5959.Name ==string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116)or _0x5959.Name ==string.char(84,111,114,115,111)or _0x5959.Name ==string.char(85,112,112,101,114,84,111,114,115,111)or _0x5959.Name ==string.char(76,111,119,101,114,84,111,114,115,111)or _0x5959.Name ==string.char(72,101,97,100)) then
pcall(function() _0x5959.CanCollide = true; _0x5959.Massless = false end)
end
end
end
end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,70,108,105,110,103,32,83,104,105,101,108,100,32,100,105,115,97,98,108,101,100))
_0xED6E()
end
_0x5DAB.FlingShield.startFn = _0xC237
_0x5DAB.FlingShield.stopFn = _0x7E9Flocal function _0xD41D(seat)
if not seat or not (seat:IsA(string.char(83,101,97,116)) or seat:IsA(string.char(86,101,104,105,99,108,101,83,101,97,116))) then return end
if not _0x5DAB.SeatTrap.savedSeats[seat] then
_0x5DAB.SeatTrap.savedSeats[seat] = { Disabled = seat.Disabled, CanTouch = seat.CanTouch }
end
pcall(function()
seat.Disabled = true
seat.CanTouch = false
for _0x9094, _0x7B2F in ipairs(seat:GetChildren()) do
if _0x7B2F:IsA(string.char(87,101,108,100)) or _0x7B2F:IsA(string.char(87,101,108,100,67,111,110,115,116,114,97,105,110,116)) or _0x7B2F.Name ==string.char(83,101,97,116,87,101,108,100)then
_0x7B2F:Destroy()
end
end
end)
_0x5DAB.SeatTrap.neutralizedSeats = (_0x5DAB.SeatTrap.neutralizedSeats or 0) + 1
end
_0x5DAB.SeatTrap.startFn = function(silent)
if _0x5DAB.SeatTrap.enabled and _0x5DAB.SeatTrap.wsDescConn then return end
_0x5DAB.SeatTrap.enabled = true
task.spawn(function()
local _0x69FF = workspace:GetDescendants()
for i = 1, #_0x69FF do
if not _0x5DAB.SeatTrap.enabled then break end
local _0x4A72 = _0x69FF[i]
if _0x4A72 and (_0x4A72:IsA(string.char(83,101,97,116)) or _0x4A72:IsA(string.char(86,101,104,105,99,108,101,83,101,97,116))) then
_0xD41D(_0x4A72)
end
if i % 250 == 0 then
task.wait(0.03)
end
end
end)
if _0x5DAB.SeatTrap.wsDescConn then _0x5DAB.SeatTrap.wsDescConn:Disconnect() end
_0x5DAB.SeatTrap.wsDescConn = workspace.DescendantAdded:Connect(function(_0x4A72)
if not _0x5DAB.SeatTrap.enabled then return end
if _0x4A72:IsA(string.char(83,101,97,116)) or _0x4A72:IsA(string.char(86,101,104,105,99,108,101,83,101,97,116)) then
_0xD41D(_0x4A72)
elseif (_0x4A72:IsA(string.char(83,101,97,116,87,101,108,100)) or _0x4A72.Name ==string.char(83,101,97,116,87,101,108,100)) and _0xA6AA.Character then
local _0xD8D8, _0x9AC3 = _0x4A72.Part0, _0x4A72.Part1
if (_0xD8D8 and _0xD8D8:IsDescendantOf(_0xA6AA.Character)) or (_0x9AC3 and _0x9AC3:IsDescendantOf(_0xA6AA.Character)) then
pcall(function() _0x4A72:Destroy() end)
end
end
end)
if _0xA00F then pcall(_0xA00F) end
if _0x8AC6 then pcall(_0x8AC6) end
if not silent then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,83,101,97,116,32,47,32,67,111,117,99,104,45,75,105,100,110,97,112,32,68,101,115,116,114,111,121,101,114,32,118,52,32,40,65,108,119,97,121,115,45,79,110,41,32,65,67,84,73,86,69))
_0xF140()
end
end
_0x5DAB.SeatTrap.stopFn = function()
if _0x5DAB.AlwaysOnCore or _0x5DAB.SeatTrap.alwaysOn then
_0x5DAB.SeatTrap.startFn(true)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(239,191,189,239,191,189,32,65,110,116,105,45,83,105,116,32,47,32,65,110,116,105,45,83,101,97,116,32,105,115,32,108,111,99,107,101,100,32,65,76,87,65,89,83,45,79,78,33))
return
end
if not _0x5DAB.SeatTrap.enabled then return end
_0x5DAB.SeatTrap.enabled = false
if _0x5DAB.SeatTrap.wsDescConn then _0x5DAB.SeatTrap.wsDescConn:Disconnect(); _0x5DAB.SeatTrap.wsDescConn = nil end
if _0xA00F then pcall(_0xA00F) end
end
_0x5DAB.ToolGuard.startFn = function()
if _0x5DAB.ToolGuard.enabled then return end
_0x5DAB.ToolGuard.enabled = true
if _0x5DAB.ToolGuard.loopConn then _0x5DAB.ToolGuard.loopConn:Disconnect() end
local _0x8DB2 = 0
_0x5DAB.ToolGuard.loopConn = _0xC77A.Heartbeat:Connect(function()
if not _0x5DAB.ToolGuard.enabled then return end
local _0x60A3 = tick()
if _0x60A3 - _0x8DB2 < 0.20 then return end
_0x8DB2 = _0x60A3
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
if not _0x32EC then return end
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= _0xA6AA and _0x1CEE.Character then
local _0x6DEF = _0x4DA4(_0x1CEE.Character)
if not _0x6DEF or (_0x6DEF.Position - _0x32EC.Position).Magnitude < 45 then
for _0x9094, child in ipairs(_0x1CEE.Character:GetChildren()) do
if child:IsA(string.char(84,111,111,108)) or child:IsA(string.char(72,111,112,112,101,114,66,105,110)) then
for _0x9094, _0x5959 in ipairs(child:GetDescendants()) do
if _0x5959:IsA(string.char(66,97,115,101,80,97,114,116)) then
if _0x5959.CanTouch or _0x5959.CanCollide then
_0x5959.CanTouch = false
_0x5959.CanCollide = false
_0x5959.Massless = true
_0x5DAB.ToolGuard.disarmedTools = (_0x5DAB.ToolGuard.disarmedTools or 0) + 1
end
elseif _0x5959:IsA(string.char(83,101,97,116)) or _0x5959:IsA(string.char(86,101,104,105,99,108,101,83,101,97,116)) then
_0xD41D(_0x5959)
elseif _0x1213 and _0xBFF0(_0x5959, _0x1213) then
pcall(function() _0x5959:Destroy() end)
_0x5DAB.Attach.severedCount = (_0x5DAB.Attach.severedCount or 0) + 1
end
end
end
end
end
end
end
end)
if _0xA00F then pcall(_0xA00F) end
if _0x8AC6 then pcall(_0x8AC6) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,84,111,111,108,32,47,32,67,111,117,99,104,32,47,32,67,97,114,114,121,32,68,105,115,97,114,109,101,114,32,118,51,32,79,78))
_0xF140()
end
_0x5DAB.ToolGuard.stopFn = function()
if not _0x5DAB.ToolGuard.enabled then return end
_0x5DAB.ToolGuard.enabled = false
if _0x5DAB.ToolGuard.loopConn then _0x5DAB.ToolGuard.loopConn:Disconnect(); _0x5DAB.ToolGuard.loopConn = nil end
if _0xA00F then pcall(_0xA00F) end
if _0x8AC6 then pcall(_0x8AC6) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,84,111,111,108,32,68,105,115,97,114,109,101,114,32,100,105,115,97,98,108,101,100))
_0xED6E()
end_0x5DAB.AntiHeadsit.startFn = function()
if _0x5DAB.AntiHeadsit.enabled then return end
_0x5DAB.AntiHeadsit.enabled = true
if _0x5DAB.AntiHeadsit.steppedConn then _0x5DAB.AntiHeadsit.steppedConn:Disconnect() end
_0x5DAB.AntiHeadsit.steppedConn = _0xC77A.Stepped:Connect(function()
if not _0x5DAB.AntiHeadsit.enabled then return end
if _0x1B4F() or _0x1978 or (_0xAE44 and _0xAE44.rewinding) then return end
local _0x60A3 = tick()
if _0x60A3 - (_0x5DAB.AntiHeadsit.lastEvade or 0) < 0.35 then return end
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
if not _0x32EC then return end
local _0x6CC4 = _0x32EC.CFrame
local _0xB1BD = _0x6CC4 * CFrame.new(0, 0, -1.75)
local _0xBDE4 = _0x6CC4 * CFrame.new(0, 0, 1.75)
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= _0xA6AA and _0x1CEE.Character then
local _0xEC72 = _0x4DA4(_0x1CEE.Character)
if _0xEC72 then
local _0x7D2D = _0xEC72.Position
local _0xCA8D = _0x7D2D.Y - _0x6CC4.Position.Y
local _0x6143 = _0x1CEE.Character:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
local _0x9EC6 = _0x6143 and (_0x6143.Sit or _0x6143.PlatformStand or _0x6143:GetState() == Enum.HumanoidStateType.Physics or _0xEC72.AssemblyLinearVelocity.Magnitude > 30)
local _0xF269 = _0x9EC6 and (math.abs(_0x7D2D.X - _0x6CC4.Position.X) <= 2.2 and math.abs(_0x7D2D.Z - _0x6CC4.Position.Z) <= 2.2 and _0xCA8D >= 1.15 and _0xCA8D <= 4.8)
local _0x2F64 = _0x9EC6 and (((_0x7D2D - _0xB1BD.Position).Magnitude <= 1.65) or ((_0x7D2D - _0xBDE4.Position).Magnitude <= 1.55))
if (_0xF269 or _0x2F64) and (_0x60A3 - _0x1FB2 > 2.0) then
_0x5DAB.AntiHeadsit.lastEvade = _0x60A3
_0x5DAB.AntiHeadsit.evadedCount = (_0x5DAB.AntiHeadsit.evadedCount or 0) + 1
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
task.spawn(function()
pcall(function()
_0x363C(_0x6CC4)
_0x32EC.CFrame = CFrame.new(_0x6CC4.Position.X, math.clamp(_0x8668 - 180, -950, -350), _0x6CC4.Position.Z)
task.wait(0.18)
if _0x32EC and _0x32EC.Parent and not _0x1B4F() then
_0x363C(_0x6CC4)
_0x32EC.AssemblyLinearVelocity = Vector3.zero
_0x32EC.AssemblyAngularVelocity = Vector3.zero
_0x32EC.CFrame = _0x6CC4
end
end)
end)
break
end
end
end
end
end)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,72,101,97,100,115,105,116,32,38,32,65,110,116,105,45,70,97,99,101,98,97,110,103,32,69,118,97,100,101,114,32,40,70,117,108,108,32,76,105,98,114,97,114,121,41,32,79,78))
_0xF140()
end
_0x5DAB.AntiHeadsit.stopFn = function()
if not _0x5DAB.AntiHeadsit.enabled then return end
_0x5DAB.AntiHeadsit.enabled = false
if _0x5DAB.AntiHeadsit.steppedConn then _0x5DAB.AntiHeadsit.steppedConn:Disconnect(); _0x5DAB.AntiHeadsit.steppedConn = nil end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,72,101,97,100,115,105,116,32,38,32,65,110,116,105,45,70,97,99,101,98,97,110,103,32,100,105,115,97,98,108,101,100))
_0xED6E()
end
_0x5DAB.GlitchDesync.startFn = function()
if _0x5DAB.GlitchDesync.enabled then return end
_0x5DAB.GlitchDesync.enabled = true
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
if _0x32EC then
_0x5DAB.GlitchDesync.realCF = _0x32EC.CFrame
_0x5DAB.GlitchDesync.realVel = _0x32EC.AssemblyLinearVelocity
_0x5DAB.GlitchDesync.realRot = _0x32EC.AssemblyAngularVelocity
end
if _0x5DAB.GlitchDesync.steppedConn then _0x5DAB.GlitchDesync.steppedConn:Disconnect() end
_0x5DAB.GlitchDesync.steppedConn = _0xC77A.Stepped:Connect(function()
if not _0x5DAB.GlitchDesync.enabled then return end
if _0x1B4F() or _0x1978 or (_0xAE44 and _0xAE44.rewinding) then return end
local _0x5CFE = _0x4DA4(_0xA6AA.Character)
if _0x5CFE and _0x5DAB.GlitchDesync.realCF then
_0x5CFE.CFrame = _0x5DAB.GlitchDesync.realCF
local _0x5E44 = _0x5DAB.GlitchDesync.realVel
if _0x5E44 and _0x5E44.Magnitude < 1 then _0x5E44 = Vector3.new(0, 0.05, 0) end
_0x5CFE.AssemblyLinearVelocity = _0x5E44 or Vector3.zero
_0x5CFE.AssemblyAngularVelocity = _0x5DAB.GlitchDesync.realRot or Vector3.zero
end
end)
pcall(function() _0xC77A:UnbindFromRenderStep(string.char(75,104,97,109,97,110,71,108,105,116,99,104,82,101,115,116,111,114,101)) end)
pcall(function()
_0xC77A:BindToRenderStep(string.char(75,104,97,109,97,110,71,108,105,116,99,104,82,101,115,116,111,114,101), 1, function()
if not _0x5DAB.GlitchDesync.enabled then return end
if _0x1B4F() or _0x1978 or (_0xAE44 and _0xAE44.rewinding) then return end
local _0x5CFE = _0x4DA4(_0xA6AA.Character)
if _0x5CFE and _0x5DAB.GlitchDesync.realCF then
_0x5CFE.CFrame = _0x5DAB.GlitchDesync.realCF
local _0x5E44 = _0x5DAB.GlitchDesync.realVel
if _0x5E44 and _0x5E44.Magnitude < 1 then _0x5E44 = Vector3.new(0, 0.05, 0) end
_0x5CFE.AssemblyLinearVelocity = _0x5E44 or Vector3.zero
_0x5CFE.AssemblyAngularVelocity = _0x5DAB.GlitchDesync.realRot or Vector3.zero
end
end)
end)
if _0x5DAB.GlitchDesync.heartbeatConn then _0x5DAB.GlitchDesync.heartbeatConn:Disconnect() end
_0x5DAB.GlitchDesync.heartbeatConn = _0xC77A.Heartbeat:Connect(function()
if not _0x5DAB.GlitchDesync.enabled then return end
if _0x1B4F() or _0x1978 or (_0xAE44 and _0xAE44.rewinding) then return end
local _0x5CFE = _0x4DA4(_0xA6AA.Character)
if not _0x5CFE then return end
_0x5DAB.GlitchDesync.realCF = _0x5CFE.CFrame
_0x5DAB.GlitchDesync.realVel = _0x5CFE.AssemblyLinearVelocity
_0x5DAB.GlitchDesync.realRot = _0x5CFE.AssemblyAngularVelocity
local _0x4032 = math.random(-50000, 50000)
local _0x9794 = math.random(50, 1000)
local _0xB872 = math.random(-50000, 50000)
local _0x5822 = math.random(-100, 100)
local _0x58BF = math.random(12, 145)
local _0x886B = math.random(-100, 100)
local _0x2473 = CFrame.new(_0x5CFE.Position) * CFrame.Angles(0, math.random(0, 314) / 100, 0) + Vector3.new(_0x5822, _0x58BF, _0x886B)
_0x363C(_0x5DAB.GlitchDesync.realCF)
_0x5CFE.AssemblyLinearVelocity = Vector3.new(_0x4032, _0x9794, _0xB872)
_0x5CFE.AssemblyAngularVelocity = Vector3.new(_0x4032, _0x9794, _0xB872)
_0x5CFE.CFrame = _0x2473
end)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,66,97,110,103,32,71,108,105,116,99,104,32,68,101,115,121,110,99,32,40,69,118,97,100,101,32,66,97,110,103,115,41,32,79,78))
_0xF140()
end
_0x5DAB.GlitchDesync.stopFn = function()
if not _0x5DAB.GlitchDesync.enabled then return end
_0x5DAB.GlitchDesync.enabled = false
pcall(function() _0xC77A:UnbindFromRenderStep(string.char(75,104,97,109,97,110,71,108,105,116,99,104,82,101,115,116,111,114,101)) end)
if _0x5DAB.GlitchDesync.steppedConn then _0x5DAB.GlitchDesync.steppedConn:Disconnect(); _0x5DAB.GlitchDesync.steppedConn = nil end
if _0x5DAB.GlitchDesync.heartbeatConn then _0x5DAB.GlitchDesync.heartbeatConn:Disconnect(); _0x5DAB.GlitchDesync.heartbeatConn = nil end
local _0x5CFE = _0x4DA4(_0xA6AA.Character)
if _0x5CFE and _0x5DAB.GlitchDesync.realCF then
_0x363C(_0x5DAB.GlitchDesync.realCF)
_0x5CFE.CFrame = _0x5DAB.GlitchDesync.realCF
_0x5CFE.AssemblyLinearVelocity = _0x5DAB.GlitchDesync.realVel or Vector3.zero
_0x5CFE.AssemblyAngularVelocity = _0x5DAB.GlitchDesync.realRot or Vector3.zero
end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,66,97,110,103,32,71,108,105,116,99,104,32,68,101,115,121,110,99,32,100,105,115,97,98,108,101,100))
_0xED6E()
end
_0x5DAB.Kick.startFn = function()
if _0x5DAB.Kick.enabled then return end
_0x5DAB.Kick.enabled = true
pcall(function()
if type(hookfunction) ==string.char(102,117,110,99,116,105,111,110)and _0xA6AA and _0xA6AA.Kick and not _0x5DAB.Kick.hooked then
_0x5DAB.Kick.hooked = true
local _0xBDD1
_0xBDD1 = hookfunction(_0xA6AA.Kick, function(selfArg, ...)
if _0x5DAB.Kick.enabled and selfArg == _0xA6AA then
_0x5DAB.Kick.blockedKicks = (_0x5DAB.Kick.blockedKicks or 0) + 1
local _0x4F8A = tostring(... orstring.char(67,108,105,101,110,116,32,75,105,99,107))
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(239,191,189,239,191,189,239,184,143,32,65,110,116,105,45,75,105,99,107,32,98,108,111,99,107,101,100,58,32).. _0x4F8A:sub(1, 36))
return nil
end
return _0xBDD1(selfArg, ...)
end)
_0x5DAB.Kick.originalKick = _0xBDD1
end
end)
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,75,105,99,107,32,40,67,108,105,101,110,116,32,75,105,99,107,32,73,110,116,101,114,99,101,112,116,111,114,41,32,79,78))
_0xF140()
end
_0x5DAB.Kick.stopFn = function()
if not _0x5DAB.Kick.enabled then return end
_0x5DAB.Kick.enabled = false
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,110,116,105,45,75,105,99,107,32,100,105,115,97,98,108,101,100))
_0xED6E()
endlocal function _0xA4B1(attacker)
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
if not _0x32EC then return nil end
local _0xE2FF, _0xC27B = nil, math.huge
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= _0xA6AA and _0x1CEE ~= attacker and _0x1CEE.Character then
local _0x5CFE = _0x4DA4(_0x1CEE.Character)
local _0xA077 = _0x1CEE.Character:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0x5CFE and (not _0xA077 or _0xA077.Health > 0) and _0x5CFE.Position.Y > (_0x8668 + 25) then
local _0x000B = (_0x5CFE.Position - _0x32EC.Position).Magnitude
if _0x000B < _0xC27B then
_0xC27B = _0x000B
_0xE2FF = _0x1CEE
end
end
end
end
return _0xE2FF
end
local function _0x6876(attacker, threatReason)
if _0x1978 or _0x1B4F() then return end
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
local _0x4545 = _0x1213 and _0x1213:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0x32EC or not _0x4545 or _0x4545.Health <= 0 then return end
if not attacker or not attacker.Character then return end
local _0x59C0 = _0x76B4(attacker.Character,string.char(116,111,114,115,111))
if not _0x59C0 then return end
_0x1978 = true
_0x7DE1.deflectCount = _0x7DE1.deflectCount + 1
_0x7DE1.lastAttackerName = attacker.Name
_0x7DE1.lastThreatReason = threatReason orstring.char(80,114,111,120,105,109,105,116,121,47,84,114,111,108,108)local _0xA3C6 = _0x7DE1.mode orstring.char(71,111,100,77,97,116,114,105,120)if not _0x7DE1.enabled then
if _0x5DAB.Redirect.enabled then _0xA3C6 =string.char(82,101,100,105,114,101,99,116)elseif _0x5DAB.PauseTrap.enabled then _0xA3C6 =string.char(86,111,105,100,80,97,117,115,101)end
end
local _0x6CC4 = _0x97B4(_0x32EC.CFrame) and _0x32EC.CFrame or _0x6660()
_0x363C(_0x6CC4)
local _0x6EE9 = workspace.CurrentCamera
local _0xE4B4 = _0x6EE9 and _0x6EE9.CFrame
local _0x3829 = _0x6EE9 and _0x6EE9.CameraType
pcall(function() workspace.FallenPartsDestroyHeight = 0/0 end)
if _0x6EE9 and _0xE4B4 then
pcall(function()
_0x6EE9.CameraType = Enum.CameraType.Scriptable
_0x6EE9.CFrame = _0xE4B4
end)
end
_0x6EA6()
for _0x9094, _0x5959 in ipairs(_0x04D0(_0x1213)) do
if _0x5959.Parent then
_0x5959.CanCollide = false
_0x5959.CanTouch = false
_0x5959.Massless = true
end
end
local _0x0E65 =string.char(239,191,189,239,191,189,239,184,143,32).. (_0x7DE1.modeLabels[_0xA3C6] or _0xA3C6) ..string.char(32,45,62,32).. attacker.Name ..string.char(32,40).. tostring(_0x7DE1.lastThreatReason) ..string.char(41)_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65), _0x0E65)
if _0x2DB3 then _0x2DB3(_0x0E65) end
_0x6F35()
local _0x67EE = math.clamp(_0x8668 - 155, -780, -340)
local _0x89B7 = CFrame.new(_0x6CC4.Position.X, _0x67EE, _0x6CC4.Position.Z)
if _0xA3C6 ==string.char(71,111,100,77,97,116,114,105,120)then
for i = 1, 6 do
if not _0x32EC.Parent or not _0x59C0.Parent then break end
local _0xFD1C = i * 1.15
_0x32EC.CFrame = _0x59C0.CFrame * CFrame.new(math.cos(_0xFD1C) * 0.65, 0, math.sin(_0xFD1C) * 0.65)
* CFrame.Angles(math.rad(math.random(-180, 180)), _0xFD1C, math.rad(math.random(-180, 180)))
_0x32EC.AssemblyAngularVelocity = Vector3.new(95000, 95000, 95000)
_0x32EC.AssemblyLinearVelocity = Vector3.new(math.random(-28000, 28000), -60000, math.random(-28000, 28000))
_0xC77A.Heartbeat:Wait()
end
for _0x9094 = 1, 5 do
if not _0x32EC.Parent then break end
_0x32EC.CFrame = _0x89B7
_0x32EC.AssemblyLinearVelocity = Vector3.new(0, -75000, 0)
_0x32EC.AssemblyAngularVelocity = Vector3.zero
_0xC77A.Heartbeat:Wait()
end
local _0xB5AA = _0xA4B1(attacker)
if _0xB5AA and _0xB5AA.Character then
local _0x527A = _0x76B4(_0xB5AA.Character,string.char(116,111,114,115,111))
if _0x527A and _0x97B4(_0x527A.CFrame) then
for _0x9094 = 1, 4 do
if not _0x32EC.Parent or not _0x527A.Parent then break end
_0x32EC.CFrame = _0x527A.CFrame * CFrame.new(0, 0, 0.35)
_0x32EC.AssemblyLinearVelocity = Vector3.zero
_0xC77A.Heartbeat:Wait()
end
end
end
elseif _0xA3C6 ==string.char(82,101,118,101,114,115,101,70,108,105,110,103)then
local _0xAD41 = tick()
while tick() - _0xAD41 < 0.26 do
if not _0x32EC.Parent or not _0x59C0.Parent then break end
local _0x6299 = (tick() - _0xAD41) * 48
local _0x6355 = _0x59C0.AssemblyLinearVelocity
local _0x1857 = Vector3.new(_0x6355.X, 0, _0x6355.Z) * 0.06
_0x32EC.CFrame = CFrame.new(_0x59C0.Position + _0x1857 + Vector3.new(math.cos(_0x6299) * 1.1, 0.3, math.sin(_0x6299) * 1.1))
* CFrame.Angles(_0x6299, _0x6299 * 1.5, 0)
_0x32EC.AssemblyAngularVelocity = Vector3.new(95000, 95000, 95000)
_0x32EC.AssemblyLinearVelocity = Vector3.new(math.random(-22000, 22000), 48000, math.random(-22000, 22000))
_0xC77A.Heartbeat:Wait()
end
elseif _0xA3C6 ==string.char(86,111,105,100,80,97,117,115,101)then
for _0x9094 = 1, 7 do
if not _0x32EC.Parent then break end
_0x32EC.CFrame = _0x89B7
_0x32EC.AssemblyLinearVelocity = Vector3.new(0, -78000, 0)
_0x32EC.AssemblyAngularVelocity = Vector3.new(45000, 0, 45000)
_0xC77A.Heartbeat:Wait()
end
elseif _0xA3C6 ==string.char(82,101,100,105,114,101,99,116)then
local _0xB5AA = _0xA4B1(attacker)
local _0x527A = _0xB5AA and _0xB5AA.Character and _0x76B4(_0xB5AA.Character,string.char(116,111,114,115,111))
if _0x527A and _0x97B4(_0x527A.CFrame) then
local _0xAD41 = tick()
while tick() - _0xAD41 < 0.30 do
if not _0x32EC.Parent or not _0x527A.Parent then break end
_0x32EC.AssemblyLinearVelocity = Vector3.zero
_0x32EC.AssemblyAngularVelocity = Vector3.zero
_0x32EC.CFrame = _0x527A.CFrame * CFrame.new(0, 0, 0.32)
_0xC77A.Heartbeat:Wait()
end
else
for _0x9094 = 1, 6 do
if not _0x32EC.Parent then break end
_0x32EC.CFrame = _0x89B7
_0x32EC.AssemblyLinearVelocity = Vector3.new(0, -70000, 0)
_0xC77A.Heartbeat:Wait()
end
end
elseif _0xA3C6 ==string.char(66,108,97,99,107,104,111,108,101)then
local _0xAD41 = tick()
while tick() - _0xAD41 < 0.26 do
if not _0x32EC.Parent or not _0x59C0.Parent then break end
local _0xDFBB = tick() - _0xAD41
local _0x2AC4 = 0.8 + (_0xDFBB * 18)
local _0xFD1C = _0xDFBB * 58
local _0x4CD8 = Vector3.new(math.cos(_0xFD1C) * _0x2AC4, 0.6, math.sin(_0xFD1C) * _0x2AC4)
_0x32EC.CFrame = CFrame.lookAt(_0x59C0.Position + _0x4CD8, _0x59C0.Position)
_0x32EC.AssemblyLinearVelocity = _0x4CD8.Unit * 58000
_0x32EC.AssemblyAngularVelocity = Vector3.new(0, 95000, 0)
_0xC77A.Heartbeat:Wait()
end
elseif _0xA3C6 ==string.char(83,107,121,79,114,98,105,116)then
local _0x0D54 = CFrame.new(_0x6CC4.Position.X, math.min(_0x6CC4.Position.Y + 18000, 45000), _0x6CC4.Position.Z)
for _0x9094 = 1, 5 do
if not _0x32EC.Parent or not _0x59C0.Parent then break end
_0x32EC.CFrame = _0x59C0.CFrame
_0x32EC.AssemblyLinearVelocity = Vector3.new(0, 85000, 0)
_0x32EC.AssemblyAngularVelocity = Vector3.new(85000, 85000, 85000)
_0xC77A.Heartbeat:Wait()
end
for _0x9094 = 1, 4 do
if not _0x32EC.Parent then break end
_0x32EC.CFrame = _0x0D54
_0x32EC.AssemblyLinearVelocity = Vector3.new(0, 90000, 0)
_0xC77A.Heartbeat:Wait()
end
end
_0x1FB2 = tick()
_0x363C(_0x6CC4)
_0xDF2E(_0x1213, _0x6CC4)
task.wait(0.06)
if _0x6EE9 then
pcall(function()
_0x6EE9.CameraType = _0x3829 or Enum.CameraType.Custom
if _0x4545 then _0x6EE9.CameraSubject = _0x4545 end
end)
end
_0x1978 = false
if _0x8AC6 then pcall(_0x8AC6) end
end
_0xC77A.Heartbeat:Connect(function(_0x004C)
if not _0x7DE1.enabled and not _0x5DAB.Redirect.enabled and not _0x5DAB.PauseTrap.enabled then
return
end
if _0x1B4F() or _0x1978 or (_0xAE44 and _0xAE44.rewinding) then return end
local _0x1213 = _0xA6AA.Character
local _0x32EC = _0x4DA4(_0x1213)
local _0x4545 = _0x1213 and _0x1213:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if not _0x32EC or not _0x4545 or _0x4545.Health <= 0 then return end
local _0x3ABA = _0x7DE1.enabled and (_0x7DE1.range or 7.5) or 6.5
local _0x60A3 = tick()
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= _0xA6AA and _0x1CEE.Character then
local _0xEC72 = _0x76B4(_0x1CEE.Character,string.char(116,111,114,115,111))
local _0x6143 = _0x1CEE.Character:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xEC72 and (not _0x6143 or _0x6143.Health > 0) then
local _0x0E43 = (_0xEC72.Position - _0x32EC.Position).Magnitude
local _0x6355 = _0xEC72.AssemblyLinearVelocity
local _0x1C8D = _0x6355.Magnitude
local _0xC034 = _0xEC72.AssemblyAngularVelocity.Magnitude
local _0xFD85 = (_0x32EC.Position - _0xEC72.Position)
local _0xAB48 = (_0xFD85.Magnitude > 0.01) and _0x6355:Dot(_0xFD85.Unit) or 0
local _0x6B0A = _0xD7A4[_0x1CEE.UserId]
_0xD7A4[_0x1CEE.UserId] = _0xEC72.Position
local _0x30F8 = _0x6B0A and (_0xEC72.Position - _0x6B0A).Magnitude or 0
local _0x1510 = (_0x1C8D > 85 or _0xC034 > 45) and _0x0E43 <= (_0x3ABA * 2.4)
local _0xF19D = _0x0E43 <= (_0x3ABA + 1.5) and (
(_0x6143 and (_0x6143.PlatformStand or _0x6143.Sit or _0x6143:GetState() == Enum.HumanoidStateType.Physics))
or (_0x0E43 < 4.2 and _0x30F8 > 1.1)
or _0xAB48 > 42
)
if _0x1510 or _0xF19D or _0x0E43 <= _0x3ABA then
local _0x9766 = 1.0
local _0x4F8A =string.char(65,117,114,97,32,67,111,110,116,97,99,116)if _0x1510 then
_0x9766 = 5.0
_0x4F8A =string.char(70,108,105,110,103,32,83,112,105,110,110,101,114)elseif _0xF19D then
_0x9766 = 3.8
_0x4F8A =string.char(87,101,108,100,47,84,114,111,108,108,32,76,111,99,107)end
_0x8A10[_0x1CEE.UserId] = (_0x8A10[_0x1CEE.UserId] or 0) + _0x004C * _0x9766
local _0x1C78 = _0x77B5[_0x1CEE.UserId] or 0
if (_0x8A10[_0x1CEE.UserId] >= 0.12 or _0x1510 or _0xF19D) and (_0x60A3 - _0x1C78) > 0.65 then
_0x77B5[_0x1CEE.UserId] = _0x60A3
_0x8A10[_0x1CEE.UserId] = 0
task.spawn(function() _0x6876(_0x1CEE, _0x4F8A) end)
break
end
else
_0x8A10[_0x1CEE.UserId] = math.max(0, (_0x8A10[_0x1CEE.UserId] or 0) - _0x004C * 2)
end
end
end
end
end)
_0xA023 = function()
_0x5DAB.Redirect.enabled = true
if _0x207A then pcall(_0x207A) end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(84,114,111,108,108,32,82,101,100,105,114,101,99,116,32,79,78,32,40,116,114,97,110,115,102,101,114,115,32,97,116,116,97,99,107,101,114,115,32,116,111,32,97,110,111,116,104,101,114,32,112,108,97,121,101,114,41))
_0xF140()
end
_0xDCCA = function()
_0x5DAB.Redirect.enabled = false
if _0x207A then pcall(_0x207A) end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(84,114,111,108,108,32,82,101,100,105,114,101,99,116,32,100,105,115,97,98,108,101,100))
_0xED6E()
end
_0x5DAB.Redirect.startFn = _0xA023
_0x5DAB.Redirect.stopFn = _0xDCCA
_0x91B8 = function()
_0x5DAB.PauseTrap.enabled = true
if _0x207A then pcall(_0x207A) end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(86,111,105,100,45,80,97,117,115,101,32,84,114,97,112,32,79,78,32,40,98,97,110,105,115,104,101,115,32,119,101,108,100,101,100,32,97,116,116,97,99,107,101,114,115,41))
_0xF140()
end
_0x1419 = function()
_0x5DAB.PauseTrap.enabled = false
if _0x207A then pcall(_0x207A) end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(86,111,105,100,45,80,97,117,115,101,32,84,114,97,112,32,100,105,115,97,98,108,101,100))
_0xED6E()
end
_0x5DAB.PauseTrap.startFn = _0x91B8
_0x5DAB.PauseTrap.stopFn = _0x1419
_0x9887 = function()
_0x7DE1.enabled = true
_0xC237()
if _0x207A then pcall(_0x207A) end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(68,101,102,101,110,99,101,32,84,114,111,108,108,32,77,97,116,114,105,120,32,118,51,32,79,78,58,32).. (_0x7DE1.modeLabels[_0x7DE1.mode] or _0x7DE1.mode))
_0xF140()
end
_0x41CA = function()
_0x7DE1.enabled = false
if _0x207A then pcall(_0x207A) end
if _0xA00F then pcall(_0xA00F) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(68,101,102,101,110,99,101,32,84,114,111,108,108,32,77,97,116,114,105,120,32,79,70,70))
_0xED6E()
end
_0x7DE1.startFn = _0x9887
_0x7DE1.stopFn = _0x41CA_0x5DAB.enforceAlwaysOn = function(silent)
_0xFC7F(silent ~= false)
_0x5DAB.InfFallVoid.startFn(silent ~= false)
_0xE9DA(silent ~= false)
_0x5DAB.SeatTrap.startFn(silent ~= false)
_0xFE3D(silent ~= false)
_0xE1A6(silent ~= false)
_0x0E9F(silent ~= false)
end
_0x4D8B = function()
_0x5DAB.enforceAlwaysOn(true)
_0x9887()
_0xA25E()
_0xC237()
_0x557D()
_0x2D4F()
_0x8E13()
if _0x5DAB.ToolGuard.startFn then _0x5DAB.ToolGuard.startFn() end
if _0x5DAB.Kick.startFn then _0x5DAB.Kick.startFn() end
_0x486A()
if _0x8AC6 then pcall(_0x8AC6) end
if _0xA00F then pcall(_0xA00F) end
if _0x207A then pcall(_0x207A) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(239,191,189,239,191,189,239,184,143,32,65,76,76,32,70,85,76,76,45,76,73,66,82,65,82,89,32,86,52,32,65,78,84,73,32,83,72,73,69,76,68,83,32,65,67,84,73,86,65,84,69,68,33))
_0xCAE4()
end
_0x65FF = function()
_0x41CA()
_0xDCCA()
_0x1419()
_0x0606()
_0x7E9F()
_0x3D9F()
_0xA4A6()
_0xE011()
if _0x5DAB.ToolGuard.stopFn then _0x5DAB.ToolGuard.stopFn() end
if _0x5DAB.AntiHeadsit.stopFn then _0x5DAB.AntiHeadsit.stopFn() end
if _0x5DAB.GlitchDesync.stopFn then _0x5DAB.GlitchDesync.stopFn() end
if _0x5DAB.Kick.stopFn then _0x5DAB.Kick.stopFn() end
_0xF12C()
_0x559B()_0x5DAB.enforceAlwaysOn(true)
if _0x8AC6 then pcall(_0x8AC6) end
if _0xA00F then pcall(_0xA00F) end
if _0x207A then pcall(_0x207A) end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(79,112,116,105,111,110,97,108,32,115,104,105,101,108,100,115,32,111,102,102,32,194,183,32,67,111,114,101,32,65,110,116,105,45,83,105,116,47,86,111,105,100,47,76,97,103,47,70,114,101,101,122,101,32,114,101,109,97,105,110,32,65,76,87,65,89,83,45,79,78,33))
_0xED6E()
end
_0x5DAB.enableAll = _0x4D8B
_0x5DAB.disableAll = _0x65FF_0x5DAB.enforceAlwaysOn(true)
do
local _0x9FF2 = 0
_0xC77A.Heartbeat:Connect(function()
local _0x60A3 = tick()
if _0x60A3 - _0x9FF2 < 0.75 then return end
_0x9FF2 = _0x60A3
if _0x5DAB.AlwaysOnCore then
if not _0x5DAB.Void.enabled or not _0x5DAB.Void.steppedConn then _0xFC7F(true) end
if not _0x5DAB.InfFallVoid.enabled then _0x5DAB.InfFallVoid.startFn(true) end
if not _0x5DAB.Ragdoll.enabled or not _0x5DAB.Ragdoll.steppedConn then _0xE9DA(true) end
if not _0x5DAB.SeatTrap.enabled or not _0x5DAB.SeatTrap.wsDescConn then _0x5DAB.SeatTrap.startFn(true) end
if not _0x5DAB.Lag.enabled or not _0x5DAB.Lag.loopConn then _0xFE3D(true) end
if not _0x5DAB.Anchor.enabled or not _0x5DAB.Anchor.steppedConn then _0xE1A6(true) end
if not _0x5DAB.GamePaused.enabled or not _0x5DAB.GamePaused.loopConn then _0x0E9F(true) end
end
end)
end
end)()local function _0xA046()
local _0xCE1E = workspace.CurrentCamera or _0x8319
local _0xE944 = _0xCE1E and _0xCE1E.ViewportSize or Vector2.new(1280, 720)
local _0x02A0 = (_0xE944 and _0xE944.X > 300) and _0xE944.X or 1280
local _0x1C98 = (_0xE944 and _0xE944.Y > 300) and _0xE944.Y or 720local function _0x41C9(sw, sh)
local _0x25EB = math.clamp(sw - 28, 316, sw >= 900 and 444 or 376)
local _0xA077 = math.clamp(math.floor(sh * 0.52), 336, 412)
return _0x25EB, _0xA077
end
local _0x3571, _0xFC21 = _0x41C9(_0x02A0, _0x1C98)
local _0x5140 = { minimized = false, open = true }
local _0xF7E0, _0xDADC, _0x216D
local _0xD822
_0xF28E = Instance.new(string.char(83,99,114,101,101,110,71,117,105))
_0xF28E.Name =string.char(75,104,97,109,97,110,68,104,111,107,108,97,86,51,55)_0xF28E.ResetOnSpawn = false
_0xF28E.Enabled = true
_0xF28E.DisplayOrder = 999999
_0xF28E.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_0xF28E.IgnoreGuiInset = true
local _0x389F = pcall(function() _0xF28E.Parent = _0x9617 end)
if not _0x389F or not _0xF28E.Parent then
local _0x5E61 = _0xA6AA:FindFirstChildOfClass(string.char(80,108,97,121,101,114,71,117,105)) or _0xA6AA:WaitForChild(string.char(80,108,97,121,101,114,71,117,105), 8)
if not _0x5E61 then error(string.char(78,111,32,117,115,97,98,108,101,32,80,108,97,121,101,114,71,117,105,32,102,111,117,110,100,32,119,104,105,108,101,32,109,111,117,110,116,105,110,103,32,75,72,65,77,65,78,32,68,72,79,75,76,65,32,83,99,114,101,101,110,71,117,105)) end
_0xF28E.Parent = _0x5E61
end_0xA2C6 = Instance.new(string.char(70,114,97,109,101))
_0xA2C6.Name =string.char(75,104,97,109,97,110,70,108,105,110,103,72,85,68)_0xA2C6.Size = UDim2.new(0, 216, 0, 54)
_0xA2C6.Position = UDim2.new(0.5, -108, 0, 14)
_0xA2C6.BackgroundColor3 = _0x90E7.BG2
_0xA2C6.BackgroundTransparency = 0.04
_0xA2C6.BorderSizePixel = 0
_0xA2C6.Visible = false
_0xA2C6.ZIndex = 960
_0xA2C6.Parent = _0xF28E
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xA2C6).CornerRadius = UDim.new(0, 10)
do
local _0xD9E3 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0xD9E3.Color = _0x90E7.Accent
_0xD9E3.Thickness = 1.6
_0xD9E3.Parent = _0xA2C6
_0x3FD6 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x3FD6.Size = UDim2.new(1, -78, 1, -8)
_0x3FD6.Position = UDim2.new(0, 10, 0, 4)
_0x3FD6.BackgroundTransparency = 1
_0x3FD6.Text =string.char(86,79,73,68,32,76,79,67,75,32,65,67,84,73,86,69)_0x3FD6.TextColor3 = _0x90E7.Neon
_0x3FD6.Font = Enum.Font.GothamBold
_0x3FD6.TextSize = 11
_0x3FD6.TextXAlignment = Enum.TextXAlignment.Left
_0x3FD6.ZIndex = 961
_0x3FD6.Parent = _0xA2C6
local _0x2105 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x2105.Size = UDim2.new(0, 58, 0, 34)
_0x2105.Position = UDim2.new(1, -66, 0.5, -17)
_0x2105.BackgroundColor3 = _0x90E7.Danger
_0x2105.Text =string.char(83,84,79,80)_0x2105.TextColor3 = Color3.new(1, 1, 1)
_0x2105.Font = Enum.Font.GothamBold
_0x2105.TextSize = 10
_0x2105.ZIndex = 962
_0x2105.Parent = _0xA2C6
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x2105).CornerRadius = UDim.new(0, 7)
_0x2105.MouseButton1Click:Connect(function()
_0x0909()
_0x3C23:StopFling(false)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(83,116,111,112,112,101,100,32,102,108,105,110,103,32,38,32,114,101,116,117,114,110,101,100,32,116,111,32,115,97,102,101,32,115,112,111,116,33))
end)
endlocal _0xC02C = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xC02C.Name =string.char(75,104,97,109,97,110,68,104,111,107,108,97,76,97,117,110,99,104,101,114)_0xC02C.Size = UDim2.new(0, 46, 0, 46)
_0xC02C.Position = UDim2.new(0, 14, 0.5, -23)
_0xC02C.BackgroundColor3 = Color3.fromRGB(242, 188, 18)
_0xC02C.BackgroundTransparency = 0.02
_0xC02C.Text =string.char(75,68)_0xC02C.TextColor3 = Color3.fromRGB(24, 16, 4)
_0xC02C.Font = Enum.Font.GothamBlack
_0xC02C.TextSize = 14
_0xC02C.AutoButtonColor = false
_0xC02C.Active = true
_0xC02C.ZIndex = 999
_0xC02C.Visible = false
_0xC02C.Parent = _0xF28E
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xC02C).CornerRadius = UDim.new(0, 12)
local _0x84A1 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x84A1.Color = _0x90E7.Neon
_0x84A1.Thickness = 1.8
_0x84A1.Transparency = 0.08
_0x84A1.Parent = _0xC02C
local _0xFC29 = Instance.new(string.char(70,114,97,109,101))
_0xFC29.Size = UDim2.new(0, 9, 0, 9)
_0xFC29.Position = UDim2.new(1, -10, 1, -10)
_0xFC29.BackgroundColor3 = _0x90E7.Success
_0xFC29.BorderSizePixel = 0
_0xFC29.ZIndex = 1000
_0xFC29.Parent = _0xC02C
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xFC29).CornerRadius = UDim.new(1, 0)local _0x5C62 = Instance.new(string.char(70,114,97,109,101))
_0x5C62.Name =string.char(75,104,97,109,97,110,68,104,111,107,108,97,68,97,115,104,98,111,97,114,100)_0x5C62.Size = UDim2.new(0, _0x3571, 0, _0xFC21)
_0x5C62.Position = UDim2.new(0.5, -_0x3571/2, 0.56, -_0xFC21/2)
_0x5C62.BackgroundColor3 = Color3.fromRGB(44, 33, 9)
_0x5C62.BackgroundTransparency = 0.02
_0x5C62.BorderSizePixel = 0
_0x5C62.ClipsDescendants = true
_0x5C62.Active = true
_0x5C62.ZIndex = 5
_0x5C62.Parent = _0xF28E
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x5C62).CornerRadius = UDim.new(0, 15)
local _0x93AB = Instance.new(string.char(85,73,83,99,97,108,101))
_0x93AB.Scale = 1
_0x93AB.Parent = _0x5C62do
local _0xB42F = Instance.new(string.char(85,73,71,114,97,100,105,101,110,116))
_0xB42F.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0.0, Color3.fromRGB(82, 62, 15)),
ColorSequenceKeypoint.new(0.45, Color3.fromRGB(48, 36, 10)),
ColorSequenceKeypoint.new(1.0, Color3.fromRGB(30, 22, 6)),
})
_0xB42F.Rotation = 135
_0xB42F.Parent = _0x5C62
local _0x7466 = Instance.new(string.char(70,114,97,109,101))
_0x7466.Name =string.char(84,111,112,84,117,114,109,101,114,105,99,71,108,111,119)_0x7466.Size = UDim2.new(1, 0, 0, 2)
_0x7466.Position = UDim2.new(0, 0, 0, 0)
_0x7466.BackgroundColor3 = _0x90E7.Accent
_0x7466.BorderSizePixel = 0
_0x7466.ZIndex = 12
_0x7466.Parent = _0x5C62
local _0x82DE = Instance.new(string.char(85,73,71,114,97,100,105,101,110,116))
_0x82DE.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0.0, Color3.fromRGB(217, 138, 10)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(254, 243, 148)),
ColorSequenceKeypoint.new(1.0, Color3.fromRGB(42, 196, 88)),
})
_0x82DE.Parent = _0x7466
local _0x67E0 = Instance.new(string.char(70,114,97,109,101))
_0x67E0.Name =string.char(75,104,97,109,97,110,68,104,111,107,108,97,83,112,111,110,103,101,84,101,120,116,117,114,101)_0x67E0.Size = UDim2.new(1, 0, 1, 0)
_0x67E0.BackgroundTransparency = 1
_0x67E0.ZIndex = 5
_0x67E0.Active = false
_0x67E0.Parent = _0x5C62
local _0xABD3 = {{ x = 0.07, y = 0.27, sz = 14, _0xD6A9 = Color3.fromRGB(250, 204, 21), _0x6F27 = 0.89 },
{ x = 0.21, y = 0.44, sz = 10, _0xD6A9 = Color3.fromRGB(250, 204, 21), _0x6F27 = 0.91 },
{ x = 0.47, y = 0.32, sz = 18, _0xD6A9 = Color3.fromRGB(250, 204, 21), _0x6F27 = 0.90 },
{ x = 0.73, y = 0.25, sz = 12, _0xD6A9 = Color3.fromRGB(250, 204, 21), _0x6F27 = 0.89 },
{ x = 0.88, y = 0.51, sz = 16, _0xD6A9 = Color3.fromRGB(250, 204, 21), _0x6F27 = 0.89 },
{ x = 0.15, y = 0.75, sz = 15, _0xD6A9 = Color3.fromRGB(250, 204, 21), _0x6F27 = 0.90 },
{ x = 0.62, y = 0.71, sz = 13, _0xD6A9 = Color3.fromRGB(250, 204, 21), _0x6F27 = 0.90 },
{ x = 0.83, y = 0.81, sz = 11, _0xD6A9 = Color3.fromRGB(250, 204, 21), _0x6F27 = 0.89 },{ x = 0.12, y = 0.35, sz = 4, _0xD6A9 = Color3.fromRGB(16, 12, 4), _0x6F27 = 0.42 },
{ x = 0.34, y = 0.24, sz = 5, _0xD6A9 = Color3.fromRGB(16, 12, 4), _0x6F27 = 0.42 },
{ x = 0.57, y = 0.47, sz = 4, _0xD6A9 = Color3.fromRGB(16, 12, 4), _0x6F27 = 0.42 },
{ x = 0.80, y = 0.37, sz = 5, _0xD6A9 = Color3.fromRGB(16, 12, 4), _0x6F27 = 0.42 },
{ x = 0.28, y = 0.67, sz = 4, _0xD6A9 = Color3.fromRGB(16, 12, 4), _0x6F27 = 0.42 },
{ x = 0.71, y = 0.63, sz = 5, _0xD6A9 = Color3.fromRGB(16, 12, 4), _0x6F27 = 0.42 },{ x = 0.18, y = 0.28, sz = 6, _0xD6A9 = Color3.fromRGB(42, 196, 88), _0x6F27 = 0.70 },
{ x = 0.66, y = 0.30, sz = 7, _0xD6A9 = Color3.fromRGB(42, 196, 88), _0x6F27 = 0.70 },
{ x = 0.41, y = 0.78, sz = 6, _0xD6A9 = Color3.fromRGB(42, 196, 88), _0x6F27 = 0.70 },
{ x = 0.90, y = 0.66, sz = 6, _0xD6A9 = Color3.fromRGB(42, 196, 88), _0x6F27 = 0.70 },
}
for _0x9094, _0xE21C in ipairs(_0xABD3) do
local _0x4D9D = Instance.new(string.char(70,114,97,109,101))
_0x4D9D.Size = UDim2.new(0, _0xE21C.sz, 0, _0xE21C.sz)
_0x4D9D.Position = UDim2.new(_0xE21C.x, 0, _0xE21C.y, 0)
_0x4D9D.BackgroundColor3 = _0xE21C.col
_0x4D9D.BackgroundTransparency = _0xE21C.tr
_0x4D9D.BorderSizePixel = 0
_0x4D9D.ZIndex = 5
_0x4D9D.Active = false
_0x4D9D.Parent = _0x67E0
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4D9D).CornerRadius = UDim.new(1, 0)
end
end
_0xD822 = Instance.new(string.char(70,114,97,109,101))
_0xD822.Name =string.char(80,97,110,101,108,83,104,97,100,111,119)_0xD822.Position = UDim2.new(0.5, -_0x3571/2 - 5, 0.56, -_0xFC21/2 + 5)
_0xD822.Size = UDim2.new(0, _0x3571 + 10, 0, _0xFC21 + 10)
_0xD822.BackgroundColor3 = Color3.fromRGB(14, 10, 2)
_0xD822.BackgroundTransparency = 0.42
_0xD822.BorderSizePixel = 0
_0xD822.ZIndex = 4
_0xD822.Parent = _0xF28E
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xD822).CornerRadius = UDim.new(0, 18)
local _0x2612 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x2612.Color = _0x90E7.Accent
_0x2612.Thickness = 1.5
_0x2612.Transparency = 0.16
_0x2612.Parent = _0x5C62
local function _0xFBE5()
local _0xF556 = workspace.CurrentCamera
if not _0xF556 or not _0x5C62.Parent then return end
local _0x041F = _0xF556.ViewportSize
local _0x6B91, _0x676A = _0x41C9(_0x041F.X, _0x041F.Y)
_0x3571, _0xFC21 = _0x6B91, _0x676A
_0x5C62.Size = UDim2.new(0, _0x6B91, 0, _0x676A)
_0xD822.Size = UDim2.new(0, _0x6B91 + 10, 0, _0x676A + 10)
if not _0xF7E0 then
_0x5C62.Position = UDim2.new(0.5, -_0x6B91 / 2, 0.56, -_0x676A / 2)
_0xD822.Position = UDim2.new(0.5, -_0x6B91 / 2 - 5, 0.56, -_0x676A / 2 + 5)
end
end
local _0xF556 = workspace.CurrentCamera
if _0xF556 then
_0xF556:GetPropertyChangedSignal(string.char(86,105,101,119,112,111,114,116,83,105,122,101)):Connect(_0xFBE5)
end
local _0x3DFE
local _0x39F8, _0x79DD, _0x5CC3, _0xE7EF = false, nil, nil, false
local _0x76FF = 0
local function _0x8F99()
if tick() - _0x76FF < 0.12 then return end
_0x76FF = tick()
_0x0909()
if _0x3DFE then _0x3DFE(true) end
end
_0xC02C.InputBegan:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
_0x39F8 = true; _0x79DD = inp.Position; _0x5CC3 = _0xC02C.Position; _0xE7EF = false
end
end)
_0xB2E3.InputChanged:Connect(function(inp)
if _0x39F8 and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
local _0x5635 = inp.Position - _0x79DD
if math.abs(_0x5635.X) > 8 or math.abs(_0x5635.Y) > 8 then _0xE7EF = true end
if _0xE7EF then
_0xC02C.Position = UDim2.new(_0x5CC3.X.Scale, _0x5CC3.X.Offset + _0x5635.X, _0x5CC3.Y.Scale, _0x5CC3.Y.Offset + _0x5635.Y)
end
end
end)
_0xB2E3.InputEnded:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
if _0x39F8 and not _0xE7EF then _0x8F99() end
_0x39F8 = false
end
end)
_0xC02C.MouseButton1Click:Connect(function()
if not _0xE7EF then _0x8F99() end
end)
local _0x3BAC = setmetatable({}, {__mode =string.char(107)})
local function _0x961E(_0x4973, initialColor)
_0x3BAC[_0x4973] = initialColor
_0x4973.BackgroundColor3 = initialColor
_0x4973.AutoButtonColor = false
_0x4973.MouseEnter:Connect(function()
_0x9FE9()
if _0x3BAC[_0x4973] then
_0xFD0E:Create(_0x4973, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
BackgroundColor3 = _0x3BAC[_0x4973]:Lerp(_0x90E7.Neon, 0.12)
}):Play()
end
end)
_0x4973.MouseLeave:Connect(function()
if _0x3BAC[_0x4973] then
_0xFD0E:Create(_0x4973, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
BackgroundColor3 = _0x3BAC[_0x4973]
}):Play()
end
end)
endlocal _0x298C = Instance.new(string.char(70,114,97,109,101))
_0x298C.Name =string.char(72,101,97,100,101,114)_0x298C.Size = UDim2.new(1, 0, 0, 44)
_0x298C.BackgroundColor3 = _0x90E7.BG2
_0x298C.BackgroundTransparency = 0.08
_0x298C.BorderSizePixel = 0
_0x298C.ZIndex = 6
_0x298C.Parent = _0x5C62
local _0xBD5D = Instance.new(string.char(70,114,97,109,101))
_0xBD5D.Size = UDim2.new(1, -20, 0, 1)
_0xBD5D.Position = UDim2.new(0, 10, 1, -1)
_0xBD5D.BackgroundColor3 = _0x90E7.Border
_0xBD5D.BackgroundTransparency = 0.35
_0xBD5D.BorderSizePixel = 0
_0xBD5D.ZIndex = 7
_0xBD5D.Parent = _0x298C
local _0x0A87 = Instance.new(string.char(70,114,97,109,101))
_0x0A87.Size = UDim2.new(0, 28, 0, 28)
_0x0A87.Position = UDim2.new(0, 11, 0.5, -14)
_0x0A87.BackgroundColor3 = _0x90E7.Accent
_0x0A87.BorderSizePixel = 0
_0x0A87.ZIndex = 8
_0x0A87.Parent = _0x298C
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x0A87).CornerRadius = UDim.new(0, 8)
local _0x1E42 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x1E42.Color = _0x90E7.Neon
_0x1E42.Thickness = 1.2
_0x1E42.Transparency = 0.2
_0x1E42.Parent = _0x0A87
local _0x5334 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x5334.Size = UDim2.new(1, 0, 1, 0)
_0x5334.BackgroundTransparency = 1
_0x5334.Text =string.char(75,68)_0x5334.TextColor3 = _0x90E7.Dark
_0x5334.Font = Enum.Font.GothamBlack
_0x5334.TextSize = 11
_0x5334.ZIndex = 9
_0x5334.Parent = _0x0A87
_0x2DB3 = function(msg)
pcall(function()
if not _0xF28E or not _0xF28E.Parent then return end
local _0x9AED = _0xF28E:FindFirstChild(string.char(75,104,97,109,97,110,68,101,102,101,110,99,101,84,111,97,115,116))
if _0x9AED then _0x9AED:Destroy() end
local _0x2619 = Instance.new(string.char(70,114,97,109,101))
_0x2619.Name =string.char(75,104,97,109,97,110,68,101,102,101,110,99,101,84,111,97,115,116)_0x2619.Size = UDim2.new(0, 286, 0, 34)
_0x2619.Position = UDim2.new(0.5, -143, 0, -42)
_0x2619.BackgroundColor3 = _0x90E7.BG2
_0x2619.BorderSizePixel = 0
_0x2619.ZIndex = 500
_0x2619.Parent = _0xF28E
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x2619).CornerRadius = UDim.new(0, 9)
local _0x8A3B = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x8A3B.Color = _0x90E7.Accent
_0x8A3B.Thickness = 1.4
_0x8A3B.Transparency = 0.15
_0x8A3B.Parent = _0x2619
local _0xE687 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0xE687.Size = UDim2.new(1, -12, 1, 0)
_0xE687.Position = UDim2.new(0, 6, 0, 0)
_0xE687.BackgroundTransparency = 1
_0xE687.Text = msg
_0xE687.TextColor3 = _0x90E7.Text
_0xE687.Font = Enum.Font.GothamBold
_0xE687.TextSize = 10
_0xE687.ZIndex = 501
_0xE687.Parent = _0x2619
_0xFD0E:Create(_0x2619, TweenInfo.new(0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
Position = UDim2.new(0.5, -143, 0, 16)
}):Play()
task.delay(2.5, function()
if _0x2619 and _0x2619.Parent then
local _0x521B = _0xFD0E:Create(_0x2619, TweenInfo.new(0.22), {
Position = UDim2.new(0.5, -143, 0, -42),
BackgroundTransparency = 1
})
_0x521B:Play()
_0x521B.Completed:Connect(function() _0x2619:Destroy() end)
end
end)
end)
end
local _0x3409 = (_0xB2E3.TouchEnabled and not _0xB2E3.KeyboardEnabled) or _0xB2E3.TouchEnabled
local _0x1412 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x1412.Size = UDim2.new(1, -216, 0, 16)
_0x1412.Position = UDim2.new(0, 46, 0.5, -13)
_0x1412.BackgroundTransparency = 1
_0x1412.Text =string.char(239,191,189,239,191,189,32,75,72,65,77,65,78,32,68,72,79,75,76,65)_0x1412.TextColor3 = _0x90E7.Accent
_0x1412.Font = Enum.Font.GothamBlack
_0x1412.TextSize = 12
_0x1412.TextXAlignment = Enum.TextXAlignment.Left
_0x1412.ZIndex = 8
_0x1412.Parent = _0x298C
local _0x1159 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x1159.Size = UDim2.new(1, -216, 0, 12)
_0x1159.Position = UDim2.new(0, 46, 0.5, 4)
_0x1159.BackgroundTransparency = 1
_0x1159.Text =string.char(90,69,82,79,45,68,69,76,65,89,32,86,51,55,32,32,194,183,32,32).. (_0x3409 andstring.char(239,191,189,239,191,189,32,65,78,68,82,79,73,68)orstring.char(239,191,189,239,191,189,32,80,67))
_0x1159.TextColor3 = _0x90E7.Neon
_0x1159.Font = Enum.Font.GothamMedium
_0x1159.TextSize = 8
_0x1159.TextXAlignment = Enum.TextXAlignment.Left
_0x1159.ZIndex = 8
_0x1159.Parent = _0x298Clocal _0x4BC0 = Instance.new(string.char(70,114,97,109,101))
_0x4BC0.Size = UDim2.new(0, 108, 0, 24)
_0x4BC0.Position = UDim2.new(1, -182, 0.5, -12)
_0x4BC0.BackgroundColor3 = _0x90E7.Panel
_0x4BC0.BorderSizePixel = 0
_0x4BC0.ZIndex = 8
_0x4BC0.Parent = _0x298C
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4BC0).CornerRadius = UDim.new(0, 7)
local _0x7EC4 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x7EC4.Color = _0x90E7.Border
_0x7EC4.Thickness = 1
_0x7EC4.Transparency = 0.4
_0x7EC4.Parent = _0x4BC0
local _0x136D = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x136D.Size = UDim2.new(1, 0, 1, 0)
_0x136D.BackgroundTransparency = 1
_0x136D.Text =string.char(54,48,32,70,80,83,32,194,183,32,239,191,189,239,191,189,239,184,143,32,48)_0x136D.TextColor3 = _0x90E7.Text
_0x136D.Font = Enum.Font.GothamBold
_0x136D.TextSize = 9
_0x136D.ZIndex = 9
_0x136D.Parent = _0x4BC0
task.spawn(function()
local _0x5C36 = tick()
local _0x3C30 = 0
_0xC77A.RenderStepped:Connect(function()
_0x3C30 = _0x3C30 + 1
local _0x60A3 = tick()
if _0x60A3 - _0x5C36 >= 0.75 then
local _0xCFE8 = math.clamp(math.floor(_0x3C30 / (_0x60A3 - _0x5C36)), 1, 240)
_0x3C30 = 0
_0x5C36 = _0x60A3
local _0x1181 = 0
for _0x9094, sub in pairs(_0x5DAB) do
if typeof(sub) ==string.char(116,97,98,108,101)and sub.enabled then _0x1181 = _0x1181 + 1 end
end
if _0x7DE1.enabled then _0x1181 = _0x1181 + 1 end
local _0x0EAC = 0
pcall(function() _0x0EAC = math.floor(_0xA6AA:GetNetworkPing() * 1000) end)
if _0x136D and _0x136D.Parent then
if _0x0EAC > 0 then
_0x136D.Text = string.format(string.char(37,100,32,70,80,83,32,194,183,32,37,100,109,115,32,194,183,32,239,191,189,239,191,189,239,184,143,37,100), _0xCFE8, _0x0EAC, _0x1181)
else
_0x136D.Text = string.format(string.char(37,100,32,70,80,83,32,194,183,32,239,191,189,239,191,189,239,184,143,32,37,100), _0xCFE8, _0x1181)
end
end
end
end)
end)
local function _0x321D(xOffset, labelText, bgCol)
local _0x4973 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x4973.Size = UDim2.new(0, 26, 0, 26)
_0x4973.Position = UDim2.new(1, xOffset, 0.5, -13)
_0x4973.BackgroundColor3 = bgCol
_0x4973.Text = labelText
_0x4973.TextColor3 = _0x90E7.Text
_0x4973.Font = Enum.Font.GothamBold
_0x4973.TextSize = 12
_0x4973.AutoButtonColor = false
_0x4973.ZIndex = 8
_0x4973.Parent = _0x298C
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4973).CornerRadius = UDim.new(0, 7)
_0x961E(_0x4973, bgCol)
return _0x4973
end
local _0xDF13 = _0x321D(-68,string.char(226,128,148), _0x90E7.PanelLt)
local _0xE18F = _0x321D(-36,string.char(88), _0x90E7.Accent2)
_0x298C.InputBegan:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
_0xF7E0 = true; _0xDADC = inp.Position; _0x216D = _0x5C62.Position
end
end)
_0xB2E3.InputChanged:Connect(function(inp)
if _0xF7E0 and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
local _0x000B = inp.Position - _0xDADC
_0x5C62.Position = UDim2.new(_0x216D.X.Scale, _0x216D.X.Offset + _0x000B.X, _0x216D.Y.Scale, _0x216D.Y.Offset + _0x000B.Y)
_0xD822.Position = UDim2.new(_0x5C62.Position.X.Scale, _0x5C62.Position.X.Offset - 5, _0x5C62.Position.Y.Scale, _0x5C62.Position.Y.Offset + 5)
end
end)
_0xB2E3.InputEnded:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
_0xF7E0 = false
end
end)local _0xF1AE = Instance.new(string.char(70,114,97,109,101))
_0xF1AE.Name =string.char(84,97,98,115,66,97,114)_0xF1AE.Size = UDim2.new(1, -20, 0, 34)
_0xF1AE.Position = UDim2.new(0, 10, 0, 48)
_0xF1AE.BackgroundColor3 = _0x90E7.BG2
_0xF1AE.BorderSizePixel = 0
_0xF1AE.ZIndex = 6
_0xF1AE.Parent = _0x5C62
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xF1AE).CornerRadius = UDim.new(0, 9)
local _0xD42C = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0xD42C.Color = _0x90E7.Border
_0xD42C.Thickness = 1
_0xD42C.Transparency = 0.4
_0xD42C.Parent = _0xF1AElocal _0x0326 = Instance.new(string.char(70,114,97,109,101))
_0x0326.Name =string.char(65,99,116,105,118,101,84,97,98,80,105,108,108)_0x0326.Size = UDim2.new(0.2, -4, 1, -4)
_0x0326.Position = UDim2.new(0, 2, 0, 2)
_0x0326.BackgroundColor3 = _0x90E7.Accent2
_0x0326.BorderSizePixel = 0
_0x0326.ZIndex = 7
_0x0326.Parent = _0xF1AE
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x0326).CornerRadius = UDim.new(0, 7)
do
local _0x9117 = Instance.new(string.char(85,73,71,114,97,100,105,101,110,116))
_0x9117.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0.0, Color3.fromRGB(245, 178, 18)),
ColorSequenceKeypoint.new(1.0, Color3.fromRGB(204, 122, 8)),
})
_0x9117.Rotation = 90
_0x9117.Parent = _0x0326
local _0x9BDA = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x9BDA.Color = _0x90E7.Neon
_0x9BDA.Thickness = 1
_0x9BDA.Transparency = 0.25
_0x9BDA.Parent = _0x0326
end
local _0x9FD5 = Instance.new(string.char(70,114,97,109,101))
_0x9FD5.Name =string.char(67,111,110,116,101,110,116)_0x9FD5.Size = UDim2.new(1, 0, 1, -126)
_0x9FD5.Position = UDim2.new(0, 0, 0, 86)
_0x9FD5.BackgroundTransparency = 1
_0x9FD5.ClipsDescendants = true
_0x9FD5.ZIndex = 6
_0x9FD5.Parent = _0x5C62local _0x0A55 = Instance.new(string.char(70,114,97,109,101))
_0x0A55.Name =string.char(70,111,111,116,101,114)_0x0A55.Size = UDim2.new(1, 0, 0, 40)
_0x0A55.Position = UDim2.new(0, 0, 1, -40)
_0x0A55.BackgroundColor3 = _0x90E7.BG2
_0x0A55.BorderSizePixel = 0
_0x0A55.ZIndex = 6
_0x0A55.Parent = _0x5C62
local _0x332D = Instance.new(string.char(70,114,97,109,101))
_0x332D.Size = UDim2.new(1, -20, 0, 1)
_0x332D.Position = UDim2.new(0, 10, 0, 0)
_0x332D.BackgroundColor3 = _0x90E7.Border
_0x332D.BackgroundTransparency = 0.38
_0x332D.BorderSizePixel = 0
_0x332D.ZIndex = 7
_0x332D.Parent = _0x0A55
local _0xD445 = Instance.new(string.char(70,114,97,109,101))
_0xD445.Size = UDim2.new(0, 8, 0, 8)
_0xD445.Position = UDim2.new(0, 12, 0.5, -4)
_0xD445.BackgroundColor3 = _0x90E7.Success
_0xD445.BorderSizePixel = 0
_0xD445.ZIndex = 8
_0xD445.Parent = _0x0A55
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xD445).CornerRadius = UDim.new(1, 0)
local _0xC3B1 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0xC3B1.Size = UDim2.new(1, -148, 0, 16)
_0xC3B1.Position = UDim2.new(0, 26, 0, 5)
_0xC3B1.BackgroundTransparency = 1
_0xC3B1.Text =string.char(65,117,116,111,58,32,78,101,97,114,101,115,116,32,80,108,97,121,101,114)_0xC3B1.TextColor3 = _0x90E7.Text
_0xC3B1.Font = Enum.Font.GothamBold
_0xC3B1.TextSize = 11
_0xC3B1.TextXAlignment = Enum.TextXAlignment.Left
_0xC3B1.TextTruncate = Enum.TextTruncate.AtEnd
_0xC3B1.ZIndex = 8
_0xC3B1.Parent = _0x0A55
local _0x00E5 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x00E5.Size = UDim2.new(1, -148, 0, 13)
_0x00E5.Position = UDim2.new(0, 26, 0, 21)
_0x00E5.BackgroundTransparency = 1
_0x00E5.Text =string.char(114,101,97,100,121,32,194,183,32,122,101,114,111,45,100,101,108,97,121,32,108,111,99,107,32,97,99,116,105,118,101)_0x00E5.TextColor3 = _0x90E7.Muted
_0x00E5.Font = Enum.Font.Gotham
_0x00E5.TextSize = 9
_0x00E5.TextXAlignment = Enum.TextXAlignment.Left
_0x00E5.TextTruncate = Enum.TextTruncate.AtEnd
_0x00E5.ZIndex = 8
_0x00E5.Parent = _0x0A55
local _0x4E18 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x4E18.Size = UDim2.new(0, 114, 0, 26)
_0x4E18.Position = UDim2.new(1, -124, 0.5, -13)
_0x4E18.Text =string.char(83,84,79,80,32,47,32,85,78,87,69,76,68)_0x4E18.TextColor3 = Color3.new(1, 1, 1)
_0x4E18.Font = Enum.Font.GothamBold
_0x4E18.TextSize = 10
_0x4E18.ZIndex = 8
_0x4E18.Parent = _0x0A55
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4E18).CornerRadius = UDim.new(0, 7)
_0x961E(_0x4E18, _0x90E7.Accent2)
local _0x2CD7, _0x4CB7, _0x6DC2 = {}, {}, {}
local _0x2165 = {}
local _0x7B45 = nil
local _0xB0A3 = 0local function _0x74C2(name)
if not _0x2CD7[name] then return end
local _0xEC07 = _0x7B45
_0x7B45 = name
local _0xF61B = _0x6DC2[name] or 1
local _0xD167 = (_0xEC07 and _0x6DC2[_0xEC07]) or _0xF61B
local _0x2ACE = math.max(1, #_0x2165)
local _0x31B5 = 1 / _0x2ACE_0xFD0E:Create(_0x0326, TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
Size = UDim2.new(_0x31B5, -4, 1, -4),
Position = UDim2.new((_0xF61B - 1) * _0x31B5, 2, 0, 2),
}):Play()
for _0x4D41, _0x4973 in pairs(_0x4CB7) do
local _0x0B5F = (_0x4D41 == name)
_0xFD0E:Create(_0x4973, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
TextColor3 = _0x0B5F and _0x90E7.Dark or _0x90E7.Muted,
}):Play()
end
if _0xEC07 == name then
_0x2CD7[name].Position = UDim2.new(0, 0, 0, 0)
_0x2CD7[name].Visible = true
return
end
_0xB0A3 = _0xB0A3 + 1
local _0xA639 = _0xB0A3
local _0x452C = (_0xF61B >= _0xD167) and 1 or -1
for _0x4D41, _0x1CEE in pairs(_0x2CD7) do
if _0x4D41 ~= name and _0x4D41 ~= _0xEC07 then
_0x1CEE.Visible = false
end
end
local _0x3974 = _0x2CD7[name]
local _0xB8F6 = _0xEC07 and _0x2CD7[_0xEC07] or nil
if _0xB8F6 and _0xB8F6 ~= _0x3974 then
_0xFD0E:Create(_0xB8F6, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
Position = UDim2.new(-0.08 * _0x452C, 0, 0, 0),
}):Play()
task.delay(0.18, function()
if _0xA639 == _0xB0A3 and _0x7B45 ~= _0xEC07 then
_0xB8F6.Visible = false
_0xB8F6.Position = UDim2.new(0, 0, 0, 0)
end
end)
end
_0x3974.Position = UDim2.new(0.10 * _0x452C, 0, 0, 6)
_0x3974.Visible = true
_0xFD0E:Create(_0x3974, TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
Position = UDim2.new(0, 0, 0, 0),
}):Play()
end
local function _0x79C5(name)
table.insert(_0x2165, name)
local _0x2665 = #_0x2165
_0x6DC2[name] = _0x2665
local _0x43E0 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x43E0.Name = name ..string.char(84,97,98,66,116,110)_0x43E0.BackgroundTransparency = 1
_0x43E0.BorderSizePixel = 0
_0x43E0.Text = name:upper()
_0x43E0.TextColor3 = _0x90E7.Muted
_0x43E0.Font = Enum.Font.GothamBlack
_0x43E0.TextSize = 10
_0x43E0.AutoButtonColor = false
_0x43E0.ZIndex = 8
_0x43E0.Parent = _0xF1AE
_0x43E0.MouseButton1Click:Connect(function() _0x0909(); _0x74C2(name) end)
_0x4CB7[name] = _0x43E0
local _0x2ACE = #_0x2165
for i, tabName in ipairs(_0x2165) do
local _0xD2E9 = _0x4CB7[tabName]
local _0x31B5 = 1 / _0x2ACE
_0xD2E9.Size = UDim2.new(_0x31B5, -4, 1, -4)
_0xD2E9.Position = UDim2.new((i - 1) * _0x31B5, 2, 0, 2)
end
_0x0326.Size = UDim2.new(1 / _0x2ACE, -4, 1, -4)
local _0xB578 = Instance.new(string.char(83,99,114,111,108,108,105,110,103,70,114,97,109,101))
_0xB578.Name = name ..string.char(80,97,103,101)_0xB578.Size = UDim2.new(1, 0, 1, 0)
_0xB578.BackgroundTransparency = 1
_0xB578.BorderSizePixel = 0
_0xB578.ScrollBarThickness = 3
_0xB578.ScrollBarImageColor3 = _0x90E7.Accent
_0xB578.CanvasSize = UDim2.new(0, 0, 0, 0)
_0xB578.AutomaticCanvasSize = Enum.AutomaticSize.Y
_0xB578.Visible = false
_0xB578.ZIndex = 6
_0xB578.Parent = _0x9FD5
local _0x26A5 = Instance.new(string.char(85,73,80,97,100,100,105,110,103))
_0x26A5.PaddingTop = UDim.new(0, 6)
_0x26A5.PaddingBottom = UDim.new(0, 8)
_0x26A5.PaddingLeft = UDim.new(0, 10)
_0x26A5.PaddingRight = UDim.new(0, 10)
_0x26A5.Parent = _0xB578
local _0x6B2A = Instance.new(string.char(85,73,76,105,115,116,76,97,121,111,117,116))
_0x6B2A.Padding = UDim.new(0, 6)
_0x6B2A.SortOrder = Enum.SortOrder.LayoutOrder
_0x6B2A.Parent = _0xB578
_0x2CD7[name] = _0xB578
return _0xB578
end
local function _0x8DC1(parent, order, txt, color)
local _0xEB52 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0xEB52.Size = UDim2.new(1, 0, 0, 14)
_0xEB52.BackgroundTransparency = 1
_0xEB52.Text = txt
_0xEB52.TextColor3 = color or _0x90E7.Muted
_0xEB52.Font = Enum.Font.GothamBold
_0xEB52.TextSize = 9
_0xEB52.TextXAlignment = Enum.TextXAlignment.Left
_0xEB52.LayoutOrder = order
_0xEB52.ZIndex = 7
_0xEB52.Parent = parent
return _0xEB52
endlocal _0x710C = _0x79C5(string.char(87,101,108,100))
local _0x30B6 = _0x79C5(string.char(84,97,114,103,101,116))
local _0xE441 = _0x79C5(string.char(67,104,97,116))
local _0x7261 = _0x79C5(string.char(65,110,116,105))
local _0xAC95 = _0x79C5(string.char(77,111,118,101))local _0xEDD7 = Instance.new(string.char(70,114,97,109,101))
_0xEDD7.Name =string.char(84,97,114,103,101,116,80,114,101,118,105,101,119)_0xEDD7.Size = UDim2.new(1, 0, 0, 52)
_0xEDD7.BackgroundColor3 = _0x90E7.Panel
_0xEDD7.BorderSizePixel = 0
_0xEDD7.LayoutOrder = 1
_0xEDD7.ZIndex = 7
_0xEDD7.Parent = _0x710C
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xEDD7).CornerRadius = UDim.new(0, 9)
local _0x04FE = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x04FE.Color = _0x90E7.Border
_0x04FE.Thickness = 1
_0x04FE.Transparency = 0.35
_0x04FE.Parent = _0xEDD7
local _0x29AA = Instance.new(string.char(70,114,97,109,101))
_0x29AA.Size = UDim2.new(0, 38, 0, 38)
_0x29AA.Position = UDim2.new(0, 8, 0.5, -19)
_0x29AA.BackgroundColor3 = _0x90E7.PanelLt
_0x29AA.BorderSizePixel = 0
_0x29AA.ZIndex = 8
_0x29AA.Parent = _0xEDD7
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x29AA).CornerRadius = UDim.new(1, 0)
local _0x2EDB = Instance.new(string.char(73,109,97,103,101,76,97,98,101,108))
_0x2EDB.Size = UDim2.new(1, 0, 1, 0)
_0x2EDB.BackgroundTransparency = 1
_0x2EDB.Image =""_0x2EDB.ZIndex = 9
_0x2EDB.Parent = _0x29AA
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x2EDB).CornerRadius = UDim.new(1, 0)
local _0xB6B7 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0xB6B7.Size = UDim2.new(1, 0, 1, 0)
_0xB6B7.BackgroundTransparency = 1
_0xB6B7.Text =string.char(63)_0xB6B7.TextColor3 = _0x90E7.Muted
_0xB6B7.Font = Enum.Font.GothamBold
_0xB6B7.TextSize = 15
_0xB6B7.ZIndex = 8
_0xB6B7.Parent = _0x29AA
local _0xD634 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0xD634.Size = UDim2.new(1, -124, 0, 18)
_0xD634.Position = UDim2.new(0, 54, 0, 8)
_0xD634.BackgroundTransparency = 1
_0xD634.Text =string.char(65,117,116,111,58,32,78,101,97,114,101,115,116,32,80,108,97,121,101,114)_0xD634.TextColor3 = _0x90E7.Text
_0xD634.Font = Enum.Font.GothamBold
_0xD634.TextSize = 12
_0xD634.TextXAlignment = Enum.TextXAlignment.Left
_0xD634.TextTruncate = Enum.TextTruncate.AtEnd
_0xD634.ZIndex = 9
_0xD634.Parent = _0xEDD7
local _0x6860 = Instance.new(string.char(70,114,97,109,101))
_0x6860.Size = UDim2.new(0, 6, 0, 6)
_0x6860.Position = UDim2.new(0, 54, 0, 33)
_0x6860.BackgroundColor3 = _0x90E7.Success
_0x6860.BorderSizePixel = 0
_0x6860.ZIndex = 9
_0x6860.Parent = _0xEDD7
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x6860).CornerRadius = UDim.new(1, 0)
local _0x9A42 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x9A42.Size = UDim2.new(1, -136, 0, 14)
_0x9A42.Position = UDim2.new(0, 65, 0, 29)
_0x9A42.BackgroundTransparency = 1
_0x9A42.Text =string.char(115,99,97,110,110,105,110,103,32,110,101,97,114,101,115,116,32,112,108,97,121,101,114)_0x9A42.TextColor3 = _0x90E7.Muted
_0x9A42.Font = Enum.Font.GothamMedium
_0x9A42.TextSize = 10
_0x9A42.TextXAlignment = Enum.TextXAlignment.Left
_0x9A42.TextTruncate = Enum.TextTruncate.AtEnd
_0x9A42.ZIndex = 9
_0x9A42.Parent = _0xEDD7
local _0xDED3 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xDED3.Size = UDim2.new(0, 56, 0, 26)
_0xDED3.Position = UDim2.new(1, -64, 0.5, -13)
_0xDED3.Text =string.char(65,85,84,79)_0xDED3.TextColor3 = Color3.new(1, 1, 1)
_0xDED3.Font = Enum.Font.GothamBold
_0xDED3.TextSize = 10
_0xDED3.ZIndex = 9
_0xDED3.Parent = _0xEDD7
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xDED3).CornerRadius = UDim.new(0, 6)
_0x961E(_0xDED3, _0x90E7.PanelLt)
local _0xBEB0 = nil
local _0xA982local function _0x7382()
local _0x9BBF, _0x41F6 = _0xB894()
_0x3BAC[_0xDED3] = _0x41F6 and _0x90E7.Success or _0x90E7.PanelLt
_0xDED3.BackgroundColor3 = _0x41F6 and _0x90E7.Success or _0x90E7.PanelLt
if not _0x9BBF then
_0xD634.Text =string.char(65,117,116,111,58,32,78,101,97,114,101,115,116,32,80,108,97,121,101,114)_0x9A42.Text =string.char(119,97,105,116,105,110,103,32,102,111,114,32,110,101,97,114,98,121,32,112,108,97,121,101,114,115,46,46,46)_0x6860.BackgroundColor3 = _0x90E7.Accent
_0x2EDB.Image =""_0xB6B7.Visible = true
_0x04FE.Color = _0x90E7.Border
_0xBEB0 = nil
return
end
_0xB6B7.Visible = false
local _0x975E = _0x9BBF.UserId
local _0x5E54 = (_0x9BBF.Parent == _0xC3F7)
_0xD634.Text = (_0x41F6 andstring.char(78,101,97,114,101,115,116,58,32)orstring.char(84,97,114,103,101,116,58,32)) .. (_0x9BBF.DisplayName or _0x9BBF.Name orstring.char(63))
if _0xBEB0 ~= _0x975E then
_0xBEB0 = _0x975E
pcall(function()
_0x2EDB.Image =string.char(114,98,120,116,104,117,109,98,58,47,47,116,121,112,101,61,65,118,97,116,97,114,72,101,97,100,83,104,111,116,38,105,100,61).. _0x975E ..string.char(38,119,61,49,53,48,38,104,61,49,53,48)end)
end
if not _0x5E54 then
_0x9A42.Text =string.char(64).. _0x9BBF.Name ..string.char(32,194,183,32,108,101,102,116,32,115,101,114,118,101,114)_0x6860.BackgroundColor3 = _0x90E7.Danger
_0x04FE.Color = _0x90E7.Danger
else
local _0x5BFE = _0x4E36(_0x9BBF)
local _0xA778 = _0x5BFE and _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
local _0x9D7F = _0x5BFE and _0x76B4(_0x5BFE,string.char(116,111,114,115,111))
if _0xA778 and _0xA778.Health <= 0 then
_0x9A42.Text =string.char(64).. _0x9BBF.Name ..string.char(32,194,183,32,114,101,115,112,97,119,110,105,110,103)_0x6860.BackgroundColor3 = _0x90E7.Warning
_0x04FE.Color = _0x90E7.Warning
elseif not _0x9D7F then
_0x9A42.Text =string.char(64).. _0x9BBF.Name ..string.char(32,194,183,32,104,105,100,100,101,110,47,102,97,114,32,40,97,117,116,111,45,115,101,101,107,32,114,101,97,100,121,41)_0x6860.BackgroundColor3 = _0x90E7.Accent
_0x04FE.Color = _0x90E7.Accent
else
local _0xC925 =""pcall(function()
local _0xFB7E = _0xA6AA.Character and _0xA6AA.Character:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116))
if _0xFB7E then _0xC925 =string.char(32,194,183,32).. tostring(math.floor((_0x9D7F.Position - _0xFB7E.Position).Magnitude)) ..string.char(115)end
end)
_0x9A42.Text =string.char(64).. _0x9BBF.Name .. _0xC925 ..string.char(32,194,183,32,108,111,99,107,101,100)_0x6860.BackgroundColor3 = _0x90E7.Success
_0x04FE.Color = _0x41F6 and _0x90E7.Border or _0x90E7.Success
end
end
end
_0xDED3.MouseButton1Click:Connect(function()
_0x0909()
_0x0A85 = nil
_0x7A5D(nil)
_0xC3B1.Text =string.char(65,117,116,111,58,32,78,101,97,114,101,115,116,32,80,108,97,121,101,114)_0x00E5.Text =string.char(97,117,116,111,45,99,111,110,110,101,99,116,115,32,116,111,32,110,101,97,114,101,115,116,32,112,108,97,121,101,114)if _0xA982 then pcall(_0xA982) end
pcall(_0x7382)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(65,117,116,111,45,78,101,97,114,101,115,116,32,80,108,97,121,101,114,32,109,111,100,101,32,97,99,116,105,118,101))
end)
_0x7382()
task.spawn(function()
while _0xEDD7 and _0xEDD7.Parent do
task.wait(0.5)
pcall(_0x7382)
end
end)local _0xF580 = Color3.fromRGB(32, 156, 72)
do_0x8DC1(_0x710C, 2,string.char(84,82,79,76,76,32,38,32,87,69,76,68,32,65,67,84,73,79,78,83,32,32,40,84,65,80,32,91,43,93,32,84,79,32,80,73,78,32,70,76,79,65,84,73,78,71,32,73,67,79,78,41), _0x90E7.Muted)
local _0xF39D = {
{ _0xE12E =string.char(104,101,97,100,112,97,116), pillLabel =string.char(80,97,116), width = 82 },
{ _0xE12E =string.char(104,101,97,100,115,105,116), pillLabel =string.char(72,101,97,100,115,105,116), width = 104 },
{ _0xE12E =string.char(102,97,99,101,98,97,110,103), pillLabel =string.char(70,97,99,101,98,97,110,103), width = 112 },
{ _0xE12E =string.char(98,97,99,107,115,104,111,116,115), pillLabel =string.char(66,97,99,107,115,104,111,116,115), width = 114 },
{ _0xE12E =string.char(107,105,115,115), pillLabel =string.char(75,105,115,115), width = 82 },
{ _0xE12E =string.char(98,97,99,107,112,97,99,107), pillLabel =string.char(66,97,99,107,112,97,99,107), width = 110 },
{ _0xE12E =string.char(112,114,111,112,111,115,101), pillLabel =string.char(80,114,111,112,111,115,101), width = 104 },
{ _0xE12E =string.char(104,117,103), pillLabel =string.char(72,117,103), width = 82 },
{ _0xE12E =string.char(99,104,97,115,101), pillLabel =string.char(67,104,97,115,101,84,80), width = 104 },
{ _0xE12E =string.char(102,108,105,110,103), pillLabel =string.char(70,108,105,110,103), width = 86 },
{ _0xE12E =string.char(118,111,105,100,116,104,114,111,119), pillLabel =string.char(86,111,105,100,84,104,114,111,119), width = 112 },
{ _0xE12E =string.char(100,101,102,108,101,99,116), pillLabel =string.char(68,101,102,108,101,99,116), width = 100 },
{ _0xE12E =string.char(114,101,119,105,110,100), pillLabel =string.char(82,101,119,105,110,100), width = 96 },
}
local _0x539F = {}
for _0x9094, item in ipairs(_0xF39D) do _0x539F[item.key] = item end
local _0x013D = Color3.fromRGB(48, 36, 11)
local _0x52D9 = Color3.fromRGB(185, 142, 24)
local _0x9B90 = Color3.fromRGB(168, 132, 36)
local _0xDF4E = Color3.fromRGB(234, 179, 8)
local _0x8E27 = Color3.fromRGB(255, 251, 235)
_0xF580 = Color3.fromRGB(32, 156, 72)
local _0x7C19 = Color3.fromRGB(250, 204, 21)
local _0x68C3 = Color3.fromRGB(254, 240, 138)
local _0x9C92 = Color3.fromRGB(255, 255, 255)
local _0x8377 = Color3.fromRGB(255, 255, 255)
local _0x391C = {}local _0x7C4D = {}
local _0x052D = {}
local _0x6717 = {}
local function _0x6E01(_0xE12E)
if _0xE12E ==string.char(114,101,119,105,110,100)then return _0xAE44.rewinding == true end
if _0xE12E ==string.char(102,108,105,110,103)or _0xE12E ==string.char(118,111,105,100,116,104,114,111,119)then return _0xF3B0 == true end
if _0xE12E ==string.char(100,101,102,108,101,99,116)then return (_0x7DE1.enabled or _0x5DAB.Redirect.enabled or _0x5DAB.PauseTrap.enabled) end
return (_0x243A.active == true and _0x243A.presetKey == _0xE12E)
endlocal function _0xDD4F()
local _0xF25B = 0
for _0x9094, _0xE12E in ipairs(_0x6717) do
local _0x4599 = _0x052D[_0xE12E]
if _0x4599 and _0x4599.btn and _0x4599.btn.Parent then
_0xF25B = _0xF25B + 1
if not _0x4599.customMoved then
local _0x37A2 = 58 + (_0xF25B - 1) * 35
_0x4599.btn.Position = UDim2.new(1, -(_0x4599.width + 12), 0, _0x37A2)
end
end
end
end
local function _0x21AD(_0xE12E)
local _0x9E03 = _0x052D[_0xE12E] ~= nil
local _0x2127 = _0x7C4D[_0xE12E]
if _0x2127 and _0x2127.Parent then
_0x2127.Text = _0x9E03 andstring.char(226,156,147)orstring.char(43)_0x2127.BackgroundColor3 = _0x9E03 and _0xF580 or _0x90E7.BG2
_0x2127.TextColor3 = _0x9E03 and Color3.new(1, 1, 1) or _0x90E7.Muted
end
end
_0x207A = function()
for _0xE12E, item in pairs(_0x391C) do
if item and item.btn and item.btn.Parent then
local _0x0B5F = _0x6E01(_0xE12E)
local _0xD6A9 = _0x0B5F and _0xF580 or _0x90E7.Panel
_0x3BAC[item.btn] = _0xD6A9
_0xFD0E:Create(item.btn, TweenInfo.new(0.15), {BackgroundColor3 = _0xD6A9}):Play()
if item.dot then
item.dot.BackgroundColor3 = _0x0B5F and _0x68C3 or _0x9B90
end
if item.stroke then
item.stroke.Color = _0x0B5F and _0x7C19 or _0x90E7.Border
item.stroke.Transparency = _0x0B5F and 0.1 or 0.45
end
end
end
for _0xE12E, _0x4599 in pairs(_0x052D) do
if _0x4599 and _0x4599.btn and _0x4599.btn.Parent then
local _0x0B5F = _0x6E01(_0xE12E)
_0xFD0E:Create(_0x4599.btn, TweenInfo.new(0.15), {
BackgroundColor3 = _0x0B5F and _0xF580 or _0x013D,
BackgroundTransparency = _0x0B5F and 0.04 or 0.12,
}):Play()
_0xFD0E:Create(_0x4599.stroke, TweenInfo.new(0.15), {
Color = _0x0B5F and _0x7C19 or _0x52D9,
Transparency = _0x0B5F and 0.05 or 0.25,
}):Play()
_0xFD0E:Create(_0x4599.dot, TweenInfo.new(0.15), {
BackgroundColor3 = _0x0B5F and _0x68C3 or _0x9B90,
}):Play()
_0xFD0E:Create(_0x4599.dotStroke, TweenInfo.new(0.15), {
Color = _0x0B5F and _0x9C92 or _0xDF4E,
}):Play()
_0x4599.label.TextColor3 = _0x0B5F and _0x8377 or _0x8E27
end
end
end
local function _0xFE9A(_0xE12E)
if _0xE12E ==string.char(114,101,119,105,110,100)then
_0xAE44:Start(_0xAE44.duration)
_0x207A()
return
end
if _0xE12E ==string.char(100,101,102,108,101,99,116)then
local _0x55A0 = not (_0x7DE1.enabled or _0x5DAB.Redirect.enabled or _0x5DAB.PauseTrap.enabled)
_0x7DE1.enabled = _0x55A0
_0x5DAB.Redirect.enabled = _0x55A0
_0x5DAB.PauseTrap.enabled = _0x55A0
_0x5DAB.FlingShield.enabled = _0x55A0
if _0x55A0 then
_0x5DAB.FlingShield.startFn()
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(68,101,102,101,110,99,101,32,84,114,111,108,108,32,79,78,32,40).. (_0x7DE1.modeLabels[_0x7DE1.mode] or _0x7DE1.mode) ..string.char(41))
else
_0x5DAB.FlingShield.stopFn()
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(68,101,102,101,110,99,101,32,84,114,111,108,108,32,79,70,70))
end
_0x207A()
if _0x8AC6 then pcall(_0x8AC6) end
return
end
if _0xE12E ==string.char(118,111,105,100,116,104,114,111,119)then
if _0xF3B0 then
_0x3C23:StopFling(false)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(86,111,105,100,32,84,104,114,111,119,32,115,116,111,112,112,101,100,32,38,32,115,97,102,101,108,121,32,114,101,116,117,114,110,101,100))
_0xED6E()
else
_0xC789()
end
_0x207A()
return
end
if _0xE12E ==string.char(102,108,105,110,103)then
if _0xF3B0 then
_0x3C23:StopFling(false)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(70,108,105,110,103,32,115,116,111,112,112,101,100,32,38,32,115,97,102,101,108,121,32,114,101,116,117,114,110,101,100))
_0xED6E()
else
_0x0F95(-1,string.char(85,110,108,105,109,105,116,101,100), false)
end
_0x207A()
return
end
if _0x243A.active and _0x243A.presetKey == _0xE12E then
_0x7EF3()
_0x3C23:Cleanup(true)
_0x518F = nil
_0x00E5.Text =string.char(115,116,111,112,112,101,100)_0x207A()
_0xED6E()
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65), (_0xA4A2[_0xE12E] and _0xA4A2[_0xE12E].label or _0xE12E) ..string.char(32,115,116,111,112,112,101,100))
return
end
local _0x49D0, _0xAF3C = _0xB894()
if not _0x49D0 or _0x49D0.Parent ~= _0xC3F7 then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(78,111,32,116,97,114,103,101,116,32,112,108,97,121,101,114,32,102,111,117,110,100,32,105,110,32,115,101,114,118,101,114,33))
_0xB065()
_0x207A()
return
end
_0x3C23:Cleanup(true, true)
_0x6652 = _0x49D0
_0x839F = _0x49D0.UserId
_0xE947(_0x49D0)
local _0xF999 = _0xE84F(_0xE12E, _0x49D0)
if _0xF999 then
_0xC3B1.Text = (_0xAF3C andstring.char(78,101,97,114,101,115,116,58,32)orstring.char(84,97,114,103,101,116,58,32)) .. _0x49D0.Name
_0x00E5.Text =string.char(97,99,116,105,118,101,32,194,183,32).. (_0xA4A2[_0xE12E].label or _0xE12E)
_0x207A()
_0xCAE4()
local _0x59E7 = _0xAF3C andstring.char(65,117,116,111,45,78,101,97,114,101,115,116,32,40).. (_0xA4A2[_0xE12E].label or _0xE12E) ..string.char(41,32,45,62,32)or ((_0xA4A2[_0xE12E].label or _0xE12E) ..string.char(32,45,62,32))
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65), _0x59E7 .. _0x49D0.Name)
else
_0x207A()
_0xB065()
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(70,97,105,108,101,100,32,226,128,148,32,114,101,102,101,114,101,110,99,101,32,112,97,114,116,32,109,105,115,115,105,110,103))
end
end
local function _0x5691(_0xE12E)
local _0x4599 = _0x052D[_0xE12E]
if not _0x4599 then return end
if _0x4599.btn then pcall(function() _0x4599.btn:Destroy() end) end
_0x052D[_0xE12E] = nil
for i = #_0x6717, 1, -1 do
if _0x6717[i] == _0xE12E then table.remove(_0x6717, i) end
end
_0xDD4F()
_0x21AD(_0xE12E)
end
local function _0x8057(_0xE12E)
if _0x052D[_0xE12E] then return end
local _0x510F = _0x539F[_0xE12E]
if not _0x510F then return end
local _0x50B6 = _0x510F.width or 100
local _0xFDCB = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xFDCB.Name =string.char(81,117,105,99,107,80,105,108,108,95).. _0xE12E
_0xFDCB.Size = UDim2.new(0, _0x50B6, 0, 32)
_0xFDCB.BackgroundColor3 = _0x013D
_0xFDCB.BackgroundTransparency = 0.12
_0xFDCB.BorderSizePixel = 0
_0xFDCB.Text =""_0xFDCB.AutoButtonColor = false
_0xFDCB.Active = true
_0xFDCB.ZIndex = 995
_0xFDCB.Parent = _0xF28E
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xFDCB).CornerRadius = UDim.new(1, 0)
local _0x2A85 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x2A85.Color = _0x52D9
_0x2A85.Thickness = 1.4
_0x2A85.Transparency = 0.25
_0x2A85.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
_0x2A85.Parent = _0xFDCB
local _0x4D9D = Instance.new(string.char(70,114,97,109,101))
_0x4D9D.Name =string.char(83,116,97,116,117,115,67,105,114,99,108,101)_0x4D9D.Size = UDim2.new(0, 10, 0, 10)
_0x4D9D.Position = UDim2.new(0, 11, 0.5, -5)
_0x4D9D.BackgroundColor3 = _0x9B90
_0x4D9D.BorderSizePixel = 0
_0x4D9D.ZIndex = 996
_0x4D9D.Parent = _0xFDCB
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4D9D).CornerRadius = UDim.new(1, 0)
local _0x0435 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x0435.Color = _0xDF4E
_0x0435.Thickness = 1.2
_0x0435.Transparency = 0.2
_0x0435.Parent = _0x4D9D
local _0x2594 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x2594.Name =string.char(80,105,108,108,84,105,116,108,101)_0x2594.Size = UDim2.new(1, -28, 1, 0)
_0x2594.Position = UDim2.new(0, 26, 0, 0)
_0x2594.BackgroundTransparency = 1
_0x2594.Text = _0x510F.pillLabel
_0x2594.TextColor3 = _0x8E27
_0x2594.Font = Enum.Font.GothamBold
_0x2594.TextSize = 12
_0x2594.TextXAlignment = Enum.TextXAlignment.Left
_0x2594.ZIndex = 996
_0x2594.Parent = _0xFDCB
local _0x4599 = {
_0x43E0 = _0xFDCB,
stroke = _0x2A85,
_0x4D9D = _0x4D9D,
_0x0435 = _0x0435,
label = _0x2594,
width = _0x50B6,
customMoved = false,
}
_0x052D[_0xE12E] = _0x4599
table.insert(_0x6717, _0xE12E)
_0xDD4F()
local _0x97F2, _0x1578, _0xFAF0, _0xDCD7 = false, nil, nil, false
local _0x51E9 = 0
local function _0x35AC()
if tick() - _0x51E9 < 0.18 then return end
_0x51E9 = tick()
_0x0909()
_0xFE9A(_0xE12E)
end
_0xFDCB.InputBegan:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
_0x97F2 = true; _0x1578 = inp.Position; _0xFAF0 = _0xFDCB.Position; _0xDCD7 = false
elseif inp.UserInputType == Enum.UserInputType.MouseButton2 then
_0x0909()
_0x5691(_0xE12E)
end
end)
_0xB2E3.InputChanged:Connect(function(inp)
if _0x97F2 and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
local _0x5635 = inp.Position - _0x1578
if math.abs(_0x5635.X) > 8 or math.abs(_0x5635.Y) > 8 then
_0xDCD7 = true
_0x4599.customMoved = true
end
if _0xDCD7 then
_0xFDCB.Position = UDim2.new(_0xFAF0.X.Scale, _0xFAF0.X.Offset + _0x5635.X, _0xFAF0.Y.Scale, _0xFAF0.Y.Offset + _0x5635.Y)
end
end
end)
_0xB2E3.InputEnded:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
if _0x97F2 and not _0xDCD7 then _0x35AC() end
_0x97F2 = false
end
end)
_0xFDCB.MouseButton1Click:Connect(function()
if not _0xDCD7 then _0x35AC() end
end)
_0x21AD(_0xE12E)
_0x207A()
end
local function _0x5A88(_0xE12E)
if _0x052D[_0xE12E] then
_0x5691(_0xE12E)
else
_0x8057(_0xE12E)
end
endlocal function _0x8133(order, entries)
local _0xD663 = Instance.new(string.char(70,114,97,109,101))
_0xD663.Size = UDim2.new(1, 0, 0, 34)
_0xD663.BackgroundTransparency = 1
_0xD663.LayoutOrder = order
_0xD663.ZIndex = 7
_0xD663.Parent = _0x710C
local _0x342C = #entries
for i, cfg in ipairs(entries) do
local _0xCFA1 = 1 / _0x342C
local _0x4973 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x4973.Size = UDim2.new(_0xCFA1, -4, 1, 0)
_0x4973.Position = UDim2.new((i - 1) * _0xCFA1, (i == 1) and 0 or 4, 0, 0)
_0x4973.Text =""_0x4973.AutoButtonColor = false
_0x4973.ZIndex = 8
_0x4973.Parent = _0xD663
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4973).CornerRadius = UDim.new(0, 8)
_0x961E(_0x4973, _0x90E7.Panel)
local _0xE898 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0xE898.Color = _0x90E7.Border
_0xE898.Thickness = 1
_0xE898.Transparency = 0.45
_0xE898.Parent = _0x4973
local _0x4D9D = Instance.new(string.char(70,114,97,109,101))
_0x4D9D.Size = UDim2.new(0, 8, 0, 8)
_0x4D9D.Position = UDim2.new(0, 10, 0.5, -4)
_0x4D9D.BackgroundColor3 = _0x9B90
_0x4D9D.BorderSizePixel = 0
_0x4D9D.ZIndex = 9
_0x4D9D.Parent = _0x4973
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4D9D).CornerRadius = UDim.new(1, 0)
local _0x2816 = cfg.key and _0x539F[cfg.key] ~= nil
local _0x2594 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x2594.Size = UDim2.new(1, _0x2816 and -54 or -24, 1, 0)
_0x2594.Position = UDim2.new(0, 24, 0, 0)
_0x2594.BackgroundTransparency = 1
_0x2594.Text = cfg.text
_0x2594.TextColor3 = _0x90E7.Text
_0x2594.Font = Enum.Font.GothamBold
_0x2594.TextSize = 11
_0x2594.TextXAlignment = Enum.TextXAlignment.Left
_0x2594.TextTruncate = Enum.TextTruncate.AtEnd
_0x2594.ZIndex = 9
_0x2594.Parent = _0x4973
if cfg.key then
_0x391C[cfg.key] = { _0x43E0 = _0x4973, _0x4D9D = _0x4D9D, label = _0x2594, stroke = _0xE898 }
_0x4973.MouseButton1Click:Connect(function()
_0x0909()
if cfg.cb then cfg.cb() else _0xFE9A(cfg.key) end
end)
if _0x2816 then
local _0x4B66 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x4B66.Size = UDim2.new(0, 22, 0, 22)
_0x4B66.Position = UDim2.new(1, -27, 0.5, -11)
_0x4B66.BackgroundColor3 = _0x90E7.BG2
_0x4B66.Text =string.char(43)_0x4B66.TextColor3 = _0x90E7.Muted
_0x4B66.Font = Enum.Font.GothamBold
_0x4B66.TextSize = 11
_0x4B66.AutoButtonColor = false
_0x4B66.ZIndex = 10
_0x4B66.Parent = _0x4973
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4B66).CornerRadius = UDim.new(0, 6)
_0x7C4D[cfg.key] = _0x4B66
_0x4B66.MouseButton1Click:Connect(function()
_0x0909()
_0x5A88(cfg.key)
end)
end
elseif cfg.cb then
_0x4973.MouseButton1Click:Connect(function() _0x0909(); cfg.cb() end)
end
end
end
_0x8133(3, {
{ text =string.char(70,97,99,101,98,97,110,103), _0xE12E =string.char(102,97,99,101,98,97,110,103)},
{ text =string.char(72,101,97,100,115,105,116), _0xE12E =string.char(104,101,97,100,115,105,116)},
})
_0x8133(4, {
{ text =string.char(66,97,99,107,115,104,111,116,115), _0xE12E =string.char(98,97,99,107,115,104,111,116,115)},
{ text =string.char(80,97,116), _0xE12E =string.char(104,101,97,100,112,97,116)},
})
_0x8133(5, {
{ text =string.char(75,105,115,115), _0xE12E =string.char(107,105,115,115)},
{ text =string.char(66,97,99,107,112,97,99,107), _0xE12E =string.char(98,97,99,107,112,97,99,107)},
})
_0x8133(6, {
{ text =string.char(80,114,111,112,111,115,101), _0xE12E =string.char(112,114,111,112,111,115,101)},
{ text =string.char(72,117,103), _0xE12E =string.char(104,117,103)},
})
_0x8133(7, {
{ text =string.char(65,117,116,111,45,67,104,97,115,101,32,40,69,118,101,114,121,119,104,101,114,101,41), _0xE12E =string.char(99,104,97,115,101)},
{ text =string.char(86,111,105,100,32,84,104,114,111,119,32,118,50,32,226,154,161), _0xE12E =string.char(118,111,105,100,116,104,114,111,119)},
})
_0x8133(8, {
{ text =string.char(78,101,98,117,108,97,32,70,108,105,110,103,32,47,32,86,111,105,100,32,76,111,99,107), _0xE12E =string.char(102,108,105,110,103), cb = function() _0xFF07() end },
{ text =string.char(226,143,170,32,82,101,119,105,110,100,32,40,54,45,49,48,115,41), _0xE12E =string.char(114,101,119,105,110,100)},
})
_0x8133(9, {
{ text =string.char(65,110,116,105,45,84,114,111,108,108,32,68,101,102,108,101,99,116), _0xE12E =string.char(100,101,102,108,101,99,116)},
{ text =string.char(86,111,105,100,32,76,111,99,107,32,40,85,110,116,105,108,32,68,101,97,100,41), cb = function() _0x0F95(-1,string.char(86,111,105,100,32,76,111,99,107,32,85,110,116,105,108,32,68,101,97,100), true) end },
})_0x8DC1(_0x710C, 10,string.char(76,73,86,69,32,84,82,79,76,76,32,38,32,87,69,76,68,32,84,85,78,69,82,32,32,40,90,69,82,79,45,68,69,76,65,89,32,72,69,73,71,72,84,32,47,32,68,73,83,84,32,47,32,83,80,69,69,68,41), _0x90E7.Accent)
local _0x3345 = Instance.new(string.char(70,114,97,109,101))
_0x3345.Size = UDim2.new(1, 0, 0, 28)
_0x3345.BackgroundTransparency = 1
_0x3345.LayoutOrder = 11
_0x3345.ZIndex = 7
_0x3345.Parent = _0x710C
local _0xFCEF = Instance.new(string.char(70,114,97,109,101))
_0xFCEF.Size = UDim2.new(1, 0, 0, 28)
_0xFCEF.BackgroundTransparency = 1
_0xFCEF.LayoutOrder = 12
_0xFCEF.ZIndex = 7
_0xFCEF.Parent = _0x710C
local _0x7055 = { 0.6, 1.0, 1.6, 2.5, 4.0, 5.5 }
local _0x4A58 = 2
local function _0xB32A(parentRow, xScale, _0x31B5, label, onClick)
local _0x4973 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x4973.Size = UDim2.new(_0x31B5, -4, 1, 0)
_0x4973.Position = UDim2.new(xScale, 2, 0, 0)
_0x4973.BackgroundColor3 = _0x90E7.PanelLt
_0x4973.Text = label
_0x4973.TextColor3 = _0x90E7.Text
_0x4973.Font = Enum.Font.GothamBold
_0x4973.TextSize = 9
_0x4973.AutoButtonColor = false
_0x4973.ZIndex = 8
_0x4973.Parent = parentRow
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4973).CornerRadius = UDim.new(0, 6)
_0x961E(_0x4973, _0x90E7.PanelLt)
_0x4973.MouseButton1Click:Connect(function()
_0x0909()
onClick(_0x4973)
end)
return _0x4973
end
_0xB32A(_0x3345, 0.00, 0.28,string.char(83,80,69,69,68,58,32,49,46,48,120), function(_0x43E0)
_0x4A58 = (_0x4A58 % #_0x7055) + 1
_0x68F1.Speed = _0x7055[_0x4A58]
_0x43E0.Text = string.format(string.char(83,80,69,69,68,58,32,37,46,49,102,120), _0x68F1.Speed)
end)
_0xB32A(_0x3345, 0.28, 0.18,string.char(68,73,83,84,32,45), function()
_0x68F1.Z = math.clamp((_0x68F1.Z or 1.3) - 0.25, -3.5, 6.0)
end)
_0xB32A(_0x3345, 0.46, 0.18,string.char(68,73,83,84,32,43), function()
_0x68F1.Z = math.clamp((_0x68F1.Z or 1.3) + 0.25, -3.5, 6.0)
end)
_0xB32A(_0x3345, 0.64, 0.18,string.char(72,69,73,71,72,84,32,45), function()
_0x68F1.Y = math.clamp((_0x68F1.Y or 0) - 0.25, -4.0, 4.0)
end)
_0xB32A(_0x3345, 0.82, 0.18,string.char(72,69,73,71,72,84,32,43), function()
_0x68F1.Y = math.clamp((_0x68F1.Y or 0) + 0.25, -4.0, 4.0)
end)
_0xB32A(_0xFCEF, 0.00, 0.34,string.char(82,69,83,69,84,32,79,70,70,83,69,84), function()
_0x68F1.X = 0; _0x68F1.Y = 0; _0x68F1.Z = 1.3
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(72,101,105,103,104,116,32,38,32,68,105,115,116,97,110,99,101,32,111,102,102,115,101,116,115,32,114,101,115,101,116,32,116,111,32,100,101,102,97,117,108,116))
end)
_0xB32A(_0xFCEF, 0.34, 0.34,string.char(226,154,161,32,83,69,69,75,32,38,32,84,80), function()
local _0x9BBF = _0xB894()
if not _0x9BBF or _0x9BBF.Parent ~= _0xC3F7 then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(78,111,32,116,97,114,103,101,116,32,112,108,97,121,101,114,32,105,110,32,115,101,114,118,101,114,33))
_0xB065()
return
end
task.spawn(function()
local _0x9094, _0x5378 = _0x5D16(_0x9BBF,string.char(116,111,114,115,111), 2.2, true)
if _0x5378 and _0x5378.Parent then
local _0x6A8A = _0x5378.CFrame * CFrame.new(0, 1.5, 2.5)
_0x363C(_0x6A8A)
_0xDF2E(_0xA6AA.Character, _0x6A8A)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(84,101,108,101,112,111,114,116,101,100,32,116,111,32).. _0x9BBF.Name ..string.char(33))
_0xCAE4()
else
local _0x2201 = _0xF668(_0x9BBF)
if _0x2201 then
_0x363C(_0x2201)
_0xDF2E(_0xA6AA.Character, _0x2201 * CFrame.new(0, 2, 0))
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(84,101,108,101,112,111,114,116,101,100,32,116,111,32).. _0x9BBF.Name ..string.char(39,115,32,104,105,100,100,101,110,32,122,111,110,101,33))
_0xCAE4()
else
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(84,97,114,103,101,116,32,105,115,32,114,101,115,112,97,119,110,105,110,103,32,226,128,148,32,101,110,97,98,108,101,32,65,117,116,111,45,67,104,97,115,101,32,116,111,32,108,111,99,107,32,111,110,33))
_0xB065()
end
end
end)
end)
_0xB32A(_0xFCEF, 0.68, 0.32,string.char(239,191,189,239,191,189,239,184,143,32,86,73,69,87,58,32,79,70,70), function(_0x43E0)
_0x5BCC = not _0x5BCC
local _0x6EE9 = workspace.CurrentCamera
if _0x5BCC then
local _0x9BBF = _0xB894()
local _0x2EC9 = _0x9BBF and _0x4E36(_0x9BBF)
local _0xE5C6 = _0x2EC9 and (_0x2EC9:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100)) or _0x4DA4(_0x2EC9))
if _0x6EE9 and _0xE5C6 then
_0x6EE9.CameraSubject = _0xE5C6
_0x43E0.Text =string.char(239,191,189,239,191,189,239,184,143,32,86,73,69,87,58,32,79,78)_0x3BAC[_0x43E0] = _0xF580
_0x43E0.BackgroundColor3 = _0xF580
return
end
_0x5BCC = false
end
if _0x6EE9 and _0xA6AA.Character then
local _0x4545 = _0xA6AA.Character:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0x4545 then _0x6EE9.CameraSubject = _0x4545 end
end
_0x43E0.Text =string.char(239,191,189,239,191,189,239,184,143,32,86,73,69,87,58,32,79,70,70)_0x3BAC[_0x43E0] = _0x90E7.PanelLt
_0x43E0.BackgroundColor3 = _0x90E7.PanelLt
end)_0x8057(string.char(104,101,97,100,112,97,116))
_0x8057(string.char(104,101,97,100,115,105,116))
_0x8057(string.char(102,97,99,101,98,97,110,103))
_0x8057(string.char(118,111,105,100,116,104,114,111,119))
_0x8057(string.char(114,101,119,105,110,100))
enddo
local _0xD293 = Instance.new(string.char(70,114,97,109,101))
_0xD293.Size = UDim2.new(1, 0, 0, 32)
_0xD293.BackgroundTransparency = 1
_0xD293.LayoutOrder = 1
_0xD293.ZIndex = 7
_0xD293.Parent = _0x30B6
local _0x121A = Instance.new(string.char(84,101,120,116,66,111,120))
_0x121A.Size = UDim2.new(1, -92, 1, 0)
_0x121A.BackgroundColor3 = _0x90E7.Panel
_0x121A.PlaceholderText =string.char(83,101,97,114,99,104,32,112,108,97,121,101,114,46,46,46)_0x121A.Text =""_0x121A.TextColor3 = _0x90E7.Text
_0x121A.PlaceholderColor3 = _0x90E7.Muted
_0x121A.Font = Enum.Font.Gotham
_0x121A.TextSize = 11
_0x121A.ClearTextOnFocus = false
_0x121A.ZIndex = 8
_0x121A.Parent = _0xD293
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x121A).CornerRadius = UDim.new(0, 7)
local _0xA05D = Instance.new(string.char(85,73,80,97,100,100,105,110,103))
_0xA05D.PaddingLeft = UDim.new(0, 10)
_0xA05D.PaddingRight = UDim.new(0, 10)
_0xA05D.Parent = _0x121A
local _0x1690 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x1690.Size = UDim2.new(0, 86, 1, 0)
_0x1690.Position = UDim2.new(1, -86, 0, 0)
_0x1690.Text =string.char(65,85,84,79,45,78,69,65,82)_0x1690.TextColor3 = Color3.new(1, 1, 1)
_0x1690.Font = Enum.Font.GothamBold
_0x1690.TextSize = 10
_0x1690.ZIndex = 8
_0x1690.Parent = _0xD293
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x1690).CornerRadius = UDim.new(0, 7)
_0x961E(_0x1690, _0x90E7.Accent2)
local _0xE91D = Instance.new(string.char(70,114,97,109,101))
_0xE91D.Size = UDim2.new(1, 0, 0, 195)
_0xE91D.BackgroundColor3 = _0x90E7.Panel
_0xE91D.BorderSizePixel = 0
_0xE91D.LayoutOrder = 2
_0xE91D.ClipsDescendants = true
_0xE91D.ZIndex = 7
_0xE91D.Parent = _0x30B6
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xE91D).CornerRadius = UDim.new(0, 8)
local _0x67BA = Instance.new(string.char(83,99,114,111,108,108,105,110,103,70,114,97,109,101))
_0x67BA.Size = UDim2.new(1, -8, 1, -8)
_0x67BA.Position = UDim2.new(0, 4, 0, 4)
_0x67BA.BackgroundTransparency = 1
_0x67BA.BorderSizePixel = 0
_0x67BA.ScrollBarThickness = 2
_0x67BA.ScrollBarImageColor3 = _0x90E7.Accent
_0x67BA.CanvasSize = UDim2.new(0, 0, 0, 0)
_0x67BA.AutomaticCanvasSize = Enum.AutomaticSize.Y
_0x67BA.ZIndex = 8
_0x67BA.Parent = _0xE91D
local _0xB97B = Instance.new(string.char(85,73,76,105,115,116,76,97,121,111,117,116))
_0xB97B.Padding = UDim.new(0, 4)
_0xB97B.SortOrder = Enum.SortOrder.LayoutOrder
_0xB97B.Parent = _0x67BA
local function _0x9D0A(_0xDDC2)
_0xDDC2 = (_0xDDC2 or""):lower()
local _0xC218 = {}
for _0x9094, _0x1CEE in ipairs(_0xC3F7:GetPlayers()) do
if _0x1CEE ~= _0xA6AA then
if _0xDDC2 ==""or _0x1CEE.Name:lower():sub(1, #_0xDDC2) == _0xDDC2 or _0x1CEE.DisplayName:lower():sub(1, #_0xDDC2) == _0xDDC2 then
table.insert(_0xC218, _0x1CEE)
end
end
end
return _0xC218
end
_0xA982 = function()
for _0x9094, _0x4E33 in ipairs(_0x67BA:GetChildren()) do
if _0x4E33:IsA(string.char(84,101,120,116,66,117,116,116,111,110)) or _0x4E33:IsA(string.char(84,101,120,116,76,97,98,101,108)) then _0x4E33:Destroy() end
end
local _0x2EC1 = _0x9D0A(_0x121A.Text)
if #_0x2EC1 == 0 then
local _0x69BD = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x69BD.Size = UDim2.new(1, 0, 0, 32)
_0x69BD.BackgroundTransparency = 1
_0x69BD.Text =string.char(78,111,32,109,97,116,99,104,105,110,103,32,112,108,97,121,101,114,115,32,226,128,148,32,65,117,116,111,45,78,101,97,114,101,115,116,32,119,105,108,108,32,98,101,32,117,115,101,100)_0x69BD.TextColor3 = _0x90E7.Muted
_0x69BD.Font = Enum.Font.Gotham
_0x69BD.TextSize = 10
_0x69BD.ZIndex = 9
_0x69BD.Parent = _0x67BA
return
end
for i, _0x1CEE in ipairs(_0x2EC1) do
local _0xCB15 = (_0x0A85 == _0x1CEE)
local _0x43E0 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x43E0.Size = UDim2.new(1, -4, 0, 34)
_0x43E0.BackgroundColor3 = _0xCB15 and _0xF580 or _0x90E7.PanelLt
_0x43E0.Text =""_0x43E0.AutoButtonColor = false
_0x43E0.LayoutOrder = i
_0x43E0.ZIndex = 9
_0x43E0.Parent = _0x67BA
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x43E0).CornerRadius = UDim.new(0, 6)
_0x961E(_0x43E0, _0xCB15 and _0xF580 or _0x90E7.PanelLt)
local _0x0372 = Instance.new(string.char(73,109,97,103,101,76,97,98,101,108))
_0x0372.Size = UDim2.new(0, 24, 0, 24)
_0x0372.Position = UDim2.new(0, 6, 0.5, -12)
_0x0372.BackgroundColor3 = _0x90E7.BG2
_0x0372.Image =string.char(114,98,120,116,104,117,109,98,58,47,47,116,121,112,101,61,65,118,97,116,97,114,72,101,97,100,83,104,111,116,38,105,100,61).. _0x1CEE.UserId ..string.char(38,119,61,52,56,38,104,61,52,56)_0x0372.ZIndex = 10
_0x0372.Parent = _0x43E0
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x0372).CornerRadius = UDim.new(1, 0)
local _0x6969 =""pcall(function()
local _0xFB7E = _0xA6AA.Character and _0xA6AA.Character:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116))
local _0xA298 = _0xF668(_0x1CEE)
if _0xFB7E and _0xA298 then
_0x6969 = string.format(string.char(32,194,183,32,37,100,115), math.floor((_0xA298.Position - _0xFB7E.Position).Magnitude))
else
_0x6969 =string.char(32,194,183,32,104,105,100,100,101,110)end
end)
local _0x394C = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x394C.Size = UDim2.new(1, -124, 1, 0)
_0x394C.Position = UDim2.new(0, 36, 0, 0)
_0x394C.BackgroundTransparency = 1
_0x394C.Text = _0x1CEE.DisplayName ..string.char(32,40,64).. _0x1CEE.Name ..string.char(41).. _0x6969
_0x394C.TextColor3 = _0x90E7.Text
_0x394C.Font = Enum.Font.GothamMedium
_0x394C.TextSize = 10
_0x394C.TextXAlignment = Enum.TextXAlignment.Left
_0x394C.TextTruncate = Enum.TextTruncate.AtEnd
_0x394C.ZIndex = 10
_0x394C.Parent = _0x43E0
local _0xA973 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xA973.Size = UDim2.new(0, 34, 0, 22)
_0xA973.Position = UDim2.new(1, -80, 0.5, -11)
_0xA973.BackgroundColor3 = _0x90E7.BG2
_0xA973.Text =string.char(84,80)_0xA973.TextColor3 = _0x90E7.Neon
_0xA973.Font = Enum.Font.GothamBold
_0xA973.TextSize = 9
_0xA973.AutoButtonColor = false
_0xA973.ZIndex = 11
_0xA973.Parent = _0x43E0
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xA973).CornerRadius = UDim.new(0, 5)
_0xA973.MouseButton1Click:Connect(function()
_0x0909()
_0x0A85 = _0x1CEE
_0x7A5D(_0x1CEE)
task.spawn(function()
local _0x9094, _0x5378 = _0x5D16(_0x1CEE,string.char(116,111,114,115,111), 2.4)
if _0x5378 and _0x5378.Parent then
local _0x6A8A = _0x5378.CFrame * CFrame.new(0, 1.5, 2.5)
_0x363C(_0x6A8A)
_0xDF2E(_0xA6AA.Character, _0x6A8A)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(70,111,117,110,100,32,38,32,116,101,108,101,112,111,114,116,101,100,32,116,111,32).. _0x1CEE.Name ..string.char(33))
_0xCAE4()
else
local _0x2201 = _0xF668(_0x1CEE)
if _0x2201 then
_0x363C(_0x2201)
_0xDF2E(_0xA6AA.Character, _0x2201 * CFrame.new(0, 2, 0))
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(84,101,108,101,112,111,114,116,101,100,32,116,111,32).. _0x1CEE.Name ..string.char(39,115,32,104,105,100,100,101,110,32,108,111,99,97,116,105,111,110,33))
_0xCAE4()
else
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(83,101,101,107,105,110,103,32).. _0x1CEE.Name ..string.char(32,226,128,148,32,116,117,114,110,101,100,32,111,110,32,65,117,116,111,45,67,104,97,115,101,33))
_0xE84F(string.char(99,104,97,115,101), _0x1CEE)
_0x207A()
end
end
end)
end)
local _0xF7D0 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xF7D0.Size = UDim2.new(0, 40, 0, 22)
_0xF7D0.Position = UDim2.new(1, -43, 0.5, -11)
_0xF7D0.BackgroundColor3 = _0x90E7.Accent2
_0xF7D0.Text =string.char(86,79,73,68)_0xF7D0.TextColor3 = Color3.new(1, 1, 1)
_0xF7D0.Font = Enum.Font.GothamBold
_0xF7D0.TextSize = 9
_0xF7D0.AutoButtonColor = false
_0xF7D0.ZIndex = 11
_0xF7D0.Parent = _0x43E0
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xF7D0).CornerRadius = UDim.new(0, 5)
_0xF7D0.MouseButton1Click:Connect(function()
_0x0909()
_0x0A85 = _0x1CEE
_0x7A5D(_0x1CEE)
_0xC789(_0x1CEE)
end)
_0x43E0.MouseButton1Click:Connect(function()
if _0x0A85 == _0x1CEE then
_0x0A85 = nil
_0xC3B1.Text =string.char(65,117,116,111,58,32,78,101,97,114,101,115,116,32,80,108,97,121,101,114)_0x00E5.Text =string.char(97,117,116,111,45,99,111,110,110,101,99,116,115,32,116,111,32,110,101,97,114,101,115,116,32,112,108,97,121,101,114)_0x7A5D(nil)
else
_0x0A85 = _0x1CEE
_0xC3B1.Text =string.char(84,97,114,103,101,116,58,32).. _0x1CEE.Name
_0x00E5.Text =string.char(108,111,99,107,101,100,32,40,116,97,112,32,97,103,97,105,110,32,102,111,114,32,97,117,116,111,45,110,101,97,114,101,115,116,41)_0x7A5D(_0x1CEE)
end
_0x0909()
_0xA982()
pcall(_0x7382)
end)
end
end
_0x1690.MouseButton1Click:Connect(function()
_0x0909()
_0x0A85 = nil
_0x121A.Text =""_0x7A5D(nil)
_0xC3B1.Text =string.char(65,117,116,111,58,32,78,101,97,114,101,115,116,32,80,108,97,121,101,114)_0x00E5.Text =string.char(97,117,116,111,45,99,111,110,110,101,99,116,115,32,116,111,32,110,101,97,114,101,115,116,32,112,108,97,121,101,114)pcall(_0xA982)
pcall(_0x7382)
end)
_0x121A:GetPropertyChangedSignal(string.char(84,101,120,116)):Connect(function() pcall(_0xA982) end)
pcall(_0xA982)
_0xC3F7.PlayerAdded:Connect(function(_0x1CEE)
task.wait(0.35)
pcall(_0xA982)
if _0x2CD3 and _0x839F and _0x1CEE.UserId == _0x839F then
_0xE947(_0x1CEE)
local _0x599C = tick()
while tick() - _0x599C < 12.0 and _0x1CEE.Parent == _0xC3F7 and not _0x4E36(_0x1CEE) do
_0xC77A.Heartbeat:Wait()
end
if _0x1CEE.Parent ~= _0xC3F7 then return end
_0x0A85 = _0x1CEE
_0xC3B1.Text =string.char(84,97,114,103,101,116,58,32).. _0x1CEE.Name
_0x00E5.Text =string.char(114,101,106,111,105,110,101,100,32,226,128,148,32,97,117,116,111,32,114,101,45,119,101,108,100,105,110,103)_0x7A5D(_0x1CEE)
local _0xE12E = _0x243A.presetKey or _0x518F
if _0xE12E and _0xA4A2[_0xE12E] then
_0xE84F(_0xE12E, _0x1CEE)
_0x207A()
end
end
end)
_0xC3F7.PlayerRemoving:Connect(function(_0x1CEE)
if _0x243A.target == _0x1CEE or _0x6652 == _0x1CEE or _0x0A85 == _0x1CEE then
_0x839F = _0x1CEE.UserId
_0x7EF3()
_0x3C23:Cleanup(false)
if _0x0A85 == _0x1CEE then
_0x0A85 = nil
_0x7A5D(nil)
end
_0xC3B1.Text =string.char(65,117,116,111,58,32,78,101,97,114,101,115,116,32,80,108,97,121,101,114)_0x00E5.Text =string.char(116,97,114,103,101,116,32,108,101,102,116,32,226,128,148,32,115,97,102,101,108,121,32,114,101,116,117,114,110,101,100)pcall(_0x207A)
end
task.wait(0.1)
pcall(_0xA982)
pcall(_0x7382)
end)endlocal _0xFA8C
do
_0x8DC1(_0xE441, 1,string.char(67,72,65,84,32,83,80,65,77,77,69,82,32,40,65,85,84,79,45,78,69,65,82,69,83,84,32,87,72,69,78,32,66,76,65,78,75,41), _0x90E7.Muted)
_0xA36A = Instance.new(string.char(84,101,120,116,66,111,120))
_0xA36A.Size = UDim2.new(1, 0, 0, 32)
_0xA36A.BackgroundColor3 = _0x90E7.Panel
_0xA36A.PlaceholderText =string.char(84,97,114,103,101,116,32,110,97,109,101,32,40,108,101,97,118,101,32,98,108,97,110,107,32,102,111,114,32,110,101,97,114,101,115,116,32,112,108,97,121,101,114,41)_0xA36A.Text =""_0xA36A.TextColor3 = _0x90E7.Text
_0xA36A.PlaceholderColor3 = _0x90E7.Muted
_0xA36A.Font = Enum.Font.Gotham
_0xA36A.TextSize = 11
_0xA36A.LayoutOrder = 2
_0xA36A.ClearTextOnFocus = false
_0xA36A.ZIndex = 7
_0xA36A.Parent = _0xE441
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xA36A).CornerRadius = UDim.new(0, 7)
local _0x6EAE = Instance.new(string.char(85,73,80,97,100,100,105,110,103))
_0x6EAE.PaddingLeft = UDim.new(0, 10)
_0x6EAE.PaddingRight = UDim.new(0, 10)
_0x6EAE.Parent = _0xA36A
_0x7A5D(_0x0A85)
local _0xD4EB = Instance.new(string.char(70,114,97,109,101))
_0xD4EB.Size = UDim2.new(1, 0, 0, 30)
_0xD4EB.BackgroundTransparency = 1
_0xD4EB.LayoutOrder = 3
_0xD4EB.ZIndex = 7
_0xD4EB.Parent = _0xE441
local _0x2E3D = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x2E3D.Size = UDim2.new(0.5, -3, 1, 0)
_0x2E3D.Text =string.char(82,79,65,83,84)_0x2E3D.TextColor3 = _0x90E7.Text
_0x2E3D.Font = Enum.Font.GothamBold
_0x2E3D.TextSize = 10
_0x2E3D.ZIndex = 8
_0x2E3D.Parent = _0xD4EB
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x2E3D).CornerRadius = UDim.new(0, 6)
_0x961E(_0x2E3D, _0x90E7.Accent2)
local _0xF9A2 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xF9A2.Size = UDim2.new(0.5, -3, 1, 0)
_0xF9A2.Position = UDim2.new(0.5, 3, 0, 0)
_0xF9A2.Text =string.char(77,69,83,83,65,71,69)_0xF9A2.TextColor3 = _0x90E7.Text
_0xF9A2.Font = Enum.Font.GothamBold
_0xF9A2.TextSize = 10
_0xF9A2.ZIndex = 8
_0xF9A2.Parent = _0xD4EB
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xF9A2).CornerRadius = UDim.new(0, 6)
_0x961E(_0xF9A2, _0x90E7.PanelLt)
local _0x5695 = Instance.new(string.char(84,101,120,116,66,111,120))
_0x5695.Size = UDim2.new(1, 0, 0, 32)
_0x5695.BackgroundColor3 = _0x90E7.Panel
_0x5695.PlaceholderText =string.char(67,117,115,116,111,109,32,109,101,115,115,97,103,101,32,116,111,32,115,112,97,109,46,46,46)_0x5695.Text =""_0x5695.TextColor3 = _0x90E7.Text
_0x5695.PlaceholderColor3 = _0x90E7.Muted
_0x5695.Font = Enum.Font.Gotham
_0x5695.TextSize = 11
_0x5695.LayoutOrder = 4
_0x5695.ClearTextOnFocus = false
_0x5695.Visible = false
_0x5695.ZIndex = 7
_0x5695.Parent = _0xE441
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x5695).CornerRadius = UDim.new(0, 7)
local _0x6F75 = Instance.new(string.char(85,73,80,97,100,100,105,110,103))
_0x6F75.PaddingLeft = UDim.new(0, 10)
_0x6F75.PaddingRight = UDim.new(0, 10)
_0x6F75.Parent = _0x5695
local function _0x3CDC(_0xC05B)
_0x546D = _0xC05B
_0x3BAC[_0x2E3D] = (_0xC05B ==string.char(114,111,97,115,116)) and _0x90E7.Accent2 or _0x90E7.PanelLt
_0x3BAC[_0xF9A2] = (_0xC05B ==string.char(109,101,115,115,97,103,101)) and _0x90E7.Accent2 or _0x90E7.PanelLt
_0x2E3D.BackgroundColor3 = _0x3BAC[_0x2E3D]
_0xF9A2.BackgroundColor3 = _0x3BAC[_0xF9A2]
_0x5695.Visible = (_0xC05B ==string.char(109,101,115,115,97,103,101))
end
_0x2E3D.MouseButton1Click:Connect(function() _0x0909(); _0x3CDC(string.char(114,111,97,115,116)) end)
_0xF9A2.MouseButton1Click:Connect(function() _0x0909(); _0x3CDC(string.char(109,101,115,115,97,103,101)) end)
local _0x91FC = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x91FC.Size = UDim2.new(1, 0, 0, 16)
_0x91FC.BackgroundTransparency = 1
_0x91FC.LayoutOrder = 5
_0x91FC.Text =string.char(115,116,97,116,117,115,58,32,105,100,108,101)_0x91FC.TextColor3 = _0x90E7.Muted
_0x91FC.Font = Enum.Font.Gotham
_0x91FC.TextSize = 10
_0x91FC.TextXAlignment = Enum.TextXAlignment.Left
_0x91FC.ZIndex = 7
_0x91FC.Parent = _0xE441
local _0x31E2 = Instance.new(string.char(70,114,97,109,101))
_0x31E2.Size = UDim2.new(1, 0, 0, 32)
_0x31E2.BackgroundTransparency = 1
_0x31E2.LayoutOrder = 6
_0x31E2.ZIndex = 7
_0x31E2.Parent = _0xE441
local _0x3DB1 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x3DB1.Size = UDim2.new(0.5, -3, 1, 0)
_0x3DB1.Text =string.char(83,84,65,82,84)_0x3DB1.TextColor3 = Color3.new(1, 1, 1)
_0x3DB1.Font = Enum.Font.GothamBold
_0x3DB1.TextSize = 11
_0x3DB1.ZIndex = 8
_0x3DB1.Parent = _0x31E2
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x3DB1).CornerRadius = UDim.new(0, 6)
_0x961E(_0x3DB1, _0xF580)
local _0x6F1E = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x6F1E.Size = UDim2.new(0.5, -3, 1, 0)
_0x6F1E.Position = UDim2.new(0.5, 3, 0, 0)
_0x6F1E.Text =string.char(83,84,79,80)_0x6F1E.TextColor3 = Color3.new(1, 1, 1)
_0x6F1E.Font = Enum.Font.GothamBold
_0x6F1E.TextSize = 11
_0x6F1E.ZIndex = 8
_0x6F1E.Parent = _0x31E2
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x6F1E).CornerRadius = UDim.new(0, 6)
_0x961E(_0x6F1E, _0x90E7.Danger)
local function _0x46FD()
if _0x59D4 then return end
_0xC080 = (_0xA36A.Text or""):gsub(string.char(94,37,115,42,64,43,37,115,42),"")
_0x48CA = _0x5695.Text
if _0x546D ==string.char(114,111,97,115,116)then
local _0xD159 = (_0xC080 ~=""and _0xC080 ~= nil) and _0x8324(_0xC080, _0xA6AA) or nil
if not _0xD159 then
local _0x5CE2 = _0xB894()
if _0x5CE2 then _0xC080 = _0x5CE2.Name end
end
if _0xC080 ==""or _0xC080 == nil then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(78,111,32,116,97,114,103,101,116,32,111,114,32,110,101,97,114,98,121,32,112,108,97,121,101,114,32,102,111,117,110,100))
_0xB065()
return
end
_0xA36A.Text = _0xC080
end
if _0x546D ==string.char(109,101,115,115,97,103,101)and _0x48CA ==""then
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(69,110,116,101,114,32,97,32,109,101,115,115,97,103,101))
_0xB065()
return
end
_0x59D4 = true
_0x21C1 = _0x21C1 + 1
_0xC9A9 = 0
_0x91FC.Text =string.char(114,117,110,110,105,110,103,32,194,183,32).. _0x546D
_0x91FC.TextColor3 = _0x90E7.Success
local _0xA9E7 = _0x21C1
task.spawn(function()
while _0x59D4 and _0x21C1 == _0xA9E7 do
local _0xC05B = _0x7154()
if _0xC05B ~=""then
if _0xA6C9(_0xC05B) then
_0xC9A9 = _0xC9A9 + 1
_0x91FC.Text =string.char(114,117,110,110,105,110,103,32,194,183,32).. _0x50D5 ..string.char(32,194,183,32).. _0xC9A9
else
_0x91FC.Text =string.char(102,97,105,108,101,100,32,116,111,32,115,101,110,100)_0x91FC.TextColor3 = _0x90E7.Danger
end
end
task.wait(_0xAB73)
end
end)
_0xF140()
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(67,104,97,116,32,115,112,97,109,109,101,114,32,115,116,97,114,116,101,100))
end
_0xFA8C = function()
_0x59D4 = false
_0x21C1 = _0x21C1 + 1
_0x91FC.Text =string.char(115,116,111,112,112,101,100,32,194,183,32).. _0xC9A9 ..string.char(32,115,101,110,116)_0x91FC.TextColor3 = _0x90E7.Muted
_0xED6E()
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(67,104,97,116,32,115,112,97,109,109,101,114,32,115,116,111,112,112,101,100))
end
_0x3DB1.MouseButton1Click:Connect(function() _0x0909(); _0x46FD() end)
_0x6F1E.MouseButton1Click:Connect(function() _0x0909(); _0xFA8C() end)
_0x3CDC(string.char(114,111,97,115,116))
enddolocal _0xB650 = {}_0xA00F = function()
for _0x9094, _0x4599 in ipairs(_0xB650) do
if _0x4599.btn and _0x4599.btn.Parent then
local _0xE898 = _0x4599.getState()
local _0xBEC2 = _0x4599.isAlwaysOn and _0x5DAB.AlwaysOnCore
_0x3BAC[_0x4599.btn] = _0xE898 and _0xF580 or _0x90E7.PanelLt
_0x4599.btn.BackgroundColor3 = _0x3BAC[_0x4599.btn]
_0x4599.btn.Text = _0xBEC2 andstring.char(65,76,87,65,89,83,32,79,78)or (_0xE898 andstring.char(79,78)orstring.char(79,70,70))
end
end
if _0x8AC6 then pcall(_0x8AC6) end
endlocal _0x3514 = Instance.new(string.char(70,114,97,109,101))
_0x3514.Size = UDim2.new(1, 0, 0, 30)
_0x3514.BackgroundTransparency = 1
_0x3514.LayoutOrder = 0
_0x3514.ZIndex = 7
_0x3514.Parent = _0x7261
local _0x28D7 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x28D7.Size = UDim2.new(0.64, -3, 1, 0)
_0x28D7.Text =string.char(239,191,189,239,191,189,239,184,143,32,69,78,65,66,76,69,32,65,76,76,32,65,68,86,65,78,67,69,68,32,65,78,84,73)_0x28D7.TextColor3 = Color3.new(1, 1, 1)
_0x28D7.Font = Enum.Font.GothamBold
_0x28D7.TextSize = 10
_0x28D7.ZIndex = 8
_0x28D7.Parent = _0x3514
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x28D7).CornerRadius = UDim.new(0, 7)
_0x961E(_0x28D7, _0xF580)
_0x28D7.MouseButton1Click:Connect(function()
_0x0909()
_0x5DAB.enableAll()
end)
local _0x468D = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x468D.Size = UDim2.new(0.36, -3, 1, 0)
_0x468D.Position = UDim2.new(0.64, 6, 0, 0)
_0x468D.Text =string.char(68,73,83,65,66,76,69,32,79,80,84,46)_0x468D.TextColor3 = Color3.new(1, 1, 1)
_0x468D.Font = Enum.Font.GothamBold
_0x468D.TextSize = 10
_0x468D.ZIndex = 8
_0x468D.Parent = _0x3514
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x468D).CornerRadius = UDim.new(0, 7)
_0x961E(_0x468D, _0x90E7.Danger)
_0x468D.MouseButton1Click:Connect(function()
_0x0909()
_0x5DAB.disableAll()
end)
_0x8DC1(_0x7261, 1,string.char(68,69,70,69,78,67,69,32,84,82,79,76,76,32,77,65,84,82,73,88,32,86,51,32,32,40,54,32,67,79,85,78,84,69,82,45,77,79,68,69,83,32,43,32,79,77,78,73,45,82,65,68,65,82,41), _0x90E7.Accent)local _0x2A28 = Instance.new(string.char(70,114,97,109,101))
_0x2A28.Size = UDim2.new(1, 0, 0, 122)
_0x2A28.BackgroundColor3 = _0x90E7.Panel
_0x2A28.BorderSizePixel = 0
_0x2A28.LayoutOrder = 2
_0x2A28.ZIndex = 7
_0x2A28.Parent = _0x7261
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x2A28).CornerRadius = UDim.new(0, 8)
local _0x4740 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x4740.Color = _0x90E7.Accent
_0x4740.Thickness = 1.2
_0x4740.Transparency = 0.35
_0x4740.Parent = _0x2A28local _0x7FC7 = Instance.new(string.char(70,114,97,109,101))
_0x7FC7.Size = UDim2.new(1, 0, 0, 36)
_0x7FC7.BackgroundTransparency = 1
_0x7FC7.ZIndex = 8
_0x7FC7.Parent = _0x2A28
local _0xA0DD = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0xA0DD.Size = UDim2.new(1, -94, 1, 0)
_0xA0DD.Position = UDim2.new(0, 12, 0, 0)
_0xA0DD.BackgroundTransparency = 1
_0xA0DD.Text =string.char(68,69,70,69,78,67,69,32,84,82,79,76,76,32,77,65,84,82,73,88,32,86,51)_0xA0DD.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xA0DD.Font = Enum.Font.GothamBold
_0xA0DD.TextSize = 11
_0xA0DD.TextXAlignment = Enum.TextXAlignment.Left
_0xA0DD.ZIndex = 9
_0xA0DD.Parent = _0x7FC7
local _0xB63F = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xB63F.Size = UDim2.new(0, 72, 0, 24)
_0xB63F.Position = UDim2.new(1, -82, 0.5, -12)
_0xB63F.Text = _0x7DE1.enabled andstring.char(79,78)orstring.char(79,70,70)_0xB63F.TextColor3 = Color3.new(1, 1, 1)
_0xB63F.Font = Enum.Font.GothamBold
_0xB63F.TextSize = 10
_0xB63F.ZIndex = 9
_0xB63F.Parent = _0x7FC7
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xB63F).CornerRadius = UDim.new(1, 0)
_0x961E(_0xB63F, _0x7DE1.enabled and _0xF580 or _0x90E7.PanelLt)local _0xDBF1 = Instance.new(string.char(70,114,97,109,101))
_0xDBF1.Size = UDim2.new(1, -20, 0, 28)
_0xDBF1.Position = UDim2.new(0, 10, 0, 40)
_0xDBF1.BackgroundTransparency = 1
_0xDBF1.ZIndex = 8
_0xDBF1.Parent = _0x2A28
local _0x3508 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x3508.Size = UDim2.new(0.62, -4, 1, 0)
_0x3508.BackgroundColor3 = _0x90E7.PanelLt
_0x3508.Text =string.char(77,79,68,69,58,32).. (_0x7DE1.modeLabels[_0x7DE1.mode] or _0x7DE1.mode)
_0x3508.TextColor3 = _0x90E7.Neon
_0x3508.Font = Enum.Font.GothamBold
_0x3508.TextSize = 9
_0x3508.ZIndex = 9
_0x3508.Parent = _0xDBF1
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x3508).CornerRadius = UDim.new(0, 6)
_0x961E(_0x3508, _0x90E7.PanelLt)
local _0x24BD = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x24BD.Size = UDim2.new(0.38, 0, 1, 0)
_0x24BD.Position = UDim2.new(0.62, 2, 0, 0)
_0x24BD.BackgroundColor3 = _0x90E7.PanelLt
_0x24BD.Text =string.char(82,65,68,65,82,58,32).. tostring(_0x7DE1.range) ..string.char(115)_0x24BD.TextColor3 = _0x90E7.Text
_0x24BD.Font = Enum.Font.GothamBold
_0x24BD.TextSize = 9
_0x24BD.ZIndex = 9
_0x24BD.Parent = _0xDBF1
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x24BD).CornerRadius = UDim.new(0, 6)
_0x961E(_0x24BD, _0x90E7.PanelLt)local _0xCAE3 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0xCAE3.Size = UDim2.new(1, -24, 0, 40)
_0xCAE3.Position = UDim2.new(0, 12, 0, 74)
_0xCAE3.BackgroundTransparency = 1
_0xCAE3.Text =string.char(226,154,161,32,67,79,85,78,84,69,82,69,68,58,32,48,32,32,194,183,32,32,70,76,73,78,71,83,58,32,48,32,32,194,183,32,32,76,65,71,32,80,85,82,71,69,68,58,32,48,10,67,79,82,69,32,50,52,47,55,58,32,65,110,116,105,45,83,105,116,32,194,183,32,65,110,116,105,45,86,111,105,100,32,194,183,32,65,110,116,105,45,76,97,103,32,194,183,32,65,110,116,105,45,70,114,101,101,122,101,32,65,67,84,73,86,69)_0xCAE3.TextColor3 = _0x90E7.Muted
_0xCAE3.Font = Enum.Font.GothamMedium
_0xCAE3.TextSize = 8
_0xCAE3.TextWrapped = true
_0xCAE3.TextXAlignment = Enum.TextXAlignment.Left
_0xCAE3.ZIndex = 9
_0xCAE3.Parent = _0x2A28
_0x8AC6 = function()
pcall(function()
if _0xCAE3 and _0xCAE3.Parent then
_0xCAE3.Text = string.format(string.char(226,154,161,32,67,79,85,78,84,69,82,69,68,58,32,37,100,32,32,194,183,32,32,70,76,73,78,71,83,58,32,37,100,32,32,194,183,32,32,83,69,65,84,83,58,32,37,100,32,32,194,183,32,32,76,65,71,58,32,37,100,10,76,65,83,84,58,32,37,115,32,40,37,115,41,32,32,194,183,32,32,50,52,47,55,32,67,79,82,69,32,83,72,73,69,76,68,83,32,79,78),
_0x7DE1.deflectCount or 0,
_0x5DAB.FlingShield.blockedFlings or 0,
_0x5DAB.SeatTrap.neutralizedSeats or 0,
_0x5DAB.Lag.purgedItems or 0,
tostring(_0x7DE1.lastAttackerName orstring.char(78,111,110,101)),
tostring(_0x7DE1.lastThreatReason orstring.char(83,116,97,110,100,98,121))
)
end
if _0xB63F and _0xB63F.Parent then
_0xB63F.Text = _0x7DE1.enabled andstring.char(79,78)orstring.char(79,70,70)_0x3BAC[_0xB63F] = _0x7DE1.enabled and _0xF580 or _0x90E7.PanelLt
_0xB63F.BackgroundColor3 = _0x3BAC[_0xB63F]
end
end)
end
_0xB63F.MouseButton1Click:Connect(function()
_0x0909()
if _0x7DE1.enabled then
_0x7DE1.stopFn()
else
_0x7DE1.startFn()
end
_0x8AC6()
end)
_0x3508.MouseButton1Click:Connect(function()
_0x0909()
local _0xF25B = 1
for i, _0xC05B in ipairs(_0x7DE1.modes) do
if _0xC05B == _0x7DE1.mode then _0xF25B = i; break end
end
_0xF25B = (_0xF25B % #_0x7DE1.modes) + 1
_0x7DE1.mode = _0x7DE1.modes[_0xF25B]
_0x3508.Text =string.char(77,79,68,69,58,32).. (_0x7DE1.modeLabels[_0x7DE1.mode] or _0x7DE1.mode)
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(68,101,102,101,110,99,101,32,77,111,100,101,32,115,101,116,58,32).. (_0x7DE1.modeLabels[_0x7DE1.mode] or _0x7DE1.mode))
_0x8AC6()
end)
_0x24BD.MouseButton1Click:Connect(function()
_0x0909()
_0x7DE1.rangeIdx = (_0x7DE1.rangeIdx % #_0x7DE1.ranges) + 1
_0x7DE1.range = _0x7DE1.ranges[_0x7DE1.rangeIdx]
_0x24BD.Text =string.char(82,65,68,65,82,58,32).. tostring(_0x7DE1.range) ..string.char(115)_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(68,101,102,108,101,99,116,32,82,97,100,97,114,32,82,97,110,103,101,58,32).. tostring(_0x7DE1.range) ..string.char(32,115,116,117,100,115))
end)
_0x8DC1(_0x7261, 3,string.char(239,191,189,239,191,189,32,50,52,47,55,32,65,76,87,65,89,83,45,79,78,32,67,79,82,69,32,83,72,73,69,76,68,83,32,40,65,78,84,73,45,83,73,84,32,47,32,86,79,73,68,32,47,32,76,65,71,32,47,32,70,82,69,69,90,69,41), _0x90E7.Success)
local function _0x813C(order, label, getState, onEnable, onDisable, isAlwaysOn)
local _0xD663 = Instance.new(string.char(70,114,97,109,101))
_0xD663.Size = UDim2.new(1, 0, 0, 34)
_0xD663.BackgroundColor3 = _0x90E7.Panel
_0xD663.BorderSizePixel = 0
_0xD663.LayoutOrder = order
_0xD663.ZIndex = 7
_0xD663.Parent = _0x7261
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xD663).CornerRadius = UDim.new(0, 7)
local _0x2594 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x2594.Size = UDim2.new(1, -98, 1, 0)
_0x2594.Position = UDim2.new(0, 12, 0, 0)
_0x2594.BackgroundTransparency = 1
_0x2594.Text = label
_0x2594.TextColor3 = isAlwaysOn and _0x90E7.Neon or _0x90E7.Text
_0x2594.Font = isAlwaysOn and Enum.Font.GothamBold or Enum.Font.GothamMedium
_0x2594.TextSize = 10
_0x2594.TextXAlignment = Enum.TextXAlignment.Left
_0x2594.TextTruncate = Enum.TextTruncate.AtEnd
_0x2594.ZIndex = 8
_0x2594.Parent = _0xD663
local _0xE898 = getState()
local _0xBEC2 = isAlwaysOn and _0x5DAB.AlwaysOnCore
local _0x43E0 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x43E0.Size = UDim2.new(0, 78, 0, 24)
_0x43E0.Position = UDim2.new(1, -86, 0.5, -12)
_0x43E0.Text = _0xBEC2 andstring.char(65,76,87,65,89,83,32,79,78)or (_0xE898 andstring.char(79,78)orstring.char(79,70,70))
_0x43E0.TextColor3 = Color3.new(1, 1, 1)
_0x43E0.Font = Enum.Font.GothamBold
_0x43E0.TextSize = _0xBEC2 and 8 or 10
_0x43E0.ZIndex = 8
_0x43E0.Parent = _0xD663
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x43E0).CornerRadius = UDim.new(1, 0)
_0x961E(_0x43E0, _0xE898 and _0xF580 or _0x90E7.PanelLt)
table.insert(_0xB650, { _0x43E0 = _0x43E0, getState = getState, isAlwaysOn = isAlwaysOn })
_0x43E0.MouseButton1Click:Connect(function()
_0x0909()
if getState() then
onDisable()
else
onEnable()
end
_0xA00F()
end)
return _0x43E0
end_0x813C(4,string.char(239,191,189,239,191,189,32,65,110,116,105,45,83,105,116,32,47,32,67,111,117,99,104,45,75,105,100,110,97,112,32,68,101,115,116,114,111,121,101,114,32,118,52,32,40,50,52,47,55,41), function() return _0x5DAB.SeatTrap.enabled end, _0x5DAB.SeatTrap.startFn, _0x5DAB.SeatTrap.stopFn, true)
_0x813C(5,string.char(239,191,189,239,191,189,32,65,110,116,105,45,82,97,103,100,111,108,108,32,47,32,65,110,116,105,45,83,105,116,32,47,32,65,110,116,105,45,83,116,117,110,32,118,52,32,40,50,52,47,55,41), function() return _0x5DAB.Ragdoll.enabled end, _0x5DAB.Ragdoll.startFn, _0x5DAB.Ragdoll.stopFn, true)
_0x813C(6,string.char(239,191,189,239,191,189,32,65,110,116,105,45,86,111,105,100,32,118,52,32,40,50,48,52,56,120,50,48,52,56,32,70,108,111,111,114,32,43,32,67,97,116,99,104,32,50,52,47,55,41), function() return _0x5DAB.Void.enabled end, _0x5DAB.Void.startFn, _0x5DAB.Void.stopFn, true)
_0x813C(7,string.char(239,191,189,239,191,189,32,73,110,102,105,110,105,116,101,32,70,97,108,108,32,86,111,105,100,32,40,78,97,78,32,75,105,108,108,80,108,97,110,101,32,76,111,99,107,32,50,52,47,55,41), function() return _0x5DAB.InfFallVoid.enabled end, _0x5DAB.InfFallVoid.startFn, _0x5DAB.InfFallVoid.stopFn, true)
_0x813C(8,string.char(239,191,189,239,191,189,32,65,110,116,105,45,76,97,103,32,118,52,32,40,80,97,114,116,105,99,108,101,32,38,32,67,108,111,110,101,45,66,111,109,98,32,80,117,114,103,101,114,32,50,52,47,55,41), function() return _0x5DAB.Lag.enabled end, _0x5DAB.Lag.startFn, _0x5DAB.Lag.stopFn, true)
_0x813C(9,string.char(239,191,189,239,191,189,32,65,110,116,105,45,70,114,101,101,122,101,32,47,32,65,110,116,105,45,65,110,99,104,111,114,32,38,32,77,111,118,101,114,32,80,117,114,103,101,114,32,118,52,32,40,50,52,47,55,41), function() return _0x5DAB.Anchor.enabled end, _0x5DAB.Anchor.startFn, _0x5DAB.Anchor.stopFn, true)
_0x813C(10,string.char(239,191,189,239,191,189,32,65,110,116,105,45,71,97,109,101,112,108,97,121,80,97,117,115,101,100,32,47,32,65,110,116,105,45,78,101,116,119,111,114,107,70,114,101,101,122,101,32,118,52,32,40,50,52,47,55,41), function() return _0x5DAB.GamePaused.enabled end, _0x5DAB.GamePaused.startFn, _0x5DAB.GamePaused.stopFn, true)
_0x8DC1(_0x7261, 11,string.char(65,68,68,73,84,73,79,78,65,76,32,67,72,65,82,65,67,84,69,82,32,38,32,80,72,89,83,73,67,83,32,83,72,73,69,76,68,83,32,40,86,52,41), _0x90E7.Muted)
_0x813C(12,string.char(65,110,116,105,45,70,108,105,110,103,32,118,51,32,40,83,101,114,118,101,114,32,78,111,45,67,111,108,108,105,100,101,32,43,32,90,101,114,111,45,73,109,112,117,108,115,101,41), function() return _0x5DAB.FlingShield.enabled end, _0x5DAB.FlingShield.startFn, _0x5DAB.FlingShield.stopFn, false)
_0x813C(13,string.char(65,110,116,105,45,75,105,108,108,32,47,32,71,111,100,45,77,111,100,101,32,118,51,32,40,84,111,117,99,104,32,83,104,105,101,108,100,32,43,32,70,111,114,99,101,70,105,101,108,100,41), function() return _0x5DAB.Kill.enabled end, _0x5DAB.Kill.startFn, _0x5DAB.Kill.stopFn, false)
_0x813C(14,string.char(65,110,116,105,45,65,116,116,97,99,104,32,47,32,79,109,110,105,45,87,101,108,100,32,38,32,71,114,97,98,32,83,101,118,101,114,32,118,51), function() return _0x5DAB.Attach.enabled end, _0x5DAB.Attach.startFn, _0x5DAB.Attach.stopFn, false)
_0x813C(15,string.char(65,110,116,105,45,66,114,105,110,103,32,47,32,84,111,111,108,45,71,114,97,98,32,38,32,84,101,108,101,112,111,114,116,32,71,117,97,114,100,32,118,51), function() return _0x5DAB.Bring.enabled end, _0x5DAB.Bring.startFn, _0x5DAB.Bring.stopFn, false)
_0x813C(16,string.char(65,110,116,105,45,84,111,111,108,32,47,32,67,111,117,99,104,32,47,32,67,97,114,114,121,32,47,32,67,117,102,102,115,32,68,105,115,97,114,109,101,114,32,118,51), function() return _0x5DAB.ToolGuard.enabled end, _0x5DAB.ToolGuard.startFn, _0x5DAB.ToolGuard.stopFn, false)
_0x813C(17,string.char(65,110,116,105,45,72,101,97,100,115,105,116,32,38,32,65,110,116,105,45,70,97,99,101,98,97,110,103,32,69,118,97,100,101,114,32,40,76,105,98,114,97,114,121,41), function() return _0x5DAB.AntiHeadsit.enabled end, _0x5DAB.AntiHeadsit.startFn, _0x5DAB.AntiHeadsit.stopFn, false)
_0x813C(18,string.char(65,110,116,105,45,66,97,110,103,32,71,108,105,116,99,104,32,68,101,115,121,110,99,32,40,69,118,97,100,101,32,66,97,110,103,115,32,47,32,67,70,114,97,109,101,32,83,112,111,111,102,41), function() return _0x5DAB.GlitchDesync.enabled end, _0x5DAB.GlitchDesync.startFn, _0x5DAB.GlitchDesync.stopFn, false)
_0x813C(19,string.char(65,110,116,105,45,66,108,105,110,100,32,47,32,65,110,116,105,45,70,108,97,115,104,98,97,110,103,32,38,32,70,111,103,32,67,108,101,97,114,32,118,51), function() return _0x5DAB.Blind.enabled end, _0x5DAB.Blind.startFn, _0x5DAB.Blind.stopFn, false)
_0x8DC1(_0x7261, 20,string.char(75,72,65,77,65,78,32,65,78,84,73,45,86,67,32,86,52,32,85,76,84,82,65,32,66,89,80,65,83,83,32,38,32,67,79,85,78,84,69,82,45,84,82,65,80,83), _0x90E7.Accent)
_0x813C(21,string.char(75,104,97,109,97,110,32,65,110,116,105,45,86,67,32,118,52,32,40,65,117,116,111,32,43,32,70,111,114,99,101,32,86,111,105,99,101,32,66,121,112,97,115,115,41), function() return _0x5DAB.VC.enabled or _0x5DAB.VC.running end, _0x5DAB.VC.startFn, _0x5DAB.VC.stopFn, false)
_0x813C(22,string.char(86,111,105,100,45,80,97,117,115,101,32,65,116,116,97,99,107,101,114,32,40,66,97,110,105,115,104,32,87,101,108,100,101,100,32,84,114,111,108,108,115,41), function() return _0x5DAB.PauseTrap.enabled end, _0x5DAB.PauseTrap.startFn, _0x5DAB.PauseTrap.stopFn, false)
_0x813C(23,string.char(82,101,100,105,114,101,99,116,32,65,116,116,97,99,107,101,114,32,45,62,32,78,101,97,114,101,115,116,32,66,121,115,116,97,110,100,101,114), function() return _0x5DAB.Redirect.enabled end, _0x5DAB.Redirect.startFn, _0x5DAB.Redirect.stopFn, false)
_0x813C(24,string.char(65,110,116,105,45,75,105,99,107,32,40,73,110,116,101,114,99,101,112,116,32,67,108,105,101,110,116,32,76,111,99,97,108,80,108,97,121,101,114,58,75,105,99,107,41), function() return _0x5DAB.Kick.enabled end, _0x5DAB.Kick.startFn, _0x5DAB.Kick.stopFn, false)
_0x813C(25,string.char(65,110,116,105,45,65,70,75,32,118,51,32,40,73,100,108,101,100,32,43,32,86,105,114,116,117,97,108,85,115,101,114,32,43,32,73,110,112,117,116,32,80,117,108,115,101,41), function() return _0x5DAB.AFK.enabled end, _0x5DAB.AFK.startFn, _0x5DAB.AFK.stopFn, false)
do
local _0x8873 = Instance.new(string.char(70,114,97,109,101))
_0x8873.Size = UDim2.new(1, 0, 0, 68)
_0x8873.BackgroundColor3 = _0x90E7.Panel
_0x8873.BorderSizePixel = 0
_0x8873.LayoutOrder = 26
_0x8873.ZIndex = 7
_0x8873.Parent = _0x7261
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x8873).CornerRadius = UDim.new(0, 7)
local _0xB122 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0xB122.Size = UDim2.new(1, -138, 0, 28)
_0xB122.Position = UDim2.new(0, 12, 0, 4)
_0xB122.BackgroundTransparency = 1
_0xB122.Text =string.char(83,116,97,116,117,115,58,32,73,100,108,101,32,194,183,32,71,117,97,114,100,58,48)_0xB122.TextColor3 = _0x90E7.Neon
_0xB122.Font = Enum.Font.GothamBold
_0xB122.TextSize = 10
_0xB122.TextXAlignment = Enum.TextXAlignment.Left
_0xB122.ZIndex = 8
_0xB122.Parent = _0x8873
_0x5DAB.VC.rowSubLbl = _0xB122
local _0x56EA = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x56EA.Size = UDim2.new(0, 118, 0, 24)
_0x56EA.Position = UDim2.new(1, -126, 0, 6)
_0x56EA.Text =string.char(79,80,69,78,32,65,78,84,73,45,86,67,32,85,73)_0x56EA.TextColor3 = Color3.new(1, 1, 1)
_0x56EA.Font = Enum.Font.GothamBold
_0x56EA.TextSize = 9
_0x56EA.ZIndex = 8
_0x56EA.Parent = _0x8873
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x56EA).CornerRadius = UDim.new(0, 6)
_0x961E(_0x56EA, _0x90E7.Accent2)
_0x56EA.MouseButton1Click:Connect(function()
_0x0909()
if _0x5DAB.VC.openPanelFn then _0x5DAB.VC.openPanelFn() end
end)
local _0x49A1 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x49A1.Size = UDim2.new(0.36, -6, 0, 26)
_0x49A1.Position = UDim2.new(0, 8, 0, 36)
_0x49A1.Text =string.char(226,154,161,32,70,79,82,67,69,32,66,89,80,65,83,83)_0x49A1.TextColor3 = Color3.new(1, 1, 1)
_0x49A1.Font = Enum.Font.GothamBold
_0x49A1.TextSize = 9
_0x49A1.ZIndex = 8
_0x49A1.Parent = _0x8873
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x49A1).CornerRadius = UDim.new(0, 6)
_0x961E(_0x49A1, Color3.fromRGB(185, 115, 12))
_0x49A1.MouseButton1Click:Connect(function()
_0x0909()
if _0x5DAB.VC.forceBypassFn then _0x5DAB.VC.forceBypassFn() end
end)
local _0xA067 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xA067.Size = UDim2.new(0.32, -4, 0, 26)
_0xA067.Position = UDim2.new(0.36, 4, 0, 36)
_0xA067.Text =string.char(239,191,189,239,191,189,239,184,143,32,76,73,86,69)_0xA067.TextColor3 = Color3.new(1, 1, 1)
_0xA067.Font = Enum.Font.GothamBold
_0xA067.TextSize = 9
_0xA067.ZIndex = 8
_0xA067.Parent = _0x8873
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xA067).CornerRadius = UDim.new(0, 6)
_0x961E(_0xA067, _0xF580)
_0x5DAB.VC.inlineMicBtn = _0xA067
_0xA067.MouseButton1Click:Connect(function()
_0x0909()
if _0x5DAB.VC.toggleMicFn then _0x5DAB.VC.toggleMicFn() end
end)
local _0x5E9E = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x5E9E.Size = UDim2.new(0.32, -8, 0, 26)
_0x5E9E.Position = UDim2.new(0.68, 4, 0, 36)
_0x5E9E.Text =string.char(239,191,189,239,191,189,32,82,69,74,79,73,78,32,86,67)_0x5E9E.TextColor3 = _0x90E7.Neon
_0x5E9E.Font = Enum.Font.GothamBold
_0x5E9E.TextSize = 9
_0x5E9E.ZIndex = 8
_0x5E9E.Parent = _0x8873
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x5E9E).CornerRadius = UDim.new(0, 6)
_0x961E(_0x5E9E, _0x90E7.PanelLt)
_0x5E9E.MouseButton1Click:Connect(function()
_0x0909()
if _0x5DAB.VC.rejoinFn then _0x5DAB.VC.rejoinFn() end
end)
end
_0xA00F()
enddo_0x8DC1(_0xAC95, -4,string.char(67,72,82,79,78,79,45,82,69,87,73,78,68,32,83,89,83,84,69,77,32,32,40,54,115,32,226,128,147,32,49,48,115,32,69,88,65,67,84,32,80,82,69,67,73,83,73,79,78,41), _0x90E7.Neon)
local _0xE23B = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xE23B.Size = UDim2.new(1, 0, 0, 34)
_0xE23B.BackgroundColor3 = _0x90E7.Accent2
_0xE23B.BorderSizePixel = 0
_0xE23B.Text =string.char(226,143,170,32,82,69,87,73,78,68,32,84,73,77,69,32,78,79,87,32,32,40).. tostring(_0xAE44.duration) ..string.char(115,32,80,82,69,67,73,83,73,79,78,41,32,32,91,75,69,89,58,32,82,93)_0xE23B.TextColor3 = Color3.new(1, 1, 1)
_0xE23B.Font = Enum.Font.GothamBold
_0xE23B.TextSize = 10
_0xE23B.LayoutOrder = -3
_0xE23B.ZIndex = 7
_0xE23B.Parent = _0xAC95
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xE23B).CornerRadius = UDim.new(0, 7)
_0x961E(_0xE23B, _0x90E7.Accent2)
_0xE23B.MouseButton1Click:Connect(function()
_0x0909()
_0xAE44:Start(_0xAE44.duration)
end)
local _0xCD1A = Instance.new(string.char(70,114,97,109,101))
_0xCD1A.Size = UDim2.new(1, 0, 0, 28)
_0xCD1A.BackgroundTransparency = 1
_0xCD1A.LayoutOrder = -2
_0xCD1A.ZIndex = 7
_0xCD1A.Parent = _0xAC95
local _0x4384 = {
{ label =string.char(54,32,83,69,67), val = 6.0 },
{ label =string.char(56,32,83,69,67), val = 8.0 },
{ label =string.char(49,48,32,83,69,67,32,40,77,65,88,41), val = 10.0 },
}
local _0xE703 = {}
local function _0xF35E()
for _0x9094, item in ipairs(_0xE703) do
local _0x0A3D = math.abs(_0xAE44.duration - item.val) < 0.1
_0x3BAC[item.btn] = _0x0A3D and _0xF580 or _0x90E7.PanelLt
item.btn.BackgroundColor3 = _0x3BAC[item.btn]
item.btn.TextColor3 = _0x0A3D and Color3.new(1, 1, 1) or _0x90E7.Text
end
_0xE23B.Text =string.char(226,143,170,32,82,69,87,73,78,68,32,84,73,77,69,32,78,79,87,32,32,40).. tostring(_0xAE44.duration) ..string.char(115,32,80,82,69,67,73,83,73,79,78,41,32,32,91,75,69,89,58,32,82,93)end
for i, opt in ipairs(_0x4384) do
local _0x22CF = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x22CF.Size = UDim2.new(1 / 3, -3, 1, 0)
_0x22CF.Position = UDim2.new((i - 1) / 3, (i == 1) and 0 or 3, 0, 0)
_0x22CF.Text = opt.label
_0x22CF.Font = Enum.Font.GothamBold
_0x22CF.TextSize = 9
_0x22CF.ZIndex = 8
_0x22CF.Parent = _0xCD1A
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x22CF).CornerRadius = UDim.new(0, 6)
_0x961E(_0x22CF, _0x90E7.PanelLt)
table.insert(_0xE703, { _0x43E0 = _0x22CF, val = opt.val })
_0x22CF.MouseButton1Click:Connect(function()
_0x0909()
_0xAE44.duration = opt.val
_0xF35E()
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(82,101,119,105,110,100,32,119,105,110,100,111,119,32,115,101,116,32,116,111,32).. tostring(opt.val) ..string.char(32,115,101,99,111,110,100,115,32,40,54,48,72,122,32,101,120,97,99,116,41))
end)
end
_0xF35E()
local _0xD70A = Instance.new(string.char(70,114,97,109,101))
_0xD70A.Size = UDim2.new(1, 0, 0, 26)
_0xD70A.BackgroundTransparency = 1
_0xD70A.LayoutOrder = -1
_0xD70A.ZIndex = 7
_0xD70A.Parent = _0xAC95
local _0x5A92 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x5A92.Size = UDim2.new(0.55, -2, 1, 0)
_0x5A92.Text =string.char(77,79,68,69,58,32,83,77,79,79,84,72,32,82,69,86,69,82,83,69,32,82,69,80,76,65,89)_0x5A92.TextColor3 = _0x90E7.Neon
_0x5A92.Font = Enum.Font.GothamBold
_0x5A92.TextSize = 8
_0x5A92.ZIndex = 8
_0x5A92.Parent = _0xD70A
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x5A92).CornerRadius = UDim.new(0, 6)
_0x961E(_0x5A92, _0x90E7.Panel)
_0x5A92.MouseButton1Click:Connect(function()
_0x0909()
_0xAE44.instantMode = not _0xAE44.instantMode
_0x5A92.Text = _0xAE44.instantMode andstring.char(77,79,68,69,58,32,73,78,83,84,65,78,84,32,83,78,65,80,66,65,67,75)orstring.char(77,79,68,69,58,32,83,77,79,79,84,72,32,82,69,86,69,82,83,69,32,82,69,80,76,65,89)end)
local _0x239C = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x239C.Size = UDim2.new(0.45, -2, 1, 0)
_0x239C.Position = UDim2.new(0.55, 4, 0, 0)
_0x239C.Text =string.char(67,65,77,32,82,69,87,73,78,68,58,32,79,78)_0x239C.TextColor3 = Color3.new(1, 1, 1)
_0x239C.Font = Enum.Font.GothamBold
_0x239C.TextSize = 8
_0x239C.ZIndex = 8
_0x239C.Parent = _0xD70A
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x239C).CornerRadius = UDim.new(0, 6)
_0x961E(_0x239C, _0xF580)
_0x239C.MouseButton1Click:Connect(function()
_0x0909()
_0xAE44.rewindCamera = not _0xAE44.rewindCamera
_0x239C.Text = _0xAE44.rewindCamera andstring.char(67,65,77,32,82,69,87,73,78,68,58,32,79,78)orstring.char(67,65,77,32,82,69,87,73,78,68,58,32,79,70,70)_0x3BAC[_0x239C] = _0xAE44.rewindCamera and _0xF580 or _0x90E7.Panel
_0x239C.BackgroundColor3 = _0x3BAC[_0x239C]
end)
_0x8DC1(_0xAC95, 1,string.char(87,65,76,75,32,83,80,69,69,68,32,32,40,85,80,32,84,79,32,53,48,48,41), _0x90E7.Accent)
local _0xD6EC, _0x7868 = 16, 50
local _0x373A, _0x0AD9 = 32, 75
local _0xAA2C, _0x3E58 = 16, 500
local _0xAD02, _0x0295 = 350, 25
local function _0x6171()
local _0x7B2F = _0xA6AA.Character
if not _0x7B2F then return nil, nil, nil end
return _0x7B2F, _0x7B2F:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100)), _0x7B2F:FindFirstChild(string.char(72,117,109,97,110,111,105,100,82,111,111,116,80,97,114,116))
end
local function _0xB1D3(parent, order, text, callback, color)
local _0x4973 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x4973.Size = UDim2.new(1, 0, 0, 32)
_0x4973.BackgroundColor3 = color or _0x90E7.Panel
_0x4973.BorderSizePixel = 0
_0x4973.Text = text
_0x4973.TextColor3 = _0x90E7.Text
_0x4973.Font = Enum.Font.GothamBold
_0x4973.TextSize = 10
_0x4973.LayoutOrder = order
_0x4973.ZIndex = 7
_0x4973.Parent = parent
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4973).CornerRadius = UDim.new(0, 7)
_0x961E(_0x4973, color or _0x90E7.Panel)
_0x4973.MouseButton1Click:Connect(callback)
return _0x4973
end
local _0x3A47
_0x3A47 = _0xB1D3(_0xAC95, 2,string.char(87,65,76,75,32,83,80,69,69,68,32,32,194,183,32,32,79,70,70,32,32,40,51,50,41), function()
local _0x9094, _0xA778 = _0x6171()
if not _0xA778 then _0xA387(string.char(77,111,118,101,109,101,110,116),string.char(67,104,97,114,97,99,116,101,114,32,110,111,116,32,114,101,97,100,121,46)); return end
_0x02BF.speed = not _0x02BF.speed
_0xA778.WalkSpeed = _0x02BF.speed and _0x373A or _0xD6EC
_0x3A47.Text =string.char(87,65,76,75,32,83,80,69,69,68,32,32,194,183,32,32).. (_0x02BF.speed andstring.char(79,78)orstring.char(79,70,70)) ..string.char(32,32,40).. tostring(_0x373A) ..string.char(41)_0x3BAC[_0x3A47] = _0x02BF.speed and _0xF580 or _0x90E7.Panel
_0x3A47.BackgroundColor3 = _0x3BAC[_0x3A47]if _0x02BF.speed then
if _0x02BF.speedLoopConn then _0x02BF.speedLoopConn:Disconnect() end
_0x02BF.speedLoopConn = _0xC77A.Heartbeat:Connect(function()
if not _0x02BF.speed then return end
local _0x9094, _0xA077 = _0x6171()
if _0xA077 and _0xA077.WalkSpeed ~= _0x373A then
_0xA077.WalkSpeed = _0x373A
end
end)
else
if _0x02BF.speedLoopConn then
_0x02BF.speedLoopConn:Disconnect()
_0x02BF.speedLoopConn = nil
end
end
end)
local function _0x5302(val)
_0x373A = math.clamp(math.floor(val), _0xAA2C, _0x3E58)
_0x02BF.desiredWalkSpeed = _0x373A
local _0x9094, _0xA778 = _0x6171()
if _0xA778 and _0x02BF.speed then _0xA778.WalkSpeed = _0x373A end
if _0x3A47 then
_0x3A47.Text =string.char(87,65,76,75,32,83,80,69,69,68,32,32,194,183,32,32).. (_0x02BF.speed andstring.char(79,78)orstring.char(79,70,70)) ..string.char(32,32,40).. tostring(_0x373A) ..string.char(41)end
endlocal _0x7E2C = Instance.new(string.char(70,114,97,109,101))
_0x7E2C.Size = UDim2.new(1, 0, 0, 28)
_0x7E2C.BackgroundTransparency = 1
_0x7E2C.LayoutOrder = 3
_0x7E2C.ZIndex = 7
_0x7E2C.Parent = _0xAC95
local function _0xEA35(parent, xPos, width, txt, step)
local _0x4973 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x4973.Size = width
_0x4973.Position = xPos
_0x4973.Text = txt
_0x4973.TextColor3 = _0x90E7.Text
_0x4973.Font = Enum.Font.GothamBold
_0x4973.TextSize = 9
_0x4973.ZIndex = 8
_0x4973.Parent = parent
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4973).CornerRadius = UDim.new(0, 6)
_0x961E(_0x4973, _0x90E7.PanelLt)
_0x4973.MouseButton1Click:Connect(function() _0x5302(_0x373A + step) end)
return _0x4973
end
_0xEA35(_0x7E2C, UDim2.new(0, 0, 0, 0), UDim2.new(0.24, -2, 1, 0),string.char(45,53,48), -50)
_0xEA35(_0x7E2C, UDim2.new(0.25, 0, 0, 0), UDim2.new(0.24, -2, 1, 0),string.char(45,49,48), -10)
_0xEA35(_0x7E2C, UDim2.new(0.50, 2, 0, 0), UDim2.new(0.24, -2, 1, 0),string.char(43,49,48), 10)
_0xEA35(_0x7E2C, UDim2.new(0.75, 2, 0, 0), UDim2.new(0.25, -2, 1, 0),string.char(43,53,48), 50)local _0xD60E = Instance.new(string.char(70,114,97,109,101))
_0xD60E.Size = UDim2.new(1, 0, 0, 26)
_0xD60E.BackgroundTransparency = 1
_0xD60E.LayoutOrder = 4
_0xD60E.ZIndex = 7
_0xD60E.Parent = _0xAC95
local _0x69BC = { {_0x6299=string.char(49,54), _0x324B=16}, {_0x6299=string.char(54,48), _0x324B=60}, {_0x6299=string.char(49,50,48), _0x324B=120}, {_0x6299=string.char(50,53,48), _0x324B=250}, {_0x6299=string.char(53,48,48,32,77,65,88), _0x324B=500} }
local _0x3E17 = 1 / #_0x69BC
for i, _0x1CEE in ipairs(_0x69BC) do
local _0x5C7D = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x5C7D.Size = UDim2.new(_0x3E17, -3, 1, 0)
_0x5C7D.Position = UDim2.new((i - 1) * _0x3E17, 2, 0, 0)
_0x5C7D.Text = _0x1CEE.t
_0x5C7D.TextColor3 = _0x1CEE.v == 500 and _0x90E7.Neon or _0x90E7.Muted
_0x5C7D.Font = Enum.Font.GothamBold
_0x5C7D.TextSize = 8
_0x5C7D.ZIndex = 8
_0x5C7D.Parent = _0xD60E
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x5C7D).CornerRadius = UDim.new(0, 5)
_0x961E(_0x5C7D, _0x1CEE.v == 500 and _0x90E7.Accent2 or _0x90E7.Panel)
_0x5C7D.MouseButton1Click:Connect(function()
_0x5302(_0x1CEE.v)
_0xA387(string.char(83,112,101,101,100),string.char(87,97,108,107,83,112,101,101,100,32,115,101,116,32,116,111,32).. tostring(_0x1CEE.v))
end)
endlocal _0xC546 = Instance.new(string.char(70,114,97,109,101))
_0xC546.Size = UDim2.new(1, 0, 0, 30)
_0xC546.BackgroundColor3 = _0x90E7.Panel
_0xC546.BorderSizePixel = 0
_0xC546.LayoutOrder = 5
_0xC546.ZIndex = 7
_0xC546.Parent = _0xAC95
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xC546).CornerRadius = UDim.new(0, 6)
local _0x5DAF = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x5DAF.Size = UDim2.new(0.55, 0, 1, 0)
_0x5DAF.Position = UDim2.new(0, 10, 0, 0)
_0x5DAF.BackgroundTransparency = 1
_0x5DAF.Text =string.char(67,85,83,84,79,77,32,83,80,69,69,68,32,40,49,54,45,53,48,48,41,58)_0x5DAF.TextColor3 = _0x90E7.Muted
_0x5DAF.Font = Enum.Font.GothamMedium
_0x5DAF.TextSize = 9
_0x5DAF.TextXAlignment = Enum.TextXAlignment.Left
_0x5DAF.ZIndex = 8
_0x5DAF.Parent = _0xC546
local _0x4C7C = Instance.new(string.char(84,101,120,116,66,111,120))
_0x4C7C.Size = UDim2.new(0.4, -10, 1, -6)
_0x4C7C.Position = UDim2.new(0.6, 0, 0, 3)
_0x4C7C.BackgroundColor3 = _0x90E7.PanelLt
_0x4C7C.Text = tostring(_0x373A)
_0x4C7C.TextColor3 = _0x90E7.Neon
_0x4C7C.Font = Enum.Font.GothamBold
_0x4C7C.TextSize = 11
_0x4C7C.ClearTextOnFocus = false
_0x4C7C.ZIndex = 8
_0x4C7C.Parent = _0xC546
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4C7C).CornerRadius = UDim.new(0, 5)
_0x4C7C.FocusLost:Connect(function()
local _0x4D41 = tonumber(_0x4C7C.Text)
if _0x4D41 then
_0x5302(_0x4D41)
_0x4C7C.Text = tostring(_0x373A)
else
_0x4C7C.Text = tostring(_0x373A)
end
end)
_0x8DC1(_0xAC95, 6,string.char(74,85,77,80,32,38,32,80,72,89,83,73,67,83), _0x90E7.Muted)
local _0xAF41
_0xAF41 = _0xB1D3(_0xAC95, 7,string.char(74,85,77,80,32,80,79,87,69,82,32,32,194,183,32,32,79,70,70,32,32,40,55,53,41), function()
local _0x9094, _0xA778 = _0x6171()
if not _0xA778 then _0xA387(string.char(77,111,118,101,109,101,110,116),string.char(67,104,97,114,97,99,116,101,114,32,110,111,116,32,114,101,97,100,121,46)); return end
_0x02BF.jump = not _0x02BF.jump
_0xA778.UseJumpPower = true
_0xA778.JumpPower = _0x02BF.jump and _0x0AD9 or _0x7868
_0xAF41.Text =string.char(74,85,77,80,32,80,79,87,69,82,32,32,194,183,32,32).. (_0x02BF.jump andstring.char(79,78)orstring.char(79,70,70)) ..string.char(32,32,40).. tostring(_0x0AD9) ..string.char(41)_0x3BAC[_0xAF41] = _0x02BF.jump and _0xF580 or _0x90E7.Panel
_0xAF41.BackgroundColor3 = _0x3BAC[_0xAF41]
end)
_0xB1D3(_0xAC95, 8,string.char(74,85,77,80,32,43,50,53,32,32,40,77,65,88,32,51,53,48,41), function()
_0x0AD9 = math.min(_0xAD02, _0x0AD9 + _0x0295)
local _0x9094, _0xA778 = _0x6171()
if _0xA778 then _0xA778.UseJumpPower = true; if _0x02BF.jump then _0xA778.JumpPower = _0x0AD9 end end
_0xAF41.Text =string.char(74,85,77,80,32,80,79,87,69,82,32,32,194,183,32,32).. (_0x02BF.jump andstring.char(79,78)orstring.char(79,70,70)) ..string.char(32,32,40).. tostring(_0x0AD9) ..string.char(41)end, _0x90E7.PanelLt)
local _0x9543
_0x9543 = _0xB1D3(_0xAC95, 9,string.char(73,78,70,73,78,73,84,69,32,74,85,77,80,32,32,194,183,32,32,79,70,70), function()
_0x02BF.infiniteJump = not _0x02BF.infiniteJump
if _0x02BF.infiniteJump then
_0x02BF.jumpConn = _0xB2E3.JumpRequest:Connect(function()
if not _0x02BF.infiniteJump then return end
local _0x9094, _0xA778 = _0x6171()
if _0xA778 and _0xA778.Health > 0 then _0xA778:ChangeState(Enum.HumanoidStateType.Jumping) end
end)
elseif _0x02BF.jumpConn then
_0x02BF.jumpConn:Disconnect(); _0x02BF.jumpConn = nil
end
_0x9543.Text =string.char(73,78,70,73,78,73,84,69,32,74,85,77,80,32,32,194,183,32,32).. (_0x02BF.infiniteJump andstring.char(79,78)orstring.char(79,70,70))
_0x3BAC[_0x9543] = _0x02BF.infiniteJump and _0xF580 or _0x90E7.Panel
_0x9543.BackgroundColor3 = _0x3BAC[_0x9543]
end)local _0x92E7
_0x92E7 = _0xB1D3(_0xAC95, 10,string.char(78,79,67,76,73,80,32,40,87,65,76,75,32,84,72,82,79,85,71,72,32,87,65,76,76,83,41,32,32,194,183,32,32,79,70,70), function()
_0x02BF.noclip = not _0x02BF.noclip
if _0x02BF.noclip then
if _0x02BF.noclipConn then _0x02BF.noclipConn:Disconnect() end
_0x02BF.noclipConn = _0xC77A.Stepped:Connect(function()
if not _0x02BF.noclip then return end
local _0x7B2F = _0xA6AA.Character
if _0x7B2F then
for _0x9094, _0x1CEE in ipairs(_0x04D0(_0x7B2F)) do
if _0x1CEE.Parent and _0x1CEE.CanCollide then
_0x1CEE.CanCollide = false
end
end
end
end)
elseif _0x02BF.noclipConn then
_0x02BF.noclipConn:Disconnect()
_0x02BF.noclipConn = nil
end
_0x92E7.Text =string.char(78,79,67,76,73,80,32,40,87,65,76,75,32,84,72,82,79,85,71,72,32,87,65,76,76,83,41,32,32,194,183,32,32).. (_0x02BF.noclip andstring.char(79,78)orstring.char(79,70,70))
_0x3BAC[_0x92E7] = _0x02BF.noclip and _0xF580 or _0x90E7.Panel
_0x92E7.BackgroundColor3 = _0x3BAC[_0x92E7]
end)
_0x8DC1(_0xAC95, 11,string.char(85,78,73,86,69,82,83,65,76,32,70,76,73,71,72,84,32,40,80,67,32,38,32,65,78,68,82,79,73,68,41), _0x90E7.Accent)local _0x4199, _0x2757 = false, false
local _0x1E04 = nil
local function _0xD2BE()
if _0x1E04 and _0x1E04.Parent then return end
_0x1E04 = Instance.new(string.char(70,114,97,109,101))
_0x1E04.Name =string.char(67,111,99,111,77,111,98,105,108,101,70,108,121,72,85,68)_0x1E04.Size = UDim2.new(0, 72, 0, 144)
_0x1E04.Position = UDim2.new(1, -86, 0.5, -72)
_0x1E04.BackgroundColor3 = _0x90E7.BG2
_0x1E04.BackgroundTransparency = 0.2
_0x1E04.BorderSizePixel = 0
_0x1E04.ZIndex = 200
_0x1E04.Parent = _0xF28E
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x1E04).CornerRadius = UDim.new(0, 12)
local _0x2A64 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x2A64.Color = _0x90E7.Accent
_0x2A64.Thickness = 1.4
_0x2A64.Transparency = 0.2
_0x2A64.Parent = _0x1E04
local _0x5D58 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x5D58.Size = UDim2.new(1, 0, 0, 22)
_0x5D58.BackgroundTransparency = 1
_0x5D58.Text =string.char(65,76,84,73,84,85,68,69)_0x5D58.TextColor3 = _0x90E7.Neon
_0x5D58.Font = Enum.Font.GothamBold
_0x5D58.TextSize = 8
_0x5D58.ZIndex = 201
_0x5D58.Parent = _0x1E04
local _0xB0B4 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xB0B4.Size = UDim2.new(1, -12, 0, 50)
_0xB0B4.Position = UDim2.new(0, 6, 0, 24)
_0xB0B4.BackgroundColor3 = _0x90E7.Panel
_0xB0B4.Text =string.char(226,150,178,10,85,80)_0xB0B4.TextColor3 = Color3.new(1, 1, 1)
_0xB0B4.Font = Enum.Font.GothamBold
_0xB0B4.TextSize = 11
_0xB0B4.ZIndex = 201
_0xB0B4.AutoButtonColor = false
_0xB0B4.Parent = _0x1E04
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xB0B4).CornerRadius = UDim.new(0, 8)
local _0xA0F4 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xA0F4.Size = UDim2.new(1, -12, 0, 50)
_0xA0F4.Position = UDim2.new(0, 6, 0, 82)
_0xA0F4.BackgroundColor3 = _0x90E7.Panel
_0xA0F4.Text =string.char(226,150,188,10,68,79,87,78)_0xA0F4.TextColor3 = Color3.new(1, 1, 1)
_0xA0F4.Font = Enum.Font.GothamBold
_0xA0F4.TextSize = 11
_0xA0F4.ZIndex = 201
_0xA0F4.AutoButtonColor = false
_0xA0F4.Parent = _0x1E04
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xA0F4).CornerRadius = UDim.new(0, 8)
local function _0x1950(_0x43E0, setFlag)
_0x43E0.InputBegan:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
setFlag(true)
_0x43E0.BackgroundColor3 = _0x90E7.Accent2
end
end)
_0x43E0.InputEnded:Connect(function(inp)
if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
setFlag(false)
_0x43E0.BackgroundColor3 = _0x90E7.Panel
end
end)
end
_0x1950(_0xB0B4, function(_0x87D3) _0x4199 = _0x87D3 end)
_0x1950(_0xA0F4, function(_0x87D3) _0x2757 = _0x87D3 end)
end
local function _0xCB98()
if _0x1E04 then
_0x1E04:Destroy()
_0x1E04 = nil
end
_0x4199 = false
_0x2757 = false
end
local _0x53CA
_0x53CA = _0xB1D3(_0xAC95, 12,string.char(70,76,89,32,32,194,183,32,32,79,70,70,32,32,40,87,65,83,68,32,47,32,74,79,89,83,84,73,67,75,32,43,32,65,76,84,41), function()
local _0x9094, _0xA778, _0xE5AE = _0x6171()
if not _0xA778 or not _0xE5AE then _0xA387(string.char(77,111,118,101,109,101,110,116),string.char(67,104,97,114,97,99,116,101,114,32,110,111,116,32,114,101,97,100,121,46)); return end
_0x02BF.fly = not _0x02BF.fly
if _0x02BF.fly then
local _0xD11D = Instance.new(string.char(66,111,100,121,86,101,108,111,99,105,116,121))
_0xD11D.Name =string.char(67,111,99,111,70,108,121,86,101,108,111,99,105,116,121)_0xD11D.MaxForce = Vector3.new(1e5, 1e5, 1e5)
_0xD11D.P = 2e4
_0xD11D.Velocity = Vector3.zero
_0xD11D.Parent = _0xE5AE
local _0xBA01 = Instance.new(string.char(66,111,100,121,71,121,114,111))
_0xBA01.Name =string.char(67,111,99,111,70,108,121,71,121,114,111)_0xBA01.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
_0xBA01.P = 1e4
_0xBA01.D = 650
_0xBA01.CFrame = _0xE5AE.CFrame
_0xBA01.Parent = _0xE5AE
_0xA778.PlatformStand = true
_0x53CA.Text =string.char(70,76,89,32,32,194,183,32,32,79,78,32,32,40,87,65,83,68,32,47,32,74,79,89,83,84,73,67,75,32,43,32,65,76,84,41)_0x3BAC[_0x53CA] = _0xF580
_0x53CA.BackgroundColor3 = _0xF580
_0xD2BE()
_0x02BF.flyConn = _0xC77A.RenderStepped:Connect(function(_0x004C)
if not _0x02BF.fly or not _0xE5AE.Parent then return end
local _0x4E33 = workspace.CurrentCamera
if not _0x4E33 then return end
local _0x452C = Vector3.zeroif _0xB2E3:IsKeyDown(Enum.KeyCode.W) then _0x452C = _0x452C + (_0x4E33.CFrame.LookVector) end
if _0xB2E3:IsKeyDown(Enum.KeyCode.S) then _0x452C = _0x452C - (_0x4E33.CFrame.LookVector) end
if _0xB2E3:IsKeyDown(Enum.KeyCode.D) then _0x452C = _0x452C + (_0x4E33.CFrame.RightVector) end
if _0xB2E3:IsKeyDown(Enum.KeyCode.A) then _0x452C = _0x452C - (_0x4E33.CFrame.RightVector) end
if _0xB2E3:IsKeyDown(Enum.KeyCode.Space) then _0x452C = _0x452C + (Vector3.yAxis) end
if _0xB2E3:IsKeyDown(Enum.KeyCode.LeftControl) or _0xB2E3:IsKeyDown(Enum.KeyCode.C) then _0x452C = _0x452C - (Vector3.yAxis) endif _0xA778 and _0xA778.MoveDirection.Magnitude > 0.05 then
local _0x52EB = _0x4E33.CFrame.LookVector
local _0x9A18 = _0x4E33.CFrame.RightVector
local _0xDE5A = Vector3.new(_0x52EB.X, 0, _0x52EB.Z).Unit
local _0x2115 = Vector3.new(_0x9A18.X, 0, _0x9A18.Z).Unit
local _0xF2AF = _0xA778.MoveDirection:Dot(_0xDE5A)
local _0x68A5 = _0xA778.MoveDirection:Dot(_0x2115)_0x452C = _0x452C + ((_0x52EB * _0xF2AF) + (_0x9A18 * _0x68A5))
endif _0x4199 or (_0xA778 and _0xA778.Jump) then _0x452C = _0x452C + (Vector3.yAxis) end
if _0x2757 then _0x452C = _0x452C - (Vector3.yAxis) end
local _0xC015 = _0x452C.Magnitude > 0.05
local _0xDC52 = math.max(24, _0x373A)
_0xD11D.Velocity = _0xC015 and (_0x452C.Unit * _0xDC52) or Vector3.zero
local _0x43DF = CFrame.lookAt(_0xE5AE.Position, _0xE5AE.Position + _0x4E33.CFrame.LookVector, Vector3.yAxis)
_0xBA01.CFrame = _0xBA01.CFrame:Lerp(_0x43DF, math.clamp((_0x004C or 1/60) * 8, 0, 1))
end)
else
if _0x02BF.flyConn then _0x02BF.flyConn:Disconnect(); _0x02BF.flyConn = nil end
_0xCB98()
if _0xE5AE then
local _0xD11D = _0xE5AE:FindFirstChild(string.char(67,111,99,111,70,108,121,86,101,108,111,99,105,116,121)); if _0xD11D then _0xD11D:Destroy() end
local _0xBA01 = _0xE5AE:FindFirstChild(string.char(67,111,99,111,70,108,121,71,121,114,111)); if _0xBA01 then _0xBA01:Destroy() end
end
if _0xA778 then _0xA778.PlatformStand = false end
_0x53CA.Text =string.char(70,76,89,32,32,194,183,32,32,79,70,70,32,32,40,87,65,83,68,32,47,32,74,79,89,83,84,73,67,75,32,43,32,65,76,84,41)_0x3BAC[_0x53CA] = _0x90E7.Panel
_0x53CA.BackgroundColor3 = _0x90E7.Panel
end
end)
_0xB1D3(_0xAC95, 13,string.char(82,69,83,69,84,32,65,76,76,32,77,79,86,69,77,69,78,84), function()
_0x02BF.speed, _0x02BF.jump, _0x02BF.noclip = false, false, false
if _0x02BF.speedLoopConn then _0x02BF.speedLoopConn:Disconnect(); _0x02BF.speedLoopConn = nil end
if _0x02BF.noclipConn then _0x02BF.noclipConn:Disconnect(); _0x02BF.noclipConn = nil end
local _0x9094, _0xA778, _0xE5AE = _0x6171()
if _0xA778 then _0xA778.WalkSpeed = _0xD6EC; _0xA778.UseJumpPower = true; _0xA778.JumpPower = _0x7868; _0xA778.PlatformStand = false end
if _0x02BF.fly then
_0x02BF.fly = false
if _0x02BF.flyConn then _0x02BF.flyConn:Disconnect(); _0x02BF.flyConn = nil end
_0xCB98()
if _0xE5AE then
local _0xD11D = _0xE5AE:FindFirstChild(string.char(67,111,99,111,70,108,121,86,101,108,111,99,105,116,121)); if _0xD11D then _0xD11D:Destroy() end
local _0xBA01 = _0xE5AE:FindFirstChild(string.char(67,111,99,111,70,108,121,71,121,114,111)); if _0xBA01 then _0xBA01:Destroy() end
end
end
_0x3A47.Text =string.char(87,65,76,75,32,83,80,69,69,68,32,32,194,183,32,32,79,70,70,32,32,40).. tostring(_0x373A) ..string.char(41); _0x3BAC[_0x3A47] = _0x90E7.Panel; _0x3A47.BackgroundColor3 = _0x90E7.Panel
_0xAF41.Text =string.char(74,85,77,80,32,80,79,87,69,82,32,32,194,183,32,32,79,70,70,32,32,40).. tostring(_0x0AD9) ..string.char(41); _0x3BAC[_0xAF41] = _0x90E7.Panel; _0xAF41.BackgroundColor3 = _0x90E7.Panel
if _0x92E7 then _0x92E7.Text =string.char(78,79,67,76,73,80,32,40,87,65,76,75,32,84,72,82,79,85,71,72,32,87,65,76,76,83,41,32,32,194,183,32,32,79,70,70); _0x3BAC[_0x92E7] = _0x90E7.Panel; _0x92E7.BackgroundColor3 = _0x90E7.Panel end
_0x53CA.Text =string.char(70,76,89,32,32,194,183,32,32,79,70,70,32,32,40,87,65,83,68,32,47,32,74,79,89,83,84,73,67,75,32,43,32,65,76,84,41); _0x3BAC[_0x53CA] = _0x90E7.Panel; _0x53CA.BackgroundColor3 = _0x90E7.Panel
_0xA387(string.char(77,111,118,101,109,101,110,116),string.char(65,108,108,32,109,111,118,101,109,101,110,116,32,118,97,108,117,101,115,32,114,101,115,101,116,46))
end, _0x90E7.Danger)
_0xA6AA.CharacterAdded:Connect(function(_0x5BFE)
task.wait(0.5)
local _0xA778 = _0x5BFE:FindFirstChildOfClass(string.char(72,117,109,97,110,111,105,100))
if _0xA778 then
if _0x02BF.speed then _0xA778.WalkSpeed = _0x373A end
if _0x02BF.jump then _0xA778.UseJumpPower = true; _0xA778.JumpPower = _0x0AD9 end
end
_0x02BF.fly = false
if _0x02BF.flyConn then _0x02BF.flyConn:Disconnect(); _0x02BF.flyConn = nil end
_0xCB98()
_0x53CA.Text =string.char(70,76,89,32,32,194,183,32,32,79,70,70,32,32,40,87,65,83,68,32,47,32,74,79,89,83,84,73,67,75,32,43,32,65,76,84,41); _0x3BAC[_0x53CA] = _0x90E7.Panel; _0x53CA.BackgroundColor3 = _0x90E7.Panel
end)
end_0x4E18.MouseButton1Click:Connect(function()
_0x0909()
_0x7EF3()
_0x3C23:Cleanup(false)
_0x839F = nil
_0x518F = nil
_0x00E5.Text =string.char(115,116,111,112,112,101,100)_0x207A()
if not (_0x5DAB and (_0x5DAB.AlwaysOnCore or (_0x5DAB.Void and _0x5DAB.Void.enabled) or (_0x5DAB.InfFallVoid and _0x5DAB.InfFallVoid.enabled) or (_0x5DAB.Kill and _0x5DAB.Kill.enabled))) then
pcall(function() workspace.FallenPartsDestroyHeight = _0x8668 end)
end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65),string.char(85,110,119,101,108,100,101,100,32,38,32,115,116,97,116,101,32,99,108,101,97,114,101,100))
_0xCAE4()
end)_0x3DFE = function(isOpen)
_0xF28E.Enabled = true
_0x5140.open = isOpen
_0x5140.minimized = not isOpen
if isOpen then
_0xC02C.Visible = false
_0x93AB.Scale = 0.92
_0x5C62.Visible = true
_0xD822.Visible = true
_0xFD0E:Create(_0x93AB, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
Scale = 1.0
}):Play()
else
local _0x521B = _0xFD0E:Create(_0x93AB, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
Scale = 0.92
})
_0x521B:Play()
task.delay(0.14, function()
if not _0x5140.open then
_0x5C62.Visible = false
_0xD822.Visible = false
_0xC02C.Visible = true
end
end)
end
end
_0xDF13.MouseButton1Click:Connect(function()
_0x0909()
_0x3DFE(false)
end)
local function _0xA7AC()
_0x7EF3()
_0x3C23:Cleanup(false)
_0xFA8C()
pcall(function() workspace.FallenPartsDestroyHeight = _0x8668 end)
_0xF28E:Destroy()
print(string.char(91,75,72,65,77,65,78,32,68,72,79,75,76,65,93,32,84,101,114,109,105,110,97,116,101,100,46))
end
local function _0xBB22()
local _0xA2A1 = Instance.new(string.char(70,114,97,109,101))
_0xA2A1.Size = UDim2.new(1, 0, 1, 0)
_0xA2A1.BackgroundColor3 = Color3.new(0, 0, 0)
_0xA2A1.BackgroundTransparency = 0.45
_0xA2A1.ZIndex = 100
_0xA2A1.Parent = _0xF28E
local _0x3706 = Instance.new(string.char(70,114,97,109,101))
_0x3706.Size = UDim2.new(0, 250, 0, 154)
_0x3706.Position = UDim2.new(0.5, -125, 0.5, -77)
_0x3706.BackgroundColor3 = _0x90E7.BG2
_0x3706.BorderSizePixel = 0
_0x3706.ZIndex = 101
_0x3706.Parent = _0xF28E
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x3706).CornerRadius = UDim.new(0, 12)
local _0x6517 = Instance.new(string.char(85,73,83,116,114,111,107,101))
_0x6517.Color = _0x90E7.Border
_0x6517.Thickness = 1.2
_0x6517.Parent = _0x3706
local _0x004C = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x004C.Size = UDim2.new(1, -24, 0, 22)
_0x004C.Position = UDim2.new(0, 12, 0, 12)
_0x004C.BackgroundTransparency = 1
_0x004C.Text =string.char(67,108,111,115,101,32,75,72,65,77,65,78,32,68,72,79,75,76,65,63)_0x004C.TextColor3 = _0x90E7.Text
_0x004C.Font = Enum.Font.GothamBold
_0x004C.TextSize = 13
_0x004C.ZIndex = 102
_0x004C.Parent = _0x3706
local _0x3CD2 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x3CD2.Size = UDim2.new(1, -24, 0, 28)
_0x3CD2.Position = UDim2.new(0, 12, 0, 34)
_0x3CD2.BackgroundTransparency = 1
_0x3CD2.Text =string.char(72,105,100,101,32,116,111,32,116,104,101,32,75,68,32,68,104,111,107,108,97,32,105,99,111,110,32,111,114,32,117,110,108,111,97,100,32,99,111,109,112,108,101,116,101,108,121,63)_0x3CD2.TextColor3 = _0x90E7.Muted
_0x3CD2.TextWrapped = true
_0x3CD2.Font = Enum.Font.Gotham
_0x3CD2.TextSize = 10
_0x3CD2.ZIndex = 102
_0x3CD2.Parent = _0x3706
local _0xF64B = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0xF64B.Size = UDim2.new(1, -24, 0, 30)
_0xF64B.Position = UDim2.new(0, 12, 0, 70)
_0xF64B.Text =string.char(72,73,68,69,32,80,65,78,69,76,32,40,75,69,69,80,32,73,67,79,78,83,41)_0xF64B.TextColor3 = Color3.new(1, 1, 1)
_0xF64B.Font = Enum.Font.GothamBold
_0xF64B.TextSize = 10
_0xF64B.ZIndex = 102
_0xF64B.Parent = _0x3706
Instance.new(string.char(85,73,67,111,114,110,101,114), _0xF64B).CornerRadius = UDim.new(0, 6)
_0x961E(_0xF64B, _0x90E7.Accent2)
local _0x02C9 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x02C9.Size = UDim2.new(0.5, -15, 0, 30)
_0x02C9.Position = UDim2.new(0, 12, 1, -40)
_0x02C9.Text =string.char(85,78,76,79,65,68)_0x02C9.TextColor3 = Color3.new(1, 1, 1)
_0x02C9.Font = Enum.Font.GothamBold
_0x02C9.TextSize = 10
_0x02C9.ZIndex = 102
_0x02C9.Parent = _0x3706
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x02C9).CornerRadius = UDim.new(0, 6)
_0x961E(_0x02C9, _0x90E7.Danger)
local _0x4B59 = Instance.new(string.char(84,101,120,116,66,117,116,116,111,110))
_0x4B59.Size = UDim2.new(0.5, -15, 0, 30)
_0x4B59.Position = UDim2.new(0.5, 3, 1, -40)
_0x4B59.Text =string.char(67,65,78,67,69,76)_0x4B59.TextColor3 = _0x90E7.Text
_0x4B59.Font = Enum.Font.GothamBold
_0x4B59.TextSize = 10
_0x4B59.ZIndex = 102
_0x4B59.Parent = _0x3706
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x4B59).CornerRadius = UDim.new(0, 6)
_0x961E(_0x4B59, _0x90E7.PanelLt)
local function _0x2F5E()
_0xA2A1:Destroy()
_0x3706:Destroy()
end
_0xF64B.MouseButton1Click:Connect(function()
_0xED6E()
_0x3DFE(false)
_0x2F5E()
end)
_0x02C9.MouseButton1Click:Connect(function() _0xED6E(); _0xA7AC() end)
_0x4B59.MouseButton1Click:Connect(function() _0x0909(); _0x2F5E() end)
end
_0xE18F.MouseButton1Click:Connect(function() _0x0909(); _0xBB22() end)
_0xB2E3.InputBegan:Connect(function(inp, gp)
if gp or _0xB2E3:GetFocusedTextBox() then return end
if inp.KeyCode == Enum.KeyCode.RightShift then
_0x3DFE(not _0x5140.open)
if _0x5140.open then _0xEA8A() else _0xED6E() end
elseif inp.KeyCode == Enum.KeyCode.R then
_0xAE44:Start(_0xAE44.duration)
elseif inp.KeyCode == Enum.KeyCode.V and (_0x5DAB.VC.enabled or _0x5DAB.VC.running) then
if _0x5DAB.VC.toggleMicFn then _0x5DAB.VC.toggleMicFn() end
end
end)
_0x74C2(string.char(87,101,108,100))
end
local _0xA8DB, _0x6357 = xpcall(_0xA046, function(_0xA263)
local _0x9528 =""pcall(function()
if debug and typeof(debug.traceback) ==string.char(102,117,110,99,116,105,111,110)then
_0x9528 =string.char(10).. tostring(debug.traceback())
end
end)
return tostring(_0xA263) .. _0x9528
end)
if not _0xA8DB then
warn(string.char(91,75,72,65,77,65,78,32,68,72,79,75,76,65,93,32,71,85,73,32,115,116,97,114,116,117,112,32,102,97,105,108,101,100,58,10).. tostring(_0x6357))pcall(function()
local _0x5E61 = _0xA6AA:FindFirstChildOfClass(string.char(80,108,97,121,101,114,71,117,105)) or _0xA6AA:WaitForChild(string.char(80,108,97,121,101,114,71,117,105), 8)
if not _0x5E61 then return end
local _0x9AED = _0x5E61:FindFirstChild(string.char(75,104,97,109,97,110,68,104,111,107,108,97,83,116,97,114,116,117,112,69,114,114,111,114))
if _0x9AED then _0x9AED:Destroy() end
local _0xA592 = Instance.new(string.char(83,99,114,101,101,110,71,117,105))
_0xA592.Name =string.char(75,104,97,109,97,110,68,104,111,107,108,97,83,116,97,114,116,117,112,69,114,114,111,114)_0xA592.ResetOnSpawn = false
_0xA592.DisplayOrder = 100000
_0xA592.Parent = _0x5E61
local _0x088B = Instance.new(string.char(70,114,97,109,101))
_0x088B.Size = UDim2.new(0.9, 0, 0, 150)
_0x088B.Position = UDim2.new(0.05, 0, 0.08, 0)
_0x088B.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
_0x088B.BorderSizePixel = 0
_0x088B.Parent = _0xA592
Instance.new(string.char(85,73,67,111,114,110,101,114), _0x088B).CornerRadius = UDim.new(0, 10)
local _0x1412 = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0x1412.Size = UDim2.new(1, -20, 0, 32)
_0x1412.Position = UDim2.new(0, 10, 0, 8)
_0x1412.BackgroundTransparency = 1
_0x1412.Font = Enum.Font.GothamBold
_0x1412.TextSize = 16
_0x1412.TextColor3 = Color3.fromRGB(255, 115, 115)
_0x1412.TextXAlignment = Enum.TextXAlignment.Left
_0x1412.Text =string.char(75,72,65,77,65,78,32,68,72,79,75,76,65,32,102,97,105,108,101,100,32,116,111,32,115,116,97,114,116)_0x1412.Parent = _0x088B
local _0xD6FE = Instance.new(string.char(84,101,120,116,76,97,98,101,108))
_0xD6FE.Size = UDim2.new(1, -20, 1, -48)
_0xD6FE.Position = UDim2.new(0, 10, 0, 40)
_0xD6FE.BackgroundTransparency = 1
_0xD6FE.Font = Enum.Font.Code
_0xD6FE.TextSize = 11
_0xD6FE.TextColor3 = Color3.fromRGB(235, 235, 240)
_0xD6FE.TextWrapped = true
_0xD6FE.TextXAlignment = Enum.TextXAlignment.Left
_0xD6FE.TextYAlignment = Enum.TextYAlignment.Top
_0xD6FE.Text = tostring(_0x6357):sub(1, 1800)
_0xD6FE.Parent = _0x088B
end)
return
end
_0xA387(string.char(75,72,65,77,65,78,32,68,72,79,75,76,65,32,86,51,57),string.char(90,101,114,111,45,70,114,101,101,122,101,32,84,114,111,108,108,32,43,32,84,114,117,101,32,85,110,108,105,109,105,116,101,100,32,70,108,105,110,103,32,43,32,50,52,47,55,32,67,111,114,101,32,83,104,105,101,108,100,115,32,43,32,86,67,32,86,52,32,82,101,97,100,121,33))
print(string.char(91,75,72,65,77,65,78,32,68,72,79,75,76,65,32,86,51,57,93,32,82,101,97,100,121,46))
