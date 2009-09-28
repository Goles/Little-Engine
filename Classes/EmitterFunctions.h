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


/*
 *This function gives me the Y coordinate when I apply a linear emition.
 */
static inline float giveLinearPositionY(float x, float slopeM, float interceptN)
{
	return(x*slopeM + interceptN);
}
