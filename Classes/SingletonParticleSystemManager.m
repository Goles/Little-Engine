//
//  SingletonParticleSystemManager.m
//  Particles_2
//
//  Created by Nicolas Goles on 10/10/09.
//  Copyright 2009 Gando-Games All rights reserved.
//

#import "ParticleSystemManagerFunctions.h"
#import "SingletonParticleSystemManager.h"
#import "OpenGLCommon.h"
#import "EmitterFunctions.h"
#import "RenderingFunctions.h"
#import "ParticleSystem.h"
#import "ParticleEmitter.h"
#import "ParticleRenderer.h"


/*
 *
 * Singleton declaration according to Apple's own documentation
 * http://developer.apple.com/mac/library/documentation/Cocoa/Conceptual/CocoaFundamentals/CocoaObjects/CocoaObjects.html
 */

static SingletonParticleSystemManager *sharedParticleSystemManager = nil;
 
@implementation SingletonParticleSystemManager

- (id) init
{
	if((self = [super init]))
	{
		_systemsList = NULL;
	}
	
	return self;
}

#pragma mark singleton
/*Method to obtain the singleton instance*/
+ (SingletonParticleSystemManager *) sharedParticleSystemManager
{
	@synchronized(self)
	{
		if (!sharedParticleSystemManager)
			sharedParticleSystemManager = [[self alloc] init];
	}
	
	return sharedParticleSystemManager;
}

/*Overload alloc to only let our Singleton Instance once.*/
+(id)alloc
{
	@synchronized([sharedParticleSystemManager class])
	{
		NSAssert(sharedParticleSystemManager == nil, @"Attempted to allocate a second instance of a singleton.");
		sharedParticleSystemManager = [super alloc];
		return sharedParticleSystemManager;
	}
	// to avoid compiler warning
	return nil;
}

