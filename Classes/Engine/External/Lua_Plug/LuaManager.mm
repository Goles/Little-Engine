/*
 *  LuaLoader.cpp
 *  Cinder2
 *
 *  Created by Nicolas Goles on 6/18/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include "LuaManager.h"
#include <iostream>


extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
}

#include "FileUtils.h"
#include "LuaInit.h"

LuaManager *LuaManager::instance = NULL;

LuaManager* LuaManager::getInstance()
{
	if (instance == NULL) {
		instance = new LuaManager();
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

void LuaManager::execScript(const char *script)
{
    const char *scriptFullPath = gg::util::fullCPathFromRelativePath(script); 
    
	if (luaL_dofile(L, scriptFullPath)) {
		std::cout	<< "Lua Register Manager: ERROR when trying to execute script: " 
					<< scriptFullPath 
					<< std::endl
					<< "Error: "
                    << lua_tostring(L, -1)
					<< std::endl;
	}
}

LuaManager::LuaManager()
{
	//Init Lua, open the default libs and register state with Luabind.
    
	L = lua_open();
	luaL_openlibs(L);
	luabind::open(L);
	
	//Register with luabind.
	luabind::module(L) 
	[
	 luabind::class_<LuaManager>("LuaManager")
	 .def("execScript", &LuaManager::execScript)
	 .scope
	 [
	  luabind::def("getInstance", &LuaManager::getInstance) //returns static singleton instance
      ]
	 ];
}

LuaManager::~LuaManager()
{
	lua_close(L);
}