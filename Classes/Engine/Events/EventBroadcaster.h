/*
 *  EventBroadcaster.h
 *  GandoEngine
 *
 *  Created by Nicolas Goles on 12/13/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 *	The in_event_payload should be a Lua table, it's normally specified like:
 *		
 *	luabind::object payload = luabind::newtable(LR_MANAGER_STATE);
 *	payload["foo"] = "bar";
 *
 */

#ifndef	__EVENT_BROADCASTER_H__
#define __EVENT_BROADCASTER_H__

#import "LuaManager.h"

namespace gg {
	namespace event {
		static inline void broadcast(const char *in_eventType, const luabind::object &in_event_payload)
		{	
			luabind::call_function<void>(LR_MANAGER_STATE, "broadcast", in_eventType, in_event_payload);
		}
		
		static inline void broadcast_touch(float in_x, float in_y, int in_touchIndex, int in_touchId, int in_touchType)
		{			
			luabind::call_function<void>(LR_MANAGER_STATE, "broadcast_touch", in_x, in_y, in_touchIndex, in_touchId, in_touchType);	
		}
		
		static inline void notify_target_entity(const char *in_eventType, const luabind::object &in_event_payload, const int in_uid)
		{
			luabind::call_function<void>(LR_MANAGER_STATE, "notify_target_entity", in_eventType, in_event_payload, in_uid);
		}
	}
}

#endif
