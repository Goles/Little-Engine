//
//  gecJoystick.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/5/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#ifndef __GEC_JOYSTICK_H__
#define __GEC_JOYSTICK_H__

#include "CompTouchable.h"

class gecJoystick: public CompTouchable
{	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mComponentID; }
	virtual void update(float delta);
	
	//CompTouchable Interface
public:
	virtual Boolean regionHit(float x, float y);
	virtual Boolean handle_touch(float x, float y, int touchIndex, int touchID, int touchType);
	
	//gecJoystick Interface
public:
	gecJoystick();
	Boolean		outerRegionHit();
	void		updateVelocity(float x, float y);
	
	//Getters & Setters
	void		setShape(CGRect aShape);
	CGRect		getShape() const { return shape; }
	void		setCenter (float a, float b){ center.x = a; center.y = b; }	
	void		setInRadius (float r ) { inRadius = r; }
	void		setOutRadius (float r ) { outRadius = r; }
		
private:	
	static gec_id_type	mComponentID;
	float				inRadius;
	float				outRadius;
	bool				active;
	bool				firstTouch;
	CGRect				shape;
	CGPoint				center;
	CGPoint				latestVelocity;
	bool				dx_negative;
	int					currentTouchID;
};

#endif