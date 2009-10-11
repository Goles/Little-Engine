/*
 *  EmiterFunctions.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 9/27/09.
 *  Copyright 2009 Gando Games All rights reserved.
 *
 */

typedef enum
{
	kEmmiterFX_none = 0,
	kEmmiterFX_linear,
} EmmiterFX;

typedef enum
{
	kParticleSystemFX_smallFire = 0,
	kParticleSystemFX_mediumFire,
	kParticleSystemFX_bigFire,
	kParticleSystemFX_smallFireExplosion,
	kParticleSystemFX_mediumFireExplosion,
	kParticleSystemFX_bigFireExplosion,
	kParticleSystemFX_smallFireFountain,
	kParticleSystemFX_mediumFireFountain,
	kParticleSystemFX_bigFireFountain,
} ParticleSystemFX;

/*
 *This function gives me the Y coordinate when I apply a linear emition.
 */
static inline float giveLinearPositionY(float x, float slopeM, float interceptN)
{
	return(x*slopeM + interceptN);
}
