-- Expedition Antarctica Stylish UI Script (Full Fixed)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local speedValue = 16
local jumpValue = 50

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "EA_StylishUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 270, 0, 250)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "⚡ Zone Expedition Trainer"
Title.TextColor3 = Color3.fromRGB(180, 230, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamSemibold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local toggleBtn = Instance.new("TextButton", MainFrame)
toggleBtn.Position = UDim2.new(1, -30, 0, 5)
toggleBtn.Size = UDim2.new(0, 20, 0, 20)
toggleBtn.Text = "-"
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 4)

local fpsLabel = Instance.new("TextLabel", MainFrame)
fpsLabel.Size = UDim2.new(0, 80, 0, 20)
fpsLabel.Position = UDim2.new(1, -110, 0, 5)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(180, 230, 255)
fpsLabel.Font = Enum.Font.GothamSemibold
fpsLabel.TextSize = 14
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
fpsLabel.Text = "FPS: 0"

local contentFrame = Instance.new("Frame", MainFrame)
contentFrame.Name = "ContentFrame"
contentFrame.Position = UDim2.new(0, 0, 0, 35)
contentFrame.Size = UDim2.new(1, 0, 1, -35)
contentFrame.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", contentFrame)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local minimized = false
local originalSize = MainFrame.Size
local minimizedSize = UDim2.new(0, 270, 0, 35)

toggleBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	contentFrame.Visible = not minimized
	toggleBtn.Text = minimized and "+" or "-"
	MainFrame.Size = minimized and minimizedSize or originalSize
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, g)
	if not g and input.KeyCode == Enum.KeyCode.RightControl then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end
end)

local function createBox(labelText, default)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, -20, 0, 30)
	container.BackgroundTransparency = 1

	local label = Instance.new("TextLabel", container)
	label.Size = UDim2.new(0, 60, 1, 0)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.Text = labelText
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1,1,1)
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left

	local box = Instance.new("TextBox", container)
	box.Size = UDim2.new(0, 160, 1, 0)
	box.Position = UDim2.new(0, 70, 0, 0)
	box.Text = default
	box.Font = Enum.Font.Gotham
	box.TextSize = 14
	box.TextColor3 = Color3.new(1,1,1)
	box.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
	return container, box
end

local speedContainer, speedBox = createBox("Speed:", tostring(speedValue))
speedBox.FocusLost:Connect(function()
	speedValue = tonumber(speedBox.Text) or speedValue
	speedBox.Text = tostring(speedValue)
	humanoid.WalkSpeed = speedValue
end)

local jumpContainer, jumpBox = createBox("Jump:", tostring(jumpValue))
jumpBox.FocusLost:Connect(function()
	jumpValue = tonumber(jumpBox.Text) or jumpValue
	jumpBox.Text = tostring(jumpValue)
	humanoid.JumpPower = jumpValue
end)

local function createButton(text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 30)
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

local function createToggleButton(textOn, textOff, callback)
	local enabled = false
	local btn = createButton(textOff, function()
		enabled = not enabled
		btn.Text = enabled and textOn or textOff
		btn.BackgroundColor3 = enabled and Color3.fromRGB(60,100,60) or Color3.fromRGB(40,40,40)
		callback(enabled)
	end)
	return btn
end

local function updateFPS()
	local RunService = game:GetService("RunService")
	local frameCount, last = 0, tick()

	RunService.RenderStepped:Connect(function()
		frameCount += 1
		if tick() - last >= 1 then
			fpsLabel.Text = "FPS: " .. tostring(frameCount)
			frameCount = 0
			last = tick()
		end
	end)
end
updateFPS()

-- UI insert order
speedContainer.Parent = contentFrame
jumpContainer.Parent = contentFrame

createButton("Reset Speed & Jump", function()
	speedValue = 16
	jumpValue = 50
	humanoid.WalkSpeed = speedValue
	humanoid.JumpPower = jumpValue
	speedBox.Text = "16"
	jumpBox.Text = "50"
end).Parent = contentFrame

local antiStorm = false
createToggleButton("☁ Anti Badai: ON", "☁ Anti Badai: OFF", function(state)
	antiStorm = state
end).Parent = contentFrame

task.spawn(function()
	while true do task.wait(1)
		if antiStorm then
			for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
				if v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BlurEffect") then
					v.Enabled = false
				end
			end
			for _, v in pairs(workspace.CurrentCamera:GetChildren()) do
				if v:IsA("BlurEffect") then
					v.Enabled = false
				end
			end
		end
	end
end)

local godModeConnection
createToggleButton("🛡️ God Mode: ON", "🛡️ God Mode: OFF", function(state)
	if state then
		godModeConnection = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			if humanoid.Health < humanoid.MaxHealth then
				humanoid.Health = humanoid.MaxHealth
			end
		end)
	else
		if godModeConnection then
			godModeConnection:Disconnect()
			godModeConnection = nil
		end
	end
end).Parent = contentFrame

player.CharacterAdded:Connect(function(newChar)
	char = newChar
	humanoid = newChar:WaitForChild("Humanoid")
	task.wait(0.3)
	humanoid.WalkSpeed = speedValue
	humanoid.JumpPower = jumpValue
end) 
