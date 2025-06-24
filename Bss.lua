-- Expedition Antarctica Stylish UI Script with God Mode

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "EA_StylishUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 270, 0, 210)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local shadow = Instance.new("ImageLabel", MainFrame)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = 0

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "❄️ Zone Expedition Trainer"
Title.TextColor3 = Color3.fromRGB(180, 230, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamSemibold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 2

local toggleBtn = Instance.new("TextButton", MainFrame)
toggleBtn.Position = UDim2.new(1, -30, 0, 5)
toggleBtn.Size = UDim2.new(0, 20, 0, 20)
toggleBtn.Text = "-"
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.AutoButtonColor = false

local btnCorner = Instance.new("UICorner", toggleBtn)
btnCorner.CornerRadius = UDim.new(0, 4)

toggleBtn.MouseEnter:Connect(function()
	toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end)
toggleBtn.MouseLeave:Connect(function()
	toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

local minimized = false
local contentFrame = Instance.new("Frame", MainFrame)
contentFrame.Name = "ContentFrame"
contentFrame.Position = UDim2.new(0, 0, 0, 35)
contentFrame.Size = UDim2.new(1, 0, 1, -35)
contentFrame.BackgroundTransparency = 1

-- Styled input function
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

	local boxCorner = Instance.new("UICorner", box)
	boxCorner.CornerRadius = UDim.new(0, 6)

	box.MouseEnter:Connect(function()
		box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	end)
	box.MouseLeave:Connect(function()
		box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	end)

	return box
end

local speedBox = createInput("Speed:", 10, tostring(humanoid.WalkSpeed))
local jumpBox = createInput("Jump:", 50, tostring(humanoid.JumpPower))

-- Minimize logic
task.wait()
local originalSize = MainFrame.Size
local minimizedSize = UDim2.new(0, 270, 0, 35)

toggleBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	contentFrame.Visible = not minimized
	toggleBtn.Text = minimized and "+" or "-"
	MainFrame.Size = minimized and minimizedSize or originalSize
end)

-- Toggle UI visibility with RightCtrl
local UIS = game:GetService("UserInputService")
local hidden = false
UIS.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
		hidden = not hidden
		ScreenGui.Enabled = not hidden
	end
end)

-- Update Speed and Jump
speedBox.FocusLost:Connect(function()
	local speed = tonumber(speedBox.Text)
	if speed then
		humanoid.WalkSpeed = speed
	end
	speedBox.Text = tostring(humanoid.WalkSpeed)
end)

jumpBox.FocusLost:Connect(function()
	local jump = tonumber(jumpBox.Text)
	if jump then
		humanoid.JumpPower = jump
	end
	jumpBox.Text = tostring(humanoid.JumpPower)
end)

-- GOD MODE TOGGLE
local godButton = Instance.new("TextButton", contentFrame)
godButton.Position = UDim2.new(0, 10, 0, 90)
godButton.Size = UDim2.new(0, 230, 0, 30)
godButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
godButton.TextColor3 = Color3.new(1, 1, 1)
godButton.Font = Enum.Font.GothamBold
godButton.TextSize = 14
godButton.Text = "🛡️ God Mode: OFF"
godButton.BorderSizePixel = 0

local corner = Instance.new("UICorner", godButton)
corner.CornerRadius = UDim.new(0, 6)

local godMode = false
local function keepHealth()
	while godMode do
		if humanoid and humanoid.Health < humanoid.MaxHealth then
			humanoid.Health = humanoid.MaxHealth
		end
		task.wait(0.1)
	end
end

godButton.MouseButton1Click:Connect(function()
	godMode = not godMode
	godButton.Text = godMode and "🛡️ God Mode: ON" or "🛡️ God Mode: OFF"
	if godMode then
		task.spawn(keepHealth)
	end
end)