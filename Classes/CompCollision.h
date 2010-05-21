/*
 *  CompCollision.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _CompCollision_H_
#define _CompCollision_H_

#include <string>

#include "Box2D.h"
#include "GEComponent.h"

class CompCollision: public GEComponent
{
	//CompCollision interface
public:
	CompCollision() : entityBody(NULL), tag(NULL){}
	~CompCollision();
	virtual void setTransform(b2Body *b) = 0;
	void setTag(const std::string &name) { if(!tag){ tag = new std::string(name); } else tag->assign(name); }
	const std::string *getTag() { return tag; }
	
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

};

#endif