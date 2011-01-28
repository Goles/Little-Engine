--[[
	entity.lua
	Copyright 2010 Nicolas Goles. All Rights Reserved. 
]]--

Character = 
{
	event_data =
	{
		listen_events = 
		{
			"E_SCENE_ACTIVE",
			"E_DRAG_GAMEPAD",
			"E_STOP_GAMEPAD",
			"E_BUTTON_PRESS",
			"E_STATE_CHANGE",
			"E_ANIMATION_FINISH",
		},

		handle_event = function (this, in_event, in_data)
			
			--
			--	EVENT ACTIVE SCENE
			--
			if (in_event == "E_SCENE_ACTIVE") then

				local c = this.components["gecAnimatedSprite"]
				c:setCurrentAnimation("S_STAND")
				c:setCurrentRunning(true)
				c:setCurrentRepeating(true)
				
				if(in_data == "CoolScene") then
					-- this is level "CoolScene" manage special according to this level.
				end
			
			--
			--	EVENT DRAG GAMEPAD
			--
			elseif (in_event == "E_DRAG_GAMEPAD") then
								
				this.flipHorizontally = in_data.dx_negative
				
				if(fsm ~= nil) then					
					this.components["gecFSM"]:performAction("A_DRAG_GAMEPAD")					
				end
				
				local delta_speed = in_data.delta * this.speed
				local movement_x = delta_speed * in_data.latest_speed.x
				local movement_y = delta_speed * in_data.latest_speed.y
				
				if(fsm.currentState ~= "S_ATTACK") then
					this.x = this.x + movement_x -- + round(movement_x) 
					this.y = this.y + movement_y -- + round(movement_y)
				end
			
			--
			--	EVENT STOP GAMEPAD
			--
			elseif (in_event == "E_STOP_GAMEPAD") then
				
				this.components["gecFSM"]:performAction("A_STOP_GAMEPAD")
			
			--
			--	EVENT BUTTON PRESS
			--
			elseif (in_event == "E_BUTTON_PRESS") then
								
				if (in_data.label == "BUTTON_ATTACK") then					
					this.components["gecFSM"]:performAction("A_ATTACK")
					
					-- Broadcast an Attack Event for the Weapon Game Entity to manage					
					broadcast("E_CHARACTER_ATTACK", {x=this.x, y=this.y})
				end
				
			--
			--	EVENT ANIMATION FINISH
			--
			elseif (in_event == "E_ANIMATION_FINISH") then
				
				if (in_data.animation_label == "S_ATTACK" and in_data.owner_ge_uid == this.id) then					
					this.components["gecFSM"]:performAction("A_STOP_ATTACK")
					
					-- broadcast a character attack stop event
					broadcast("E_CHARACTER_ATTACK_STOP", nil)
									
				end

			--
			-- EVENT STATE CHANGE
			--
			elseif (in_event == "E_STATE_CHANGE") then				
				this.components["gecAnimatedSprite"]:setCurrentAnimation(in_data)
				this.components["gecAnimatedSprite"]:setCurrentRunning(true)				
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
				-- Animation id (matches state names), Animation spritesheet coords, Animation frame duration.
				-- {label=, coords=, duration= , sheet= , repeats=, pingpong= }
				{"S_STAND", {0,0,1,0,2,0,3,0}, 0.07, "hitter1_1.png", true, true},				
				{"S_WALK", {4,0,5,0,6,0,7,0}, 0.07, "hitter1_1.png", true, false},
				{"S_ATTACK",{8,0,9,0,10,0}, 0.08, "hitter1_1.png", false, false},
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
		
		-- Simple box collision component
		gecBoxCollisionable =
		{
			solid = true,
			size = {height=40, width=40},			
		},
	},
	

	
	-- Atributes for this entity ( this should slowly dissappear )
	attributes =
	{
		speed = 120
	},
}

return Character