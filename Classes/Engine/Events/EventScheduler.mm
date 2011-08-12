//
//  EventScheduler.mm
//  GandoEngine
//
//  Created by Nicolas Goles on 8/4/11 at 4:55 PM
//  Copyright 2011 Nicolas Goles. All rights reserved.
//

#include "EventScheduler.h"
#include "EventBroadcaster.h"

namespace gg { namespace event {

EventScheduler::~EventScheduler()
{
    ScheduledEventVector::iterator event = m_scheduledEvents.begin();        
    for (; event != m_scheduledEvents.end(); ++event) {
        delete *event;
    }
}

void EventScheduler::updateEvents(double delta)
{
    ScheduledEventVector::iterator event = m_scheduledEvents.begin();
    for (; event != m_scheduledEvents.end(); ) {  
        if (!(*event)->isPaused)
            (*event)->elapsedTime += delta;
        
            if ((*event)->elapsedTime >= (*event)->triggerTime) {
                this->broadcastEvent(*event);
                if (!(*event)->isRepeating) {
                    delete *event;
                    *event = NULL;
                    event = m_scheduledEvents.erase(event); //Erase already increments the iterator
                }
            } else
                ++event;
    }
}
    
void EventScheduler::unscheduleEvent(unsigned eventHandle)
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
    
void EventScheduler::pauseScheduledEvent(unsigned eventHandle)
{
    for (int i = 0; i < m_scheduledEvents.size(); ++i) {
        if (m_scheduledEvents[i]->handle == eventHandle) {
            m_scheduledEvents[i]->isPaused = true;
            break;
        }
    }
}
    
void EventScheduler::resetScheduledEvent(unsigned eventHandle)
{
    for (int i = 0; i < m_scheduledEvents.size(); ++i) {
        if (m_scheduledEvents[i]->handle == eventHandle) {
            m_scheduledEvents[i]->elapsedTime = 0.0;
            break;
        }
    }        
}

void EventScheduler::broadcastEvent(gg::event::ScheduledEvent *scheduledEvent)
{
    //For now Event Scheduler doesn't support payload.
    luabind::object eventPayload = luabind::newtable(LR_MANAGER_STATE);
    m_broadcaster->broadcast(scheduledEvent->type.c_str(), eventPayload);
}

}} //end gg::event