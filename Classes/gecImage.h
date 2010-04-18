/*
 *  gecImage.h
 *  Particles_2
 *
 *  Created by Nicolas Goles on 4/17/10.
 *  Copyright 2010 GandoGames. All rights reserved.
 *
 */

#ifndef _GEC_IMAGE_H_
#define _GEC_IMAGE_H_

#include "gecVisual.h"
#include "Image.h"

class gecImage: public gecVisual
{
	//gecImage Interface
public:
	gecImage(Image *i) { this->image = i; }
	
private:
	Image *image;
	static gec_id_type mGECTypeID;

	//gecVisual Interface
public:
	virtual void render() const;
	
	//GEComponent Interface
public:
	virtual const gec_id_type &componentID() const { return mGECTypeID; }
	virtual void update(float delta) const {}
};

#endif