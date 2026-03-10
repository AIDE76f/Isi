-- LocalScript داخل StarterGui أو أي مكان يناسبك

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- إنشاء الشاشة الرئيسية للرسم (لـ ESP)
local espDrawings = {}

-- متغيرات الحالة
local aimbotEnabled = false
local smoothAimValue = 50  -- القيمة الافتراضية
local espEnabled = false

-- إنشاء واجهة المستخدم (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RaivlsMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.new(0, 0, 0)
mainFrame.Active = true
mainFrame.Draggable = true  -- جعل الإطار قابلاً للتحريك
mainFrame.Parent = screenGui

-- عنوان
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleLabel.Text = "Raivls Menu"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.Parent = mainFrame

-- قائمة AIMBOT
local aimbotLabel = Instance.new("TextLabel")
aimbotLabel.Size = UDim2.new(1, -10, 0, 25)
aimbotLabel.Position = UDim2.new(0, 5, 0, 35)
aimbotLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
aimbotLabel.Text = "AIMBOT"
aimbotLabel.TextColor3 = Color3.new(1, 1, 1)
aimbotLabel.Font = Enum.Font.GothamSemibold
aimbotLabel.TextSize = 16
aimbotLabel.Parent = mainFrame

-- زر تبديل AIMBOT
local aimbotToggleFrame = Instance.new("Frame")
aimbotToggleFrame.Size = UDim2.new(0, 100, 0, 25)
aimbotToggleFrame.Position = UDim2.new(1, -110, 0, 35)
aimbotToggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
aimbotToggleFrame.Parent = mainFrame

local aimbotToggleButton = Instance.new("TextButton")
aimbotToggleButton.Size = UDim2.new(0, 25, 0, 25)
aimbotToggleButton.Position = UDim2.new(1, -30, 0, 0)
aimbotToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- أحمر (معطل)
aimbotToggleButton.Text = ""
aimbotToggleButton.Parent = aimbotToggleFrame

local aimbotToggleLabel = Instance.new("TextLabel")
aimbotToggleLabel.Size = UDim2.new(1, -30, 1, 0)
aimbotToggleLabel.Position = UDim2.new(0, 0, 0, 0)
aimbotToggleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0, 0)
aimbotToggleLabel.Text = "AIMBOT"
aimbotToggleLabel.TextColor3 = Color3.new(1, 1, 1)
aimbotToggleLabel.Font = Enum.Font.Gotham
aimbotToggleLabel.TextSize = 14
aimbotToggleLabel.Parent = aimbotToggleFrame

-- شريط التمرير Smooth AIM
local smoothLabel = Instance.new("TextLabel")
smoothLabel.Size = UDim2.new(0, 100, 0, 20)
smoothLabel.Position = UDim2.new(0, 10, 0, 70)
smoothLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0, 0)
smoothLabel.Text = "Smooth AIM:"
smoothLabel.TextColor3 = Color3.new(1, 1, 1)
smoothLabel.Font = Enum.Font.Gotham
smoothLabel.TextSize = 14
smoothLabel.TextXAlignment = Enum.TextXAlignment.Left
smoothLabel.Parent = mainFrame

local smoothSlider = Instance.new("Frame")
smoothSlider.Size = UDim2.new(0, 150, 0, 20)
smoothSlider.Position = UDim2.new(0, 120, 0, 70)
smoothSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
smoothSlider.Parent = mainFrame

local smoothSliderButton = Instance.new("TextButton")
smoothSliderButton.Size = UDim2.new(0, 10, 1, 0)
smoothSliderButton.Position = UDim2.new((smoothAimValue - 1) / 99, 0, 0, 0)  -- نسبة حسب القيمة
smoothSliderButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
smoothSliderButton.Text = ""
smoothSliderButton.Parent = smoothSlider

