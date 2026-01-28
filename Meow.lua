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
		-- COPY AVATAR (CLIENT SIDE)

local Players = game:GetService("Players")
local plr = Players.LocalPlayer

local originalDesc
local currentDesc
local addedCon
local isAvatarOriginal = true

-- ================== APPLY AVATAR ==================
local function applyAvatar(char)
    local hum = char:WaitForChild("Humanoid")

    if not originalDesc then
        originalDesc = hum:GetAppliedDescription()
    end

    if currentDesc then
        plr:ClearCharacterAppearance()
        hum:ApplyDescriptionClientServer(currentDesc)
        isAvatarOriginal = false
    end
end

-- ================== UI ==================
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "CopyAvatarUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,150)
frame.Position = UDim2.new(0.5,-130,0.5,-75)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
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
box.Size = UDim2.new(1,-20,0,35)
box.Position = UDim2.new(0,10,0,40)
box.PlaceholderText = "Tên hoặc UserId"
box.Text = ""
box.Font = Enum.Font.Gotham
box.TextSize = 14
Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Size = UDim2.new(0.45,0,0,35)
copyBtn.Position = UDim2.new(0.05,0,0,90)
copyBtn.Text = "COPY"
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextColor3 = Color3.new(1,1,1)
copyBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0,8)

local resetBtn = Instance.new("TextButton", frame)
resetBtn.Size = UDim2.new(0.45,0,0,35)
resetBtn.Position = UDim2.new(0.5,0,0,90)
resetBtn.Text = "RESET"
resetBtn.Font = Enum.Font.GothamBold
resetBtn.TextColor3 = Color3.new(1,1,1)
resetBtn.BackgroundColor3 = Color3.fromRGB(255,80,80)
Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0,8)

-- ================== COPY ==================
copyBtn.MouseButton1Click:Connect(function()
    local input = box.Text
    if input == "" then return end

    local userId = tonumber(input)
    if not userId then
        local ok, id = pcall(function()
            return Players:GetUserIdFromNameAsync(input)
        end)
        if ok then userId = id else return end
    end

    local ok, desc = pcall(function()
        return Players:GetHumanoidDescriptionFromUserId(userId)
    end)
    if not ok then return end

    currentDesc = desc
    applyAvatar(plr.Character)

    if addedCon then addedCon:Disconnect() end
    addedCon = plr.CharacterAdded:Connect(applyAvatar)
end)

-- ================== RESET ==================
resetBtn.MouseButton1Click:Connect(function()
    if addedCon then
        addedCon:Disconnect()
        addedCon = nil
    end

    if originalDesc and plr.Character then
        plr:ClearCharacterAppearance()
        local hum = plr.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ApplyDescriptionClientServer(originalDesc)
            isAvatarOriginal = true
        end
    end
end)
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
destroyButton.Text = "Close Ui"
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

AddButton(1, {
	Name = "Point",
	Callback = function()
		-- POINT MANAGER - Tạo, Xóa, Teleport đến Point
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- LƯU TRỮ POINTS
local SavedPoints = {}
local PointMarkers = {} -- Lưu các marker trong game
local CurrentSelectedPoint = nil

-- MÀU SẮC
local Colors = {
    Primary = Color3.fromRGB(52, 152, 219),
    Secondary = Color3.fromRGB(41, 128, 185),
    Success = Color3.fromRGB(46, 204, 113),
    Danger = Color3.fromRGB(231, 76, 60),
    Warning = Color3.fromRGB(241, 196, 15),
    Dark = Color3.fromRGB(44, 62, 80),
    Light = Color3.fromRGB(236, 240, 241)
}

-- TẠO MARKER TRONG GAME
function createPointMarker(position, index)
    -- Tạo part đánh dấu
    local marker = Instance.new("Part")
    marker.Name = "PointMarker_" .. index
    marker.Size = Vector3.new(2, 2, 2)
    marker.Position = position
    marker.Anchored = true
    marker.CanCollide = false
    marker.Material = Enum.Material.Neon
    marker.BrickColor = BrickColor.new("Bright blue")
    marker.Transparency = 0.3
    
    -- Billboard GUI hiển thị số
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 100, 0, 100)
    billboard.AlwaysOnTop = true
    billboard.Parent = marker
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Text = "Point " .. index
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboard
    
    -- Hiệu ứng nhấp nháy
    spawn(function()
        while marker and marker.Parent do
            marker.Transparency = 0.2
            wait(0.5)
            marker.Transparency = 0.5
            wait(0.5)
        end
    end)
    
    marker.Parent = workspace
    PointMarkers[index] = marker
    return marker
end

-- XÓA MARKER
function removePointMarker(index)
    if PointMarkers[index] then
        PointMarkers[index]:Destroy()
        PointMarkers[index] = nil
    end
end

-- TẠO GUI CHÍNH
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PointManagerGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.05, 0, 0.5, -200)
MainFrame.BackgroundColor3 = Colors.Dark
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = MainFrame

