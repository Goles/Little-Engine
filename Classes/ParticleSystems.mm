/*
 *  ParticleSystems.mm
 *  Particles_2
 *
 *  Created by Nicolas Goles on 11/5/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "ParticleSystems.h"

ParticleSystems::ParticleSystems(int inParticleNumber, BOOL isContinuous, int kRenderingMode)
{
	particleNumber	= inParticleNumber;
	isActive		= YES;
	
	/* 1) Allocate the  system's particles array*/
	array = (Particle **)malloc(particleNumber * sizeof(Particle *));
	
	for(int i = 0; i < particleNumber; i++)
	{
		array[i] = [[Particle alloc] init];
	}
	
	/* 2) Allocate the system's renderer */
	//systemRenderer	= [[ParticleRenderer alloc] initWithDelegate:self particles:particleNumber type:kRenderingMode];
	systemRenderer	= [[ParticleRenderer alloc] initWithParticles:particleNumber type:kRenderingMode];
	[systemRenderer setDelegateReference:this];
	[systemRenderer testDelegateReference];
	/* 3) Allocate the system's Emitter */
	//systemEmitter	= [[ParticleEmitter alloc] initWithDelegate:self];
	
	
	
	/* 4) Allocate the system's Controller */
	//systemController = [[ParticleController alloc] initWithDelegate:self];
	
	/* 5) We set the if the emitter will be continuous or not */
	//[systemRenderer setContinuousRendering:inContinuous];
}

void ParticleSystems::draw()
{
	printf("aq");
	
}

void ParticleSystems::update()
{
	printf("aq");
	
}