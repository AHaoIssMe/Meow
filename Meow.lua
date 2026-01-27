--===== CHATGPT HUB KEY SYSTEM =====--

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- FILE LƯU KEY
local KEY_FILE = "MEOWHub_Key.json"
local KEY_PREFIX = "FREE_MEOWHUB"

-- LOAD KEY ĐÃ LƯU
local savedKey = nil
pcall(function()
    if isfile(KEY_FILE) then
        local data = HttpService:JSONDecode(readfile(KEY_FILE))
        savedKey = data.key
    end
end)

-- CHECK KEY
local function isValidKey(key)
    return typeof(key) == "string"
        and key:sub(1, #KEY_PREFIX) == KEY_PREFIX
        and #key == #KEY_PREFIX + 15
end

-- ĐÃ CÓ KEY → CHO CHẠY LUÔN
if savedKey and isValidKey(savedKey) then
    warn("✔ Key hợp lệ, auto login")
else
    --===== UI NHẬP KEY =====--
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0,300,0,160)
    Frame.Position = UDim2.new(0.5,-150,0.5,-80)
    Frame.BackgroundColor3 = Color3.fromRGB(255,170,200)
    Frame.Active = true
    Frame.Draggable = true
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,16)

    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1,0,0,35)
    Title.Text = "🔑 KEY SYSTEM"
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255,20,147)

    local Box = Instance.new("TextBox", Frame)
    Box.PlaceholderText = "Enter Key.."
    Box.Size = UDim2.new(1,-30,0,40)
    Box.Position = UDim2.new(0,15,0,50)
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 14
    Box.Text = ""
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0,12)

    local Btn = Instance.new("TextButton", Frame)
    Btn.Text = "Xác Nhận"
    Btn.Size = UDim2.new(1,-60,0,35)
    Btn.Position = UDim2.new(0,30,0,100)
    Btn.BackgroundColor3 = Color3.fromRGB(255,105,180)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,12)

    Btn.MouseButton1Click:Connect(function()
        local key = Box.Text
        if isValidKey(key) then
            writefile(KEY_FILE, HttpService:JSONEncode({key = key}))
            ScreenGui:Destroy()
            warn("✔ Key lưu thành công")
        else
            Btn.Text = "KEY SAI"
            task.wait(1)
            Btn.Text = "Xác Nhận"
        end
    end)

    repeat task.wait() until not ScreenGui.Parent
end

--===== SAU DÒNG NÀY LÀ UI CHATGPT HUB CỦA M =====--

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

--================ LOGO =================
local Logo = Instance.new("ImageButton", ScreenGui)
Logo.Size = UDim2.new(0,50,0,50)
Logo.Position = UDim2.new(0,20,0.45,0)
Logo.BackgroundColor3 = Color3.fromRGB(255,190,210)
Logo.Image = "rbxassetid://75319304126321"
Logo.AutoButtonColor = false
Logo.Active = true
Logo.Draggable = false
Instance.new("UICorner", Logo).CornerRadius = UDim.new(1,0)

-- LOGO RAINBOW BORDER
local LogoStroke = Instance.new("UIStroke")
LogoStroke.Parent = Logo
LogoStroke.Thickness = 2
LogoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
LogoStroke.Enabled = true

--================ MAIN UI =================
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,380,0,260)
Main.Position = UDim2.new(0.5,-190,0.5,-130)
Main.BackgroundColor3 = Color3.fromRGB(255,170,200)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

-- TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "🗿 Meow Hub 🐢"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255,20,147)

--================ MENU =================
local Menu = Instance.new("ScrollingFrame", Main)
Menu.Position = UDim2.new(0,10,0,50)
Menu.Size = UDim2.new(0,140,0,200)
Menu.BackgroundColor3 = Color3.fromRGB(255,140,180)
Menu.ScrollBarImageTransparency = 1
Menu.CanvasSize = UDim2.new(0,0,0,0)
Menu.AutomaticCanvasSize = Enum.AutomaticSize.None
Instance.new("UICorner", Menu).CornerRadius = UDim.new(0,14)

