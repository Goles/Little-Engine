//
//  FadeInAction.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "FadeInAction.h"
#include "GameEntity.h"
#include "gecVisual.h"

namespace gg { namespace action {

void FadeInAction::afterUpdate(float dt)
{
    gecVisual *visual = static_cast<gecVisual *>(m_target->getGEC("CompVisual"));
    
    if(visual)
        visual->setAlpha(dt);
}

}} //END gg::action