//
//  SceneManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/16/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#ifndef __SCENE_MANAGER_H__
#define __SCENE_MANAGER_H__

#include <vector>
#include <iostream>

#include "LuaRegisterManager.h"
#include "GameEntity.h"

/** The Scene class is a node with a list of it's associated GameEntities.
	@remarks
		We don't use the classic Scene->SceneList. We talk about a SceneManager, 
		which manages a list of GameEntities. Each GameEntity can also have it's
		own list of GameEntities.
 */
class Scene
{
public:
//------------------------------------------------------------------------------	
	/** Constructor */
	Scene();
	
	/** Destructor */
	~Scene();
	
//------------------------------------------------------------------------------		
	/** Updates the GameEntities present in this scene. 
	 */
	void updateScene(float delta);
	
	/** Renders the GameEntities present in this scene.
	 */
	void renderScene();
	
	/** Sorsts the GameEntities comparing them by their Y botton coordinate.
	 */
	void sortEntitiesY();
	
	/** Sorts the GameEntities comparing them by their X bottom left coordinate.
	 */
	void sortEntitiesX();
	
	/** Removes a GameEntity from the Scene.
		@param gameEntity is a pointer to the gameEntity that we want to remove.
		@remarks
			The idea is that the memory address of the gameEntity is their "hash"
	 */
	void removeEntity(GameEntity *gameEntity);
	
	/** Adds a GameEntity to the Scene.
		@param gameEntity is a pointer to a gameEntity.
		@remarks
			This scene is responsible for deallocating the referenced gameEntity.
	 */
	GameEntity* addEntity(GameEntity *gameEntity);
	
//------------------------------------------------------------------------------
	/** Sets the scene unique id 
		@param _id is an std::string unique for this scene.
	 */
	void setSceneLabel(const std::string &in_label) { label = std::string(in_label); }
	
	/** Gets the scene unique id 
		@returns reference to sceneId
	 */
	const std::string &getSceneLabel(void) { return label; }
	
//------------------------------------------------------------------------------
	/** Lua Interface
	 @remarks
		This methods are to expose this class to the Lua runtime.
	 */
	static void registrate(void)
	{
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<Scene>("Scene")
		 .def(luabind::constructor<>())
		 .def("addEntity", &Scene::addEntity)
		 .property("label", &Scene::getSceneLabel, &Scene::setSceneLabel)
		 ];	
	}
	
//------------------------------------------------------------------------------		
	/** Prints a detailed list of GameEntities present in this scene.
		@remarks
			Used for debug purposes.
	 */
	void debugPrintEntityList();
	
//------------------------------------------------------------------------------
private:
	typedef std::vector<GameEntity *> ENTITY_VECTOR;
	typedef std::vector<GameEntity *>::iterator ENTITY_VECTOR_ITERATOR;
	
	std::string label; /** < Unique identifier for this scene */
	
	ENTITY_VECTOR entityList; /** Vector of GameEntities owned by this SceneManager */
};

#endif