/*
 *  gecHealthHuman.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 6/7/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "gecHealthHuman.h"

std::string gecHealthHuman::mGECTypeID = "gecHealthHuman";

#pragma mark -
#pragma mark initializer

#pragma mark -
#pragma mark GEComponent Interface
void gecHealthHuman::update(float delta)
{
	/* Perform the updates for this entity here. */
}

#pragma mark -
#pragma mark CompHealth Inteface
void gecHealthHuman::removeHealth(const int removed_health)
{
    current_health -= removed_health;
}

void gecHealthHuman::addHealth(const int added_health)
{
	current_health += added_health;	
}