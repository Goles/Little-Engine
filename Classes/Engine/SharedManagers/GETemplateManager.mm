//
//  GECTemplateManager.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/28/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//



#include "GETemplateManager.h"
#include "VectorList.h"

#include "GameEntity.h"
#include "SpriteSheet.h"
#include "SharedTextureManager.h"
#include "gecAnimatedSprite.h"
#include "gecVisualContainer.h"
#include "gecJoystick.h"
#include "gecButton.h"
#include "gecFSM.h"
#include "gecImage.h"
#include "gecScrollingBackground.h"
#include "gecBoxCollisionable.h"
#include "gecWeapon.h"

GETemplateManager* GETemplateManager::singletonInstance = NULL;

#pragma mark constructor and destructor
GETemplateManager* GETemplateManager::getInstance()
{
	if (singletonInstance == NULL)
		singletonInstance = new GETemplateManager();
	
	return singletonInstance;
}

GETemplateManager::GETemplateManager()
{
	/*We must insert all our member functions into our map*/
	fmap.insert( std::make_pair( "broly",			&GETemplateManager::broly ));
	fmap.insert( std::make_pair( "hitter1",			&GETemplateManager::hitter1 ));
	fmap.insert( std::make_pair( "testDummy",		&GETemplateManager::testDummy ));
	fmap.insert( std::make_pair( "joypad",			&GETemplateManager::joypad ));
	fmap.insert( std::make_pair( "buttonDummy",		&GETemplateManager::buttonDummy ));
	fmap.insert( std::make_pair( "buttonAttack",	&GETemplateManager::buttonAttack ));
	fmap.insert( std::make_pair( "pixelDummy",		&GETemplateManager::pixelDummy ));
	fmap.insert( std::make_pair( "backgroundDummy",	&GETemplateManager::backgroundDummy ));
	fmap.insert( std::make_pair( "background1",		&GETemplateManager::background1 ));
	fmap.insert( std::make_pair( "scrollingBackground", &GETemplateManager::scrollingBackground ));
}

GETemplateManager::~GETemplateManager()
{	
	std::map <std::string, MFP>::iterator it;
	
	for(it = fmap.begin(); it != fmap.end(); ++it)
	{
		fmap.erase(it);
	}
	
	delete singletonInstance;
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
	/*
	//This is usually the width/height of the sprite.
	float	width	= 80,
			height	= 80;
	
	GameEntity *gE = new GameEntity(x, y, width, height);
	
	//Load the spriteSheet.
	SpriteSheet *ss = new SpriteSheet();
	ss->initWithImageNamed("hitter1_sheet.png", gE->width, gE->height, 0.0, 1.0);
	
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
	*/
	
	/*Add the animations to the sprite*/	
	
	//spriteAnimations->addAnimation("walk", coordWalk, ss);
//	spriteAnimations->addAnimation("stand", coordStand, ss);
	
	/*The Default animation is stand and it's running*/
//	spriteAnimations->setCurrentAnimation(std::string("stand"));
//	spriteAnimations->setCurrentRunning(true);
	
	//add the sprite animations to our game entity, make it active and set it's position
//	gE->setGEC(spriteAnimations);
//	gE->isActive = true;

//	return gE;		
}

