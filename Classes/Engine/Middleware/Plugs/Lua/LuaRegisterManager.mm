/*
 *  LuaLoader.cpp
 *  Cinder2
 *
 *  Created by Nicolas Goles on 6/18/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include <iostream>

#include "LuaRegisterManager.h"
#include "FileUtils.h"

LuaRegisterManager *LuaRegisterManager::instance = NULL;

LuaRegisterManager* LuaRegisterManager::getInstance()
{
	if(instance == NULL)
		instance = new LuaRegisterManager();

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
	if(luaL_dofile(L, [FileUtils fullCPathFromRelativePath:script]))
	{
		std::cout	<< "Lua Register Manager: ERROR when trying to execute script: " 
					<< script 
					<< std::endl
					<< "Error: "
					<< lua_tostring(L, -1)
					<< std::endl;
	}
}

/** Init the LuaRegisterManager.
 @remarks
	Does start up the lua-runtime, and also binds the runtime to the luabind library.
 */
LuaRegisterManager::LuaRegisterManager()
{
	L = lua_open();
	luabind::open(L);
}

/** Destroys the LuaRegisterManager.
 @remarks
	It does close the Lua Runtime.
 */
LuaRegisterManager::~LuaRegisterManager()
{
	lua_close(L);
}