local MenuList = Instance.new("UIListLayout", Menu)
MenuList.Padding = UDim.new(0,6)

MenuList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	Menu.CanvasSize = UDim2.new(0,0,0,MenuList.AbsoluteContentSize.Y + 10)
end)

--================ CONTENT (FIX TRÀN) =================
local Content = Instance.new("ScrollingFrame", Main)
Content.Position = UDim2.new(0,160,0,50)
Content.Size = UDim2.new(0,210,0,200)
Content.BackgroundColor3 = Color3.fromRGB(255,160,200)
Content.ScrollBarImageTransparency = 1
Content.CanvasSize = UDim2.new(0,0,0,0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.None
Instance.new("UICorner", Content).CornerRadius = UDim.new(0,14)

-- AUTO FIX TRÀN
local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0,8)

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	Content.CanvasSize = UDim2.new(0,0,0,UIList.AbsoluteContentSize.Y + 10)
end)

--================ LOGO CLICK =================
Logo.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

--================ LOGO DRAG (MOBILE OK) =================
local dragging, dragStart, startPos

Logo.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Logo.Position
	end
end)

Logo.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		Logo.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

--================ RAINBOW LOGO (MƯỢT – KHÔNG DELAY) =================
local hue = 0
game:GetService("RunService").RenderStepped:Connect(function(dt)
	hue = (hue + dt * 0.8) % 1
	LogoStroke.Color = Color3.fromHSV(hue, 1, 1)
end)

--================ TAB SYSTEM (THEO SỐ) =================

local Tabs = {}        -- Tabs[1], Tabs[2]...
local TabIndexList = {} -- lưu thứ tự tab
local CurrentTab = nil

-- TẠO TAB
function CreateTab(index, name)
	if Tabs[index] then return end

	Tabs[index] = {
		Name = name,
		Buttons = {}
	}

	table.insert(TabIndexList, index)
	table.sort(TabIndexList)
end

-- BUILD MENU TAB
function BuildMenu()
	-- clear menu cũ
	for _,v in pairs(Menu:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end

	for i,tabIndex in ipairs(TabIndexList) do
		local tab = Tabs[tabIndex]

		local b = Instance.new("TextButton", Menu)
		b.Size = UDim2.new(1,-10,0,35)
		b.Text = tab.Name
		b.BackgroundColor3 = Color3.fromRGB(255,182,193)
		b.TextColor3 = Color3.fromRGB(255,20,147)
		b.Font = Enum.Font.GothamBold
		b.TextSize = 14
		Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)

		b.MouseButton1Click:Connect(function()
			ShowTab(tabIndex)
		end)
	end
end

