//
//  SharedInputManager.m
//  Particles_2
//
//  Created by Nicolas Goles on 12/3/09.
//  Copyright 2009 GandoGames. All rights reserved.
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
	for(int i = 0; i < MAX_TOUCHES; i++)
	{
		GUIState[i].x			= 0;
		GUIState[i].y			= 0;
		GUIState[i].fingerDown	= false;
		GUIState[i].hitFirst	= false;
		GUIState[i].touchID		= NULL;
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
			GUIState[i].fingerDown	= true;
			GUIState[i].touchID		= touchID;
			this->broadcastInteraction(x, y, i, touchID, kTouchType_began);
			break;
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
	for(int i = 0; i < MAX_TOUCHES; i++)
	{
		if(GUIState[i].fingerDown)
		{
			GUIState[i].x = x;
			GUIState[i].y = y;
			GUIState[i].fingerDown	= true;
			this->broadcastInteraction(x, y, i, touchID, kTouchType_moved);
			break; //
		}
	}
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
			GUIState[i].fingerDown	= false;
			GUIState[i].touchID	= touchID;
			GUIState[i].hitFirst = false;
			this->broadcastInteraction(x, y, i, touchID, kTouchType_ended);
			break;
		}
	}
}

void SharedInputManager::broadcastInteraction(float x, float y, int touchIndex, void *touchID, int touchType)
{	
	gameEntityMap::iterator it;
	
	//std::cout << "X :" << x << " Y: " << y << std::endl;
	
	/*We tell every component the is subscribed that touches happened*/
	for (it = receiversMap.begin(); it != receiversMap.end(); ++it)
	{
		if(((*it).second)->isActive)
		{	
			GEComponent *gec = ((*it).second)->getGEC(std::string("CompGUI"));
			gecGUI *gGUI = static_cast<gecGUI *> (gec);
			if( gGUI )
			{
				if(touchType == kTouchType_began && gGUI->regionHit(x, y))
				{
					GUIState[touchIndex].hitFirst = true;
				}
				gGUI->immGUI(x, y, touchIndex, touchID, touchType); //Trigger the immGUI handler.
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
