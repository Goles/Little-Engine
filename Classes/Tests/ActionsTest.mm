
//
//  ActionsTest.mm
//  GandoEngine
//
//  Created by Nicolas Goles on 7/16/11.
//  Copyright 2011 GandoGames. All rights reserved.
//

#include "unittestpp.h"

#include "IAction.h"
#include "FiniteTimeAction.h"
#include "FadeInAction.h"
#include "FadeOutAction.h"
#include "MoveByAction.h"
#include "MoveToAction.h"
#include "ScaleToAction.h"

#include "GameEntity.h"
#include "gecVisual.h"
#include "gecImage.h"
#include "ConstantsAndMacros.h"

using namespace gg::action;

//Mock to have access to protected atribute m_color
struct gecImageMock : public gecImage {
public:
    inline float getAlpha() {
        return m_color[3];
    }
    
    inline const GGPoint &getScale() {
        return m_scale;
    }
};

//Test fixture in order to avoid creating Game Entity on each test.
struct ActionFixture {
  
    ActionFixture() {
        entity = new GameEntity();
        entity->setPosition(200, 200);
    }
    
    ~ActionFixture() {
        delete entity;
    }
    
    GameEntity *entity;    
};

TEST_FIXTURE(ActionFixture, FadeInAction)
{
    const float TIME_DELTA = 2.0;
    
    gecImageMock *visualComponent = new gecImageMock();
    visualComponent->setAlpha(0.0); //default alpha is 1.0
    entity->setGEC(visualComponent);
    FadeInAction *fadeInAction = new FadeInAction();
    fadeInAction->setDuration(TIME_DELTA);
    fadeInAction->setTarget(entity);
    fadeInAction->update(TIME_DELTA);
    
    CHECK_EQUAL (1.0, visualComponent->getAlpha());    
 
    delete visualComponent;
    delete fadeInAction;
}

TEST_FIXTURE(ActionFixture, FadeInActionRepeat)
{
    const float TIME_DELTA = 2.0;
    const unsigned REPEAT_TIMES = 20;
    
    gecImageMock *visualComponent = new gecImageMock();
    visualComponent->setAlpha(0.0); //default alpha is 1.0
    entity->setGEC(visualComponent);
    FadeInAction *fadeInAction = new FadeInAction();
    fadeInAction->setDuration(TIME_DELTA);
    fadeInAction->setRepeatTimes(REPEAT_TIMES);
    fadeInAction->setTarget(entity);
    fadeInAction->update(TIME_DELTA * REPEAT_TIMES);
    
    CHECK_EQUAL (1.0, visualComponent->getAlpha());    
    
    delete visualComponent;
    delete fadeInAction; 
}

TEST_FIXTURE(ActionFixture, FadeOutAction)
{
    const float TIME_DELTA = 2.0;
    
    gecImageMock *visualComponent = new gecImageMock(); //default alpha is 1.0
    entity->setGEC(visualComponent);
    FadeOutAction *fadeOutAction = new FadeOutAction();
    fadeOutAction->setDuration(TIME_DELTA);
    fadeOutAction->setTarget(entity);
    fadeOutAction->update(TIME_DELTA);
   
    CHECK_EQUAL (0.0, visualComponent->getAlpha());
 
    delete visualComponent;
    delete fadeOutAction;
}

TEST_FIXTURE(ActionFixture, FadeOutActionRepeat)
{
    const float TIME_DELTA = 2.0;
    const unsigned REPEAT_TIMES = 20;
    
    gecImageMock *visualComponent = new gecImageMock(); //default alpha is 1.0
    entity->setGEC(visualComponent);
    FadeOutAction *fadeOutAction = new FadeOutAction();
    fadeOutAction->setDuration(TIME_DELTA);
    fadeOutAction->setTarget(entity);
    fadeOutAction->setRepeatTimes(REPEAT_TIMES);
    
    fadeOutAction->update(TIME_DELTA);
    CHECK_EQUAL (0.0, visualComponent->getAlpha());
    fadeOutAction->update(TIME_DELTA * (REPEAT_TIMES -1)); //already updated once
    CHECK_EQUAL (0.0, visualComponent->getAlpha());
    
    delete visualComponent;
    delete fadeOutAction;
}

TEST_FIXTURE(ActionFixture, MoveByAction)
{
    const float TIME_DELTA = 2.0;
    
    MoveByAction *moveByAction = new MoveByAction();
    moveByAction->setDuration(TIME_DELTA);
    moveByAction->setMovementOffset(ggp(100, 100));
    moveByAction->setTarget(entity);
    moveByAction->update(TIME_DELTA/2);

     //Since it's linear it should update half of the movement offset in TIME_DELTA/2
    GGPoint aPoint = ggp(250, 250);
    CHECK_EQUAL (aPoint.x, entity->getPositionX());
    CHECK_EQUAL (aPoint.y, entity->getPositionY());

    moveByAction->update(TIME_DELTA/2);
    
    //Should move the entity +100, +100. The new position should be 300,300 (full TIME_DELTA)
    aPoint = ggp(300, 300);
    CHECK_EQUAL (aPoint.x, entity->getPositionX());
    CHECK_EQUAL (aPoint.y, entity->getPositionY());
    
    delete moveByAction;
}

