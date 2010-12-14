/*
 *  GContactListener.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/8/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef _GContactListener_H_
#define _GContactListener_H_

#include <vector>

#include "Box2D.h"

using std::vector;

typedef struct Contact
{
	b2Fixture *fixtureA;
	b2Fixture *fixtureB;
	bool operator==(const Contact& other) const
	{
		return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
	}
} GContact;

class GContactListener : public b2ContactListener 
{
public:    
    GContactListener();
    ~GContactListener(){};
    
	virtual void BeginContact(b2Contact* contact);
	virtual void EndContact(b2Contact* contact);
	virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);    
	virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
	
	const vector<GContact> *getContacts() { return contacts; }

private:
	typedef vector<GContact> ContactsVector;	
	ContactsVector* contacts;
};

#endif