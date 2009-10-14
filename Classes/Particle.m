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
@synthesize xInitialSpeed;
@synthesize yInitialSpeed;
@synthesize xAccel;
@synthesize yAccel;
@synthesize xGravity;
@synthesize yGravity;
@synthesize xAccelVariance;
@synthesize yAccelVariance;
@synthesize lifeTime;
@synthesize startingLifeTime;
@synthesize lifespanVariance;
@synthesize lastLifespan;
@synthesize rotation;
@synthesize decreaseFactor;
@synthesize size;
@synthesize isActive;

- (id) init
{
	if((self = [super init]))
	{
		srand([[NSDate date] timeIntervalSince1970]);
		source			= CGPointZero;
		position		= CGPointZero;
		xSpeed			= xInitialSpeed;
		ySpeed			= yInitialSpeed;
		xAccel			= 0;
		yAccel			= 0;
		xGravity		= 0;
		yGravity		= 0;
		xAccelVariance	= 0;
		yAccelVariance	= 0;
		lifeTime		= 1.0;
		rotation		= 0;
		size			= 16.0;
		isActive		= YES;
	}
	return self;
}


#pragma mark particle_logic
- (void) update
{	
	float kRandom = CCRANDOM_0_1()/decreaseFactor;
	float cachedDiv = kRandom/(lastLifespan+startingLifeTime);
	
	if(lifeTime >= kRandom){
		
		xSpeed		= xSpeed + xAccel + xGravity + xAccelVariance*CCRANDOM_MINUS1_1();
		ySpeed		= ySpeed + yAccel + yGravity + yAccelVariance*CCRANDOM_MINUS1_1();
		position.x	+= xSpeed;
		position.y	+= ySpeed;

		currentColor.red		+= deltaColor.red*cachedDiv;
		currentColor.green		+= deltaColor.green*cachedDiv;
		currentColor.blue		+= deltaColor.blue*cachedDiv;
		
		lifeTime -= kRandom;
		
	}else {
		lifeTime = 0.0;
		isActive = NO;
	}
}

- (void) reset
{	
	position = CGPointMake(source.x + CCRANDOM_MINUS1_1()*5, source.y + CCRANDOM_MINUS1_1()*5);
	xSpeed = xInitialSpeed + xAccelVariance*CCRANDOM_MINUS1_1();
	ySpeed = yInitialSpeed + yAccelVariance*CCRANDOM_MINUS1_1();
	currentColor = startColor;	
	lastLifespan = lifespanVariance*CCRANDOM_MINUS1_1();
	lifeTime = startingLifeTime + lastLifespan;
	isActive = YES;
}

#pragma mark coloring
- (void) setStartColor:(Color3D) inColor
{
	startColor = inColor;
}

- (Color3D) startColor
{
	return startColor;
}

- (void) setDeltaColor:(Color3D) inColor
{
	deltaColor = inColor;
}
- (Color3D) deltaColor
{
	return startColor;
}

- (Color3D) currentColor
{
	return currentColor;
}

- (void) dealloc
{
	[super dealloc];
}

@end
