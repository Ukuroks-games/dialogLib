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
}

--[[
	Chcater class constructor
]]
function character.new(faceId: string): Character
	local self: Character = {
		FaceImageID = faceId,
	}

	return self
end

return character
