//
//  SceneManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/16/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#ifndef _SCENEMANAGER_H_
#define _SCENEMANAGER_H_

#include "GameEntity.h"
#include "gecParticleSystem.h"
#include <vector>
#include <iostream>

class GEComponent;

class SceneManager
{
public:
	//Constructor & Destructor
	SceneManager();
	~SceneManager();
		
	//Drawing & updating
	void updateScene(float delta);
	void renderScene();
	void sortEntitiesY();
	void sortEntitiesX();
	
	//Overloaded methods.
	void			removeEntity(GameEntity *gameEntity);
	GameEntity*		addEntity(GameEntity *gameEntity);
		
	//debug methods
	void debugPrintEntityList();
	
private:
	typedef std::vector<GameEntity *> ENTITY_VECTOR;
	typedef std::vector<GameEntity *>::iterator ENTITY_VECTOR_ITERATOR;
	
	ENTITY_VECTOR entityList;
};

#endif