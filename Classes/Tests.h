//
//  Tests.h
//  GandoEngine
//
//  Created by Nicolas Goles on 6/9/10.
//  Copyright 2010 GandoGames. All rights reserved.
//

#include <boost/bind.hpp>

#include "ConstantsAndMacros.h"
#include "EmitterFunctions.h"
#include "FileUtils.h"
#include "SceneManager.h"
#include "GEComponent.h"
#include "GETemplateManager.h"
#include "SharedParticleSystemManager.h"
#include "gecAnimatedSprite.h"
#include "gecVisualContainer.h"
#include "gecButton.h"
#include "gecJoystick.h"
#include "gecFSM.h"
#include "gecImage.h"
#include "Image.h"
#include "gecScrollingBackground.h"
#include "gecBoxCollision.h"
#include "gecWeapon.h"

static inline void tenZombies(SceneManager* sm)
{
	//Declare our game entities
	GameEntity *b		= GE_FACTORY->createGE("scrollingBackground", 0, 320.0);
	GameEntity *hitter	= GE_FACTORY->createGE("hitter1", 240.0f, 120.0f);
	GameEntity *j		= GE_FACTORY->createGE("joypad",  75.0f, 65.0f);
	GameEntity *button	= GE_FACTORY->createGE("buttonAttack", 400.0f, 50.0f);
	
	srand(time(NULL));
	
	for(int i = 0; i < 10; i++)
	{
		GameEntity *h = GE_FACTORY->createGE("hitter1", rand()%400 + 20, rand()%80 + 80);
		sm->addEntity(h);
	}
	
	//Configure our button
	((gecButton *)button->getGEC("CompGUI"))->setActionPressed(kBehaviourAction_doAttack);
	((gecButton *)button->getGEC("CompGUI"))->setActionReleased(kBehaviourAction_stopAttack);
	((gecButton	*)button->getGEC("CompGUI"))->addSignal(boost::bind(&gecFSM::performAction, 
																	(gecFSM*)hitter->getGEC("CompBehaviour"), _1));
	((gecJoystick *)j->getGEC("CompGUI"))->subscribeGameEntity(hitter);
	
	//Subscribe entity
	((gecScrollingBackground *)b->getGEC("CompVisual"))->setSubscribedGE(hitter);
	
	//Add everything to the Scene.
	sm->addEntity(PARTICLE_MANAGER->createParticleSystem(kParticleSystemFX_FountainGiant, CGPointMake(320, 50), "Particle2.pvr"));
	sm->addEntity(b);
	sm->addEntity(hitter);	
	sm->addEntity(j);
	sm->addEntity(button);
}