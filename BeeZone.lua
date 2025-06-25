
-- Bee Swarm Simulator Trainer v1 - Fungsional
-- Dibuat oleh ChatGPT (versi awal dengan GUI dan auto walk ke field)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- CONFIG
local selectedField = "Sunflower Field"
local walkingSpeed = 16
local autoFarm = false
local autoConvert = false
local autoDig = false

-- FIELD POSITIONS (sederhana)
local fieldPositions = {
    ["Sunflower Field"] = Vector3.new(108, 3, 268),
    ["Clover Field"] = Vector3.new(143, 3, 94),
    ["Strawberry Field"] = Vector3.new(89, 3, 147),
    ["Blue Flower Field"] = Vector3.new(40, 3, 264),
    ["Bamboo Field"] = Vector3.new(270, 3, 144),
    ["Pineapple Patch"] = Vector3.new(-130, 3, 481),
    ["Coconut Field"] = Vector3.new(-260, 3, 410),
    ["Pumpkin Patch"] = Vector3.new(-70, 3, 264),
    ["Spider Field"] = Vector3.new(153, 3, 180),
    ["Mountain Top Field"] = Vector3.new(87, 180, -44)
}

-- UI (minimal)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BSSTrainer"

local main = Instance.new("Frame", ScreenGui)
main.Size = UDim2.new(0, 250, 0, 200)
main.Position = UDim2.new(0, 20, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🐝 Bee Swarm Trainer"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local dropdown = Instance.new("TextButton", main)
dropdown.Position = UDim2.new(0, 10, 0, 40)
dropdown.Size = UDim2.new(0, 230, 0, 30)
dropdown.Text = "Field: " .. selectedField
dropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
dropdown.TextColor3 = Color3.new(1,1,1)
dropdown.TextSize = 14
dropdown.Font = Enum.Font.Gotham
Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0, 6)

dropdown.MouseButton1Click:Connect(function()
    local next = nil
    local found = false
    for field, _ in pairs(fieldPositions) do
        if found then next = field break end
        if field == selectedField then found = true end
    end
    if not next then
        for field, _ in pairs(fieldPositions) do next = field break end
    end
    selectedField = next
    dropdown.Text = "Field: " .. selectedField
end)

local function createToggle(text, ypos, callback)
    local btn = Instance.new("TextButton", main)
    btn.Position = UDim2.new(0, 10, 0, ypos)
    btn.Size = UDim2.new(0, 230, 0, 25)
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
end

createToggle("Auto Farm", 80, function(val) autoFarm = val end)
createToggle("Auto Dig", 110, function(val) autoDig = val end)
createToggle("Auto Convert", 140, function(val) autoConvert = val end)

-- WALKING
local function walkTo(pos)
    local dist = (hrp.Position - pos).Magnitude
    local time = dist / walkingSpeed
    TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)}):Play()
end

-- DIG FUNCTION
local function holdDig()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, nil)
end

-- LOOP
task.spawn(function()
    while true do
        task.wait(1)
        if autoFarm and fieldPositions[selectedField] then
            walkTo(fieldPositions[selectedField])
        end
        if autoDig then
            holdDig()
        end
    end
end)
