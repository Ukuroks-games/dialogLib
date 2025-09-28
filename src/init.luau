local character = require(script.character)
local dialog = require(script.dialog)
local dialogType = require(script.dialogType)
local phrase = require(script.phrase)
local textShowAnimation = require(script.textShowAnimation)

export type Dialogue = dialog.Dialogue
export type Phrase = phrase.Phrase
export type Character = character.Character
export type ShowTextAnimation = dialogType.ShowTextAnimation

return {
	dialog	= dialog,
	character	= character,
	phrase	= phrase,
	TextShowAnimation	= textShowAnimation
}
