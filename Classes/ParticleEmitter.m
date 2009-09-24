//
//  ParticleEmitter.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ParticleEmitter.h"
#import "ParticleSystem.h"
#import "Particle.h"

@implementation ParticleEmitter

@synthesize delegate;
@synthesize emitionSource;

- (id) init
{
	if((self = [super init]))
	{
		NSLog(@".");
		/*Stuff happens here.*/
	}
	
	return self;
}

- (void) setEmitionSource:(CGPoint)source
{
	emitionSource = source;
	
	Particle **a = [delegate array];
	
	[(Particle *) a[1] setSource:CGPointMake(1.0, 1.0)];
	
	for(int i = 0; i < [(ParticleSystem *)delegate particleNumber]; i++)
	{
		[a[i] setSource:CGPointMake((float)i, (float)i)];
	}
		 
	for(int i = 0; i < [(ParticleSystem *)delegate particleNumber]; i++)
	{
		NSLog(@"%d-%f,%f",i,[a[i] source].x, [a[i] source].y);
	}
}

- (void) dealloc
{
	[super dealloc];
}

@end
