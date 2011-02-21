/*
 *  CompCollisionable.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include "CompCollisionable.h"
#include "GandoBox2D.h"

std::string CompCollisionable::mFamilyID = "CompCollisionable";

#pragma mark -
#pragma mark destroy
CompCollisionable::~CompCollisionable()
{
	GBOX_2D_WORLD->DestroyBody(entityBody);
}