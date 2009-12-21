//
//  GECTemplateManager.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/28/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#import "GETemplateManager.h"
#import "GameEntity.h"

#import "SpriteSheet.h"
#import "gecAnimatedSprite.h"
#import "gecVisualContainer.h"
#import "gecJoystick.h"


GETemplateManager* GETemplateManager::singletonInstance = NULL;

#pragma mark constructor_init

GETemplateManager* GETemplateManager::getInstance()
{
	if (singletonInstance == NULL)
		singletonInstance = new GETemplateManager();
	
	return singletonInstance;
}

GETemplateManager::GETemplateManager()
{
	/*We must insert all our member functions into our map*/
	fmap.insert( std::make_pair( "testDummy",	  &GETemplateManager::testDummy));
	fmap.insert( std::make_pair( "joypad",	  &GETemplateManager::joypad));	
}

#pragma mark action_methods
GameEntity* GETemplateManager::createGE(const std::string &geName, float x, float y)
{
	MFP fp = fmap[geName];
	return(this->*fp)(x, y);
}

#pragma mark factory_methods
GameEntity* GETemplateManager::testDummy(float x, float y)
{
	GameEntity *gE = new GameEntity();
	
	SpriteSheet *ss = new SpriteSheet();
	ss->initWithImageNamed("prototypePlayerSheet.png", 100, 100, 0.0, 1.0);	
	
	gecAnimatedSprite	*spriteAnimations	= new gecAnimatedSprite();
	
	spriteAnimations->setOwnerGE(gE);
	
	std::vector<int>	coordWalk,
						coordAttack,
						coordStand,
						coordHit,
						coordDeath;
	
	coordWalk.push_back(1);
	coordWalk.push_back(0);
	coordWalk.push_back(2);	
	coordWalk.push_back(0);
	coordWalk.push_back(3);
	coordWalk.push_back(0);	
	coordWalk.push_back(4);
	coordWalk.push_back(0);
	
	coordAttack.push_back(7);
	coordAttack.push_back(0);
	coordAttack.push_back(8);
	coordAttack.push_back(0);
	coordAttack.push_back(9);
	coordAttack.push_back(0);
	
	coordStand.push_back(0);
	coordStand.push_back(0);
	
	coordHit.push_back(5);
	coordHit.push_back(0);
	
	coordDeath.push_back(1);
	coordDeath.push_back(1);
	coordDeath.push_back(1);
	coordDeath.push_back(2);	
	coordDeath.push_back(3);
	
	/*Add the animations to the sprite*/
	spriteAnimations->addAnimation("walk", coordWalk, ss);
	spriteAnimations->addAnimation("attack", coordAttack, ss);	
	spriteAnimations->addAnimation("stand", coordStand, ss);	
	spriteAnimations->addAnimation("hit", coordHit, ss);
	spriteAnimations->addAnimation("death", coordDeath, ss);
	
	/*The Default animation is stand and it's running*/
	spriteAnimations->setCurrentAnimation(std::string("stand"));
	spriteAnimations->setCurrentRunning(true);
	
	gE->setGEC(spriteAnimations);
	gE->isActive = true;
	gE->x = x;
	gE->y = y;

	return gE;	
}

GameEntity* GETemplateManager::joypad(float x, float y)
{
	GameEntity *anEntity = new GameEntity();
	
	/*Build the joystick*/
	std::vector<int> aVector;
	
	aVector.push_back(0);
	aVector.push_back(0);
	
	SpriteSheet *ss = new SpriteSheet();
	ss->initWithImageNamed("joystick_tes.png", 60, 60, 0.0, 1.0);
	
	gecAnimatedSprite *spriteComp;
	
	spriteComp = new gecAnimatedSprite();
	spriteComp->addAnimation("normal", aVector, ss);
	spriteComp->addAnimation("hot", aVector, ss);
	spriteComp->addAnimation("active", aVector, ss);
	spriteComp->setCurrentAnimation("normal");
	spriteComp->setCurrentRunning(true);
	spriteComp->setOwnerGE(anEntity);
	
	gecJoystick *jComp;	
	jComp = new gecJoystick();
	jComp->setOwnerGE(anEntity);
	jComp->setShape(CGRectMake(70.0, 70.0, 80.0, 80.0));
	
	jComp->setCenter(x, y);
	
	anEntity->setGEC(spriteComp);
	anEntity->setGEC(jComp);
	anEntity->x = 70.0;
	anEntity->y = 70.0;
	anEntity->isActive  = true;
	
	return anEntity;
}
