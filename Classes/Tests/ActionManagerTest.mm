//
//  ActionManagerTest.cpp
//  GandoEngine
//
//  Created by Nicolas Goles on 4/7/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "unittestpp.h"

#include "FiniteTimeAction.h"
#include "ActionManager.h"
#include "GameEntity.h"
#include "UnisonAction.h"

using namespace gg::action;

struct FiniteActionMock : public FiniteTimeAction
{
    FiniteActionMock() : counter_targetId(0), counter_afterUpdate(0) {}
    
    virtual unsigned targetId() {
        counter_targetId++;
        return 0;
    }
    
    virtual void afterUpdate(float dt) {
        counter_afterUpdate++;
    }
    
    int counter_afterUpdate;
    int counter_targetId;
};

struct ActionManagerFixture {

    ActionManagerFixture() {
        a1 = new FiniteActionMock();
        a2 = new FiniteActionMock();        
        e = new GameEntity();
    }
    
    ~ActionManagerFixture() {
        delete ACTION_MANAGER;
        delete e;
    }
    
    FiniteActionMock *a1;
    FiniteActionMock *a2;    
    GameEntity *e;
};

TEST_FIXTURE (ActionManagerFixture, AddActionTest)
{    
    a1->setTarget(e);
    a2->setTarget(e);
    ACTION_MANAGER->addAction(a1);
    ACTION_MANAGER->addAction(a2);
    
    CHECK_EQUAL(2, a1->counter_targetId + a2->counter_targetId);
}

TEST_FIXTURE (ActionManagerFixture, UpdateActionsTest)
{
    a1->setTarget(e);
    a1->setDuration(10.0f);
    a2->setDuration(10.1f);
    a2->setTarget(e);
    
    ACTION_MANAGER->addAction(a1);
    ACTION_MANAGER->addAction(a2);
    
    ACTION_MANAGER->update(10.0f);
    
    CHECK (a1->isDone());
    CHECK (!a2->isDone());
}

TEST_FIXTURE (ActionManagerFixture, TotalActionsNumTest)
{
    ACTION_MANAGER->addAction(a1);
    ACTION_MANAGER->addAction(a2);
    
    CHECK_EQUAL(2, ACTION_MANAGER->totalActionsNum());
}

TEST_FIXTURE (ActionManagerFixture, ParallelActionsAdd)
{    
    a1->setDuration(10.0f);
    a2->setDuration(10.0f);
    a1->setTarget(e);
    a2->setTarget(e);
    
    ACTION_MANAGER->addParallelActions(a1, a2, NULL);
    
    ACTION_MANAGER->update(10.0f);
    
    CHECK_EQUAL (2, (a1->counter_afterUpdate + a2->counter_afterUpdate));
}

//
// Acceptance Tests
//
TEST_FIXTURE (ActionManagerFixture, UpdateFullActionSequence)
{
    UnisonAction *uap = new UnisonAction();
    FiniteActionMock *a3 = new FiniteActionMock();
    FiniteActionMock *a4 = new FiniteActionMock();
    
    a1->setDuration(10.0f);
    a2->setDuration(20.0f);
    a3->setDuration(6.0);
    a4->setDuration(7.0);
    
    a1->setTarget(e);
    a2->setTarget(e);
    a3->setTarget(e);
    a4->setTarget(e);
    
    uap->addAction(a1);
    uap->addAction(a2);
    
    ACTION_MANAGER->addAction(uap);
    ACTION_MANAGER->addAction(a1);
    ACTION_MANAGER->addAction(a2);
    ACTION_MANAGER->addAction(a3);
    ACTION_MANAGER->addAction(a4);
    
    //First update time check
    ACTION_MANAGER->update(5.0f);
    CHECK_EQUAL (5.0f, a1->duration());
    CHECK_EQUAL (15.0f, a2->duration());
    CHECK_EQUAL (15.0f, uap->duration());
    CHECK_EQUAL (6.0f, a3->duration());
    CHECK_EQUAL (7.0f, a4->duration());
    
    //Second update time check
    ACTION_MANAGER->update(5.0f);
    CHECK_EQUAL (true, a1->isDone());
    CHECK_EQUAL (10.0f, a2->duration());
    CHECK_EQUAL (10.0f, uap->duration());    
    CHECK_EQUAL (6.0f, a3->duration());
    CHECK_EQUAL (7.0f, a4->duration());
    
    //Third update time check
    ACTION_MANAGER->update(10.0f);
    CHECK_EQUAL (true, a2->isDone());
    CHECK_EQUAL (true, uap->isDone());    
    CHECK_EQUAL (6.0f, a3->duration());
    CHECK_EQUAL (7.0f, a4->duration());
    
    //Fourth update time check
    ACTION_MANAGER->update(6.0f);   
    CHECK_EQUAL (true, a3->isDone());
    CHECK_EQUAL (7.0f, a4->duration());
    
    //Fifth & final update time check
    ACTION_MANAGER->update(7.0f);   
    CHECK_EQUAL (true, a4->isDone());  
    
    delete uap; 
    delete a3;
    delete a4;
}