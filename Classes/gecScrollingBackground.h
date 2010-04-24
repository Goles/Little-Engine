/*
 *  gecScrollingBackground.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/19/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _GEC_SCROLLING_BACKGROUND_H_
#define _GEC_SCROLLING_BACKGROUND_H_

#include "gecVisual.h"
#include "gecImage.h"
#include "gecFSM.h"
#include "BehaviourStates.h"

class gecScrollingBackground : public gecVisual
{
	//gecScrollingBackground interface
public:
	gecScrollingBackground();
	gecScrollingBackground(const std::string &im1,const std::string &im2);
	void setSubscribedGE(GameEntity *e);
	GameEntity* getSubscribedGE(){ return subscribedGE; }
	
private:
	Image	*im1, *im2;
	static gec_id_type mGECTypeID;
	float dispWidth1;
	float dispWidth2;
	float dispOffset;
	float tolerance;
	float moveSpeed;
	GameEntity* subscribedGE;
	gecFSM* fsm;
	
	//gecVisual Interface
public:
	virtual void render() const;
	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	virtual void update(float delta);

};

#endif