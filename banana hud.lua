local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

getgenv().Config = {
    FastAttack = true,
    AttackDelay = 0.04,
    HitboxSize = 50,
    AutoHaki =true,
    UseSkills = true,
    AutoFarm = false,
    AutoQuest = false,
    BringMob = false,
    BringRadius = 350,
    HoverHeight = 16,
    AutoEquip = true,
    Weapon = "Melee",
    AutoChest = false,
    AutoRaid = false,
    SelectedChip = "Flame",
    AutoFactory = false,
    AutoSeaBeast = false,
    AutoSeaEvent = false,
    AutoKitsune = false,
    AutoLeviathan = false,
    AutoVolcanic = false,
    BoatSpeed = 300,
    AutoV4 = false,
    AutoTryV4 = false,
    NoFog = false,
    AutoCDK = false,
    AutoSoulGuitar = false,
    AutoSharkAnchor = false,
    AutoHallowScythe = false,
    AutoMastery600 = false,
    AutoStats = false,
    StatTarget = "Melee",
    WalkSpeedBoost = false,
    SpeedValue = 100,
    JumpPowerBoost = false,
    JumpValue = 100,
    InfiniteJump = false,
    NoClip = false,
    PlayerESP = false,
    ItemESP = false,
    MobESP = false,
    FPSBooster = false,
    SelectedIsland = "Floating Turtle",
    TweenSpeed = 300
}

local QuestState = {
    CurrentMobName = "",
    CurrentMobCFrame = nil
}

