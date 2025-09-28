local character = require(script.Parent.character)

--[[
	Phrase class
]]
local phrase = {}

export type Phrase = {
	Text: string,
	Char: character.Character,
}

--[[
	Phrase class constructor
]]
function phrase.new(text: string, char: character.Character): Phrase
	local self: Phrase = {
		Text = text,
		Char = char,
	}

	return self
end

return phrase
