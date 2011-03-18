/*
 *  CompCollisionable.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef _CompCollisionable_H_
#define _CompCollisionable_H_

#include <string>

#include "Box2D.h"
#include "GEComponent.h"

class CompCollisionable: public GEComponent
{
	//CompCollisionable interface
public:
	CompCollisionable() : entityBody(NULL), tag(NULL), m_solid(true) {}
	~CompCollisionable();
	virtual void setTransform(b2Body * const b) = 0;
	void setTag(const std::string &name) { if(!tag){ tag = new std::string(name); } else tag->assign(name); }
	const std::string *getTag() { return tag; }
	bool getSolid() const { return m_solid; }	
	void setSolid(const bool in_solid) { m_solid = in_solid; }
	
	//GEComponent Interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	
	//Shared atributes
protected:
	b2Body* entityBody;
	std::string *tag;
	
	//Private Atributes.
private:
	static gec_id_type mFamilyID;
	bool m_solid;
};

#endif