local QuestDatabase = {
    { MinLevel = 1, MaxLevel = 9, QuestName = "BanditQuest1", QuestIndex = 1, MobName = "Bandit", NPC_CFrame = CFrame.new(1059, 15, 1550), Mob_CFrame = CFrame.new(1145, 17, 1634) },
    { MinLevel = 10, MaxLevel = 14, QuestName = "JungleQuest", QuestIndex = 1, MobName = "Monkey", NPC_CFrame = CFrame.new(-1598, 35, 153), Mob_CFrame = CFrame.new(-1448, 67, 11) },
    { MinLevel = 15, MaxLevel = 29, QuestName = "JungleQuest", QuestIndex = 2, MobName = "Gorilla", NPC_CFrame = CFrame.new(-1598, 35, 153), Mob_CFrame = CFrame.new(-1129, 40, -525) },
    { MinLevel = 30, MaxLevel = 39, QuestName = "BuggyQuest", QuestIndex = 1, MobName = "Pirate", NPC_CFrame = CFrame.new(-1145, 15, 3825), Mob_CFrame = CFrame.new(-1200, 15, 3900) },
    { MinLevel = 40, MaxLevel = 59, QuestName = "BuggyQuest", QuestIndex = 2, MobName = "Brute", NPC_CFrame = CFrame.new(-1145, 15, 3825), Mob_CFrame = CFrame.new(-1390, 15, 4100) },
    { MinLevel = 60, MaxLevel = 74, QuestName = "DesertQuest", QuestIndex = 1, MobName = "Desert Bandit", NPC_CFrame = CFrame.new(935, 7, 4375), Mob_CFrame = CFrame.new(900, 7, 4450) },
    { MinLevel = 75, MaxLevel = 89, QuestName = "DesertQuest", QuestIndex = 2, MobName = "Desert Officer", NPC_CFrame = CFrame.new(935, 7, 4375), Mob_CFrame = CFrame.new(1100, 7, 4350) },
    { MinLevel = 90, MaxLevel = 99, QuestName = "SnowQuest", QuestIndex = 1, MobName = "Snow Bandits", NPC_CFrame = CFrame.new(1140, 25, -1180), Mob_CFrame = CFrame.new(1250, 25, -1350) },
    { MinLevel = 100, MaxLevel = 119, QuestName = "SnowQuest", QuestIndex = 2, MobName = "Snowman", NPC_CFrame = CFrame.new(1140, 25, -1180), Mob_CFrame = CFrame.new(1350, 75, -1500) },
    { MinLevel = 120, MaxLevel = 149, QuestName = "MarineQuest", QuestIndex = 1, MobName = "Chief Petty Officer", NPC_CFrame = CFrame.new(-4500, 20, 4260), Mob_CFrame = CFrame.new(-4800, 20, 4050) },
    { MinLevel = 150, MaxLevel = 174, QuestName = "SkyQuest", QuestIndex = 1, MobName = "Skypiea Guards", NPC_CFrame = CFrame.new(-4840, 717, -2620), Mob_CFrame = CFrame.new(-4700, 850, -2800) },
    { MinLevel = 175, MaxLevel = 189, QuestName = "SkyQuest", QuestIndex = 2, MobName = "Wanderers", NPC_CFrame = CFrame.new(-4840, 717, -2620), Mob_CFrame = CFrame.new(-5000, 430, -2250) },
    { MinLevel = 190, MaxLevel = 209, QuestName = "SkyQuest", QuestIndex = 3, MobName = "Thunder God", NPC_CFrame = CFrame.new(-4840, 717, -2620), Mob_CFrame = CFrame.new(-7800, 5550, -1650) },
    { MinLevel = 210, MaxLevel = 249, QuestName = "PrisonQuest", QuestIndex = 1, MobName = "Prisoner", NPC_CFrame = CFrame.new(4875, 5, 735), Mob_CFrame = CFrame.new(5100, 5, 600) },
    { MinLevel = 250, MaxLevel = 274, QuestName = "ColosseumQuest", QuestIndex = 1, MobName = "Toga Warrior", NPC_CFrame = CFrame.new(-1255, 7, 3275), Mob_CFrame = CFrame.new(-1500, 7, 3050) },
    { MinLevel = 275, MaxLevel = 299, QuestName = "MagmaQuest", QuestIndex = 1, MobName = "Military Soldier", NPC_CFrame = CFrame.new(-5315, 12, 8515), Mob_CFrame = CFrame.new(-5650, 18, 8700) },
    { MinLevel = 300, MaxLevel = 324, QuestName = "FishmanQuest", QuestIndex = 1, MobName = "Fishman Warrior", NPC_CFrame = CFrame.new(61125, 18, 1565), Mob_CFrame = CFrame.new(60800, 20, 1500) },
    { MinLevel = 325, MaxLevel = 699, QuestName = "FountainQuest", QuestIndex = 1, MobName = "Galley Pirate", NPC_CFrame = CFrame.new(5125, 60, 4050), Mob_CFrame = CFrame.new(5550, 60, 3900) },
    { MinLevel = 700, MaxLevel = 724, QuestName = "Area1Quest", QuestIndex = 1, MobName = "Raider", NPC_CFrame = CFrame.new(-395, 75, 275), Mob_CFrame = CFrame.new(-700, 75, 2400) },
    { MinLevel = 725, MaxLevel = 749, QuestName = "Area1Quest", QuestIndex = 2, MobName = "Mercenary", NPC_CFrame = CFrame.new(-395, 75, 275), Mob_CFrame = CFrame.new(-850, 75, 1400) },
    { MinLevel = 750, MaxLevel = 774, QuestName = "Area2Quest", QuestIndex = 1, MobName = "Swan Pirate", NPC_CFrame = CFrame.new(630, 75, 915), Mob_CFrame = CFrame.new(850, 125, 1250) },
    { MinLevel = 775, MaxLevel = 799, QuestName = "Area2Quest", QuestIndex = 2, MobName = "Factory Staff", NPC_CFrame = CFrame.new(630, 75, 915), Mob_CFrame = CFrame.new(350, 125, -150) },
    { MinLevel = 800, MaxLevel = 824, QuestName = "MarineQuest2", QuestIndex = 1, MobName = "Marine Lieutenant", NPC_CFrame = CFrame.new(-2440, 75, -3200), Mob_CFrame = CFrame.new(-2800, 75, -3000) },
    { MinLevel = 825, MaxLevel = 849, QuestName = "MarineQuest2", QuestIndex = 2, MobName = "Marine Captain", NPC_CFrame = CFrame.new(-2440, 75, -3200), Mob_CFrame = CFrame.new(-2200, 75, -3500) },
    { MinLevel = 850, MaxLevel = 874, QuestName = "ZombieQuest", QuestIndex = 1, MobName = "Zombie", NPC_CFrame = CFrame.new(-5450, 15, -7950), Mob_CFrame = CFrame.new(-5700, 50, -7100) },
    { MinLevel = 875, MaxLevel = 899, QuestName = "ZombieQuest", QuestIndex = 2, MobName = "Vampire", NPC_CFrame = CFrame.new(-5450, 15, -7950), Mob_CFrame = CFrame.new(-6000, 20, -7500) },
    { MinLevel = 900, MaxLevel = 924, QuestName = "SnowMountainQuest", QuestIndex = 1, MobName = "Snow Trooper", NPC_CFrame = CFrame.new(655, 400, -5250), Mob_CFrame = CFrame.new(450, 420, -5500) },
    { MinLevel = 925, MaxLevel = 949, QuestName = "SnowMountainQuest", QuestIndex = 2, MobName = "Winter Warrior", NPC_CFrame = CFrame.new(655, 400, -5250), Mob_CFrame = CFrame.new(1150, 450, -5000) },
    { MinLevel = 950, MaxLevel = 974, QuestName = "IceSideQuest", QuestIndex = 1, MobName = "Lab Subordinate", NPC_CFrame = CFrame.new(-6015, 15, -5100), Mob_CFrame = CFrame.new(-5800, 15, -4500) },
    { MinLevel = 975, MaxLevel = 999, QuestName = "IceSideQuest", QuestIndex = 2, MobName = "Horned Warrior", NPC_CFrame = CFrame.new(-6015, 15, -5100), Mob_CFrame = CFrame.new(-6300, 60, -5700) },
    { MinLevel = 1000, MaxLevel = 1049, QuestName = "FireSideQuest", QuestIndex = 1, MobName = "Magma Ninja", NPC_CFrame = CFrame.new(-5425, 15, -5900), Mob_CFrame = CFrame.new(-5400, 75, -6000) },
    { MinLevel = 1050, MaxLevel = 1099, QuestName = "FireSideQuest", QuestIndex = 2, MobName = "Lava Pirate", NPC_CFrame = CFrame.new(-5425, 15, -5900), Mob_CFrame = CFrame.new(-5200, 75, -4800) },
    { MinLevel = 1100, MaxLevel = 1149, QuestName = "ShipQuest1", QuestIndex = 1, MobName = "Ship Deckhand", NPC_CFrame = CFrame.new(920, 125, 32800), Mob_CFrame = CFrame.new(900, 150, 32700) },
    { MinLevel = 1150, MaxLevel = 1199, QuestName = "ShipQuest1", QuestIndex = 2, MobName = "Ship Engineer", NPC_CFrame = CFrame.new(920, 125, 32800), Mob_CFrame = CFrame.new(900, 150, 32950) },
    { MinLevel = 1200, MaxLevel = 1249, QuestName = "IceCastleQuest", QuestIndex = 1, MobName = "Arctic Warrior", NPC_CFrame = CFrame.new(6170, 290, -6850), Mob_CFrame = CFrame.new(6000, 300, -6000) },
    { MinLevel = 1250, MaxLevel = 1299, QuestName = "IceCastleQuest", QuestIndex = 2, MobName = "Snow Lurker", NPC_CFrame = CFrame.new(6170, 290, -6850), Mob_CFrame = CFrame.new(6300, 300, -7200) },
    { MinLevel = 1300, MaxLevel = 1349, QuestName = "ForgottenQuest", QuestIndex = 1, MobName = "Sea Soldier", NPC_CFrame = CFrame.new(-3040, 315, -10250), Mob_CFrame = CFrame.new(-3250, 50, -10500) },
    { MinLevel = 1350, MaxLevel = 1499, QuestName = "ForgottenQuest", QuestIndex = 2, MobName = "Water Fighter", NPC_CFrame = CFrame.new(-3040, 315, -10250), Mob_CFrame = CFrame.new(-3400, 50, -9800) },
    { MinLevel = 1500, MaxLevel = 1524, QuestName = "PortTownQuest", QuestIndex = 1, MobName = "Pirate Millionaire", NPC_CFrame = CFrame.new(-290, 15, 5360), Mob_CFrame = CFrame.new(-350, 50, 5800) },
    { MinLevel = 1525, MaxLevel = 1549, QuestName = "PortTownQuest", QuestIndex = 2, MobName = "Pistol Billionaire", NPC_CFrame = CFrame.new(-290, 15, 5360), Mob_CFrame = CFrame.new(-500, 75, 6100) },
    { MinLevel = 1550, MaxLevel = 1574, QuestName = "HydraQuest1", QuestIndex = 1, MobName = "Mythological Pirate", NPC_CFrame = CFrame.new(5245, 605, 755), Mob_CFrame = CFrame.new(5600, 750, 1100) },
    { MinLevel = 1575, MaxLevel = 1599, QuestName = "HydraQuest1", QuestIndex = 2, MobName = "Female Islander", NPC_CFrame = CFrame.new(5245, 605, 755), Mob_CFrame = CFrame.new(5100, 750, 600) },
    { MinLevel = 1600, MaxLevel = 1624, QuestName = "HydraQuest2", QuestIndex = 1, MobName = "Marine Commodore", NPC_CFrame = CFrame.new(2180, 28, -1275), Mob_CFrame = CFrame.new(2400, 50, -1400) },
    { MinLevel = 1625, MaxLevel = 1649, QuestName = "HydraQuest2", QuestIndex = 2, MobName = "Marine Rear Admiral", NPC_CFrame = CFrame.new(2180, 28, -1275), Mob_CFrame = CFrame.new(2900, 50, -1600) },
    { MinLevel = 1650, MaxLevel = 1699, QuestName = "GreatTreeQuest", QuestIndex = 1, MobName = "Fishman Raider", NPC_CFrame = CFrame.new(2300, 30, -6800), Mob_CFrame = CFrame.new(2500, 50, -7200) },
    { MinLevel = 1700, MaxLevel = 1749, QuestName = "GreatTreeQuest", QuestIndex = 2, MobName = "Diablo", NPC_CFrame = CFrame.new(2300, 30, -6800), Mob_CFrame = CFrame.new(2100, 150, -7500) },
    { MinLevel = 1750, MaxLevel = 1774, QuestName = "TurtleQuest1", QuestIndex = 1, MobName = "Jungle Pirate", NPC_CFrame = CFrame.new(-12450, 330, -8750), Mob_CFrame = CFrame.new(-11800, 350, -8400) },
    { MinLevel = 1775, MaxLevel = 1799, QuestName = "TurtleQuest1", QuestIndex = 2, MobName = "Musketeer Pirate", NPC_CFrame = CFrame.new(-12450, 330, -8750), Mob_CFrame = CFrame.new(-13100, 350, -8900) },
    { MinLevel = 1800, MaxLevel = 1824, QuestName = "TurtleQuest2", QuestIndex = 1, MobName = "Reborn Skeleton", NPC_CFrame = CFrame.new(-2015, 330, -10050), Mob_CFrame = CFrame.new(-2300, 50, -10400) },
    { MinLevel = 1825, MaxLevel = 1849, QuestName = "TurtleQuest2", QuestIndex = 2, MobName = "Living Zombie", NPC_CFrame = CFrame.new(-2015, 330, -10050), Mob_CFrame = CFrame.new(-1800, 50, -9700) },
    { MinLevel = 1850, MaxLevel = 1899, QuestName = "MarineQuest3", QuestIndex = 1, MobName = "Demonic Soul", NPC_CFrame = CFrame.new(-9515, 145, 5785), Mob_CFrame = CFrame.new(-9300, 150, 6000) },
    { MinLevel = 1900, MaxLevel = 1949, QuestName = "MarineQuest3", QuestIndex = 2, MobName = "Posessed Mummy", NPC_CFrame = CFrame.new(-9515, 145, 5785), Mob_CFrame = CFrame.new(-9800, 150, 5500) },
    { MinLevel = 1950, MaxLevel = 1999, QuestName = "CandyQuest1", QuestIndex = 1, MobName = "Peanut Scout", NPC_CFrame = CFrame.new(-2025, 50, -12150), Mob_CFrame = CFrame.new(-2200, 50, -12400) },
    { MinLevel = 2000, MaxLevel = 2049, QuestName = "CandyQuest1", QuestIndex = 2, MobName = "Peanut President", NPC_CFrame = CFrame.new(-2025, 50, -12150), Mob_CFrame = CFrame.new(-1850, 50, -11900) },
    { MinLevel = 2050, MaxLevel = 2099, QuestName = "CandyQuest2", QuestIndex = 1, MobName = "Ice Cream Chef", NPC_CFrame = CFrame.new(-2025, 50, -12150), Mob_CFrame = CFrame.new(-2300, 50, -11500) },
    { MinLevel = 2100, MaxLevel = 2149, QuestName = "CandyQuest2", QuestIndex = 2, MobName = "Ice Cream Commander", NPC_CFrame = CFrame.new(-2025, 50, -12150), Mob_CFrame = CFrame.new(-1700, 50, -11400) },
    { MinLevel = 2150, MaxLevel = 2199, QuestName = "CakeQuest1", QuestIndex = 1, MobName = "Cookie Crafter", NPC_CFrame = CFrame.new(-2021, 38, -12028), Mob_CFrame = CFrame.new(-2360, 38, -12080) },
    { MinLevel = 2200, MaxLevel = 2249, QuestName = "CakeQuest1", QuestIndex = 2, MobName = "Cake Guard", NPC_CFrame = CFrame.new(-2021, 38, -12028), Mob_CFrame = CFrame.new(-1610, 38, -12250) },
    { MinLevel = 2250, MaxLevel = 2299, QuestName = "CakeQuest2", QuestIndex = 1, MobName = "Baking Staff", NPC_CFrame = CFrame.new(-1927, 38, -12842), Mob_CFrame = CFrame.new(-1880, 38, -12980) },
    { MinLevel = 2300, MaxLevel = 2349, QuestName = "CakeQuest2", QuestIndex = 2, MobName = "Head Baker", NPC_CFrame = CFrame.new(-1927, 38, -12842), Mob_CFrame = CFrame.new(-2200, 52, -13020) },
    { MinLevel = 2350, MaxLevel = 2399, QuestName = "ChocQuest1", QuestIndex = 1, MobName = "Cocoa Warrior", NPC_CFrame = CFrame.new(233, 25, -12200), Mob_CFrame = CFrame.new(110, 25, -12240) },
    { MinLevel = 2400, MaxLevel = 2449, QuestName = "ChocQuest1", QuestIndex = 2, MobName = "Chocolate Bar Battler", NPC_CFrame = CFrame.new(233, 25, -12200), Mob_CFrame = CFrame.new(580, 25, -12550) },
    { MinLevel = 2450, MaxLevel = 2474, QuestName = "TikiQuest1", QuestIndex = 1, MobName = "Island Outlaw", NPC_CFrame = CFrame.new(-16547, 55, 1051), Mob_CFrame = CFrame.new(-16350, 55, 1280) },
    { MinLevel = 2475, MaxLevel = 2499, QuestName = "TikiQuest1", QuestIndex = 2, MobName = "Island Boy", NPC_CFrame = CFrame.new(-16547, 55, 1051), Mob_CFrame = CFrame.new(-16820, 55, 1410) },
    { MinLevel = 2500, MaxLevel = 2524, QuestName = "TikiQuest2", QuestIndex = 1, MobName = "Sun-kissed Warrior", NPC_CFrame = CFrame.new(-16541, 55, 1051), Mob_CFrame = CFrame.new(-16280, 55, 1590) },
    { MinLevel = 2525, MaxLevel = 2549, QuestName = "TikiQuest2", QuestIndex = 2, MobName = "Isle Champion", NPC_CFrame = CFrame.new(-16541, 55, 1051), Mob_CFrame = CFrame.new(-16790, 55, 1740) },
    { MinLevel = 2550, MaxLevel = 2574, QuestName = "TikiQuest3", QuestIndex = 1, MobName = "Serpent Hunter", NPC_CFrame = CFrame.new(-16665, 105, 1575), Mob_CFrame = CFrame.new(-16520, 105, 1890) },
    { MinLevel = 2575, MaxLevel = 2599, QuestName = "TikiQuest3", QuestIndex = 2, MobName = "Skull Slayer", NPC_CFrame = CFrame.new(-16665, 105, 1575), Mob_CFrame = CFrame.new(-16840, 105, 1950) },
    { MinLevel = 2600, MaxLevel = 2649, QuestName = "SubmergedQuest1", QuestIndex = 1, MobName = "Abyssal Marauder", NPC_CFrame = CFrame.new(-17420, 18, 2480), Mob_CFrame = CFrame.new(-17260, 22, 2690) },
    { MinLevel = 2650, MaxLevel = 2699, QuestName = "SubmergedQuest1", QuestIndex = 2, MobName = "Tidal Warden", NPC_CFrame = CFrame.new(-17420, 18, 2480), Mob_CFrame = CFrame.new(-17610, 26, 2810) },
    { MinLevel = 2700, MaxLevel = 2749, QuestName = "CelestialQuest1", QuestIndex = 1, MobName = "Astral Disciple", NPC_CFrame = CFrame.new(-18250, 890, 3920), Mob_CFrame = CFrame.new(-18090, 895, 4150) },
    { MinLevel = 2750, MaxLevel = 2800, QuestName = "CelestialQuest1", QuestIndex = 2, MobName = "Celestial Sovereign", NPC_CFrame = CFrame.new(-18250, 890, 3920), Mob_CFrame = CFrame.new(-18440, 902, 4280) }
}

