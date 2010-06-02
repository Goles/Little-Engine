//
//  GEComponent.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/25/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#import "GEComponent.h"

GameEntity* GEComponent::getOwnerGE() const
{ 
	if(ownerGE == NULL)
		assert(ownerGE != NULL);
	
	return ownerGE;
}