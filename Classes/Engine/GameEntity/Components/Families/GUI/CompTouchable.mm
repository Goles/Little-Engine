//
//  CompTouchable.mm
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#import "CompTouchable.h"
#import "TouchableManager.h"
#include <iostream>
std::string CompTouchable::mFamilyID = "CompGUI";

void CompTouchable::registerTouchable()
{
	TOUCHABLE_MANAGER->registerTouchable(this);
}

void CompTouchable::unregisterTouchable()
{
	TOUCHABLE_MANAGER->removeTouchable(this->getId());
}