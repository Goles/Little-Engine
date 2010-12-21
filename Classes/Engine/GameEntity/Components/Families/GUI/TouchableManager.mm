/*
 *  TouchableManager.mm
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 12/21/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "TouchableManager.h"
#include "gecGUI.h"
#include "GandoBox2D.h"
#include "GameEntity.h"

TouchableManager* TouchableManager::singletonInstance = NULL;

#pragma mark initializers

TouchableManager* TouchableManager::getInstance()
{
	if(singletonInstance == NULL)
		singletonInstance = new TouchableManager();
	
	return singletonInstance;
}

TouchableManager::TouchableManager() : incrementalID(0)
{
	this->initGUIState();
}

void TouchableManager::initGUIState()
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

void TouchableManager::registerTouchable(gecGUI *inTouchable)
{
	touchReceivers.insert(TouchableMapPair(incrementalID, inTouchable));
}

gecGUI* TouchableManager::getTouchable(int guiID)
{
	TouchableMap::iterator it = touchReceivers.find(guiID);
	
	if (it != touchReceivers.end()) {
		return(it->second);
	}
	
	return NULL;
}

void TouchableManager::removeTouchable(int guiID)
{
	touchReceivers.erase(guiID);
}

#pragma mark touch_management
void TouchableManager::touchesBegan(float x, float y, void *touchID)
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

void TouchableManager::touchesMoved(float x, float y, void *touchID)
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

void TouchableManager::touchesEnded(float x, float y, void *touchID)
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

void TouchableManager::broadcastInteraction(float x, float y, int touchIndex, void *touchID, int touchType)
{	
	TouchableMap::iterator it;
	
	//TODO: This logic should be created in components that will support touch
	
	/*We tell every component the is subscribed that touches happened*/
	for (it = touchReceivers.begin(); it != touchReceivers.end(); ++it)
	{
		if (((*it).second)->getOwnerGE()->isActive)
		{	
			gecGUI *gGUI = (*it).second;
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

void TouchableManager::debugPrintGUIState()
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

void TouchableManager::debugPrintMap()
{
	TouchableMap::iterator it;
	
	std::cout << "**DEBUG PRINT MAP **" << std::endl;
	std::cout << "Map Size " << touchReceivers.size() << std::endl;
	/*We tell every component the is subscribed that we have touched it.*/
	for (it = touchReceivers.begin(); it != touchReceivers.end(); it++)
	{
		std::cout << (*it).second << std::endl;
	}
}
