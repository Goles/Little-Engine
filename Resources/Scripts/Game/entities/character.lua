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

				local c = this:component("gecAnimatedSprite")
				c:setCurrentAnimation("S_STAND")
				
				if(in_data == "World_1") then
					-- this is level "CoolScene" manage special according to this level.
					playBackgroundMusic("sonic_theme.mp3")
				end

				action = MoveToAction()
				action:startWithTarget(this)
				action:setDuration(10.0)
				action:setEndPoint(ggp(200.0, 200.0))
				addAction(action)

			--
			--	EVENT DRAG GAMEPAD
			--
			elseif (in_event == "E_DRAG_GAMEPAD") then
				
				local fsm = this:component("gecFSM")
				
				fsm:performAction("A_DRAG_GAMEPAD")	
				
				-- flip the entity if needed
				this.flipped = in_data.dx_negative
				
				-- Update entity position
				local delta_speed = in_data.delta * this.speed
				local movement_x = delta_speed * in_data.latest_speed.x
				local movement_y = delta_speed * in_data.latest_speed.y
			
				
				if(fsm.currentState ~= "S_ATTACK") then
										
					this.x = round(this.x + movement_x)
					this.y = round(this.y + movement_y)
					
					-- Broadcast a character moved event
					broadcast("E_CHARACTER_MOVED", {x=this.x, y=this.y, flipped=this.flipped})
				end
			
			--
			--	EVENT CHARACTER MOVED
			--
			elseif(in_event == "E_CHARACTER_MOVED") then
				
				-- Update the Camera
				this:component("gecFollowingCamera").x = this.x
				this:component("gecFollowingCamera").y = this.y			
			
			--
			--	EVENT STOP GAMEPAD
			--
			elseif (in_event == "E_STOP_GAMEPAD") then
				
				this:component("gecFSM"):performAction("A_STOP_GAMEPAD")
			
			--
			--	EVENT BUTTON PRESS
			--
			elseif (in_event == "E_BUTTON_PRESS") then
								
				if (in_data.label == "BUTTON_ATTACK") then					
					this:component("gecFSM"):performAction("A_ATTACK")
										
					-- Broadcast an Attack Event for the Weapon Game Entity to manage					
					broadcast("E_CHARACTER_ATTACK", {flipped=this.flipped; x=this.x, y=this.y})
				end
				
			--
			--	EVENT ANIMATION FINISH
			--
			elseif (in_event == "E_ANIMATION_FINISH") then
				
				if (in_data.animation_label == "S_ATTACK" and in_data.owner_ge_uid == this.id) then					
					
					this:component("gecFSM"):performAction("A_STOP_ATTACK")
					
					-- broadcast a character attack stop event
					broadcast("E_CHARACTER_ATTACK_STOP", {flipped=this.flipped})
									
				end

			--
			-- EVENT STATE CHANGE
			--
			elseif (in_event == "E_STATE_CHANGE") then
				
				local gec = this:component("gecAnimatedSprite")							
				gec:setCurrentAnimation(in_data)
				
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
				{"character_ss_alpha.png", 110, 110, 0.0, 1.0}
			},
			animations =
			{
				-- Animation id (matches state names), Animation spritesheet coords, Animation frame duration.
				-- {label=, coords=, duration= , sheet= , repeats=, pingpong= }
				{"S_STAND", {0,0,1,0,2,0,3,0,4,0}, 0.05, "character_ss_alpha.png", true, true},				
				{"S_WALK", {5,0,6,0,7,0,8,0,0,1,1,1}, 0.10, "character_ss_alpha.png", true, false},
				{"S_ATTACK",{8,1,0,2,1,2,2,2,3,2}, 0.030, "character_ss_alpha.png", false, false},
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
		
		-- Following Camera component
		gecFollowingCamera =
		{			
			follow_x = true,
			follow_y = true,
					
			death_zone = 
			{
				x_treshold = 120,
				y_treshold = 120,
			},
		},
	},
		
	-- Atributes for this entity ( this should slowly dissappear )
	attributes =
	{
		speed = 120
	},
}

return Character