#pragma mark particlesystem_allocation
- (SystemEntity *) createParticleFX:(int) inParticleFX atStartPosition:(CGPoint) inPosition
{
	ParticleSystem *newSystem;
	
	switch (inParticleFX) 
	{
		/********************************************************	
		 *				FIRE FX		v1.0						*
		 *				_Nicolas Goles Domic - October 16 2009	*
		 ********************************************************/
		case kParticleSystemFX_FireSmall:
			newSystem	= [[ParticleSystem alloc] initWithParticles:50 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:0.5
													   xAccel:0
													   yAccel:0.0
											   xAccelVariance:0.05
											   yAccelVariance:0.01
													 xGravity:0
													 yGravity:0
													 lifeTime:1.0
											 lifespanVariance:0.95
													   source:inPosition 
											   decreaseFactor:20	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 100)
														 size:16
												   startColor:Color3DMake(255, 127, 77, 0)
													 endColor:Color3DMake(255, 127, 77, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			
			break;
		case kParticleSystemFX_FireMedium:
			newSystem	= [[ParticleSystem alloc] initWithParticles:110 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:1
													   xAccel:0
													   yAccel:0.0
											   xAccelVariance:0.05
											   yAccelVariance:0.01
													 xGravity:0
													 yGravity:0
													 lifeTime:1.0
											 lifespanVariance:0.9
													   source:inPosition 
											   decreaseFactor:30	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 100)
														 size:20
												   startColor:Color3DMake(255, 127, 77, 0)
													 endColor:Color3DMake(255, 127, 77, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			
			break;
		case kParticleSystemFX_FireBig:
			newSystem	= [[ParticleSystem alloc] initWithParticles:100 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:1
													   xAccel:0
													   yAccel:0.0
											   xAccelVariance:0.05
											   yAccelVariance:0.05
													 xGravity:0
													 yGravity:0
													 lifeTime:1.5
											 lifespanVariance:1.3
													   source:inPosition 
											   decreaseFactor:35	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 100)
														 size:32
												   startColor:Color3DMake(255, 127, 77, 0)
													 endColor:Color3DMake(255, 127, 77, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
			/********************************************************	
			 *				EXPLOSION FX		v1.0				*
			 *				_Nicolas Goles Domic - October 16 2009	*
			 ********************************************************/
		case kParticleSystemFX_ExplosionSmall:
			newSystem	= [[ParticleSystem alloc] initWithParticles:80 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:0
													   xAccel:0
													   yAccel:0.0
											   xAccelVariance:0.2
											   yAccelVariance:0.2
													 xGravity:0
													 yGravity:0
													 lifeTime:1.5
											 lifespanVariance:1.3
													   source:inPosition 
											   decreaseFactor:8	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 100)
														 size:8
												   startColor:Color3DMake(255, 127, 77, 0)
													 endColor:Color3DMake(255, 127, 77, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		case kParticleSystemFX_ExplosionMedium:
			newSystem	= [[ParticleSystem alloc] initWithParticles:80 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:0
													   xAccel:0
													   yAccel:0.0
											   xAccelVariance:0.5
											   yAccelVariance:0.5
													 xGravity:0
													 yGravity:0
													 lifeTime:1.5
											 lifespanVariance:1.3
													   source:inPosition 
											   decreaseFactor:8	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 100)
														 size:32
												   startColor:Color3DMake(255, 127, 77, 0)
													 endColor:Color3DMake(255, 127, 77, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		case kParticleSystemFX_ExplosionBig:
			newSystem	= [[ParticleSystem alloc] initWithParticles:50 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:0
													   xAccel:0
													   yAccel:0.0
											   xAccelVariance:1
											   yAccelVariance:1
													 xGravity:0
													 yGravity:0
													 lifeTime:1.5
											 lifespanVariance:1.3
													   source:inPosition 
											   decreaseFactor:8	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 100)
														 size:64
												   startColor:Color3DMake(255, 127, 77, 0)
													 endColor:Color3DMake(255, 127, 77, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
		
		
		/********************************************************	
		*			FOUNTAIN FX		v1.0						*
		*			_Nicolas Goles Domic - October 16 2009		*
		********************************************************/
		case kParticleSystemFX_FountainSmall:
			
			newSystem	= [[ParticleSystem alloc] initWithParticles:50 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:3
													   xAccel:0
													   yAccel:0.0
											   xAccelVariance:.1
											   yAccelVariance:0.05
													 xGravity:0
													 yGravity:-0.1
													 lifeTime:5
											 lifespanVariance:4.9
													   source:inPosition 
											   decreaseFactor:5	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 100)
														 size:16
												   startColor:Color3DMake(255, 127, 77, 0)
													 endColor:Color3DMake(255, 127, 77, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
		
		case kParticleSystemFX_FountainMedium:
			
			newSystem	= [[ParticleSystem alloc] initWithParticles:50 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:4
													   xAccel:0
													   yAccel:0.0
											   xAccelVariance:.1
											   yAccelVariance:0.05
													 xGravity:0
													 yGravity:-0.1
													 lifeTime:5
											 lifespanVariance:4.9
													   source:inPosition 
											   decreaseFactor:5	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 100)
														 size:32
												   startColor:Color3DMake(255, 127, 77, 0)
													 endColor:Color3DMake(255, 127, 77, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		case kParticleSystemFX_FountainBig:
			
			newSystem	= [[ParticleSystem alloc] initWithParticles:50 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:6
													   xAccel:0
													   yAccel:0.0
											   xAccelVariance:.2
											   yAccelVariance:0.05
													 xGravity:0
													 yGravity:-0.15
													 lifeTime:5
											 lifespanVariance:4.9
													   source:inPosition 
											   decreaseFactor:5	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 100)
														 size:64
												   startColor:Color3DMake(255, 127, 77, 0)
													 endColor:Color3DMake(255, 127, 77, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		case kParticleSystemFX_Smoke:
			newSystem	= [[ParticleSystem alloc] initWithParticles:200 continuous:YES renderingMode:kRenderingMode_2xTriangles];
	
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:0.5
													   xAccel:0
													   yAccel:0
											   xAccelVariance:0.01
											   yAccelVariance:0.01
													 xGravity:0
													 yGravity:0
													 lifeTime:2.0
											 lifespanVariance:1.99
													   source:inPosition 
											   decreaseFactor:55	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 100)
														 size:32
												   startColor:Color3DMake(223, 223, 223, 0)
													 endColor:Color3DMake(0, 0, 0, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		default:
			break;
	}
	
	/* We now set the ParticleRenderer Texture to the input Image */
	 
	return([self insertEntity:newSystem]);
}

#pragma mark list_management
/*Inserts an entity System at the beggining of the Linked List*/
- (SystemEntity *) insertEntity:(ParticleSystem *)inSystem
{
	SystemEntity *newElement;
	SystemEntity *currentElement;
	
	newElement = (SystemEntity *)malloc(sizeof(SystemEntity));
	
	newElement->system		= inSystem;
	newElement->nextSystem	= NULL;
	
	currentElement = _systemsList;
	
	/*We insert at the beginning*/
	if(currentElement == NULL) //The list is empty
	{
		currentElement = newElement;
		_systemsList = currentElement;
		
		return (newElement);
	}else{	//The list is non nil
		newElement->nextSystem = currentElement;
		_systemsList = newElement;
		
		return (newElement);
	}
	return nil;
}

/*Inserts an entity System at some specified position in the list from 0 to m-1*/
- (BOOL) removeEntityAtPosition:(int)inPosition
{
	int counter = 0;
	SystemEntity *currentElement	= _systemsList;
	SystemEntity *previousElement	= _systemsList;
	
	while (currentElement != NULL && counter <= inPosition) 
	{
		if(counter == inPosition)
		{
			previousElement->nextSystem = currentElement->nextSystem;
			/* We check if we are freeing the head, if we are, the new head is == previousElement*/
			if(_systemsList == currentElement)
			{
				previousElement = currentElement->nextSystem;
				_systemsList = previousElement;
			}
			
			/*Now free the current element*/
			[(ParticleSystem *)currentElement->system release];
			free(currentElement);
			
			return(YES);
		}		
		previousElement = currentElement;
		currentElement = currentElement->nextSystem;
		
		counter++;
	}
	
	return NO;
}

- (void) printListDebug
{
	SystemEntity *currentElement = _systemsList;
	
	while (currentElement != NULL) 
	{
		printf("Number Of Particles: %d\n",[(ParticleSystem *)currentElement->system particleNumber]);
		
		currentElement = currentElement->nextSystem;
	}
}

- (void) drawSystems
{
	SystemEntity *currentElement = _systemsList;
	
	while (currentElement != NULL) 
	{
		if([(ParticleSystem *)currentElement->system isActive])
		{
			[(ParticleSystem *)currentElement->system update];
			[(ParticleSystem *)currentElement->system draw];
		}
		currentElement = currentElement->nextSystem;
	}
}


#pragma mark dealloc
- (BOOL) deleteEntity:(int) inPosition
{
	return NO;
}

- (void) dealloc
{
	/*Release the whole list here.*/
	
	[super dealloc];
}

@end
