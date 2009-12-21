//
//  SceneManager.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#include "SceneManager.h"
#include "SharedParticleSystemManager.h"
#include "gecVisual.h"

//Constructor
#pragma mark contructor
SceneManager::SceneManager()
{
	//Init some stuff here.
}

#pragma mark drawing_updating
void SceneManager::updateScene(float delta)
{
	ENTITY_VECTOR_ITERATOR it ;
	
	for(it = entityList.begin(); it < entityList.end(); it++)
	{
		if((*it)->isActive)
			(*it)->update(delta);
	}
}

void SceneManager::renderScene()
{
	ENTITY_VECTOR_ITERATOR it ;
	
	for (it = entityList.begin(); it < entityList.end(); it++)
	{
		if((*it)->isActive)
		{	GEComponent *gec = (*it)->getGEC(std::string("CompVisual"));
			gecVisual *gvis	 = static_cast<gecVisual*> (gec);
			if( gvis )
			{
				gvis->render();
			}
		}
	}
}

#pragma mark remove_add
/*
 * Methods to add/remove several Kinds of "GameEntities" to the entityList
 */
GameEntity *SceneManager::addEntity(GameEntity *inGameEntity)
{
	entityList.push_back(inGameEntity);
	
	return entityList.back();
}

void SceneManager::removeEntity(GameEntity *inGameEntity)
{
	ENTITY_VECTOR_ITERATOR it = entityList.begin();

	while (it != entityList.end())
	{
		if (*it == inGameEntity) {
			entityList.erase(it);
		}		
		it++;
	}

}

void SceneManager::sortEntitiesX()
{
	std::sort(entityList.begin(), entityList.end(), GameEntity::compareByX());	
}

void SceneManager::sortEntitiesY()
{
	std::sort(entityList.begin(), entityList.end(), GameEntity::compareByY());
}

#pragma mark debug
void SceneManager::debugPrintEntityList()
{
	std::cout << "*DEBUG Print Entity List ( Scene Manager ) *" << std::endl;
	
	ENTITY_VECTOR_ITERATOR it = entityList.begin();
	
	while(it != entityList.end())
	{
		if(*it)
		{
			std::cout << "comp:" << std::endl;
			(*it)->debugPrintComponents();
		}
		it++;
	}
}

#pragma mark destructor
SceneManager::~SceneManager()
{
	/*Erase the whole scene entity list on delete.*/
	ENTITY_VECTOR_ITERATOR it = entityList.begin();
	
	while (it != entityList.end())
	{
		entityList.erase(it);
	}
	
	entityList.clear();
}