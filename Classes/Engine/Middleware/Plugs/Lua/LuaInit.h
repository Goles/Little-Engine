/*
 *  LuaInit.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 9/17/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */
#ifndef __LUA_BASE_TYPES_H__
#define __LUA_BASE_TYPES_H__

#include <vector>

#include "LuaRegisterManager.h"

#include "FileUtils.h"
#include "ConstantsAndMacros.h"

#include "GameEntity.h"
#include "Scene.h"
#include "Image.h"
#include "Frame.h"
#include "Animation.h"
#include "SpriteSheet.h"

#include "GEComponent.h"
#include "gecAnimatedSprite.h"
#include "gecFSM.h"

#include "SharedSceneManager.h"

namespace gg
{
	namespace lua 
	{
		static inline void enableSettings(void)
		{
			lua_gc(LR_MANAGER_STATE, LUA_GCSTOP, 0);
		}
		
        static inline void bindBasicFunctions(void)
        {
            luabind::module(LR_MANAGER_STATE) 
            [
             luabind::def("fileRelativePath", &FileUtils::relativeCPathForFile),
             luabind::def("filePath", &FileUtils::fullCPathFromRelativePath) 
			 ];
        }
        
		static inline void bindBasicTypes(void)
		{	
			luabind::module(LR_MANAGER_STATE)
			[
			 luabind::class_<std::vector<int> >("int_vector")
			 .def(luabind::constructor<>())
			 .def("push_back", &std::vector<int>::push_back)
			 ];
			
			luabind::module(LR_MANAGER_STATE)
			[
			 luabind::class_<std::vector<float> >("float_vector")
			 .def(luabind::constructor<>())
			 .def("push_back", &std::vector<float>::push_back)
			 ];
			
			luabind::module(LR_MANAGER_STATE)
			[
			 luabind::class_<GGPoint>("GGPoint")
			 .def(luabind::constructor<>())
			 .def_readwrite("x", &GGPoint::x)
			 .def_readwrite("y", &GGPoint::y)			 
			 ];
		}
		 
		static inline void bindClasses(void)
		{
			LR_MANAGER->registrate<Image>();
			LR_MANAGER->registrate<Frame>();
			LR_MANAGER->registrate<Animation>();
			LR_MANAGER->registrate<SpriteSheet>();
			LR_MANAGER->registrate<gecAnimatedSprite>();
			LR_MANAGER->registrate<gecFSM>();
			LR_MANAGER->registrate<GameEntity>();
			LR_MANAGER->registrate<Scene>();
		}
		
		static inline void bindManagers(void)
		{
			LR_MANAGER->registrate<SharedSceneManager>();
		}

		static inline void bindAll(void)
		{			
			bindBasicTypes();
            bindBasicFunctions();
			bindClasses();
			bindManagers();
		}
	}
}
#endif