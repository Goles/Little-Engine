//
//  SharedParticleSystemManager.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SharedParticleSystemManager.h"
#import "OpenGLCommon.h"
#import "EmitterFunctions.h"
#import "RenderingFunctions.h"
#import "ParticleSystem.h"
#import "ParticleEmitter.h"
#import "ParticleRenderer.h"

SharedParticleSystemManager* SharedParticleSystemManager::instance = NULL;

SharedParticleSystemManager* SharedParticleSystemManager::getInstance()
{
	if(instance == NULL)
		instance = new SharedParticleSystemManager();
	
	return instance;
}

#pragma mark action_methods
//Action Methods
SystemEntity*	SharedParticleSystemManager::createParticleFX(int k_InParticleFX, CGPoint inPosition, Image *inImage)
{
	ParticleSystem *newSystem;
	
	switch (k_InParticleFX) 
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
	[[newSystem systemRenderer] setParticleSubTexture:inImage];
	
	
	return(this->insertEntity(newSystem));
}

SystemEntity* SharedParticleSystemManager::insertEntity(ParticleSystem *inSystem) //Creates and inserts a new SystemEntity in the _systemsList
{
	SystemEntity *newElement		= NULL;
	SystemEntity *currentElement	= NULL;
	
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
}

BOOL SharedParticleSystemManager::removeEntityAtPosition(int inPosition)
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

void SharedParticleSystemManager::drawSystems()
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

void SharedParticleSystemManager::printListDebug()
{
	SystemEntity *currentElement = _systemsList;
	
	while (currentElement != NULL) 
	{
		printf("Number Of Particles: %d\n",[(ParticleSystem *)currentElement->system particleNumber]);
		
		currentElement = currentElement->nextSystem;
	}
}

#pragma mark constructor_destructor
SharedParticleSystemManager::SharedParticleSystemManager()
{
	//constructor
	_systemsList = NULL;
}

SharedParticleSystemManager::~SharedParticleSystemManager()
{
	delete instance;
}
