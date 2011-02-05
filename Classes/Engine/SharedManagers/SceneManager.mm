/*
 *  SceneManager.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 9/23/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include "SceneManager.h"

SceneManager *SceneManager::instance = NULL;

SceneManager* SceneManager::getInstance()
{
	if(!instance)
	{
		instance = new SceneManager();
	}
	
	return instance;
}

Scene* SceneManager::getScene(const std::string &sceneName)
{
	//Should check if he has it, if it doesn't then create it.
	SceneMap::iterator it = scenes.find(sceneName);
	
	/*If the key is already in the map*/
	if(it != scenes.end())
		return(it->second);
	
	return NULL;
}

Scene* SceneManager::addScene(Scene *aScene)
{
	std::string sceneName = aScene->getSceneLabel();
	
	//Return NULL if the scene remains unnamed
	if(!aScene->getSceneLabel().compare("unnamed_scene"))
	{
		return NULL;
	}
		
	//Try to find the scene in the map
	SceneMap::iterator it = scenes.find(sceneName);
	
	//If it's already in the map return NULL.
	if(it != scenes.end())
	{
		return NULL;
	}
    
	//Return a pointer to the inserted scene
	return((scenes.insert(SceneMapPair(sceneName, aScene))).first->second);	
}

int SceneManager::setActiveScene(const std::string &sceneName)
{
	SceneMap::iterator it = scenes.find(sceneName);
	
	if (it == scenes.end()) 
	{
		std::cout << "Error: No scene named " << sceneName << " in the sceneMap" << std::endl;
		return 0;
	}else{
		activeScene = it->second;		
	}
	
	return 1;
}