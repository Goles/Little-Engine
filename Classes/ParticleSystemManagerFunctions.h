/*
 *  SingletonParticleSystemManagerFunctions.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 10/10/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#import "ParticleSystem.h"

typedef struct _entity
{
	ParticleSystem	*system;
	struct _entity	*nextSystem;
	BOOL isActive;
} SystemEntity;

/*This is going to be the List containing all the Particle Systems declared here for performance reasons only.*/
SystemEntity *_systemsList;

/*Declared as static inline due to overhead of Obj-C messaging, this draws the particles system*/
static inline void drawSystems()
{
	SystemEntity *currentElement = _systemsList;
	
	while (currentElement != NULL) 
	{
		if(currentElement->isActive)
		{
			[(ParticleSystem *)currentElement->system update];
			[(ParticleSystem *)currentElement->system draw];
		}
		currentElement = currentElement->nextSystem;
	}
}