--[[
	# Character class
]]
local character = {}

--[[
	Character struct
]]
export type Character = {
	--[[
		Id of character face image
	]]
	FaceImageID: string,

	--[[
		Sound that sounding where this character soy something.

		Working with text show animation
	]]
	VoiceSound: string?
}

--[[
	Character class constructor
]]
function character.new(faceId: string, voiceSound: string?): Character
	local self: Character = {
		FaceImageID = faceId,
		VoiceSound = voiceSound
	}

	return self
end

return character
