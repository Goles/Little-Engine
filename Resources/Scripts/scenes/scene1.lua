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
--		{file="zero.lua"; position={x=30, y=200}},
		{file="hitter_1.lua"; position={x=120, y=20}},
		{file="hitter_1.lua"; position={x=120, y=100}},
		{file="hitter_1.lua"; position={x=120, y=150}},
		{file="hitter_1.lua"; position={x=120, y=200}},
		{file="hitter_1.lua"; position={x=360, y=150}},
		{file="hitter_1.lua"; position={x=360, y=20}},
		{file="hitter_1.lua"; position={x=360, y=100}},
		{file="hitter_1.lua"; position={x=360, y=150}},
		{file="hitter_1.lua"; position={x=360, y=200}},
		{file="hitter_1.lua"; position={x=0,   y=160}},
		{file="hitter_1.lua"; position={x=480, y=160}},

		-- GUI
		{file="joypad_1.lua"; position={x=60, y=60}},
		{file="button_attack.lua"; position={x=430, y=60}},
	},
}

return Level1