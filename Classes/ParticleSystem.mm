/*
 *  ParticleSystems.mm
 *  Particles_2
 *
 *  Created by Nicolas Goles on 11/5/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include "ParticleSystem.h"
#include <iostream>

ParticleSystem::ParticleSystem(int inParticleNumber, BOOL isContinuous, int kRenderingMode)
{
	particleNumber	= inParticleNumber;
	isActive		= true;
	
	/* 1) Allocate the  system's particles array*/
	array = (Particle **)malloc(particleNumber * sizeof(Particle *));
	
	for(int i = 0; i < particleNumber; i++)
	{
		array[i] = [[Particle alloc] init];
	}
	
	/* 2) Allocate the system's renderer */
	systemRenderer	= [[ParticleRenderer alloc] initWithSystemReference:this particlesArray:array particles:inParticleNumber type:kRenderingMode];

	/* 3) Allocate the system's Emitter */
	systemEmitter	= [[ParticleEmitter alloc] initWithParticleNumber:particleNumber particlesArray:array];
	
	/* 4) Allocate the system's Controller */
	//systemController = [[ParticleController alloc] initWithDelegate:self];
	
	/* 5) We set the if the emitter will be continuous or not */
	[systemRenderer setContinuousRendering:isContinuous];
	
}

#pragma mark action_methods
void ParticleSystem::draw()
{
	if(isActive)
		[systemRenderer draw];	
}

void ParticleSystem::update()
{
	if (isActive) 
		[systemRenderer update];
}

#pragma mark setters
void ParticleSystem::setIsActive(bool inIsActive)
{
	isActive = inIsActive;
}

void ParticleSystem::setX(float inX)
{
	//x is inherited from GameEntity
	x = inX;
}

void ParticleSystem::setY(float inY)
{
	//y is inherited from GameEntity
	y = inY;
}

#pragma mark getters
unsigned int ParticleSystem::getParticleNumber()
{
	return particleNumber;
}

Particle** ParticleSystem::getParticlesArray()
{
	return(array);
}

ParticleEmitter* ParticleSystem::getParticleEmitter()
{
	return systemEmitter;
}

ParticleController* ParticleSystem::getParticleController()
{
	return systemController;
}

ParticleRenderer* ParticleSystem::getParticleRenderer()
{
	return systemRenderer;
}

float ParticleSystem::getX()
{
	return x;
}

float ParticleSystem::getY()
{
	return y;
}

#pragma mark destructor
ParticleSystem::~ParticleSystem()
{
	[systemEmitter release];

	//[systemController release];
	
	[systemRenderer release];

	for(int i = 0; i < particleNumber; i++)
	{
		[array[i] release];
	}
	
	free(array);
}
