//
//  gecGUI.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#ifndef GECGUI_H
#define GECGUI_H

#include "GEComponent.h"
#include <boost/signal.hpp>

class gecGUI: public GEComponent
{
	//GEComponent interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	void setOwnerGE(GameEntity *gE);
	virtual void update(float delta) {}
	
	//gecGUI interface
public:
	typedef boost::signal<void ()> ContactSignal; //typedef for our basic signal type.	
	virtual Boolean regionHit(float x, float y) = 0;
	virtual Boolean immGUI(float x, float y, int touchIndex, void *guiID, int touchType) = 0;
	int getGuiID() const { return guiID; }
	void setGuiID(int gid) { guiID = gid; } 

protected:
	int guiID;

private:
	static gec_id_type mFamilyID;
};

#endif