TEST_FIXTURE(ActionFixture, MoveByActionRepeat)
{
    const float TIME_DELTA = 0.5;
    const float REPEAT_TIMES = 5;
    const float TIME_STEP = 1.0/60.0;
    const float MOVEMENT_OFFSET = 10.0;
    float accumulator = 0.0;
    
    MoveByAction *moveByAction = new MoveByAction();
    moveByAction->setDuration(TIME_DELTA);
    moveByAction->setMovementOffset(ggp(MOVEMENT_OFFSET, MOVEMENT_OFFSET));
    moveByAction->setTarget(entity);
    moveByAction->setRepeatTimes(REPEAT_TIMES);
    moveByAction->update(TIME_DELTA);
    
    //Update 1 repetition, the action shouldn't finish yet (4 more repetitions to go)
    CHECK_EQUAL (moveByAction->isDone(), false);
    
    //Only one repetition (1*TIME_DELTA), means an increase of 1 movementOffset
    GGPoint aPoint = ggp(200 + MOVEMENT_OFFSET , 200 + MOVEMENT_OFFSET);
    CHECK_EQUAL (aPoint.x, entity->getPositionX());
    CHECK_EQUAL (aPoint.y, entity->getPositionY());
    
    //Repeat the action (REPEAT TIMES - 1)
    while (accumulator < (TIME_DELTA *(REPEAT_TIMES - 1)) 
           && !moveByAction->isDone()) {
        accumulator += TIME_STEP;
        moveByAction->update(TIME_STEP);
    }
    
    //Should move the entity +40, +40. The new position should be 250,250
    aPoint = ggp(200 + (MOVEMENT_OFFSET * REPEAT_TIMES), 200 + (MOVEMENT_OFFSET * REPEAT_TIMES));
    CHECK_EQUAL(aPoint.x, entity->getPositionX());
    CHECK_EQUAL(aPoint.y, entity->getPositionY());
    
    delete moveByAction;
}

TEST_FIXTURE(ActionFixture, MoveToAction)
{
    const GGPoint targetPoint = ggp(250, 250);
    const float TIME_DELTA = 2.0;
    
    MoveToAction *moveToAction = new MoveToAction();
    moveToAction->setDuration(TIME_DELTA);
    moveToAction->setEndPoint(targetPoint);
    moveToAction->setTarget(entity);
    moveToAction->update(TIME_DELTA);
    
    CHECK_EQUAL(targetPoint.x, entity->getPositionX());
    CHECK_EQUAL(targetPoint.y, entity->getPositionY());
    
    delete moveToAction;
}

TEST_FIXTURE(ActionFixture, MoveToActionRepeat)
{
    const GGPoint targetPoint = ggp(250, 250);
    const float TIME_DELTA = 2.0;
    const float REPEAT_TIMES = 5;
    const float TIME_STEP = 1.0/60.0;
    float accumulator = 0.0;
    
    MoveToAction *moveToAction = new MoveToAction();
    moveToAction->setDuration(TIME_DELTA);
    moveToAction->setEndPoint(targetPoint);
    moveToAction->setTarget(entity);
    moveToAction->setRepeatTimes(REPEAT_TIMES);
    moveToAction->update(TIME_DELTA);
    
    //One Repetition should already take it to the target.
    CHECK_EQUAL(targetPoint.x, entity->getPositionX());
    CHECK_EQUAL(targetPoint.y, entity->getPositionY());
        
    //Repeat the action (REPEAT TIMES - 1)
    while (accumulator < (TIME_DELTA *(REPEAT_TIMES - 1)) 
           && !moveToAction->isDone()) {
        accumulator += TIME_STEP;
        moveToAction->update(TIME_STEP);
    }
    
    //N more repetitions of MoveToAction shouldn't change the entity position anymore.
    CHECK_EQUAL(targetPoint.x, entity->getPositionX());
    CHECK_EQUAL(targetPoint.y, entity->getPositionY());
    
    delete moveToAction;
}

TEST_FIXTURE(ActionFixture, ScaleToAction)
{
    const GGPoint endScale = ggp(2.0, 2.0);
    const float TIME_DELTA = 2.0;
    
    gecImageMock *visualComponent = new gecImageMock();
    entity->setGEC(visualComponent);
    ScaleToAction *scaleToAction = new ScaleToAction();
    scaleToAction->setDuration(TIME_DELTA);
    scaleToAction->setEndScale(endScale);
    scaleToAction->setTarget(entity);
    scaleToAction->update(TIME_DELTA);
    
    CHECK_EQUAL (endScale.x, visualComponent->getScale().x);
    CHECK_EQUAL (endScale.y, visualComponent->getScale().y);
    
    delete visualComponent;
    delete scaleToAction;
}

TEST_FIXTURE(ActionFixture, ScaleToActionRepeat)
{
    const GGPoint endScale = ggp(2.0, 2.0);    
    const float TIME_DELTA = 2.0;
    const float REPEAT_TIMES = 5;
    const float TIME_STEP = 1.0/60.0;    
    float accumulator = 0.0;
    
    gecImageMock *visualComponent = new gecImageMock();
    entity->setGEC(visualComponent);
    ScaleToAction *scaleToAction = new ScaleToAction();
    scaleToAction->setDuration(TIME_DELTA);
    scaleToAction->setEndScale(endScale);
    scaleToAction->setTarget(entity);
    scaleToAction->update(TIME_DELTA);
    
    //One repetition should set the Scale to the final value
    CHECK_EQUAL (endScale.x, visualComponent->getScale().x);
    CHECK_EQUAL (endScale.y, visualComponent->getScale().y);
    
    //Repeat the action (REPEAT TIMES - 1)    
    while (accumulator < (TIME_DELTA *(REPEAT_TIMES - 1)) 
           && !scaleToAction->isDone()) {
        accumulator += TIME_STEP;
        scaleToAction->update(TIME_STEP);
    }
    
    //N more repetitions of ScaleToAction shouldn't affect the scale anymore.
    CHECK_EQUAL (endScale.x, visualComponent->getScale().x);
    CHECK_EQUAL (endScale.y, visualComponent->getScale().y);
    
    delete visualComponent;
    delete scaleToAction;
}