/*
 *  LuaLoader.h
 *  Cinder2
 *
 *  Created by Nicolas Goles on 6/18/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#ifndef _LUA_REGISTER_MANAGER_H_
#define _LUA_REGISTER_MANAGER_H_

/** Include Luabind in C++ */

#define LR_MANAGER LuaManager::getInstance()
#define LR_MANAGER_STATE LuaManager::getInstance()->getLuaState()

class lua_State;

class LuaManager 
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

        /** Returns the Lua runtime */
        lua_State *getLuaState() { return L; };

        /** Returns the singleton instance for the Lua register manager*/
        static LuaManager* getInstance();

        /** Destroys the LuaManager.
          @remarks
          It does close the Lua Runtime.
          */
        ~LuaManager();


    protected:
        /** Init the LuaManager.
          @remarks
          Does start up the lua-runtime, and also binds the runtime to the luabind library.
          */
        LuaManager();

    private:
        static LuaManager* instance;
        lua_State* L;
        int m_state;
};


#endif
