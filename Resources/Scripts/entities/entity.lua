--[[
	entity.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

-- Never use the reserved keyword "GameEntity"
TestEntity = 
{
	event_data =
	{
		listen_events = 
		{
			"E_SCENE_ACTIVE",
			"E_ROCK",
			"E_EXPLOSION",
			"E_STATE_CHANGE",
			"E_DRAG_GAMEPAD"
		},

		handle_event = function(this, in_event, in_data)
			
			if( in_event == "E_SCENE_ACTIVE" ) then
				
				-- Setup startup animation
				local c = this.components["gecAnimatedSprite"]
				c:setCurrentAnimation("S_STAND")
				c:setCurrentRunning(true)
				c:setCurrentRepeating(true)
				
				if(in_data == "CoolScene") then
					-- this is level "CoolScene" manage special according to this level.
				end
				
			
			elseif (in_event == "E_STATE_CHANGE") then	
							
				print("STATE CHANGED! ".. "in_data")
			

			elseif(in_event == "E_EXPLOSION") then
				print ("E_EXPLOSION")
				
				local c = this.components["gecAnimatedSprite"]
				c:setCurrentAnimation("S_WALK")				
				
			end

		end
	},
	
	-- Component definitions for this Entity
	components = 
	{
		-- Sprite Sheet Animations Component
		gecAnimatedSprite =
		{
			spritesheets = 
			{
				{"hitter1_1.png", 80, 80, 0.0, 1.0}
			},
			animations =
			{
				-- Animation name, Animation spritesheet coords, Animation frame duration.
				-- {id=, coords=, duration= , sheet= , repeats=, pingpong= }
				{"S_STAND", {0,0,1,0,2,0,3,0}, 0.10, "hitter1_1.png", true, true},				
				{"S_WALK", {4,0,5,0,6,0,7,0}, 0.10, "hitter1_1.png", true, false},
				{"S_ATTACK",{8,0,9,0,10,0}, 0.16, "hitter1_1.png", false, false},
			},
		},
		
		-- Finite State Machine Component, a visual tool would help indeed :)
		gecFSM =
		{
			rules =
			{
				-- current state, input action, resulting state.
				{"S_STAND", "A_ATTACK", "S_ATTACK"},
				{"S_STAND", "A_DRAG_GAMEPAD", "S_WALK"},
				{"S_STAND", "A_HIT", "S_HIT"},
				{"S_WALK", "A_DRAG_GAMEPAD", "S_WALK"},
				{"S_WALK", "A_STOP_GAMEPAD", "S_STAND"},
				{"S_WALK", "A_ATTACK", "S_ATTACK"},
				{"S_WALK", "A_HIT", "S_HIT"},
				{"S_ATTACK", "A_STOP_ATTACK","S_STAND"},			
				{"S_ATTACK", "A_ATTACK", "S_ATTACK"},			
				{"S_ATTACK", "A_DRAG_GAMEPAD", "S_ATTACK"},				
				{"S_ATTACK", "A_STOP_GAMEPAD", "S_ATTACK"},				
				{"S_ATTACK", "A_HIT","S_HIT"},
				{"S_HIT", "A_STOP_HIT", "S_STAND"},																	
			},
		},
	},
}

return TestEntity