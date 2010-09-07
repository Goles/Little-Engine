/*
 *  LuaLoader.cpp
 *  Cinder2
 *
 *  Created by Nicolas Goles on 6/18/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "LuaRegisterManager.h"
#include "luabind.hpp"

LuaRegisterManager *LuaRegisterManager::instance = NULL;

LuaRegisterManager* LuaRegisterManager::getInstance()
{
	if(instance == NULL)
		instance = new LuaRegisterManager();

	return instance;
}

void LuaRegisterManager::execScript(char *script)
{
	//assert(!luaL_dofile(L, ci::app::getResourcePath(script).c_str()));
}

LuaRegisterManager::LuaRegisterManager()
{
	L = lua_open();
	luabind::open(L);
}

LuaRegisterManager::~LuaRegisterManager()
{
	lua_close(L);
}