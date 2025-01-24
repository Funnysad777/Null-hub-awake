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
    {name = "ScarySpeakerman2", gold = 350, position = CFrame.new(-64.4728546, -34.0955658, -17.6681023, -0.999657393, -1.10892922e-08, 0.0261741541, -1.09862253e-08, 1, 4.08153733e-09, -0.0261741541, 3.79258358e-09, -0.999657393), angles = CFrame.Angles(0, 0, 0), tower = "ScarySpeakerman"},
    {name = "ScarySpeakerman3", gold = 550, position = CFrame.new(-64.4728546, -34.0955658, -17.6681023, -0.999657393, -1.10892922e-08, 0.0261741541, -1.09862253e-08, 1, 4.08153733e-09, -0.0261741541, 3.79258358e-09, -0.999657393), angles = CFrame.Angles(0, 0, 0), tower = "ScarySpeakerman2"},
    {name = "ScarySpeakerman4", gold = 700, position = CFrame.new(-64.4728546, -34.0955658, -17.6681023, -0.999657393, -1.10892922e-08, 0.0261741541, -1.09862253e-08, 1, 4.08153733e-09, -0.0261741541, 3.79258358e-09, -0.999657393), angles = CFrame.Angles(0, 0, 0), tower = "ScarySpeakerman3"}
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

wait(3)
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
    {name = "ScarySpeakerman2", gold = 350, position = CFrame.new(-64.4728546, -34.0955658, -17.6681023, -0.999657393, -1.10892922e-08, 0.0261741541, -1.09862253e-08, 1, 4.08153733e-09, -0.0261741541, 3.79258358e-09, -0.999657393), angles = CFrame.Angles(0, 0, 0), tower = "ScarySpeakerman"},
    {name = "ScarySpeakerman3", gold = 550, position = CFrame.new(-64.4728546, -34.0955658, -17.6681023, -0.999657393, -1.10892922e-08, 0.0261741541, -1.09862253e-08, 1, 4.08153733e-09, -0.0261741541, 3.79258358e-09, -0.999657393), angles = CFrame.Angles(0, 0, 0), tower = "ScarySpeakerman2"},
    {name = "ScarySpeakerman4", gold = 700, position = CFrame.new(-64.4728546, -34.0955658, -17.6681023, -0.999657393, -1.10892922e-08, 0.0261741541, -1.09862253e-08, 1, 4.08153733e-09, -0.0261741541, 3.79258358e-09, -0.999657393), angles = CFrame.Angles(0, 0, 0), tower = "ScarySpeakerman3"}
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

wait(3)
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
    {name = "PumpkinFarmer", gold = 200, position = CFrame.new(-99.6062698, -34.0955658, -0.0689644143, -0.947679281, -2.34635209e-08, 0.319224, -4.61523086e-08, 1, -6.35104627e-08, -0.319224, -7.49204787e-08, -0.947679281), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "PumpkinFarmer2", gold = 250, position = CFrame.new(-99.6062698, -34.0955658, -0.0689644143, -0.947679281, -2.34635209e-08, 0.319224, -4.61523086e-08, 1, -6.35104627e-08, -0.319224, -7.49204787e-08, -0.947679281), angles = CFrame.Angles(0, 0, 0), tower = "PumpkinFarmer"},
    {name = "PumpkinFarmer3", gold = 500, position = CFrame.new(-99.6062698, -34.0955658, -0.0689644143, -0.947679281, -2.34635209e-08, 0.319224, -4.61523086e-08, 1, -6.35104627e-08, -0.319224, -7.49204787e-08, -0.947679281), angles = CFrame.Angles(0, 0, 0), tower = "PumpkinFarmer2"},
    {name = "PumpkinFarmer4", gold = 750, position = CFrame.new(-99.6062698, -34.0955658, -0.0689644143, -0.947679281, -2.34635209e-08, 0.319224, -4.61523086e-08, 1, -6.35104627e-08, -0.319224, -7.49204787e-08, -0.947679281), angles = CFrame.Angles(0, 0, 0), tower = "PumpkinFarmer3"},
    {name = "PumpkinFarmer5", gold = 1500, position = CFrame.new(-99.6062698, -34.0955658, -0.0689644143, -0.947679281, -2.34635209e-08, 0.319224, -4.61523086e-08, 1, -6.35104627e-08, -0.319224, -7.49204787e-08, -0.947679281), angles = CFrame.Angles(0, 0, 0), tower = "PumpkinFarmer4"}
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
    {name = "Upgraded Titan Cameraman", gold = 1500, position = CFrame.new(-89.8586349, -34.0955658, -29.0876522), angles = CFrame.Angles(0, 0, 0), tower = nil},
    {name = "Upgraded Titan Cameraman2", gold = 3000, position = CFrame.new(-89.8586349, -34.0955658, -29.0876522), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Cameraman"},
    {name = "Upgraded Titan Cameraman3", gold = 4000, position = CFrame.new(-89.8586349, -34.0955658, -29.0876522), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Cameraman2"},
    {name = "Upgraded Titan Cameraman4", gold = 8000, position = CFrame.new(-89.8586349, -34.0955658, -29.0876522), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Cameraman3"},
    {name = "Upgraded Titan Cameraman5", gold = 10000, position = CFrame.new(-89.8586349, -34.0955658, -29.0876522), angles = CFrame.Angles(0, 0, 0), tower = "Upgraded Titan Cameraman4"}
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
