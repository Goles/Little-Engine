/*
 *  CompCollision.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include "CompCollision.h"
#include "GandoBox2D.h"

std::string CompCollision::mFamilyID = "CompCollision";

#pragma mark -
#pragma mark destroy
CompCollision::~CompCollision()
{
	GBOX_2D_WORLD->DestroyBody(entityBody);
}