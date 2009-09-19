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
		position = CGPointMake(320.0/2, 480/2);
		srand([[NSDate date] timeIntervalSince1970]);
		xSpeed = 0;
		ySpeed = 0;
		xAccel = CCRANDOM_0_1()/100;
		yAccel = CCRANDOM_0_1()/10;
		lifeTime = 2.0;
		rotation = 0;
	}
	
	return self;
}

- (void) update
{	
	xSpeed += xAccel;
	ySpeed += yAccel;
	position.x += xSpeed;
	position.y += ySpeed;
	lifeTime -= CCRANDOM_0_1()/15;
	rotation++;
}

- (void) reset
{	
	position = CGPointMake(320.0/2 + 4*CCRANDOM_0_1(), 480/2+ 4*CCRANDOM_0_1());
	xSpeed = 0;
	ySpeed = 0;
	xAccel = CCRANDOM_0_1()/100;
	yAccel = CCRANDOM_0_1()/10;
	lifeTime = 2.0;
}

- (void) dealloc
{
	[super dealloc];
}

@end
