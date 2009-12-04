//
//  SharedInputManager.m
//  Particles_2
//
//  Created by Nicolas Goles on 12/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#include "SharedInputManager.h"
#include "GameEntity.h"

SharedInputManager* SharedInputManager::singletonInstance = NULL;

#pragma mark constructor
SharedInputManager* SharedInputManager::getInstance()
{
	if(singletonInstance == NULL)
		singletonInstance = new SharedInputManager();
	
	return singletonInstance;
}

#pragma mark touch_management
void SharedInputManager::touchesBegan(float x, float y)
{
	gameEntityMap::iterator it;
	
	//we must message all the map entities about a touch happening, they are responsible for managing it.
	for (it = receiversMap.begin(); it != receiversMap.end(); it++)
	{
		//it->second->touchesBegan(x, y);
	}
}

void SharedInputManager::touchesMoved(float x, float y)
{
	gameEntityMap::iterator it;
	
	//we must message all the map entities about a touch happening, they are responsible for managing it.
	for (it = receiversMap.begin(); it != receiversMap.end(); it++)
	{
		//it->second->touchesMoved(x, y);
	}
}

void SharedInputManager::touchesEnded(float x, float y)
{
	gameEntityMap::iterator it;
	
	//we must message all the map entities about a touch happening, they are responsible for managing it.
	for (it = receiversMap.begin(); it != receiversMap.end(); it++)
	{
		//it->second->touchesEnded(x, y);
	}
}
