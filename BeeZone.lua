-- GUI menggunakan Kavo‑style (Atlas)
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Chris12089/atlasbss/main/script.lua"))()
local Window = library.CreateLib("Zone Bee Swarm Script", "Ocean")

local Player = game.Players.LocalPlayer
local chr = Player.Character or Player.CharacterAdded:Wait()

-- Panel Farming
local FarmTab = Window:NewTab("Farming")
local Farm = FarmTab:NewSection("Farm Controls")

getgenv().autoFarm = false
getgenv().autoSprout = false
getgenv().autoConvert = false

Farm:NewToggle("Auto Farm", "Auto collect pollen", function(t)
    getgenv().autoFarm = t
    while getgenv().autoFarm do
        -- Contoh: teleport ke flower zone
        local zone = workspace.FlowerZones:GetChildren()[1]
        chr.HumanoidRootPart.CFrame = zone.CFrame + Vector3.new(0, 5, 0)
        wait(1)
    end
end)

Farm:NewToggle("Auto Sprout", "Auto sprout farm", function(t)
    getgenv().autoSprout = t
    while getgenv().autoSprout do
        -- contoh kode sprout
        fireclickdetector(workspace.Sprouts:FindFirstChild("Sprout").ClickDetector)
        wait(3)
    end
end)

Farm:NewToggle("Auto Convert", "Convert pollen to honey", function(t)
    getgenv().autoConvert = t
    while getgenv().autoConvert do
        local hive = workspace.Honeycombs:FindFirstChild(Player.Name)
        if hive then
            chr.HumanoidRootPart.CFrame = hive.CFrame + Vector3.new(0,5,0)
        end
        wait(5)
    end
end)

-- Panel Quest
local QuestTab = Window:NewTab("Quests")
local Quests = QuestTab:NewSection("Quest Actions")

Quests:NewButton("Collect Quests", "Otomatis klik quest board", function()
    for _,btn in pairs(workspace.MissionBoard:GetDescendants()) do
        if btn:IsA("ClickDetector") then
            fireclickdetector(btn)
        end
    end
end)

Quests:NewButton("Turn-in Quests", "Kirim quest yang selesai", function()
    for _,gui in pairs(Player.PlayerGui.ScreenGui.MissionBoard:GetChildren()) do
        if gui:IsA("TextButton") and gui.Text == "Turn In" then
            fireclickdetector(gui.ClickDetector)
        end
    end
end)