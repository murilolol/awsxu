-- 🩷 Murilo HUB v9.5 | Versão Final - CORRIGIDO

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer

if player.PlayerGui:FindFirstChild("Murilo_HUB") then
 player.PlayerGui.Murilo_HUB:Destroy()
end

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "Murilo_HUB"
gui.ResetOnSpawn = false

local accent = Color3.fromRGB(0, 0, 0) -- Preto
local bg = Color3.fromRGB(0, 0, 0) -- Preto
local white = Color3.fromRGB(255, 255, 255) -- Branco

-- Variáveis Globais
local espEnabled = false
local noclipEnabled = false
local infiniteYieldEnabled = false
local flyEnabled = false
local fullbrightEnabled = false
local godModeEnabled = false
local flySpeed = 50
local noclipConnection
local flyConnection
local godModeConnection
local flyBodyVelocity
local flyBodyPosition
local lastValidPosition

-- Carregando Interface
local loading = Instance.new("Frame", gui)
loading.Size = UDim2.new(0, 300, 0, 150)
loading.Position = UDim2.new(0.5, -150, 0.5, -75)
loading.BackgroundColor3 = bg
loading.BackgroundTransparency = 0.2
loading.BorderSizePixel = 0
Instance.new("UICorner", loading).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", loading)
title.Size = UDim2.new(1, 0, 0.5, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🩷 Murilo HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = white

local subtitle = Instance.new("TextLabel", loading)
subtitle.Size = UDim2.new(1, 0, 0.5, 0)
subtitle.Position = UDim2.new(0, 0, 0.5, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Carregando... Por favor, aguarde"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)

wait(2)
TweenService:Create(loading, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(title, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
TweenService:Create(subtitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
wait(0.6)
loading:Destroy()

-- Notificação
pcall(function()
 StarterGui:SetCore("SendNotification", {
  Title = "🩷 Murilo HUB",
  Text = "Aproveite o Murilo HUB!",
  Duration = 5
 })
end)

-- Botão de Abrir
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 130, 0, 50)
openBtn.Position = UDim2.new(0, 20, 0.5, -25)
openBtn.BackgroundColor3 = bg
openBtn.Text = "🩷 Murilo HUB"
openBtn.TextColor3 = white
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 16
openBtn.Draggable = true
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 12)

-- Janela Principal
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 500, 0, 380)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -190)
mainFrame.BackgroundColor3 = bg
mainFrame.BackgroundTransparency = 0.2
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

-- Cabeçalho
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = accent
header.BackgroundTransparency = 0.3
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 14)

local headerLabel = Instance.new("TextLabel", header)
headerLabel.Size = UDim2.new(1, -60, 1, 0)
headerLabel.Position = UDim2.new(0, 10, 0, 0)
headerLabel.Text = "🩷 Murilo HUB"
headerLabel.TextColor3 = white
headerLabel.Font = Enum.Font.GothamBold
headerLabel.TextSize = 20
headerLabel.BackgroundTransparency = 1

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0.5, -20)
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = white
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function()
 mainFrame.Visible = false
end)

-- Abas + Conteúdo
local tabFrame = Instance.new("Frame", mainFrame)
tabFrame.Size = UDim2.new(0, 100, 1, -60)
tabFrame.Position = UDim2.new(0, 5, 0, 55)
tabFrame.BackgroundTransparency = 1

local tabLayout = Instance.new("UIListLayout", tabFrame)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 5)

local contentFrame = Instance.new("ScrollingFrame", mainFrame)
contentFrame.Size = UDim2.new(1, -115, 1, -70)
contentFrame.Position = UDim2.new(0, 110, 0, 60)
contentFrame.BackgroundTransparency = 1
contentFrame.ScrollBarThickness = 4
contentFrame.ScrollBarImageColor3 = accent
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

Instance.new("UIListLayout", contentFrame).Padding = UDim.new(0, 10)

local currentTab

