//
//  GameElement.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameEntity.h"

Boolean GameEntity::getIsActive()
{
	return isActive;
}

void GameEntity::setIsActive(Boolean inActive)
{
	isActive = inActive;
}