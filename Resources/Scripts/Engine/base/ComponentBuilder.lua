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

	local joypad = gecJoystick(eventBroadcaster()) -- joypad needs an event broadcaster to communicate
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

	local button = gecButton(eventBroadcaster()) -- gecButton needs an Event Broadcaster to communicate.
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
	
	-- Assign the __index meta method to nil, in order to get nil when
	-- doint fsm.statesMatrix[ "NON-EXISTANT-STATE" ][ "NO EXISTANT STATE" ] 
	local empty = {}
	setmetatable(fsm.statesMatrix, {__index=function() return empty end})
	
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
	
	if t.death_zone then
		
		if t.death_zone.x_treshold ~= nil then			
			camera.death_zone_x = t.death_zone.x_treshold
		end
			
		if t.death_zone.y_treshold ~= nil then
			camera.death_zone_y = t.death_zone.y_treshold	
		end
		
	end
	
	if t.follow_x == true or t.follow_x == false then
		camera.follow_x = t.follow_x
	end
	
	if t.follow_y == true or t.follow_y == false then
		camera.follow_y = t.follow_y
	end
	
	return camera
end

--
--	Build a gecParticleSystem
--
function gecParticleSystemBuild(t)	
	local particleSystem = gecParticleSystem()

	assert(t.defaultParticle ~= nil, "'defaultParticle' can't be nil on gecParticleSystem definition")
	assert(t.duration ~= nil, "'duration' can't be nil on gecParticleSystem definition")
	assert(t.texture ~= nil, "'texture' can't be nil on gecParticleSystem definition")
	assert(t.emissionRate ~= nil, "'emissionRate' can't be nil on gecParticleSystem definition")

	particleSystem.emissionDuration = t.duration;	
	particleSystem.texture = t.texture;
	particleSystem.emissionRate = t.emissionRate;
	
	if t.particle_size ~= nil then
		particleSystem.size = t.particle_size;	
	end
	
	if t.emissionRateVariance ~= nil then
		particleSystem.emissionRateVariance = t.emissionRateVariance;
	end
	
	if t.originVariance ~= nil then
		particleSystem.originVariance = t.originVariance;
	end
	
	if t.lifeVariance ~= nil then
		particleSystem.lifeVariance = t.lifeVariance;
	end
	
	if t.speedVariance ~= nil then
		particleSystem.speedVariance = t.speedVariance;
	end
	
	if t.decayVariance ~= nil then
		particleSystem.decayVariance = t.decayVariance;
	end
	
	local position = ggp(t.defaultParticle.position.x, t.defaultParticle.position.y)
	local speed = ggp(t.defaultParticle.speed.x, t.defaultParticle.speed.y)
	
	particle = makeParticle(position,
						    speed,
							t.defaultParticle.life,
							t.defaultParticle.decay,
							t.defaultParticle.color_R,
							t.defaultParticle.color_G,
							t.defaultParticle.color_B,
							t.defaultParticle.color_A,
							t.defaultParticle.rotation)

	particleSystem:setDefaultParticle(particle)
	return particleSystem
end

--
-- Build a gecImage
--
function gecImageBuild(t)
	local gec = gecImage()
	local image = Image()
	
	assert(t.file, "You need to specify an image name in order to build a gecImage component.")
	
	image:initWithTextureFile(t.file)
	
	gec:setImage(image)
	
	return gec
end

--
-- Build a gecTinyEventScheduler
--
function tinyEventSchedulerBuild(t)
	local gec = gecTinyEventScheduler()	
	return gec
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
	["gecParticleSystem"] = gecParticleSystemBuild,
	["gecImage"] = gecImageBuild,
	["gecTinyEventScheduler"] = gecTinyEventSchedulerBuild,	
}