/*
 *  SharedBehaviorManager.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 12/6/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _SHARED_BEHAVIOR_MANAGER_
#define _SHARED_BEHAVIOR_MANAGER_

#include <map>

class SharedBehaviorManager 
{
public:
	SharedBehaviorManager* getInstance();
	
protected:
	SharedBehaviorManager();
	
private:
	static SharedBehaviorManager *instance;
	
};

#endif