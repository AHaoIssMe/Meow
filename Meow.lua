--===== CHATGPT HUB KEY SYSTEM =====--

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

------------------------------------------------
-- KEY SYSTEM
------------------------------------------------

local KEY_FILE = "MEOWHub_Key.json"
local KEY_PREFIX = "FREE_MEOWHUB"

local savedKey
pcall(function()
	if isfile(KEY_FILE) then
		savedKey = HttpService:JSONDecode(readfile(KEY_FILE)).key
	end
end)

local function isValidKey(key)
	return typeof(key) == "string"
		and key:sub(1, #KEY_PREFIX) == KEY_PREFIX
		and #key == #KEY_PREFIX + 15
end

if not (savedKey and isValidKey(savedKey)) then
	local KeyGui = Instance.new("ScreenGui", game.CoreGui)
	KeyGui.ResetOnSpawn = false

	local Frame = Instance.new("Frame", KeyGui)
	Frame.Size = UDim2.new(0,300,0,160)
	Frame.Position = UDim2.new(0.5,-150,0.5,-80)
	Frame.BackgroundColor3 = Color3.fromRGB(255,170,200)
	Frame.Active = true
	Frame.Draggable = true
	Frame.BorderSizePixel = 0
	Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,16)

	local Title = Instance.new("TextLabel", Frame)
	Title.Size = UDim2.new(1,0,0,35)
	Title.BackgroundTransparency = 1
	Title.Text = "🔑 KEY SYSTEM"
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 18
	Title.TextColor3 = Color3.fromRGB(255,20,147)

	local Box = Instance.new("TextBox", Frame)
	Box.PlaceholderText = "Enter Key..."
	Box.Size = UDim2.new(1,-30,0,36)
	Box.Position = UDim2.new(0,15,0,55)
	Box.Text = ""
	Box.Font = Enum.Font.Gotham
	Box.TextSize = 14
	Box.BorderSizePixel = 0
	Box.BackgroundColor3 = Color3.fromRGB(255,200,220)
	Instance.new("UICorner", Box).CornerRadius = UDim.new(0,8)

	local Btn = Instance.new("TextButton", Frame)
	Btn.Size = UDim2.new(1,-30,0,36)
	Btn.Position = UDim2.new(0,15,0,105)
	Btn.Text = "LOGIN"
	Btn.Font = Enum.Font.GothamBold
	Btn.TextSize = 15
	Btn.BackgroundColor3 = Color3.fromRGB(255,120,170)
	Btn.BorderSizePixel = 0
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

	Btn.MouseButton1Click:Connect(function()
		if isValidKey(Box.Text) then
			writefile(KEY_FILE, HttpService:JSONEncode({key = Box.Text}))
			KeyGui:Destroy()
		else
			Btn.Text = "Xác Nhận"
		end
	end)

	repeat task.wait() until KeyGui.Parent == nil
end

------------------------------------------------
-- MAIN UI
------------------------------------------------

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.ResetOnSpawn = false

-- LOGO
local Logo = Instance.new("ImageButton", ScreenGui)
Logo.Size = UDim2.new(0,50,0,50)
Logo.Position = UDim2.new(0,20,0.45,0)
Logo.BackgroundColor3 = Color3.fromRGB(255,190,210)
Logo.Image = "rbxassetid://75319304126321"
Logo.AutoButtonColor = false
Logo.Active = true
Logo.Draggable = true
Logo.BorderSizePixel = 0
Instance.new("UICorner", Logo).CornerRadius = UDim.new(1,0)

local LogoStroke = Instance.new("UIStroke", Logo)
LogoStroke.Thickness = 2
LogoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
LogoStroke.Color = Color3.fromRGB(255,100,150)

-- RAINBOW VIỀN
task.spawn(function()
	local t = 0
	while Logo.Parent do
		t += 0.02
		LogoStroke.Color = Color3.fromHSV(t % 1, 1, 1)
		task.wait(0.03)
	end
end)

-- MAIN FRAME
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,420,0,300)
Main.Position = UDim2.new(0.5,-210,0.5,-150)
Main.BackgroundColor3 = Color3.fromRGB(255,170,200)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

-- Thêm viền hồng cho Main
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(255,100,150)

Logo.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

------------------------------------------------
-- TITLE (HEADER)
------------------------------------------------

