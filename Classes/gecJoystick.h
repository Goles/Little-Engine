//
//  gecJoystick.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "gecGUI.h"

class gecJoystick: public gecGUI
{	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mComponentID; }
	virtual void update(float delta) const{}
	
	//gecJoystick Interface
public:
	virtual Boolean regionHit(float x, float y);
	virtual Boolean immGUI(float x, float y, int guiID);
	Boolean	outerRegionHit();
	void	updateVelocity(float x, float y);
	
	void setShape(CGRect aShape);
	CGRect getShape() const { return shape; }
	void setCenter (float a, float b){ center.x = a; center.y = b; }
	void setInRadius (float r ) { inRadius = r; }
	void setOutRadius (float r ) { outRadius = r; }	
	
	
private:	
	static gec_id_type mComponentID;
	float	inRadius;
	float	outRadius;
	CGRect	shape;
	CGPoint	center;
};