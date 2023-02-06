-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ImageLabel = Instance.new("ImageLabel")
local flyButton = Instance.new("TextButton")
local speed = Instance.new("TextButton")
local speed2 = Instance.new("TextButton")
local ResetSpeed = Instance.new("TextButton")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Frame.Position = UDim2.new(0.0877950937, 0, 0.200748131, 0)
Frame.Size = UDim2.new(0, 451, 0, 270)
Frame.Style = Enum.FrameStyle.RobloxRound

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(-0.0219115522, 0, -0.0674055964, 0)
TextLabel.Size = UDim2.new(0, 449, 0, 50)
TextLabel.Font = Enum.Font.Gotham
TextLabel.Text = "Capl's (hopefully) universal GUI"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000

ImageLabel.Parent = Frame
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 0.600
ImageLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Position = UDim2.new(-0.0189169068, 0, 0.0743569285, 0)
ImageLabel.Size = UDim2.new(0, 451, 0, 0)
ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

flyButton.Name = "flyButton"
flyButton.Parent = Frame
flyButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
flyButton.BackgroundTransparency = 0.850
flyButton.Position = UDim2.new(0.017738359, 0, 0.133717403, 0)
flyButton.Size = UDim2.new(0, 129, 0, 21)
flyButton.Font = Enum.Font.SourceSans
flyButton.Text = "Toggle Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextSize = 14.000

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speed.BackgroundTransparency = 0.850
speed.Position = UDim2.new(0.334712327, 0, 0.135786161, 0)
speed.Size = UDim2.new(0, 36, 0, 21)
speed.Font = Enum.Font.SourceSans
speed.Text = "+"
speed.TextColor3 = Color3.fromRGB(255, 255, 255)
speed.TextSize = 29.000

speed2.Name = "speed2"
speed2.Parent = Frame
speed2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speed2.BackgroundTransparency = 0.850
speed2.Position = UDim2.new(0.418684393, 0, 0.135566667, 0)
speed2.Size = UDim2.new(0, 40, 0, 21)
speed2.Font = Enum.Font.SourceSansBold
speed2.Text = "-"
speed2.TextColor3 = Color3.fromRGB(255, 255, 255)
speed2.TextSize = 29.000
speed2.TextWrapped = true

ResetSpeed.Name = "Reset Speed"
ResetSpeed.Parent = Frame
ResetSpeed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ResetSpeed.BackgroundTransparency = 0.850
ResetSpeed.Position = UDim2.new(0.334753454, 0, 0.22274904, 0)
ResetSpeed.Size = UDim2.new(0, 76, 0, 21)
ResetSpeed.Font = Enum.Font.SourceSans
ResetSpeed.Text = "Reset Speed"
ResetSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetSpeed.TextSize = 14.000

-- Scripts:

local function HVLA_fake_script() -- flyButton.LocalScript 
	local script = Instance.new('LocalScript', flyButton)

	-- Press E to toggle
	
	repeat wait()
	until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("UpperTorso") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
	local mouse = game.Players.LocalPlayer:GetMouse()
	repeat wait() until mouse
	local plr = game.Players.LocalPlayer
	local UpperTorso = plr.Character.UpperTorso
	local flying = false
	local deb = true
	local ctrl = {f = 0, b = 0, l = 0, r = 0}
	local lastctrl = {f = 0, b = 0, l = 0, r = 0}
	local maxspeed = 50
	local speed = 0
	local button = script.Parent
	
	function Fly()
		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		repeat wait()
			plr.Character.Humanoid.PlatformStand = true
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
				bv.velocity = Vector3.new(0,0.1,0)
			end
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		until not flying
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
	end
	
	button.MouseButton1Click:Connect(function()
		if flying then flying = false
		else
			flying = true
			Fly()
		end
	end)
	
	mouse.KeyDown:connect(function(key)
		if key:lower() == "w" then
			ctrl.f = 1
		elseif key:lower() == "s" then
			ctrl.b = -1
		elseif key:lower() == "a" then
			ctrl.l = -1
		elseif key:lower() == "d" then
			ctrl.r = 1
		end
	end)
	
	mouse.KeyUp:connect(function(key)
		if key:lower() == "w" then
			ctrl.f = 0
		elseif key:lower() == "s" then
			ctrl.b = 0
		elseif key:lower() == "a" then
			ctrl.l = 0
		elseif key:lower() == "d" then
			ctrl.r = 0
		end
	end)
	Fly()
end
coroutine.wrap(HVLA_fake_script)()
local function CIPQG_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)

	local gui = script.Parent
	
	-- Hide the GUI when the script starts
	
	-- Function to show or hide the GUI when a button is clicked
	game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
		if input.KeyCode == Enum.KeyCode.PageUp then
			if gui.Visible then
				gui.Visible = false
			else
				gui.Visible = true
			end
		end
	end)
	
	
	
end
coroutine.wrap(CIPQG_fake_script)()
local function BRDPQV_fake_script() -- Frame.SmoothDrag 
	local script = Instance.new('LocalScript', Frame)

	-- Investigated by TraderBey for any bugs. [Safe]
	local Drag = script.Parent
	gsCoreGui = game:GetService("CoreGui")
	gsTween = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")
		local dragging
		local dragInput
		local dragStart
		local startPos
		local function update(input)
			local delta = input.Position - dragStart
			local dragTime = 0.1 -- smoothness
			local SmoothDrag = {}
			SmoothDrag.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			local dragSmoothFunction = gsTween:Create(Drag, TweenInfo.new(dragTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), SmoothDrag)
			dragSmoothFunction:Play()
		end
		Drag.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = Drag.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)
		Drag.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging and Drag.Size then
				update(input)
			end
		end)
	
end
coroutine.wrap(BRDPQV_fake_script)()
local function AXUB_fake_script() -- speed.LocalScript 
	local script = Instance.new('LocalScript', speed)

	local player = game.Players.LocalPlayer
	local humanoid = player.Character.Humanoid
	
	local ws = 16
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		humanoid.WalkSpeed = ws + 1
	end)
end
coroutine.wrap(AXUB_fake_script)()
local function TXJOJPI_fake_script() -- speed2.LocalScript 
	local script = Instance.new('LocalScript', speed2)

	local player = game.Players.LocalPlayer
	local humanoid = player.Character.Humanoid
	
	local ws = 16
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		humanoid.WalkSpeed = ws - 1
	end)
end
coroutine.wrap(TXJOJPI_fake_script)()
local function OKZJGZ_fake_script() -- ResetSpeed.LocalScript 
	local script = Instance.new('LocalScript', ResetSpeed)

	local player = game.Players.LocalPlayer
	local humanoid = player.Character.Humanoid
	
	local ws = 16
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		humanoid.WalkSpeed = ws
	end)
end
coroutine.wrap(OKZJGZ_fake_script)()
