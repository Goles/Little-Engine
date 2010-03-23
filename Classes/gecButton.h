//
//  gecButton.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#include <boost/signal.hpp>
#include <iostream>
#include "gecGUI.h"

class gecButton : public gecGUI
{
	//GEComponent interface
public:
	virtual const gec_id_type &componentID() const { return mComponentID; }
	virtual void update(float delta) const {}
	
	//gecButton Interface
public:
	virtual Boolean regionHit(float x, float y);
	virtual Boolean immGUI(float x, float y, int guiID, void *touchID);
	gecButton();
	~gecButton();
	void setShape(CGRect aShape);
	CGRect getShape() const { return shape; }
	boost::signal<void ()> sig;

private:	
	static gec_id_type mComponentID;
	CGRect shape;
	
};