-- Stroke
local stroke = Instance.new("UIStroke")
stroke.Color = Colors.Primary
stroke.Thickness = 2
stroke.Parent = MainFrame

-- TITLE
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "📍 POINT MANAGER BY A.HAO"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Colors.Primary
Title.TextColor3 = Colors.Light
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Title Corner
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = Title

-- BODY FRAME
local BodyFrame = Instance.new("Frame")
BodyFrame.Name = "BodyFrame"
BodyFrame.Size = UDim2.new(1, -20, 1, -70)
BodyFrame.Position = UDim2.new(0, 10, 0, 60)
BodyFrame.BackgroundTransparency = 1
BodyFrame.Parent = MainFrame

-- CREATE BUTTON (TẠO POINT)
local CreateBtn = Instance.new("TextButton")
CreateBtn.Name = "CreateBtn"
CreateBtn.Text = "➕ TẠO POINT"
CreateBtn.Size = UDim2.new(1, 0, 0, 45)
CreateBtn.Position = UDim2.new(0, 0, 0, 0)
CreateBtn.BackgroundColor3 = Colors.Success
CreateBtn.TextColor3 = Colors.Light
CreateBtn.Font = Enum.Font.GothamBold
CreateBtn.TextSize = 14
CreateBtn.Parent = BodyFrame

-- Teleport Button
local TeleportBtn = Instance.new("TextButton")
TeleportBtn.Name = "TeleportBtn"
TeleportBtn.Text = "🚀 TELE TO POINT"
TeleportBtn.Size = UDim2.new(1, 0, 0, 45)
TeleportBtn.Position = UDim2.new(0, 0, 0, 55)
TeleportBtn.BackgroundColor3 = Colors.Primary
TeleportBtn.TextColor3 = Colors.Light
TeleportBtn.Font = Enum.Font.GothamBold
TeleportBtn.TextSize = 14
TeleportBtn.Parent = BodyFrame

-- Delete Button
local DeleteBtn = Instance.new("TextButton")
DeleteBtn.Name = "DeleteBtn"
DeleteBtn.Text = "🗑️ XÓA POINT"
DeleteBtn.Size = UDim2.new(1, 0, 0, 45)
DeleteBtn.Position = UDim2.new(0, 0, 0, 110)
DeleteBtn.BackgroundColor3 = Colors.Danger
DeleteBtn.TextColor3 = Colors.Light
DeleteBtn.Font = Enum.Font.GothamBold
DeleteBtn.TextSize = 14
DeleteBtn.Parent = BodyFrame

-- Points List Label
local ListLabel = Instance.new("TextLabel")
ListLabel.Name = "ListLabel"
ListLabel.Text = "📋 DANH SÁCH POINTS:"
ListLabel.Size = UDim2.new(1, 0, 0, 30)
ListLabel.Position = UDim2.new(0, 0, 0, 170)
ListLabel.BackgroundTransparency = 1
ListLabel.TextColor3 = Colors.Light
ListLabel.Font = Enum.Font.GothamBold
ListLabel.TextSize = 14
ListLabel.TextXAlignment = Enum.TextXAlignment.Left
ListLabel.Parent = BodyFrame

-- Scroll Frame for Points List
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, 0, 0, 150)
ScrollFrame.Position = UDim2.new(0, 0, 0, 200)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ScrollFrame.BackgroundTransparency = 0.2
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = BodyFrame

-- List Layout
local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 5)
ListLayout.Parent = ScrollFrame

ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
end)

