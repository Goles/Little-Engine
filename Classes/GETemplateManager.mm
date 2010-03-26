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
#import "gecButton.h"


GETemplateManager* GETemplateManager::singletonInstance = NULL;

#pragma mark constructor_init
GETemplateManager* GETemplateManager::getInstance()
{
	if (singletonInstance == NULL)
		singletonInstance = new GETemplateManager();
	
	return singletonInstance;
}

#pragma mark destructor

GETemplateManager::~GETemplateManager()
{
	
	std::map <std::string, MFP>::iterator it;
	
	for(it = fmap.begin(); it != fmap.end(); it++)
	{
		fmap.erase(it);
	}
	
	delete singletonInstance;
}

GETemplateManager::GETemplateManager()
{
	/*We must insert all our member functions into our map*/
	fmap.insert( std::make_pair( "broly",			&GETemplateManager::broly ));
	fmap.insert( std::make_pair( "hitter1",			&GETemplateManager::hitter1 ));
	fmap.insert( std::make_pair( "testDummy",		&GETemplateManager::testDummy ));
	fmap.insert( std::make_pair( "joypad",			&GETemplateManager::joypad ));
	fmap.insert( std::make_pair( "buttonDummy",		&GETemplateManager::buttonDummy ));
	fmap.insert( std::make_pair( "pixelDummy",		&GETemplateManager::pixelDummy ));
	fmap.insert( std::make_pair( "backgroundDummy",	&GETemplateManager::backgroundDummy ));
}

#pragma mark action_methods
GameEntity* GETemplateManager::createGE(const std::string &geName, float x, float y)
{
	MFP fp = fmap[geName];
	return(this->*fp)(x, y);
}

#pragma mark factory_methods
//Creates a broly entity
GameEntity* GETemplateManager::broly(float x, float y)
{
	//This is usually the width/height of the sprite.
	float	width	= 80,
			height	= 80;
	
	GameEntity *gE = new GameEntity(x, y, width, height);
	
	//Load the spriteSheet.
	SpriteSheet *ss = new SpriteSheet();
	ss->initWithImageNamed("brolySheetComic.png", gE->width, gE->height, 0.0, 1.0);
	
	gecAnimatedSprite *spriteAnimations = new gecAnimatedSprite();
	spriteAnimations->setOwnerGE(gE);
	
	std::vector<int>	coordStand,
						coordWalk;
	
	coordStand.push_back(0);
	coordStand.push_back(0);
	
	coordWalk.push_back(1);
	coordWalk.push_back(0);
	coordWalk.push_back(2);
	coordWalk.push_back(0);
	coordWalk.push_back(3);
	coordWalk.push_back(0);	
	coordWalk.push_back(4);
	coordWalk.push_back(0);	
	coordWalk.push_back(5);
	coordWalk.push_back(0);	
	coordWalk.push_back(6);
	coordWalk.push_back(0);
	
	/*Add the animations to the sprite*/	
	spriteAnimations->addAnimation("walk", coordWalk, ss);
	spriteAnimations->addAnimation("stand", coordStand, ss);
	
	/*The Default animation is stand and it's running*/
	spriteAnimations->setCurrentAnimation(std::string("stand"));
	spriteAnimations->setCurrentRunning(true);
	
	//add the sprite animations to our game entity, make it active and set it's position
	gE->setGEC(spriteAnimations);
	gE->isActive = true;

	return gE;		
}

//Creates a hitter1 Entity
GameEntity* GETemplateManager::hitter1(float x, float y)
{
	//This is usually the width/height of the sprite.
	float	width	= 80,
			height	= 80;
	
	GameEntity *gE = new GameEntity(x, y, width, height);
	
	SpriteSheet *ss = new SpriteSheet();
	ss->initWithImageNamed("slowHitter1.png", gE->height, gE->width, 0.0, 1.0);
	
	gecAnimatedSprite *spriteAnimations = new gecAnimatedSprite();
	spriteAnimations->setOwnerGE(gE);
	
	std::vector<int>	coordStand,
						coordWalk;
	
	coordStand.push_back(0);
	coordStand.push_back(0);
	coordWalk.push_back(1);
	coordWalk.push_back(0);
	coordWalk.push_back(2);
	coordWalk.push_back(0);
	coordWalk.push_back(3);
	coordWalk.push_back(0);	
	coordWalk.push_back(4);
	coordWalk.push_back(0);
	
	/*Add the animations to the sprite*/	
	spriteAnimations->addAnimation("walk", coordWalk, ss);
	spriteAnimations->addAnimation("stand", coordStand, ss);
	
	/*The Default animation is stand and it's running*/
	spriteAnimations->setCurrentAnimation(std::string("stand"));
	spriteAnimations->setCurrentRunning(true);	
	
	//add the sprite animations to our game entity, make it active and set it's position
	gE->setGEC(spriteAnimations);
	gE->isActive = true;
	gE->x = x;
	gE->y = y;
	
	return gE;
}

