//
//  SharedInputManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/3/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

/*
 * The idea of the Input manager is to have a C++ implementation to handle all the device interaction.
 * In the case of the iPhone, it acts as a very thin layer between touchesBegan:withEvent: and our C++ Engine
 * this class could of course be extended to work pretty well with other devices.
 *
 * _NG Thu 3 Dec 2009
 */
 
#ifndef _SHARED_INPUT_MANAGER_H
#define _SHARED_INPUT_MANAGER_H

#include <string>
#include <map>

#define INPUT_MANAGER SharedInputManager::getInstance()
#define MAX_TOUCHES 2

//Input enumeration for the touch types.
typedef enum
{
	kTouchType_began = 0,
	kTouchType_moved,
	kTouchType_ended
} kTouchType;

//The input manager will track the UIstate
typedef struct
{
	float	x;
	float	y;
	bool	fingerDown;	//True if the user has his finger down.
	bool	hitFirst;	//True if the user "hit" an interface element on touches begin.
	void*	touchID;	//Represents the pointer to the "Touch" event, which will be his ID.
} UIState;

class GameEntity;

class SharedInputManager
{
	//SharedInputManager Singleton Interface.
public:
	static SharedInputManager*	getInstance();	
	void						registerGameEntity(GameEntity *anEntity);
	void						removeGameEntity(int guiID);	
	GameEntity*					getGameEntity(int guiID);
	void						setTouchCount(int t) { touchCount = t; }
	int							getTouchCount() { return touchCount; }
	void						touchesBegan(float x, float y, void *touchID);
	void						touchesMoved(float x, float y, void *touchID);
	void						touchesEnded(float x, float y, void *touchID);
	int							generateID(){ return (++incrementalID); }
	
	UIState GUIState[MAX_TOUCHES]; //public for easier accesibility no thread safe though.
	
	~SharedInputManager();
		
protected:
	SharedInputManager();
	void						initGUIState();

	//private Atributes
private:
	typedef std::map<int, GameEntity *>	GameEntityMap;
	typedef std::pair<int, GameEntity *> GameEntityMapPair;

	static SharedInputManager*	singletonInstance;
	GameEntityMap				touchReceivers;
	int							incrementalID;
	int							touchCount;

	//private Methods
private:
	void broadcastInteraction(float x, float y, int touchIndex, void *touchID, int touchType);
		
	//Debug interface
public:
	void debugPrintMap();
	void debugPrintGUIState();
};

#endif