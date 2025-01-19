local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local label = Instance.new("TextLabel")

screenGui.Parent = game.Players.LocalPlayer.PlayerGui
screenGui.Name = "FakeSealGui"

frame.Parent = screenGui
frame.Size = UDim2.new(0, 200, 0, 200)
frame.Position = UDim2.new(0.5, -100, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.Visible = false  -- ซ่อนเริ่มต้น

label.Parent = frame
label.Size = UDim2.new(1, 0, 1, 0)
label.Text = "Null hub"
label.TextColor3 = Color3.fromRGB(0, 0, 0)
label.TextSize = 30
label.TextAlign = Enum.TextAlign.Center
label.Font = Enum.Font.GothamBold

-- อนิเมชันเข้ามา
local enterTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
local enterTween = TweenService:Create(frame, enterTweenInfo, {Position = UDim2.new(0.5, -100, 0.5, -100), Visible = true})

-- อนิเมชันออก
local exitTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.In)
local exitTween = TweenService:Create(frame, exitTweenInfo, {Position = UDim2.new(0.5, -100, 0.5, -200), Visible = false})

-- ใช้อนิเมชันเมื่อเข้า
enterTween:Play()

-- ให้อนิเมชันออกหลังจาก 3 วินาที
wait(3)
exitTween:Play()

local args = {
    [1] = "Nightmare"
}

game:GetService("ReplicatedStorage").Events.VoteForMap:FireServer(unpack(args))

wait(13)
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

wait(10)
local player = game.Players.LocalPlayer -- สมมติว่าคุณใช้ LocalPlayer

local function hasEnoughGold(amount)
    local playerStats = workspace.PlayerStats:FindFirstChild(player.Name)
    if playerStats and playerStats:FindFirstChild("Gold") then
        if playerStats.Gold.Value >= amount then
            return true
        end
    end
    return false
end

local function changeMode(name, position, angles, towerName)
    local args = {
        [1] = name,
        [2] = position * angles,
        [3] = towerName and workspace.Towers:FindFirstChild(towerName) or nil
    }
    game:GetService("ReplicatedStorage").Functions.ChangeMode:InvokeServer(unpack(args))
end

local upgrades = {
    {name = "Dark Speakerman", gold = 150, position = CFrame.new(-72.76365661621094, -15.121337890625, -59.39636993408203), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Dark Speakerman2", gold = 100, position = CFrame.new(-72.76365661621094, -15.121337890625, -59.39636993408203), angles = CFrame.Angles(0, 0, 0), tower = "Dark Speakerman"},
    {name = "Dark Speakerman3", gold = 200, position = CFrame.new(-72.76365661621094, -15.121337890625, -59.39636993408203), angles = CFrame.Angles(0, 0, 0), tower = "Dark Speakerman2"},
    {name = "Dark Speakerman4", gold = 300, position = CFrame.new(-72.76365661621094, -15.121337890625, -59.39636993408203), angles = CFrame.Angles(0, 0, 0), tower = "Dark Speakerman3"},
    {name = "Dark Speakerman5", gold = 400, position = CFrame.new(-72.76365661621094, -15.121337890625, -59.39636993408203), angles = CFrame.Angles(0, 0, 0), tower = "Dark Speakerman4"}
}

local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1)
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

-- ตารางการอัปเกรด
local upgrades = {
    {name = "Scientist Cameraman", gold = 100, position = CFrame.new(-82.7974853515625, -15.121337890625, -52.27956008911133), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Scientist Cameraman2", gold = 300, position = CFrame.new(-82.7974853515625, -15.121337890625, -52.27956008911133), angles = CFrame.Angles(0, 0, 0), tower = "Scientist Cameraman"},
    {name = "Scientist Cameraman3", gold = 600, position = CFrame.new(-82.7974853515625, -15.121337890625, -52.27956008911133), angles = CFrame.Angles(0, 0, 0), tower = "Scientist Cameraman2"},
    {name = "Scientist Cameraman4", gold = 1000, position = CFrame.new(-82.7974853515625, -15.121337890625, -52.27956008911133), angles = CFrame.Angles(0, 0, 0), tower = "Scientist Cameraman3"},
    {name = "Scientist Cameraman5", gold = 2000, position = CFrame.new(-82.7974853515625, -15.121337890625, -52.27956008911133), angles = CFrame.Angles(0, 0, 0), tower = "Scientist Cameraman4"},
    {name = "Scientist Cameraman6", gold = 5000, position = CFrame.new(-82.7974853515625, -15.121337890625, -52.27956008911133), angles = CFrame.Angles(0, 0, 0), tower = "Scientist Cameraman5"}
}

-- ลูปการอัปเกรด
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- ไปยังการอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาที
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

-- ตารางการอัปเกรด
local upgrades = {
    {name = "Upgraded Titan Speakerman", gold = 1000, position = CFrame.new(-89.4161605834961, -9.581405639648438, -56.570579528808594), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Upgraded Titan Speakerman2", gold = 600, position = CFrame.new(-89.4161605834961, -9.581405639648438, -56.570579528808594), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman"},
    {name = "Upgraded Titan Speakerman3", gold = 2000, position = CFrame.new(-89.4161605834961, -9.581405639648438, -56.570579528808594), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman2"},
    {name = "Upgraded Titan Speakerman4", gold = 4000, position = CFrame.new(-89.4161605834961, -9.581405639648438, -56.570579528808594), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman3"},
    {name = "Upgraded Titan Speakerman5", gold = 6000, position = CFrame.new(-89.4161605834961, -9.581405639648438, -56.570579528808594), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Speakerman4"}
}

-- ลูปการอัปเกรด
local i = 1
while i <= #upgrades do
    local upgrade = upgrades[i]
    if hasEnoughGold(upgrade.gold) then
        changeMode(upgrade.name, upgrade.position, upgrade.angles, upgrade.tower)
        print("ทำการอัปเกรด " .. upgrade.name)
        i = i + 1 -- ไปยังการอัปเกรดถัดไป
    else
        print("ไม่พอ Gold สำหรับการอัปเกรด " .. upgrade.name)
        wait(1) -- รอ 1 วินาที
    end
end
