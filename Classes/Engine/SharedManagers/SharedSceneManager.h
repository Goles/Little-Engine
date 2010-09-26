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
#include "LuaRegisterManager.h"

#define SCENE_MANAGER SharedSceneManager::getInstance()

/** Manages the whole SceneMap of a Game
 */
class SharedSceneManager
{	
public:
//------------------------------------------------------------------------------
	/** Returns singleton instance */
	static	SharedSceneManager* getInstance();
	
	/** Retrieves Scene from the Scene Map
		@param s is the scene std::string "key" name.
		@returns Scene * pointer
		@remarks
			If the scene is not found, NULL is returned
	 */
	Scene	*getScene(const std::string &s);
	
	/** Adds a Scene to the Scene Map
		@param Pointer to an allocated Scene
		@returns Pointer to the added scene or NULL
		@remarks
			Returns NULL if there's already a scene with the name of the scene
			that we are trying to add in the Scene Map.
	 */
	Scene	*addScene(Scene *s);
	
	/** Set's the Currently active Scene.
		@param scenName is the name of the scene that we want to "activate".
		@returns 1 if the scene is found and set to active 0 otherwise.
		@remarks
			The active Scene is being updated and rendered.
	 */
	int		setActiveScene(const std::string &sceneName);
	
//------------------------------------------------------------------------------
/** Lua Interface
 @remarks
 This methods are to expose this class to the Lua runtime.
 */
static void registrate(void)
{
	luabind::module(LR_MANAGER_STATE) 
	[
	 luabind::class_<SharedSceneManager>("SceneManager")
	 .def("addScene", &SharedSceneManager::addScene)
	 .def("getScene", &SharedSceneManager::getScene)
	 .def("setActiveScene", &SharedSceneManager::setActiveScene)
	 .scope
	 [
	  luabind::def("getInstance", &SharedSceneManager::getInstance)
	 ]
	 ];	
}

//------------------------------------------------------------------------------ 
protected:
	SharedSceneManager():activeScene(NULL){}

//------------------------------------------------------------------------------	
private:
	typedef std::map<std::string, Scene *> SceneMap;
	typedef std::pair<std::string, Scene *> SceneMapPair;
	
	static SharedSceneManager *instance;
	Scene *activeScene;
	SceneMap scenes;

};

#endif