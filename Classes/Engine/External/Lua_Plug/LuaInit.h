/*
 *  LuaInit.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 9/17/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */
#ifndef __LUA_BASE_TYPES_H__
#define __LUA_BASE_TYPES_H__

#include <vector>

#include "LuaRegisterManager.h"

#include "FileUtils.h"
#include "ConstantsAndMacros.h"
#include "OpenGLCommon.h"

#include "GameEntity.h"
#include "Scene.h"
#include "Image.h"
#include "Frame.h"
#include "Animation.h"
#include "SpriteSheet.h"

#include "IFont.h"

#include "GEComponent.h"
#include "gecAnimatedSprite.h"
#include "gecFollowingCamera.h"
#include "gecFSM.h"
#include "gecJoystick.h"
#include "gecButton.h"
#include "gecBoxCollisionable.h"

#include "SceneManager.h"
#include "FontManager.h"

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
				luabind::def("filePath", &FileUtils::fullCPathFromRelativePath),
				luabind::def("ggr", &CGRectMake),
				luabind::def("ggs", &CGSizeMake),
				luabind::def("gluLookAt", &gluLookAt)
			 ];
        }
        
		static inline void bindBasicTypes(void)
		{	
			luabind::module(LR_MANAGER_STATE)
			[
			 luabind::class_<std::string>("string")
			 .def("c_str", &std::string::c_str)
			 ];
			
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
			
			luabind::module(LR_MANAGER_STATE)
			[
				luabind::class_<GGSize>("GGSize")
				.def_readwrite("width", &GGSize::width)
				.def_readwrite("height", &GGSize::height)
			];
			
			luabind::module(LR_MANAGER_STATE)
			[
				luabind::class_<CGRect>("GGRect")
				.def(luabind::constructor<>())
				.def_readwrite("origin", &GGRect::origin)
				.def_readwrite("size", &GGRect::size)
			];
			
			luabind::module(LR_MANAGER_STATE)
			[
				 luabind::class_<Vector3D>("Vector3D")
				 .def(luabind::constructor<>())
				 .def_readwrite("x",&Vector3D::x)
				 .def_readwrite("y",&Vector3D::y)
				 .def_readwrite("z",&Vector3D::z)
			 ];
		}
		 
		static inline void bindAbstractInterfaces(void)
		{
			luabind::module(LR_MANAGER_STATE)
			[
				 luabind::class_<IFont>("IFont")
				 .def("open", &IFont::open)
				 .def("setText", &IFont::setText)
			 ];
		}
		
		static inline void bindClasses(void)
		{
			LR_MANAGER->registrate<Image>();
			LR_MANAGER->registrate<Frame>();
			LR_MANAGER->registrate<Animation>();
			LR_MANAGER->registrate<SpriteSheet>();
			LR_MANAGER->registrate<gecAnimatedSprite>();
			LR_MANAGER->registrate<gecFollowingCamera>();
			LR_MANAGER->registrate<gecFSM>();
			LR_MANAGER->registrate<gecJoystick>();
			LR_MANAGER->registrate<gecButton>();
			LR_MANAGER->registrate<gecBoxCollisionable>();
			LR_MANAGER->registrate<GameEntity>();
			LR_MANAGER->registrate<Scene>();
		}
		
		static inline void bindManagers(void)
		{
			LR_MANAGER->registrate<SceneManager>();
			LR_MANAGER->registrate<FontManager>();
		}

		static inline void bindAll(void)
		{			
			bindBasicTypes();
            bindBasicFunctions();
			bindAbstractInterfaces();
			bindClasses();
			bindManagers();
		}
	}
}
#endif