/*
 *  EmiterFunctions.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 9/27/09.
 *  Copyright 2009 Gando Games All rights reserved.
 *
 */

#ifndef _EMITTER_FUNCTIONS_H_
#define _EMITTER_FUNCTIONS_H_

typedef enum
{
	kEmmiterFX_none = 0,
	kEmmiterFX_linear,
} EmmiterFX;

typedef enum
{
	kParticleSystemFX_FireSmall = 0,
	kParticleSystemFX_FireMedium,
	kParticleSystemFX_FireBig,
	kParticleSystemFX_ExplosionSmall,
	kParticleSystemFX_ExplosionMedium,
	kParticleSystemFX_ExplosionBig,
	kParticleSystemFX_FountainSmall,
	kParticleSystemFX_FountainMedium,
	kParticleSystemFX_FountainBig,
	kParticleSystemFX_FountainGiant,	
	kParticleSystemFX_Smoke,
} ParticleSystemFX;

/*
 *This function gives me the Y coordinate when I apply a linear emition.
 */
static inline float giveLinearPositionY(float x, float slopeM, float interceptN)
{
	return(x*slopeM + interceptN);
}

#endif