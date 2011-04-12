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