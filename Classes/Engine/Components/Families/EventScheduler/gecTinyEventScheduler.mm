//
//  gecTinyEventScheduler.mm
//  GandoEngine
//
//  Created by Nicolas Goles on 8/8/11 at 9:23 PM
//  Copyright 2011 Nicolas Goles. All rights reserved.
//

#include "gecTinyEventScheduler.h"

//Static Init
const GEComponent::gec_id_type gecTinyEventScheduler::m_id = "gecTinyEventScheduler";

void gecTinyEventScheduler::update(float delta) 
{
    m_scheduler->updateEvents(delta);
}

unsigned gecTinyEventScheduler::scheduleEvent(gg::event::ScheduledEvent *event)
{
    return m_scheduler->scheduleEvent(event);
}

void gecTinyEventScheduler::unscheduleEvent(unsigned eventHandle)
{
    m_scheduler->unscheduleEvent(eventHandle);
}

void gecTinyEventScheduler::pauseScheduledEvent(unsigned eventHandle)
{
    m_scheduler->pauseScheduledEvent(eventHandle);
}

void gecTinyEventScheduler::resetScheduledEvent(unsigned eventHandle)
{
    m_scheduler->resetScheduledEvent(eventHandle);
}
