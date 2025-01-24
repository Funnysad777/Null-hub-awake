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
    badgeText.Text = "Null Hub"
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
    {name = "ScarySpeakerman", gold = 200, position = CFrame.new(-64.4728546, -34.0955658, -17.6681023, -0.999657393, -1.10892922e-08, 0.0261741541, -1.09862253e-08, 1, 4.08153733e-09, -0.0261741541, 3.79258358e-09, -0.999657393), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "ScarySpeakerman2", gold = 350, position = CFrame.new(-64.4728546, -34.0955658, -17.6681023, -0.999657393, -1.10892922e-08, 0.0261741541, -1.09862253e-08, 1, 4.08153733e-09, -0.0261741541, 3.79258358e-09, -0.999657393), angles = CFrame.Angles(0, 0, 0), tower = "ScarySpeakerman2"},
    {name = "ScarySpeakerman3", gold = 550, position = CFrame.new(-64.4728546, -34.0955658, -17.6681023, -0.999657393, -1.10892922e-08, 0.0261741541, -1.09862253e-08, 1, 4.08153733e-09, -0.0261741541, 3.79258358e-09, -0.999657393), angles = CFrame.Angles(0, 0, 0), tower = "ScarySpeakerman3"},
    {name = "ScarySpeakerman4", gold = 700, position = CFrame.new(-64.4728546, -34.0955658, -17.6681023, -0.999657393, -1.10892922e-08, 0.0261741541, -1.09862253e-08, 1, 4.08153733e-09, -0.0261741541, 3.79258358e-09, -0.999657393), angles = CFrame.Angles(0, 0, 0), tower = "ScarySpeakerman4"}
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
