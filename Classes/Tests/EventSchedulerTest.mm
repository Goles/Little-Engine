//
//  File.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 8/5/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifdef UNIT_TEST

#include "unittestpp.h"
#include "ScheduledEvent.h"
#include "EventScheduler.h"
#include "EventBroadcaster.h"

struct EventBroadcasterMock : public gg::event::IEventBroadcaster 
{
    
    IEventBroadcaster *eventBroadcaster()
    {
        static IEventBroadcaster *instance = NULL;
        if (instance == NULL) {
            instance = new EventBroadcasterMock();
        }
        return instance;
    }
    
    virtual inline void broadcast(const char *eventType, const char *payloadTableName)
    {
        // Do stuff
    }
    
    virtual inline void broadcastTouch(float x, float y, int touchIndex, int touchID, int touchType)
    {
        // Do more stuff
    }
    
//    virtual inline void notifyTargetEntity(const char *eventType, const luabind::object &payload, int entityID)
//    {
//        // Do event more stuff
//    }
};

struct EventSchedulerFixture 
{
    EventSchedulerFixture() 
    {
        broadcaster = new EventBroadcasterMock();
        scheduler = new gg::event::EventScheduler(broadcaster);
    }
    
    ~EventSchedulerFixture()
    {
        delete scheduler;
        scheduler = NULL;
    }
    
    gg::event::EventScheduler *scheduler;
    gg::event::IEventBroadcaster *broadcaster;
};

TEST_FIXTURE (EventSchedulerFixture, ScheduleEventHandle)
{
    unsigned eventHandle = scheduler->scheduleEvent(gg::event::createScheduledEvent("E_TEST", 1.0));
    CHECK_EQUAL (1, eventHandle);
}

TEST_FIXTURE(EventSchedulerFixture, NumberOfScheduledEvents)
{
    gg::event::ScheduledEvent *e1 = new gg::event::ScheduledEvent();
    gg::event::ScheduledEvent *e2 = new gg::event::ScheduledEvent();
    gg::event::ScheduledEvent *e3 = new gg::event::ScheduledEvent();
    scheduler->scheduleEvent(e1);
    scheduler->scheduleEvent(e2);
    scheduler->scheduleEvent(e3);    
    CHECK_EQUAL (scheduler->scheduledEventsNumber(), 3);
}

TEST_FIXTURE(EventSchedulerFixture, ProperDeleteOfDeadEvents)
{
    gg::event::ScheduledEvent *e1 = new gg::event::ScheduledEvent();
    gg::event::ScheduledEvent *e2 = new gg::event::ScheduledEvent();
    gg::event::ScheduledEvent *e3 = new gg::event::ScheduledEvent();    
    scheduler->scheduleEvent(e1);
    scheduler->scheduleEvent(e2);
    scheduler->scheduleEvent(e3);
    scheduler->updateEvents(1.0);
    CHECK_EQUAL (scheduler->scheduledEventsNumber(), 0); //all event's should be freed
}

TEST_FIXTURE (EventSchedulerFixture, EventSchedulerUpdate)
{
    const double timeStep = 1.0/60.0;
    gg::event::ScheduledEvent *event = gg::event::createScheduledEvent("E_TEST", 1.0);
    scheduler->scheduleEvent(event);
    scheduler->updateEvents(timeStep);
    CHECK_EQUAL (timeStep, event->elapsedTime);
}

TEST_FIXTURE (EventSchedulerFixture, EventSchedulerEventRemoval)
{
    const double timeStep = 1.0/60.0;
    double accumulator = 0.0;
    gg::event::ScheduledEvent *event = gg::event::createScheduledEvent("E_TEST", 1.0); 
    scheduler->scheduleEvent(event);
    
    while (accumulator < 1.0) {
        scheduler->updateEvents(timeStep);
        accumulator += timeStep;
    }
    
    CHECK_EQUAL(0, scheduler->scheduledEventsNumber());
}

TEST_FIXTURE (EventSchedulerFixture, UnscheduleEventTest)
{
    unsigned handle = scheduler->scheduleEvent(gg::event::createScheduledEvent("E_TEST_0", 1.0));
    scheduler->scheduleEvent(gg::event::createScheduledEvent("E_TEST_1", 1.0));
    scheduler->scheduleEvent(gg::event::createScheduledEvent("E_TEST_1", 1.0));
    CHECK_EQUAL(3, scheduler->scheduledEventsNumber());
    scheduler->unscheduleEvent(handle);
    CHECK_EQUAL(2, scheduler->scheduledEventsNumber());
}

TEST_FIXTURE (EventSchedulerFixture, PauseScheduledEventTest)
{
    unsigned handle = scheduler->scheduleEvent(gg::event::createScheduledEvent("E_TEST_0", 1.0));
    scheduler->scheduleEvent(gg::event::createScheduledEvent("E_TEST_1", 1.0));
    scheduler->scheduleEvent(gg::event::createScheduledEvent("E_TEST_1", 1.0));
    scheduler->pauseScheduledEvent(handle);
    scheduler->updateEvents(1.0);
    CHECK_EQUAL(1, scheduler->scheduledEventsNumber()); //only paused event should remain.
}

TEST_FIXTURE(EventSchedulerFixture, ResetScheduledEvent)
{
    unsigned handle = scheduler->scheduleEvent(gg::event::createScheduledEvent("E_TEST_0", 1.0));
    scheduler->updateEvents(0.5);
    scheduler->resetScheduledEvent(handle);
    scheduler->updateEvents(0.5);
    CHECK_EQUAL(1, scheduler->scheduledEventsNumber());
    scheduler->updateEvents(0.5);
    CHECK_EQUAL(0, scheduler->scheduledEventsNumber());
}

#endif

