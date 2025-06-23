
-- Bee Swarm Atlas v1.0 Style Script using Rayfield

-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Window Setup
local Window = Rayfield:CreateWindow({
   Name = "Atlas v1.0 - Bee Swarm Simulator",
   LoadingTitle = "Atlas v1.0",
   LoadingSubtitle = "by ChatGPT",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "AtlasUI", -- Optional
      FileName = "BeeSwarmScript"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

-- Farming Tab
local FarmingTab = Window:CreateTab("🌾 Farming", 4483362458)

local selectedField = "Sunflower Field"

FarmingTab:CreateDropdown({
   Name = "Select Field",
   Options = {
      "Sunflower Field", "Dandelion Field", "Mushroom Field", "Blue Flower Field",
      "Clover Field", "Spider Field", "Strawberry Field", "Bamboo Field", "Pumpkin Patch", "Pine Tree Forest"
   },
   CurrentOption = "Sunflower Field",
   Callback = function(Option)
      selectedField = Option
   end
})

FarmingTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Callback = function(v)
      getgenv().autoFarm = v
   end
})

FarmingTab:CreateToggle({
   Name = "Auto Sprinkler",
   CurrentValue = false,
   Callback = function(v)
      getgenv().autoSprinkler = v
   end
})

FarmingTab:CreateToggle({
   Name = "Auto Dig",
   CurrentValue = false,
   Callback = function(v)
      getgenv().autoDig = v
   end
})

-- Sprout Settings Tab
local SproutTab = Window:CreateTab("🌱 Sprout Settings", 4483362458)

SproutTab:CreateToggle({
   Name = "Farm Sprouts",
   CurrentValue = false,
   Callback = function(v)
      getgenv().farmSprouts = v
   end
})

SproutTab:CreateToggle({
   Name = "Auto Plant Sprouts",
   CurrentValue = false,
   Callback = function(v)
      getgenv().autoPlantSprouts = v
   end
})

SproutTab:CreateToggle({
   Name = "Plant During Day Only",
   CurrentValue = false,
   Callback = function(v)
      getgenv().plantDayOnly = v
   end
})

SproutTab:CreateToggle({
   Name = "Plant During Night Only",
   CurrentValue = false,
   Callback = function(v)
      getgenv().plantNightOnly = v
   end
})

SproutTab:CreateDropdown({
   Name = "Allowed Fields",
   Options = {
      "Sunflower Field", "Pine Tree Forest", "Mushroom Field", "Strawberry Field", "Pumpkin Patch"
   },
   CurrentOption = "Pine Tree Forest",
   Callback = function(Option)
      getgenv().allowedField = Option
   end
})

SproutTab:CreateDropdown({
   Name = "Sprout Rarity",
   Options = {"Common", "Rare", "Epic", "Legendary"},
   CurrentOption = "Rare",
   Callback = function(Option)
      getgenv().sproutRarity = Option
   end
})
