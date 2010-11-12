require "PrimitiveBuilder" -- Primitive builder could use a better name
require "tableprint"

-- Build a gecAnimatedSprite
function gecAnimatedSpriteBuild(t)
	assert(t.spritesheets, "*** A gecAnimatedSprite should contain at least 1 SpriteSheet")
	assert(t.animations, "*** A gecAnimatedSprite should contain at least 1 Animation")
	
	gec = gecAnimatedSprite()	
	spritesheetsTable = {}
	animationsTable = {}
	
	for k,v in ipairs(t.spritesheets) do
		spritesheetsTable[v[1]] = spriteSheetBuild(v)
	end

	for i,v in ipairs(t.animations) do
	 	animationsTable[v[1]] = animationTableBuild(t.animations[i])
	end
	
	flag = 0
	
	for k,v in pairs(animationsTable) do
		gec:addAnimation(v.name, 
						 v.coordinates,
						 v.frameDuration, 
						 spritesheetsTable[v.spritesheetName])	
		
		if(flag == 0) then		
			gec:setCurrentAnimation(v.name)
			flag = 1
		end
			
	end
	
	return gec
end

-- Function table with { Key, function() } for each component builder.
component_function_table = 
{
	["gecAnimatedSprite"] = gecAnimatedSpriteBuild,
}