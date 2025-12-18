-- main.lua | NateeHubb v3
-- Orion UI + Delta Executor compatible
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

local Window = OrionLib:MakeWindow({
	Name = "NateeHubb | Blox Fruits",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "NateeHubb"
})

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Version
local CURRENT_VERSION = "v3.1"

-- SEA DETECTION
local Sea = "Unknown"
local placeId = game.PlaceId
if placeId == 2753915549 then
	Sea = "First Sea"
elseif placeId == 4442272183 then
	Sea = "Second Sea"
elseif placeId == 7449423635 then
	Sea = "Third Sea"
end

OrionLib:MakeNotification({
	Name = "NateeHubb",
	Content = "Detected: " .. Sea,
	Time = 4
})

-- PLAYER TAB
local PlayerTab = Window:MakeTab({Name = "Player", Icon = "rbxassetid://4483345998"})
PlayerTab:AddSlider({Name="WalkSpeed",Min=16,Max=300,Default=16,Callback=function(v)
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.WalkSpeed = v
	end
end})
PlayerTab:AddSlider({Name="JumpPower",Min=50,Max=300,Default=50,Callback=function(v)
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.JumpPower = v
	end
end})
PlayerTab:AddToggle({Name="Infinite Jump",Default=false,Callback=function(v)
	_G.InfJump = v
end})
game:GetService("UserInputService").JumpRequest:Connect(function()
	if _G.InfJump then LocalPlayer.Character.Humanoid:ChangeState("Jumping") end
end})

-- VISUALS TAB
local VisualsTab = Window:MakeTab({Name="Visuals",Icon="rbxassetid://4483345998"})
local FruitESP = false
local function ClearFruitESP()
	for _,v in pairs(Workspace:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("Handle") then
			if v.Handle:FindFirstChild("NateeFruitESP") then v.Handle.NateeFruitESP:Destroy() end
		end
	end
end
local function ApplyFruitESP()
	for _,fruit in pairs(Workspace:GetChildren()) do
		if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
			if not fruit.Handle:FindFirstChild("NateeFruitESP") then
				local hl = Instance.new("Highlight")
				hl.Name = "NateeFruitESP"
				hl.FillColor = Color3.fromRGB(255,0,255)
				hl.OutlineColor = Color3.fromRGB(255,255,255)
				hl.Adornee = fruit
				hl.Parent = fruit.Handle
			end
		end
	end
end
VisualsTab:AddToggle({Name="Fruit ESP",Default=false,Callback=function(v)
	FruitESP=v
	if not v then ClearFruitESP() end
end})
task.spawn(function()
	while task.wait(2) do if FruitESP then pcall(ApplyFruitESP) end end
end)

-- BLOX FRUITS TAB
local BloxTab = Window:MakeTab({Name="Blox Fruits",Icon="rbxassetid://4483345998"})
BloxTab:AddLabel("🌊 Current Sea: "..Sea)
BloxTab:AddButton({Name="Auto Haki",Callback=function()
	pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso") end)
end})

-- MISC TAB
local MiscTab = Window:MakeTab({Name="Misc",Icon="rbxassetid://4483345998"})
MiscTab:AddButton({Name="Anti AFK",Callback=function()
	for _,v in pairs(getconnections(LocalPlayer.Idled)) do v:Disable() end
	OrionLib:MakeNotification({Name="NateeHubb",Content="Anti-AFK Enabled",Time=3})
end})
MiscTab:AddButton({Name="Rejoin Server",Callback=function()
	game:GetService("TeleportService"):Teleport(game.PlaceId,LocalPlayer)
end})

-- CREDITS
local CreditsTab = Window:MakeTab({Name="Credits",Icon="rbxassetid://4483345998"})
CreditsTab:AddLabel("NateeHubb v3")
CreditsTab:AddLabel("By NateeDev")
CreditsTab:AddLabel("No Key System")
CreditsTab:AddLabel("Delta Executor")
CreditsTab:AddLabel("Orion UI")

OrionLib:Init()