local function GetQuestDataByLevel()
    local dataFolder = LocalPlayer:FindFirstChild("Data")
    local levelObj = dataFolder and dataFolder:FindFirstChild("Level")
    if not levelObj then return nil end

    local currentLevel = levelObj.Value
    local selectedQuest = QuestDatabase[1]

    for _, quest in ipairs(QuestDatabase) do
        if currentLevel >= quest.MinLevel then
            selectedQuest = quest
        end
    end

    return selectedQuest
end

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if not getgenv().Config.AutoQuest then 
                QuestState.CurrentMobName = ""
                QuestState.CurrentMobCFrame = nil
                return 
            end

            local questData = GetQuestDataByLevel()
            if not questData then return end

            QuestState.CurrentMobName = questData.MobName
            QuestState.CurrentMobCFrame = questData.Mob_CFrame

            local mainGui = PlayerGui:FindFirstChild("Main")
            local questFrame = mainGui and mainGui:FindFirstChild("Quest")

            if questFrame and not questFrame.Visible then
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if hrp then
                    hrp.CFrame = questData.NPC_CFrame
                    task.wait(0.2)

                    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                    local commF = remotes and remotes:FindFirstChild("CommF_")
                    if commF then
                        commF:InvokeServer("StartQuest", questData.QuestName, questData.QuestIndex)
                    end
                end
            elseif questFrame and questFrame.Visible then
                local container = questFrame:FindFirstChild("Container")
                local questTitle = container and container:FindFirstChild("QuestTitle")
                local titleLabel = questTitle and questTitle:FindFirstChild("Title")

                if titleLabel and not string.find(titleLabel.Text, questData.MobName) then
                    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                    local commF = remotes and remotes:FindFirstChild("CommF_")
                    if commF then
                        commF:InvokeServer("AbandonQuest")
                    end
                end
            end
        end)
    end
