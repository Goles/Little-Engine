/*
 *  ggEngine.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 9/6/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef __GG_ENGINE_H__
#define __GG_ENGINE_H__

#include "GETemplateManager.h"
#include "SharedInputManager.h"
#include "SharedParticleSystemManager.h"
#include "SharedTextureManager.h"
#include "GandoBox2D.h"
#include "LuaRegisterManager.h"
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
		LR_MANAGER;			/** < Initialize the Lua Registrate Manager */
		INPUT_MANAGER;		/** < Initialize the Input Manager*/
		SCENE_MANAGER;		/** < Initialize the Scene Manager */
		TEXTURE_MANAGER;	/** < Initialize the Texture Manager*/
		PARTICLE_MANAGER;	/** < Initialize the Particles Manager*/
		GBOX_2D;			/** < Initialize the Box2D Plug for GG*/
		GE_FACTORY;			/** < Initialize the Game Entity Factory */
	}
	
	inline void startup(void)
	{
		LR_MANAGER->execScript("init.lua");
	}
}

#endif