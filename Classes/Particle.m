//
//  Particle.m
//  Particles
//
//  Created by Nicolas Goles on 9/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Particle.h"
#import "ConstantsAndMacros.h"

@implementation Particle

@synthesize position;
@synthesize source;
@synthesize xSpeed;
@synthesize ySpeed;
@synthesize xAccel;
@synthesize yAccel;
@synthesize lifeTime;
@synthesize rotation;

- (id) init
{
	if((self = [super init]))
	{
		srand([[NSDate date] timeIntervalSince1970]);
		source		= CGPointZero;
		position	= CGPointZero;
		xSpeed		= 0;
		ySpeed		= 0;
		xAccel		= 0;
		yAccel		= 0;
		lifeTime	= 1.0;
		rotation	= 0;
	}
	return self;
}

- (void) update
{	
	xSpeed		+= xAccel;
	ySpeed		+= yAccel;
	position.x	+= xSpeed;
	position.y	+= ySpeed;
	
	float kRandom = CCRANDOM_0_1();
	
	if(lifeTime >= kRandom/35)
		lifeTime -= kRandom/35;
	else {
		lifeTime = 0.0;
	}
	
	rotation++;
}

- (void) reset
{	
	position = CGPointMake(source.x + CCRANDOM_0_1()*5, source.y +  CCRANDOM_0_1()*10);
	xSpeed = 0;
	ySpeed = 0;
	xAccel = CCRANDOM_0_1()/100;
	yAccel = CCRANDOM_0_1()/10;
	lifeTime = 1.0;
}

- (void) dealloc
{
	[super dealloc];
}

@end
