//
//  SingletonParticleSystemManager.m
//  Particles_2
//
//  Created by Nicolas Goles on 10/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SingletonParticleSystemManager.h"
#import "OpenGLCommon.h"
#import "EmitterFunctions.h"
#import "RenderingFunctions.h"
#import "ParticleSystem.h"
#import "ParticleEmitter.h"


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
		/*Small Fire FX initializer*/
		case kParticleSystemFX_smallFire:
			newSystem	= [[ParticleSystem alloc] initWithParticles:10 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			[[newSystem systemEmitter] setSystemXInitialSpeed:0
												initialYSpeed:0
													   xAccel:0
													   yAccel:0.03
											   xAccelVariance:0.1
											   yAccelVariance:0.1
													 xGravity:0
													 yGravity:0
													 lifeTime:0.0
													   source:inPosition 
											   decreaseFactor:20	//Bigger means slower decrease. => Higher life time
													 position:CGPointMake(160, 200)
														 size:64
												   startColor:Color3DMake(255, 127, 77, 0)
													 endColor:Color3DMake(255, 127, 77, 0)];
			
			[[newSystem systemEmitter] setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			
			break;
		case kParticleSystemFX_mediumFire:
			break;
		case kParticleSystemFX_bigFire:
			break;		
		default:
			break;
	}
	
	return([self insertEntity:newSystem]);
}

#pragma mark list_management
/*Inserts an entity System at the beggining of the Linked List*/
- (SystemEntity *) insertEntity:(ParticleSystem *)inSystem
{
	SystemEntity *newElement;
	SystemEntity *currentElement;
	
	newElement = malloc(sizeof(SystemEntity));
	
	newElement->system		= inSystem;
	newElement->isActive	= [inSystem isActive];
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
