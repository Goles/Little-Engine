//
//  gecVisual.h
//  Particles_2
//
//  Created by Nicolas Goles on 11/25/09.
//  Copyright 2009 Nicolas Goles. All rights reserved.
//

#ifndef _GECVISUAL_H_
#define _GECVISUAL_H_

#include "GEComponent.h"
#include "ConstantsAndMacros.h"

class gecVisual: public GEComponent
{
	//GEComponent Interface
public:
	virtual const gec_id_type& familyID() const { return m_id; }

	//gecVisual Interface
public:
    gecVisual();
    virtual ~gecVisual() {}
	virtual void render() const = 0;
    void setTransform(const mat4f_t &transform);
    void setColor(float R, float G, float B, float A = 255.0f);
    void setAlpha(float alpha);    
	
protected:
    mat4f_t m_transform;
    float m_color[4];    
    bool m_dirtyTransform;
    bool m_dirtyColor;

private:
	static gec_id_type m_id;
};

#endif