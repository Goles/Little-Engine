/*
 *  SharedSceneManager.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 9/23/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef __SHARED_SCENE_MANAGER_H__
#define __SHARED_SCENE_MANAGER_H__

#include <map>
#include <string>

#include "Scene.h"

class SharedSceneManager
{	
public:
	static	SharedSceneManager* getInstance();
	Scene	*getScene(const std::string &s);
	Scene	*addScene(Scene *s);
	int		setActiveScene(const std::string &sceneName);
protected:
	SharedSceneManager();
	
private:
	typedef std::map<std::string, Scene *> SceneMap;
	typedef std::pair<std::string, Scene *> SceneMapPair;
	
	static SharedSceneManager *instance;
	Scene *activeScene;
	SceneMap scenes;

};

#endif