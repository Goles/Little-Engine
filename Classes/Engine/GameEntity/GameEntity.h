//
//  GameElement.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 GandoGames. All rights reserved.
//
#ifndef __GAME_ENTITY_H__
#define __GAME_ENTITY_H__

#include <iostream>
#include <map>
#include <vector>

/** Forward Declaration of GEComponent */
class GEComponent;

/** Base class to represent a Game Entity.
 @remarks
	Everything that lives inside the game is considered a GameEntity. From a trigger,
	to an Enemy. A GameEntity is by definition a collection of components. (GEComponent)
 */
class GameEntity
{
public:
	
	float		 x,	/**< X position of the Entity */
				 y,	/**< Y position of the Entity */
			height,	/**< Height of the Entity */
			 width;	/**< Width of the Entity */
	float	 speed;
	bool  isActive;	/**< Is the Entity "sleeping" or not */
//------------------------------------------------------------------------------
	/** Default Constructor */
	GameEntity();
	
	/** Position Constructor
	 @remarks
		Constructor to set the game entity to an initial position.
	 @param x specify X screen position coordinate.
	 @param y specity Y screen position coordinate.
	 */
	GameEntity(float x, float y);
	
	/** Position + Size Constructor
	 @remarks
		Constructor to place the entity to an initial position and set a
		fixed size for this entity.
	 @param x specify X screen position coordinate.
	 @param y specity Y screen position coordinate.
	 @param inWidth represents entity width.
	 @param inHeight represents entity height.
	 */
	GameEntity(float inX, float inY, int inWidth, int inHeight);
	virtual ~GameEntity(){ this->clearGECs(); }
//------------------------------------------------------------------------------
	/** Updates the Game Entity.
	 @remarks
		A Game Entity update just updates the component map that compose it.
	 @param delta represents the time interval since the last update - 1/60 for 60fps.
	 */
	void update(float delta);

	/** Adds a GameEntityComponent - GEC - to the GameEntity.
	  @remarks
		Called when we want to add a GEC to a GameEntity. It's important to note that
		a GameEntity can't have two components that share the same FamilyID.
	  @param newGEC represents a reference to an allocated component.
	 */
	void setGEC( GEComponent *newGEC );
	
	/** Returns a GEC that is owned by the GameEntity.
	 @remarks
		Only one GEC reference is returned by this method.
	 @returns a pointer of type GEComponent to the corresponding GEC or NULL if not found.
	 @param familyID Represents the familyID of the component that we want - eg: "CompVisual" -
	 */
	GEComponent* getGEC( const std::string &familyID );
	
	/** Deletes all the GECs that are owned by the GameEntity.
	 @remarks
		It just calls the STL map clear method is called over the components map.
		- All the elements in the container are dropped: their destructors are called, 
		and then they are removed from the container, leaving it with a size of 0.- 
	 */
	void clearGECs() { components.clear(); }
//------------------------------------------------------------------------------
	/** Returns TRUE or FALSE if the GameEntity is active or not*/
	const bool		getIsActive() const { return isActive; }

	/** Put's a Game Entity in an Active/Inactive state. 
	 @param inActive set's an entity to active when true, and the opposite when false
	 */
	const void		setIsActive(bool inActive) { isActive = inActive; }
	
	/** Returns the GameEntity speed */
	const float		getSpeed() const { return speed; }
	
	/** Set's the GameEntity speed */
	const void		setSpeed(float s) { speed = s; }
	
	/** Flips the GameEntity Horizontally (facing right or left)*/
	void			setFlipHorizontally(bool f){ flipHorizontally = f; }
	
	/** Returns the GameEntity Flip State.*/
	bool			getFlipHorizontally() { return flipHorizontally; }
//------------------------------------------------------------------------------
public:
	/** Functor to sort/compare Game Entities by the X poosition coordinate  
	 @remarks
		Mostly used by STL containers
	 */
	friend class compareByX;
    class compareByX 
	{
	public:
	bool operator()(GameEntity const *a, GameEntity const *b) { 
            return (a->x < b->x);
        }
    };
	
	/** Functor to sort/compare Game Entities by the X poosition coordinate  
	 @remarks
		Mostly used by STL containers
	 */	
	friend class compareByY;
    class compareByY 
	{
	public:
        bool operator()(GameEntity const *a, GameEntity const *b) 
		{ 
            return ((a->y - (a->height/2)) > (b->y - (b->height/2)) );
        }
    };
//------------------------------------------------------------------------------
public:
	/** Print's all the Game Entity components for debugging
	 @remarks 
		Ideally you can use this anywhere in the code, but also when using GDB.		
	 */
	void debugPrintComponents();
//------------------------------------------------------------------------------	
private:
	/** Definition to easily work with an STL Map of Components */
	typedef std::map<const std::string, GEComponent *> ComponentMap;
	
	/** Definition to easily work with an STL Map of Components Pair*/
	typedef std::pair<const std::string, GEComponent *>	ComponentMapPair;
	
	ComponentMap components; /** < Game Entity Map of Components */
	bool flipHorizontally;	 /** < Game Entity bool to switch horizontally */
};

#endif