-- HIỂN THỊ TAB
function ShowTab(index)
	for _,v in pairs(Content:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end

	CurrentTab = Tabs[index]
	if not CurrentTab then return end

	for _,info in ipairs(CurrentTab.Buttons) do
		local btn = Instance.new("TextButton", Content)
		btn.Size = UDim2.new(1,-10,0,35)
		btn.Text = info.Name
		btn.BackgroundColor3 = Color3.fromRGB(255,182,193)
		btn.TextColor3 = Color3.fromRGB(255,20,147)
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 14
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

		btn.MouseButton1Click:Connect(function()
			task.spawn(info.Callback)
		end)
	end
end

-- ADD BUTTON VÀO TAB THEO SỐ
function AddButton(tabIndex, info)
	if not Tabs[tabIndex] then
		warn("❌ Tab "..tabIndex.." không tồn tại")
		return
	end
	table.insert(Tabs[tabIndex].Buttons, info)
end

-- Tab + Button
CreateTab(1, "Linh Tinh")
ShowTab(1)
BuildMenu()

AddButton(1, {
	Name = "Teleport Tool",
	Callback = function()
		local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Tạo Tool
local tool = Instance.new("Tool")
tool.Name = "Teleport Tool"
tool.RequiresHandle = false
tool.Parent = player.Backpack

-- Khi click
tool.Activated:Connect(function()
    if not mouse.Hit then return end

    local char = player.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Tele tới vị trí click
    hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
end)
	end
})

AddButton(1, {
	Name = "Eps Rainbow",
	Callback = function()
		-- ESP RAINBOW AUTO RUN (NO BUTTON)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ESP_CACHE = {}
local hue = 0

-- tạo ESP
local function createESP(player)
    if player == LocalPlayer then return end
    if ESP_CACHE[player] then return end
    if not player.Character then return end

    local hl = Instance.new("Highlight")
    hl.Name = "ESP_RAINBOW"
    hl.FillTransparency = 0.3
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = player.Character

    ESP_CACHE[player] = hl
end

-- xóa ESP
local function removeESP(player)
    if ESP_CACHE[player] then
        ESP_CACHE[player]:Destroy()
        ESP_CACHE[player] = nil
    end
end

-- gắn cho player hiện tại
for _, plr in pairs(Players:GetPlayers()) do
    if plr.Character then
        createESP(plr)
    end
end

-- player mới
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(0.5)
        createESP(plr)
    end)
end)

-- player rời
Players.PlayerRemoving:Connect(removeESP)

-- rainbow loop
RunService.RenderStepped:Connect(function()
    hue = (hue + 0.01) % 1
    local color = Color3.fromHSV(hue, 1, 1)

    for _, hl in pairs(ESP_CACHE) do
        if hl then
            hl.FillColor = color
            hl.OutlineColor = color
        end
    end
end)
	end
})

AddButton(1, {
	Name = "Fly",
	Callback = function()
		local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")
local closebutton = Instance.new("TextButton")
local mini = Instance.new("TextButton")
local mini2 = Instance.new("TextButton")

main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)

up.Name = "up"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "UP"
up.TextColor3 = Color3.fromRGB(0, 0, 0)
up.TextSize = 14.000

down.Name = "down"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "DOWN"
down.TextColor3 = Color3.fromRGB(0, 0, 0)
down.TextSize = 14.000

onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
onof.Size = UDim2.new(0, 56, 0, 28)
onof.Font = Enum.Font.SourceSans
onof.Text = "Fly"
onof.TextColor3 = Color3.fromRGB(0, 0, 0)
onof.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Fly Portal"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
speed.Size = UDim2.new(0, 44, 0, 28)
speed.Font = Enum.Font.SourceSans
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(0, 0, 0)
speed.TextScaled = true
speed.TextSize = 14.000
speed.TextWrapped = true

mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
mine.Size = UDim2.new(0, 45, 0, 29)
mine.Font = Enum.Font.SourceSans
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(0, 0, 0)
mine.TextScaled = true
mine.TextSize = 14.000
mine.TextWrapped = true

closebutton.Name = "Close"
closebutton.Parent = main.Frame
closebutton.BackgroundColor3 = Color3.fromRGB(225, 25, 0)
closebutton.Font = "SourceSans"
closebutton.Size = UDim2.new(0, 45, 0, 28)
closebutton.Text = "X"
closebutton.TextSize = 30
closebutton.Position =  UDim2.new(0, 0, -1, 27)

mini.Name = "minimize"
mini.Parent = main.Frame
mini.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
mini.Font = "SourceSans"
mini.Size = UDim2.new(0, 45, 0, 28)
mini.Text = "-"
mini.TextSize = 40
mini.Position = UDim2.new(0, 44, -1, 27)

mini2.Name = "minimize2"
mini2.Parent = main.Frame
mini2.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
mini2.Font = "SourceSans"
mini2.Size = UDim2.new(0, 45, 0, 28)
mini2.Text = "+"
mini2.TextSize = 40
mini2.Position = UDim2.new(0, 44, -1, 57)
mini2.Visible = false

speeds = 1

local speaker = game:GetService("Players").LocalPlayer

local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = false

game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Fly Portal";
	Text = "Portal";
	Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})
Duration = 5;

Frame.Active = true -- main = gui
Frame.Draggable = true