end)

local CombatFramework = nil
local CombatFrameworkR = nil

pcall(function()
    CombatFramework = require(LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
    CombatFrameworkR = debug.getupvalues(CombatFramework)[2]
end)

local function GetCurrentBlade()
    if not CombatFrameworkR then return nil end
    local AC = CombatFrameworkR.activeController
    if AC and AC.blades and #AC.blades > 0 then
        return AC.blades[1]
    end
    return nil
end

local function EquipWeapon(toolType)
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if not hum then return end

    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == toolType or tool.Name:find(toolType)) then
            hum:EquipTool(tool)
            break
        end
    end
end

task.spawn(function()
    while true do
        pcall(function()
            if getgenv().Config.FastAttack and CombatFrameworkR then
                local AC = CombatFrameworkR.activeController
                if AC and AC.equipped then
                    AC.attacking = false
                    AC.blocking = false
                    AC.timeToNextAttack = 0
                    AC.timeToNextBlock = 0
                    AC.increment = 3
                    AC.hitboxMagnitude = getgenv().Config.HitboxSize
                    
                    local blade = GetCurrentBlade()
                    if blade then
                        AC:attack()
                    end
                end
                
                local Net = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Net")
                if Net then
                    local RegisterAttack = Net:FindFirstChild("RE/RegisterAttack")
                    if RegisterAttack then
                        RegisterAttack:FireServer(0)
                    end
                end
            end
        end)
        task.wait(getgenv().Config.AttackDelay)
    end
end)

