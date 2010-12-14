--[[
	PrimitiveBuilder.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

require "base_functions"
require "tableprint"

-- Function table with { Key, function() } for each primitive builder.
primitive_function_table = 
{
	["spritesheets"] = spriteSheetBuild,
	["animations"] = animationTableBuild,
}

-- Build a SpriteSheet
function spriteSheetBuild(t)
	assert(#t == 5, "A SpriteSheet table definition should contain 5 parameters")
			
	ss = SpriteSheet()
  	ss:initWithImageNamed(t[1], t[2], t[3], t[4],t[5])
	return ss
end

-- Build Animation
function animationTableBuild(t)
	assert(#t == 6, "An Animation must be defined by {name, coordinates, frameDurations, spriteSheetName, repeats, pingpong}")
	
	animationTable = 
	{
		name = t[1], 
		coordinates = t[2], --makeIntVector(t[2]), 
		frameDuration = t[3], --makeFloatVector(t[3]),	
		spritesheetName = t[4],
		repeating = t[5],
		pingpong = t[6],
	}
	
	return animationTable
end

function frameBuild(frameImage, frameDelay)
	aFrame = Frame()
	aFrame.image = frameImage
	aFrame.delay = frameDelay
	
	return aFrame
end
	

function animationBuild(animationTable, spriteSheetInstance)
	animation = Animation()

	for i=1, #animationTable.coordinates, 2 do
		
		aFrame = {}	
		
		if(type(animationTable.frameDuration) == "number") then
			aFrame = frameBuild(spriteSheetInstance:getSpriteAtCoordinate(animationTable.coordinates[i], animationTable.coordinates[i+1]), animationTable.frameDuration)
		
		elseif(type(animationTable.frameDuration == "table") and (#animationTable.frameDuration == (#animationTable.coordinates)/2)) then
			aFrame = frameBuild(spriteSheetInstance:getSpriteAtCoordinate(animationTable.coordinates[i], animationTable.coordinates[i+1]), animationTable.frameDuration[i])
					
		else
			print("frameDuration, must have a single value or specify a value for EACH Animation Frame")
			assert(#animationTable.frameDuration == (#animationTable.frameDuration)/2)
		end
		
		animation:addFrame(aFrame)
	end

	animation.repeating = animationTable.repeating
	animation.pingpong = animationTable.pingpong

	return animation
end