local smoothValueLabel = Instance.new("TextLabel")
smoothValueLabel.Size = UDim2.new(0, 30, 0, 20)
smoothValueLabel.Position = UDim2.new(1, -35, 0, 70)
smoothValueLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
smoothValueLabel.Text = tostring(smoothAimValue)
smoothValueLabel.TextColor3 = Color3.new(1, 1, 1)
smoothValueLabel.Font = Enum.Font.Gotham
smoothValueLabel.TextSize = 12
smoothValueLabel.Parent = mainFrame

-- قائمة ESP
local espLabel = Instance.new("TextLabel")
espLabel.Size = UDim2.new(1, -10, 0, 25)
espLabel.Position = UDim2.new(0, 5, 0, 100)
espLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espLabel.Text = "ESP"
espLabel.TextColor3 = Color3.new(1, 1, 1)
espLabel.Font = Enum.Font.GothamSemibold
espLabel.TextSize = 16
espLabel.Parent = mainFrame

-- زر تبديل ESP
local espToggleFrame = Instance.new("Frame")
espToggleFrame.Size = UDim2.new(0, 100, 0, 25)
espToggleFrame.Position = UDim2.new(1, -110, 0, 100)
espToggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espToggleFrame.Parent = mainFrame

local espToggleButton = Instance.new("TextButton")
espToggleButton.Size = UDim2.new(0, 25, 0, 25)
espToggleButton.Position = UDim2.new(1, -30, 0, 0)
espToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- أحمر (معطل)
espToggleButton.Text = ""
espToggleButton.Parent = espToggleFrame

local espToggleLabel = Instance.new("TextLabel")
espToggleLabel.Size = UDim2.new(1, -30, 1, 0)
espToggleLabel.Position = UDim2.new(0, 0, 0, 0)
espToggleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0, 0)
espToggleLabel.Text = "ESP"
espToggleLabel.TextColor3 = Color3.new(1, 1, 1)
espToggleLabel.Font = Enum.Font.Gotham
espToggleLabel.TextSize = 14
espToggleLabel.Parent = espToggleFrame

-- وظائف التبديل
aimbotToggleButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        aimbotToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- أخضر
    else
        aimbotToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- أحمر
    end
end)

espToggleButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        espToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- أخضر
        -- بدء رسم ESP
        espLoop()
    else
        espToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- أحمر
        -- مسح الرسومات
        clearESP()
    end
end)

-- وظيفة شريط التمرير
local dragging = false
smoothSliderButton.MouseButton1Down:Connect(function()
    dragging = true
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if dragging then
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        local sliderPos = smoothSlider.AbsolutePosition.X
        local sliderSize = smoothSlider.AbsoluteSize.X
        local relativeX = math.clamp(mousePos.X - sliderPos, 0, sliderSize)
        local newValue = math.floor((relativeX / sliderSize) * 99) + 1
        smoothAimValue = math.clamp(newValue, 1, 100)
        smoothSliderButton.Position = UDim2.new((smoothAimValue - 1) / 99, 0, 0, 0)
        smoothValueLabel.Text = tostring(smoothAimValue)
    end
end)

-- وظائف AIMBOT (مثال بسيط)
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotEnabled then
        -- البحث عن أقرب عدو (يمكن تعديل حسب آلية اللعبة)
        local closestPlayer = getClosestEnemy()
        if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPart = closestPlayer.Character.HumanoidRootPart
            local targetPos = targetPart.Position
            local cameraPos = camera.CFrame.Position
            local direction = (targetPos - cameraPos).unit
            local smoothFactor = smoothAimValue / 100  -- 0.01 إلى 1.0 (كلما زاد كان أسرع)
            -- تطبيق Smooth Aim عن طريق تدوير الكاميرا تدريجياً
            local newCFrame = CFrame.lookAt(cameraPos, cameraPos + direction)
            camera.CFrame = camera.CFrame:Lerp(newCFrame, smoothFactor)
        end
    end
end)

