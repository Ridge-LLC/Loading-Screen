--MIT License

--Copyright (c) 2023 Ridge Development LLC
--Please Read the LICENSE Script for more info.
--More info on my github Page
--https://github.com/Ridge-LLC/Loading-Screen
--== [CONFIG] ==--
local ReplicatedStorage_Image = "rbxassetid://8775655595"
local Workspace_Image = "rbxassetid://8775656173"
local PlayerGui_Image = "rbxassetid://8775655966"
local Successfully_Image = "rbxassetid://7072706620"
local GameLogo_Image = "rbxassetid://12554579229"

local ReplicatedStorage_Text = "Loading ReplicatedStorage"
local Workspace_Text = "Loading Workspace"
local PlayerGui_Text = "Loading PlayerGui"
local Successfully_Text = "Successfully Loaded"
local PleaseWait_Text = "Please Wait"
local Done_Text = "Done"






--== [SERVICE] ==--
local Player = game:GetService("Players").LocalPlayer
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local StarterGui = game:GetService("StarterGui")
local WorkspaceService = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

--== [MODULE] ==--
local Replicated = game:GetService("ReplicatedStorage")
local Folder = Replicated:FindFirstChild("AnimationModule") or Replicated:WaitForChild("AnimationModule")
local Fade = require(Folder.FadeModule)
local Tween = require(Folder.TweenModule)

