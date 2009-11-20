//
//  SceneManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameEntity.h"
#include "ParticleSystem.h"
#include <vector>
#include <iostream>

typedef std::vector<GameEntity *> ENTITY_VECTOR;
typedef std::vector<GameEntity *>::iterator ENTITY_VECTOR_ITERATOR;

class SceneManager
{
public:
	//Constructor
	SceneManager();
		
	//Drawing & updating
	void updateScene();
	void renderScene();
	void sortEntitiesY();
	void sortEntitiesX();
	
	//Overloaded methods.
	void			removeEntity(GameEntity *gameEntity);
	void			removeEntity(ParticleSystem *particleSystem);	
	GameEntity*		addEntity(GameEntity *gameEntity);
	ParticleSystem* addEntity(ParticleSystem *particleSystem);
		
	//debug methods
	void debugPrintEntityList();
	
	//Destructor
	~SceneManager();
private:

	ENTITY_VECTOR entityList;
};