-- UPDATE POINTS LIST
function updatePointsList()
    -- Xóa tất cả các item cũ
    for _, child in pairs(ScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Thêm các point mới
    for index, pointData in pairs(SavedPoints) do
        local pointBtn = Instance.new("TextButton")
        pointBtn.Name = "Point_" .. index
        pointBtn.Text = "📍 Point " .. index .. "\n" .. string.format("X:%.1f Y:%.1f Z:%.1f", 
            pointData.Position.X, pointData.Position.Y, pointData.Position.Z)
        pointBtn.Size = UDim2.new(1, -10, 0, 40)
        pointBtn.Position = UDim2.new(0, 5, 0, 0)
        pointBtn.BackgroundColor3 = Colors.Secondary
        pointBtn.TextColor3 = Colors.Light
        pointBtn.Font = Enum.Font.Gotham
        pointBtn.TextSize = 12
        pointBtn.TextWrapped = true
        pointBtn.Parent = ScrollFrame
        
        -- Corner
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 5)
        btnCorner.Parent = pointBtn
        
        -- Stroke
        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = Colors.Primary
        btnStroke.Thickness = 1
        btnStroke.Parent = pointBtn
        
        -- Click để chọn point
        pointBtn.MouseButton1Click:Connect(function()
            CurrentSelectedPoint = index
            -- Highlight point được chọn
            for _, btn in pairs(ScrollFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    if btn.Name == "Point_" .. index then
                        btn.BackgroundColor3 = Colors.Warning
                        btn.TextColor3 = Colors.Dark
                    else
                        btn.BackgroundColor3 = Colors.Secondary
                        btn.TextColor3 = Colors.Light
                    end
                end
            end
        end)
        
        -- Double click để teleport
        local lastClickTime = 0
        pointBtn.MouseButton1Click:Connect(function()
            local currentTime = tick()
            if currentTime - lastClickTime < 0.3 then -- Double click trong 0.3 giây
                teleportToPoint(index)
            end
            lastClickTime = currentTime
        end)
    end
    
    -- Nếu không có point nào
    if #SavedPoints == 0 then
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Text = "Chưa có point nào được tạo"
        emptyLabel.Size = UDim2.new(1, 0, 0, 30)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        emptyLabel.Font = Enum.Font.Gotham
        emptyLabel.TextSize = 12
        emptyLabel.Parent = ScrollFrame
    end
end

-- TẠO DELETE MENU (Mở khi nhấn XÓA POINT)
local DeleteMenu = Instance.new("Frame")
DeleteMenu.Name = "DeleteMenu"
DeleteMenu.Size = UDim2.new(0, 350, 0, 300)
DeleteMenu.Position = UDim2.new(0.5, -175, 0.5, -150)
DeleteMenu.BackgroundColor3 = Colors.Dark
DeleteMenu.Visible = false
DeleteMenu.Active = true
DeleteMenu.Draggable = true
DeleteMenu.Parent = ScreenGui

-- Delete Menu Corner
local deleteCorner = Instance.new("UICorner")
deleteCorner.CornerRadius = UDim.new(0, 10)
deleteCorner.Parent = DeleteMenu

-- Delete Menu Stroke
local deleteStroke = Instance.new("UIStroke")
deleteStroke.Color = Colors.Danger
deleteStroke.Thickness = 2
deleteStroke.Parent = DeleteMenu

-- Delete Menu Title
local DeleteTitle = Instance.new("TextLabel")
DeleteTitle.Text = "🗑️ CHỌN POINT ĐỂ XÓA"
DeleteTitle.Size = UDim2.new(1, 0, 0, 50)
DeleteTitle.BackgroundColor3 = Colors.Danger
DeleteTitle.TextColor3 = Colors.Light
DeleteTitle.Font = Enum.Font.GothamBold
DeleteTitle.TextSize = 16
DeleteTitle.Parent = DeleteMenu

-- Delete Scroll Frame
local DeleteScrollFrame = Instance.new("ScrollingFrame")
DeleteScrollFrame.Size = UDim2.new(1, -20, 1, -120)
DeleteScrollFrame.Position = UDim2.new(0, 10, 0, 60)
DeleteScrollFrame.BackgroundTransparency = 1
DeleteScrollFrame.ScrollBarThickness = 5
DeleteScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
DeleteScrollFrame.Parent = DeleteMenu

-- Delete List Layout
local DeleteListLayout = Instance.new("UIListLayout")
DeleteListLayout.Padding = UDim.new(0, 5)
DeleteListLayout.Parent = DeleteScrollFrame

DeleteListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    DeleteScrollFrame.CanvasSize = UDim2.new(0, 0, 0, DeleteListLayout.AbsoluteContentSize.Y)
end)

