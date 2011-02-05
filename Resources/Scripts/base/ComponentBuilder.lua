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
				
		if newState then 
					
			if( oldState ~= newState ) then
				this.currentState = newState

				-- broadcast an event letting an entity know that it's state changed			
				this.ownerGE:handle_event("E_STATE_CHANGE", newState)
			
			end
			
		end

	end
	
	return fsm
end

--
--	Build a gecBoxCollisionable
--
function gecBoxCollisionableBuild(t)
	
	assert(t.size, "You need to define a size = {width=, height=} to build a gecBoxCollisionable component")
	
	gbc = gecBoxCollisionable()
	
	-- The gecBoxCollisionable will be a non-solid box by default
	if not t.solid  then
		gbc.solid = false		
	else
		gbc.solid = t.solid
	end	
	
	gbc:setSize( ggs(t.size.width, t.size.height) )
	
	return gbc

end

--
--	Build a gecFollowingCamera
--
function gecFollowingCameraBuild(t)
	camera = gecFollowingCamera()
	
	if t.eye then
		
		local v_eye = Vector3D()
		v_eye.x = t.eye.x
		v_eye.y = t.eye.y
		v_eye.z = t.eye.z
		camera:setEye(v_eye)
		
	end
	
	if t.center then
		
		local v_center = Vector3D()
		v_center.x = t.center.x
		v_center.y = t.center.y
		v_center.z = t.center.y
		camera:setCenter(v_center)
		
	end

	if t.up then
		
		local v_up = Vector3D()
		v_up.x = t.up.x
		v_up.y = t.up.y
		v_up.z = t.up.z
		camera:setUp(v_up)

	end
	
	return camera
end

-- =================================================================== --
-- Function table with { Key, function() } for each component builder. --
-- =================================================================== --
component_function_table = 
{
	["gecAnimatedSprite"] = gecAnimatedSpriteBuild,
	["gecFSM"] = gecFSMBuild,
	["gecBoxCollisionable"] = gecBoxCollisionableBuild,
	["gecButton"] = gecButtonBuild,
	["gecFollowingCamera"] = gecFollowingCameraBuild,
	["gecJoystick"] = gecJoystickBuild,
}