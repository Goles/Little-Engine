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

/** Include Luabind in C++ */
#include "luabind.hpp"

#define LR_MANAGER LuaRegisterManager::getInstance()
#define LR_MANAGER_STATE LuaRegisterManager::getInstance()->getLuaState()

class lua_State;

class LuaRegisterManager 
{
public:
	/** Execute a Lua Script
	 @param script Will be a const char refering to a lua script. - "myscript.lua".
	 
	 @remarks
	 On failure we print out the error from the top of the Lua Stack.
	 That's what L - 1 means ( pop out the top of the stack ), and I know that in
	 case of error, the top of the stack will be a C string ( %s ).
	 */
	void execScript(const char *script);
	
	/** Call the static registrate(void) method of a Class that registers with Lua.
		@remarks
			We will have to manually call this post main() or in main().
	 */
	template <typename T>
	void registrate() {
		T::registrate();
	}
	
	/** Returns the Lua runtime */
	lua_State *getLuaState() { return L; };	
	
	/** Returns the singleton instance for the Lua register manager*/
	static LuaRegisterManager* getInstance();
	
protected:
	/** Init the LuaRegisterManager.
	 @remarks
	 Does start up the lua-runtime, and also binds the runtime to the luabind library.
	 */
	LuaRegisterManager();
	
	/** Destroys the LuaRegisterManager.
	 @remarks
	 It does close the Lua Runtime.
	 */
	~LuaRegisterManager();
	
private:	
	static LuaRegisterManager* instance;	
	lua_State* L;
};


#endif
