loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Adonis-Admin-Anti-Crash-18757"))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local whitelist = {
    "Miner_ClawYT", 
    "Josecarlos_gonzz1",
    "Player",
    "Player",
    "Player",
    "Player",
    "Player",
    "Player",
}

local function isWhitelisted(player)
    for _, username in ipairs(whitelist) do
        if player.Name:lower() == username:lower() then
            return true
        end
    end
    return false
end


local Window = Rayfield:CreateWindow({
    Name = "JC HUB V1 | SW2",
    Icon = 0,
    LoadingTitle = "JC HUB",
    LoadingSubtitle = "by Jose Carlos",
    Theme = customTheme,

    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,

    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "Big Hub"
    },

    Discord = {
        Enabled = true,
        Invite = "vegax",
        RememberJoins = true
    },

    KeySystem = false,
    KeySettings = {
        Title = "JC HUB | Key",
        Subtitle = "Access Key",
        Note = "Get the key from our Discord",
        FileName = "JCHUBKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {""}
    }
})

-- MAIN TAB
local MainTab = Window:CreateTab("👑Main", 4483362458)
MainTab:CreateSection("Card Dupe💳")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

local dupeAmount = 10

local function notifyFarmed(finalAmount)
    Rayfield:Notify({
        Title = "Success",
        Content = "You have Duped " .. tostring(finalAmount) .. " cards and laptops.",
        Duration = 6
    })
end

MainTab:CreateInput({
    Name = "Amount",
    PlaceholderText = "Input",
    RemoveTextAfterFocusLost = false,
    Flag = "DupeAmount",
    Callback = function(value)
        dupeAmount = tonumber(value) or 10
        if dupeAmount <= 0 then
            dupeAmount = 10
        end
    end
})

local function duplicateCardsAndLaptops()
    if dupeAmount <= 0 then return end

    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    RunService:Set3dRenderingEnabled(false)

    fireclickdetector(game.Workspace["Streetz War"].Anonymous.ClickDetector)
    task.wait()
    player.PlayerGui:WaitForChild("DealerGui")
    local shopGui = player.PlayerGui.DealerGui.ShopFrame
    shopGui.Visible = true
    player.PlayerGui.DealerGui.Frame.Visible = false

    repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    player.Character.HumanoidRootPart.CFrame = CFrame.new(-55, 4.5, 170)
    task.wait(0.5)

    local cardButton = shopGui["Blank Card"]
    local laptopButton = shopGui["laptop"]

    for i = 1, dupeAmount do
        task.wait()
        if cardButton.Visible then
            local cardPos = cardButton.AbsolutePosition
            VirtualInputManager:SendMouseButtonEvent(cardPos.X + 150, cardPos.Y + 60, 0, true, game, 0)
            task.wait()
            VirtualInputManager:SendMouseButtonEvent(cardPos.X + 150, cardPos.Y + 60, 0, false, game, 0)
        end

        if laptopButton.Visible then
            local laptopPos = laptopButton.AbsolutePosition
            VirtualInputManager:SendMouseButtonEvent(laptopPos.X + 150, laptopPos.Y + 60, 0, true, game, 0)
            task.wait()
            VirtualInputManager:SendMouseButtonEvent(laptopPos.X + 150, laptopPos.Y + 60, 0, false, game, 0)
        end
    end

    RunService:Set3dRenderingEnabled(true)

    local exitButton = shopGui.exit
    VirtualInputManager:SendMouseButtonEvent(exitButton.AbsolutePosition.X + 300, exitButton.AbsolutePosition.Y + 65, 0, true, game, 0)
    task.wait()
    VirtualInputManager:SendMouseButtonEvent(exitButton.AbsolutePosition.X + 300, exitButton.AbsolutePosition.Y + 65, 0, false, game, 0)

    player.Character.HumanoidRootPart.CFrame = CFrame.new(949, 4, -102)
    task.wait(2)

    local laptopCount = 0
    for _, v in pairs(player.Backpack:GetChildren()) do
        if v.Name == "Laptop" then
            laptopCount = laptopCount + 1
        end
    end

    for i = 1, laptopCount - 1 do
        spawn(function()
            local args = { true, "NEW123" }
            ReplicatedStorage.Assets.Other.GiverPunchmade:InvokeServer(unpack(args))
        end)
    end

    task.wait(4)
    if player.Backpack:FindFirstChild("Laptop") then
        player.Backpack.Laptop.Parent = player.Character
    end
    task.wait(4)

    local cardCount = 0
    for _, v in pairs(player.Backpack:GetChildren()) do
        if v.Name == "Loaded Card" then
            cardCount = cardCount + 1
        end
    end

    for i = 1, cardCount do
        spawn(function()
            local args = { false, "NEW123" }
            ReplicatedStorage.Assets.Other.GiverPunchmade:InvokeServer(unpack(args))
        end)
    end

    task.wait(1)
    player.Character.Humanoid:UnequipTools()

    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    notifyFarmed(dupeAmount)
end

MainTab:CreateButton({
    Name = "Duplicate",
    Callback = function()
        duplicateCardsAndLaptops()
    end
})


-- PLAYER TAB
local PlayerTab = Window:CreateTab("🙋🏽‍♂️Player", 4483362458)
PlayerTab:CreateSection("Player Mods")

-- NOTIFICATION
Rayfield:Notify({
    Title = "JC HUB Loaded!",
    Content = "Anti-Cheat protected version activated.",
    Duration = 5
})

-- INFINITE JUMP
local infiniteJumpEnabled = false

PlayerTab:CreateButton({
    Name = "Toggle Infinite Jump",
    Callback = function()
        infiniteJumpEnabled = not infiniteJumpEnabled

        local UIS = game:GetService("UserInputService")
        local Player = game:GetService("Players").LocalPlayer

        UIS.JumpRequest:Connect(function()
            if infiniteJumpEnabled and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
                Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end
})

-- WALKSPEED SLIDER
PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Value
            _G._CustomWS = Value
        end
    end
})

-- Maintain WalkSpeed on respawn
player.CharacterAdded:Connect(function(char)
    wait(1)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and _G._CustomWS then
        hum.WalkSpeed = _G._CustomWS
    end
end)

-- Basic GUI relocation (if needed)
task.spawn(function()
    wait(3)
    local gui = PlayerGui:FindFirstChild("Rayfield")
    if gui then
        gui.Parent = PlayerGui -- Keep it out of CoreGui if injected
    end
end)
