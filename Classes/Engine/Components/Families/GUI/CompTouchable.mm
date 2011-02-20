//
//  CompTouchable.mm
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#import "CompTouchable.h"

#include <iostream>

std::string CompTouchable::mFamilyID = "CompGUI";

void CompTouchable::registerTouchable(const CompTouchable *in_touchable)
{
	TOUCHABLE_MANAGER->registerTouchable(in_touchable);
}

void CompTouchable::unregisterTouchable()
{
	TOUCHABLE_MANAGER->deleteTouchable(m_Id);
}