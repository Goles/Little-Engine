//
//  gecGUI.mm
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "gecGUI.h"
#import "SharedInputManager.h"

std::string gecGUI::mFamilyID = "CompGUI";

void gecGUI::setOwnerGE(GameEntity* gE)
{
	gecGUI::ownerGE = gE;
	INPUT_MANAGER->registerGameEntity(this->getOwnerGE());
}
