//
//  GEComponent.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/25/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#import "GEComponent.h"
#include <iostream>

GameEntity* GEComponent::getOwnerGE() const
{ 
	if(ownerGE == NULL)
	{
		std::cout << "The Owner Game Entity of a GEComponent can't be NULL" << std::endl;
		assert(ownerGE != NULL);
	}

	return ownerGE;
}

void GEComponent::setOwnerGE(GameEntity *gE)
{
	ownerGE = static_cast<GameEntity *>(gE);
}