/*
 *  TouchableManager.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 12/21/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

/*
 * The idea of the Touchable manager is to have a C++ implementation to handle all kind of user touches.
 * In the case of the iPhone, it acts as a very thin layer between touchesBegan:withEvent: and our C++ Engine
 * this class could of course be extended to work pretty well with other devices.
 *
 * _NG Tue 21 Dec 2010
 */

#ifndef __TOUCHABLE_MANAGER_H__
#define __TOUCHABLE_MANAGER_H__

#include <string>
#include <map>

#define TOUCHABLE_MANAGER TouchableManager::getInstance()
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
} GTouch;

class gecGUI;

class TouchableManager
{
	//SharedInputManager Singleton Interface.
public:
	static TouchableManager*	getInstance();	
	void						registerTouchable(gecGUI *gui_component);
	void						removeTouchable(int guiID);	
	gecGUI*						getTouchable(int guiID);
	void						setTouchCount(int t) { touchCount = t; }
	int							getTouchCount() { return touchCount; }
	void						touchesBegan(float x, float y, void *touchID);
	void						touchesMoved(float x, float y, void *touchID);
	void						touchesEnded(float x, float y, void *touchID);
	int							generateID(){ return (++incrementalID); }
	
	GTouch GUIState[MAX_TOUCHES]; //public for easier accesibility no thread safe though.
	
	~TouchableManager();
	
protected:
	TouchableManager();
	void						initGUIState();
	
	//private Atributes
private:
	typedef std::map<int, gecGUI *>	TouchableMap;
	typedef std::pair<int, gecGUI *> TouchableMapPair;
	
	static TouchableManager*	singletonInstance;
	TouchableMap				touchReceivers;
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