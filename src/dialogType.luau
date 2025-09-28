local phrase = require(script.Parent.phrase)

--[[
	Base dialog struct for usage
]]
export type BaseDialog = {
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
	PhraseChange: RBXScriptConnection,
}

--[[
	Function that show text (and show animation if needed)
]]
export type ShowTextAnimation = (self: BaseDialog, phrase: phrase.Phrase) -> any?

--[[
	Dialog struct with internal fields
]]
export type DialogueStruct = BaseDialog & {

	--[[

	]]
	TextShowAnimation: ShowTextAnimation,

	PhraseChangeEvent: BindableEvent,
}

return {}