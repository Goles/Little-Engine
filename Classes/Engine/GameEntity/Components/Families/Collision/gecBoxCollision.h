/*
 *  gecBoxCollision.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef __gecBoxCollision_H__
#define __gecBoxCollision_H__

#include "CompCollision.h"
#include "LuaRegisterManager.h"

class gecBoxCollision: public CompCollision
{
	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	virtual void update(float delta);	
	
	//CompCollision interface
public:
	virtual void setTransform(b2Body * const b);
	
	//gecBoxCollision interface
public:
	gecBoxCollision();
	void setSize(const CGSize in_size);
	void createB2dBodyDef(void);	
	
	static void registrate(void)
	{
		luabind::module(LR_MANAGER_STATE)
		[
		 luabind::class_<gecBoxCollision, GEComponent>("gecBoxCollision")
		 .def(luabind::constructor<>())
		 .def("setSize", &gecBoxCollision::setSize)
		 .def("createB2dBodyDef", &gecBoxCollision::createB2dBodyDef)
		];
	}
	
	//Private Atributes.
private:
	static	gec_id_type mGECTypeID;	
	CGSize	m_size;
};

#endif