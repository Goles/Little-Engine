/*
 *  CompCollision.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 5/7/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "CompCollision.h"

std::string CompCollision::mFamilyID = "CompCollision";

#pragma mark -
#pragma mark init
CompCollision::CompCollision()
{
	entityBody = NULL;
}