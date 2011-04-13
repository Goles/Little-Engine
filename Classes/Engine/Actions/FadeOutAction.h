//
//  FadeOutAction.h
//  GandoEngine
//
//  Created by Nicolas Goles on 4/2/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __FADE_OUT_ACTION_H__
#define __FADE_OUT_ACTION_H__

#include "FiniteTimeAction.h"

namespace gg { namespace action {

class FadeOutAction : public FiniteTimeAction
{
    
public:
    FadeOutAction() {}
    void afterUpdate(float dt);
    
};

}}
#endif