//Creates a hitter1 Entity
GameEntity* GETemplateManager::hitter1(float x, float y)
{
//	//This is usually the width/height of the sprite.
//	float	width	= 80,
//			height	= 80;
//	
//	GameEntity *gE = new GameEntity(x, y, width, height);
//	gE->setSpeed(75.0);
//	
//	SpriteSheet *ss = new SpriteSheet();
//	ss->initWithImageNamed("hitter1_1.png", gE->height, gE->width, 0.0, 1.0);
//	
//	//Add an FSM to our Game Entity
//	gecFSM *fsm = new gecFSM();
//	fsm->setOwnerGE(gE);
	
	//Build the rules for this entity FSM.
	//fsm->setRule(kBehaviourState_stand, kBehaviourAction_doAttack, kBehaviourState_attack, "attack");
//	fsm->setRule(kBehaviourState_stand, kBehaviourAction_dragGamepad, kBehaviourState_walk, "walk");
//	fsm->setRule(kBehaviourState_stand, kBehaviourAction_hit, kBehaviourState_hit, "hit");
//	fsm->setRule(kBehaviourState_walk, kBehaviourAction_stopGamepad, kBehaviourState_stand, "stand");
//	fsm->setRule(kBehaviourState_walk, kBehaviourAction_dragGamepad, kBehaviourState_walk, "walk");
//	fsm->setRule(kBehaviourState_walk, kBehaviourAction_doAttack, kBehaviourState_attack, "attack");
//	fsm->setRule(kBehaviourState_walk, kBehaviourAction_hit, kBehaviourState_hit, "hit");
//	fsm->setRule(kBehaviourState_attack, kBehaviourAction_stopAttack, kBehaviourState_stand, "stand");
//	fsm->setRule(kBehaviourState_attack, kBehaviourAction_doAttack, kBehaviourState_attack, "attack");
//	fsm->setRule(kBehaviourState_attack, kBehaviourAction_stopGamepad, kBehaviourState_attack, "attack");
//	fsm->setRule(kBehaviourState_attack, kBehaviourAction_dragGamepad, kBehaviourState_attack, "attack");
//	fsm->setRule(kBehaviourState_attack, kBehaviourAction_hit, kBehaviourState_hit, "hit");
//	fsm->setRule(kBehaviourState_hit, kBehaviourAction_stopHit, kBehaviourState_stand, "stand");
	
	//Create the sprite animations component
	
//	gecAnimatedSprite *spriteAnimations = new gecAnimatedSprite();
//	spriteAnimations->setOwnerGE(gE);
//	
//	std::vector<int> coord_Standing,
//	coord_Moving,
//	coord_Hitting1Punch,
//	coord_Hitting2Conector,
//	coord_Hitting3Uppercut,
//	coord_BeenHit1,
//	coord_BeenHit2,
//	coord_Dying;
//	
//	std::vector<float> time_Standing,
//	time_Moving,
//	time_Hitting1Punch,
//	time_Hitting2Conector,
//	time_Hitting3Uppercut,
//	time_BeenHit1,
//	time_BeenHit2,
//	time_Dying;
//	
//	coord_Standing = vlist_of<int>(0)(0)(1)(0)(2)(0)(3)(0);
//	coord_Moving = vlist_of<int>(4)(0)(5)(0)(6)(0)(7)(0);
//	coord_Hitting1Punch = vlist_of<int>(8)(0)(9)(0)(10)(0);
//	coord_Hitting2Conector = vlist_of<int>(11)(0)(0)(1);
//	coord_Hitting3Uppercut = vlist_of<int>(1)(1)(2)(1)(3)(1);
//	coord_BeenHit1 = vlist_of<int>(4)(1);
//	coord_BeenHit2 = vlist_of<int>(5)(1);
//	coord_Dying = vlist_of<int>(6)(1)(7)(1)(8)(1)(9)(1)(10)(1)(11)(1)(0)(2)(1)(2);
//	time_Standing.push_back(0.10f);
//	time_Moving.push_back(0.10f);
//	time_Hitting1Punch.push_back(0.08f);
//	time_Hitting2Conector.push_back(0.16f);
//	time_Hitting3Uppercut.push_back(0.16f);
//	time_BeenHit1.push_back(0.4f);
//	time_BeenHit2.push_back(0.4f);
//	time_Dying.push_back(0.07f);
//	
//	//Add the animations to the sprite
//	spriteAnimations->addAnimation("stand", coord_Standing, time_Standing, ss);
//	spriteAnimations->addAnimation("walk", coord_Moving, time_Moving, ss);
//	spriteAnimations->addAnimation("attack", coord_Hitting1Punch, time_Hitting1Punch, ss);
//	spriteAnimations->addAnimation("attack2", coord_Hitting2Conector, time_Hitting2Conector, ss);
//	spriteAnimations->addAnimation("attack3", coord_Hitting3Uppercut, time_Hitting3Uppercut, ss);
//	spriteAnimations->addAnimation("hit", coord_BeenHit1, time_BeenHit1, ss);
//	spriteAnimations->addAnimation("hit2", coord_BeenHit2, time_BeenHit2, ss);
//	spriteAnimations->addAnimation("dying", coord_Dying, time_Dying, ss);
	
	//Set a delegate for the attack animation
	//This should be much better because EVERY animation should implement delegation by default.
//	Animation *attack = spriteAnimations->getAnimation("attack");
//	if(attack)
//		attack->setDelegate(boost::bind(&gecFSM::animationFinishedDelegate, fsm));
//	
//	Animation *hit = spriteAnimations->getAnimation("hit");
//	if(hit)
//	{
//		hit->setDelegate(boost::bind(&gecFSM::animationFinishedDelegate, fsm));
//		Animation *an = spriteAnimations->getAnimation("hit");
//		an->setIsRepeating(false);
//	}
//		
//	
//	//The Default animation is stand and it's running
//	spriteAnimations->setCurrentAnimation(std::string("stand"));
//	spriteAnimations->setCurrentRunning(true);
//	spriteAnimations->setCurrentPingPong(true);
//	spriteAnimations->setCurrentRepeating(true);
//	
//	//add the sprite animations to our game entity, make it active and set it's position
//	gE->setGEC(spriteAnimations);
//	gE->isActive = true;
//	gE->x = x;
//	gE->y = y;
//	//Attach the FSM to the hitter.
//	gE->setGEC(fsm);
	
	//Attach collisioning to the entity:
//	gecBoxCollisionable *gbc = new gecBoxCollisionable();
//	gbc->setOwnerGE(gE);
//	gE->setGEC(gbc);
	
	//Attach weapon
//	gecWeapon *gwc = new gecWeapon();
//	gwc->init(gE, 10.0, 10.0f);
//	gE->setGEC(gwc);
	
//	return gE;
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
	ss->initWithImageNamed("joypad_move.png", 42, 42, 0.0, 1.0);
	
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
	jComp->setShape(CGRectMake(x, y, 42.0, 42.0));
	
	jComp->setCenter(x, y);
	
	anEntity->setGEC(spriteComp);
	anEntity->setGEC(jComp);
	anEntity->x = x;
	anEntity->y = y;
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
	buttonComp->setParentSharedShape(CGRectMake(x, y, 200, 50));
	
	anEntity->setGEC(spriteComp);
	anEntity->setGEC(buttonComp);
	anEntity->x = x;
	anEntity->y = y;
	anEntity->isActive  = true;
	
	return anEntity;
}

