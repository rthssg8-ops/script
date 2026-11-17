local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create a clean floating UI inside Delta
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaAnimFinder"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 140)
frame.Position = UDim2.new(0.5, -160, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "Delta Emote ID Finder"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

local box = Instance.new("TextBox")
box.Size = UDim2.new(0.9, 0, 0, 50)
box.Position = UDim2.new(0.05, 0, 0, 45)
box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
box.TextColor3 = Color3.fromRGB(0, 255, 128)
box.TextSize = 14
box.Font = Enum.Font.Code
box.Text = "Play an emote to grab its ID..."
box.ClearTextOnFocus = false
box.Parent = frame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 6)
boxCorner.Parent = box

-- Function to listen to playing tracks
local function monitor()
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	local animator = hum:FindFirstChildOfClass("Animator")
	if not animator then return end

	animator.AnimationPlayed:Connect(function(track)
		if track and track.Animation then
			box.Text = track.Animation.AnimationId
			print("[Delta ID Found]:", track.Animation.AnimationId)
		end
	end)
end

player.CharacterAdded:Connect(function()
	task.wait(1)
	monitor()
end)

monitor()
