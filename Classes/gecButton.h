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

class gecButton : public gecGUI
{
	//GEComponent interface
public:
	virtual const gec_id_type &componentID() const { return mComponentID; }
	virtual void update(float delta) const {}
	
	//gecGUI Interface
public:
	virtual Boolean regionHit(float x, float y);
	virtual Boolean immGUI(float x, float y, int touchIndex, void *touchID, int touchType);
	
	//gecButton Interface
public:
	gecButton();
	~gecButton();
	void setShape(CGRect aShape);
	CGRect getShape() const { return shape; }
	void addSignal(const ContactSignal::slot_type& slot);
	void call();
	
private:	
	ContactSignal triggerSignal;	
	static gec_id_type mComponentID;
	CGRect shape;
};

#endif