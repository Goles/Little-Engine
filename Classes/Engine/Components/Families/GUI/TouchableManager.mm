/*
 *  TouchableManager.mm
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 12/21/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "TouchableManager.h"
#include "CompTouchable.h"
#include "GandoBox2D.h"
#include "GameEntity.h"
#include "EventBroadcaster.h"

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
void TouchableManager::registerTouchable(const CompTouchable *in_Touchable)
{
	touchReceivers.insert(TouchableMapPair(incrementalID, in_Touchable));
}

const CompTouchable* TouchableManager::getTouchable(int guiID)
{
	TouchableMap::const_iterator it = touchReceivers.find(guiID);
	
	if (it != touchReceivers.end()) {
		return(it->second);
	}
	
	return NULL;
}

void TouchableManager::deleteTouchable(int guiID)
{	
	this->debugPrintMap();
	
	TouchableMap::iterator tmit = touchReceivers.find(guiID);
	
	if(tmit != touchReceivers.end())
	{
		touchReceivers.erase(tmit);
	}else {
		std::cout << "ERROR: Touchable component couldn't be deleted because it's guiID was not found!" << std::endl;
		assert(tmit != touchReceivers.end());
	}
	
	this->debugPrintMap();
}

#pragma mark touch_management
void TouchableManager::touchesBegan(float x, float y, int touchID)
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
			GUIState[i].hitFirst = true;
			GUIState[i].touchID	= touchID;
			this->broadcastInteraction(x, y, i, touchID, TouchTypes::BEGAN);
			break;
		}
	}
}

void TouchableManager::touchesMoved(float x, float y, int touchID)
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
			GUIState[i].hitFirst = false;
			this->broadcastInteraction(x, y, i, touchID, TouchTypes::MOVED);
			break;
		}
	}
}

void TouchableManager::touchesEnded(float x, float y, int touchID)
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
			this->broadcastInteraction(x, y, i, touchID, TouchTypes::ENDED);
			GUIState[i].touchID = NULL;
			break;
		}
	}
}

void TouchableManager::broadcastInteraction(float x, float y, int touchIndex, int touchID, int touchType)
{
#ifdef DEBUG
    assert(m_broadcaster != NULL);
#endif
    
    if (m_broadcaster)
        m_broadcaster->broadcastTouch(x, y, touchIndex, touchID, touchType);
}

TouchableManager::~TouchableManager()
{
	//Don't free the touchables here since those will be freed by the Scene Manager.
	//Touchable manager is not responsible for those references.
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
	TouchableMap::const_iterator it;
	
	std::cout << "**DEBUG PRINT MAP **" << std::endl;
	std::cout << "Map Size " << touchReceivers.size() << std::endl;
	/*We tell every component the is subscribed that we have touched it.*/
	for (it = touchReceivers.begin(); it != touchReceivers.end(); ++it)
	{
		std::cout << (*it).second << std::endl;
	}
}
