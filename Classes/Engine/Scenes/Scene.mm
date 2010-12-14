//
//  SceneManager.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/16/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#include "Scene.h"
#include "SharedParticleSystemManager.h"
#include "gecVisual.h"

//Constructor
#pragma mark contructor
Scene::Scene() : sceneId("unnamed")
{
	//Init some stuff here.
}

#pragma mark drawing_updating
void Scene::updateScene(float delta)
{	
	ENTITY_VECTOR_ITERATOR it ;
	
	for(it = entityList.begin(); it < entityList.end(); ++it)
	{
		if((*it) != NULL)
			if((*it)->isActive)
				(*it)->update(delta);
	}
}

void Scene::renderScene()
{
	ENTITY_VECTOR::const_iterator it ;
	
	for (it = entityList.begin(); it < entityList.end(); ++it)
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
GameEntity *Scene::addEntity(GameEntity *inGameEntity)
{	
	entityList.push_back(inGameEntity);
	
	//return entityList.back();	
	return inGameEntity;
}

void Scene::removeEntity(GameEntity *inGameEntity)
{
	ENTITY_VECTOR_ITERATOR it = entityList.begin();

	while (it != entityList.end())
	{
		if (*it == inGameEntity) {
			entityList.erase(it);
		}		
		++it;
	}
}

void Scene::sortEntitiesX()
{
	std::sort(entityList.begin(), entityList.end(), GameEntity::compareByX());	
}

void Scene::sortEntitiesY()
{
	std::sort(entityList.begin(), entityList.end(), GameEntity::compareByY());
}

#pragma mark debug
void Scene::debugPrintEntityList()
{
	std::cout << "*** DEBUG Print Entity List ( Scene Manager ) ***" << std::endl;
	
	ENTITY_VECTOR_ITERATOR it = entityList.begin();
	
	int i = 0;
	
	while(it != entityList.end())
	{
		if(*it)
		{
			std::cout << "\nEntity " << i << " [" << (*it) << "] - " <<"[" << (*it)->x << "][" <<(*it)->y <<  "]" << std::endl;
			//(*it)->debugPrintComponents();
		}
		++it;
		++i;
	}
}

#pragma mark destructor
Scene::~Scene()
{
	/*Erase the whole scene entity list on delete.*/
	ENTITY_VECTOR_ITERATOR it = entityList.begin();
	
	while (it != entityList.end())
	{
		entityList.erase(it);
	}
	
	entityList.clear();
}