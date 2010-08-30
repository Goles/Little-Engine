/*
 *  GLuaInterface.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 8/29/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef __G_LUA_INTERFACE__
#define __G_LUA_INTERFACE__

class LuaBindeable
{
	virtual void luabind() = 0;
	static void registerLua() { luabind(); }
};

#endif