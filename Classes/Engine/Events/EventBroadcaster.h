/*
 *  EventBroadcaster.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 12/13/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 *  The in_event_payload should be a Lua table, it's normally specified like:
 *
 *  luabind::object payload = luabind::newtable(LR_MANAGER_STATE);
 *  payload["foo"] = "bar";
 *
 */

#ifndef __EVENT_BROADCASTER_H__
#define __EVENT_BROADCASTER_H__

#import "LuaManager.h"
#import "nanoluadict.h"

namespace gg {
    namespace event {

        //TODO: replace const luabind::object parameters with something more generic?
        // <const char *key, const char *value> or simmilar? (with ... multi parameters)
        struct IEventBroadcaster {
            public:

                virtual inline void broadcast(const char *eventType, const char *payloadTableName) = 0;
                virtual inline void broadcastTouch(float x, float y, int touchIndex, int touchID, int touchType) = 0;
                // virtual inline void notifyTargetEntity(const char *eventType, const luabind::object &payload, int entityID) = 0;
        };

        struct LuabindBroadcaster : public IEventBroadcaster
        {
            virtual inline void broadcast(const char *eventType, const char *payloadTableName)
            {
//                lua_getglobal(LR_MANAGER_STATE, "broadcast");
//                assert(lua_isfunction(LR_MANAGER_STATE, -1));
//
//                lua_pushstring(LR_MANAGER_STATE, eventType);
//                lua_getglobal(LR_MANAGER_STATE, payloadTableName);
//                assert(lua_istable(LR_MANAGER_STATE, -1));
//
//                lua_pcall(LR_MANAGER_STATE, 2, 0, 0); 
            }

            virtual inline void broadcastTouch(float x, float y, int touchIndex, int touchID, int touchType)
            {
                //luabind::call_function<void>(LR_MANAGER_STATE, "broadcast_touch", x, y, touchIndex, touchID, touchType);
            }

            // virtual inline void notifyTargetEntity(const char *eventType, const luabind::object &payload, int entityID)
            // {
                // luabind::call_function<void>(LR_MANAGER_STATE, "notify_target_entity", eventType, payload, entityID);
            // }
        };

        //Pseudo-Abstract Factory function for a "singleton" (not really singleton) Luabind Broadcaster.
        static IEventBroadcaster *LUABIND_BROADCASTER = NULL;

        static inline IEventBroadcaster* luabindBroadcaster()
        {
            if (!LUABIND_BROADCASTER) {
                LUABIND_BROADCASTER = new LuabindBroadcaster();
            }

            return LUABIND_BROADCASTER;
        }

    }
}

#endif
