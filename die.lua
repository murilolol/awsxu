-- STEAL HUB: Made by ShedlteskySword

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- ✅ KEY SYSTEM
local correctKey = "Tripa tropa TRALALA liririla Tung Tung Sahur boneca Tung Tung tralalelo tripa tropa crocodina"

local function requestKey()
    local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
    ScreenGui.Name = "KeyGui"

    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 400, 0, 150)
    Frame.Position = UDim2.new(0.5, -200, 0.5, -75)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BorderSizePixel = 0

    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.Text = "Digite a KEY para ativar o script:"
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 18

    local TextBox = Instance.new("TextBox", Frame)
    TextBox.Size = UDim2.new(1, -40, 0, 40)
    TextBox.Position = UDim2.new(0, 20, 0, 40)
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 16
    TextBox.TextColor3 = Color3.new(1, 1, 1)
    TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TextBox.Text = ""

    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(0, 100, 0, 35)
    Button.Position = UDim2.new(0.5, -50, 1, -40)
    Button.Text = "Confirmar"
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 16
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.TextColor3 = Color3.new(1, 1, 1)

    local confirmed = false
    Button.MouseButton1Click:Connect(function()
        if TextBox.Text == correctKey then
            confirmed = true
            ScreenGui:Destroy()
        else
            LocalPlayer:Kick("KEY incorreta.")
        end
    end)

    repeat wait() until confirmed
end

requestKey()

-- ✅ Verificação de HttpGet
local function httpCheck()
    local ok, result = pcall(function()
        return game:HttpGet("https://www.google.com/")
    end)
    if not ok or not result then
        LocalPlayer:Kick("Seu executor não suporta HttpGet.")
    end
end

httpCheck()

-- ✅ Carrega Rayfield UI
getgenv().SecureMode = true
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
    Name = "STEAL HUB",
    LoadingTitle = "Carregando...",
    LoadingSubtitle = "By ShedlteskySword",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = { Enabled = false },
    KeySystem = false
})

local Tab = Window:CreateTab("Main")
local AutoSteal = false
local ESP_Enabled = false
local ServerHopper = false

-- ✅ Auto Steal
Tab:CreateToggle({
    Name = "Auto Steal",
    CurrentValue = false,
    Callback = function(Value)
        AutoSteal = Value
    end
})

-- ✅ ESP de Brainrot secreto
Tab:CreateToggle({
    Name = "ESP Secreto",
    CurrentValue = false,
    Callback = function(Value)
        ESP_Enabled = Value
    end
})

-- ✅ Server Hopper
Tab:CreateButton({
    Name = "Procurar Server com Brainrot Secreto",
    Callback = function()
        ServerHopper = true
    end
})

-- ✅ TP 5 studs para frente com tecla T
UIS.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.T then
        local hrp = Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 5
        end
    end
end)

-- ✅ Loop Auto Steal
RunService.RenderStepped:Connect(function()
    if AutoSteal then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "Brainrot" and obj:IsA("Part") then
                local dist = (obj.Position - Character:WaitForChild("HumanoidRootPart").Position).Magnitude
                if dist <= 10 then
                    local prompt = obj:FindFirstChildWhichIsA("ProximityPrompt")
                    if prompt then
                        fireproximityprompt(prompt)
                    end
                end
            end
        end
    end
end)

-- ✅ ESP Secreto
RunService.RenderStepped:Connect(function()
    if ESP_Enabled then
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("Part") and part.Name == "Brainrot" and not part:FindFirstChild("ESP") then
                local rarity = part:FindFirstChild("Rarity")
                if rarity and rarity:IsA("StringValue") and string.lower(rarity.Value) == "secret" then
                    local bill = Instance.new("BillboardGui", part)
                    bill.Name = "ESP"
                    bill.Size = UDim2.new(0, 100, 0, 40)
                    bill.AlwaysOnTop = true
                    bill.Adornee = part
                    local text = Instance.new("TextLabel", bill)
                    text.Size = UDim2.new(1, 0, 1, 0)
                    text.Text = "🔍 Secreto"
                    text.TextColor3 = Color3.new(1, 0, 1)
                    text.BackgroundTransparency = 1
                    text.TextScaled = true
                end
            end
        end
    end
end)

-- ✅ Server Hopper secreto
task.spawn(function()
    local checked = {}
    while task.wait(2) do
        if ServerHopper then
            -- Procura Brainrot secreto
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Brainrot" and obj:IsA("Part") then
                    local rarity = obj:FindFirstChild("Rarity")
                    if rarity and string.lower(rarity.Value) == "secret" then
                        warn("✅ Secreto encontrado.")
                        ServerHopper = false
                        return
                    end
                end
            end

            -- Hopper
            local place = game.PlaceId
            local url = "https://games.roblox.com/v1/games/" .. place .. "/servers/Public?sortOrder=Asc&limit=100"
            local success, res = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(url))
            end)
            if success and res and res.data then
                for _, server in pairs(res.data) do
                    if server.id ~= game.JobId and not checked[server.id] then
                        checked[server.id] = true
                        TeleportService:TeleportToPlaceInstance(place, server.id, LocalPlayer)
                        return
                    end
                end
            end
        end
    end
end)