task.spawn(function()
    while task.wait(1) do
        if getgenv().Config.AutoHaki then
            pcall(function()
                local char = LocalPlayer.Character
                if char and not char:FindFirstChild("HasBuso") then
                    local CommF = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
                    if CommF then
                        CommF:InvokeServer("Buso")
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.15) do
        pcall(function()
            if getgenv().Config.BringMob and (getgenv().Config.AutoFarm or getgenv().Config.AutoRaid) then
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    local enemyHum = enemy:FindFirstChild("Humanoid")
                    local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
                    
                    if enemyHum and enemyHRP and enemyHum.Health > 0 then
                        local isValidTarget = getgenv().Config.AutoRaid or (not getgenv().Config.AutoQuest) or (QuestState.CurrentMobName == "") or (enemy.Name == QuestState.CurrentMobName)
                        
                        if isValidTarget then
                            local dist = (enemyHRP.Position - hrp.Position).Magnitude
                            if dist <= getgenv().Config.BringRadius then
                                enemyHum.WalkSpeed = 0
                                enemyHum.JumpPower = 0
                                enemyHRP.CanCollide = false
                                enemyHRP.CFrame = hrp.CFrame * CFrame.new(0, 0, -10)
                                
                                if sethiddenproperty then
                                    sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local humanoid = char and char:FindFirstChild("Humanoid")
            if not hrp or not humanoid then return end

            if getgenv().Config.AutoFarm then
                if getgenv().Config.AutoEquip then
                    EquipWeapon(getgenv().Config.Weapon)
                end

                local target = nil
                local shortestDist = math.huge
                
                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    local enemyHum = enemy:FindFirstChild("Humanoid")
                    local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
                    
                    if enemyHum and enemyHRP and enemyHum.Health > 0 then
                        local isValidTarget = (not getgenv().Config.AutoQuest) or (QuestState.CurrentMobName == "") or (enemy.Name == QuestState.CurrentMobName)
                        if isValidTarget then
                            local dist = (enemyHRP.Position - hrp.Position).Magnitude
                            if dist < shortestDist then
                                shortestDist = dist
                                target = enemy
                            end
                        end
                    end
                end

                if target and target:FindFirstChild("HumanoidRootPart") then
                    humanoid.PlatformStand = true
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

                    hrp.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, getgenv().Config.HoverHeight, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                    
                    if not getgenv().Config.FastAttack then
                        VirtualUser:CaptureController()
                        VirtualUser:Button1Down(Vector2.new(1280, 672))
                    end
                elseif getgenv().Config.AutoQuest and QuestState.CurrentMobCFrame then
                    humanoid.PlatformStand = true
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    hrp.CFrame = QuestState.CurrentMobCFrame * CFrame.new(0, getgenv().Config.HoverHeight, 0)
                else
                    humanoid.PlatformStand = false
                end
            else
                if humanoid.PlatformStand and not (getgenv().Config.AutoChest or getgenv().Config.AutoRaid or getgenv().Config.AutoFactory or getgenv().Config.AutoSeaBeast) then
                    humanoid.PlatformStand = false
                end
            end
        end)
    end
end)

if PlayerGui:FindFirstChild("BananaHubUltimate") then
    PlayerGui.BananaHubUltimate:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BananaHubUltimate"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0.05, 0, 0.18, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleButton.Text = "🍌"
ToggleButton.TextSize = 24
ToggleButton.Parent = ScreenGui
ToggleButton.Active = true
ToggleButton.Draggable = true
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleButton)
ToggleStroke.Color = Color3.fromRGB(255, 215, 0)
ToggleStroke.Thickness = 2

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 215, 0)
MainStroke.Thickness = 2

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "BANANA HUB | ULTIMATE EDITION"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
