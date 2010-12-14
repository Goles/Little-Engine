//
//  ParticleController.m
//  Particles
//
//  Created by Nicolas Goles on 9/18/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

/*
 *
 *	
	The Particle controller is responsible for particle (of the System Array) actions as a set.
 
	Ex: 
		- Rotation around a point.
		- Variable particle sizes.
		- Variable particle colors.
		- Areas around the system to which the particles react in different ways.
		- Collision detection. ( with other objects or particles if necesary)
 *
 */
 
#import "ParticleController.h"
#import "ConstantsAndMacros.h"
#import "Texture2D.h"
#import "Particle.h"

@implementation ParticleController

@synthesize delegate;

- (id) initWithDelegate:(id)inDelegate
{

	if((self = [super init]))
	{
		delegate = inDelegate;

		if(delegate)
		{
			/*Do important stuff here*/
		}
	}
	return self;
}

- (void) dealloc
{	
	free(array);	
	[super dealloc];
}

@end