local function createTab(name, icon, callback)
 local tab = Instance.new("TextButton", tabFrame)
 tab.Size = UDim2.new(1, 0, 0, 35)
 tab.Text = icon .. " " .. name
 tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
 tab.TextColor3 = white
 tab.Font = Enum.Font.GothamBold
 tab.TextSize = 12
 Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 10)

 tab.MouseButton1Click:Connect(function()
  if currentTab then currentTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30) end
  currentTab = tab
  tab.BackgroundColor3 = accent

  for _, child in pairs(contentFrame:GetChildren()) do
   if not child:IsA("UIListLayout") then child:Destroy() end
  end

  if callback then callback() end
 end)

 return tab
end

local function createToggle(name, callback, initialState)
 local container = Instance.new("Frame", contentFrame)
 container.Size = UDim2.new(1, 0, 0, 45)
 container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
 Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

 local label = Instance.new("TextLabel", container)
 label.Size = UDim2.new(1, -80, 1, 0)
 label.Position = UDim2.new(0, 10, 0, 0)
 label.BackgroundTransparency = 1
 label.Text = name
 label.Font = Enum.Font.Gotham
 label.TextSize = 14
 label.TextColor3 = white
 label.TextXAlignment = Enum.TextXAlignment.Left

 local toggle = Instance.new("TextButton", container)
 toggle.Size = UDim2.new(0, 55, 0, 25)
 toggle.Position = UDim2.new(1, -65, 0.5, -12)
 toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
 toggle.Text = "DESLIGADO"
 toggle.TextColor3 = white
 toggle.Font = Enum.Font.GothamBold
 toggle.TextSize = 12
 Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

 -- Estado inicial
 local isOn = initialState or false
 if isOn then
  toggle.Text = "LIGADO"
  toggle.BackgroundColor3 = accent
 end

 toggle.MouseButton1Click:Connect(function()
  isOn = not isOn
  toggle.Text = isOn and "LIGADO" or "DESLIGADO"
  toggle.BackgroundColor3 = isOn and accent or Color3.fromRGB(60, 60, 60)
  if callback then callback(isOn) end
 end)

 return toggle
end

local function createButton(name, callback)
 local button = Instance.new("TextButton", contentFrame)
 button.Size = UDim2.new(1, 0, 0, 40)
 button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
 button.Text = name
 button.TextColor3 = white
 button.Font = Enum.Font.Gotham
 button.TextSize = 14
 Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
 button.MouseButton1Click:Connect(callback)
end

-- Função Noclip Aprimorada
local function toggleNoclip(state)
 noclipEnabled = state
 if noclipConnection then
  noclipConnection:Disconnect()
  noclipConnection = nil
 end
 
 if state then
  local character = player.Character
  if character then
   lastValidPosition = character.HumanoidRootPart.Position
  end
  
  noclipConnection = RunService.Stepped:Connect(function()
   local character = player.Character
   local rootPart = character and character:FindFirstChild("HumanoidRootPart")
   if character and rootPart then
    -- Desativa colisão para todas as partes
    for _, part in pairs(character:GetDescendants()) do
     if part:IsA("BasePart") then
      part.CanCollide = false
      part.CanTouch = false
     end
    end
    
    -- Verifica teleporte indesejado
    local currentPos = rootPart.Position
    if lastValidPosition and (currentPos - lastValidPosition).Magnitude > 50 then
     rootPart.CFrame = CFrame.new(lastValidPosition)
    else
     lastValidPosition = currentPos
    end
   end
  end)
 else
  local character = player.Character
  if character then
   for _, part in pairs(character:GetDescendants()) do
    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
     part.CanCollide = true
     part.CanTouch = true
    end
   end
  end
 end
end

-- Função God Mode
local function toggleGodMode(state)
 godModeEnabled = state
 if godModeConnection then
  godModeConnection:Disconnect()
  godModeConnection = nil
 end
 
 local character = player.Character
 local humanoid = character and character:FindFirstChildOfClass("Humanoid")
 
 if state and humanoid then
  humanoid.MaxHealth = math.huge
  humanoid.Health = math.huge
  humanoid.HealthDisplayDistance = 0 -- Oculta barra de vida
  
  godModeConnection = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
   if humanoid.Health < math.huge then
    humanoid.Health = math.huge
   end
  end)
 else
  if humanoid then
   humanoid.MaxHealth = 100
   humanoid.Health = 100
   humanoid.HealthDisplayDistance = 100
  end
 end
