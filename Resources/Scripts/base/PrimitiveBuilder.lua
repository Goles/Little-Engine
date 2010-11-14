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
		coordinates = makeIntVector(t[2]), 
		frameDuration = makeFloatVector(t[3]),	
		spritesheetName = t[4],
		repeats = t[5],
		pingpong = t[6],
	}
	
	return animationTable
end
