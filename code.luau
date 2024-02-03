local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local SERVER_URL = "http://minecraft-server-url.com" -- Replace with your Minecraft server URL

function sendCoordinates(player)
local character = player.Character
if character then
local humanoid = character:FindFirstChildOfClass("Humanoid")
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
local camera = player:FindFirstChildOfClass("Camera")
if humanoid and humanoidRootPart and camera then
local position = humanoidRootPart.Position
local rootRotation = humanoidRootPart.CFrame - humanoidRootPart.Position
local pitch = math.atan2(-rootRotation.Y, math.sqrt(rootRotation.X^2 + rootRotation.Z^2))
local jaw = math.atan2(rootRotation.X, rootRotation.Z)
local data = {
userId = player.UserId,
x = position.X,
y = position.Y,
z = position.Z,
pitch = math.deg(pitch),
jaw = math.deg(jaw)
}
local jsonData = HttpService:JSONEncode(data)
HttpService:PostAsync(SERVER_URL, jsonData)
end
end
end

function onPlayerAdded(player)
player.CharacterAdded:Connect(function(character)
sendCoordinates(player)
end)
player.CharacterRemoving:Connect(function(character)
-- Player is leaving, handle removal of data or notify server
local data = {
userId = player.UserId,
leaving = true
}
local jsonData = HttpService:JSONEncode(data)
HttpService:PostAsync(SERVER_URL, jsonData)
end)
end
