//
//  ActionManager.h
//  GandoEngine
//
//  Created by Nicolas Goles on 4/2/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __ACTION_MANAGER_H__
#define __ACTION_MANAGER_H__

#define ACTION_MANAGER gg::action::ActionManager::getInstance()

#include <vector>
#include <map>
#include <cstdarg>

namespace gg { namespace action {

class IAction;
class FiniteTimeAction;
    
class ActionManager 
{
public:
    static ActionManager* getInstance() {
        if(!m_instance)
            m_instance = new ActionManager();
        
        return m_instance;
    }
    
    ~ActionManager();
    void update(float delta);
    void addAction(IAction *action);
    void addParallelActions(FiniteTimeAction *action, ...);
    void removeAction(IAction *action);
    unsigned totalActionsNum() const;
    void cleanup();    

    
protected:
    ActionManager() {}
    
private:
    typedef std::vector<IAction *> ActionVector;
    typedef std::map<unsigned, ActionVector*> ActionMap;
    
    ActionMap actions;
    ActionVector cleanupActions;     
    static ActionManager *m_instance;
};
    
}}
#endif