/*
 *  gecImage.mm
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/17/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "gecImage.h"

std::string gecImage::mGECTypeID = "gecImage";

#pragma mark -
#pragma mark gecVisual
void gecImage::render() const
{
	GameEntity *ge = this->getOwnerGE();
	image->renderAtPoint(CGPointMake(ge->x, ge->y), true);
}