//Creates the new attackbutton
GameEntity*	GETemplateManager::buttonAttack(float x, float y)
{
	GameEntity *anEntity = new GameEntity();
	
	std::vector<int> buttonNormal, buttonHot;
	
	buttonNormal = vlist_of<int>(0)(0);
	buttonHot = vlist_of<int>(1)(0);
	
	SpriteSheet *ss = new SpriteSheet();
	ss->initWithImageNamed("button_attack.png", 42, 42, 0.0, 1.0);
	
	gecAnimatedSprite *spriteComp;
	
	spriteComp = new gecAnimatedSprite();
	spriteComp->addAnimation("normal", buttonNormal, ss);
	spriteComp->addAnimation("hot", buttonHot, ss);
//	spriteComp->addAnimation("active", buttonHot, ss);
	spriteComp->setCurrentAnimation("normal");
	spriteComp->setCurrentRunning(true);
	spriteComp->setOwnerGE(anEntity);
	
	gecButton *buttonComp;	
	buttonComp = new gecButton();
	buttonComp->setOwnerGE(anEntity);
	buttonComp->setParentSharedShape(CGRectMake(x, y, 64, 64));
	
	anEntity->setGEC(spriteComp);
	anEntity->setGEC(buttonComp);
	anEntity->x = x;
	anEntity->y = y;
	anEntity->isActive  = true;
	
	return anEntity;
}

//Creates a background 480x320 entity
GameEntity* GETemplateManager::background1(float x, float y)
{
//	//Dimensions
//	float	width	= 480,
//			height	= 320;
//	
//	//Creating GameEntity
//	GameEntity	*ge = new GameEntity(x, y, width, height);
//	
//	//Create a visualComponent
//	Image *i = new Image();
//	i->initWithTextureFile("backgroundDummy.png");
//	
//	//Create and set the gecImage
//	gecImage *gi = new gecImage(i);
//	ge->setGEC(gi);
//	
//	ge->isActive = true;
//	ge->x = x;
//	ge->y = y;
//	return ge;
}

GameEntity* GETemplateManager::scrollingBackground(float x, float y)
{
	GameEntity *gE = new GameEntity();	
	gecScrollingBackground *gsb = new gecScrollingBackground("scenario_3.png", "scenario_3.png");
	
	gE->setGEC(gsb);
	gE->x = x;
	gE->y = y;
	gE->isActive = true;
	
	return gE;
}

//Creates a background 480x320 entity
GameEntity* GETemplateManager::backgroundDummy(float x, float y)
{
//	//This is usually the width/height of the sprite.
//	float	width	= 480,
//			height	= 320;
//	
//	GameEntity *gE = new GameEntity(x, y, width, height);
//	
//	SpriteSheet *ss = new SpriteSheet();
//	ss->initWithImageNamed("backgroundDummy.png", gE->width, gE->height, 0.0, 1.0);
//	
//	gecAnimatedSprite *spriteAnimations = new gecAnimatedSprite();
//	spriteAnimations->setOwnerGE(gE);
//	
//	std::vector<int>	coordBack;
//	coordBack.push_back(0);
//	coordBack.push_back(0);
//	
//	/*Add the animations to the sprite*/
//	spriteAnimations->addAnimation("display",coordBack, ss);
//	
//	/*The Default animation is stand and it's running*/
//	spriteAnimations->setCurrentAnimation(std::string("display"));
//	spriteAnimations->setCurrentRunning(true);
//	
//	gE->setGEC(spriteAnimations);
//	gE->isActive = true;
//	gE->x = x;
//	gE->y = y;
//	
//	return gE;
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
