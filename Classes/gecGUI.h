//
//  gecGUI.h
//  Particles_2
//
//  Created by Nicolas Goles on 12/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GEComponent.h"

class gecGUI: public GEComponent
{
	//GEComponent interface
public:
	virtual const gec_id_type &familyID() const { return mFamilyID; }
	void setOwnerGE(GameEntity *gE);
	virtual void update(float delta) const {}
	
	//gecGUI interface
public:
	virtual Boolean regionHit(float x, float y) = 0;
	virtual Boolean immGUI(float x, float y, int guiID) = 0;
	int getGuiID() const { return guiID; }
	void setGuiID(int gid) { guiID = gid; } 
protected:
	int guiID;

private:
	static gec_id_type mFamilyID;
};
