//
//  ScheduledEvent.h
//  GandoEngine
//
//  Created by Nicolas Goles on 8/4/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifndef GandoEngine_ScheduledEvent_h
#define GandoEngine_ScheduledEvent_h

#include <string>

namespace gg { namespace event {

    struct ScheduledEvent {
        
        ScheduledEvent()
            : triggerTime(0.0)
            , elapsedTime(0.0)
            , handle(0)
            , isPaused(false)
            , isRepeating(false)
        {}
        
        std::string type;
        double triggerTime;
        double elapsedTime;
        unsigned handle;
        bool isPaused;
        bool isRepeating;
    };
    
    
    static inline ScheduledEvent *createScheduledEvent(const std::string &eventType, double triggerTime, bool isRepeating = false) 
    {
        ScheduledEvent *event = new ScheduledEvent();
        event->triggerTime = triggerTime;
        event->isRepeating = isRepeating;
        event->type = eventType;
        return event;
    }
    
}} //END: gg::event
#endif
