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
Title.Text = "Zone Expedition"
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

-- 🔹 FPS Display
local fpsLabel = Instance.new("TextLabel", MainFrame)
fpsLabel.Size = UDim2.new(0, 80, 0, 20)
fpsLabel.Position = UDim2.new(1, -110, 0, 5) -- Diatur supaya di samping kiri toggleBtn
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

local minimized = false
local originalSize = MainFrame.Size
local minimizedSize = UDim2.new(0, 270, 0, 35)

toggleBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	contentFrame.Visible = not minimized
	toggleBtn.Text = minimized and "+" or "-"
	MainFrame.Size = minimized and minimizedSize or originalSize
end)

-- Toggle UI with RightCtrl
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end
end)

-- Input Builder
local function createInput(labelText, posY, defaultText)
	local label = Instance.new("TextLabel", contentFrame)
	label.Position = UDim2.new(0, 10, 0, posY)
	label.Size = UDim2.new(0, 60, 0, 30)
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left

	local box = Instance.new("TextBox", contentFrame)
	box.Position = UDim2.new(0, 80, 0, posY)
	box.Size = UDim2.new(0, 160, 0, 30)
	box.Text = defaultText
	box.Font = Enum.Font.Gotham
	box.TextSize = 14
	box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.ClearTextOnFocus = true
	box.BorderSizePixel = 0
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

	box.MouseEnter:Connect(function()
		box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	end)
	box.MouseLeave:Connect(function()
		box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	end)

	return box
end

-- Input
local speedBox = createInput("Speed:", 10, "16")
local jumpBox = createInput("Jump:", 50, "50")

-- Apply on change
speedBox.FocusLost:Connect(function()
	local val = tonumber(speedBox.Text)
	if val then
		speedValue = val
		if humanoid then humanoid.WalkSpeed = val end
	end
	speedBox.Text = tostring(speedValue)
end)

jumpBox.FocusLost:Connect(function()
	local val = tonumber(jumpBox.Text)
	if val then
		jumpValue = val
		if humanoid then humanoid.JumpPower = val end
	end
	jumpBox.Text = tostring(jumpValue)
end)

-- Reset Button
local resetBtn = Instance.new("TextButton", contentFrame)
resetBtn.Position = UDim2.new(0, 10, 0, 170)
resetBtn.Size = UDim2.new(0, 230, 0, 30)
resetBtn.Text = "🔄 Reset Speed & Jump"
resetBtn.Font = Enum.Font.GothamBold
resetBtn.TextSize = 14
resetBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
resetBtn.TextColor3 = Color3.new(1, 1, 1)
resetBtn.BorderSizePixel = 0
Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0, 6)

resetBtn.MouseButton1Click:Connect(function()
	speedValue = 16
	jumpValue = 50
	if humanoid then
		humanoid.WalkSpeed = speedValue
		humanoid.JumpPower = jumpValue
	end
	speedBox.Text = "16"
	jumpBox.Text = "50"
end)

-- Toggle Button Builder
local function createToggleButton(name, posY, onText, offText, callback)
	local btn = Instance.new("TextButton", contentFrame)
	btn.Position = UDim2.new(0, 10, 0, posY)
	btn.Size = UDim2.new(0, 230, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.Text = offText
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	local enabled = false
	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		btn.Text = enabled and onText or offText
		btn.BackgroundColor3 = enabled and Color3.fromRGB(60, 100, 60) or Color3.fromRGB(40, 40, 40)
		callback(enabled)
	end)

	return btn
end

-- Anti Blizzard
local antiStormEnabled = false
createToggleButton("AntiStorm", 90, "☁ Anti Badai: ON", "☁ Anti Badai: OFF", function(state)
	antiStormEnabled = state
end)

task.spawn(function()
	while true do
		task.wait(1)
		if antiStormEnabled then
			local Lighting = game:GetService("Lighting")
			local cam = workspace.CurrentCamera
			for _, v in pairs(Lighting:GetChildren()) do
				if v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BlurEffect") then
					v.Enabled = false
				end
			end
			for _, v in pairs(cam:GetChildren()) do
				if v:IsA("BlurEffect") then
					v.Enabled = false
				end
			end
		end
	end
end)

-- God Mode
local godConnection
createToggleButton("GodMode", 130, "🛡️ God Mode: ON", "🛡️ God Mode: OFF", function(state)
	if state then
		local hum = humanoid
		if hum then
			godConnection = hum:GetPropertyChangedSignal("Health"):Connect(function()
				if hum.Health < hum.MaxHealth then
					hum.Health = hum.MaxHealth
				end
			end)
		end
	else
		if godConnection then
			godConnection:Disconnect()
			godConnection = nil
		end
	end
end)

-- 🔹 FPS Calculation
local RunService = game:GetService("RunService")
local fps = 0
local frameCount = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
	frameCount += 1
	local now = tick()

	if now - lastTime >= 1 then
		fps = frameCount
		frameCount = 0
		lastTime = now
		fpsLabel.Text = "FPS: " .. tostring(fps)
	end
end)

-- Update on Respawn
player.CharacterAdded:Connect(function(newChar)
	char = newChar
	humanoid = newChar:WaitForChild("Humanoid")
	task.wait(0.3)
	humanoid.WalkSpeed = speedValue
	humanoid.JumpPower = jumpValue
end)