local TitleFrame = Instance.new("Frame", Main)
TitleFrame.Size = UDim2.new(1, 0, 0, 40)
TitleFrame.Position = UDim2.new(0, 0, 0, 10)
TitleFrame.BackgroundTransparency = 1
TitleFrame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TitleFrame)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🗿 Meow Hub 🚀"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255, 20, 147)
Title.TextStrokeTransparency = 0.7
Title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

-- Hiệu ứng nhấp nháy cho title
task.spawn(function()
    while Title.Parent do
        for i = 1, 10 do
            Title.TextTransparency = 0.3 + (i * 0.07)
            task.wait(0.05)
        end
        for i = 1, 10 do
            Title.TextTransparency = 1 - (i * 0.07)
            task.wait(0.05)
        end
    end
end)

------------------------------------------------
-- TAB SYSTEM (SỬA LẠI THEO LOGIC CŨ)
------------------------------------------------

local Tabs = {}
local CurrentTab

local TabButtons = Instance.new("Frame", Main)
TabButtons.Size = UDim2.new(1,-20,0,40)
TabButtons.Position = UDim2.new(0,10,0,10)
TabButtons.BackgroundTransparency = 1
TabButtons.BorderSizePixel = 0

-- Layout ngang cho tab buttons
local TabLayout = Instance.new("UIListLayout", TabButtons)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 5)
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1,-20,1,-70)
Content.Position = UDim2.new(0,10,0,60)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0

function CreateTab(tabId, name)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0,80,0,30)
	btn.Text = name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 13
	btn.BackgroundColor3 = Color3.fromRGB(255,140,180)
	btn.BorderSizePixel = 0
	btn.Parent = TabButtons
	
	-- Hiệu ứng hover
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(255,120,160)
	end)
	
	btn.MouseLeave:Connect(function()
		if CurrentTab == tabId then
			btn.BackgroundColor3 = Color3.fromRGB(255,100,140)
		else
			btn.BackgroundColor3 = Color3.fromRGB(255,140,180)
		end
	end)
	
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	local frame = Instance.new("ScrollingFrame", Content)
	frame.Size = UDim2.new(1,0,1,0)
	frame.CanvasSize = UDim2.new(0,0,0,0)
	frame.ScrollBarImageTransparency = 1
	frame.ScrollingDirection = Enum.ScrollingDirection.Y
	frame.Visible = false
	frame.BorderSizePixel = 0
	frame.BackgroundTransparency = 1

	local layout = Instance.new("UIListLayout", frame)
	layout.Padding = UDim.new(0,6)
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		frame.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
	end)

	btn.MouseButton1Click:Connect(function()
		ShowTab(tabId)
	end)

	Tabs[tabId] = {Button = btn, Frame = frame}
end

function ShowTab(tabId)
	for id, t in pairs(Tabs) do
		t.Frame.Visible = false
		if id == tabId then
			t.Button.BackgroundColor3 = Color3.fromRGB(255,100,140)
		else
			t.Button.BackgroundColor3 = Color3.fromRGB(255,140,180)
		end
	end
	if Tabs[tabId] then
		Tabs[tabId].Frame.Visible = true
		CurrentTab = tabId
	end
end

function AddButton(tabId, data)
	if not Tabs[tabId] then 
		warn("Tab " .. tabId .. " không tồn tại!")
		return 
	end
	
	local btn = Instance.new("TextButton", Tabs[tabId].Frame)
	btn.Size = UDim2.new(1,0,0,36)
	btn.Text = data.Name or "Button"
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.BackgroundColor3 = Color3.fromRGB(255,150,190)
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
	
	-- Hiệu ứng hover
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(255,130,170)
	end)
	
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(255,150,190)
	end)

	btn.MouseButton1Click:Connect(function()
		if data.Callback then
			data.Callback()
		end
	end)
	
	return btn
end

function BuildMenu()
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
		-- COPY AVATAR PLUGIN WITH GUI & LOGO
-- Copy skin người khác (chỉ mình bạn nhìn thấy)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

------------------------------------------------
-- MAIN UI
------------------------------------------------

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.ResetOnSpawn = false

