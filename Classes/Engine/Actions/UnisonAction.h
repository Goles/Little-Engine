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
#include "ActionManager.h"
#include <vector>
#include <algorithm>

namespace gg { namespace action {
    
class UnisonAction : public FiniteTimeAction
{
    
public:
    UnisonAction(){
        m_duration = 0.0f;
    }
    
    void addAction(FiniteTimeAction *a) {
        if(m_duration < a->duration())
            m_duration = a->duration();
        
        unisonActions.push_back(a);
    }
    
    virtual void refresh(float dt) {
        
    }
    
    virtual unsigned getTargetId() {
        return unisonActions[0]->getTargetId();
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

        this->refresh(MIN(1, m_elapsed/m_duration));
        
        //Remove
        if (this->isDone())
            ACTION_MANAGER->removeAction(this);
    }
    
private:
    std::vector<FiniteTimeAction *> unisonActions;
    
};
    
}}
#endif
