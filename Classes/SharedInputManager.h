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

class GameEntity;

class SharedInputManager
{
//SharedInputManager Singleton Interface.
public:
	static SharedInputManager* getInstance();
	
	void addGameEntity(std::string, GameEntity *anEntity);
	void removeGameEntity(std::string);
	
	void touchesBegan(float x, float y);
	void touchesMoved(float x, float y);
	void touchesEnded(float x, float y);
		
	~SharedInputManager();

protected:
	SharedInputManager(){}
private:
	typedef std::map<std::string, GameEntity *> gameEntityMap;
	typedef std::pair<std::string, GameEntity *> gameEntityMapPair;
	
	gameEntityMap receiversMap;
	boost::mutex io_mutex;
	static SharedInputManager *singletonInstance;
};