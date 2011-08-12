//
//  EventScheduler.h
//  GandoEngine
//
//  Created by Nicolas Goles on 8/4/11 at 4:55 PM
//  Copyright 2011 Nicolas Goles. All rights reserved.
//

#ifndef __EventScheduler_H__
#define __EventScheduler_H__

#include "ScheduledEvent.h"
#include <vector>

namespace gg { namespace event {
    
class IEventBroadcaster;
    
class EventScheduler 
{
public:
    EventScheduler(gg::event::IEventBroadcaster *broadcaster)
        : m_incrementalEventHandle(1)
        , m_broadcaster(broadcaster)
    {
        m_scheduledEvents.reserve(10);
    }
    
    ~EventScheduler();
    void updateEvents(double delta);    
    void unscheduleEvent(unsigned eventHandle);
    void pauseScheduledEvent(unsigned eventHandle);
    void resetScheduledEvent(unsigned eventHandle);
    inline unsigned scheduleEvent(ScheduledEvent *event)
    {
        event->handle = m_incrementalEventHandle++;
        m_scheduledEvents.push_back(event);        
        return event->handle;
    }
    
    inline unsigned scheduledEventsNumber() 
    {
        return (unsigned)m_scheduledEvents.size();
    }

private:
    void broadcastEvent(gg::event::ScheduledEvent *);
    unsigned m_incrementalEventHandle;
    typedef std::vector<gg::event::ScheduledEvent * > ScheduledEventVector;
    ScheduledEventVector m_scheduledEvents;
    gg::event::IEventBroadcaster *m_broadcaster;
};

}}
    
#endif