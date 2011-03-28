//
//  FiniteTimeAction.h
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __FINITE_TIME_ACTION_H__
#define __FINITE_TIME_ACTION_H__

#include "Action.h"

class FiniteTimeAction : public Action
{
public:
    virtual void update(float delta);
    
    virtual void refresh(float time) = 0;
    
    void setDuration(float dt) { 
            
        m_duration = dt; 
        
        if (m_duration == 0.0) 
            m_duration = FLT_EPSILON; 
    }
    
    bool isDone() { 
        return (m_elapsed >= m_duration); 
    } 
    
private:    
    float m_duration;
    float m_elapsed;
    bool m_firstTick;
    
};

#endif