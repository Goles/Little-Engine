//
//  GameElement.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 Gando-Games. All rights reserved.
//

#import "GameEntity.h"
#import "GEComponent.h"

void GameEntity::setGEC( GEComponent *newGEC )
{
	std::string familyID = newGEC->familyID();
	components[familyID] = newGEC;
}

GEComponent* GameEntity::getGEC(const std::string &familyID)
{
	return components[familyID];
}

