Emmiter = 
{
	components = 
	{
		gecParticleSystem =
		{
			duration = 30.0,
			texture = "Particle2.pvr",	
			emissionRate = 50.0,
			particle_size = 0.40,
--			emissionMode = 
			emissionRateVariance = 0.0,
			originVariance = 5.0,
			lifeVariance = 5.0,
			speedVariance = 5.0,
			decayVariance = 2.0,

			defaultParticle = 
			{
				position = {x=100 , y=100}, -- this should be removed.
				speed = {x=75 , y=0 },
				life = 10,
				decay = 5,
				color_R = 255,
				color_G = 127,
				color_B = 77,
				color_A = 255,
				rotation = 1,
			},
		},
	},
}

return Emmiter

