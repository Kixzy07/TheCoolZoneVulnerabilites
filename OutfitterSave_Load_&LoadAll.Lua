local Players = game:GetService("Players")
local LPlr = Players.LocalPlayer
local Backpack = LPlr.Backpack
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AvatarEditor = ReplicatedStorage.AvatarEditor

function SaveOutfit(OutfitTable) -- Saves Outfits in the Concurrent Outfit Table

	if type(OutfitTable) ~= "table" then
		return warn("Table is not a table")
	end
	local OutfitName = OutfitTable.OutfitName
	local ids = OutfitTable.HatIDS
	local Main = {}
	Main.BodyColors = OutfitTable.BodyColors
	Main.Shirt = OutfitTable.Shirt
	Main.Head = OutfitTable.Head
	Main.Pants = OutfitTable.Pants
	Main.Face = OutfitTable.Face
	Main["T-Shirt"] = OutfitTable.TShirt
	Main.Accessories = {}
	local BodyGuardContract = Backpack:FindFirstChild("Bodyguard Contract")
	if not BodyGuardContract then
		local SpawnItem = ReplicatedStorage.SpawnmenuEvents.SpawnItem -- RemoteEvent
		SpawnItem:FireServer("Tools", "Fun", "Bodyguard Contract")
		BodyGuardContract = Backpack:WaitForChild("Bodyguard Contract")
	end
	local Contractor = BodyGuardContract:WaitForChild("Contractor")
	if Contractor.Value == nil then
		local Event = BodyGuardContract.Event -- RemoteEvent
		Event:FireServer(1, Players.LocalPlayer.Name, "1")
	end
	local A = Main.Accessories
	for i, v in ids do
		local T = {}
		T.Id = tonumber(v)
		table.insert(A, T)
	end
	local AvatarSave = AvatarEditor.AvatarSave -- RemoteEvent
	local Target = Backpack:WaitForChild("Bodyguard Contract"):WaitForChild("Contractor")
	AvatarSave:FireServer(OutfitName, Main, Target)
end


function EquipOutfit(OutfitName) -- Equips OutfitName
	local EditorOutfitter_GetAppearance = ReplicatedStorage.EditorOutfitter_GetAppearance -- RemoteFunction
	local TOutfit = LPlr.CustomAvatars:WaitForChild(OutfitName)
	local CustomOutfits = LPlr.PlayerGui.OutfitManager.CustomOutfits
	EditorOutfitter_GetAppearance:InvokeServer(TOutfit,CustomOutfits,true)
	local Apply = ReplicatedStorage.OutfitManager.Apply -- RemoteEvent
	local TOutfit = LPlr.PlayerGui.OutfitManager.CustomOutfits:WaitForChild(OutfitName)
	Apply:FireServer(TOutfit)
end

AvatarEditor.AvatarLoadAll:FireServer() -- Loads all Saved Outfits that were saved ingame

local OutfitTables = {} 
OutfitTables['Template'] = {
	OutfitName = 'Template',
	HatIDS = {--[[HatIds Here]]},
	BodyColors = {
		RightArm = "FFFFFF",
		Head = "FFFFFF",
		RightLeg = "FFFFFF",
		Torso = "FFFFFF",
		LeftArm = "FFFFFF",
		LeftLeg = "FFFFFF"
	},
	Shirt = 0,
	Pants = 0,
	Face = 0,
	TShirt = 0,
	Head = 0,
}

for i, v in OutfitTables do -- Saves Outfits From Table Above
	task.spawn(function()
		SaveOutfit(v)
	end)
end

EquipOutfit("Template") --Equip the Outfit Name Like This