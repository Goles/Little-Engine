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

#include <boost/thread/mutex.hpp>
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
	GameEntity*					getGameEntity(int guiID);
	void						setTouchCount(int t) { touchCount = t; }
	int							getTouchCount() { return touchCount; }
	void						removeGameEntity(int guiID);
	void						touchesBegan(float x, float y, void *touchID);
	void						touchesMoved(float x, float y, void *touchID);
	void						touchesEnded(float x, float y, void *touchID);
	int							giveID(){ return (++guiIDMax); }
	
	UIState GUIState[MAX_TOUCHES]; //public for easier accesibility
	
	~SharedInputManager();
		
protected:
	SharedInputManager();

	//private Atributes
private:
	typedef std::map<int, GameEntity *>	gameEntityMap;
	typedef std::pair<int, GameEntity *> gameEntityMapPair;
	
	gameEntityMap				receiversMap;
	boost::mutex				io_mutex;
	static SharedInputManager*	singletonInstance;
	int							guiIDMax;
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