--== [TWEEN-COLOR] ==--
local Info = TweenInfo.new(
	0.5, -- Time
	Enum.EasingStyle.Quint, -- EasingStyle
	Enum.EasingDirection.InOut, -- EasingDirection
	0, -- RepeatCount (when less than zero the tween will loop indefinitely)
	false, -- Reverses (tween will reverse once reaching it's goal)
	0 -- DelayTime
)

local ReplicatedStorageGoal = {}
ReplicatedStorageGoal.BackgroundColor3 = Color3.fromRGB(52, 152, 219)

local WorkspaceGoal = {}
WorkspaceGoal.BackgroundColor3 = Color3.fromRGB(39, 174, 96)

local MainMenuGoal = {}
MainMenuGoal.BackgroundColor3 = Color3.fromRGB(142, 68, 173)

local SuccessfullyGoal = {}
SuccessfullyGoal.BackgroundColor3 = Color3.fromRGB(192, 57, 43)

--== [FUNCTION] ==--

function TweenColor(Instant, Goal)
	pcall(function()
		local Tween = game:GetService("TweenService"):Create(Instant, Info, Goal)
		Tween:Play()
	end)
end

--== [SETUP] ==--
local PlayerGui = Player.PlayerGui or Player:WaitForChild("PlayerGui")
local Current_time = tick()

ReplicatedFirst:RemoveDefaultLoadingScreen()
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

local success,failed = pcall(function()
	local AddLoadScreen = script.LoadScreen:Clone()
	AddLoadScreen.Parent = PlayerGui

	repeat wait(1) until game:IsLoaded()
	AddLoadScreen.Container.GameLogo.Image = GameLogo_Image
	AddLoadScreen.Container.State.Value = 1
	wait(2)
	AddLoadScreen.Container.CurrentImage.Image = ReplicatedStorage_Image
	AddLoadScreen.Container.CurrentImage.ImageColor3 = Color3.fromRGB(52, 152, 219)
	AddLoadScreen.Container.StatusLabel.Text = ReplicatedStorage_Text
	spawn(function()
		TweenColor(AddLoadScreen.Container.RightDot, ReplicatedStorageGoal)
		TweenColor(AddLoadScreen.Container.CenterDot, ReplicatedStorageGoal)
		TweenColor(AddLoadScreen.Container.LeftDot, ReplicatedStorageGoal)
	end)
	Fade.FadeIn(AddLoadScreen.Container.CurrentImage, 0.2)
	repeat wait(3) until Replicated
	Fade.FadeOut(AddLoadScreen.Container.CurrentImage, 0.3)
	wait(1)
	AddLoadScreen.Container.CurrentImage.ImageColor3 = Color3.fromRGB(39, 174, 96)
	AddLoadScreen.Container.CurrentImage.Image = Workspace_Image
	repeat wait(1) until AddLoadScreen.Container.CurrentImage.IsLoaded
	AddLoadScreen.Container.StatusLabel.Text = Workspace_Text
	spawn(function()
		TweenColor(AddLoadScreen.Container.RightDot, WorkspaceGoal)
		TweenColor(AddLoadScreen.Container.CenterDot, WorkspaceGoal)
		TweenColor(AddLoadScreen.Container.LeftDot, WorkspaceGoal)
	end)
	Fade.FadeIn(AddLoadScreen.Container.CurrentImage, 0.2)
	repeat wait(3) until WorkspaceService
	Fade.FadeOut(AddLoadScreen.Container.CurrentImage, 0.3)
	wait(1)
	AddLoadScreen.Container.CurrentImage.ImageColor3 = Color3.fromRGB(142, 68, 173)
	AddLoadScreen.Container.CurrentImage.Image = PlayerGui_Image
	repeat wait(1) until AddLoadScreen.Container.CurrentImage.IsLoaded
	AddLoadScreen.Container.StatusLabel.Text = PlayerGui_Text
	spawn(function()
		TweenColor(AddLoadScreen.Container.RightDot, MainMenuGoal)
		TweenColor(AddLoadScreen.Container.CenterDot, MainMenuGoal)
		TweenColor(AddLoadScreen.Container.LeftDot, MainMenuGoal)
	end)
	Fade.FadeIn(AddLoadScreen.Container.CurrentImage, 0.2)
	repeat wait(3) until PlayerGui
	Fade.FadeOut(AddLoadScreen.Container.CurrentImage, 0.3)
	wait(1)
	AddLoadScreen.Container.CurrentImage.ImageColor3 = Color3.fromRGB(192, 57, 43)
	AddLoadScreen.Container.CurrentImage.Image = Successfully_Image
	repeat wait(1) until AddLoadScreen.Container.CurrentImage.IsLoaded
	AddLoadScreen.Container.StatusLabel.Text = Successfully_Text
	spawn(function()
		TweenColor(AddLoadScreen.Container.RightDot, SuccessfullyGoal)
		TweenColor(AddLoadScreen.Container.CenterDot, SuccessfullyGoal)
		TweenColor(AddLoadScreen.Container.LeftDot, SuccessfullyGoal)
	end)
	Fade.FadeIn(AddLoadScreen.Container.CurrentImage, 0.2)
	wait(2)
	AddLoadScreen.Container.State.Value = 2
	Fade.FadeOut(AddLoadScreen.Container.RightDot, 0.3)
	Fade.FadeOut(AddLoadScreen.Container.CenterDot, 0.3)
	Fade.FadeOut(AddLoadScreen.Container.LeftDot, 0.3)
	Fade.FadeOut(AddLoadScreen.Container.CurrentImage, 0.3)
	Fade.FadeOut(AddLoadScreen.Container.StatusLabel, 0.3)
	AddLoadScreen.Container.RightDot.Visible = false
	AddLoadScreen.Container.CenterDot.Visible = false
	AddLoadScreen.Container.LeftDot.Visible = false
	AddLoadScreen.Container.StatusLabel.Position = UDim2.new(0.5, 0, 0.9, 0)
	wait(1)
	AddLoadScreen.Container.GameLogo.Visible = true
	Fade.FadeIn(AddLoadScreen.Container.GameLogo, 0.2)
	AddLoadScreen.Container.StatusLabel.Text = PleaseWait_Text
	Fade.FadeIn(AddLoadScreen.Container.StatusLabel, 0.2)
	--
	wait(2)
	AddLoadScreen.Container.StatusLabel.Text = Done_Text
	wait(1)
	Fade.FadeOut(AddLoadScreen.Container.StatusLabel, 1)
	Fade.FadeOut(AddLoadScreen.Container.GameLogo, 1)
	Fade.FadeOut(AddLoadScreen.Container, 1)
	wait(1)
	warn("[ ✅ ] Client took " .. tick() - Current_time .. " to load")
	AddLoadScreen:Destroy()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end)

if failed then
	warn("[ ⭕ ]LoadScreen is not run correctly")
	warn(failed)
end
