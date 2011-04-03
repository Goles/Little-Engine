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

namespace gg { namespace action {

class IAction;
    
class ActionManager 
{
public:
    static ActionManager* getInstance() {
        if(!m_instance)
            m_instance = new ActionManager();
        
        return m_instance;
    }
    
    void update(float delta);
    void addAction(IAction *action);
    
protected:
    ActionManager() {}
    
private:
    typedef std::vector< IAction * > ActionVector;
    typedef std::map< int, ActionVector* > ActionMap;
    
    ActionMap actions;
    
    static ActionManager *m_instance;
};
    
}}
#endif