//
//  test.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#include "gecInput.h"

class gecInputButton : public gecInput
{
	//GEComponent Interface
public:
	virtual const std::string & componentID() const { return mComponentID;}
	
	//gecInputButton Interface
public:
	virtual void touchesBegan(float x, float y);
	virtual void touchesMoved(float x, float y);	
	virtual void touchesEnded(float x, float y);
	gecInputButton();
	~gecInputButton();
	
private:
	
	static std::string mComponentID;
};