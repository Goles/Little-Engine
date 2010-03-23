//
//  SharedInputManager.m
//  Particles_2
//
//  Created by Nicolas Goles on 12/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#include "SharedInputManager.h"
#include "gecGUI.h"

SharedInputManager* SharedInputManager::singletonInstance = NULL;

#pragma mark constructor
SharedInputManager* SharedInputManager::getInstance()
{
	if(singletonInstance == NULL)
	{
		singletonInstance = new SharedInputManager();
	}
	return singletonInstance;
}

SharedInputManager::SharedInputManager()
{
	for(int i = 0; i < 2; i++)
	{
		GUIState[i].x			= 0;
		GUIState[i].y			= 0;
		GUIState[i].hotItem		= 0;
		GUIState[i].fingerDown	= false;
	}

	guiIDMax = 0;
}

#pragma mark action_methods
void SharedInputManager::registerGameEntity(GameEntity *anEntity)
{
	receiversMap.insert(gameEntityMapPair(guiIDMax, anEntity));
}

GameEntity* SharedInputManager::getGameEntity(int guiID)
{
	gameEntityMap::iterator it = receiversMap.find(guiID);
	
	if (it != receiversMap.end()) {
		return(it->second);
	}
	
	return NULL;
}

void SharedInputManager::removeGameEntity(int guiID)
{
	receiversMap.erase(guiID);
}

#pragma mark touch_management
void SharedInputManager::touchesBegan(float x, float y, void *touchID)
{
	//Flip Parameters due to landscape mode
	float auxX = x;
	x = y;
	y = auxX;
	
	//We need to set the GUIState
	for(int i = 0; i < MAX_TOUCHES; i++)
	{
		if(!GUIState[i].fingerDown)
		{
			GUIState[i].x = x;
			GUIState[i].y = y;
			GUIState[i].fingerDown = true;
			GUIState[i].touchID	= touchID;
			this->broadcastInteraction(x, y, touchID);
			break; //
		}
	}
}

void SharedInputManager::touchesMoved(float x, float y, void *touchID)
{
	//Flip Parameters due to landscape mode
	float auxX = x;
	x = y;
	y = auxX;
	
	//We need to set the GUIState
	/*GUIState.x = x;
	GUIState.y = y;
	GUIState.fingerDown = true;*/
	
	this->broadcastInteraction(x, y, touchID);
}

void SharedInputManager::touchesEnded(float x, float y, void *touchID)
{
	//Flip Parameters due to landscape mode
	float auxX = x;
	x = y;
	y = auxX;
	
	//We need to set the GUIState
	for(int i = 0; i < MAX_TOUCHES; i++)
	{
		if(GUIState[i].fingerDown && (GUIState[i].touchID == touchID))
		{
			GUIState[i].x = x;
			GUIState[i].y = y;
			GUIState[i].fingerDown = false;
			GUIState[i].touchID	= touchID;
			this->broadcastInteraction(x, y, touchID);
			break;
		}
	}
	
	this->broadcastInteraction(x, y, touchID);
}

void SharedInputManager::broadcastInteraction(float x, float y, void *touchID)
{	
	gameEntityMap::iterator it;
	
	//std::cout << "X :" << x << " Y: " << y << std::endl;
	
	/*We tell every component the is subscribed that we have touched it.*/
	for (it = receiversMap.begin(); it != receiversMap.end(); ++it)
	{
		if(((*it).second)->isActive)
		{	GEComponent *gec = ((*it).second)->getGEC(std::string("CompGUI"));
			gecGUI *gGUI = static_cast<gecGUI *> (gec);
			if( gGUI )
			{
				gGUI->immGUI(x, y, gGUI->getGuiID(), touchID); //Trigger the immGUI handler.
			}
		}
	}
}

void SharedInputManager::debugPrintMap()
{
	gameEntityMap::iterator it;
	
	std::cout << "**DEBUG PRINT MAP **" << std::endl;
	std::cout << "Map Size " << receiversMap.size() << std::endl;
	/*We tell every component the is subscribed that we have touched it.*/
	for (it = receiversMap.begin(); it != receiversMap.end(); it++)
	{
		std::cout << (*it).second << std::endl;
	}
}
