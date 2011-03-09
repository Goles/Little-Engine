/*
 *  gecBoxCollisionable.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef __gecBoxCollisionable_H__
#define __gecBoxCollisionable_H__

#include "CompCollisionable.h"

class gecBoxCollisionable: public CompCollisionable
{
	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	virtual void update(float delta);	
	
	//CompCollisionable interface
public:
	virtual void setTransform(b2Body * const b);
	
	//gecBoxCollisionable interface
public:
	gecBoxCollisionable();
	void setSize(const CGSize in_size);
	void createB2dBodyDef(void);
	
	//Private Atributes.
private:
	static	gec_id_type mGECTypeID;	
	CGSize	m_size;
};

#endif