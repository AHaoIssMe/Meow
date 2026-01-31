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
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AHaoIssMe/Meow/main/CopyAvatar"))()
	end
})

AddButton(1, {
	Name = "Point",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/AHaoIssMe/Meow/main/Point"))()
	end
})