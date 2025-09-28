local dialogType = require(script.Parent.dialogType)
local phrase = require(script.Parent.phrase)

local TextShowAnimations = {}

local function PlayCharSound(newPhrase: phrase.Phrase): Sound
	local sound

	if newPhrase.Char.VoiceSound then
		sound.SoundId = newPhrase.Char.VoiceSound
		sound = Instance.new("Sound")
		sound.Ended:Connect(function()
		sound:Destroy()
	end)

	sound:Play()
	end

	return sound
end

--[[
	Default text show animation
]]
function TextShowAnimations.Default(
	self: dialogType.BaseDialog,
	newPhrase: phrase.Phrase
)
	PlayCharSound(newPhrase)
	self.Text.Text = newPhrase.Text or self.Default
end

--[[
	Print text by single char
]]
function TextShowAnimations.ByChars(
	delay: number?
): dialogType.ShowTextAnimation
	return function(self: dialogType.BaseDialog, newPhrase: phrase.Phrase)
		if not newPhrase.Text then
			newPhrase.Text = self.Default
		end

		self.Text.Text = ""
		for i = 1, #newPhrase.Text do
			self.Text.Text = newPhrase.Text:sub(1, i)
			local t = os.clock()
			
			local b = PlayCharSound(newPhrase)

			if b then
				b.Ended:Wait()
			end

			local a = delay - (os.clock() - t)
			if a > 0 then
				wait(a)
			end
		end
	end
end

return TextShowAnimations