-- دالة للعثور على أقرب عدو (مثال: جميع اللاعبين غير صاحب السكربت)
function getClosestEnemy()
    local closest = nil
    local shortestDistance = math.huge
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (otherPlayer.Character.HumanoidRootPart.Position - camera.CFrame.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closest = otherPlayer
            end
        end
    end
    return closest
end

-- وظائف ESP
function createESPForPlayer(plr)
    if not plr.Character then return end
    local character = plr.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    if not rootPart or not humanoid then return end

    -- إنشاء مربع (Box) حول اللاعب
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.new(1, 0, 0)  -- أحمر
    box.Thickness = 2
    box.Filled = false

    -- شريط الصحة (عمودي)
    local healthBar = Drawing.new("Square")
    healthBar.Visible = false
    healthBar.Color = Color3.new(0, 1, 0)  -- أخضر
    healthBar.Thickness = 1
    healthBar.Filled = true

    -- حفظ الرسم في جدول مرتبط باللاعب
    espDrawings[plr] = {
        box = box,
        healthBar = healthBar,
        rootPart = rootPart,
        humanoid = humanoid
    }
end

function updateESP()
    for plr, drawings in pairs(espDrawings) do
        if plr.Parent ~= game.Players or not plr.Character or not drawings.rootPart.Parent then
            -- إذا خرج اللاعب أو مات، نمسح الرسومات
            drawings.box:Remove()
            drawings.healthBar:Remove()
            espDrawings[plr] = nil
        else
            -- تحديث موقع المربع وشريط الصحة
            local rootPos = drawings.rootPart.Position
            local vector, onScreen = camera:WorldToViewportPoint(rootPos)
            if onScreen then
                -- حجم المربع يعتمد على المسافة
                local distance = (rootPos - camera.CFrame.Position).magnitude
                local scale = 500 / distance
                local boxSize = Vector2.new(40 * scale, 60 * scale)  -- عرض وارتفاع تقريبي
                local boxPos = Vector2.new(vector.X - boxSize.X / 2, vector.Y - boxSize.Y / 2)

                -- رسم المربع
                drawings.box.Visible = true
                drawings.box.Position = boxPos
                drawings.box.Size = boxSize

                -- رسم شريط الصحة (عمودي على يسار المربع)
                local healthPercent = drawings.humanoid.Health / drawings.humanoid.MaxHealth
                local healthBarSize = Vector2.new(5 * scale, boxSize.Y * healthPercent)
                local healthBarPos = Vector2.new(boxPos.X - 7 * scale, boxPos.Y + boxSize.Y - healthBarSize.Y)

                drawings.healthBar.Visible = true
                drawings.healthBar.Position = healthBarPos
                drawings.healthBar.Size = healthBarSize
                -- لون الشريط حسب نسبة الصحة
                drawings.healthBar.Color = Color3.new(1 - healthPercent, healthPercent, 0)
            else
                drawings.box.Visible = false
                drawings.healthBar.Visible = false
            end
        end
    end
end

function clearESP()
    for _, drawings in pairs(espDrawings) do
        drawings.box:Remove()
        drawings.healthBar:Remove()
    end
    espDrawings = {}
end

function espLoop()
    -- دورة ESP: تحديث مستمر
    spawn(function()
        while espEnabled do
            -- إضافة رسومات للاعبين الجدد
            for _, plr in ipairs(game.Players:GetPlayers()) do
                if plr ~= player and not espDrawings[plr] then
                    createESPForPlayer(plr)
                end
            end
            -- تحديث الرسومات
            updateESP()
            wait(0.05)  -- تحديث كل 0.05 ثانية
        end
    end)
end

-- عند إضافة لاعب جديد أثناء تشغيل ESP
game.Players.PlayerAdded:Connect(function(plr)
    if espEnabled then
        createESPForPlayer(plr)
    end
end)

-- عند خروج لاعب
game.Players.PlayerRemoving:Connect(function(plr)
    if espDrawings[plr] then
        espDrawings[plr].box:Remove()
        espDrawings[plr].healthBar:Remove()
        espDrawings[plr] = nil
    end
end)

-- إغلاق السكربت عند الحذف (اختياري)
screenGui.Destroying:Connect(function()
    clearESP()
end)
