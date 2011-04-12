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

namespace unisonaction {

struct FiniteActionMock : public FiniteTimeAction
{
    FiniteActionMock() : counter_targetId(0), counter_afterUpdate(0), counter_init(0) {}
    
    virtual ~FiniteActionMock() { 
        counter_afterUpdate = 0; 
        counter_targetId = 0; 
        counter_init = 0; 
    }
    
    virtual unsigned targetId() {
        counter_targetId++;
        return 0;
    }
    
    virtual void afterUpdate(float dt) {
        counter_afterUpdate++;
    }
    
    virtual void init();
    
    int counter_afterUpdate;
    int counter_targetId;
    int counter_init;
};

void FiniteActionMock::init()
{
    FiniteActionMock::counter_init++;
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

    CHECK_EQUAL (3, a1->counter_afterUpdate + a2->counter_afterUpdate + a3->counter_afterUpdate);

    delete a;
}

TEST_FIXTURE (UnisonActionFixture, UnisonActionSetAllTargets)
{
    UnisonAction *a = new UnisonAction();
    GameEntity *e = new GameEntity();
    
    a->addAction(a1);
    a->addAction(a2);
    a->addAction(a3);
    
    a->setTarget(e);
    
    CHECK_EQUAL (3, a1->counter_init + a2->counter_init + a3->counter_init);
    
    delete a;
    delete e;
}

}