//
//  GameElement.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#import "GameEntity.h"

#include "GEComponent.h"

GameEntity::GameEntity()
{
	height		= 0.0f;
	width		= 0.0f;
	speed		= 0.0f;	
	x			= 0.0f;
	y			= 0.0f;
	flipHorizontally = false;
}

GameEntity::GameEntity(float inX, float inY)
{
	height		= 0.0f;
	width		= 0.0f;
	speed		= 0.0f;
	x			= inX;
	y			= inY;
	flipHorizontally = false;
}

GameEntity::GameEntity(float inX, float inY, int inWidth, int inHeight)
{
	speed		= 0.0f;
	height		= inHeight;
	width		= inWidth;
	x			= inX;
	y			= inY;
	flipHorizontally = false;
}

void GameEntity::setGEC( GEComponent *newGEC )
{
	if(!newGEC)
	{
		std::cout << "ERROR: Can't pass NULL component!" << std::endl;
		assert(newGEC != NULL);
	}else {
//		newGEC->setOwnerGE(this);
		std::string familyID = newGEC->familyID();
		components[familyID] = newGEC;
	}
}

GEComponent* GameEntity::getGEC(const std::string &familyID)
{
	ComponentMap::iterator component = components.find(familyID);
	
	//If component is not present in the map, return NULL
	if(component == components.end())
		return NULL;
	
	return component->second;
}

void GameEntity::update(float delta)
{
	ComponentMap::iterator it;

	for(it = components.begin(); it != components.end(); ++it)
	{
		if((*it).second)
			(*it).second->update(delta);
		else {
			std::cout << "ERROR: NULL Component in GameEntity Components Map" << std::endl;
			assert((*it).second != NULL);
		}
	}
}

void GameEntity::debugPrintComponents()
{
	ComponentMap::iterator it;
	
	
	for(it = components.begin(); it != components.end(); ++it)
	{
		std::cout << (*it).second->componentID()
		<< "[" << (*it).second << "] " //Print The Component Address
		<< " - Parent Entity [" << (*it).second->getOwnerGE() << "] " 
		<< std::endl;
	}
}
