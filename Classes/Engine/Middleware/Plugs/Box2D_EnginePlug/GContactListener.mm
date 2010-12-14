/*
 *  GContactListener.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/8/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include <algorithm>

#include "GContactListener.h"

GContactListener::GContactListener()
{
	contacts = new ContactsVector;
}

void GContactListener::BeginContact(b2Contact* contact)
{
	GContact newContact = { contact->GetFixtureA(), contact->GetFixtureB() };
	contacts->push_back(newContact);
}

void GContactListener::EndContact(b2Contact* contact)
{
	GContact newContact = { contact->GetFixtureA(), contact->GetFixtureB() };
	ContactsVector::iterator it;
	it = std::find(contacts->begin(), contacts->end(), newContact);
	
	if(it != contacts->end())
		contacts->erase(it);
}

void GContactListener::PreSolve(b2Contact* contact, const b2Manifold* oldManifold) 
{
}

void GContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse) 
{
}