//
//  gecButton.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#ifndef __GECBUTTON_H__
#define __GECBUTTON_H__

#include "CompTouchable.h"
#include "BehaviourActions.h"

class gecButton : public CompTouchable
{
	//GEComponent interface
public:
	virtual const gec_id_type &componentID() const { return mComponentID; }
	virtual void update(float delta) {}
	
	//CompTouchable Interface
public:
	virtual Boolean regionHit(float x, float y);
	virtual Boolean handle_touch(float x, float y, int touchIndex, int touchID, int touchType);
	
	//gecButton Interface
public:
	gecButton();
	void setShape(CGRect aShape);
	void setParentSharedShape(CGRect aRect);
	CGRect getShape() const { return shape; }
	
protected:
	void broadcastButtonPress();
	void broadcastButtonRelease();
	
private:
	static gec_id_type mComponentID;
	CGRect shape;
};

#endif