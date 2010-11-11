/*
 *  gecHealthHuman.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 6/7/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _gecHealthHuman_H_
#define _gecHealthHuman_H_

#include "CompHealth.h"

class gecHealthUndead: public CompHealth
{
    gecHealthUndead(){}
    
	//gecHealthHuman interface
public:
	virtual void removeHealth(const int health);
	virtual void addHealth(const int health);
	virtual void setRegenRate(const float regenRate);
	virtual void getRegenRate();
	virtual void regenerateHealth();
	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	virtual void update(float delta);

    //To register with lua
	static void registrate(void)
	{
		luabind::module(LR_MANAGER_STATE) 
		[
		 luabind::class_<CompHealth>("CompHealth"),
		 luabind::class_<gecHealthUndead, GEComponent>("gecHealthUndead")	/** < Binds the gecHealth class*/
		 .def(luabind::constructor<>())							    /** < Binds the gecHealthUndead constructor  */
		 .def("addHealth", &gecHealthUndead::addHealth)
		 .def("removeHealth", &gecHealthUndead::removeHealth)
		 .def("setRegenRate", &gecHealthUndead::setRegenRate)		 
		 ];
	}
    }
	
	//Private Atributes.
private:
	static gec_id_type mGECTypeID;
	float regenRate;
	
};

#endif