onof.MouseButton1Down:connect(function()

	if nowe == true then
		nowe = false

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	else 
		nowe = true



		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i,v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end




	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then



		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Torso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		local bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			game:GetService("RunService").RenderStepped:Wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end
			--	game.Players.LocalPlayer.Character.Animate.Disabled = true
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false




	else
		local plr = game.Players.LocalPlayer
		local UpperTorso = plr.Character.UpperTorso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end

			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false



	end





end)

local tis

up.MouseButton1Down:connect(function()
	tis = up.MouseEnter:connect(function()
		while tis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
		end
	end)
end)

up.MouseLeave:connect(function()
	if tis then
		tis:Disconnect()
		tis = nil
	end
end)

local dis

down.MouseButton1Down:connect(function()
	dis = down.MouseEnter:connect(function()
		while dis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
		end
	end)
end)

down.MouseLeave:connect(function()
	if dis then
		dis:Disconnect()
		dis = nil
	end
end)


game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
	wait(0.7)
	game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	game.Players.LocalPlayer.Character.Animate.Disabled = false

end)


plus.MouseButton1Down:connect(function()
	speeds = speeds + 1
	speed.Text = speeds
	if nowe == true then


		tpwalking = false
		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
	end
end)
mine.MouseButton1Down:connect(function()
	if speeds == 1 then
		speed.Text = 'cannot be less than 1'
		wait(1)
		speed.Text = speeds
	else
		speeds = speeds - 1
		speed.Text = speeds
		if nowe == true then
			tpwalking = false
			for i = 1, speeds do
				spawn(function()

					local hb = game:GetService("RunService").Heartbeat	


					tpwalking = true
					local chr = game.Players.LocalPlayer.Character
					local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
					while tpwalking and hb:Wait() and chr and hum and hum.Parent do
						if hum.MoveDirection.Magnitude > 0 then
							chr:TranslateBy(hum.MoveDirection)
						end
					end

				end)
			end
		end
	end
end)

closebutton.MouseButton1Click:Connect(function()
	main:Destroy()
end)

mini.MouseButton1Click:Connect(function()
	up.Visible = false
	down.Visible = false
	onof.Visible = false
	plus.Visible = false
	speed.Visible = false
	mine.Visible = false
	mini.Visible = false
	mini2.Visible = true
	main.Frame.BackgroundTransparency = 1
	closebutton.Position =  UDim2.new(0, 0, -1, 57)
end)

mini2.MouseButton1Click:Connect(function()
	up.Visible = true
	down.Visible = true
	onof.Visible = true
	plus.Visible = true
	speed.Visible = true
	mine.Visible = true
	mini.Visible = true
	mini2.Visible = false
	main.Frame.BackgroundTransparency = 0 
	closebutton.Position =  UDim2.new(0, 0, -1, 27)
end)
	end
})

