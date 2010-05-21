//
//  GECTemplateManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/28/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

/* The way to use the component is by static_cast ( not dynamic_cast! (slow!)
 *
 *	 GEComponent *gec = ((GameEntity *)(*it))->getGEC(std::string("CompVisual"));
 *	 gecVisual *gvis = static_cast<gecVisual*> (gec);
 *	 if( gvis )
 *	 {
 *		gvis->render();
 *	 }
 *	
 *	_NG Sat - Dec - 19
 */

#ifndef _GETEMPLATE_MANAGER_H_
#define _GETEMPLATE_MANAGER_H_

#include <map>
#include <string> 

#define GE_FACTORY GETemplateManager::getInstance()

class GameEntity;

class GETemplateManager
{
public:
	static GETemplateManager* getInstance();
	GameEntity *createGE(const std::string &geName, float x, float y);
	~GETemplateManager();

protected:
	GETemplateManager();
	GameEntity* broly(float x, float y);
	GameEntity*	hitter1(float x, float y);	
	GameEntity* testDummy(float x, float y);
	GameEntity* joypad(float x, float y);
	GameEntity* buttonDummy(float x, float y);
	GameEntity*	buttonAttack(float x, float y);
	GameEntity* pixelDummy(float x, float y);
	GameEntity* backgroundDummy(float x, float y);
	GameEntity* background1(float x, float y);
	GameEntity* scrollingBackground(float x, float y);
	
private:
	typedef GameEntity* (GETemplateManager::*MFP)(float x, float y);
    std::map <std::string, MFP> fmap;	//Declaration of a map with member function pointers.
		
	static GETemplateManager *singletonInstance;
};

#endif