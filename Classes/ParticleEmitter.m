//
//  ParticleEmitter.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ParticleEmitter.h"
#import "EmitterFunctions.h"
#import "ParticleSystem.h"
#import "Particle.h"

@implementation ParticleEmitter

@synthesize delegate;
@synthesize emitionSource;

- (id) initWithDelegate:(id)inDelegate
{
	if((self = [super init]))
	{
		delegate = inDelegate;
		
		if(delegate)
		{
			if(!array)
				[self setArrayReference];
			
			emitionSource = CGPointZero;
			emitionEnd	  = CGPointZero;
			slopeM		  = 0.0;
			interceptN	  = 0.0;
			currentFX	  = -1;
		}
	}
	
	return self;
}

- (void) setArrayReference
{	
	array = [(ParticleSystem *)delegate array];
}

- (void) setSystemXSpeed:(float) inXSpeed 
				  ySpeed:(float) inYSpeed 
				  xAccel:(float) inXAccel 
				  yAccel:(float) inYAccel 
				lifeTime:(float) inLifeTime 
				  source:(CGPoint) inSource 
				position:(CGPoint) inPosition
{
	if(array)
	{
		for(int i = 0; i < [(ParticleSystem *)delegate particleNumber]; i++)
		{
			[array[i] setXSpeed:inXSpeed];
			[array[i] setYSpeed:inYSpeed];
			[array[i] setXAccel:inXAccel];
			[array[i] setYAccel:inYAccel];
			[array[i] setLifeTime:inLifeTime];
			[array[i] setSource:inSource];
			[array[i] setPosition:inPosition];
		}
	}
}

- (void) update
{
	for(int i = 0; i < [(ParticleSystem *)delegate particleNumber]; i++)
	{
		if(array[i].lifeTime > 0.0)
		{	
			[array[i] update];
		}
		else {
			[array[i] reset];
		}
	}
}

#pragma mark SpecialFX
/*
 *Set Current FX: Change the special FX being Applied to the system.
 */
- (void) setCurrentFX:(int)fx withSource:(CGPoint)inSource andEnd:(CGPoint)inEnd
{
	currentFX = fx;
	
	switch (currentFX) {
		case kEmmiterFX_none:
			emitionSource = inSource;
			break;
		case kEmmiterFX_linear:
			emitionSource	= inSource;
			emitionEnd		= inEnd;
			[self calculateLinearEmission];
		default:
			break;
	}
	
	[self updateEmitionSource];
}



/*
 *The first FX allows to emit particles following a rect between a source CGPoint and an End CGPoint
 */
- (void) calculateLinearEmission
{
	//We calculate the slope and the intercept.
	slopeM		= (emitionEnd.y - emitionSource.y)/(emitionEnd.x - emitionSource.y);
	interceptN	= (emitionSource.y - slopeM*emitionSource.x);
}

- (void) setEmitionEnd:(CGPoint) end
{
	emitionEnd = end;
}

- (void) updateEmitionSource
{
	//emitionSource = source;
	
	if(!array)
		[self setArrayReference];
	
	for(int i = 0; i < [(ParticleSystem *)delegate particleNumber]; i++)
	{
		
		switch (currentFX) 
		{
			case kEmmiterFX_none:
				[array[i] setSource:emitionSource];
				break;
			case kEmmiterFX_linear:
				if (!calculatedInterpolation) {
					linearInterpolation = sqrt((emitionEnd.x - emitionSource.x)*(emitionEnd.x - emitionSource.x) + (emitionEnd.y - emitionSource.y)*(emitionEnd.y - emitionSource.y))/[(ParticleSystem *)delegate particleNumber];
					calculatedInterpolation = YES;
					NSLog(@"Linear Interpolation: %f",linearInterpolation);
					NSLog(@"Distance: %f", linearInterpolation * [(ParticleSystem *)delegate particleNumber]);
				}
				[array[i] setSource:CGPointMake(emitionSource.x += linearInterpolation/2, giveLinearPositionY(emitionSource.x += linearInterpolation/2, slopeM, interceptN))];
				break;

			default:
				break;
		}
	}
	calculatedInterpolation = NO;			 
}

- (void) dealloc
{
	[super dealloc];
}

@end
