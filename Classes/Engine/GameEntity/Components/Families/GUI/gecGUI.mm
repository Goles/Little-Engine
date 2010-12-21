//
//  gecGUI.mm
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#import "gecGUI.h"
#import "SharedInputManager.h"
#include <iostream>
std::string gecGUI::mFamilyID = "CompGUI";

void gecGUI::registerGUI()
{
	
	std::cout << "Nice :) " << std::endl;
	INPUT_MANAGER->registerGameEntity(this->getOwnerGE());
}
