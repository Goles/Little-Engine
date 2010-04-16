//
//  SharedParticleSystemManager.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#include "SharedParticleSystemManager.h"
#include "OpenGLCommon.h"
#include "EmitterFunctions.h"
#include "RenderingFunctions.h"
#include "gecParticleSystem.h"
#include "ParticleEmitter.h"
#include "ParticleRenderer.h"
#include "Image.h"
#include "FileUtils.h"

SharedParticleSystemManager* SharedParticleSystemManager::instance = NULL;

SharedParticleSystemManager* SharedParticleSystemManager::getInstance()
{
	if(instance == NULL)
		instance = new SharedParticleSystemManager();
	
	return instance;
}

#pragma mark constructor_destructor
SharedParticleSystemManager::SharedParticleSystemManager()
{
	//constructor
}

SharedParticleSystemManager::~SharedParticleSystemManager()
{
	delete instance;
}

#pragma mark action_methods
//Action Methods
GameEntity* SharedParticleSystemManager::createParticleSystem(int k_InParticleFX, CGPoint inPosition, const std::string &textureName)
{	
	gecParticleSystem *pSystemComponent;
	
	Image *inImage = new Image();
	inImage->initWithTextureFile(textureName);
	
	switch (k_InParticleFX) 
	{
			/********************************************************	
			 *				FIRE FX		v1.0						*
			 *				_Nicolas Goles Domic - October 16 2009	*
			 ********************************************************/
		case kParticleSystemFX_FireSmall:
			//newSystem	= [[ParticleSystem alloc] initWithParticles:50 continuous:YES renderingMode:kRenderingMode_PointSprites];
			
			pSystemComponent	= new gecParticleSystem(59, YES, kRenderingMode_PointSprites);
			
			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
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
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			
			break;
	
		case kParticleSystemFX_FireMedium:
			pSystemComponent	= new gecParticleSystem(110, YES, kRenderingMode_PointSprites);
			
			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
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
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			
			break;
		case kParticleSystemFX_FireBig:
			pSystemComponent	= new gecParticleSystem(100, YES, kRenderingMode_PointSprites);
			
			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
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
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
			/********************************************************	
			 *				EXPLOSION FX		v1.0				*
			 *				_Nicolas Goles Domic - October 16 2009	*
			 ********************************************************/
		case kParticleSystemFX_ExplosionSmall:
			pSystemComponent	= new gecParticleSystem(80, NO, kRenderingMode_PointSprites);
			
			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
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
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		case kParticleSystemFX_ExplosionMedium:
			pSystemComponent	= new gecParticleSystem(80, NO, kRenderingMode_PointSprites);
			
			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
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
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		case kParticleSystemFX_ExplosionBig:
			pSystemComponent	= new gecParticleSystem(53, NO, kRenderingMode_PointSprites);
			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
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
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
			
			/********************************************************	
			 *			FOUNTAIN FX		v1.0						*
			 *			_Nicolas Goles Domic - October 16 2009		*
			 ********************************************************/
		case kParticleSystemFX_FountainSmall:
			pSystemComponent	= new gecParticleSystem(50, YES, kRenderingMode_PointSprites);

			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
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
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		case kParticleSystemFX_FountainMedium:
			pSystemComponent	= new gecParticleSystem(50, YES, kRenderingMode_PointSprites);
			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
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
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		case kParticleSystemFX_FountainBig:
			pSystemComponent	= new gecParticleSystem(70, YES, kRenderingMode_PointSprites);
			
			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
															 initialYSpeed:5
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
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		case kParticleSystemFX_FountainGiant:
			pSystemComponent	= new gecParticleSystem(1500, YES, kRenderingMode_PointSprites);
			
			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
															 initialYSpeed:8
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
																	  size:32
																startColor:Color3DMake(51, 51, 153, 0)
																  endColor:Color3DMake(255, 10, 61, 0)];
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		case kParticleSystemFX_Smoke:
			pSystemComponent	= new gecParticleSystem(100, YES, kRenderingMode_2xTriangles);
			
			[pSystemComponent->getParticleEmitter() setSystemXInitialSpeed:0
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
			
			[pSystemComponent->getParticleEmitter() setCurrentFX:kEmmiterFX_none withSource:inPosition andEnd:CGPointZero];
			break;
			
		default:
			break;
	}
	
	/*Set the particle System X and Y position, which will serve to sort it with other GameEntities*/
	
	/* We now set the ParticleRenderer Texture to the input Image */
	[pSystemComponent->getParticleRenderer() setParticleSubTexture:inImage];
	
	/* Finally the recently created pSystem will go into an entity*/
	GameEntity *newEntity = new GameEntity();
	newEntity->setGEC(pSystemComponent);
	newEntity->x = inPosition.x;
	newEntity->y = inPosition.y;
	newEntity->isActive = true;
	
	return this->insertSystem(newEntity);
}

GameEntity* SharedParticleSystemManager::insertSystem(GameEntity *inSystem) //Creates and inserts a new SystemEntity in the _systemsList
{
	_systemsList.push_back(inSystem);	

	return inSystem;
}

void SharedParticleSystemManager::removeSystem(GameEntity *inSystem)
{
	ParticleSystemList::iterator it = _systemsList.begin();
	
	while(it != _systemsList.end())
	{
		if(*it == inSystem)
		{
			_systemsList.erase(it);
			return;
		}
	}
}

void SharedParticleSystemManager::debugPrintList()
{
	ParticleSystemList::iterator it = _systemsList.begin();
	
	while(it != _systemsList.end())
	{
		std::cout << "Particle System& " << *it << std::endl; 
	}
}
