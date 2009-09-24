//
//  ParticleSystem.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ParticleSystem.h"
#import "Particle.h"
#import "ParticleController.h";
#import "ParticleEmitter.h";
#import "ParticleRenderer.h";

@implementation ParticleSystem

@synthesize systemEmitter;
@synthesize particleNumber;
@synthesize array;

- (id) initWithParticles:(int)number
{
	if(self = [super init])
	{
		particleNumber = number;
		
		/* 1) Allocate the  system's particles array*/
		array = (Particle **)malloc(particleNumber * sizeof(Particle *));
		
		for(int i = 0; i < particleNumber; i++)
		{
			array[i] = [[Particle alloc] init];
			[array[i] setXSpeed:99.0f];
		}
		
		/* 2) Allocate the system's renderer */
		systemRenderer	= [[ParticleRenderer alloc] init];
		[systemRenderer setDelegate:self];
		
		/* 3) Allocate the system's Emitter */
		systemEmitter	= [[ParticleEmitter alloc] init];
		[systemEmitter	setDelegate:self];
		
		/* 4) Allocate the system's Controller */
		systemController = [[ParticleController alloc] init];
		[systemController setDelegate:self];
	}
	
	return self;
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
