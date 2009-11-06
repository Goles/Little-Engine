//
//  ParticleEmitter.m
//  Particles_2
//
//  Created by Nicolas Goles on 9/23/09.
//  Copyright 2009 Gando-Games All rights reserved.
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

- (void) setSystemXInitialSpeed:(float) inXSpeed 
				  initialYSpeed:(float) inYSpeed 
						 xAccel:(float) inXAccel 
						 yAccel:(float) inYAccel
				 xAccelVariance:(float) inXAccelVariance
				 yAccelVariance:(float) inYAccelVariance
					   xGravity:(float) inXGravity
					   yGravity:(float) inYGravity
					   lifeTime:(float) inLifeTime
			   lifespanVariance:(float) inLifespanVariance
						 source:(CGPoint) inSource
				 decreaseFactor:(float) inDecreaseFactor
					   position:(CGPoint) inPosition
						   size:(float) inSize
					 startColor:(Color3D) inStartColor
					   endColor:(Color3D) inEndColor
{
	if(array)
	{
		for(int i = 0; i < [(ParticleSystem *)delegate particleNumber]; i++)
		{
			[array[i] setXInitialSpeed:inXSpeed];
			[array[i] setYInitialSpeed:inYSpeed];
			[array[i] setXAccel:inXAccel];
			[array[i] setYAccel:inYAccel];
			[array[i] setXAccelVariance:inXAccelVariance];
			[array[i] setYAccelVariance:inYAccelVariance];
			[array[i] setXGravity:inXGravity];
			[array[i] setYGravity:inYGravity];
			[array[i] setLifeTime:inLifeTime];
			[array[i] setStartingLifeTime:inLifeTime];
			[array[i] setLifespanVariance:inLifespanVariance];
			[array[i] setSource:inSource];
			[array[i] setDecreaseFactor:inDecreaseFactor];
			[array[i] setPosition:inPosition];
			[array[i] setSize:inSize];
			[array[i] setStartColor:inStartColor];

			/*We must calculate the delta from which the startColor will transform in End Color.*/
			[array[i] setDeltaColor:Color3DMake((inEndColor.red - inStartColor.red), 
												(inEndColor.green - inStartColor.green), 
												(inEndColor.blue - inStartColor.blue), 
												0)];
			/*Finally we must reset the particle for it to take initial positions.*/
			[array[i] reset];
			
		}
	}
}

- (void) update
{
	/*for(int i = 0; i < [(ParticleSystem *)delegate particleNumber]; i++)
	{

	}*/
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