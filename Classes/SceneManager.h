//
//  SceneManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameEntity.h"
#include "gecParticleSystem.h"
#include <vector>
#include <iostream>

class GEComponent;

class SceneManager
{
public:
	//Constructor
	SceneManager();
		
	//Drawing & updating
	void updateScene(float delta);
	void renderScene();
	void sortEntitiesY();
	void sortEntitiesX();
	
	//Overloaded methods.
	void			removeEntity(GameEntity *gameEntity);
	//void			removeEntity(ParticleSystem *particleSystem);	
	GameEntity*		addEntity(GameEntity *gameEntity);
	//ParticleSystem* addEntity(ParticleSystem *particleSystem);
		
	//debug methods
	void debugPrintEntityList();
	
	//Destructor
	~SceneManager();
private:
	typedef std::vector<GameEntity *> ENTITY_VECTOR;
	typedef std::vector<GameEntity *>::iterator ENTITY_VECTOR_ITERATOR;
	
	ENTITY_VECTOR entityList;
};

