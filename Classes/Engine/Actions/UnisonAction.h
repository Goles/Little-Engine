//
//  UnisonAction.h
//  GandoEngine
//
//  Created by Nicolas Goles on 4/8/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __UNISON_ACTION_H__
#define __UNISON_ACTION_H__

#include "FiniteTimeAction.h"
#include <vector>

#include "FiniteTimeAction.h"

namespace gg { namespace action {
    
    class UnisonAction : public FiniteTimeAction
    {
        
    public:
        void addAction(FiniteTimeAction *a);
        
        virtual void refresh(float dt)
        {
            
        }
        
    };
    
}}
#endif
