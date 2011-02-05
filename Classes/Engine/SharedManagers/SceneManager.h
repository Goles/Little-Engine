/*
 *  SceneManager.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 9/23/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef __SHARED_SCENE_MANAGER_H__
#define __SHARED_SCENE_MANAGER_H__

#include <map>
#include <string>

#include "Scene.h"
#include "LuaRegisterManager.h"

#define SCENE_MANAGER SceneManager::getInstance()

/** Manages the whole SceneMap of a Game
 */
class SceneManager
{	
public:
//------------------------------------------------------------------------------
	/** Returns singleton instance */
	static	SceneManager* getInstance();
	
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
    
    /** Get the current active Scene
        @
        @
        @
     */
    Scene   *getActiveScene() { return activeScene; }
	
//------------------------------------------------------------------------------
/** Lua Interface
 @remarks
 This methods are to expose this class to the Lua runtime.
 */
static void registrate(void)
{
	luabind::module(LR_MANAGER_STATE) 
	[
	 luabind::class_<SceneManager>("SceneManager")
	 .def("addScene", &SceneManager::addScene)
	 .def("getScene", &SceneManager::getScene)
	 .def("setActiveScene", &SceneManager::setActiveScene)
	 .scope
	 [
	  luabind::def("getInstance", &SceneManager::getInstance)
	 ]
	 ];	
}

//------------------------------------------------------------------------------ 
protected:
	SceneManager() : activeScene(0){}

//------------------------------------------------------------------------------	
private:
	typedef std::map<std::string, Scene *> SceneMap;
	typedef std::pair<std::string, Scene *> SceneMapPair;
	
	static SceneManager *instance;
	Scene *activeScene;
	SceneMap scenes;

};

#endif