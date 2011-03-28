//
//  ActionManager.h
//  GandoEngine
//
//  Created by Nicolas Goles on 3/27/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef __ACTION_MANAGER_H__
#define __ACTION_MANAGER_H__

class ActionManager
{
public:
    static ActionManager *getInstance() {
        if(instance == NULL)
            instance = new ActionManager();
        
        return instance;
    }
    
protected:
    ActionManager();
    
private:
    static ActionManager *instance;
    
};

ActionManager* ActionManager::instance = NULL;

#endif

