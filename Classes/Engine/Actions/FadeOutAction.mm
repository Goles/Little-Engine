//
//  FadeOutAction.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 4/2/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "FadeOutAction.h"
#include "GameEntity.h"
#include "gecVisual.h"

namespace gg { namespace action {

void FadeOutAction::afterUpdate(float dt)
{
    gecVisual *visual = static_cast<gecVisual *>(m_target->getGEC("CompVisual"));
    
    if(visual)
        visual->setAlpha(1 - dt);
}

}} //END gg::action