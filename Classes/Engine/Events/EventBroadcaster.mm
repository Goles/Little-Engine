//
//  EventBroadcaster.mm
//  GandoEngine
//
//  Created by Nicolas Goles on 8/26/12.
//
//

#include "EventBroadcaster.h"
#include "LuaManager.h"

extern "C" {
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"
}

namespace gg {
    namespace event {
        
        void EventBroadcaster::broadcast(const char *eventType, const char *payloadTableName)
        {
            lua_State *L = LR_MANAGER_STATE;
            lua_getglobal(L, "broadcast");
            assert(lua_iscfunction(L, -1));
            lua_pushstring(L, eventType);
            lua_getglobal(L, payloadTableName);
            assert(lua_istable(L, -1));
            lua_pcall(L, 2, 0, 0);
        }
        
        void EventBroadcaster::broadcastTouch(float x, float y, int touchIndex, int touchID, int touchType)
        {
//            lua_State *L = LR_MANAGER_STATE;
//            lua_getglobal(L, "broadcast_touch");
//            assert(lua_iscfunction(L, -1));
//            lua_pushnumber(L, x);
//            lua_pushnumber(L, y);
//            lua_pushnumber(L, touchIndex);
//            lua_pushnumber(L, touchID);
//            lua_pushnumber(L, touchType);
//            lua_pcall(L, 5, 0, 0);
        }
//        void EventBroadcaster::broadcast(const char *eventType, const char *payloadTableName)
//        {
//            lua_getglobal(LR_MANAGER_STATE, "broadcast");
//            lua_getglobal(LR_MANAGER_STATE, "broadcast");
//            assert(lua_isfunction(LR_MANAGER_STATE, -1));
//
//            lua_pushstring(LR_MANAGER_STATE, eventType);
//            lua_getglobal(LR_MANAGER_STATE, payloadTableName);
//            assert(lua_istable(LR_MANAGER_STATE, -1));
//
//            lua_pcall(LR_MANAGER_STATE, 2, 0, 0); 
//        }
//
//        void EventBroadcaster::broadcastTouch(float x, float y, int touchIndex, int touchID, int touchType)
//        {
//            //luabind::call_function<void>(LR_MANAGER_STATE, "broadcast_touch", x, y, touchIndex, touchID, touchType);
//        }
//
////        void EventBroadcaster::notifyTargetEntity(const char *eventType, const luabind::object &payload, int entityID)
////        {
////            luabind::call_function<void>(LR_MANAGER_STATE, "notify_target_entity", eventType, payload, entityID);
////        }
//        
//        IEventBroadcaster* EventBroadcaster::eventBroadcaster()
//        {
//            return NULL;
//        }
//

    }
}

