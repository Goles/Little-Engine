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
				-- deactivate weapon on the move
				this.active = false
				
				local offset = 0
				
				if in_data.flipped == true then
					offset = -30
				else
					offset = 30
				end
				
				-- Update weapon position	
				this.x = in_data.x + offset
				this.y = in_data.y
								
			--
			--	EVENT CHARACTER ATTACK
			--						
			elseif in_event == "E_CHARACTER_ATTACK" then
				-- activate weapon on attack
				this.active = false

			--
			--	EVENT CHARACTER ATTACK STOP
			--
			elseif in_event == "E_CHARACTER_ATTACK_STOP" then
				-- deactivate the weapon on attack stop
				this.active = true		
			end	
					
		end
	},
		
	components = 
	{
		gecBoxCollisionable =
		{
			size = {width=30, height=50}
		}
	},
}

return Weapon1