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
	
	animationTable = {}
	
	if (t.name ~= nil and
	    t.coords ~= nil and
	    t.frameDuration ~= nil and
	    t.spritesheetName ~= nil and
	    t.repeats ~= nil and
	    t.pingpong ~= nil) 
	
	then
		
		animationTable.name = t.name
		animationTable.coordinates = t.coordinates	
		animationTable.frameDuration = t.frameDuration
		animationTable.spritesheetName = t.spritesheetName
		animationTable.repeating = t.repeats
		animationTable.pingpong = t.pingpong
	
	elseif (t[1] ~= nil and
			t[2] ~= nil and
			t[3] ~= nil and
			t[4] ~= nil and
			t[5] ~= nil and
			t[6] ~= nil) 
	then
	
		animationTable.name = t[1]
		animationTable.coordinates = t[2]
		animationTable.frameDuration = t[3]
		animationTable.spritesheetName = t[4]
		animationTable.repeating = t[5]
		animationTable.pingpong = t[6]
	else
		assert(false, "Error: Problem with animation definition. ( {label=, coords=, duration= , sheet= , repeats=, pingpong= } )")
	end

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
	animation.animation_label = animationTable.name
	
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
