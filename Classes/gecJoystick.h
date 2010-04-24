//
//  gecJoystick.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/5/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#ifndef _GECGUI_H_
#define _GECGUI_H_

#include "gecGUI.h"
#include "BehaviourActions.h"

class GameEntity;
class gecFSM;

class gecJoystick: public gecGUI
{	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mComponentID; }
	virtual void update(float delta);
	
	//gecGUI Interface
public:
	virtual Boolean regionHit(float x, float y);
	virtual Boolean immGUI(float x, float y, int touchIndex, void *touchID, int touchType);
	
	//gecJoystick Interface
public:
	gecJoystick();
	Boolean	outerRegionHit();
	void		updateVelocity(float x, float y);
	void		subscribeGameEntity(GameEntity *gE);
	
	//Getters & Setters
	void		setShape(CGRect aShape);
	CGRect	getShape() const { return shape; }
	void		setCenter (float a, float b){ center.x = a; center.y = b; }
	void		setInRadius (float r ) { inRadius = r; }
	void		setOutRadius (float r ) { outRadius = r; }	
	
protected:
	void		updateSubscriberState(kBehaviourAction s);
	
private:	
	static gec_id_type mComponentID;
	float			inRadius;
	float			outRadius;
	bool			active;
	CGRect		shape;
	CGPoint		center;
	CGPoint		latestVelocity;
	GameEntity*	subscribedGE;
	gecFSM*		fsm;
};

#endif