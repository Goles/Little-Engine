/*
 *  gecScrollingBackground.cpp
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/19/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#include "gecScrollingBackground.h"

std::string gecScrollingBackground::mGECTypeID = "gecScrollingBackground";

#pragma mark -
#pragma mark update
void gecScrollingBackground::update(float delta)
{
	dispOffset+=1;
	if(dispOffset >= dispWidth1) //This should be better if we have different size tiles.
		dispOffset = 0;
}

#pragma mark -
#pragma mark Constructor
gecScrollingBackground::gecScrollingBackground()
{
	im1 = NULL;
	im2 = NULL;
	dispWidth1 = 0.0f;
	dispWidth2 = 0.0f;
	dispOffset = 0.0f;
}

gecScrollingBackground::gecScrollingBackground(const std::string &im1, const std::string &im2)
{
	this->im1 = new Image();
	this->im2 = new Image();
	this->im1->initWithTextureFile(im1);
	this->im2->initWithTextureFile(im2);
	dispWidth1 = this->im1->getImageWidth();
	dispWidth2 = this->im2->getImageWidth();
	dispOffset = 0.0f;
}

#pragma mark -
#pragma mark rendering
void gecScrollingBackground::render() const
{	
	float offsetCalc = dispWidth1 - dispOffset;
	im1->renderSubImageAtPoint(CGPointZero, CGPointMake(dispOffset, 0), offsetCalc, 320, false);
	im2->renderSubImageAtPoint(CGPointMake(offsetCalc, 0), CGPointZero, dispOffset, 320, false);
}



