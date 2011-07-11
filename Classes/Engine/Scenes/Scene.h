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
	void update(float delta);
	
	/** Renders the GameEntities present in this scene hierarchy.
	 */
	void render();
	
	/** Sorsts the GameEntities comparing them by their Y botton coordinate.
	 */
	void sortEntitiesY();
	
	/** Sorts the GameEntities comparing them by their X bottom left coordinate.
	 */
	void sortEntitiesX();
	
	/** Adds a child scene node to this Scene Node, 
	 */
	void addChild(Scene *child);
	
	/** Remove Child from the Scene hierarchy.
	 */
	void removeChild(Scene *child);
	
	/** Removes a GameEntity from the Scene.
		@param gameEntity is a pointer to the gameEntity that we want to remove.
		@remarks
			The idea is that the memory address of the gameEntity is their "hash"
	 */
	void removeGameEntity(const GameEntity *gameEntity);
	
	/** Adds a GameEntity to the Scene.
		@param gameEntity is a pointer to a gameEntity.
		@remarks
			This scene is responsible for deallocating the referenced gameEntity.
	 */
	GameEntity* addGameEntity(GameEntity *gameEntity);
	
//------------------------------------------------------------------------------
public:
	/** Functor to sort/compare Game Entities by the X poosition coordinate  
	 @remarks
	 Mostly used by STL containers
	 */
	friend class compareByZOrder;
    class compareByZOrder
	{
	public:
		bool operator()(Scene const *lhs, Scene const *rhs) { 
            return (lhs->getZOrder() < rhs->getZOrder());
        }
    };
//------------------------------------------------------------------------------
	/** Gets the scene unique id 
	 @returns reference to sceneId
	 */
	const std::string &getSceneLabel(void) { return m_label; }
	
	/** Sets the scene unique id 
		@param _id is an std::string unique for this scene.
	 */
	void setSceneLabel(const std::string &in_label) { m_label = std::string(in_label); }
	
	/** Returns the ZOrder (to see rendering/update order in hierarchy) of this scene ( bigger Z means rendered first )
	 */
	int getZOrder() const { return m_zOrder; }
	
	/**
	 */
	void setZOrder(int in_zOrder) { m_zOrder = in_zOrder; }
	
	/**
	 */
	const CGPoint &getPosition() { return m_position; }
	
	/**
	 */
	void setPosition(CGPoint in_position) { m_position = in_position; }
	
//------------------------------------------------------------------------------		
	/** Prints a detailed list of GameEntities present in this scene.
		@remarks
			Used for debug purposes.
	 */
	void debugPrintEntities();

	/** Print the Scene child list.
	 */
	void debugPrintChildren();
	
//------------------------------------------------------------------------------
protected:
	void transform();

//------------------------------------------------------------------------------
private:
	typedef std::vector<GameEntity *> EntityVector;
	typedef std::vector<Scene *> SceneVector;
		
	EntityVector m_entities; /** Vector of GameEntities owned by this Scene */
	SceneVector m_scenes; /** Vector of Children Scenes */
	
	std::string m_label; /** < Unique identifier for this scene */
	int m_zOrder;		/** < z order in which this scene will be drawn */
	CGPoint m_position;
};

#endif