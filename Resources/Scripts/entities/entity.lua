-- Never use the reserved keyword "GameEntity"
TestEntity = 
{	
	components = 
	{
		gecAnimatedSprite =
		{
			spritesheets = 
			{
				{"hitter1_1.png", 80, 80, 0.0, 1.0}
			},
			animations =
			{
				-- Animation name, Animation spritesheet coords, Animation frame duration.
				{"stand", {0,0,1,0,2,0,3,0}, 0.10, "hitter1_1.png"},
				{"walk", {4,0,5,0,6,0,7,0}, 0.10, "hitter1_1.png"},
				{"attack",{8,0,9,0,10,0}, 0.08, "hitter1_1.png"},
			},
		}
	}
}

return TestEntity
