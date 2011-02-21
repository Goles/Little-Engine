/*
 *  gecScrollingBackground.cpp
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/19/10.
 *  Copyright 2010 Nicolas Goles. All rights reserved.
 *
 */

#include "gecScrollingBackground.h"
#include "GameEntity.h"

std::string gecScrollingBackground::mGECTypeID = "gecScrollingBackground";

#pragma mark -
#pragma mark update
void gecScrollingBackground::update(float delta)
{
	if(subscribedGE != NULL)
	{
		if(subscribedGE->x >= tolerance && (fsm->getState().compare("S_WALK")))
			dispOffset+=1;
	}else{
		//Assert out if our subscribedGE is null.
		assert(subscribedGE != NULL);
	}
	
	if(dispOffset >= dispWidth1) //This should be better if we have different size tiles.
		dispOffset = 0;
}

void gecScrollingBackground::setSubscribedGE(GameEntity *e)
{
	GEComponent *f = e->getGEC("CompBehaviour");
	if( f != NULL )
	{
		fsm = (gecFSM *)f;	
		subscribedGE = e;
	}else {
		std::cout << "Entity doesn't contain an FSM" << std::endl;
		assert(f != NULL);
	}
}

#pragma mark -
#pragma mark Constructor
gecScrollingBackground::gecScrollingBackground()
{
	im1 = NULL;
	im2 = NULL;
	subscribedGE = NULL;	
	dispWidth1	= 0.0f;
	dispWidth2	= 0.0f;
	dispOffset	= 0.0f;
	tolerance	= 0.0f;
	moveSpeed	= 0.0f;
}

gecScrollingBackground::gecScrollingBackground(const std::string &im1, const std::string &im2)
{
	this->im1 = new Image();
	this->im2 = new Image();
	this->im1->initWithTextureFile(im1);
	this->im2->initWithTextureFile(im2);
	dispWidth1	= this->im1->getImageWidth();
	dispWidth2	= this->im2->getImageWidth();
	dispOffset	= 0.0f;
	moveSpeed	= 0.0f;	
	tolerance	= 320.0f;
	subscribedGE = NULL;
}

#pragma mark -
#pragma mark rendering
void gecScrollingBackground::render() const
{	
	float offsetCalc = dispWidth1 - dispOffset;
	im1->renderSubImageAtPoint(CGPointZero, CGPointMake(dispOffset, 0), offsetCalc, 320, false);
	im2->renderSubImageAtPoint(CGPointMake(offsetCalc, 0), CGPointZero, dispOffset, 320, false);		
}



