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
    
class EventScheduler 
{
public:
    
    EventScheduler()
        : m_incrementalEventHandle(1)
    {
        m_scheduledEvents.reserve(10);
    }
    
    ~EventScheduler() 
    {
        ScheduledEventVector::iterator event = m_scheduledEvents.begin();        
        for (; event != m_scheduledEvents.end(); ++event) {
                delete *event;
        }
    }
    
    inline unsigned scheduleEvent(ScheduledEvent *event) 
    {
        event->handle = m_incrementalEventHandle++;
        m_scheduledEvents.push_back(event);        
        return event->handle;
    }
    
    void updateEvents(double delta) 
    {
        ScheduledEventVector::iterator event = m_scheduledEvents.begin();
        for (; event != m_scheduledEvents.end();) {  
            if (!(*event)->isPaused)
                (*event)->elapsedTime += delta;
            
            if ((*event)->elapsedTime >= (*event)->triggerTime) {
                delete *event;
                *event = NULL;
                event = m_scheduledEvents.erase(event); //Erase already increments the iterator
            } else
                ++event;
        }
    }
    
    void unscheduleEvent(unsigned eventHandle) 
    {    
        //lineary search the vector for the item, remove and break;
        for (int i = 0; i < m_scheduledEvents.size(); ++i) {            
            if (m_scheduledEvents[i]->handle == eventHandle) {
                std::swap(m_scheduledEvents[i], m_scheduledEvents.back());
                m_scheduledEvents.pop_back();
                break;
            }            
        }
    }
    
    void pauseScheduledEvent(unsigned eventHandle) 
    {
        for (int i = 0; i < m_scheduledEvents.size(); ++i) {
            if (m_scheduledEvents[i]->handle == eventHandle) {
                m_scheduledEvents[i]->isPaused = true;
                break;
            }
        }
    }
    
    void resetScheduledEvent(unsigned eventHandle) 
    {
        for (int i = 0; i < m_scheduledEvents.size(); ++i) {
            if (m_scheduledEvents[i]->handle == eventHandle) {
                m_scheduledEvents[i]->elapsedTime = 0.0;
                break;
            }
        }        
    }
    
    inline unsigned scheduledEventsNumber() 
    {
        return (unsigned)m_scheduledEvents.size();
    }
    
private:
    unsigned m_incrementalEventHandle;
    typedef std::vector<gg::event::ScheduledEvent * > ScheduledEventVector;
    ScheduledEventVector m_scheduledEvents;
};

}}
    
#endif