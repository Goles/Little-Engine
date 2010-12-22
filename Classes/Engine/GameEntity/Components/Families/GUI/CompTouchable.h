//
//  CompTouchable.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#ifndef __COMP_TOUCHABLE_H__
#define __COMP_TOUCHABLE_H__

#include "GEComponent.h"
#include <boost/signal.hpp>

class CompTouchable: public GEComponent
{
	//GEComponent interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	virtual void update(float delta) {}
	
	//CompTouchable interface
public:
	typedef boost::signal<void ()> ContactSignal; //typedef for our basic signal type.	
	virtual Boolean regionHit(float x, float y) = 0;
	virtual Boolean handle_touch(float x, float y, int touchIndex, int guiID, int touchType) = 0;
	int getId() const { return m_Id; }
	void setId(int inId) { m_Id = inId	; }

protected:
	void unregisterTouchable();
	void registerTouchable();
	int m_Id;

private:
	static gec_id_type mFamilyID;
};

#endif