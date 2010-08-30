//
//  gecButton.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#ifndef _GECBUTTON_H_
#define _GECBUTTON_H_

#include <boost/signal.hpp>
#include <boost/bind.hpp>
#include <iostream>
#include "gecGUI.h"
#include "BehaviourActions.h"

//To pass signals to FSM for example. 
//(signature: void Function(kBehaviourAction))
typedef boost::signal<void (kBehaviourAction)> TriggerSignal;

class gecButton : public gecGUI
{
	//GEComponent interface
public:
	virtual const gec_id_type &componentID() const { return mComponentID; }
	virtual void update(float delta) {}
	
	//gecGUI Interface
public:
	virtual Boolean regionHit(float x, float y);
	virtual Boolean immGUI(float x, float y, int touchIndex, void *touchID, int touchType);
	
	//gecButton Interface
public:
	gecButton();
	~gecButton();
	void				setShape(CGRect aShape);
	void				setParentSharedShape(CGRect aRect);
	void				setActionPressed(kBehaviourAction a) { buttonActions[0] = a; }
	void				setActionReleased(kBehaviourAction a) { buttonActions[1] = a; }
	CGRect				getShape() const { return shape; }
	kBehaviourAction	getActionPressed(){ return buttonActions[0]; }
	kBehaviourAction	getActionReleased(){ return buttonActions[1]; }
	void				addSignal(const TriggerSignal::slot_type& slot);
	void				call(kBehaviourAction action);
	
private:	
	TriggerSignal triggerSignal;	
	static gec_id_type mComponentID;
	CGRect shape;	
	kBehaviourAction buttonActions[2];
};

#endif