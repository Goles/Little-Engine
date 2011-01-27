--[[
	ComponentBuilder.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

require "PrimitiveBuilder" -- Primitive builder could use a better name

--
-- Build a gecAnimatedSprite
--
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

--
-- Build a gecJoystick
--
function gecJoystickBuild(t)
	assert(t.shape ~= nil, "To build a joystick a shape should be defined containing x, y, width and height")

	joypad = gecJoystick()
	local shape = ggr(t.shape.x, t.shape.y, t.shape.width, t.shape.height)
	joypad:setShape(shape)
	joypad:setCenter(t.shape.x, t.shape.y)
	
	return joypad
end

--
-- Build a gecButton
--
function gecButtonBuild(t)
	assert(t.shape ~= nil, "To build a gecButton a shape should be defined containing x, y, width and height")
	
	button = gecButton()
	local shape = ggr(t.shape.x, t.shape.y, t.shape.width, t.shape.height)
	button:setShape(shape)
	
	return button
end

--
-- Build a gecFSM
--
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

	-- Assign the states matrix as an fsm value
	fsm.statesMatrix = s_matrix
	
	-- Assign the perform action as an fsm value
	fsm.performAction = function(this, in_action)

		-- Problem here, maybe this way to access a bi-dimensional matrix is incorrect...
		-- double check everything. :) good progress btw.
		local oldState = this.currentState
		local newState = this.statesMatrix[oldState][in_action]
		
		if( oldState ~= newState ) then
			this.currentState = newState

			-- broadcast an event letting an entity know that it's state changed			
			this.ownerGE:handle_event("E_STATE_CHANGE", newState)
			
		end

	end
	
	return fsm
end

--
--	Build a gecBoxCollision
--
function gecBoxCollisionBuild(t)
	
	assert(t.size, "You need to define a shape = {x=, y=, width=, height=} to build a gecBoxCollision component")
	
	gbc = gecBoxCollision()	
	gbc:setSize( ggs(t.size.width, t.size.height) )
	
	return gbc

end
	

-- =================================================================== --
-- Function table with { Key, function() } for each component builder. --
-- =================================================================== --
component_function_table = 
{
	["gecAnimatedSprite"] = gecAnimatedSpriteBuild,
	["gecFSM"] = gecFSMBuild,
	["gecBoxCollision"] = gecBoxCollisionBuild,
	["gecButton"] = gecButtonBuild,
	["gecJoystick"] = gecJoystickBuild,
}