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

namespace gg { namespace action {

class FiniteTimeAction : public Action
{
    
public:
    virtual ~FiniteTimeAction() {}
    virtual void update(float delta);
    virtual void afterUpdate(float time) = 0;
    void setDuration(float dt) { 
            
        m_duration = dt; 
        
        if (m_duration == 0.0) 
            m_duration = FLT_EPSILON;
        
        m_firstTick =  true;
    }
    
    float duration() const { 
        return m_duration; 
    }
    
    bool isDone() {
        
        if (m_elapsed >= m_duration) {
            if (!Action::ended()) { //This means that the action is repeating
                m_firstTick = true;
            } else {
                return true;
            }                
        }
        
        return false;
    }
    
protected:    
    float m_duration;
    float m_elapsed;
    bool m_firstTick;    
};

}} //END gg::action
    
#endif
