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
	GUIState.x			= 0;
	GUIState.y			= 0;
	GUIState.fingerDown	= false;
	GUIState.hotItem	= 0;
	guiIDMax			= 0;
}

#pragma mark action_methods
void SharedInputManager::registerGameEntity(GameEntity *anEntity)
{
/*	guiIDMax++;  //auto increment key
	
	//std::cout << anEntity->getGEC("gecGUI")->componentID() << std::endl;
	
	GEComponent *gec = anEntity->getGEC("gecGUI");
	if(gec)
	{
		gecGUI *gGui = static_cast<gecGUI*> (gec);
		gGui->setGuiID(guiIDMax);
	}
*/
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
void SharedInputManager::touchesBegan(float x, float y)
{
	//Flip Parameters due to landscape mode
	float auxX = x;
	x = y;
	y = auxX;
	
	//We need to set the GUIState
	GUIState.x = x;
	GUIState.y = y;
	GUIState.fingerDown = true;
	
	std::cout << "Touches Began " << std::endl;
	std::cout << " X " << x << " Y " << y << std::endl;
	
	this->broadcastInteraction(x, y);
}

void SharedInputManager::touchesMoved(float x, float y)
{
	//Flip Parameters due to landscape mode
	float auxX = x;
	x = y;
	y = auxX;
	
	//We need to set the GUIState
	GUIState.x = x;
	GUIState.y = y;
	GUIState.fingerDown = true;
	
	std::cout << "Touches Moved " << std::endl;
	
	this->broadcastInteraction(x, y);
}

void SharedInputManager::touchesEnded(float x, float y)
{
	//Flip Parameters due to landscape mode
	float auxX = x;
	x = y;
	y = auxX;
	
	//We need to set the GUIState
	GUIState.x = x;
	GUIState.y = y;
	GUIState.fingerDown = false;
	
	std::cout << "Touches Ended " << std::endl;
	
	this->broadcastInteraction(x, y);
}

void SharedInputManager::broadcastInteraction(float x, float y)
{	
	gameEntityMap::iterator it;
	
	/*We tell every component the is subscribed that we have touched it.*/
	for (it = receiversMap.begin(); it != receiversMap.end(); it++)
	{
		if(((*it).second)->isActive)
		{	GEComponent *gec = ((*it).second)->getGEC(std::string("gecGUI"));
			gecGUI *gGUI	 = static_cast<gecGUI *> (gec);
			if( gGUI )
			{
				gGUI->immGUI(x, y, gGUI->getGuiID());
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
