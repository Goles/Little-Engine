Emmiter = 
{
	components = 
	{
		gecParticleSystem =
		{
			duration = 0.4,
			texture = "Particle2.pvr",	
			emissionRate = 200.0,
			particle_size = 1,
--			emissionMode = 
			emissionRateVariance = 0.0,
			originVariance = 0.0,
			lifeVariance = 0.0,
			speedVariance = 200.0,
			decayVariance = 1.0,

			defaultParticle = 
			{
				position = {x=80 , y=240 },
				speed = {x=0 , y=0 },
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

