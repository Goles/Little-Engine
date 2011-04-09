//
//  UnisonActionTest.c
//  GandoEngine
//
//  Created by Nicolas Goles on 4/8/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "unittestpp.h"
#include "ActionManager.h"
#include "FiniteTimeAction.h"
#include "UnisonAction.h"
#include "GameEntity.h"

using namespace gg::action;

struct FiniteActionMock : public FiniteTimeAction
{
    FiniteActionMock() : counter_getTargetId(0), counter_refresh(0) {}
    
    virtual unsigned getTargetId() {
        counter_getTargetId++;
        return 0;
    }
    
    virtual void refresh(float dt) {
        counter_refresh++;
    }
    
    int counter_refresh;
    int counter_getTargetId;
};

struct UnisonActionFixture {
    
    UnisonActionFixture() {
        a1 = new FiniteActionMock();
        a2 = new FiniteActionMock();
        a3 = new FiniteActionMock();
        e = new GameEntity();
        
        a1->setDuration(10.0f);
        a2->setDuration(10.1f);
        a3->setDuration(20.0f);
        a1->startWithTarget(e);
        a2->startWithTarget(e);
        a3->startWithTarget(e);        
    }
    
    ~UnisonActionFixture() {
        delete ACTION_MANAGER;
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
    
    a->addAction(a1);
    a->addAction(a2);
    a->addAction(a3);
    
    CHECK_EQUAL(20.0f, a->duration());
}

TEST_FIXTURE (UnisonActionFixture, UnisonActionUpdate)
{
    UnisonAction *a = new UnisonAction();

    a->addAction(a1);
    a->addAction(a2);
    a->addAction(a3);
    
    a->update(10.0f);

    CHECK_EQUAL (3, a1->counter_refresh + a2->counter_refresh + a3->counter_refresh);
}