end

-- Função Voar
local function toggleFly(state)
 flyEnabled = state
 local character = player.Character
 local humanoid = character and character:FindFirstChildOfClass("Humanoid")
 local rootPart = character and character:FindFirstChild("HumanoidRootPart")
 
 if flyConnection then
  flyConnection:Disconnect()
  flyConnection = nil
 end
 
 if flyBodyVelocity then
  flyBodyVelocity:Destroy()
  flyBodyVelocity = nil
 end
 
 if flyBodyPosition then
  flyBodyPosition:Destroy()
  flyBodyPosition = nil
 end
 
 if state and rootPart then
  flyBodyVelocity = Instance.new("BodyVelocity")
  flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
  flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
  flyBodyVelocity.Parent = rootPart
  
  flyConnection = RunService.Heartbeat:Connect(function()
   local camera = workspace.CurrentCamera
   local moveVector = humanoid.MoveDirection
   local lookVector = camera.CFrame.LookVector
   local rightVector = camera.CFrame.RightVector
   
   local velocity = Vector3.new(0, 0, 0)
   
   if moveVector.Magnitude > 0 then
    velocity = (lookVector * moveVector.Z + rightVector * -moveVector.X) * flySpeed
   end
   
   flyBodyVelocity.Velocity = velocity
  end)
 end
end

-- Funções ESP
local function createESP(plr)
 if plr == player or not plr.Character or not plr.Character:FindFirstChild("Head") then return end
 
 local head = plr.Character.Head
 if head:FindFirstChild("PlayerESP") then return end
 
 local tag = Instance.new("BillboardGui", head)
 tag.Name = "PlayerESP"
 tag.Size = UDim2.new(0, 100, 0, 30)
 tag.AlwaysOnTop = true
 tag.StudsOffset = Vector3.new(0, 2, 0)

 local label = Instance.new("TextLabel", tag)
 label.Size = UDim2.new(1, 0, 1, 0)
 label.Text = plr.Name
 label.BackgroundTransparency = 1
 label.TextColor3 = accent
 label.TextStrokeTransparency = 0
 label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
 label.Font = Enum.Font.GothamBold
 label.TextScaled = true
end

local function removeESP(plr)
 if plr.Character and plr.Character:FindFirstChild("Head") then
  local esp = plr.Character.Head:FindFirstChild("PlayerESP")
  if esp then esp:Destroy() end
 end
end

local function updateAllESP()
 for _, plr in pairs(Players:GetPlayers()) do
  if plr ~= player then
   if espEnabled then
    createESP(plr)
   else
    removeESP(plr)
   end
  end
 end
end

local function loadPlayerTab()
 createToggle("🚫 Noclip", function(state)
  toggleNoclip(state)
 end, noclipEnabled)

 createToggle("🕊️ Voar", function(state)
  toggleFly(state)
 end, flyEnabled)

 createToggle("🛡️ Anti-Dano", function(state)
  toggleGodMode(state)
 end, godModeEnabled)

 createButton("🔄 Resetar Personagem", function()
  local char = player.Character
  if char and char:FindFirstChild("Humanoid") then
   char.Humanoid.Health = 0
  end
 end)
end

local function loadVisualTab()
 createToggle("👁 ESP de Jogadores", function(state)
  espEnabled = state
  updateAllESP()
 end, espEnabled)

 createToggle("💡 Iluminação Total", function(state)
  fullbrightEnabled = state
  if state then
   Lighting.ClockTime = 14
   Lighting.Brightness = 2
   Lighting.FogEnd = 100000
   Lighting.GlobalShadows = false
  else
   Lighting.ClockTime = 12
   Lighting.Brightness = 1
   Lighting.FogEnd = 100
   Lighting.GlobalShadows = true
  end
 end, fullbrightEnabled)
