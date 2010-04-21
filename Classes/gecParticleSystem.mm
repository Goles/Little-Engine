/*
 *  ParticleSystems.mm
 *  Particles_2
 *
 *  Created by Nicolas Goles on 11/5/09.
 *  Copyright 2009 GandoGames. All rights reserved.
 *
 */

#include "gecParticleSystem.h"
#include <iostream>

std::string gecParticleSystem::mGECTypeID = "ParticleSystem";

gecParticleSystem::gecParticleSystem(int inParticleNumber, BOOL isContinuous, int kRenderingMode)
{
	particleNumber	= inParticleNumber;
	//isActive		= true;
	
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
void gecParticleSystem::render() const
{
	[systemRenderer draw];	
}

void gecParticleSystem::update(float delta)
{
	[systemRenderer update];
}

#pragma mark setters
void gecParticleSystem::setIsActive(bool inIsActive)
{
	//isActive = inIsActive;
}

#pragma mark getters
unsigned int gecParticleSystem::getParticleNumber()
{
	return particleNumber;
}

Particle** gecParticleSystem::getParticlesArray()
{
	return(array);
}

ParticleEmitter* gecParticleSystem::getParticleEmitter()
{
	return systemEmitter;
}

ParticleController* gecParticleSystem::getParticleController()
{
	return systemController;
}

ParticleRenderer* gecParticleSystem::getParticleRenderer()
{
	return systemRenderer;
}

#pragma mark destructor
gecParticleSystem::~gecParticleSystem()
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
