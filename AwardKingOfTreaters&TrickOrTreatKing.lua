--You'll need to Be on the Map Trickersville have the shop UI Open and on your screen before Executing this
local args = {
    [1] = game:GetService("Players").LocalPlayer.PlayerGui.ShopUI,
    [2] = workspace.Map.Map.Shop.Spooky:FindFirstChild("King of the Treaters")
}

game:GetService("ReplicatedStorage").TrickOrTreatEvents.Shop.Equip:FireServer(unpack(args))


local args = {
    [1] = game:GetService("Players").LocalPlayer.PlayerGui.ShopUI,
    [2] = workspace.Map.Map.Shop.Normal["Trick Or Treat King"]
}

game:GetService("ReplicatedStorage").TrickOrTreatEvents.Shop.Equip:FireServer(unpack(args))