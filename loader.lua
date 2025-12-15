-- NateeHubbb Full Script
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

local Window = OrionLib:MakeWindow({Name = "NateeHubbb", HidePremium = false, SaveConfig = true, ConfigFolder = "NateeHubbb"})

-- Player Tab
local PlayerTab = Window:MakeTab({Name = "Player", Icon = "rbxassetid://4483345998", PremiumOnly = false})
PlayerTab:AddSlider({
	Name = "WalkSpeed",
	Min = 16, Max = 500, Default = 16, Color = Color3.fromRGB(0,255,0), Increment = 1, ValueName = "Speed",
	Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end
})
PlayerTab:AddSlider({
	Name = "JumpPower",
	Min = 50, Max = 500, Default = 50, Color = Color3.fromRGB(0,255,0), Increment = 1, ValueName = "Jump",
	Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value end
})

-- Visuals Tab
local VisualsTab = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998", PremiumOnly = false})
VisualsTab:AddToggle({
	Name = "ESP (Players)",
	Default = false,
	Callback = function(Value)
		for _,player in pairs(game.Players:GetPlayers()) do
			if player ~= game.Players.LocalPlayer then
				if Value then
					local highlight = Instance.new("Highlight")
					highlight.Name = "NateeESP"
					highlight.Adornee = player.Character
					highlight.Parent = game.CoreGui
				else
					if player.Character:FindFirstChild("NateeESP") then
						player.Character.NateeESP:Destroy()
					end
				end
			end
		end
	end
})

-- Blox Fruits Tab (placeholder)
local BloxTab = Window:MakeTab({Name = "Blox Fruits", Icon = "rbxassetid://4483345998", PremiumOnly = false})
BloxTab:AddButton({
	Name = "Auto Farm (Dummy)",
	Callback = function() print("Blox Fruits AutoFarm started (placeholder)") end
})

-- Credits Tab
local CreditsTab = Window:MakeTab({Name = "Credits", Icon = "rbxassetid://4483345998", PremiumOnly = false})
CreditsTab:AddLabel("NateeHubbb by NateeDev")
CreditsTab:AddLabel("Universal Script Loader")

OrionLib:Init()
