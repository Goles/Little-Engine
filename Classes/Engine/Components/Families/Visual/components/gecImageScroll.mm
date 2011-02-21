/*
 *  gecImageScroll.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 1/31/11.
 *  Copyright 2011 GandoGames. All rights reserved.
 *
 */

#include "gecImageScroll.h"

#include "GameEntity.h"
#include "SharedTextureManager.h"

std::string gecImageScroll::mGECTypeID = "gecImageScroll";

void gecImageScroll::update(float delta)
{
	//Update here!
}

void gecImageScroll::render() const 
{
	[m_texture drawAtPoint:CGPointMake(getOwnerGE()->x, getOwnerGE()->x)];
}

void gecImageScroll::initWithFile(const std::string &filename)
{
	m_texture = TEXTURE_MANAGER->createTexture(filename);
	
	assert(m_texture != NULL);
}