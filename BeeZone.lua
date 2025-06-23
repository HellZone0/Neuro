
-- Load GUI Library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = library.CreateLib("Zone Bee Swarm Script", "Ocean")

-- Services & Setup
local Player = game.Players.LocalPlayer
local chr = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = chr:WaitForChild("Humanoid")
local VirtualInput = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

-- Variabel Global
getgenv().selectedField = "Sunflower Field"
getgenv().autoFarm = false
getgenv().autoConvert = false
getgenv().walkDelay = 1

-- 🐝 Tab Farming
local farmTab = Window:NewTab("Farming")
local farmSection = farmTab:NewSection("Auto Farming")

farmSection:NewDropdown("Select Field", "Pilih field yang ingin difarm", {
    "Sunflower Field", "Dandelion Field", "Mushroom Field",
    "Blue Flower Field", "Clover Field", "Spider Field",
    "Strawberry Field", "Bamboo Field", "Pumpkin Patch"
}, function(field)
    getgenv().selectedField = field
end)

farmSection:NewSlider("Delay Gerak (detik)", "Atur kecepatan gerak saat farming", 5, 0.2, 1, function(value)
    getgenv().walkDelay = value
end)

farmSection:NewToggle("Auto Farm (Natural)", "Karakter bergerak & farming otomatis", function(state)
    getgenv().autoFarm = state

    task.spawn(function()
        while getgenv().autoFarm do
            local field = workspace.FlowerZones:FindFirstChild(getgenv().selectedField)
            if field and chr and Humanoid then
                -- Pergi ke field dulu
                Humanoid:MoveTo(field.Position)
                wait(3)

                while getgenv().autoFarm do
                    local moveOffset = {
                        Vector3.new(5, 0, 0), Vector3.new(-5, 0, 0),
                        Vector3.new(0, 0, 5), Vector3.new(0, 0, -5)
                    }
                    local direction = moveOffset[math.random(1, #moveOffset)]
                    local newPosition = chr.HumanoidRootPart.Position + direction
                    Humanoid:MoveTo(newPosition)

                    -- Simulasi klik (untuk tool dig)
                    VirtualInput:SendMouseButtonEvent(500, 500, 0, true, game, 1)
                    wait(0.1)
                    VirtualInput:SendMouseButtonEvent(500, 500, 0, false, game, 1)

                    wait(getgenv().walkDelay)
                end
            end
            wait(1)
        end
    end)
end)

farmSection:NewToggle("Auto Convert", "Pergi otomatis ke hive", function(state)
    getgenv().autoConvert = state
    task.spawn(function()
        while getgenv().autoConvert do
            local hive = workspace.Honeycombs:FindFirstChild(Player.Name)
            if hive and chr and Humanoid then
                Humanoid:MoveTo(hive.Position)
            end
            wait(5)
        end
    end)
end)

-- 📜 Toggle GUI pakai tombol INSERT
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        library:ToggleUI()
    end
end)