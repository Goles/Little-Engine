//
//  ScaleToAction.h
//  GandoEngine
//
//  Created by Nicolas Goles on 4/14/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __SCALE_TO_ACTION_H__
#define __SCALE_TO_ACTION_H__

#include "FiniteTimeAction.h"

namespace gg { namespace action {

class ScaleToAction : public FiniteTimeAction 
{
  
public:
    virtual void started();
    virtual void afterUpdate(float dt);
};

}}
    
#endif