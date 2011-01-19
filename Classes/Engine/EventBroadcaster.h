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

#ifndef	_EVENT_BROADCASTER_H_
#define _EVENT_BROADCASTER_H_

#import "LuaRegisterManager.h"

namespace gg {
	namespace event {
		static inline void broadcast(const char *in_eventType, const luabind::object in_event_payload)
		{	
			luabind::call_function<void>(LR_MANAGER_STATE, "broadcast", in_eventType, in_event_payload);
		}
		
		static inline void broadcast_touch(float in_x, float in_y, int in_touchIndex, int in_touchId, int in_touchType)
		{			
			luabind::call_function<void>(LR_MANAGER_STATE, "broadcast_touch", in_x, in_y, in_touchIndex, in_touchId, in_touchType);	
		}
	}
}

#endif
