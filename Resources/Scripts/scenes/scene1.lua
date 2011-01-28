Level1 = 
{
	label = "Level_1",
	entities =
	{	
		-- Main Character.
		{file="character.lua", position={x=250, y=60}},
		
		-- Main Character weapon slot
		{file="weapon_1.lua", position={x=250, y=60}},
		
		-- Enemies
		{file="hitter_1.lua"; position={x=100, y=100}},
		{file="hitter_1.lua"; position={x=100, y=150}},
		{file="hitter_1.lua"; position={x=100, y=200}},
		{file="hitter_1.lua"; position={x=100, y=250}},
		{file="hitter_1.lua"; position={x=200, y=150}},
		{file="hitter_1.lua"; position={x=200, y=200}},
		{file="hitter_1.lua"; position={x=300, y=180}},
		{file="hitter_1.lua"; position={x=400, y=180}},
		{file="hitter_1.lua"; position={x=460, y=180}},
		{file="hitter_1.lua"; position={x=300, y=120}},

		-- GUI
		{file="joypad_1.lua"; position={x=60, y=60}},
		{file="button_attack.lua"; position={x=430, y=60}},
	},
}

return Level1