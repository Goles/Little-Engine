//
//  GECTemplateManager.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GETemplateManager.h"
#import "GameEntity.h"

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
	fmap.insert( std::make_pair( "testFunction1", &GETemplateManager::testFunction1));
	fmap.insert( std::make_pair( "testFunction2", &GETemplateManager::testFunction2));
	fmap.insert( std::make_pair( "testFunction3", &GETemplateManager::testFunction3));	
}

#pragma mark action_methods
GameEntity* GETemplateManager::createGE(const std::string &geName)
{
	MFP fp = fmap[geName];
	return(this->*fp)();
}



#pragma mark factory_methods
GameEntity* GETemplateManager::testFunction1()
{
	std::cout << "1!" << std::endl;
	
	GameEntity *a = new GameEntity();
	
	return a;
}

GameEntity* GETemplateManager::testFunction2()
{
	std::cout << "2!" << std::endl;
	
	GameEntity *a = new GameEntity();
	
	return a;
}

GameEntity* GETemplateManager::testFunction3()
{
	std::cout << "3!" << std::endl;
	
	GameEntity *a = new GameEntity();
	
	return a;
}
