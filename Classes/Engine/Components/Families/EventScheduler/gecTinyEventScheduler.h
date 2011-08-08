//
//  gecTinyEventScheduler.h
//  GandoEngine
//
//  Created by Nicolas Goles on 8/8/11 at 9:23 PM
//  Copyright 2011 Nicolas Goles. All rights reserved.
//

#ifndef __gecTinyEventScheduler_H__
#define __gecTinyEventScheduler_H__

#include "CompEventScheduler.h"
#include "EventScheduler.h"

class ScheduledEvent;

class gecTinyEventScheduler : public CompEventScheduler
{
public:
    gecTinyEventScheduler(gg::event::EventScheduler *s) 
        : m_scheduler(s)
    {}
    
    virtual ~gecTinyEventScheduler() {}
    virtual void update(float delta);
    virtual const gec_id_type &componentID() const { return m_id; }
    virtual unsigned scheduleEvent(gg::event::ScheduledEvent *);
    virtual void unscheduleEvent(unsigned eventHandle);
    virtual void pauseScheduledEvent(unsigned eventHandle);
    virtual void resetScheduledEvent(unsigned eventHandle);

private:
    gecTinyEventScheduler() {};
    static const gec_id_type m_id;
    gg::event::EventScheduler *m_scheduler;
};

#endif