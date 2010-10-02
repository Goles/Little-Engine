/*
 *  gecWeapon.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/11/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _gecWeapon_H_
#define _gecWeapon_H_

#include "CompWeapon.h"
#include "GandoBox2D.h"
#include "GameEntity.h"
#include "gecFSM.h"

class gecWeapon: public CompWeapon
{
	//gecWeapon interface
public:
	gecWeapon();

	void attack();

    //init method
    
public:
    init(GameEntity *ge, float _width, float _height):
                width(_width),
				height(_height)
    {
        tag = new std::string("weapon");
        active = false;
        ownerGE = ge;
        this->intialize();
    }

	//CompWeapon Interface
public:
	virtual void setTransform(b2Body *b);
	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	virtual void update(float delta);
	
//------------------------------------------------------------------------------
	/** Lua Interface
	 @remarks
		This methods are to expose this class to the Lua runtime.
	 */
	static void registrate(void)
	{
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<gecWeapon>("gecWeapon")                				/** < Binds the gecWeapon class*/
		 .def(luabind::constructor<>())											/** < Binds the gecWeapon constructor  */
		 .def("init", (void(gecWeapon::*)(const GameEntity &,
										  const float &, 
										  const float &)) 
	         )
		 ];
	}
	
//------------------------------------------------------------------------------	
	
	
	
	//Private Atributes.
private:
	void intialize();
	int checkOwnerState(kBehaviourState state) const;
	static gec_id_type mGECTypeID;
	b2Body* weaponBody;
	float width, height;
};

#endif
