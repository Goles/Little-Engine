/*
 *  gecHealthHuman.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 6/7/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "gecHealthUndead.h"

std::string gecHealthUndead::mGECTypeID = "gecHealthUndead";

#pragma mark -
#pragma mark initializer

#pragma mark -
#pragma mark GEComponent Interface
void gecHealthUndead::update(float delta)
{
	/* Perform the updates for this entity here. */
    regenerateHealth();
}

void gecHealthUndead::removeHealth(const int removed_health)
{
    current_health += removed_health;
}

void gecHealthUndead::addHealth(const int added_health)
{
	current_health -= added_health;	
}

void gecHealthUndead::setRegenRate(const float inputRegenRate)
{
    regenRate = inputRegenRate;
}

float getRegenRate();
{
    return regenRate;
}

void regenerateHealth();
{
    current_health = current_health * getRegenRate();
}