-- LOGO
local Logo = Instance.new("ImageButton", ScreenGui)
Logo.Size = UDim2.new(0,50,0,50)
Logo.Position = UDim2.new(0,20,0.45,0)
Logo.BackgroundColor3 = Color3.fromRGB(255,190,210)
Logo.Image = "rbxassetid://100178220294910"
Logo.AutoButtonColor = false
Logo.Active = true
Logo.Draggable = true
Logo.BorderSizePixel = 0
Instance.new("UICorner", Logo).CornerRadius = UDim.new(1,0)

local LogoStroke = Instance.new("UIStroke", Logo)
LogoStroke.Thickness = 2
LogoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
LogoStroke.Color = Color3.fromRGB(255,100,150)

-- RAINBOW VIỀN
task.spawn(function()
	local t = 0
	while Logo.Parent do
		t += 0.02
		LogoStroke.Color = Color3.fromHSV(t % 1, 1, 1)
		task.wait(0.03)
	end
end)

-- BIẾN
local isAvatarOriginal = true
local originalDesc
local currentDesc
local lastUser
local addedCon
local copyHistory = {}
local MainFrameVisible = false

------------------------------------------------
-- COPY AVATAR MAIN FRAME
------------------------------------------------

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 170, 200) -- Màu hồng giống logo
MainFrame.BackgroundTransparency = 0.05
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- CORNER
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 18)
Corner.Parent = MainFrame

-- NEON BORDER
local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(255, 100, 150)
Border.Thickness = 2
Border.Transparency = 0.3
Border.Parent = MainFrame

-- GLOW EFFECT
local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1, 40, 1, 40)
Glow.Position = UDim2.new(0, -20, 0, -20)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://8992230672"
Glow.ImageColor3 = Color3.fromRGB(255, 100, 150)
Glow.ImageTransparency = 0.8
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(100, 100, 100, 100)
Glow.Parent = MainFrame

-- TITLE
local Title = Instance.new("TextLabel")
Title.Text = "🎭 COPY AVATAR"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(255, 140, 180)
Title.TextColor3 = Color3.fromRGB(255, 20, 147)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

-- TITLE CORNER
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 18)
TitleCorner.Parent = Title

-- PLAYER INPUT
local PlayerLabel = Instance.new("TextLabel")
PlayerLabel.Text = "Nhập tên hoặc ID người chơi:"
PlayerLabel.Size = UDim2.new(1, -20, 0, 25)
PlayerLabel.Position = UDim2.new(0, 10, 0, 60)
PlayerLabel.BackgroundTransparency = 1
PlayerLabel.TextColor3 = Color3.fromRGB(255, 20, 147)
PlayerLabel.Font = Enum.Font.GothamBold
PlayerLabel.TextSize = 14
PlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
PlayerLabel.Parent = MainFrame

local PlayerBox = Instance.new("TextBox")
PlayerBox.PlaceholderText = "Tên hoặc ID người chơi..."
PlayerBox.Size = UDim2.new(1, -20, 0, 35)
PlayerBox.Position = UDim2.new(0, 10, 0, 90)
PlayerBox.BackgroundColor3 = Color3.fromRGB(255, 200, 220)
PlayerBox.TextColor3 = Color3.fromRGB(255, 20, 147)
PlayerBox.Font = Enum.Font.Gotham
PlayerBox.TextSize = 14
PlayerBox.Parent = MainFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = PlayerBox

-- ONLINE PLAYERS LIST
local OnlineLabel = Instance.new("TextLabel")
OnlineLabel.Text = "👥 Người chơi online:"
OnlineLabel.Size = UDim2.new(1, -20, 0, 25)
OnlineLabel.Position = UDim2.new(0, 10, 0, 135)
OnlineLabel.BackgroundTransparency = 1
OnlineLabel.TextColor3 = Color3.fromRGB(255, 20, 147)
OnlineLabel.Font = Enum.Font.GothamBold
OnlineLabel.TextSize = 14
OnlineLabel.TextXAlignment = Enum.TextXAlignment.Left
OnlineLabel.Parent = MainFrame

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -20, 0, 120)
PlayerList.Position = UDim2.new(0, 10, 0, 165)
PlayerList.BackgroundColor3 = Color3.fromRGB(255, 180, 210)
PlayerList.ScrollBarThickness = 5
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 3)
ListLayout.Parent = PlayerList

ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
end)

