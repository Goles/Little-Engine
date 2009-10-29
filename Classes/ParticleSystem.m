//
//  ParticleSystem.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 Gando-Games All rights reserved.
//

#import "ParticleSystem.h"
#import "Particle.h"
#import "ParticleController.h"
#import "ParticleEmitter.h"
#import "RenderingFunctions.h"
#import "ParticleRenderer.h"


@implementation ParticleSystem

@synthesize textureBound;
@synthesize isActive;
@synthesize particleNumber;
@synthesize systemRenderer;
@synthesize systemEmitter;
@synthesize array;

- (id) initWithParticles:(int)number
			  continuous:(BOOL)inContinuous
		   renderingMode:(int)kRenderingMode
{
	if(self = [super init])
	{
		particleNumber	= number;
		isActive		= YES;
		
		/* 1) Allocate the  system's particles array*/
		array = (Particle **)malloc(particleNumber * sizeof(Particle *));
		
		for(int i = 0; i < particleNumber; i++)
		{
			array[i] = [[Particle alloc] init];
		}
		
		/* 2) Allocate the system's renderer */
		systemRenderer	= [[ParticleRenderer alloc] initWithDelegate:self particles:particleNumber type:kRenderingMode];
		
		/* 3) Allocate the system's Emitter */
		systemEmitter	= [[ParticleEmitter alloc] initWithDelegate:self];
		
		/* 4) Allocate the system's Controller */
		systemController = [[ParticleController alloc] initWithDelegate:self];
		
		/* 5) We set the if the emitter will be continuous or not */
		[systemRenderer setContinuousRendering:inContinuous];
	}
	
	return self;
}

- (Texture2D *) currentTexture
{
	return ([systemRenderer particleTexture]);
}

- (void) draw
{
	if (isActive)
		[systemRenderer draw];
}

- (void) update
{
	if (isActive) 
		[systemRenderer update];
}

- (Particle **) array
{
	return(array);
}

- (void) dealloc
{
	[systemRenderer release];
	[systemEmitter release];
	[systemController release];
	
	for(int i = 0; i < particleNumber; i++)
	{
		[array[i] release];
	}
	
	free(array);
	
	[super dealloc];
}

@end
