//
//  GEComponent.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/25/09.
//  Copyright 2009 GandoGames. All rights reserved.
//

#ifndef _GECOMPONENT_H_
#define _GECOMPONENT_H_

#include "GameEntity.h"
#include <string>

class GEComponent
{
	//GEComponent Interface
public:
	typedef std::string gec_id_type;
	
	//Constructor & Destructor
	GEComponent():ownerGE(0){}
	virtual ~GEComponent(){}
	
	//Action Methods
	virtual const gec_id_type&	familyID() const = 0;
	virtual const gec_id_type&	componentID() const = 0;	
	virtual void				update(float delta) = 0;
	
	//Getters and setters.
	void		setOwnerGE(GameEntity *gE){ ownerGE = gE; }
	GameEntity*	getOwnerGE() const;
	
protected:
	GameEntity *ownerGE;
};

#endif