-- BUTTONS
local CopyButton = Instance.new("TextButton")
CopyButton.Text = "📋 COPY AVATAR"
CopyButton.Size = UDim2.new(1, -20, 0, 40)
CopyButton.Position = UDim2.new(0, 10, 0, 300)
CopyButton.BackgroundColor3 = Color3.fromRGB(255, 120, 170)
CopyButton.TextColor3 = Color3.new(1, 1, 1)
CopyButton.Font = Enum.Font.GothamBold
CopyButton.TextSize = 16
CopyButton.Parent = MainFrame

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 12)
CopyCorner.Parent = CopyButton

local ResetButton = Instance.new("TextButton")
ResetButton.Text = "🔄 RESET AVATAR"
ResetButton.Size = UDim2.new(1, -20, 0, 40)
ResetButton.Position = UDim2.new(0, 10, 0, 350)
ResetButton.BackgroundColor3 = Color3.fromRGB(255, 100, 150)
ResetButton.TextColor3 = Color3.new(1, 1, 1)
ResetButton.Font = Enum.Font.GothamBold
ResetButton.TextSize = 16
ResetButton.Parent = MainFrame

local ResetCorner = Instance.new("UICorner")
ResetCorner.CornerRadius = UDim.new(0, 12)
ResetCorner.Parent = ResetButton

-- STATUS LABEL
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "Trạng thái: Sẵn sàng"
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 1, -30)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 20, 147)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = MainFrame

------------------------------------------------
-- FUNCTIONS
------------------------------------------------

-- HÀM TẠO THÔNG BÁO
local function notify(message, color)
    StatusLabel.Text = "Status: " .. message
    StatusLabel.TextColor3 = color or Color3.fromRGB(255, 20, 147)
    
    -- Hiệu ứng nhấp nháy
    task.spawn(function()
        for i = 1, 3 do
            StatusLabel.TextTransparency = 0.3
            task.wait(0.1)
            StatusLabel.TextTransparency = 0
            task.wait(0.1)
        end
    end)
    
    -- Reset sau 3 giây
    task.delay(3, function()
        StatusLabel.Text = "Trạng thái: Sẵn sàng"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 20, 147)
    end)
end

-- HÀM TẠO NÚT CHO NGƯỜI CHƠI
local function createPlayerButton(player)
    local btn = Instance.new("TextButton")
    btn.Text = "👤 " .. player.Name .. " (ID: " .. player.UserId .. ")"
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(255, 150, 190)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextWrapped = true
    btn.Parent = PlayerList
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Hiệu ứng hover
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(255, 130, 170)
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(255, 150, 190)
    end)
    
    -- Click để chọn người chơi
    btn.MouseButton1Click:Connect(function()
        PlayerBox.Text = player.Name
        PlayerBox.TextColor3 = Color3.fromRGB(255, 20, 147)
        
        -- Hiệu ứng cho button
        btn.BackgroundColor3 = Color3.fromRGB(255, 100, 150)
        task.wait(0.2)
        btn.BackgroundColor3 = Color3.fromRGB(255, 150, 190)
    end)
    
    return btn
end

-- CẬP NHẬT DANH SÁCH NGƯỜI CHƠI
local function updatePlayerList()
    -- Xóa danh sách cũ
    for _, child in pairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Thêm người chơi hiện tại
    local thisPlayer = Instance.new("TextButton")
    thisPlayer.Text = "⭐ TÔI - " .. LocalPlayer.Name .. " (ID: " .. LocalPlayer.UserId .. ")"
    thisPlayer.Size = UDim2.new(1, -10, 0, 30)
    thisPlayer.BackgroundColor3 = Color3.fromRGB(255, 100, 150)
    thisPlayer.TextColor3 = Color3.new(1, 1, 1)
    thisPlayer.Font = Enum.Font.GothamBold
    thisPlayer.TextSize = 12
    thisPlayer.Parent = PlayerList
    
    local thisCorner = Instance.new("UICorner")
    thisCorner.CornerRadius = UDim.new(0, 8)
    thisCorner.Parent = thisPlayer
    
    thisPlayer.MouseButton1Click:Connect(function()
        PlayerBox.Text = LocalPlayer.UserId
        PlayerBox.TextColor3 = Color3.fromRGB(255, 20, 147)
    end)
    
    -- Thêm người chơi khác
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createPlayerButton(player)
        end
    end
end

