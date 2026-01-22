--Only Works For the LocalPlayer ?
for i,v in game:GetService("Players").LocalPlayer.CustomAvatars:GetChildren() do
	game:GetService("ReplicatedStorage"):WaitForChild("AvatarEditor"):WaitForChild("AvatarDelete"):FireServer(v.Name,Instance.new("Folder", nil))
end
