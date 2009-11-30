//
//  gecVisualContainer.mm
//  Particles_2
//
//  Created by Nicolas Goles on 11/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "gecVisualContainer.h"

std::string gecVisualContainer::mGECTypeID = "gecVisualContainer";

void gecVisualContainer::render() const
{
	for(int i = 0; i < visualComponents.size(); i++)
		visualComponents[i]->render();
}

void gecVisualContainer::addGecVisual(gecVisual *inGecVisual)
{
	//TODO: do the checks to remove an inGecVisual->componentID() that we already have.
	visualComponents.push_back(inGecVisual);
}

gecVisual* gecVisualContainer::getComponent(const gec_id_type &componentName)
{
	for(int i = 0; i < visualComponents.size(); i++)
	{
		if(componentName == visualComponents[i]->componentID())
		{
			return (visualComponents[i]);
		}
	}	
	return NULL;
}

void gecVisualContainer::update(float delta) const
{
	for(int i = 0; i < visualComponents.size(); i++)
	{
		visualComponents[i]->update(delta);
	}	
}