-- HÀM SET AVATAR
local function setAvatar(char)
    local hum = char and char:WaitForChild("Humanoid", 3)
    local hrp = char and char:WaitForChild("HumanoidRootPart", 3)
    
    if not hum or not hrp then
        notify("Không tìm thấy character!", Color3.fromRGB(255, 100, 100))
        return
    end
    
    if not originalDesc then
        local success, desc = pcall(function()
            return hum:GetAppliedDescription()
        end)
        if success then
            originalDesc = desc
        end
    end
    
    if hum and currentDesc then
        if LocalPlayer.CanLoadCharacterAppearance and not LocalPlayer:HasAppearanceLoaded() then 
            LocalPlayer.CharacterAppearanceLoaded:Wait() 
        end
        
        -- Hiệu ứng loading
        CopyButton.Text = "✨ ĐANG ÁP DỤNG..."
        
        -- Áp dụng avatar mới
        LocalPlayer:ClearCharacterAppearance()
        hum:ApplyDescriptionClientServer(currentDesc)
        isAvatarOriginal = false
        
        -- Hiệu ứng thành công
        CopyButton.Text = "✅ ĐÃ COPY!"
        task.wait(0.5)
        CopyButton.Text = "📋 COPY AVATAR"
        
        notify("Đã copy avatar thành công!", Color3.fromRGB(255, 20, 147))
        
        -- Hiệu ứng particle (ảo)
        task.spawn(function()
            for i = 1, 5 do
                local sparkle = Instance.new("Frame")
                sparkle.Size = UDim2.new(0, 5, 0, 5)
                sparkle.Position = UDim2.new(math.random(), 0, math.random(), 0)
                sparkle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                sparkle.BorderSizePixel = 0
                sparkle.Parent = MainFrame
                
                task.spawn(function()
                    for j = 1, 10 do
                        sparkle.BackgroundTransparency = j / 10
                        sparkle.Size = UDim2.new(0, 5 + j, 0, 5 + j)
                        task.wait(0.02)
                    end
                    sparkle:Destroy()
                end)
                
                task.wait(0.1)
            end
        end)
    end
end

-- HÀM COPY AVATAR
local function copyAvatar(target)
    if not target then 
        notify("Vui lòng nhập tên/ID!", Color3.fromRGB(255, 200, 0))
        return 
    end
    
    if lastUser and lastUser == target then
        notify("Đã copy người này rồi!", Color3.fromRGB(255, 200, 0))
        return
    end
    
    lastUser = target
    
    local userId = target
    local playerFound = false
    
    -- Tìm player bằng tên
    for _, player in pairs(Players:GetPlayers()) do
        if string.lower(player.Name) == string.lower(target) then
            userId = player.UserId
            playerFound = true
            break
        end
    end
    
    -- Nếu không tìm thấy, thử lấy UserId từ tên
    if not playerFound then
        if not tonumber(userId) then
            local success, id = pcall(function()
                return Players:GetUserIdFromNameAsync(userId)
            end)
            
            if success and id then 
                userId = id
                playerFound = true
            end
        end
    end
    
    -- Hiển thị trạng thái đang load
    CopyButton.Text = "⏳ ĐANG TẢI..."
    CopyButton.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
    
    -- Lấy description
    local success, desc = pcall(function()
        return Players:GetHumanoidDescriptionFromUserId(userId)
    end)
    
    CopyButton.Text = "📋 COPY AVATAR"
    CopyButton.BackgroundColor3 = Color3.fromRGB(255, 120, 170)
    
    if success and desc then
        currentDesc = desc
        
        -- Áp dụng cho character hiện tại
        local character = LocalPlayer.Character
        if character then
            setAvatar(character)
        end
        
        -- Kết nối khi respawn
        if addedCon then 
            addedCon:Disconnect() 
        end
        addedCon = LocalPlayer.CharacterAdded:Connect(setAvatar)
        
    else
        notify("Không tìm thấy người chơi!", Color3.fromRGB(255, 100, 100))
    end
end

