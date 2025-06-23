-- Bee Swarm Simulator GUI (Full Version) by ChatGPT

-- Load Kavo UI
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = library.CreateLib("Bee Swarm Script", "Ocean")

-- Services & Setup
local Player = game.Players.LocalPlayer
local chr = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = chr:WaitForChild("Humanoid")
local VirtualInput = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")

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
            if not field then break end

            -- Pindah ke tengah field
            Humanoid:MoveTo(field.Position)
            Humanoid.MoveToFinished:Wait()
            wait(1)

            -- Mulai loop gerak + tool
            while getgenv().autoFarm do
                local offset = {
                    Vector3.new(5, 0, 0), Vector3.new(-5, 0, 0),
                    Vector3.new(0, 0, 5), Vector3.new(0, 0, -5)
                }
                local dir = offset[math.random(1, #offset)]
                local newPos = chr.HumanoidRootPart.Position + dir
                Humanoid:MoveTo(newPos)
                Humanoid.MoveToFinished:Wait()

                -- Aktifkan tool farming
                local tool = chr:FindFirstChildWhichIsA("Tool")
                if tool then
                    pcall(function() tool:Activate() end)
                end

                wait(getgenv().walkDelay)
            end
        end
    end)
end)

farmSection:NewToggle("Auto Convert", "Pergi otomatis ke hive", function(state)
    getgenv().autoConvert = state

    task.spawn(function()
        while getgenv().autoConvert do
            local hive = workspace.Honeycombs:FindFirstChild(Player.Name)
            if hive then
                Humanoid:MoveTo(hive.Position)
            end
            wait(5)
        end
    end)
end)

-- 🎛️ Toggle GUI pakai tombol INSERT
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        library:ToggleUI()
    end
end)

-- 🛠 Patch GUI agar bisa di-drag (force aktif)
task.delay(1, function()
    local gui = game:GetService("CoreGui"):FindFirstChild("KavoUI")
    if gui then
        for _,v in pairs(gui:GetDescendants()) do
            if v:IsA("Frame") or v:IsA("TextButton") then
                pcall(function()
                    v.Active = true
                    v.Draggable = true
                end)
            end
        end
    end
end)

-- 🔽 Tambahkan tombol minimize ke GUI
task.delay(1, function()
    local gui = game:GetService("CoreGui"):FindFirstChild("KavoUI")
    if gui then
        local frame = gui:FindFirstChildWhichIsA("Frame")
        if frame then
            local minimizeBtn = Instance.new("TextButton")
            minimizeBtn.Name = "MinimizeButton"
            minimizeBtn.Parent = frame
            minimizeBtn.Text = "🔽"
            minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
            minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
            minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
            minimizeBtn.BorderSizePixel = 0
            minimizeBtn.Font = Enum.Font.SourceSansBold
            minimizeBtn.TextSize = 18
            minimizeBtn.ZIndex = 999

            local minimized = false

            minimizeBtn.MouseButton1Click:Connect(function()
                minimized = not minimized
                for _, v in pairs(frame:GetChildren()) do
                    if v:IsA("Frame") and v.Name ~= minimizeBtn.Name then
                        v.Visible = not minimized
                    end
                end
                minimizeBtn.Text = minimized and "🔼" or "🔽"
            end)
        end
    end
end)