end

local function loadTeleportTab()
 createButton("⬆️ Teleportar para o Céu", function()
  local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
  if root then
   root.CFrame = CFrame.new(root.Position + Vector3.new(0, 200, 0))
  end
 end)

 createButton("⬇️ Cair", function()
  local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
  if root then
   root.CFrame = CFrame.new(root.Position - Vector3.new(0, 50, 0))
  end
 end)

 createButton("🏠 Teleportar para a Base", function()
  local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
  if root then
   local basePosition = Vector3.new(0, 5, 0) -- Ajuste para a posição correta da base
   root.CFrame = CFrame.new(basePosition)
  end
 end)
end

local function loadMiscTab()
 createButton("🔄 Reconectar", function()
  TeleportService:Teleport(game.PlaceId, player)
 end)

 createButton("📋 Copiar Link do Jogo", function()
  if setclipboard then
   setclipboard("https://www.roblox.com/games/" .. game.PlaceId)
  end
 end)
end

-- Abas
createTab("Jogador", "👤", loadPlayerTab)
createTab("Visual", "👁", loadVisualTab)
createTab("Teleporte", "📍", loadTeleportTab)
createTab("Diversos", "⚙️", loadMiscTab)

-- Mostrar Interface
openBtn.MouseButton1Click:Connect(function()
 mainFrame.Visible = not mainFrame.Visible
 if mainFrame.Visible and not currentTab then
  loadPlayerTab()
 end
end)

-- ESP para novos jogadores
Players.PlayerAdded:Connect(function(plr)
 plr.CharacterAdded:Connect(function()
  wait(1)
  if espEnabled then
   createESP(plr)
  end
 end)
end)

-- Lidar com saída de jogadores
Players.PlayerRemoving:Connect(function(plr)
 removeESP(plr)
end)

-- Lidar com respawn do personagem
player.CharacterAdded:Connect(function()
 wait(1)
 -- Reaplicar estados após respawn
 if noclipEnabled then
  toggleNoclip(true)
 end
 if flyEnabled then
  toggleFly(true)
 end
 if godModeEnabled then
  toggleGodMode(true)
 end
end)

-- Botão TP CÉU (⬆️)
local tpUpBtn = Instance.new("TextButton", gui)
tpUpBtn.Size = UDim2.new(0, 50, 0, 50)
tpUpBtn.Position = UDim2.new(1, -120, 1, -140)
tpUpBtn.BackgroundColor3 = bg
tpUpBtn.Text = "⬆️"
tpUpBtn.TextColor3 = white
tpUpBtn.Font = Enum.Font.GothamBold
tpUpBtn.TextSize = 20
tpUpBtn.Draggable = true
tpUpBtn.Active = true
Instance.new("UICorner", tpUpBtn).CornerRadius = UDim.new(0, 10)

tpUpBtn.MouseButton1Click:Connect(function()
 local char = player.Character
 if char and char:FindFirstChild("HumanoidRootPart") then
  local pos = char.HumanoidRootPart.Position
  char.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y + 200, pos.Z)
 end
end)

-- Botão CAIR (⬇️)
local tpDownBtn = Instance.new("TextButton", gui)
tpDownBtn.Size = UDim2.new(0, 50, 0, 50)
tpDownBtn.Position = UDim2.new(1, -60, 1, -140)
tpDownBtn.BackgroundColor3 = bg
tpDownBtn.Text = "⬇️"
tpDownBtn.TextColor3 = white
tpDownBtn.Font = Enum.Font.GothamBold
tpDownBtn.TextSize = 20
tpDownBtn.Draggable = true
tpDownBtn.Active = true
Instance.new("UICorner", tpDownBtn).CornerRadius = UDim.new(0, 10)

tpDownBtn.MouseButton1Click:Connect(function()
 local char = player.Character
 if char and char:FindFirstChild("HumanoidRootPart") then
  local pos = char.HumanoidRootPart.Position
  char.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y - 50, pos.Z)
 end
end)