-- HÀM RESET AVATAR
local function resetAvatar()
    if addedCon then
        addedCon:Disconnect()
        addedCon = nil
        currentDesc = nil
        lastUser = nil
    end
    
    local character = LocalPlayer.Character
    local hum = character and character:FindFirstChild("Humanoid")
    
    if hum and originalDesc and not isAvatarOriginal then
        -- Hiệu ứng loading
        ResetButton.Text = "✨ ĐANG RESET..."
        
        LocalPlayer:ClearCharacterAppearance()
        hum:ApplyDescriptionClientServer(originalDesc)
        isAvatarOriginal = true
        
        -- Hiệu ứng thành công
        ResetButton.Text = "✅ ĐÃ RESET!"
        task.wait(0.5)
        ResetButton.Text = "🔄 RESET AVATAR"
        
        notify("Đã reset về avatar gốc!", Color3.fromRGB(255, 20, 147))
    else
        notify("Avatar đã là gốc!", Color3.fromRGB(255, 200, 0))
    end
end

------------------------------------------------
-- EVENT CONNECTIONS
------------------------------------------------

-- LOGO CLICK TO TOGGLE MAIN FRAME
Logo.MouseButton1Click:Connect(function()
    MainFrameVisible = not MainFrameVisible
    MainFrame.Visible = MainFrameVisible
    
    -- Hiệu ứng cho logo
    Logo.BackgroundColor3 = MainFrameVisible and Color3.fromRGB(255, 150, 190) or Color3.fromRGB(255, 190, 210)
    
    -- Hiệu ứng mở/đóng MainFrame
    if MainFrameVisible then
        MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainFrame, tweenInfo, {
            Size = UDim2.new(0, 300, 0, 400)
        })
        tween:Play()
    end
end)

-- BUTTON EVENTS
CopyButton.MouseButton1Click:Connect(function()
    local target = PlayerBox.Text
    copyAvatar(target)
end)

ResetButton.MouseButton1Click:Connect(function()
    resetAvatar()
end)

-- ENTER KEY TO COPY
PlayerBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local target = PlayerBox.Text
        copyAvatar(target)
    end
end)

-- BUTTON HOVER EFFECTS
CopyButton.MouseEnter:Connect(function()
    CopyButton.BackgroundColor3 = Color3.fromRGB(255, 130, 160)
end)

CopyButton.MouseLeave:Connect(function()
    CopyButton.BackgroundColor3 = Color3.fromRGB(255, 120, 170)
end)

ResetButton.MouseEnter:Connect(function()
    ResetButton.BackgroundColor3 = Color3.fromRGB(255, 80, 130)
end)

ResetButton.MouseLeave:Connect(function()
    ResetButton.BackgroundColor3 = Color3.fromRGB(255, 100, 150)
end)

-- KEYBINDS
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- Ctrl+C để copy
    if input.KeyCode == Enum.KeyCode.C and input.UserInputType == Enum.UserInputType.Keyboard then
        local ctrl = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) or 
                     game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.RightControl)
        if ctrl then
            copyAvatar(PlayerBox.Text)
        end
    end
    
    -- Ctrl+R để reset
    if input.KeyCode == Enum.KeyCode.R and input.UserInputType == Enum.UserInputType.Keyboard then
        local ctrl = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) or 
                     game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.RightControl)
        if ctrl then
            resetAvatar()
        end
    end
    
    -- F1 để toggle GUI
    if input.KeyCode == Enum.KeyCode.F1 then
        MainFrameVisible = not MainFrameVisible
        MainFrame.Visible = MainFrameVisible
    end
end)

-- AUTO-UPDATE PLAYER LIST
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

------------------------------------------------
-- INITIALIZATION
------------------------------------------------

-- CẬP NHẬT DANH SÁCH BAN ĐẦU
task.wait(2)
updatePlayerList()

-- TẠO NOTIFICATION BAN ĐẦU
notify("Copy Avatar Tool đã sẵn sàng!", Color3.fromRGB(255, 20, 147))

print("🎭 Copy Avatar Plugin with GUI Loaded!")
print("📌 Click vào Logo để mở GUI")
print("📌 Ctrl+C: Copy avatar từ ô nhập")
print("📌 Ctrl+R: Reset avatar")
print("📌 F1: Ẩn/hiện GUI")
print("📌 Click vào tên trong danh sách để chọn nhanh")

-- ANIMATE LOGO ON START
task.spawn(function()
    for i = 1, 3 do
        Logo.Rotation = 10
        task.wait(0.1)
        Logo.Rotation = -10
        task.wait(0.1)
        Logo.Rotation = 0
        task.wait(0.5)
    end
end)
	end
})

AddButton(1, {
	Name = "Point",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AHaoIssMe/Meow/main/Point"))()
	end
})
