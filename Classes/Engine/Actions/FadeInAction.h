//
//  FadeInAction.h
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __FADE_IN_ACTION_H__
#define __FADE_IN_ACTION_H__

#include "FiniteTimeAction.h"

class FadeInAction : public FiniteTimeAction
{

public:
    virtual void refresh(float dt);
    
    
};

#endif