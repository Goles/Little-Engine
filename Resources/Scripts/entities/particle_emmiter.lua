Emmiter = 
{
	components = 
	{
		gecParticleSystem =
		{
			duration = 10.0,
			texture = "Particle2.pvr",	
			emissionRate = 10.0,
			particle_size = 0.5,
--			emissionMode = 
			emissionRateVariance = 2.0,
			originVariance = 5.0,
			lifeVariance = 8.0,
			speedVariance = 100.0,
			decayVariance = 2.0,

			defaultParticle = 
			{
				position = {x=160 , y=240 },
				speed = {x=100 , y=0 },
				life = 20,
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

