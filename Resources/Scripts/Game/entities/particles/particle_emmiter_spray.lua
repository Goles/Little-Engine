Emmiter = 
{
	components = 
	{
		gecParticleSystem =
		{
			duration = 20.0,
			texture = "Particle2.pvr",	
			emissionRate = 100.0,
			particle_size = 0.40,
--			emissionMode = 
			emissionRateVariance = 0.0,
			originVariance = 2.0,
			lifeVariance = 5.0,
			speedVariance = 5.0,
			decayVariance = 2.0,

			defaultParticle = 
			{
				position = {x=64 , y=240 },
				speed = {x=100 , y=0 },
				life = 10,
				decay = 10,
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

