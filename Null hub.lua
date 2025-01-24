local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- ฟังก์ชันแสดง UI พร้อมอนิเมชัน
local function showBadgeUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FakeBadgeUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local badgeFrame = Instance.new("Frame")
    badgeFrame.Size = UDim2.new(0.3, 0, 0.2, 0)
    badgeFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
    badgeFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    badgeFrame.BackgroundTransparency = 1 -- เริ่มจากโปร่งใส
    badgeFrame.BorderSizePixel = 0
    badgeFrame.Parent = screenGui

    local badgeText = Instance.new("TextLabel")
    badgeText.Size = UDim2.new(1, 0, 1, 0)
    badgeText.Position = UDim2.new(0, 0, 0, 0)
    badgeText.Text = "Null Hub(made by funnysad)"
    badgeText.TextColor3 = Color3.new(1, 1, 1)
    badgeText.BackgroundTransparency = 1
    badgeText.Font = Enum.Font.GothamBold
    badgeText.TextScaled = true
    badgeText.Parent = badgeFrame

    -- สร้าง Tween สำหรับอนิเมชันเข้า
    local fadeIn = TweenService:Create(badgeFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
    local textFadeIn = TweenService:Create(badgeText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0})

    -- สร้าง Tween สำหรับอนิเมชันออก
    local fadeOut = TweenService:Create(badgeFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1})
    local textFadeOut = TweenService:Create(badgeText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1})

    -- เริ่มอนิเมชันเข้า
    fadeIn:Play()
    textFadeIn:Play()

    -- รอ 3 วินาทีก่อนเริ่มอนิเมชันออก
    task.delay(3, function()
        fadeOut:Play()
        textFadeOut:Play()

        -- ลบ UI หลังจากอนิเมชันออกเสร็จ
        fadeOut.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
end

-- ตัวอย่างการเรียกฟังก์ชันเมื่อถึงเงื่อนไข
showBadgeUI()

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gameGui = playerGui:WaitForChild("GameGui")
local info = gameGui:WaitForChild("Info")
local autoSkip = info:WaitForChild("Auto_Skip")
local redButton = autoSkip:WaitForChild("Red")

-- ตรวจสอบว่าปุ่ม Red มีอยู่
if redButton then
    redButton.BackgroundColor3 = Color3.fromRGB(13, 255, 0) -- เปลี่ยนสีพื้นหลังเป็นสีเขียว
    print("สีของปุ่ม Red ถูกเปลี่ยนแล้ว!")
else
    warn("ไม่พบปุ่ม Red ใน GUI!")
end

local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

-- ฟังก์ชันสำหรับตรวจสอบ Gold
local function hasEnoughGold(amount)
    if workspace.PlayerStats:FindFirstChild(player.Name) and 
       workspace.PlayerStats[player.Name]:FindFirstChild("Gold") and 
       workspace.PlayerStats[player.Name].Gold.Value >= amount then
        return true
    end
    return false
end

-- ฟังก์ชันสำหรับส่งคำสั่ง ChangeMode
local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

-- ขั้นตอนการอัปเกรด
local upgrades = {
    {name = "Ninja Cameraman", gold = 200, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Ninja Cameraman2", gold = 201, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(-3.1415927410125732, 0.3082665503025055, -3.1415927410125732), tower = "Ninja Cameraman"},
    {name = "Ninja Cameraman3", gold = 300, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(-3.1415927410125732, -0.5998259782791138, -3.1415927410125732), tower = "Ninja Cameraman2"},
    {name = "Ninja Cameraman4", gold = 400, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(-3.1415927410125732, -0.8647982478141785, -3.1415927410125732), tower = "Ninja Cameraman3"},
    {name = "Ninja Cameraman5", gold = 600, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(-3.1415927410125732, 0.30992642045021057, -3.1415927410125732), tower = "Ninja Cameraman4"}
}

-- ทำงานตามขั้นตอน
for i, upgrade in ipairs(upgrades) do
    if i == 1 then
        -- ทำงานส่วนแรกทันทีโดยไม่ตรวจสอบ Gold
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
    else
        -- รอจนกว่า Gold จะเพียงพอในส่วนที่เหลือ
        while not hasEnoughGold(upgrade.gold) do
            task.wait(0.1)
        end
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
    end
end

local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

-- ฟังก์ชันสำหรับตรวจสอบ Gold
local function hasEnoughGold(amount)
    local playerStats = workspace.PlayerStats:FindFirstChild(player.Name)
    if playerStats and playerStats:FindFirstChild("Gold") then
        if playerStats.Gold.Value >= amount then
            return true
        end
    end
    return false
end

-- ฟังก์ชันสำหรับส่งคำสั่ง ChangeMode
local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

-- ตารางการอัปเกรดและค่าทองที่กำหนดเอง
local upgrades = { 
    {name = "Scientist Cameraman", gold = 100, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Scientist Cameraman2", gold = 300, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Scientist Cameraman"},
    {name = "Scientist Cameraman3", gold = 600, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Scientist Cameraman2"},
    {name = "Scientist Cameraman4", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Scientist Cameraman3"},
    {name = "Scientist Cameraman5", gold = 2000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Scientist Cameraman4"},
    {name = "Scientist Cameraman6", gold = 5000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Scientist Cameraman5"},
}

-- ลูปทำงานตลอดจนกว่าจะไม่สามารถอัปเกรดได้
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- เพิ่มค่า i เพื่อไปที่การอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาทีแล้วลองใหม่
    end
end

local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

-- ฟังก์ชันสำหรับตรวจสอบ Gold
local function hasEnoughGold(amount)
    local playerStats = workspace.PlayerStats:FindFirstChild(player.Name)
    if playerStats and playerStats:FindFirstChild("Gold") then
        if playerStats.Gold.Value >= amount then
            return true
        end
    end
    return false
end

-- ฟังก์ชันสำหรับส่งคำสั่ง ChangeMode
local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

local upgrades = {
    {name = "Upgraded Titan Speakerman", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Upgraded Titan Speakerman2", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman"},
    {name = "Upgraded Titan Speakerman3", gold = 2000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman2"},
    {name = "Upgraded Titan Speakerman4", gold = 4000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman3"},
    {name = "Upgraded Titan Speakerman5", gold = 6000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman4"}
}
    -- ลูปทำงานตลอดจนกว่าจะไม่สามารถอัปเกรดได้
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- เพิ่มค่า i เพื่อไปที่การอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาทีแล้วลองใหม่
    end
end

local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

-- ฟังก์ชันสำหรับตรวจสอบ Gold
local function hasEnoughGold(amount)
    local playerStats = workspace.PlayerStats:FindFirstChild(player.Name)
    if playerStats and playerStats:FindFirstChild("Gold") then
        if playerStats.Gold.Value >= amount then
            return true
        end
    end
    return false
end

-- ฟังก์ชันสำหรับส่งคำสั่ง ChangeMode
local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

local upgrades = {
    {name = "Upgraded Titan Speakerman", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Upgraded Titan Speakerman2", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman"},
    {name = "Upgraded Titan Speakerman3", gold = 2000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman2"},
    {name = "Upgraded Titan Speakerman4", gold = 4000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman3"},
    {name = "Upgraded Titan Speakerman5", gold = 6000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman4"}
}
    -- ลูปทำงานตลอดจนกว่าจะไม่สามารถอัปเกรดได้
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- เพิ่มค่า i เพื่อไปที่การอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาทีแล้วลองใหม่
    end
end

local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

-- ฟังก์ชันสำหรับตรวจสอบ Gold
local function hasEnoughGold(amount)
    local playerStats = workspace.PlayerStats:FindFirstChild(player.Name)
    if playerStats and playerStats:FindFirstChild("Gold") then
        if playerStats.Gold.Value >= amount then
            return true
        end
    end
    return false
end

-- ฟังก์ชันสำหรับส่งคำสั่ง ChangeMode
local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

local upgrades = {
    {name = "Upgraded Titan Speakerman", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Upgraded Titan Speakerman2", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman"},
    {name = "Upgraded Titan Speakerman3", gold = 2000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman2"},
    {name = "Upgraded Titan Speakerman4", gold = 4000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman3"},
    {name = "Upgraded Titan Speakerman5", gold = 6000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman4"}
}
    -- ลูปทำงานตลอดจนกว่าจะไม่สามารถอัปเกรดได้
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- เพิ่มค่า i เพื่อไปที่การอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาทีแล้วลองใหม่
    end
end

local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

-- ฟังก์ชันสำหรับตรวจสอบ Gold
local function hasEnoughGold(amount)
    local playerStats = workspace.PlayerStats:FindFirstChild(player.Name)
    if playerStats and playerStats:FindFirstChild("Gold") then
        if playerStats.Gold.Value >= amount then
            return true
        end
    end
    return false
end

-- ฟังก์ชันสำหรับส่งคำสั่ง ChangeMode
local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

local upgrades = {
    {name = "Upgraded Titan Speakerman", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Upgraded Titan Speakerman2", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman"},
    {name = "Upgraded Titan Speakerman3", gold = 2000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman2"},
    {name = "Upgraded Titan Speakerman4", gold = 4000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman3"},
    {name = "Upgraded Titan Speakerman5", gold = 6000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman4"}
}
    -- ลูปทำงานตลอดจนกว่าจะไม่สามารถอัปเกรดได้
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- เพิ่มค่า i เพื่อไปที่การอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาทีแล้วลองใหม่
    end
end

local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

-- ฟังก์ชันสำหรับตรวจสอบ Gold
local function hasEnoughGold(amount)
    local playerStats = workspace.PlayerStats:FindFirstChild(player.Name)
    if playerStats and playerStats:FindFirstChild("Gold") then
        if playerStats.Gold.Value >= amount then
            return true
        end
    end
    return false
end

-- ฟังก์ชันสำหรับส่งคำสั่ง ChangeMode
local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

local upgrades = {
    {name = "Upgraded Titan Speakerman", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Upgraded Titan Speakerman2", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman"},
    {name = "Upgraded Titan Speakerman3", gold = 2000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman2"},
    {name = "Upgraded Titan Speakerman4", gold = 4000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman3"},
    {name = "Upgraded Titan Speakerman5", gold = 6000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman4"}
}
    -- ลูปทำงานตลอดจนกว่าจะไม่สามารถอัปเกรดได้
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- เพิ่มค่า i เพื่อไปที่การอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาทีแล้วลองใหม่
    end
end

local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

-- ฟังก์ชันสำหรับตรวจสอบ Gold
local function hasEnoughGold(amount)
    local playerStats = workspace.PlayerStats:FindFirstChild(player.Name)
    if playerStats and playerStats:FindFirstChild("Gold") then
        if playerStats.Gold.Value >= amount then
            return true
        end
    end
    return false
end

-- ฟังก์ชันสำหรับส่งคำสั่ง ChangeMode
local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

local upgrades = {
    {name = "Upgraded Titan Speakerman", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Upgraded Titan Speakerman2", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman"},
    {name = "Upgraded Titan Speakerman3", gold = 2000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman2"},
    {name = "Upgraded Titan Speakerman4", gold = 4000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman3"},
    {name = "Upgraded Titan Speakerman5", gold = 6000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman4"}
}
    -- ลูปทำงานตลอดจนกว่าจะไม่สามารถอัปเกรดได้
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- เพิ่มค่า i เพื่อไปที่การอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาทีแล้วลองใหม่
    end
end

local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

-- ฟังก์ชันสำหรับตรวจสอบ Gold
local function hasEnoughGold(amount)
    local playerStats = workspace.PlayerStats:FindFirstChild(player.Name)
    if playerStats and playerStats:FindFirstChild("Gold") then
        if playerStats.Gold.Value >= amount then
            return true
        end
    end
    return false
end

-- ฟังก์ชันสำหรับส่งคำสั่ง ChangeMode
local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

local upgrades = {
    {name = "Upgraded Titan Speakerman", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Upgraded Titan Speakerman2", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman"},
    {name = "Upgraded Titan Speakerman3", gold = 2000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman2"},
    {name = "Upgraded Titan Speakerman4", gold = 4000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman3"},
    {name = "Upgraded Titan Speakerman5", gold = 6000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman4"}
}
    -- ลูปทำงานตลอดจนกว่าจะไม่สามารถอัปเกรดได้
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- เพิ่มค่า i เพื่อไปที่การอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาทีแล้วลองใหม่
    end
end

local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

-- ฟังก์ชันสำหรับตรวจสอบ Gold
local function hasEnoughGold(amount)
    local playerStats = workspace.PlayerStats:FindFirstChild(player.Name)
    if playerStats and playerStats:FindFirstChild("Gold") then
        if playerStats.Gold.Value >= amount then
            return true
        end
    end
    return false
end

-- ฟังก์ชันสำหรับส่งคำสั่ง ChangeMode
local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

local upgrades = {
    {name = "Upgraded Titan Speakerman", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Upgraded Titan Speakerman2", gold = 1000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman"},
    {name = "Upgraded Titan Speakerman3", gold = 2000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman2"},
    {name = "Upgraded Titan Speakerman4", gold = 4000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman3"},
    {name = "Upgraded Titan Speakerman5", gold = 6000, position = CFrame.new(3.23119831, -33.6337891, -18.9258442, 1, 0, 0, 0, 1, 0, 0, 0, 1), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman4"}
}
    -- ลูปทำงานตลอดจนกว่าจะไม่สามารถอัปเกรดได้
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- เพิ่มค่า i เพื่อไปที่การอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาทีแล้วลองใหม่
    end
end