//Creates a testDummy Entity
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

//Creates a joystick Entity
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

//Creates a Button Entity
GameEntity* GETemplateManager::buttonDummy(float x, float y)
{
	GameEntity *anEntity = new GameEntity();
	
	std::vector<int> aVector, aVector2, aVector3;
	
	aVector.push_back(0);
	aVector.push_back(0);
	aVector2.push_back(1);
	aVector2.push_back(0);
	aVector3.push_back(2);
	aVector3.push_back(0);
	
	SpriteSheet *ss = new SpriteSheet();
	ss->initWithImageNamed("buttons_test.png", 200, 50, 0.0, 1.0);
	
	gecAnimatedSprite *spriteComp;
	
	spriteComp = new gecAnimatedSprite();
	spriteComp->addAnimation("normal", aVector, ss);
	spriteComp->addAnimation("hot", aVector2, ss);
	spriteComp->addAnimation("active", aVector3, ss);
	spriteComp->setCurrentAnimation("normal");
	spriteComp->setCurrentRunning(true);
	spriteComp->setOwnerGE(anEntity);
	
	gecButton *buttonComp;	
	buttonComp = new gecButton();
	buttonComp->setOwnerGE(anEntity);
	buttonComp->setShape(CGRectMake(x, y, 200, 50));
	
	anEntity->setGEC(spriteComp);
	anEntity->setGEC(buttonComp);
	anEntity->x = x;
	anEntity->y = y;
	anEntity->isActive  = true;
	
	return anEntity;
}

//Creates a background 480x320 entity
GameEntity* GETemplateManager::backgroundDummy(float x, float y)
{
	//This is usually the width/height of the sprite.
	float	width	= 480,
			height	= 320;
	
	GameEntity *gE = new GameEntity(x, y, width, height);
	
	SpriteSheet *ss = new SpriteSheet();
	ss->initWithImageNamed("scenario1a.png", gE->width, gE->height, 0.0, 1.0);
	
	gecAnimatedSprite *spriteAnimations = new gecAnimatedSprite();
	spriteAnimations->setOwnerGE(gE);
	
	std::vector<int>	coordBack;
	coordBack.push_back(0);
	coordBack.push_back(0);
	
	/*Add the animations to the sprite*/
	spriteAnimations->addAnimation("display",coordBack, ss);
	
	/*The Default animation is stand and it's running*/
	spriteAnimations->setCurrentAnimation(std::string("display"));
	spriteAnimations->setCurrentRunning(true);
	
	gE->setGEC(spriteAnimations);
	gE->isActive = true;
	gE->x = x;
	gE->y = y;
	
	return gE;
}

//Creates a 4x4 Pixel Entity
GameEntity* GETemplateManager::pixelDummy(float x, float y)
{
	GameEntity *anEntity = new GameEntity();
	
	/*Build the pixel*/
	std::vector<int> aVector;
	
	aVector.push_back(0);
	aVector.push_back(0);
	
	SpriteSheet *ss = new SpriteSheet();
	ss->initWithImageNamed("pixel.png", 4, 4, 0.0, 1.0);
	
	gecAnimatedSprite *spriteComp;
	
	spriteComp = new gecAnimatedSprite();
	spriteComp->addAnimation("normal", aVector, ss);
	spriteComp->setCurrentAnimation("normal");
	spriteComp->setCurrentRunning(true);
	spriteComp->setOwnerGE(anEntity);	
	anEntity->setGEC(spriteComp);
	
	anEntity->x = x;
	anEntity->y = y;
	anEntity->isActive  = true;
	
	return anEntity;	
}