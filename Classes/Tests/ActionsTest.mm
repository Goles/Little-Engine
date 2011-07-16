
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
    CHECK_EQUAL(aPoint.x, entity->getPositionX());
    CHECK_EQUAL(aPoint.y, entity->getPositionY());

    moveByAction->update(TIME_DELTA/2);
    
    //Should move the entity +100, +100. The new position should be 300,300 (full TIME_DELTA)
    aPoint = ggp(300, 300);
    CHECK_EQUAL(aPoint.x, entity->getPositionX());
    CHECK_EQUAL(aPoint.y, entity->getPositionY());
    
    delete moveByAction;
}

TEST_FIXTURE(ActionFixture, MoveToAction)
{
    const float TIME_DELTA = 2.0;
    const GGPoint targetPoint = ggp(250, 250);
    
    MoveToAction *moveToAction = new MoveToAction();
    moveToAction->setDuration(TIME_DELTA);
    moveToAction->setEndPoint(targetPoint);
    moveToAction->setTarget(entity);
    moveToAction->update(TIME_DELTA);
    
    CHECK_EQUAL(targetPoint.x, entity->getPositionX());
    CHECK_EQUAL(targetPoint.y, entity->getPositionY());
    
    delete moveToAction;
}

TEST_FIXTURE(ActionFixture, ScaleToAction)
{
    const float TIME_DELTA = 2.0;
    const GGPoint endScale = ggp(2.0, 2.0);
    
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