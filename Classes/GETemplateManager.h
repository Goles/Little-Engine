//
//  GECTemplateManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#include <map>
#include <string> 

#define GEFACTORY GETemplateManager::getInstance()

class GameEntity;

class GETemplateManager
{
public:
	static GETemplateManager* getInstance();
	GameEntity *createGE(const std::string &geName);
	~GETemplateManager();

protected:
	GETemplateManager();
	GameEntity* testFunction1();
	GameEntity* testFunction2();
	GameEntity* testFunction3();
	
	
	
private:
	typedef GameEntity* (GETemplateManager::*MFP)();
    std::map <std::string, MFP> fmap;	//Declaration of a map with member function pointers.
	
	
	static GETemplateManager *singletonInstance;
	
};