-- Close Delete Menu Button
local CloseDeleteBtn = Instance.new("TextButton")
CloseDeleteBtn.Text = "✖️ ĐÓNG"
CloseDeleteBtn.Size = UDim2.new(0.4, 0, 0, 40)
CloseDeleteBtn.Position = UDim2.new(0.3, 0, 1, -50)
CloseDeleteBtn.BackgroundColor3 = Colors.Secondary
CloseDeleteBtn.TextColor3 = Colors.Light
CloseDeleteBtn.Font = Enum.Font.GothamBold
CloseDeleteBtn.TextSize = 14
CloseDeleteBtn.Parent = DeleteMenu

-- TẠO TELEPORT MENU (Mở khi nhấn TELE TO POINT)
local TeleportMenu = Instance.new("Frame")
TeleportMenu.Name = "TeleportMenu"
TeleportMenu.Size = UDim2.new(0, 350, 0, 300)
TeleportMenu.Position = UDim2.new(0.5, -175, 0.5, -150)
TeleportMenu.BackgroundColor3 = Colors.Dark
TeleportMenu.Visible = false
TeleportMenu.Active = true
TeleportMenu.Draggable = true
TeleportMenu.Parent = ScreenGui

-- Teleport Menu Corner
local teleCorner = Instance.new("UICorner")
teleCorner.CornerRadius = UDim.new(0, 10)
teleCorner.Parent = TeleportMenu

-- Teleport Menu Stroke
local teleStroke = Instance.new("UIStroke")
teleStroke.Color = Colors.Primary
teleStroke.Thickness = 2
teleStroke.Parent = TeleportMenu

-- Teleport Menu Title
local TeleTitle = Instance.new("TextLabel")
TeleTitle.Text = "🚀 CHỌN POINT ĐỂ TELEPORT"
TeleTitle.Size = UDim2.new(1, 0, 0, 50)
TeleTitle.BackgroundColor3 = Colors.Primary
TeleTitle.TextColor3 = Colors.Light
TeleTitle.Font = Enum.Font.GothamBold
TeleTitle.TextSize = 16
TeleTitle.Parent = TeleportMenu

-- Teleport Scroll Frame
local TeleScrollFrame = Instance.new("ScrollingFrame")
TeleScrollFrame.Size = UDim2.new(1, -20, 1, -120)
TeleScrollFrame.Position = UDim2.new(0, 10, 0, 60)
TeleScrollFrame.BackgroundTransparency = 1
TeleScrollFrame.ScrollBarThickness = 5
TeleScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
TeleScrollFrame.Parent = TeleportMenu

-- Teleport List Layout
local TeleListLayout = Instance.new("UIListLayout")
TeleListLayout.Padding = UDim.new(0, 5)
TeleListLayout.Parent = TeleScrollFrame

TeleListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TeleScrollFrame.CanvasSize = UDim2.new(0, 0, 0, TeleListLayout.AbsoluteContentSize.Y)
end)

-- Close Teleport Menu Button
local CloseTeleBtn = Instance.new("TextButton")
CloseTeleBtn.Text = "✖️ ĐÓNG"
CloseTeleBtn.Size = UDim2.new(0.4, 0, 0, 40)
CloseTeleBtn.Position = UDim2.new(0.3, 0, 1, -50)
CloseTeleBtn.BackgroundColor3 = Colors.Secondary
CloseTeleBtn.TextColor3 = Colors.Light
CloseTeleBtn.Font = Enum.Font.GothamBold
CloseTeleBtn.TextSize = 14
CloseTeleBtn.Parent = TeleportMenu

-- HÀM TẠO POINT
function createNewPoint()
    local character = LocalPlayer.Character
    if not character then
        warn("Không tìm thấy character!")
        return
    end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then
        warn("Không tìm thấy HumanoidRootPart!")
        return
    end
    
    local newIndex = #SavedPoints + 1
    local position = root.Position
    
    -- Lưu point
    SavedPoints[newIndex] = {
        Position = position,
        TimeCreated = os.time(),
        Name = "Point " .. newIndex
    }
    
    -- Tạo marker trong game
    createPointMarker(position, newIndex)
    
    -- Update UI
    updatePointsList()
    
    -- Hiệu ứng button
    CreateBtn.Text = "✅ ĐÃ TẠO POINT " .. newIndex
    CreateBtn.BackgroundColor3 = Colors.Success
    wait(1)
    CreateBtn.Text = "➕ TẠO POINT"
    CreateBtn.BackgroundColor3 = Colors.Success
    
    print("✅ Đã tạo Point " .. newIndex .. " tại vị trí: " .. tostring(position))
