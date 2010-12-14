//
//  SharedInputManager.m
//  Particles_2
//
//  Created by Nicolas Goles on 12/3/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#include "SharedInputManager.h"
#include "gecGUI.h"
#include "GandoBox2D.h"
#include "GameEntity.h"

SharedInputManager* SharedInputManager::singletonInstance = NULL;

#pragma mark initializers

SharedInputManager* SharedInputManager::getInstance()
{
	if(singletonInstance == NULL)
	{
		singletonInstance = new SharedInputManager();
	}
	return singletonInstance;
}

SharedInputManager::SharedInputManager() : incrementalID(0)
{
	this->initGUIState();
}

void SharedInputManager::initGUIState()
{
	for(int i = 0; i < MAX_TOUCHES; i++)
	{
		GUIState[i].x			= 0;
		GUIState[i].y			= 0;
		GUIState[i].fingerDown	= false;
		GUIState[i].hitFirst	= false;
		GUIState[i].touchID		= NULL;
	}	
}

#pragma mark action_methods

void SharedInputManager::registerGameEntity(GameEntity *anEntity)
{
	touchReceivers.insert(GameEntityMapPair(incrementalID, anEntity));
}

GameEntity* SharedInputManager::getGameEntity(int guiID)
{
	GameEntityMap::iterator it = touchReceivers.find(guiID);
	
	if (it != touchReceivers.end()) {
		return(it->second);
	}
	
	return NULL;
}

void SharedInputManager::removeGameEntity(int guiID)
{
	touchReceivers.erase(guiID);
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
			GUIState[i].fingerDown = true;
			this->broadcastInteraction(x, y, i, touchID, kTouchType_moved);
			break;
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
			GUIState[i].touchID = NULL;
			break;
		}
	}
}

void SharedInputManager::broadcastInteraction(float x, float y, int touchIndex, void *touchID, int touchType)
{	
	GameEntityMap::iterator it;
	
	//TODO: This logic should be created in components that will support touch
	
	/*We tell every component the is subscribed that touches happened*/
	for (it = touchReceivers.begin(); it != touchReceivers.end(); ++it)
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

void SharedInputManager::debugPrintGUIState()
{
	std::cout << "**DEBUG PRINT GUISTATE[]**" << std::endl;
	
	for(int i = 0; i < MAX_TOUCHES; i++)
	{
		std::cout << "GUIState[" << i << "]***" << std::endl;
		std::cout << "fingerDown " << GUIState[i].fingerDown << std::endl;
		std::cout << "hitFirst " << GUIState[i].hitFirst << std::endl;
		std::cout << "touchID " << GUIState[i].touchID << std::endl;
		std::cout << std::endl;
	}
}

void SharedInputManager::debugPrintMap()
{
	GameEntityMap::iterator it;
	
	std::cout << "**DEBUG PRINT MAP **" << std::endl;
	std::cout << "Map Size " << touchReceivers.size() << std::endl;
	/*We tell every component the is subscribed that we have touched it.*/
	for (it = touchReceivers.begin(); it != touchReceivers.end(); it++)
	{
		std::cout << (*it).second << std::endl;
	}
}
