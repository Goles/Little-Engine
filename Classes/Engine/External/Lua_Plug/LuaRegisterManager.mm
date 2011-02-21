/*
 *  LuaLoader.cpp
 *  Cinder2
 *
 *  Created by Nicolas Goles on 6/18/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include <iostream>

#include "lua.hpp"

#include "LuaRegisterManager.h"
#include "FileUtils.h"
#include "LuaInit.h"

LuaRegisterManager *LuaRegisterManager::instance = NULL;

LuaRegisterManager* LuaRegisterManager::getInstance()
{
	if(instance == NULL)
	{
		instance = new LuaRegisterManager();
		gg::lua::enableSettings();
		gg::lua::bindAll();
	}

	return instance;
}

/** Execute a Lua Script
 @param script Will be a const char refering to a lua script. - "myscript.lua".
 
 @remarks
	On failure we print out the error from the top of the Lua Stack.
	That's what L - 1 means ( pop out the top of the stack ), and I know that in
	case of error, the top of the stack will be a C string ( %s ).
 */

void LuaRegisterManager::execScript(const char *script)
{
	if(luaL_dofile(L, FileUtils::fullCPathFromRelativePath(script)))
	{
		std::cout	<< "Lua Register Manager: ERROR when trying to execute script: " 
					<< script 
					<< std::endl
					<< "Error: "
                    << lua_tostring(L, -1)
					<< std::endl;
	}
}

LuaRegisterManager::LuaRegisterManager()
{
	//Init Lua, open the default libs and register state with Luabind.
	L = luaL_newstate();
	luaL_openlibs(L);
	luabind::open(L);
	
	//Register with luabind.
	luabind::module(L) 
	[
	 luabind::class_<LuaRegisterManager>("LuaRegisterManager")
	 .def("execScript", &LuaRegisterManager::execScript)
	 .scope
	 [
	  luabind::def("getInstance", &LuaRegisterManager::getInstance) //returns static singleton instance
      ]
	 ];
}

LuaRegisterManager::~LuaRegisterManager()
{
	lua_close(L);
}