--[[
	ComponentBuilder.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

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
		animation = animationBuild(v, spritesheetsTable[v.spritesheetName])
		gec:addAnimation(v.name, animation)											
			
		if(flag == 0) then		
			gec:setCurrentAnimation(v.name)
			gec:setCurrentRunning(true)
			flag = 1
		end		
	end
	
	return gec
end

-- Build a gecJoystick
function gecJoystickBuild(t)
	assert(t.shape ~= nil, "To build a joystick a shape should be defined containing x, y, width and height")

	joypad = gecJoystick()
	local shape = ggr(t.shape.x, t.shape.y, t.shape.width, t.shape.height)
	joypad:setShape(shape)
	joypad:setCenter(t.shape.x, t.shape.y)
	
	return joypad
end

-- Build a gecFSM
function gecFSMBuild(t)
	
	fsm = gecFSM()
	
	local s_matrix = {}
	
	for k,v in pairs(t.rules) do
					
		if ( s_matrix[ v[1] ] == nil ) then
			s_matrix[ v[1] ] = {}
		end
		
		-- [currentState][inputState] = [outputState]
		s_matrix[ v[1] ][ v[2] ] = v[3]
		
		-- We assign a default current state for the gecFSM only once.
		if(fsm.currentState == nil) then
			fsm.currentState = v[1]
		end
		
	end

	fsm.statesMatrix = s_matrix
	
	return fsm
end

-- Function table with { Key, function() } for each component builder.
component_function_table = 
{
	["gecAnimatedSprite"] = gecAnimatedSpriteBuild,
	["gecJoystick"] = gecJoystickBuild,
	["gecFSM"] = gecFSMBuild,
}