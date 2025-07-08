local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local dialog = require(ReplicatedStorage.shared.dialog)
local phrase = require(ReplicatedStorage.shared.phrase)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui = Players.LocalPlayer.PlayerGui
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromScale(0.5, 0.5)
MainFrame.Parent = ScreenGui

local ch1 = dialog.character.new("0")
local ch2 = dialog.character.new("1")

local phrasesList = {
	dialog.phrase.new("Hello there", ch1),
	dialog.phrase.new("Hello", ch2),
	dialog.phrase.new("aboba", ch1),
	dialog.phrase.new("Goodbye~", ch2)
}

local d = dialog.new(
		MainFrame,
		phrasesList,
		nil,
		function (self: dialog.Dialogue, newPhrase: phrase.Phrase)
			print("setText")
			self.Text.Text = newPhrase.Text
		end
)

for _, _ in pairs(phrasesList) do
	d:Next()
	task.wait(5)
end
