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


namespace gg {
    namespace event {

        //TODO: replace const luabind::object parameters with something more generic?
        // <const char *key, const char *value> or simmilar? (with ... multi parameters)
        class IEventBroadcaster {
        public:
            virtual void broadcast(const char *eventType, const char *payloadTableName) = 0;
            virtual void broadcastTouch(float x, float y, int touchIndex, int touchID, int touchType) = 0;
            // virtual inline void notifyTargetEntity(const char *eventType, const luabind::object &payload, int entityID) = 0;
        };
    }
}

#endif
