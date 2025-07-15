local dialogType = require(script.Parent.dialogType)
local phrase = require(script.Parent.phrase)
local textShowAnimation = require(script.Parent.textShowAnimation)

--[[
	# Dialog class
]]
local dialog = {}

export type Dialogue = dialogType.DialogueStruct & typeof(dialog)

--[[
	Next phrase
]]
function dialog.Next(self: Dialogue): boolean
	if self.CurrentPhrase < #self.phrases then
		self:SetPhrase(self.CurrentPhrase + 1)
		return true
	else
		warn("Dialog phrases ended")
		return false
	end
end

--[[
	Set current phrase
]]
function dialog.SetPhrase(self: Dialogue, i: number)
	self.CurrentPhrase = i
	local newPhrase = self.phrases[i]

	self.CharFace.Image = "http://www.roblox.com/asset/?id="
		.. newPhrase.Char.FaceImageID

	self:TextShowAnimation(newPhrase)

	self.PhraseChangeEvent:Fire()
end

--[[
	Destroy dialog
]]
function dialog.Destroy(self: Dialogue)
	self.PhraseChangeEvent:Destroy()
	self.CharFace:Destroy()
	self.Text:Destroy()

	table.clear(self)
end

--[[
	Dialog constructor

	`Phrases` - list of phrases

	
]]
function dialog.new(
	MainFrame: Frame,
	Phrases: { phrase.Phrase }?,
	Default: string?,
	TextShowAnimation: ((self: Dialogue, phrase: phrase.Phrase) -> nil)?
): Dialogue
	local PhraseChangeEvent = Instance.new("BindableEvent")

	local self: dialogType.DialogueStruct = {
		CurrentPhrase = 0,
		phrases = Phrases or {},
		Default = Default or "none",
		CharFace = Instance.new("ImageLabel"),
		Text = Instance.new("TextLabel"),
		MainFrame = MainFrame,
		TextShowAnimation = TextShowAnimation
			or textShowAnimation.Default,
		PhraseChangeEvent = PhraseChangeEvent,
		PhraseChange = PhraseChangeEvent.Event,
	}

	self.Text.Size = UDim2.fromScale(0.7, 1)
	self.Text.TextScaled = true
	self.Text.BackgroundTransparency = 1
	self.Text.Parent = MainFrame

	self.CharFace.Size = UDim2.fromScale(0.3, 1)
	self.CharFace.ScaleType = Enum.ScaleType.Fit
	self.CharFace.BackgroundTransparency = 1
	self.CharFace.Parent = MainFrame

	setmetatable(self, { __index = dialog })

	return self
end

return dialog
