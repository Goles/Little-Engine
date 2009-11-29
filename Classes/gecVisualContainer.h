//
//  gecVisualContainer.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "gecVisual.h"
#include <vector>

class gecVisualContainer : public gecVisual
{
public:
	gecVisualContainer(){}
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	
	//gecVisual interface
public:
	virtual void render() const;
	
	//gecVisualContainer interface
public:
	void addGecVisual(gecVisual *inGecVisual);
	gecVisual* getComponent(const gec_id_type &componentName);
	virtual void update(float delta) const;
	
private:
	typedef std::vector<gecVisual *> GecVisualVector;

	GecVisualVector visualComponents;
	
	static gec_id_type mGECTypeID;
};