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
#include <algorithm>
#include <vector>

namespace gg { namespace action {
    
class UnisonAction : public FiniteTimeAction
{
    
public:
    UnisonAction() : m_target_id(UINT_MAX) {
        m_duration = 0.0f;
    }
    
    void addAction(FiniteTimeAction *a) {
        if(m_duration < a->duration())
            m_duration = a->duration();
        
        unisonActions.push_back(a);
    }
    
    virtual void afterSetTarget() {
        std::vector<FiniteTimeAction *>::iterator it = unisonActions.begin();
        
        for(; it != unisonActions.end(); ++it)
        {
            (*it)->setTarget(m_target);
        }
    }
    
    virtual void afterUpdate(float dt) {
        
    }
    
    virtual unsigned targetId() {
        if(m_target_id == UINT_MAX)
            m_target_id = unisonActions[0]->targetId();
        
        return m_target_id;
    }
    
    float duration() const { 
        return m_duration; 
    }    
    
    virtual void update(float delta) 
    {
        if(m_firstTick)
        {
            m_firstTick = false;
            m_elapsed = 0.0f;        
        }
        
        m_elapsed += delta;
        
        std::vector<FiniteTimeAction *>::iterator it = unisonActions.begin();
        
        std::vector<int> toRemove;
        int counter = 0;
        
        for (; it != unisonActions.end(); ++it)
        {
            (*it)->update(delta);
            
            if ((*it)->isDone())
                toRemove.push_back(counter);
            
            ++counter;
        }
        
        for(int i = 0; i < toRemove.size(); ++i)
        {
            if (i < unisonActions.size())
            {
                std::swap(unisonActions[i],unisonActions.back());
                unisonActions.pop_back();
            }                
        }

        this->afterUpdate(MIN(1, m_elapsed/m_duration));
    }
    
    virtual ~UnisonAction() {}
    
private:
    std::vector<FiniteTimeAction *> unisonActions;
    unsigned m_target_id;
};
    
}}
#endif
