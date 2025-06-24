-- Expedition Antarctica Speed & Jump GUI by ChatGPT (Fixed)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local UIS = game:GetService("UserInputService")

-- UI Setup
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "AntarcticaUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0, 50, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -30, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "❄ Antarctica Utility"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 25, 0, 25)
minimize.Position = UDim2.new(1, -30, 0, 2)
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimize.TextColor3 = Color3.new(1,1,1)
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.ZIndex = 2

local container = Instance.new("Frame", frame)
container.Name = "Content"
container.Position = UDim2.new(0, 10, 0, 35)
container.Size = UDim2.new(1, -20, 1, -45)
container.BackgroundTransparency = 1

-- SLIDER TEMPLATE
local function createSlider(name, min, max, default, callback, yOffset)
	local label = Instance.new("TextLabel", container)
	label.Text = name .. ": " .. default
	label.Position = UDim2.new(0, 0, 0, yOffset)
	label.Size = UDim2.new(1, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1,1,1)
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left

	local slider = Instance.new("Frame", container)
	slider.Position = UDim2.new(0, 0, 0, yOffset + 25)
	slider.Size = UDim2.new(1, 0, 0, 10)
	slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	local fill = Instance.new("Frame", slider)
	fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

	local dragging = false

	slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local pos = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(pos, 0, 1, 0)
			local value = math.floor(min + (max - min) * pos)
			label.Text = name .. ": " .. value
			callback(value)
		end
	end)
end

-- Create sliders
createSlider("Speed", 10, 200, humanoid.WalkSpeed, function(val)
	humanoid.WalkSpeed = val
end, 0)

createSlider("Jump", 20, 150, humanoid.JumpPower, function(val)
	humanoid.JumpPower = val
end, 70)

-- Minimize functionality
local minimized = false
minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	container.Visible = not minimized
	minimize.Text = minimized and "+" or "-"
end)

-- Toggle UI with Right Ctrl
UIS.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.RightControl then
		screenGui.Enabled = not screenGui.Enabled
	end
end)