//
//  EventBroadcaster.h
//  GandoEngine
//
//  Created by Nicolas Goles on 8/26/12.
//
//

#ifndef GandoEngine_EventBroadcaster_h
#define GandoEngine_EventBroadcaster_h

#include "IEventBroadcaster.h"

namespace gg {
    namespace event {
        
        class EventBroadcaster: public IEventBroadcaster
        {
        public:
            // virtual inline void notifyTargetEntity(const char *eventType, const luabind::object &payload, int entityID) = 0;
            virtual void broadcast(const char *eventType, const char *payloadTableName);
            virtual void broadcastTouch(float x, float y, int touchIndex, int touchID, int touchType);
        };
        
    }
}

#endif