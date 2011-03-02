Weapon1 =
{
	event_data =
	{
		listen_events =
		{
			"E_CHARACTER_MOVED",
			"E_CHARACTER_ATTACK",
			"E_CHARACTER_ATTACK_STOP",
		},
		
		handle_event = function (this, in_event, in_data)

			--
			--	EVENT CHARACTER MOVED
			--
			if in_event == "E_CHARACTER_MOVED" then
				this.x = in_data.x
				this.y = in_data.y
								
			--
			--	EVENT CHARACTER ATTACK
			--						
			elseif in_event == "E_CHARACTER_ATTACK" then
				this.active = true
				offset = 0

				if in_data.flipped == true then
					offset = -40
				else
					offset = 40
				end
					
				this.x = in_data.x + offset
				this.y = in_data.y

			--
			--	EVENT CHARACTER ATTACK STOP
			--
			elseif in_event == "E_CHARACTER_ATTACK_STOP" then

				-- deactivate the weapon
				this.active = false
				
				-- Reset the weapon position.
				if in_data.flipped == true then
					offset = 40
				else
					offset = -40
				end
				
				this.x = this.x + offset
			
			end			
		end
	},
		
	components = 
	{
		gecBoxCollisionable =
		{
			size = {width=30, height=30}
		}
	},
}

return Weapon1