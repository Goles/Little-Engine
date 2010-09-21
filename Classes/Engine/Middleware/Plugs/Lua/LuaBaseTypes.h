/*
 *  LuaBaseTypes.h
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

namespace gg
{
	namespace lua 
	{
		static inline void bindBasicTypes(void)
		{
			luabind::module(LR_MANAGER_STATE)
			[
			 luabind::class_<std::vector<int> >("int_vector")
			 .def(luabind::constructor<>())
			 .def("push_back", &std::vector<int>::push_back)
			 ];
		}
	}
}
#endif