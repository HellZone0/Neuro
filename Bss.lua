-- Expedition Antarctica Utility Script (TextBox only)

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "EA_UI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -35, 0, 30)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.Text = "❄ Zone Expedition Trainer"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local toggleBtn = Instance.new("TextButton", MainFrame)
toggleBtn.Position = UDim2.new(1, -30, 0, 5)
toggleBtn.Size = UDim2.new(0, 25, 0, 20)
toggleBtn.Text = "-"
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
local minimized = false

local contentFrame = Instance.new("Frame", MainFrame)
contentFrame.Name = "ContentFrame"
contentFrame.Position = UDim2.new(0, 0, 0, 35)
contentFrame.Size = UDim2.new(1, 0, 1, -35)
contentFrame.BackgroundTransparency = 1

-- Speed TextBox
local speedBox = Instance.new("TextBox", contentFrame)
speedBox.Position = UDim2.new(0, 10, 0, 10)
speedBox.Size = UDim2.new(0, 230, 0, 30)
speedBox.Text = "Speed: 16"
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 14
speedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.ClearTextOnFocus = false

-- Jump TextBox
local jumpBox = Instance.new("TextBox", contentFrame)
jumpBox.Position = UDim2.new(0, 10, 0, 50)
jumpBox.Size = UDim2.new(0, 230, 0, 30)
jumpBox.Text = "Jump: 50"
jumpBox.Font = Enum.Font.Gotham
jumpBox.TextSize = 14
jumpBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
jumpBox.TextColor3 = Color3.new(1, 1, 1)
jumpBox.ClearTextOnFocus = false

-- Minimize function (revisi fix kotak kosong)
local originalSize = MainFrame.Size
local minimizedSize = UDim2.new(0, 250, 0, 35)

toggleBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	contentFrame.Visible = not minimized
	toggleBtn.Text = minimized and "+" or "-"
	MainFrame.Size = minimized and minimizedSize or originalSize
end)

-- Toggle GUI via RightCtrl
local UIS = game:GetService("UserInputService")
local hidden = false
UIS.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
		hidden = not hidden
		ScreenGui.Enabled = not hidden
	end
end)

-- Value update
speedBox.FocusLost:Connect(function()
	local text = speedBox.Text:match("%d+")
	local speed = tonumber(text)
	if speed then
		humanoid.WalkSpeed = speed
		speedBox.Text = "Speed: " .. speed
	end
end)

jumpBox.FocusLost:Connect(function()
	local text = jumpBox.Text:match("%d+")
	local jump = tonumber(text)
	if jump then
		humanoid.JumpPower = jump
		jumpBox.Text = "Jump: " .. jump
	end
end)