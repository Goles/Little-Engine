//
//  UnisonActionTest.c
//  GandoEngine
//
//  Created by Nicolas Goles on 4/8/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#ifdef UNIT_TEST

#include "unittestpp.h"
#include "ActionManager.h"
#include "FiniteTimeAction.h"
#include "UnisonAction.h"
#include "GameEntity.h"

using namespace gg::action;

namespace unisonaction {

struct FiniteActionMock : public FiniteTimeAction
{
    FiniteActionMock() : counter_targetId(0), counter_afterUpdate(0), counter_afterSetTarget(0) {}
    
    virtual ~FiniteActionMock() { 
        counter_afterUpdate = 0; 
        counter_targetId = 0; 
        counter_afterSetTarget = 0;
        counter_done = 0;
    }
    
    virtual unsigned targetId() {
        counter_targetId++;
        return 0;
    }
    
    virtual void afterUpdate(float dt) {
        counter_afterUpdate++;
    }
    
    virtual void afterSetTarget();
    
    int counter_done;
    int counter_afterUpdate;
    int counter_targetId;
    int counter_afterSetTarget;
};

void FiniteActionMock::afterSetTarget()
{
    FiniteActionMock::counter_afterSetTarget++;
}

struct UnisonActionFixture {
    
    UnisonActionFixture() {
        a1 = new FiniteActionMock();
        a2 = new FiniteActionMock();
        a3 = new FiniteActionMock();
        e = new GameEntity();
        
        a1->setDuration(10.0f);
        a2->setDuration(10.1f);
        a3->setDuration(20.0f);      
    }
    
    ~UnisonActionFixture() {
        delete a1;
        delete a2;
        delete a3;
        delete e;
    }
    
    GameEntity *e;
    FiniteActionMock *a1;
    FiniteActionMock *a2;
    FiniteActionMock *a3;
};

TEST_FIXTURE (UnisonActionFixture, UnisonActionDuration)
{
    UnisonAction *a = new UnisonAction();
    a->addChildAction(a1);
    a->addChildAction(a2);
    a->addChildAction(a3);
    
    CHECK_EQUAL(20.0f, a->duration());
}

TEST_FIXTURE (UnisonActionFixture, UnisonActionUpdate)
{
    UnisonAction *a = new UnisonAction();
    a->addChildAction(a1);
    a->addChildAction(a2);
    a->addChildAction(a3);
    
    a->update(10.0f);

    CHECK_EQUAL (3, a1->counter_afterUpdate + a2->counter_afterUpdate + a3->counter_afterUpdate);

    delete a;
}

TEST_FIXTURE (UnisonActionFixture, UnisonActionSetAllTargets)
{
    UnisonAction *a = new UnisonAction();
    GameEntity *e = new GameEntity();
    a->addChildAction(a1);
    a->addChildAction(a2);
    a->addChildAction(a3);
    a->setTarget(e);
    
    CHECK_EQUAL (3, a1->counter_afterSetTarget + a2->counter_afterSetTarget + a3->counter_afterSetTarget);
    
    delete a;
    delete e;
}
    
TEST_FIXTURE (UnisonActionFixture, UnisonActionWithRepeat)
{
    const unsigned REPEAT_TIMES = 5;
    const float DURATION = 0.1;
    const float TIME_STEP = 1.0/60.0;

    UnisonAction *unisonAction = new UnisonAction();
    GameEntity *entity = new GameEntity();
    int counter = 0;
    int unisonDoneCounter = 0;
    float accumulator = 0.0;
    
    a1->setDuration(DURATION);
    a1->setRepeatTimes(REPEAT_TIMES);
    unisonAction->addChildAction(a1);
    unisonAction->setTarget(entity);
    
    //Repeat the action (REPEAT_TIMES)    
    while (accumulator < (DURATION * REPEAT_TIMES)) {
        accumulator += TIME_STEP;
        unisonAction->update(TIME_STEP);
        
        if(unisonAction->isDone())
            unisonDoneCounter++;
        counter++;        
    }
        
    CHECK_EQUAL (1, unisonDoneCounter);

    delete unisonAction;
    delete entity;
}

} // END namespace unisonaction

#endif
