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
     */
    Scene   *getActiveScene() { return activeScene; }
	
	/**
	 */
	const CGSize &getWindow() { return m_window; }
	
	/**
	 */
	void setWindow(const CGSize &in_window) { m_window = in_window; }

//------------------------------------------------------------------------------ 
protected:
	SceneManager() : m_window(CGSizeZero), activeScene(0){}

//------------------------------------------------------------------------------	
private:
	typedef std::map<std::string, Scene *> SceneMap;
	typedef std::pair<std::string, Scene *> SceneMapPair;
	
	CGSize m_window;
	Scene *activeScene;
	static SceneManager *instance;
	SceneMap scenes;
};

#endif