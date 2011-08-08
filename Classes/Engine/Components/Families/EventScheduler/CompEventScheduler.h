//
//  gecEventScheduler.h
//  GandoEngine
//
//  Created by Nicolas Goles on 8/8/11 at 9:00 PM
//  Copyright 2011 Nicolas Goles. All rights reserved.
//

#ifndef __gecEventScheduler_H__
#define __gecEventScheduler_H__

#include "GEComponent.h"
#include "ScheduledEvent.h"

class CompEventScheduler : public GEComponent
{
public:
    virtual ~CompEventScheduler() {}
    virtual const gec_id_type& familyID() const { return m_familyID; }
    virtual unsigned scheduleEvent(gg::event::ScheduledEvent *) = 0;
    virtual void unscheduleEvent(unsigned eventHandle) = 0;
    virtual void pauseScheduledEvent(unsigned eventHandle) = 0;
    virtual void resetScheduledEvent(unsigned eventHandle) = 0;

private:
    static const gec_id_type m_familyID;
};

const GEComponent::gec_id_type CompEventScheduler::m_familyID = "CompEventScheduler";

#endif