//
//  SharedParticleSystemManager.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/5/09.
//  Copyright 2009 Gando-Games All rights reserved.
//

/* This class contains a Singleton instance of a Global Particle System manager
 * the idea is to make this class to manage all the game particle systems. (allocs, releases, etc)
 * the manager should give a reference to each particle system in order to deallocate them/deactivate them in the future.
 *
 * For some specific inline functions, one should look at "ParticleSystemManagerFunctions.h".
 *
 * _NG October 11 - 2009
 *
 *
 *  Remember the texture2D allocation:
 *
 *	particleTexture = [[Texture2D alloc] initWithImagePath:[[NSBundle mainBundle] pathForResource:@"smokes_w.png" ofType:nil]]; // For now this will be instanciated here, in the future must be a pointer to a texture stored somewhere.
 *	particleTexture = [[Texture2D alloc] initWithPVRTCFile:[FileUtils fullPathFromRelativePath:@"smoke.pvr"]];
 *	particleTexture = [[Texture2D alloc] initWithImagePath:[[NSBundle mainBundle] pathForResource:@"Particle2.png" ofType:nil] filter:GL_LINEAR];
 *
 *
 *	_NG October 29 - 2009
 */

//#import <Foundation/Foundation.h>
#ifndef _SHARED_PARTICLE_SYSTEM_MANAGER_H_
#define _SHARED_PARTICLE_SYSTEM_MANAGER_H_

#include "GameEntity.h"
#include <iostream>
#include <string>
#include <list>

class gecParticleSystem;

#define PARTICLE_MANAGER SharedParticleSystemManager::getInstance()

class SharedParticleSystemManager
{
public:	
	//Destructor and get instance
	static SharedParticleSystemManager* getInstance();
	~SharedParticleSystemManager();
	
	//Action Methods
	GameEntity*		createParticleSystem(int k_InParticleFX, CGPoint inPosition, const std::string &textureName);
	GameEntity*		insertSystem(GameEntity *inSystem); //Creates and inserts a new SystemEntity in the _systemsList
	void				removeSystem(GameEntity *inSystem);
	void				debugPrintList();
	
protected:
	SharedParticleSystemManager();	//Constructor
	
private:
	typedef std::list<GameEntity *> ParticleSystemList;
	static SharedParticleSystemManager *instance; //Singleton instance
	ParticleSystemList _systemsList;
};

#endif