end

-- HÀM XÓA POINT
function deletePoint(index)
    if SavedPoints[index] then
        -- Xóa marker trong game
        removePointMarker(index)
        
        -- Xóa khỏi danh sách
        SavedPoints[index] = nil
        
        -- Sắp xếp lại indexes
        local newPoints = {}
        local newIndex = 1
        for _, pointData in pairs(SavedPoints) do
            newPoints[newIndex] = pointData
            newIndex = newIndex + 1
        end
        
        SavedPoints = newPoints
        
        -- Xóa tất cả markers và tạo lại
        for i, marker in pairs(PointMarkers) do
            if marker then marker:Destroy() end
        end
        PointMarkers = {}
        
        -- Tạo lại markers
        for i, pointData in pairs(SavedPoints) do
            createPointMarker(pointData.Position, i)
        end
        
        -- Update UI
        updatePointsList()
        updateDeleteMenu()
        updateTeleportMenu()
        
        CurrentSelectedPoint = nil
        
        print("🗑️ Đã xóa Point " .. index)
    end
end

-- HÀM TELEPORT ĐẾN POINT
function teleportToPoint(index)
    if not SavedPoints[index] then
        warn("Point không tồn tại!")
        return
    end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local targetPosition = SavedPoints[index].Position
    
    -- Hiệu ứng trước khi teleport
    TeleportBtn.Text = "⚡ ĐANG TELEPORT..."
    TeleportBtn.BackgroundColor3 = Colors.Warning
    
    -- Teleport
    root.CFrame = CFrame.new(targetPosition)
    
    -- Hiệu ứng sau khi teleport
    wait(0.5)
    TeleportBtn.Text = "✅ ĐÃ TELEPORT!"
    wait(1)
    TeleportBtn.Text = "🚀 TELE TO POINT"
    TeleportBtn.BackgroundColor3 = Colors.Primary
    
    print("🚀 Đã teleport đến Point " .. index)
end

