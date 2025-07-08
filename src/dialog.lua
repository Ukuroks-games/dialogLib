
local phrase = require(script.Parent.phrase)
local character = require(script.Parent.character)

--[[
	# Dialog class
]]
local dialog = {}

dialog.phrase = phrase
dialog.character = character


--[[
	Dialog struct
]]
export type DialogueStruct = {
	--[[
	
	]]
	CurrentPhrase: number,

	--[[
		List of phrases in dialog
	]]
	phrases: { phrase.Phrase },

	--[[
		Frame, where dialog showing
	]]
	MainFrame: Frame,

	--[[

	]]
	CharFace: ImageLabel,

	--[[

	]]
	Text: TextLabel,

	--[[
	
	]]
	Default: string,

	--[[

	]]
	TextShowAnimation: (self: Dialogue, phrase: phrase.Phrase) -> nil,

	--[[
	
	]]
	PhraseChange: RBXScriptConnection,
	PhraseChangeEvent: BindableEvent
}

export type Dialogue = DialogueStruct & typeof(dialog)


dialog.TextShowAnimations = {}

--[[
	Default text show animation
]]
function dialog.TextShowAnimations.Default(self: Dialogue, phrase: phrase.Phrase)
	self.Text.Text = phrase.Text or self.Default
end

--[[
	Print text by single char
]]
function dialog.TextShowAnimations.ByChars(self: Dialogue, phrase: phrase.Phrase)
	if phrase and phrase.Text then
		phrase = {Text = self.Default, Char = phrase.Char}
	end

	self.Text.Text = ""
	for i = 1, #phrase.Text do
		self.Text.Text = phrase.Text:sub(1, i)
		wait(0.064)
	end
end

--[[
	Next phrase
]]
function dialog.Next(self: Dialogue)
	if self.CurrentPhrase < #self.phrases then
		self:SetPhrase(self.CurrentPhrase + 1)
	else
		warn("Dialog phrases ended")
	end
end

function dialog.SetPhrase(self: Dialogue, i: number)
	self.CurrentPhrase = i
	local phrase = self.phrases[i]

	self.CharFace.Image = "http://www.roblox.com/asset/?id=" .. phrase.Char.FaceImageID

	self:TextShowAnimation(phrase)

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
function dialog.new(MainFrame: Frame, Phrases: { phrase.Phrase }?, Default: string?, TextShowAnimation: ((self: Dialogue, phrase: phrase.Phrase) -> nil)? ): Dialogue

	local PhraseChangeEvent = Instance.new("BindableEvent")

	local self: DialogueStruct = {
		CurrentPhrase = 0,
		phrases = Phrases or {},
		Default = Default or "none",
		CharFace = Instance.new("ImageLabel", MainFrame),
		Text = Instance.new("TextLabel", MainFrame),
		MainFrame = MainFrame,
		TextShowAnimation = TextShowAnimation or dialog.TextShowAnimations.Default,
		PhraseChangeEvent = PhraseChangeEvent,
		PhraseChange = PhraseChangeEvent.Event
	}

	self.Text.Size = UDim2.fromScale(0.7, 1)
	self.Text.TextScaled = true
	self.Text.BackgroundTransparency = 1

	self.CharFace.Size = UDim2.fromScale(0.3, 1)
	self.CharFace.ScaleType = Enum.ScaleType.Fit
	self.CharFace.BackgroundTransparency = 1

	setmetatable(self, {__index = dialog})

	return self
end

return dialog
