//
//  gecVisualContainer.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/28/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#ifndef _GECVISUALCONTAINER_H_
#define _GECVISUALCONTAINER_H_

#include "gecVisual.h"
#include <vector>

class gecVisualContainer : public gecVisual
{
	//GEComponent Interface
public:
	gecVisualContainer(){}
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	virtual void update(float delta);
	
	//gecVisual interface
public:
	virtual void render() const;
	
	//gecVisualContainer interface
public:
	void addGecVisual(gecVisual *inGecVisual);
	gecVisual* getComponent(const gec_id_type &componentName);
	
private:
	typedef std::vector<gecVisual *> GecVisualVector;
	GecVisualVector visualComponents;
	static gec_id_type mGECTypeID;
};

#endif