-- UPDATE DELETE MENU
function updateDeleteMenu()
    -- Xóa tất cả các item cũ
    for _, child in pairs(DeleteScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Thêm các point vào delete menu
    for index, pointData in pairs(SavedPoints) do
        local deleteBtn = Instance.new("TextButton")
        deleteBtn.Text = "🗑️ Point " .. index .. "\n" .. string.format("X:%.1f Y:%.1f Z:%.1f", 
            pointData.Position.X, pointData.Position.Y, pointData.Position.Z)
        deleteBtn.Size = UDim2.new(1, -10, 0, 50)
        deleteBtn.Position = UDim2.new(0, 5, 0, 0)
        deleteBtn.BackgroundColor3 = Colors.Danger
        deleteBtn.BackgroundTransparency = 0.3
        deleteBtn.TextColor3 = Colors.Light
        deleteBtn.Font = Enum.Font.Gotham
        deleteBtn.TextSize = 12
        deleteBtn.TextWrapped = true
        deleteBtn.Parent = DeleteScrollFrame
        
        -- Corner
        local delCorner = Instance.new("UICorner")
        delCorner.CornerRadius = UDim.new(0, 5)
        delCorner.Parent = deleteBtn
        
        -- Stroke
        local delStroke = Instance.new("UIStroke")
        delStroke.Color = Colors.Danger
        delStroke.Thickness = 2
        delStroke.Parent = deleteBtn
        
        -- Click để xóa
        deleteBtn.MouseButton1Click:Connect(function()
            deletePoint(index)
        end)
    end
    
    -- Nếu không có point nào
    if #SavedPoints == 0 then
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Text = "Không có point nào để xóa"
        emptyLabel.Size = UDim2.new(1, 0, 0, 30)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        emptyLabel.Font = Enum.Font.Gotham
        emptyLabel.TextSize = 12
        emptyLabel.Parent = DeleteScrollFrame
    end
end

-- UPDATE TELEPORT MENU
function updateTeleportMenu()
    -- Xóa tất cả các item cũ
    for _, child in pairs(TeleScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Thêm các point vào teleport menu
    for index, pointData in pairs(SavedPoints) do
        local teleBtn = Instance.new("TextButton")
        teleBtn.Text = "🚀 Point " .. index .. "\n" .. string.format("X:%.1f Y:%.1f Z:%.1f", 
            pointData.Position.X, pointData.Position.Y, pointData.Position.Z)
        teleBtn.Size = UDim2.new(1, -10, 0, 50)
        teleBtn.Position = UDim2.new(0, 5, 0, 0)
        teleBtn.BackgroundColor3 = Colors.Primary
        teleBtn.BackgroundTransparency = 0.3
        teleBtn.TextColor3 = Colors.Light
        teleBtn.Font = Enum.Font.Gotham
        teleBtn.TextSize = 12
        teleBtn.TextWrapped = true
        teleBtn.Parent = TeleScrollFrame
        
        -- Corner
        local teleBtnCorner = Instance.new("UICorner")
        teleBtnCorner.CornerRadius = UDim.new(0, 5)
        teleBtnCorner.Parent = teleBtn
        
        -- Stroke
        local teleBtnStroke = Instance.new("UIStroke")
        teleBtnStroke.Color = Colors.Primary
        teleBtnStroke.Thickness = 2
        teleBtnStroke.Parent = teleBtn
        
        -- Click để teleport
        teleBtn.MouseButton1Click:Connect(function()
            teleportToPoint(index)
            TeleportMenu.Visible = false
        end)
    end
    
    -- Nếu không có point nào
    if #SavedPoints == 0 then
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Text = "Không có point nào để teleport"
        emptyLabel.Size = UDim2.new(1, 0, 0, 30)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        emptyLabel.Font = Enum.Font.Gotham
        emptyLabel.TextSize = 12
        emptyLabel.Parent = TeleScrollFrame
    end
end

-- BUTTON CLICK HANDLERS
CreateBtn.MouseButton1Click:Connect(function()
    createNewPoint()
end)

DeleteBtn.MouseButton1Click:Connect(function()
    updateDeleteMenu()
    DeleteMenu.Visible = true
    TeleportMenu.Visible = false
end)

TeleportBtn.MouseButton1Click:Connect(function()
    updateTeleportMenu()
    TeleportMenu.Visible = true
    DeleteMenu.Visible = false
end)

CloseDeleteBtn.MouseButton1Click:Connect(function()
    DeleteMenu.Visible = false
end)

CloseTeleBtn.MouseButton1Click:Connect(function()
    TeleportMenu.Visible = false
end)

-- KEYBINDS
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- Tạo point với phím C
    if input.KeyCode == Enum.KeyCode.C then
        createNewPoint()
    end
    
    -- Teleport đến point đang chọn với phím T
    if input.KeyCode == Enum.KeyCode.T then
        if CurrentSelectedPoint then
            teleportToPoint(CurrentSelectedPoint)
        else
            warn("Chưa chọn point nào!")
        end
    end
    
    -- Mở menu xóa với phím X
    if input.KeyCode == Enum.KeyCode.X then
        updateDeleteMenu()
        DeleteMenu.Visible = not DeleteMenu.Visible
        TeleportMenu.Visible = false
    end
    
    -- Mở menu teleport với phím V
    if input.KeyCode == Enum.KeyCode.V then
        updateTeleportMenu()
        TeleportMenu.Visible = not TeleportMenu.Visible
        DeleteMenu.Visible = false
    end
end)

-- LOAD SAVED POINTS (nếu có)
function loadSavedPoints()
    -- Ở đây bạn có thể thêm code để load points từ file
    -- Ví dụ: if isfile("points.json") then SavedPoints = HttpService:JSONDecode(readfile("points.json")) end
    print("✅ Point Manager đã sẵn sàng!")
    print("📌 C - Tạo point tại vị trí hiện tại")
    print("📌 T - Teleport đến point đang chọn")
    print("📌 X - Mở menu xóa point")
    print("📌 V - Mở menu teleport")
end

-- KHỞI TẠO
wait(2)
loadSavedPoints()
updatePointsList()

print("🎯 Point Manager Script Loaded!")
	end
})