AddButton(1, {
	Name = "Copy Avatar",
	Callback = function()
		--======== COPY AVATAR (CLIENT SIDE) ========--

local Players = game:GetService("Players")
local plr = Players.LocalPlayer

-- trạng thái
local originalDesc
local currentDesc
local isOriginal = true
local charConn

--========= HÀM ÁP AVATAR =========--
local function applyAvatar(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if not hum then return end

    if not originalDesc then
        originalDesc = hum:GetAppliedDescription()
    end

    if currentDesc then
        plr:ClearCharacterAppearance()
        hum:ApplyDescriptionClientServer(currentDesc)
        isOriginal = false
    end
end

--========= COPY AVATAR =========--
local function copyAvatar(input)
    local userId = tonumber(input)

    if not userId then
        local success, id = pcall(function()
            return Players:GetUserIdFromNameAsync(input)
        end)
        if not success then return warn("❌ Không tìm thấy user") end
        userId = id
    end

    local success, desc = pcall(function()
        return Players:GetHumanoidDescriptionFromUserId(userId)
    end)
    if not success then return warn("❌ Lỗi lấy avatar") end

    currentDesc = desc
    applyAvatar(plr.Character)

    if charConn then charConn:Disconnect() end
    charConn = plr.CharacterAdded:Connect(applyAvatar)
end

--========= RESET AVATAR =========--
local function resetAvatar()
    if charConn then charConn:Disconnect() end
    currentDesc = nil

    local char = plr.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and originalDesc and not isOriginal then
        plr:ClearCharacterAppearance()
        hum:ApplyDescriptionClientServer(originalDesc)
        isOriginal = true
    end
end

--======== UI =========--

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "CopyAvatarUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,140)
frame.Position = UDim2.new(0.5,-130,0.5,-70)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "🧍 Copy Avatar"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local box = Instance.new("TextBox", frame)
box.PlaceholderText = "Username hoặc UserId"
box.Size = UDim2.new(1,-20,0,30)
box.Position = UDim2.new(0,10,0,40)
box.Text = ""
box.Font = Enum.Font.Gotham
box.TextSize = 14
box.TextColor3 = Color3.new(1,1,1)
box.BackgroundColor3 = Color3.fromRGB(45,45,45)
Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.new(0.45,0,0,30)
copyBtn.Position = UDim2.new(0.05,0,0,85)
copyBtn.Text = "COPY"
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 14
copyBtn.TextColor3 = Color3.new(1,1,1)
copyBtn.BackgroundColor3 = Color3.fromRGB(80,160,255)
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0,8)

local resetBtn = Instance.new("TextButton", frame)
resetBtn.Size = UDim2.new(0.45,0,0,30)
resetBtn.Position = UDim2.new(0.5,0,0,85)
resetBtn.Text = "RESET"
resetBtn.Font = Enum.Font.GothamBold
resetBtn.TextSize = 14
resetBtn.TextColor3 = Color3.new(1,1,1)
resetBtn.BackgroundColor3 = Color3.fromRGB(255,90,90)
Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0,8)

--======== EVENT =========--
copyBtn.MouseButton1Click:Connect(function()
    if box.Text ~= "" then
        copyAvatar(box.Text)
    end
end)

resetBtn.MouseButton1Click:Connect(resetAvatar)
	end
})

