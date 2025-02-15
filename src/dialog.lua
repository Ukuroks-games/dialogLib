
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
export type Dialog = {
	CurrentPhrase: number,

	--[[
		List of phrases in dialog
	]]
	phrases: {
		phrase.Phrase
	},

	--[[
		Frame, where dialog showing
	]]
	MainFrame: Frame,

	CharFace: ImageLabel,
	Text: TextLabel,

	--[[
		Next phrase
	]]
	Next: (self: Dialog)->nil,

	SetPhrase: (self: Dialog, i: number)->nil,

	--[[
		Destroy dialog
	]]
	Destroy: (self: Dialog)->nil,

	PhraseChange: RBXScriptConnection,
	PhraseChangeEvent: BindableEvent
}

function dialog.Next(self: Dialog)
	self:SetPhrase(self.CurrentPhrase + 1)	
end

function dialog.SetPhrase(self: Dialog, i: number)
	self.CurrentPhrase = i
	local phrase = self.phrases[i]

	self.CharFace.Image = "http://www.roblox.com/asset/?id=" .. phrase.Char.FaceImageID

	self.Text.Text = phrase.Text

	self.PhraseChangeEvent:Fire()
end

function dialog.Destroy(self: Dialog)
	self.PhraseChangeEvent:Destroy()
	self.CharFace:Destroy()
	self.Text:Destroy()
end

--[[
	Dialog constructor

	`Phrases` - list of phrases
]]
function dialog.new(Phrases: {phrase.Phrase}, MainFrame: Frame): Dialog

	local PhraseChangeEvent = Instance.new("BindableEvent")

	local self: Dialog = {
		CurrentPhrase = 0,
		phrases = Phrases,
		CharFace = Instance.new("ImageLabel", MainFrame),
		Text = Instance.new("TextLabel", MainFrame),
		MainFrame = MainFrame,
		Next = dialog.Next,
		SetPhrase = dialog.SetPhrase,
		Destroy = dialog.Destroy,
		PhraseChangeEvent = PhraseChangeEvent,
		PhraseChange = PhraseChangeEvent.Event
	}

	self.Text.Size = UDim2.fromScale(0.7, 1)
	self.Text.TextScaled = true
	self.Text.BackgroundTransparency = 1

	self.CharFace.Size = UDim2.fromScale(0.3, 1)
	self.CharFace.ScaleType = Enum.ScaleType.Fit
	self.CharFace.BackgroundTransparency = 1

	return self
end

return dialog
