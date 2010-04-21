//
//  GameElement.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 Gando-Games. All rights reserved.
//

#import "GameEntity.h"
#import "GEComponent.h"

GameEntity::GameEntity()
{
	height = 0.0f;
	width = 0.0f;	
	x = 0.0f;
	y = 0.0f;
}

GameEntity::GameEntity(float inX, float inY)
{
	height = 0.0f;
	width = 0.0f;
	x = inX;
	y = inY;
}

GameEntity::GameEntity(float inX, float inY, int inWidth, int inHeight)
{
	height = inHeight;
	width = inWidth;
	x = inX;
	y = inY;
}

void GameEntity::setGEC( GEComponent *newGEC )
{
	newGEC->setOwnerGE(this);
	std::string familyID = newGEC->familyID();
	components[familyID] = newGEC;
}

GEComponent* GameEntity::getGEC(const std::string &familyID)
{
	return components[familyID];
}

void GameEntity::update(float delta)
{
	ComponentMap::iterator it;
	
	std::cout << "Game Entity: " << delta << std::endl;
	
	for(it = components.begin(); it != components.end(); ++it)
	{
		(*it).second->update(delta);
	}
}

void GameEntity::debugPrintComponents()
{
	ComponentMap::iterator it;
	
	for(it = components.begin(); it != components.end(); it++)
	{
		std::cout << "Parent Entity: " << (*it).second->getOwnerGE() << std::endl;
		std::cout << (*it).second << " & " << (*it).second->componentID() << " x " << x << " y " << y << std::endl;
	}
}