AddButton(1, {
	Name = "Auto Wall Hop",
	Callback = function()
		-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Create Frame
local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.Active = true
frame.Draggable = true

-- Create On Button
local onButton = Instance.new("TextButton")
onButton.Parent = frame
onButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
onButton.Size = UDim2.new(0, 60, 0, 30)
onButton.Position = UDim2.new(0, 20, 0, 20)
onButton.Text = "BẬT"
onButton.TextScaled = true

-- Create Off Button
local offButton = Instance.new("TextButton")
offButton.Parent = frame
offButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
offButton.Size = UDim2.new(0, 60, 0, 30)
offButton.Position = UDim2.new(0, 120, 0, 20)
offButton.Text = "TẮT"
offButton.TextScaled = true

-- Create Destroy Button
local destroyButton = Instance.new("TextButton")
destroyButton.Parent = frame
destroyButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
destroyButton.Size = UDim2.new(0, 160, 0, 30)
destroyButton.Position = UDim2.new(0, 20, 0, 60)
destroyButton.Text = "Destroy"
destroyButton.TextScaled = true

-- Create Status Indicator
local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = frame
statusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Size = UDim2.new(0, 200, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0, -30)
statusLabel.Text = "WALL HOP : TẮT"
statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
statusLabel.TextScaled = true

-- Variables for Wallhop Functionality
local toggle = false
local InfiniteJumpEnabled = true -- Acts as debounce
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
-- Filter list will be updated dynamically

-- Precise wall detection function - Returns RaycastResult
local function getWallRaycastResult()
    local player = Players.LocalPlayer
    local character = player.Character
    if not character then return nil end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end

    raycastParams.FilterDescendantsInstances = {character}

    local directions = {
        humanoidRootPart.CFrame.LookVector,
        -humanoidRootPart.CFrame.LookVector,
        humanoidRootPart.CFrame.RightVector,
        -humanoidRootPart.CFrame.RightVector
    }
    local detectionDistance = 2
    local closestHit = nil
    local minDistance = detectionDistance + 1

    for _, direction in pairs(directions) do
        local ray = Workspace:Raycast(
            humanoidRootPart.Position,
            direction * detectionDistance,
            raycastParams
        )
        if ray and ray.Instance then
             if ray.Distance < minDistance then
                 minDistance = ray.Distance
                 closestHit = ray
             end
        end
    end
    return closestHit
end

-- Button Functions
onButton.MouseButton1Click:Connect(function()
    statusLabel.Text = "WALL HOP : BẬT"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    toggle = true
end)

offButton.MouseButton1Click:Connect(function()
    statusLabel.Text = "WALL HOP : TẮT"
    statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    toggle = false
end)

destroyButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Wallhop Function - ADDED ROTATION BACK TOWARDS WALL
UserInputService.JumpRequest:Connect(function()
    if not toggle or not InfiniteJumpEnabled then return end

    local player = Players.LocalPlayer
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local camera = Workspace.CurrentCamera

    if not (humanoid and rootPart and camera) then return end

    local wallRayResult = getWallRaycastResult()

    if wallRayResult then
        InfiniteJumpEnabled = false -- Start debounce immediately

        -- 1. Calculate Base Direction Away from Wall
        local wallNormal = wallRayResult.Normal
        local horizontalWallNormal = Vector3.new(wallNormal.X, 0, wallNormal.Z).Unit
        if horizontalWallNormal.Magnitude < 0.1 then
             horizontalWallNormal = (rootPart.CFrame.LookVector * Vector3.new(1,0,1)).Unit
             if horizontalWallNormal.Magnitude < 0.1 then horizontalWallNormal = Vector3.new(0,0,-1) end
        end
        local baseDirectionAwayFromWall = horizontalWallNormal -- Store this original direction

        -- 2. Get Camera's Horizontal Look Direction
        local cameraLook = camera.CFrame.LookVector
        local horizontalCameraLook = Vector3.new(cameraLook.X, 0, cameraLook.Z).Unit
        if horizontalCameraLook.Magnitude < 0.1 then horizontalCameraLook = baseDirectionAwayFromWall end

        -- 3. Calculate Initial Rotation (Away from Wall, Camera Influenced)
        local maxInfluenceAngle = math.rad(40)
        local dot = math.clamp(baseDirectionAwayFromWall:Dot(horizontalCameraLook), -1, 1)
        local angleBetween = math.acos(dot)
        local cross = baseDirectionAwayFromWall:Cross(horizontalCameraLook)
        local rotationSign = math.sign(cross.Y)
        if rotationSign == 0 then angleBetween = 0 end
        local actualInfluenceAngle = math.min(angleBetween, maxInfluenceAngle)
        local adjustmentRotation = CFrame.Angles(0, actualInfluenceAngle * rotationSign, 0)
        local initialTargetLookDirection = adjustmentRotation * baseDirectionAwayFromWall

        -- 4. Apply Initial Rotation FIRST
        rootPart.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + initialTargetLookDirection)

        -- 5. Wait a very short moment (one frame)
        RunService.Heartbeat:Wait()

        -- 6. Apply Jump
        local didJump = false
        if humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
             humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
             didJump = true -- Track if the jump actually happened
        end

        -- 7. Apply Rotation BACK towards the wall IF the jump occurred
        if didJump then
             local directionTowardsWall = -baseDirectionAwayFromWall -- Reverse the original away direction
             -- Use the root part's current position as the origin for lookAt
             rootPart.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + directionTowardsWall)
        end

        -- Optional: Velocity boost - Consider applying it *after* the jump state change
        -- if didJump then
        --    rootPart.Velocity = rootPart.Velocity + initialTargetLookDirection * 20 -- Boost away from wall
        -- end

        -- Post-jump cooldown
        task.wait(0.15)
        InfiniteJumpEnabled = true -- End debounce
    end
end)
	end
})






