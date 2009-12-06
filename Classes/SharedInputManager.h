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
 


#include <boost/thread/mutex.hpp>
#include <string>
#include <map>

#define INPUT_MANAGER SharedInputManager::getInstance()

//The input manager will track the UIstate
typedef struct
{
	float x;
	float y;
	Boolean fingerDown;
	int hotItem;	
} UIState;

class GameEntity;

class SharedInputManager
{
	//SharedInputManager Singleton Interface.
public:
	static SharedInputManager*	getInstance();	
	void						registerGameEntity(GameEntity *anEntity);
	GameEntity*					getGameEntity(int guiID);
	void						removeGameEntity(int guiID);
	void						touchesBegan(float x, float y);
	void						touchesMoved(float x, float y);
	void						touchesEnded(float x, float y);
	int							giveID(){ return (++guiIDMax); }
	
	UIState GUIState; //public for easier accesibility
	
	~SharedInputManager();
		
protected:
	SharedInputManager();

	//private Atributes
private:
	typedef std::map<int, GameEntity *>		gameEntityMap;
	typedef std::pair<int, GameEntity *>	gameEntityMapPair;
	
	gameEntityMap				receiversMap;
	boost::mutex				io_mutex;
	static SharedInputManager*	singletonInstance;
	int							guiIDMax;

	//private Methods
private:
	void broadcastInteraction(float x, float y);
		
	//Debug interface
public:
	void debugPrintMap();
};