local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local dialogLib = require(ReplicatedStorage.Packages.dialogLib)

local dialog = dialogLib.dialog
local phrase = dialogLib.phrase
local character = dialogLib.character

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Players.LocalPlayer.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromScale(0.5, 0.5)
MainFrame.Parent = ScreenGui

local ch1 = character.new("0")
local ch2 = character.new("1")

local phrasesList = {
	phrase.new("Hello there", ch1),
	phrase.new("Hello", ch2),
	phrase.new("aboba", ch1),
	phrase.new("Goodbye~", ch2)
}

local d = dialog.new(
		MainFrame,
		phrasesList,
		"idk",
		dialogLib.TextShowAnimation.ByChars(0.1)
)

for _, _ in pairs(phrasesList) do
	d:Next()
	task.wait(5)
end

d:Destroy()
