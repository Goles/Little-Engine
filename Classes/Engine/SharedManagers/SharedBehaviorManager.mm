/*
 *  SharedBehaviorManager.cpp
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 12/6/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "SharedBehaviorManager.h"

SharedBehaviorManager *SharedBehaviorManager::instance = NULL;

SharedBehaviorManager::SharedBehaviorManager()
{
	//init stuff.
}

SharedBehaviorManager* SharedBehaviorManager::getInstance()
{
	if(instance == NULL){
		instance = new SharedBehaviorManager();
	}
	
	return instance;
}