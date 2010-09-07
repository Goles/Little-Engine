/*
 *  LuaLoader.h
 *  Cinder2
 *
 *  Created by Nicolas Goles on 6/18/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _LUA_REGISTER_MANAGER_H_
#define _LUA_REGISTER_MANAGER_H_

/** Include Lua in C++
 @remarks
	This is to avoid linker errors.
 */
extern "C" {
	#include "lua.h"
	#include "lauxlib.h"
}

#define LR_MANAGER LuaRegisterManager::getInstance()
#define LR_MANAGER_STATE LuaRegisterManager::getInstance()->getLuaState()

class LuaRegisterManager 
{
public:
	void execScript(char *script);
	lua_State *getLuaState() { return L; };	
	static LuaRegisterManager* getInstance();
	
protected:
	LuaRegisterManager();
	~LuaRegisterManager();
	
private:	
	static LuaRegisterManager* instance;	
	lua_State* L;
};

#endif
