/*
 *  ggEngine.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 9/6/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef __GG_ENGINE_H__
#define __GG_ENGINE_H__

#include "LuaManager.h"
#include "TouchableManager.h"
#include "SceneManager.h"
#include "SharedTextureManager.h"
#include "ParticleManager.h"
#include "GandoBox2D.h"
#include "SimpleAudioEngine.h"

#include "LuaInit.h"

/** Good Game Engine Namespace
	@remarks
		gg:: namespace represents everything living inside the Good Game 2D 
		game engine.
 */
namespace gg 
{	
	/** Initialize the Good Game Engine (ggEngine)
	 @remarks
	 Basically startup all the required singletons ( shared managers ). 
	 */
	inline void init(void)
	{		 
		TOUCHABLE_MANAGER;	/** < Initialize the Input Manager*/
		SCENE_MANAGER;		/** < Initialize the Scene Manager */
		TEXTURE_MANAGER;	/** < Initialize the Texture Manager*/
		PARTICLE_MANAGER;	/** < Initialize the Particles Manager*/
		GBOX_2D;			/** < Initialize the Box2D Plug for GG*/
        CocosDenshion::SimpleAudioEngine::sharedEngine(); /** < Initialize the Audio Engine */
        LR_MANAGER;			/** < Initialize the Lua Registrate Manager */        
	}
	
	inline void startup(void)
	{        
		gg::init();
		
#ifdef DEBUG
		GBOX_2D->initDebugDraw();
#endif
		
		LR_MANAGER->execScript("init.lua");
	}
	
	inline void shutDown(void)
	{
		delete LR_MANAGER;			/** < delete the Lua Registrate Manager */
		delete TOUCHABLE_MANAGER;	/** < delete the Input Manager */
		delete SCENE_MANAGER;		/** < delete the Scene Manager */
		delete TEXTURE_MANAGER;		/** < delete the Texture Manager */
		delete PARTICLE_MANAGER;	/** < delete the Particles Manager */
		delete GBOX_2D;				/** < delete the Box2D Plug for GG */
        CocosDenshion::SimpleAudioEngine::sharedEngine()->end();
	}
}

#endif