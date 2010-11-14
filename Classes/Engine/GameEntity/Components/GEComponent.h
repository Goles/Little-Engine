//
//  GEComponent.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/25/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#ifndef _GECOMPONENT_H_
#define _GECOMPONENT_H_

/** Forward Declaration of GameEntity */
class GameEntity;

#include <string>

#include "LuaRegisterManager.h"

/** Component system base class.
 @remarks
	To create any Family of components, the main familiy components should
	inherit from GEComponent. This is in order to obtain a basic level of
	polymorphism when using and creating components.
 */
class GEComponent
{
public:
	typedef std::string gec_id_type;
		
	/** GEComponent Constructor.
	 @remarks
		This constructor uses an initialization list, basically it will set
		the ownerGE variable to NULL.
	 */
	GEComponent():ownerGE(0){}
	virtual ~GEComponent(){}
//------------------------------------------------------------------------------	
	/** Returns the GEComponent Family ID.
	 @remarks
		The familyID should be unique to each component family.
	 @returns
		The FamilyID String. (eg:"CompVisual")
	 */
	virtual const gec_id_type&	familyID() const	= 0;
	
	/** Returns the Component ID.
	 @remarks
		The ComponentID should be unique for a given component type.
	 @returns
		The ComponentID String. (eg:"gecSprite")
	 */	
	virtual const gec_id_type&	componentID() const = 0;
	
	/** Updates a given component.
	 @remarks
		The update method must be implemented by all components, if you don't need
		to update some component for some reason, you should handle that in the
		update method.
	 @param delta Time interval delta to update the component. (1/60 sec should be ideal)
	 */
	virtual void update(float delta) = 0;
	
	/** Set's the owner GameEntity for this particular component */
	void		setOwnerGE(GameEntity *gE);

	/** Returns a reference to the owner GameEntity of this particular Component */
	GameEntity*	getOwnerGE() const;

//------------------------------------------------------------------------------
/** Lua Interface
 @remarks
 This methods are to expose this class to the Lua runtime.
 */
static void registrate(void)
{
	luabind::module(LR_MANAGER_STATE) 
	[
	 luabind::class_<GEComponent>("GEComponent")/** < Binds the GEComponent class*/
	 ];
}	
	
//------------------------------------------------------------------------------
protected:
	/** Reference to the GameEntity that owns this Component. */
	GameEntity *ownerGE;
};

#endif