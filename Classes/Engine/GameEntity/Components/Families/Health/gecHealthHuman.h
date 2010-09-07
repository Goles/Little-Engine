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

class gecHealthHuman: public CompHealth
{
	//gecHealthHuman interface
public:
	virtual void removeHealth(const int health);
	virtual void addHealth(const int health);
	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	virtual void update(float delta);
	
	//To register with Lua.
	static void registrate(void);
	
	//Private Atributes.
private:
	static gec_id_type mGECTypeID;
	
};

#endif