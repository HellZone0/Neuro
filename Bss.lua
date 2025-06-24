-- Antarctica Utility v3 by ChatGPT

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- Defaults
local defaultSpeed, defaultJump = 16, 50

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Zone Antartika"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 220)
frame.Position = UDim2.new(0.02, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Text = "❄ Antarctica Zone V0.1"
title.Size = UDim2.new(1, -30, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Text = "-"
minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
minimizeBtn.Position = UDim2.new(1, -30, 0, 2)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16

-- Helper UI Creator
local function createSlider(labelText, min, max, default, yPos, onChange)
	local label = Instance.new("TextLabel", frame)
	label.Text = labelText
	label.Position = UDim2.new(0, 10, 0, yPos)
	label.Size = UDim2.new(0, 120, 0, 20)
	label.TextColor3 = Color3.new(1,1,1)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left

	local slider = Instance.new("TextButton", frame)
	slider.Position = UDim2.new(0, 10, 0, yPos + 25)
	slider.Size = UDim2.new(0, 280, 0, 20)
	slider.BackgroundColor3 = Color3.fromRGB(60,60,60)
	slider.Text = ""
	slider.AutoButtonColor = false

	local fill = Instance.new("Frame", slider)
	fill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
	fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
	fill.BorderSizePixel = 0

	local valLabel = Instance.new("TextLabel", slider)
	valLabel.Size = UDim2.new(0, 50, 1, 0)
	valLabel.Position = UDim2.new(1, -55, 0, 0)
	valLabel.BackgroundTransparency = 1
	valLabel.TextColor3 = Color3.new(1,1,1)
	valLabel.Font = Enum.Font.Gotham
	valLabel.TextSize = 14
	valLabel.Text = tostring(default)

	local dragging = false
	local function update(x)
		local pos = math.clamp((x - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
		fill.Size = UDim2.new(pos, 0, 1, 0)
		local val = math.floor((min + (max - min) * pos) + 0.5)
		valLabel.Text = tostring(val)
		onChange(val)
	end

	slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			update(input.Position.X)
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input.Position.X)
		end
	end)
	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	return {
		set = function(val)
			local pos = (val - min) / (max - min)
			fill.Size = UDim2.new(pos, 0, 1, 0)
			valLabel.Text = tostring(val)
			onChange(val)
		end
	}
end

-- Sliders
local speedSlider = createSlider("WalkSpeed", 5, 200, humanoid.WalkSpeed, 40, function(val)
	humanoid.WalkSpeed = val
end)

local jumpSlider = createSlider("JumpPower", 10, 200, humanoid.JumpPower, 90, function(val)
	humanoid.JumpPower = val
end)

-- Reset Button
local resetBtn = Instance.new("TextButton", frame)
resetBtn.Text = "Reset to Default"
resetBtn.Size = UDim2.new(0, 280, 0, 30)
resetBtn.Position = UDim2.new(0, 10, 0, 150)
resetBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
resetBtn.TextColor3 = Color3.new(1,1,1)
resetBtn.Font = Enum.Font.Gotham
resetBtn.TextSize = 14

resetBtn.MouseButton1Click:Connect(function()
	speedSlider.set(defaultSpeed)
	jumpSlider.set(defaultJump)
	humanoid.WalkSpeed = defaultSpeed
	humanoid.JumpPower = defaultJump
end)

-- Minimize Toggle
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	for _, obj in pairs(frame:GetChildren()) do
		if obj ~= minimizeBtn and obj ~= title then
			obj.Visible = not minimized
		end
	end
	minimizeBtn.Text = minimized and "+" or "-"
end)

-- Right Ctrl = Show/Hide GUI
UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.RightControl then
		gui.Enabled = not gui.Enabled
	end
end)